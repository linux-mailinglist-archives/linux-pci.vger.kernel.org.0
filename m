Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2B554485
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352839AbiFVHUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbiFVHUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:20:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230E36E32
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 00:20:47 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220622072045epoutp022dcdb396e2935703cbc5782c7a7a02fc~64E_Pwn4n1379413794epoutp02p
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 07:20:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220622072045epoutp022dcdb396e2935703cbc5782c7a7a02fc~64E_Pwn4n1379413794epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655882445;
        bh=RswvKDk4upxR0WC4q5EAwd93hnGQme9cTpzcHMcp0wo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=K4L9hOZ+5jx0kEw/Bl8O4pq+n+MHkc3X3cQHsKFSg5sfhg14U/A+UMXutwLPlPxKd
         j8aGpHAf0Q4M45oe5DuDZFiHIh4b3ERn8Oi5dmzvoh4jtwtYN43IotpMgcDTukxEr7
         ZueS49Anchgi3kAoZzph+16VjP7nalTBpLcm1D4s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220622072044epcas2p28ab1ed3e98b70ecb1c92a3d7ec20c1cb~64E9IWtLd1904919049epcas2p2S;
        Wed, 22 Jun 2022 07:20:44 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LSZY7414Pz4x9QP; Wed, 22 Jun
        2022 07:20:43 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-95-62b2c2cb39f9
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.32.09642.BC2C2B26; Wed, 22 Jun 2022 16:20:43 +0900 (KST)
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
In-Reply-To: <4a58c6c4-be0e-e56c-2498-a14ba46b508d@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220622072042epcms2p478ff972391aa11a8827347b3469fd00c@epcms2p4>
Date:   Wed, 22 Jun 2022 16:20:42 +0900
X-CMS-MailID: 20220622072042epcms2p478ff972391aa11a8827347b3469fd00c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmhe7pQ5uSDBb/lLZY0pRh8fKQpsX8
        I+dYLXbPWM5kMXPqGWaL54dmMVt8alG1uPC0h83i5ax7bBZ7X29lt2jo+c1qceTNR2aL/cdX
        Mllc3jWHzeLsvONsFhNWfWOxePP7BbvFucWZFq17j7Bb7Lxzgtni19Y/TA6iHmvmrWH0uL4u
        wGPBplKPTas62TzuXNvD5vHkynQmj81L6j36tqxi9Dh+YzuTx+dNcgFcUdk2GamJKalFCql5
        yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDvKSmUJeaUAoUCEouLlfTt
        bIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM9582cdUME+7Yu+8
        6cwNjH1aXYycHBICJhKXVp1k6WLk4hAS2MEo0dqxm7WLkYODV0BQ4u8OYZAaYQEvibXrXrGA
        2EICShI71sxjhojrS1xf0c0KYrMJ6Er8W/ySDWSOiMBqNolZO18wgTjMAgsYJfb/3scIsY1X
        Ykb7UxYIW1pi+/KtYHFOATuJxmePmCDiGhI/lvUyQ9iiEjdXv2WHsd8fmw81R0Si9d5ZqBpB
        iQc/d0PFpSQWPDnECmFXS+z/+xtqZgOjRP/9VJDHJICu3nHdGCTMK+Ar0bV8BhuIzSKgKvFx
        3l02iHIXidmXD4CNZBbQlli28DUzSCuzgKbE+l36EFOUJY7cYoF5qmHjb3Z0NrMAn0TH4b9w
        8R3znkAdoyYxb+VO5gmMyrMQAT0Lya5ZCLsWMDKvYhRLLSjOTU8tNiowhsdtcn7uJkZwQtdy
        38E44+0HvUOMTByMhxglOJiVRHhtuDckCfGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MKfk
        lcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpg0r7SrmbmzizTIhPs
        /Wj2Gb/g+s8/xVSzdiQsS52or6ekmhjDWf9/dnpZzpbkgJ+z/N1PX1yed+lo95I8KZ5388XP
        rdFndWHjcVxmY6mtYMSannom5cmbU8y396ddkD6X9cPz+6UDV68b7Eow35XNxMi/Wf3QUh+z
        1efcn8dYTXtRL1peptxi92Kr482cX6a2LxI6rnoHXY7YeO7JsX2bc+VkNKapWbJum/8yZm+a
        3ruGrROaOjabxKz8v+hIevou7w7ZtgUMZQW7K7aWrXH+VTB948fkEovGzOcX3/TMfpEYEh0z
        sy2uQnbbO6XzL1XW5k1/t2pGY8WRawVHxVi49l7QvM1QMu29hfKvyow5SizFGYmGWsxFxYkA
        0Tq3QnEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <4a58c6c4-be0e-e56c-2498-a14ba46b508d@linaro.org>
        <f9a877ce-1e18-90f9-67e5-b6e67b3b4156@linaro.org>
        <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
        <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
        <20220621074244epcms2p23cb631babfb87e5abb416467fb66e521@epcms2p2>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A021/06/2022=C2=A021:44,=C2=A0Krzysztof=20Kozlowski=C2=A0wrote:=0D=0A=
