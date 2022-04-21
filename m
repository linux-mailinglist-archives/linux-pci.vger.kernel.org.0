Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBC50AC93
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiDVAAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442829AbiDVAA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 20:00:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18C3ED2D
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 16:57:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220421235730epoutp025a71dda0920d204e7797f5dc08d464f2~oDrjo00871345213452epoutp02R
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 23:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220421235730epoutp025a71dda0920d204e7797f5dc08d464f2~oDrjo00871345213452epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650585450;
        bh=5Sox+YNGgjYTvkyhHby50JbmhNPXeBUzzR3HBxzMBOw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iWgJbsIhgvyrCuuSbT+2KHBNB8kv8H74m+4uAhIWLXbXBciYuljuRRMadjHfDRDX3
         hdw20u4+93O+yKEXT1bGvb/r7xDSa3tnpokyeW3nwZSE+ecVujHxIdCXnQD/VeCpv0
         8HYrMyPkHBNHJOMcUVEQ0SSzQ+oVMw8WSHeiq1Lw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220421235730epcas2p3a16df8e04b9876100c89c52b5ad34fa9~oDri7NNye1370513705epcas2p3Q;
        Thu, 21 Apr 2022 23:57:30 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kkvbp73HNz4x9Pr; Thu, 21 Apr
        2022 23:57:26 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-c8-6261ef66dd84
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.23.10444.66FE1626; Fri, 22 Apr 2022 08:57:26 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        robh+dt <robh+dt@kernel.org>, krzk+dt <krzk+dt@kernel.org>,
        kishon <kishon@ti.com>, vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>
CC:     bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <4a6dd90c-3f8e-ad18-0136-88b75f4d9cf9@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220421235725epcms2p1fc34c904f960cba958fa692c6d5dad9c@epcms2p1>
Date:   Fri, 22 Apr 2022 08:57:25 +0900
X-CMS-MailID: 20220421235725epcms2p1fc34c904f960cba958fa692c6d5dad9c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmmW7a+8Qkg0MLJCyWNGVYvDykaTH/
        yDlWi90zljNZPD80i9niU4uqxYWnPWwWL2fdY7M4f34Du0VDz29WiyNvPjJb7D++ksni8q45
        bBZn5x1ns5iw6huLxZvfL9gtzi3OtGjde4TdYuedE8wOwh5r5q1h9Li+LsBjwaZSj02rOtk8
        nlyZzuSxeUm9R9+WVYwex29sZ/L4vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6B8lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGqnMr2QpWWlasOlTcwPjKvIuRk0NCwETi9Yvr
        zF2MXBxCAjsYJVY2HmDtYuTg4BUQlPi7QxikRljAWeLf7VZmEFtIQElix5p5zBBxfYnrK7pZ
        QWw2AV2Jf4tfsoHMERFYwCRxf+4MJhCHWeA/k8SrxmNsENt4JWa0P2WBsKUlti/fyghicwrY
        SWz81AJVoyHxY1kvM4QtKnFz9Vt2GPv9sfmMELaIROu9s1A1ghIPfu6GiktJLHhyiBXCrpbY
        //c3E4TdwCjRfz8V5DEJoKt3XDcGCfMK+ErM690FNp5FQFWi/9osqDEuEvu/ngQbzyygLbFs
        4WtmkFZmAU2J9bv0IaYoSxy5xQLzVMPG3+zobGYBPomOw3/h4jvmPYE6Rk1i3sqdzBMYlWch
        AnoWkl2zEHYtYGRexSiWWlCcm55abFRgCI/a5PzcTYzghK3luoNx8tsPeocYmTgYDzFKcDAr
        ifCGzoxPEuJNSaysSi3Kjy8qzUktPsRoCvTlRGYp0eR8YM7IK4k3NLE0MDEzMzQ3MjUwVxLn
        9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAVB8r1n77cOQRy1leVXOzF8x9nPV0ViDXv0fPRGOt
        GrxyLHeymGXrKl7RNletcs1Yx/j87FonOZd/9r0ZSzc0Pexg13/1y0vK9tuM19L+n12dTohb
        LWD9WSrjoPUtzvkts/C11B0Ry7+9br1QupxJd2WCyIMzvj9OFCu2v9+95+m9OXZlxbfYlkZU
        b74+KUOhb3rN7eqaaX23pJz/Mq09erFq2/ycl25fG0NXm7yYOWWij8Nh/5zmsyqfC369Dyt+
        eV5Qu3j6kqcd7Xa5YXzrLir8LDHmWc91V21n+4yjH1r73qvaH0o6dirrdonWtao866ia258l
        M18VZRbNynsT/f+Bs7z1A96S9UeC/6ZOU2Ipzkg01GIuKk4EAPbGHa9hBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1
