2021년 1월 현재 직장에서 내부 개발로 맡아 진행했던 경험입니다.

# 요구사항:

1. 당사에서 진행하는 프로젝트 계약건들에 대한 내용들을 정리하여 보관할 수 있는 '계약문서함'을 만들어야 한다.
2. 아래 사항들을 모두 저장할 수 있어야 한다.
    1. 프로젝트명
    2. 계약기간
    3. 검수 형태
    4. 검수 차수
    5. 공급자
    6. 공급받는 자
    7. 첨부파일
    8. 등록일
3. 받아온 정보 SQL으로 DB에 넣어주기
4. 문서 선택 시, DB에서 해당 문서에 대한 자세한 내용을 보여주어야 한다.

1. 우선 '계약문서함'의 표지 페이지입니다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6895141f-8462-4b60-b35b-ff8e38880f1d/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6895141f-8462-4b60-b35b-ff8e38880f1d/Untitled.png)

위 좌측 네비게이션 탭에서 '계약문서함'을 추가하여 클릭 시, 이동하도록 하였습니다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0d8b6125-d865-49ef-a2c8-cef5b8bf3c47/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0d8b6125-d865-49ef-a2c8-cef5b8bf3c47/Untitled.png)

*'계약문서함'에 마우스를 올렸을 때, 하단에 나타나는 표시를 통해 그룹웨어 FTP에서 어떤 디렉토리에서 처리가 이루어지는지 알 수 있습니다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/82524f19-d5af-4c71-a616-379ad0359c1d/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/82524f19-d5af-4c71-a616-379ad0359c1d/Untitled.png)

'계약문서함'의 표지 페이지입니다.

*다른 여러가지 정보들은 우선 나타나지 않게 하였습니다.

```bash
먼저, configx.asp 파일에서 ftp와 db 연결정보를 찾아서 접근을 하는 것으로 시작하였습니다.

*이미 만들어져 있는 다른 게시판의 소스를 활용하여 '계약문서함'에 필요한 사항들을 위해 
튜닝하였습니다.
```

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1d0e1bf1-a0d3-4eff-9c41-acb3441e5d2c/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1d0e1bf1-a0d3-4eff-9c41-acb3441e5d2c/Untitled.png)

위 사진처럼 '계약문서함'에 요구되는 사항들에 맞추어 테이블의 이름과 SQL문에 주어지는 값들(DB에 맞게)을 수정하였습니다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/94be721b-ff07-4d12-8bae-eb6ffc34184c/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/94be721b-ff07-4d12-8bae-eb6ffc34184c/Untitled.png)

하나의 문서를 클릭하였을 때 그 문서의 상세 내용들을 보여주는 기능, 문서 수정 기능, 문서 삭제 기능 들 모두에 '계약문서함'에 맞도록 변수들과 SQL문을 수정해주었습니다.

## Database

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3de3e56e-514d-4f41-a242-5c85df721258/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3de3e56e-514d-4f41-a242-5c85df721258/Untitled.png)

database management 툴으로는 **Microsoft SQL Server Management Studio 18**을 사용하였습니다. DB를 만들고 요구 데이터테이블을 추가해주었습니다.

*w_date에는 datatime형식으로 해주었으며, "작성날짜"를 넣어주기 위해 **'(getdate())'**를 사용해주었습니다.

### 테스트

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9f871c5d-b8ec-4b68-b734-720bc93f3e39/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9f871c5d-b8ec-4b68-b734-720bc93f3e39/Untitled.png)

**그룹웨어 '자료관리/계약문서함'에서 '등록하기"를 통해 문서를 작성해보았습니다!**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/441190a6-434d-4c7b-b4ed-8c55a207d24a/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/441190a6-434d-4c7b-b4ed-8c55a207d24a/Untitled.png)

**그룹웨어 '자료관리/계약문서함'에 성공적으로 문서가 등록되었습니다!**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f6d27640-020e-4dd0-9609-a80b33ad8f4c/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f6d27640-020e-4dd0-9609-a80b33ad8f4c/Untitled.png)

**문서이름을 클릭하여 자세히 보여주는 페이지입니다!**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f1a511c5-8c7f-4146-b7db-e820478e8d9f/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f1a511c5-8c7f-4146-b7db-e820478e8d9f/Untitled.png)

**'수정하기'를 통해 수정해보았습니다!**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77934e71-f367-4117-816d-3646dcf48a07/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77934e71-f367-4117-816d-3646dcf48a07/Untitled.png)

**—>수정도 잘 되었네요**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5fea2943-7e0e-43c2-ae5c-78940b88d0cf/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5fea2943-7e0e-43c2-ae5c-78940b88d0cf/Untitled.png)

**'삭제하기' 기능도 테스트 해보았습니다.**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/49a48a04-3e7c-419b-832b-8339c8e632c2/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/49a48a04-3e7c-419b-832b-8339c8e632c2/Untitled.png)

**삭제도 잘 되네요!!**

## 느낌점 및 후기:

- **기존에 사용하던 페이지를 활용하여 새로운 페이지와 해당 페이지에 요구되는 사항들에 맞추어 튜닝하는 방법에 대해 조금 더 능숙해진 것 같다는 느낌을 받았습니다. 또한, FTP를 통해 소스에 접근하여 소스에서 각 asp 파일 등에서 어떤 것들을 처리하고 어떤 다른 파일들과 연결되어 있는지 이전보다 더 수월하게 찾아낼 수 있었고, 기타 include된 파일들에 대한 구문과 그 경로, 그 기능까지 알아내는 부분에 이전보다 더 능숙해졌다는 느낌이 들었습니다.**
- **DB 또한 하나의 management 툴을 사용하는 것보단 여러가지 툴을 다뤄보자는 마인드로 새로운 management tool인 Microsoft SQL server management tool을 사용해보았습니다. 기능과 사용법은 대부분 비슷하기 때문에 어려움 없이 진행할 수 있었습니다.**
- **주 기능과는 조금 거리가 있는 기타 기능들에 대해 신경을 써야 할 것 같았습니다. 예를들어, 처음에 만들어 지는 게시물에는 '번호: 1'이 생성되고, 다음 게시물에는 '2'가 생성됩니다. 하지만 특정 게시물을 삭제하였을 때, 남아있는 게시물들의 번호들이 다시 재정렬 되는지, 첨부파일이 잘 첨부가 되는지, 내용들의 정렬사항을 어떤지 등의 유저를 위한 편리기능들에 대해 생각을 조금 하게 되었습니다.**
- **간단했던 프로젝트(?) 였지만 이전 프로젝트보다 더 발전된 내 자신을 느낄 수 있어 보람있었고, 프로젝트를 하며 이전에는 생각하지 못했던 사항들에 대해서도 스스로 깊히 생각할 수 있다는 것에 스스로가 대견스러웠습니다.**
