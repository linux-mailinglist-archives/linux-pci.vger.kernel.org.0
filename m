Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB465554436
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiFVHWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350216AbiFVHWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:22:06 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689436E3F
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 00:22:04 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220622072202epoutp01a357f053178a5dd12147ea8da465e335~64GFp_aer3230232302epoutp01L
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 07:22:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220622072202epoutp01a357f053178a5dd12147ea8da465e335~64GFp_aer3230232302epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655882522;
        bh=OsCBkB/Hg8OJ6ApY98wwN1LH5i0yIp4If2YhK1U5tNc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Fq/AtL6ZKDZheCLGBx5SYYRp6rdVU+33Od9LPqfjtCk0pyxJnScX3iMTQxN3WXKHg
         otTBM/IZI+ZQfQ62nCgOsyYNbOPm7+weNZ6XpIma0MvvjJTTSmKuEv+4MEOy1cX/rV
         PH+07WyeMf4yBaHPmL/7AfOkOuo2biowi0AAhRhU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220622072200epcas2p2ef8275ffd36cfb4ec8d194e2788cf415~64GEi9OP42374823748epcas2p2O;
        Wed, 22 Jun 2022 07:22:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LSZZc1QlDz4x9QH; Wed, 22 Jun
        2022 07:22:00 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-f3-62b2c31848a1
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.23.09642.813C2B26; Wed, 22 Jun 2022 16:22:00 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
CC:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220622072159epcms2p52a21560a7e60cffd13ea70e55ac15428@epcms2p5>
Date:   Wed, 22 Jun 2022 16:21:59 +0900
X-CMS-MailID: 20220622072159epcms2p52a21560a7e60cffd13ea70e55ac15428
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmma7E4U1JBstusFosacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9Nou9r7eyWzT0/Ga1OPLmI7PF/uMr
        mSwu75rDZnF23nE2iwmrvrFYvPn9gt3i3OJMi9a9R9gtdt45wWzxa+sfJgdRjzXz1jB6XF8X
        4LFgU6nHplWdbB53ru1h83hyZTqTx+Yl9R59W1Yxehy/sZ3J4/MmuQCuqGybjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKD3lBTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGauuPGMr2KZX0Xtu
        D2sD4xzdLkZODgkBE4nmba8Zuxi5OIQEdjBK7Pq1ga2LkYODV0BQ4u8OYZAaYQEvibXrXrGA
        2EICShI71sxjhojrS1xf0c0KYrMJ6Er8W/ySDWSOiMBqNolZO18wgTjMAgsYJfb/3scIsY1X
        Ykb7UxYIW1pi+/KtUHENiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHEpiQVP
        DrFC2NUS+//+ZoKwGxgl+u+ngjwjAXTpjuvGIGFeAV+J1t5usPEsAqoSrQunQo10kbg4+wzY
        acwC2hLLFr5mBmllFtCUWL9LH2KKssSRWywwjzRs/M2OzmYW4JPoOPwXLr5j3hOoY9Qk5q3c
        yQwxRkZi60v/CYxKsxDhPAvJ2lkIaxcwMq9iFEstKM5NTy02KjCGR21yfu4mRnA613LfwTjj
        7Qe9Q4xMHIyHGCU4mJVEeG24NyQJ8aYkVlalFuXHF5XmpBYfYjQFengis5Rocj4wo+SVxBua
        WBqYmJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCUamCKvf3EXXyStmDOhxMPX61d
        vlFO8NW6u1ttTlY+3Pt24fkpc+33HC+NfuIvFGnTuChiuuNUnU9LZF5f4ld8wJqxxm67Bsd3
        4esy9jI8Sc8W/mB+2v/Q3mDzy3wZr7DPlX+3NbDVJXOKqzEUp/xujuPPT9vuabVniaZkc+a8
        7RcdmSyPSDb1tvqsqeG+9/YVm9ibQ6b572ZLLHnrpSrzMP+xQpGJX+DuOIagoD0f9j9ccn7v
        0t+FH6U6Nu9bqj57D+ujt3X167wUnu2cKbD1ucLRhFts14MvL+ZIKH+aECyYYaj29WRuoPOJ
        7zvl88yyV54QfsfA/qVy3SuPi+3XL8geDX5+cofJsjvLQ8XOtBa9UGIpzkg01GIuKk4EABHd
        qzBwBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A021/06/2022=C2=A021:44,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=C2=A0On=C2=A021/06/2022=C2=A009:42,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=