>=20On=C2=A021/06/2022=C2=A009:42,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A=
>>>>=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0samsung,syscon-bus-s-fsys:=0D=0A>>>>=
=C2=A0=C2=A0=C2=A0=C2=A0description:=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0Phandle=C2=A0to=C2=A0bus-s=C2=A0path=C2=A0of=C2=A0fsys=C2=A0block,=
=C2=A0this=C2=A0register=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0are=
=C2=A0used=C2=A0for=C2=A0enabling=C2=A0bus-s.=0D=0A>>>>=C2=A0=C2=A0=C2=A0=
=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>>>>=C2=
=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0samsung,syscon-bus-p-fsys:=0D=0A>>>>=C2=A0=
=C2=A0=C2=A0=C2=A0description:=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Phandle=C2=A0to=C2=A0bus-p=C2=A0path=C2=A0of=C2=A0fsys=C2=A0block,=C2=A0=
this=C2=A0register=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0are=C2=A0us=
ed=C2=A0for=C2=A0enabling=C2=A0bus-p.=0D=0A>>>>=C2=A0=C2=A0=C2=A0=C2=A0=24r=
ef:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>>>=0D=0A>>>=C2=A0=
This=C2=A0two=C2=A0look=C2=A0unspecific=C2=A0and=C2=A0hacky=C2=A0workaround=
=C2=A0for=C2=A0missing=C2=A0drivers.=C2=A0Looks=0D=0A>>>=C2=A0like=C2=A0ins=
tead=C2=A0of=C2=A0implementing=C2=A0interconnect=C2=A0or=C2=A0clock=C2=A0dr=
iver,=C2=A0you=C2=A0decided=0D=0A>>>=C2=A0to=C2=A0poke=C2=A0some=C2=A0other=
=C2=A0registers.=C2=A0Why=C2=A0this=C2=A0cannot=C2=A0be=C2=A0an=C2=A0interc=
onnect=C2=A0driver?=0D=0A>>>=0D=0A>>>=0D=0A>>=C2=A0=0D=0A>>=C2=A0bus-s,=C2=
=A0bus-p=C2=A0is=C2=A0a=C2=A0register=C2=A0that=C2=A0exists=C2=A0in=C2=A0th=
e=C2=A0sysreg=C2=A0of=C2=A0the=C2=A0fsys=C2=A0block.=0D=0A>>=C2=A0It=C2=A0i=
s=C2=A0the=C2=A0same=C2=A0block=C2=A0as=C2=A0=22fsys-sysreg=22=C2=A0but=C2=
=A0is=C2=A0separated=C2=A0separately=C2=A0in=0D=0A>>=C2=A0hardware.=0D=0A>=
=20=0D=0A>=20Two=C2=A0points=C2=A0here:=0D=0A>=201.=C2=A0If=C2=A0it=C2=A0is=
=C2=A0in=C2=A0FSYS,=C2=A0why=C2=A0it=C2=A0cannot=C2=A0be=C2=A0accessed=C2=
=A0with=C2=A0samsung,fsys-sysreg?=0D=0A>=202.=C2=A0If=C2=A0it=C2=A0is=C2=A0=
only=C2=A0register,=C2=A0shuld=C2=A0be=C2=A0described=C2=A0like=C2=A0this.=
=C2=A0You=C2=A0must=0D=0A>=20describe=C2=A0item:=0D=0A>=20https://protect2.=
fireeye.com/v1/url?k=3D0f529a57-50c9a332-0f531118-000babff32e3-50938d819807=
7d59&q=3D1&e=3D32284e69-bbed-4d09-b6d6-0a43428aebf5&u=3Dhttps%3A%2F%2Felixi=
r.bootlin.com%2Flinux%2Fv5.18-rc1%2Fsource%2FDocumentation%2Fdevicetree%2Fb=
indings%2Fsoc%2Fsamsung%2Fexynos-usi.yaml%23L42=0D=0A>=20=0D=0A=0D=0AIt=20w=
ould=20be=20better=20to=20access=20with=20fsys-sysreg,=20but=20their=20h/w=
=20address=20are=0D=0Afar=20from=20each=20other.=20The=20fsys=20block=20con=
sists=20of=20a=20system=20register=20and=20an=0D=0Aadditional=20control=20s=
ystem=20register.=20=22bus-s-fsys=22=20and=20=22bus-p-fsys=22=20are=0D=0Aad=
ditional=20control=20system=20register.=20sysreg=20and=20additional=20contr=
ol=20sysreg=0D=0Aaddresses=20are=20far=20from=20each=20other=20and=20there=
=20are=20h/w=20registers=20that=20perform=0D=0Adifferent=20functions=20betw=
een=20them.=0D=0A=0D=0A>>=C2=A0So,=C2=A0get=C2=A0resource=C2=A0is=C2=A0perf=
ormed=C2=A0separately=C2=A0from=C2=A0=22fsys-sysreg=22.=0D=0A>>=C2=A0They=
=C2=A0set=C2=A0pcie=C2=A0slave,=C2=A0dbi=C2=A0related=C2=A0control=C2=A0set=
tings,=0D=0A>>=C2=A0naming=C2=A0=22bus-x=22=C2=A0seems=C2=A0to=C2=A0be=C2=
=A0interconnect.=0D=0A>>=C2=A0I=C2=A0will=C2=A0add=C2=A0this=C2=A0descripti=
on=C2=A0to=C2=A0property.=0D=0A>>=C2=A0I=C2=A0don't=C2=A0think=C2=A0it=C2=
=A0need=C2=A0to=C2=A0use=C2=A0the=C2=A0interconnect=C2=A0driver,=0D=0A>>=C2=
=A0so=C2=A0please=C2=A0let=C2=A0me=C2=A0know=C2=A0your=C2=A0opinion.=0D=0A>=
=20=0D=0A>=20Please=C2=A0document=C2=A0both=C2=A0in=C2=A0the=C2=A0bindings=
=C2=A0and=C2=A0in=C2=A0the=C2=A0driver=C2=A0usage=C2=A0of=C2=A0this=0D=0A>=
=20register.=C2=A0Writing=C2=A0there=C2=A0=220=22=C2=A0or=C2=A0=221=22=C2=
=A0is=C2=A0not=C2=A0enough.=C2=A0If=C2=A0the=C2=A0documentation=0D=0A>=20is=
=C2=A0good,=C2=A0I=C2=A0am=C2=A0fine=C2=A0with=C2=A0it.=C2=A0If=C2=A0the=C2=
=A0explanation=C2=A0is=C2=A0obfuscated/not=0D=0A>=20sufficient,=C2=A0it=C2=
=A0will=C2=A0look=C2=A0like=C2=A0avoiding=C2=A0to=C2=A0implement=C2=A0a=C2=
=A0driver,=C2=A0which=C2=A0I=0D=0A>=20don't=C2=A0want=C2=A0to=C2=A0accept.=
=0D=0A>=20=0D=0A=0D=0AI=20think=20i=20should=20add=20enough=20description.=
=20Is=20it=20sufficient=20to=20modify=0D=0Athe=20name=20and=20description=
=20of=20property=20like=20this?=0D=0A=0D=0Asamsung,fsys-bus-s:=0D=0A=C2=A0=
=C2=A0description:=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0bus-s=
=C2=A0of=C2=A0fsys=C2=A0block,=20this=20register=0D=0A=20=20=20=20is=20addi=
tional=20control=20sysreg=20in=20fsys=20block=20and=0D=0A=20=20=20=20this=
=20is=C2=A0used=C2=A0for=C2=A0pcie=20slave=20control=20setting.=0D=0A=C2=A0=
=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A=0D=0Asa=
msung,fsys-bus-p:=0D=0A=C2=A0=C2=A0description:=0D=0A=C2=A0=C2=A0=C2=A0=C2=
=A0Phandle=C2=A0to=C2=A0bus-p=C2=A0of=C2=A0fsys=C2=A0block,=C2=A0this=C2=A0=
register=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0is=20additional=20control=20sysreg=20=
in=20fsys=20block=20and=0D=0A=20=20=20=20this=20is=C2=A0used=C2=A0for=C2=A0=
pcie=20dbi=20control=20setting.=0D=0A=C2=A0=C2=A0=24ref:=C2=A0/schemas/type=
s.yaml=23/definitions/phandle=0D=0A=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Kr=
zysztof=0D=0A=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=
=20regards,=0D=0AWangseok=20Lee=0D=0A
