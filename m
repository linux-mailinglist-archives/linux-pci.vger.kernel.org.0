Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A5A7B4A90
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjJBBiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 21:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJBBiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 21:38:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9249C4
        for <linux-pci@vger.kernel.org>; Sun,  1 Oct 2023 18:38:11 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231002013808epoutp02af754c5b32c3ccf4ab3b138838337d13~KJqJDbkM-0383103831epoutp02T
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 01:38:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231002013808epoutp02af754c5b32c3ccf4ab3b138838337d13~KJqJDbkM-0383103831epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696210688;
        bh=kgh7GxZ2Bu/dvKtchhHvKfgopP2ArLE1uP8jxWXlhVY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=gW+4L3xj0z/BxjYKK6cMvaYb16SSAT4fs4JfImjRKxfn+hBLSPOp2+VU+2QF+vFO/
         yhIhOn+cx2PSNWwPUw5KS5os4HGQfJFXnRRD5+M9u4fHAzSUazzufj5K/J+rPrpXF7
         D89ZQTbrGk8RdrFRLzSqLp+bDS42GI6EY2x7ssQg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231002013807epcas5p3784a3a496efd1a82190980cbd4b54ab2~KJqIoDaCW2966929669epcas5p3P;
        Mon,  2 Oct 2023 01:38:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RzNrG2tv2z4x9Pt; Mon,  2 Oct
        2023 01:38:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.FB.19094.EFE1A156; Mon,  2 Oct 2023 10:38:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231002013805epcas5p4bd050e0163c8baca6e195caddede664e~KJqGtd79K2612526125epcas5p4B;
        Mon,  2 Oct 2023 01:38:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231002013805epsmtrp1c780a02dbb5469aeb828e6ce7300a6a8~KJqGsf3VL0119501195epsmtrp1O;
        Mon,  2 Oct 2023 01:38:05 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-17-651a1efe95a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.26.08649.DFE1A156; Mon,  2 Oct 2023 10:38:05 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231002013803epsmtip2880c69c0123cb6c0bbc92f94574bdce5~KJqEwDo7R0272902729epsmtip2Q;
        Mon,  2 Oct 2023 01:38:03 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= 
        <u.kleine-koenig@pengutronix.de>,
        "'Jingoo Han'" <jingoohan1@gmail.com>,
        "'Lorenzo Pieralisi'" <lpieralisi@kernel.org>,
        =?utf-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Kukjin Kim'" <kgene.kim@samsung.com>,
        "'Siva Reddy Kallam'" <siva.kallam@samsung.com>,
        "'Surendranath Gurivireddy Balla'" <suren.reddy@samsung.com>
Cc:     "'Rob Herring'" <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@pengutronix.de>
In-Reply-To: <20231001170254.2506508-2-u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 1/4] PCI: exynos: Don't put .remove callback in
 .exit.text section