=0D=0A>>>>=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0samsung,syscon-bus-s-fsys:=0D=
=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0description:=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0bus-s=C2=A0path=C2=A0of=C2=A0fsys=C2=A0=
block,=C2=A0this=C2=A0register=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0are=C2=A0used=C2=A0for=C2=A0enabling=C2=A0bus-s.=0D=0A>>>>=C2=A0=C2=A0=
=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>>=
>>=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0samsung,syscon-bus-p-fsys:=0D=0A>>>>=C2=
=A0=C2=A0=C2=A0=C2=A0description:=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Phandle=C2=A0to=C2=A0bus-p=C2=A0path=C2=A0of=C2=A0fsys=C2=A0block,=C2=
=A0this=C2=A0register=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0are=C2=
=A0used=C2=A0for=C2=A0enabling=C2=A0bus-p.=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=
=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>>>=0D=0A>>=
>=C2=A0This=C2=A0two=C2=A0look=C2=A0unspecific=C2=A0and=C2=A0hacky=C2=A0wor=
karound=C2=A0for=C2=A0missing=C2=A0drivers.=C2=A0Looks=0D=0A>>>=C2=A0like=
=C2=A0instead=C2=A0of=C2=A0implementing=C2=A0interconnect=C2=A0or=C2=A0cloc=
k=C2=A0driver,=C2=A0you=C2=A0decided=0D=0A>>>=C2=A0to=C2=A0poke=C2=A0some=
=C2=A0other=C2=A0registers.=C2=A0Why=C2=A0this=C2=A0cannot=C2=A0be=C2=A0an=
=C2=A0interconnect=C2=A0driver?=0D=0A>>>=0D=0A>>>=0D=0A>>=C2=A0=0D=0A>>=C2=
=A0bus-s,=C2=A0bus-p=C2=A0is=C2=A0a=C2=A0register=C2=A0that=C2=A0exists=C2=
=A0in=C2=A0the=C2=A0sysreg=C2=A0of=C2=A0the=C2=A0fsys=C2=A0block.=0D=0A>>=
=C2=A0It=C2=A0is=C2=A0the=C2=A0same=C2=A0block=C2=A0as=C2=A0=22fsys-sysreg=
=22=C2=A0but=C2=A0is=C2=A0separated=C2=A0separately=C2=A0in=0D=0A>>=C2=A0ha=
rdware.=0D=0A>=C2=A0=0D=0A>=C2=A0Two=C2=A0points=C2=A0here:=0D=0A>=C2=A01.=
=C2=A0If=C2=A0it=C2=A0is=C2=A0in=C2=A0FSYS,=C2=A0why=C2=A0it=C2=A0cannot=C2=
=A0be=C2=A0accessed=C2=A0with=C2=A0samsung,fsys-sysreg?=0D=0A>=C2=A02.=C2=
=A0If=C2=A0it=C2=A0is=C2=A0only=C2=A0register,=C2=A0shuld=C2=A0be=C2=A0desc=
ribed=C2=A0like=C2=A0this.=C2=A0You=C2=A0must=0D=0A>=C2=A0describe=C2=A0ite=
m:=0D=0A>=C2=A0https://protect2.fireeye.com/v1/url?k=3D0f529a57-50c9a332-0f=
531118-000babff32e3-50938d8198077d59&q=3D1&e=3D32284e69-bbed-4d09-b6d6-0a43=
428aebf5&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18-rc1%2Fsource%=
2FDocumentation%2Fdevicetree%2Fbindings%2Fsoc%2Fsamsung%2Fexynos-usi.yaml%2=
3L42=0D=0A>=C2=A0=0D=0A=0D=0AIt=C2=A0would=C2=A0be=C2=A0better=C2=A0to=C2=
=A0access=C2=A0with=C2=A0fsys-sysreg,=C2=A0but=C2=A0their=C2=A0h/w=C2=A0add=
ress=C2=A0are=0D=0Afar=C2=A0from=C2=A0each=C2=A0other.=C2=A0The=C2=A0fsys=
=C2=A0block=C2=A0consists=C2=A0of=C2=A0a=C2=A0system=C2=A0register=C2=A0and=
=C2=A0an=0D=0Aadditional=C2=A0control=C2=A0system=C2=A0register.=C2=A0=22bu=
s-s-fsys=22=C2=A0and=C2=A0=22bus-p-fsys=22=C2=A0are=0D=0Aadditional=C2=A0co=
ntrol=C2=A0system=C2=A0register.=C2=A0sysreg=C2=A0and=C2=A0additional=C2=A0=
control=C2=A0sysreg=0D=0Aaddresses=C2=A0are=C2=A0far=C2=A0from=C2=A0each=C2=
=A0other=C2=A0and=C2=A0there=C2=A0are=C2=A0h/w=C2=A0registers=C2=A0that=C2=
=A0perform=0D=0Adifferent=C2=A0functions=C2=A0between=C2=A0them.=0D=0A=0D=
=0A>>=C2=A0So,=C2=A0get=C2=A0resource=C2=A0is=C2=A0performed=C2=A0separatel=
y=C2=A0from=C2=A0=22fsys-sysreg=22.=0D=0A>>=C2=A0They=C2=A0set=C2=A0pcie=C2=
=A0slave,=C2=A0dbi=C2=A0related=C2=A0control=C2=A0settings,=0D=0A>>=C2=A0na=
ming=C2=A0=22bus-x=22=C2=A0seems=C2=A0to=C2=A0be=C2=A0interconnect.=0D=0A>>=
=C2=A0I=C2=A0will=C2=A0add=C2=A0this=C2=A0description=C2=A0to=C2=A0property=
.=0D=0A>>=C2=A0I=C2=A0don't=C2=A0think=C2=A0it=C2=A0need=C2=A0to=C2=A0use=
=C2=A0the=C2=A0interconnect=C2=A0driver,=0D=0A>>=C2=A0so=C2=A0please=C2=A0l=
et=C2=A0me=C2=A0know=C2=A0your=C2=A0opinion.=0D=0A>=C2=A0=0D=0A>=C2=A0Pleas=
e=C2=A0document=C2=A0both=C2=A0in=C2=A0the=C2=A0bindings=C2=A0and=C2=A0in=
=C2=A0the=C2=A0driver=C2=A0usage=C2=A0of=C2=A0this=0D=0A>=C2=A0register.=C2=
=A0Writing=C2=A0there=C2=A0=220=22=C2=A0or=C2=A0=221=22=C2=A0is=C2=A0not=C2=
=A0enough.=C2=A0If=C2=A0the=C2=A0documentation=0D=0A>=C2=A0is=C2=A0good,=C2=
=A0I=C2=A0am=C2=A0fine=C2=A0with=C2=A0it.=C2=A0If=C2=A0the=C2=A0explanation=
=C2=A0is=C2=A0obfuscated/not=0D=0A>=C2=A0sufficient,=C2=A0it=C2=A0will=C2=
=A0look=C2=A0like=C2=A0avoiding=C2=A0to=C2=A0implement=C2=A0a=C2=A0driver,=
=C2=A0which=C2=A0I=0D=0A>=C2=A0don't=C2=A0want=C2=A0to=C2=A0accept.=0D=0A>=
=C2=A0=0D=0A=0D=0AI=C2=A0think=C2=A0i=C2=A0should=C2=A0add=C2=A0enough=C2=
=A0description.=C2=A0Is=C2=A0it=C2=A0sufficient=C2=A0to=C2=A0modify=0D=0Ath=
e=C2=A0name=C2=A0and=C2=A0description=C2=A0of=C2=A0property=C2=A0like=C2=A0=
this?=0D=0A=0D=0Asamsung,fsys-bus-s:=0D=0A=C2=A0=C2=A0description:=0D=0A=C2=
=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0bus-s=C2=A0of=C2=A0fsys=C2=A0bloc=
k,=C2=A0this=C2=A0register=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0is=C2=A0additional=
=C2=A0control=C2=A0sysreg=C2=A0in=C2=A0fsys=C2=A0block=C2=A0and=0D=0A=C2=A0=
=C2=A0=C2=A0=C2=A0this=C2=A0is=C2=A0used=C2=A0for=C2=A0pcie=C2=A0slave=C2=
=A0control=C2=A0setting.=0D=0A=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=
=23/definitions/phandle=0D=0A=0D=0Asamsung,fsys-bus-p:=0D=0A=C2=A0=C2=A0des=
cription:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0bus-p=C2=A0of=
=C2=A0fsys=C2=A0block,=C2=A0this=C2=A0register=0D=0A=C2=A0=C2=A0=C2=A0=C2=
=A0is=C2=A0additional=C2=A0control=C2=A0sysreg=C2=A0in=C2=A0fsys=C2=A0block=
=C2=A0and=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0this=C2=A0is=C2=A0used=C2=A0for=C2=
=A0pcie=C2=A0dbi=C2=A0control=C2=A0setting.=0D=0A=C2=A0=C2=A0=24ref:=C2=A0/=
schemas/types.yaml=23/definitions/phandle=0D=0A=0D=0A>=C2=A0Best=C2=A0regar=
ds,=0D=0A>=C2=A0Krzysztof=0D=0A=0D=0AThank=C2=A0you=C2=A0for=C2=A0kindness=
=C2=A0reivew.=0D=0A=0D=0ABest=C2=A0regards,=0D=0AWangseok=C2=A0Lee