References: <4a6dd90c-3f8e-ad18-0136-88b75f4d9cf9@kernel.org>
        <20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
        <CGME20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On=C2=A018/04/2022=C2=A009:20,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=
>>=C2=A0Also,=C2=A0as=C2=A0you=C2=A0know,=0D=0A>>>>=C2=A0exynos=C2=A0driver=
=C2=A0is=C2=A0designed=C2=A0according=C2=A0to=C2=A0exynos=C2=A0SoC=C2=A0pla=
tform,=0D=0A>>>>=C2=A0so=C2=A0both=C2=A0function=C2=A0and=C2=A0variable=C2=
=A0names=C2=A0start=C2=A0with=C2=A0exynos.=0D=0A>>>=0D=0A>>>=C2=A0That's=C2=
=A0hardly=C2=A0a=C2=A0problem...=0D=0A>>>=0D=0A>>>>=C2=A0Compared=C2=A0to=
=C2=A0the=C2=A0existing=C2=A0exynos=C2=A0driver,=C2=A0=0D=0A>>>>=C2=A0you=
=C2=A0can=C2=A0see=C2=A0that=C2=A0the=C2=A0structure=C2=A0and=C2=A0type=C2=
=A0of=C2=A0function=C2=A0are=C2=A0different.=0D=0A>>>=0D=0A>>>=C2=A0No,=C2=
=A0I=C2=A0cannot=C2=A0see=C2=A0it.=C2=A0You=C2=A0coded=C2=A0the=C2=A0driver=
=C2=A0that=C2=A0way,=C2=A0you=C2=A0can=C2=A0code=C2=A0it=C2=A0in=0D=0A>>>=
=C2=A0other=C2=A0way.=0D=0A>>>=0D=0A>>>>=C2=A0For=C2=A0this=C2=A0reason,=C2=
=A0it=C2=A0is=C2=A0difficult=C2=A0to=C2=A0use=C2=A0the=C2=A0existing=C2=A0e=
xynos=C2=A0driver=C2=A0=0D=0A>>>>=C2=A0for=C2=A0artpec.=0D=0A>>>=0D=0A>>>=
=C2=A0Naming=C2=A0of=C2=A0functions=C2=A0and=C2=A0structures=C2=A0is=C2=A0n=
ot=C2=A0making=C2=A0it=C2=A0difficult.=C2=A0That's=0D=0A>>>=C2=A0not=C2=A0t=
he=C2=A0reason.=0D=0A>>>=0D=0A>>>>=C2=A0Our=C2=A0idea=C2=A0is=C2=A0to=C2=A0=
register=C2=A0a=C2=A0new=C2=A0PCIe=C2=A0driver=C2=A0for=C2=A0artpec-8=C2=A0=
SoC=C2=A0platform=C2=A0=0D=0A>>>>=C2=A0and=C2=A0maintain=C2=A0it=C2=A0in=C2=
=A0the=C2=A0future.=0D=0A>>>=0D=0A>>>=C2=A0We=C2=A0also=C2=A0want=C2=A0to=
=C2=A0maintain=C2=A0Exynos=C2=A0PCIe=C2=A0driver=C2=A0in=C2=A0the=C2=A0futu=
re.=0D=0A>>>=0D=0A>>>=C2=A0Best=C2=A0regards,=0D=0A>>>=C2=A0Krzysztof=0D=0A=
>>=C2=A0=0D=0A>>=C2=A0Hi,=C2=A0=0D=0A>>=C2=A0Sorry=C2=A0for=C2=A0delay=C2=
=A0response.=0D=0A>=20=0D=0A>=20Sure,=C2=A0happens,=C2=A0but=C2=A0I=C2=A0do=
n't=C2=A0remember=C2=A0the=C2=A0discussion,=C2=A0so=C2=A0replying=C2=A0that=
=0D=0A>=20late=C2=A0will=C2=A0not=C2=A0help=C2=A0your=C2=A0cause.=0D=0A>=20=
=0D=0A>=20You=C2=A0know=C2=A0that=C2=A0if=C2=A0you=C2=A0(you=C2=A0as=C2=A0S=
amsung)=C2=A0worked=C2=A0with=C2=A0upstream,=C2=A0e.g.=C2=A0by=0D=0A>=20ext=
ending=C2=A0the=C2=A0drivers=C2=A0and=C2=A0keeping=C2=A0them=C2=A0in=C2=A0s=
hape,=C2=A0it=C2=A0would=C2=A0be=C2=A0much=C2=A0easier=0D=0A>=20for=C2=A0yo=
u=C2=A0(again=C2=A0you=C2=A0as=C2=A0Samsung)=C2=A0to=C2=A0actually=C2=A0add=
=C2=A0new=C2=A0features?=C2=A0It's=C2=A0much=0D=0A>=20better/effective=C2=
=A0approach=C2=A0than=C2=A0the=C2=A0path=C2=A0of=C2=A0pushing=C2=A0every=C2=
=A0time=C2=A0new=C2=A0driver=0D=0A>=20with=C2=A0explanation=C2=A0like=C2=A0=
=22we=C2=A0do=C2=A0not=C2=A0want=C2=A0to=C2=A0maintain=C2=A0older=C2=A0driv=
er,=C2=A0so=C2=A0we=0D=0A>=20want=C2=A0a=C2=A0new=C2=A0one=22...=0D=0A>=20=
=0D=0A>>=C2=A0I=C2=A0have=C2=A0listed=C2=A0some=C2=A0parts=C2=A0that=C2=A0a=
re=C2=A0different=C2=A0from=C2=A0exynos=C2=A0pcie=C2=A0driver.=0D=0A>>=C2=
=A0=0D=0A>>=C2=A0PHY=C2=A0driver=0D=0A>>=C2=A0PHY=C2=A0is=C2=A0different,=
=C2=A0so=C2=A0register=C2=A0map=C2=A0is=C2=A0also=C2=A0different.=0D=0A>>=
=C2=A0Three=C2=A0reference=C2=A0clock=C2=A0options=C2=A0are=C2=A0available=
=C2=A0in=C2=A0ARTPEC-8.=0D=0A>>=C2=A0=C2=A0=C2=A0It=C2=A0operates=C2=A0by=
=C2=A0selecting=C2=A0one=C2=A0clock=C2=A0among=C2=A0XO,=C2=A0IO,=C2=A0and=
=C2=A0SOC=C2=A0PLL.=0D=0A>>=C2=A0=C2=A0=C2=A0However,=C2=A0the=C2=A0exynos=
=C2=A0phy=C2=A0driver=C2=A0sets=C2=A0one=C2=A0ref=C2=A0clk=C2=A0though=C2=
=A0sysreg.=0D=0A>=20=0D=0A>=20It=C2=A0usually=C2=A0trivial=C2=A0to=C2=A0cod=
e=C2=A0such=C2=A0difference=C2=A0in=C2=A0the=C2=A0driver.=0D=0A>=20=0D=0A>>=
=C2=A0The=C2=A0reset=C2=A0method=C2=A0and=C2=A0type=C2=A0of=C2=A0PHY=C2=A0f=
or=C2=A0initialization=C2=A0are=C2=A0different.=0D=0A>>=C2=A0The=C2=A0overa=
ll=C2=A0sysreg=C2=A0configuration=C2=A0is=C2=A0different=0D=0A>=20=0D=0A>=
=20Indeed.=0D=0A>=20=0D=0A>>=C2=A0Artpec-8=C2=A0requires=C2=A0a=C2=A0separa=
te=C2=A0sequence=C2=A0for=C2=A0phy=C2=A0tuning,=0D=0A>>=C2=A0but=C2=A0it=C2=
=A0does=C2=A0not=C2=A0exist=C2=A0in=C2=A0exynos=C2=A0phy=C2=A0driver.=0D=0A=
>>=C2=A0Artpec-8=C2=A0requires=C2=A0pcs=C2=A0resources,=C2=A0but=C2=A0exyno=
s=C2=A0phy=C2=A0driver=C2=A0does=C2=A0not=C2=A0exist.=0D=0A>>=C2=A0=0D=0A>=
=20=0D=0A>=20For=C2=A0the=C2=A0phy=C2=A0driver=C2=A0indeed=C2=A0it=C2=A0mig=
ht=C2=A0require=C2=A0much=C2=A0effort=C2=A0to=C2=A0create=C2=A0one=C2=A0dri=
ver.=0D=0A>=20=0D=0A>>=C2=A0Controller=C2=A0driver=0D=0A>>=C2=A0Sub=C2=A0co=
ntroller=C2=A0is=C2=A0different,=C2=A0so=C2=A0register=C2=A0map=C2=A0is=C2=
=A0also=C2=A0different.=0D=0A>>=C2=A0And=C2=A0it=C2=A0is=C2=A0different=C2=
=A0handles=C2=A0lane=C2=A0control,=C2=A0link=C2=A0control,=C2=A0PHY=C2=A0cl=
ocking,=0D=0A>>=C2=A0reset,=C2=A0interrupt=C2=A0control.=C2=A0=0D=0A>>=C2=
=A0The=C2=A0number=C2=A0and=C2=A0type=C2=A0of=C2=A0clock=C2=A0resources=C2=
=A0used=C2=A0are=C2=A0different.=0D=0A>>=C2=A0The=C2=A0overall=C2=A0sysreg=
=C2=A0configuration=C2=A0is=C2=A0different=0D=0A>>=C2=A0=0D=0A>>=C2=A0Also=
=C2=A0artpec-8=C2=A0is=C2=A0performed=C2=A0in=C2=A0dual=C2=A0mode=C2=A0that=
=C2=A0supports=C2=A0both=C2=A0RC=C2=A0and=C2=A0EP.=0D=0A>>=C2=A0As=C2=A0des=
cribed=C2=A0above,=C2=A0the=C2=A0PHY=C2=A0and=C2=A0sub=C2=A0ontroller=C2=A0=
are=C2=A0different=0D=0A>>=C2=A0and=C2=A0the=C2=A0regiser=C2=A0map=C2=A0is=
=C2=A0different.=0D=0A>>=C2=A0sysreg=C2=A0is=C2=A0also=C2=A0different.=C2=
=A0And=C2=A0there=C2=A0are=C2=A0differences=C2=A0such=C2=A0as=C2=A0reset.=
=0D=0A>>=C2=A0The=C2=A0driver=C2=A0will=C2=A0be=C2=A0much=C2=A0more=C2=A0co=
mplicated=C2=A0if=C2=A0both=C2=A0hardwares=C2=A0should=C2=A0be=0D=0A>>=C2=
=A0supported=C2=A0in=C2=A0the=C2=A0same=C2=A0driver.=0D=0A>=20=0D=0A>=20May=
be,=C2=A0quite=C2=A0probably.=C2=A0The=C2=A0reluctance=C2=A0to=C2=A0extend=
=C2=A0any=C2=A0existing=C2=A0code=C2=A0makes=0D=0A>=20me=C2=A0doubting=C2=
=A0this,=C2=A0but=C2=A0I=C2=A0admit=C2=A0that=C2=A0there=C2=A0are=C2=A0many=
=C2=A0differences.=0D=0A>=20=0D=0A>>=C2=A0For=C2=A0these=C2=A0reasons,=C2=
=A0my=C2=A0opinion=C2=A0is=C2=A0that=C2=A0better=C2=A0to=C2=A0create=0D=0A>=
>=C2=A0a=C2=A0phy,=C2=A0controller=C2=A0both=C2=A0driver=C2=A0with=C2=A0a=
=C2=A0new=C2=A0file.=0D=0A>>=C2=A0Please=C2=A0let=C2=A0me=C2=A0know=C2=A0yo=
ur=C2=A0opinion.=0D=0A>=20=0D=0A>=20At=C2=A0the=C2=A0end=C2=A0it's=C2=A0mos=
tly=C2=A0the=C2=A0decision=C2=A0of=C2=A0PCIe=C2=A0and=C2=A0phy=C2=A0subsyst=
em=0D=0A>=20maintainers=C2=A0whether=C2=A0they=C2=A0want=C2=A0to=C2=A0have=
=C2=A0separate=C2=A0drivers=C2=A0for=C2=A0DWC=C2=A0PCIe=0D=0A>=20blocks=C2=
=A0in=C2=A0ARMv8=C2=A0Samsung=C2=A0SoCs.=0D=0A>=20=0D=0A>=20In=C2=A0any=C2=
=A0case,=C2=A0the=C2=A0driver=C2=A0code=C2=A0looks=C2=A0like=C2=A0copied-pa=
sted=C2=A0from=C2=A0some=C2=A0vendor=0D=0A>=20sources,=C2=A0so=C2=A0you=C2=
=A0need=C2=A0to=C2=A0bring=C2=A0it=C2=A0to=C2=A0shape.=0D=0A>=20=0D=0A>=20B=
est=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AHi,=0D=0A=0D=0AThank=20you=
=20for=20your=20kindness=20review=20over=20several=20e-mails.=0D=0AI=20will=
=20improve=20on=20PATCH=201,2,3,4=20and=20i=20will=20return=20with=20v2.=0D=
=0A(yaml=20and=20phy,=20controller=20driver=20code=20improvement)=0D=0AAt=
=20that=20time,=20i=20would=20like=20ask=20to=20you=20and=20phy,=20controll=
er=20=0D=0Amaintainer's=20opinion=20again.=0D=0A=0D=0AThank=20you.