Date:   Mon, 2 Oct 2023 07:08:01 +0530
Message-ID: <000001d9f4d1$16b652d0$4422f870$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNL/kGc24c2Ajts//TB+Z/BbdbirgICKpxwAtGBLRqtKwf3wA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmuu4/OalUg12fhC2WNGVYrPgyk91i
        1dSdLBa9C66yWex9vZXdoqHnN6vFpsfXWC3OzjvOZjHj/D4mi5Y/LSwW//fsYLe4PXEyowOP
        x85Zd9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo/+vgUffllWMHp83yQVwRmXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdq6RQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmibfpmlYK5s
        xdV319gbGLfJdDFyckgImEjsWtXO0sXIxSEksIdR4unT7VDOJ0aJX0/2sUM43xgluk8uZodp
        ebH1ESNEYi+jxLf2R2wQzgtGiXNN68Cq2AR0JXYsbgNLiAjcYZZYuaCfGcRhFljDKHF12Qkm
        kCpOATeJjcvnMYPYwgIRErsmvmQDsVkEVCRWHdwNZvMKWEpcOPcVyhaUODnzCQuIzSygLbFs
        4WtmiJsUJH4+XcYKYosIOEk8O7gYqkZc4uXRI2BPSAhc4ZBo+fcAqsFFYtGS2VAPCUu8Or4F
        ypaSeNnfBmRzANkeEov+SEGEMyTeLl/PCGHbSxy4MocFpIRZQFNi/S59iFV8Er2/nzBBdPJK
        dLQJQVSrSjS/u8oCYUtLTOzuZoWwPSQO3b/MOoFRcRaSx2YheWwWkgdmISxbwMiyilEqtaA4
        Nz012bTAUDcvtRwe5cn5uZsYwQlaK2AH4+oNf/UOMTJxMB5ilOBgVhLhbbsglirEm5JYWZVa
        lB9fVJqTWnyI0RQY3BOZpUST84E5Iq8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTU
        gtQimD4mDk6pBiYBnYK1fyQalh213qN50yPHwqVWn2/ihaBNxwxf/Pay3x1c9PHMkS6T+h/+
        d4u4PKsE9sTb7Iuf9s3RhyvxOt9OwegwhYRggZi3Br3RU1u2PEh9xmd0N7h/r5nGvpAnVZpq
        4nvVVr5o3BYXrehhYzfd9pDjr0W3Dgb9uSjF/8nwx6rJ2/mSf877fy60zv8AU3FOeudD6R/R
        Ut3d8yQnS3SX+tsYX81rOfxm9fK1P+far0l/zbS1cl3ymoU8Edn3i9e5TXbqyLpwY8u3qfy3
        qjNvmL25anLqS7aT77+Ls8w8HVf1Pn518v66g38bdfYdYbhfLKPrfM6IJfPj3Qc7OQT37S+z
        6XfLvNTerrxoQogSS3FGoqEWc1FxIgBfb57nWQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvO5fOalUgyPPRC2WNGVYrPgyk91i
        1dSdLBa9C66yWex9vZXdoqHnN6vFpsfXWC3OzjvOZjHj/D4mi5Y/LSwW//fsYLe4PXEyowOP
        x85Zd9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo/+vgUffllWMHp83yQVwRnHZpKTmZJal
        FunbJXBl/O58x1SwU7Ti9+z9jA2ME4S6GDk5JARMJF5sfcQIYgsJ7GaU2LM1GyIuLXF94wR2
        CFtYYuW/50A2F1DNM0aJ/nXzWUESbAK6EjsWt7GBJEQEHjBLdCzaCFbFLLCBUWLvtsdsEGMv
        MkocbnUCsTkF3CQ2Lp/H3MXIwSEsECYx6XkMSJhFQEVi1cHdYOW8ApYSF859hbIFJU7OfMIC
        YjMLaEs8vfkUzl628DUzxHUKEj+fLgM7SETASeLZwcVQNeISL48eYZ/AKDwLyahZSEbNQjJq
        FpKWBYwsqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNUS2MH4735//QOMTJxMB5i
        lOBgVhLhbbsglirEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMH
        p1QD04NzRV1vViTsP/MvNvOT3aqPz6svbU/iEl/eeHcaW5/Pwnwj3SVX78wxvaZ70d3QR2tu
        W+rX0hpVTkfWmVlF4avFJunlNrb5T9nIcSHuSmK2z1uH2cxJYiIrn3obiPhsudUy9aP9Co2z
        Bst8EoOWrDu4du4qvYojO/+tqdrdnpCk9kJBLuROmJD2gyymqKg9rz/9tOPmVLw2SSvx/eUU
        l4wlKqd+LioPY5MU+nR7O0fBykW2tj8eLN984HxwaU3qPx+fpWtP7Nobq7PrC+9C+8iFiXPv
        xn+ccNLg8A/RbQUz+I+9nrXizra9m1+/UU1bnuryTuZB5uuovqZH+Y2GZcYOudmVj1fqdX/9
        ZOt9xkGJpTgj0VCLuag4EQCAauIIPwMAAA==
X-CMS-MailID: 20231002013805epcas5p4bd050e0163c8baca6e195caddede664e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231001170325epcas5p341bc2ba7dcbd3fd37ee1c75e1fc51bd8
References: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
        <CGME20231001170325epcas5p341bc2ba7dcbd3fd37ee1c75e1fc51bd8@epcas5p3.samsung.com>
        <20231001170254.2506508-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=C3=B6nig=20<u.kleine-koenig=40pengutronix.de>=0D=0A>=
=20Sent:=20Sunday,=20October=201,=202023=2010:33=20PM=0D=0A>=20To:=20Jingoo=
=20Han=20<jingoohan1=40gmail.com>;=20Lorenzo=20Pieralisi=0D=0A>=20<lpierali=
si=40kernel.org>;=20Krzysztof=20Wilczy=C5=84ski=20<kw=40linux.com>;=20Bjorn=
=20Helgaas=0D=0A>=20<bhelgaas=40google.com>;=20Krzysztof=20Kozlowski=0D=0A>=
=20<krzysztof.kozlowski=40linaro.org>;=20Kukjin=20Kim=20<kgene.kim=40samsun=
g.com>;=20Siva=0D=0A>=20Reddy=20Kallam=20<siva.kallam=40samsung.com>;=20Sur=
endranath=20Gurivireddy=20Balla=0D=0A>=20<suren.reddy=40samsung.com>=0D=0A>=
=20Cc:=20Rob=20Herring=20<robh=40kernel.org>;=20Alim=20Akhtar=20<alim.akhta=
r=40samsung.com>;=0D=0A>=20linux-pci=40vger.kernel.org;=20linux-arm-kernel=
=40lists.infradead.org;=20linux-samsung-=0D=0A>=20soc=40vger.kernel.org;=20=
kernel=40pengutronix.de=0D=0A>=20Subject:=20=5BPATCH=201/4=5D=20PCI:=20exyn=
os:=20Don't=20put=20.remove=20callback=20in=20.exit.text=0D=0A>=20section=
=0D=0A>=20=0D=0A>=20With=20CONFIG_PCI_EXYNOS=3Dy=20and=20exynos_pcie_remove=
()=20marked=20with=20__exit,=0D=0A>=20the=20function=20is=20discarded=20fro=
m=20the=20driver.=20In=20this=20case=20a=20bound=20device=20can=20still=20g=
et=0D=0A>=20unbound,=20e.g=20via=20sysfs.=20Then=20no=20cleanup=20code=20is=
=20run=20resulting=20in=20resource=20leaks=20or=0D=0A>=20worse.=0D=0A>=20=
=0D=0A>=20The=20right=20thing=20to=20do=20is=20do=20always=20have=20the=20r=
emove=20callback=20available.=0D=0A>=20This=20fixes=20the=20following=20war=
ning=20by=20modpost:=0D=0A>=20=0D=0A>=20=09WARNING:=20modpost:=20drivers/pc=
i/controller/dwc/pci-exynos:=20section=0D=0A>=20mismatch=20in=20reference:=
=20exynos_pcie_driver+0x8=20(section:=20.data)=20->=0D=0A>=20exynos_pcie_re=
move=20(section:=20.exit.text)=0D=0A>=20=0D=0A>=20(with=20ARCH=3Dx86_64=20W=
=3D1=20allmodconfig).=0D=0A>=20=0D=0A>=20Fixes:=20340cba6092c2=20(=22pci:=
=20Add=20PCIe=20driver=20for=20Samsung=20Exynos=22)=0D=0A>=20Signed-off-by:=
=20Uwe=20Kleine-K=C3=B6nig=20<u.kleine-koenig=40pengutronix.de>=0D=0A>=20--=
-=0D=0AThanks=21=0D=0A=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40s=
amsung.com>=0D=0A=0D=0A>=20=20drivers/pci/controller/dwc/pci-exynos.c=20=7C=
=204=20++--=0D=0A>=20=201=20file=20changed,=202=20insertions(+),=202=20dele=
tions(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/pci/controller/dwc/pci=
-exynos.c=0D=0A>=20b/drivers/pci/controller/dwc/pci-exynos.c=0D=0A>=20index=
=206319082301d6..c6bede346932=20100644=0D=0A>=20---=20a/drivers/pci/control=
ler/dwc/pci-exynos.c=0D=0A>=20+++=20b/drivers/pci/controller/dwc/pci-exynos=
.c=0D=0A>=20=40=40=20-375,7=20+375,7=20=40=40=20static=20int=20exynos_pcie_=
probe(struct=20platform_device=0D=0A>=20*pdev)=0D=0A>=20=20=09return=20ret;=
=0D=0A>=20=20=7D=0D=0A>=20=0D=0A>=20-static=20int=20__exit=20exynos_pcie_re=
move(struct=20platform_device=20*pdev)=0D=0A>=20+static=20int=20exynos_pcie=
_remove(struct=20platform_device=20*pdev)=0D=0A>=20=20=7B=0D=0A>=20=20=09st=
ruct=20exynos_pcie=20*ep=20=3D=20platform_get_drvdata(pdev);=0D=0A>=20=0D=
=0A>=20=40=40=20-431,7=20+431,7=20=40=40=20static=20const=20struct=20of_dev=
ice_id=0D=0A>=20exynos_pcie_of_match=5B=5D=20=3D=20=7B=0D=0A>=20=0D=0A>=20=
=20static=20struct=20platform_driver=20exynos_pcie_driver=20=3D=20=7B=0D=0A=
>=20=20=09.probe=09=09=3D=20exynos_pcie_probe,=0D=0A>=20-=09.remove=09=09=
=3D=20__exit_p(exynos_pcie_remove),=0D=0A>=20+=09.remove=09=09=3D=20exynos_=
pcie_remove,=0D=0A>=20=20=09.driver=20=3D=20=7B=0D=0A>=20=20=09=09.name=09=
=3D=20=22exynos-pcie=22,=0D=0A>=20=20=09=09.of_match_table=20=3D=20exynos_p=
cie_of_match,=0D=0A>=20--=0D=0A>=202.40.1=0D=0A=0D=0A=0D=0A
