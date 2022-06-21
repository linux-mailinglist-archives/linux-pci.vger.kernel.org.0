Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E07552C43
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbiFUHnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347368AbiFUHm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 03:42:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAB386
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 00:42:52 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220621074246epoutp011b9860d3e6672e769fe769b19b21600e~6ku6vIErD1803418034epoutp01I
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 07:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220621074246epoutp011b9860d3e6672e769fe769b19b21600e~6ku6vIErD1803418034epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655797366;
        bh=5Wqh3PWGBXuZZf5tPfuXfoxWrR7iqc6pEPW9lOat83o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KsNceQLSaP7jTn88AGZlNPJ141AiIN57OO7m4/DqwJ5fYKKldSGxOkto4c3fEn2X4
         SdZQTjJVipteqvM0mGeATXW5lYcCvmXcbe/0LSOTECCujGFGGj1cwb1R6T1gw++dpP
         sHvw/nlhew5BU3nixmp5Ykf3/8B1gCBsKUVMjbmE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220621074245epcas2p29a928aa9c41a3787d7b0a4f9fd2fa4e8~6ku5lLoDA2345923459epcas2p2H;
        Tue, 21 Jun 2022 07:42:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LRz510Qt7z4x9QP; Tue, 21 Jun
        2022 07:42:45 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-78-62b1767498d1
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.D4.09650.47671B26; Tue, 21 Jun 2022 16:42:44 +0900 (KST)
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
In-Reply-To: <f9a877ce-1e18-90f9-67e5-b6e67b3b4156@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220621074244epcms2p23cb631babfb87e5abb416467fb66e521@epcms2p2>
Date:   Tue, 21 Jun 2022 16:42:44 +0900
X-CMS-MailID: 20220621074244epcms2p23cb631babfb87e5abb416467fb66e521
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmqW5J2cYkgwu3LSyWNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem8Xe11vZLRp6frNaHHnzkdli//GV
        TBaXd81hszg77zibxYRV31gs3vx+wW5xbnGmReveI+wWO++cYLb4tfUPk4Oox5p5axg9rq8L
        8FiwqdRj06pONo871/aweTy5Mp3JY/OSeo++LasYPY7f2M7k8XmTXABXVLZNRmpiSmqRQmpe
        cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtB7SgpliTmlQKGAxOJiJX07
        m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjLtb9zMXLImqmDjh
        E1MD44/wLkZODgkBE4mFTzazgthCAjsYJTa/T+5i5ODgFRCU+LtDGCQsLOAlsXbdKxaIEiWJ
        HWvmMUPE9SWur+gGa2UT0JX4t/glWxcjF4eIwGo2iVk7XzCBOMwCCxgl9v/exwixjFdiRvtT
        FghbWmL78q1gcU4BO4k3L/axQsQ1JH4s62WGsEUlbq5+yw5jvz82H2qOiETrvbNQNYISD37u
        hopLSSx4cghqTrXE/r+/mSDsBkaJ/vupII9JAF2947oxSJhXwFdiyaxusFYWAVWJC397oEa6
        SFz8dgTMZhbQlli28DUzSCuzgKbE+l36EFOUJY7cYoF5qmHjb3Z0NrMAn0TH4b9w8R3znkAd
        oyYxb+VO5gmMyrMQAT0Lya5ZCLsWMDKvYhRLLSjOTU8tNiowgkdtcn7uJkZwOtdy28E45e0H
        vUOMTByMhxglOJiVRHhtuDckCfGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MKPklcQbmlga
        mJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgEsi7ubB8H8vvxLnzFm8IT930
        7ntXk7SQZHRx3omXS/y8fP47JSVHBKbtPCil5RjioaLSzmDx0ExNvNhfOG/dEr22T/8iejq3
        totqPb8etVDMMuBQ8scpBlM5s95NVrwkdedP6pWw2jcTC8WXa/ZVVUXdjGm5vOLOtM1TmdgY
        97c8PXa5IOdzwdlDvl4BBd2332090c9j73yJ+bKm86XNhdfbL+mbzPl1eLfGBd75u3d4f7IQ
        V/j19YarWPt+h96W0Eylb7PvC584k5/y+IvQ8TeXcxd/6QuQeXx97Uy7GYlqa79NlN6pfdl5
        qtQ0/rTnDGzz1nnPnz+ho4TpWENcdVFZ3fH6YO11DeyceyLalFiKMxINtZiLihMB5/uKf3AE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <f9a877ce-1e18-90f9-67e5-b6e67b3b4156@linaro.org>
        <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
        <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A020/06/2022=C2=A017:42,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=20On=C2=A020/06/2022=C2=A009:55,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=
=0A>>=C2=A0On=C2=A017/06/2022=C2=A007:54,=C2=A0Krzysztof=C2=A0Kozlowski=C2=
=A0wrote:=0D=0A>>>=C2=A0On=C2=A013/06/2022=C2=A018:27,=C2=A0Wangseok=C2=A0L=
ee=C2=A0wrote:=0D=0A>>>>=C2=A0=C2=A0Add=C2=A0description=C2=A0to=C2=A0suppo=
rt=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>>>=C2=A0=C2=A0ARTPEC-8=C2=A0is=
=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=A0Communications=0D=
=0A>>>>=C2=A0=C2=A0and=C2=A0PCIe=C2=A0controller=C2=A0is=C2=A0designed=C2=
=A0based=C2=A0on=C2=A0Design-Ware=C2=A0PCIe=C2=A0controller.=0D=0A>>>>=C2=
=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<=
wangseok.lee=40samsung.com>=0D=0A>>>>=C2=A0=C2=A0---=0D=0A>>>>=C2=A0=C2=A0v=
2->v3=C2=A0:=0D=0A>>>>=C2=A0=C2=A0-=C2=A0modify=C2=A0version=C2=A0history=
=C2=A0to=C2=A0fit=C2=A0the=C2=A0linux=C2=A0commit=C2=A0rule=0D=0A>>>>=C2=A0=
=C2=A0-=C2=A0remove=C2=A0'Device=C2=A0Tree=C2=A0Bindings'=C2=A0on=C2=A0titl=
e=0D=0A>>>>=C2=A0=C2=A0-=C2=A0remove=C2=A0the=C2=A0interrupt-names,=C2=A0ph=
y-names=C2=A0entries=0D=0A>>>>=C2=A0=C2=A0-=C2=A0remove=C2=A0'_clk'=C2=A0su=
ffix=0D=0A>>>>=C2=A0=C2=A0-=C2=A0add=C2=A0the=C2=A0compatible=C2=A0entries=
=C2=A0on=C2=A0required=0D=0A>>>>=C2=A0=C2=A0-=C2=A0change=C2=A0node=C2=A0na=
me=C2=A0to=C2=A0soc=C2=A0from=C2=A0artpec8=C2=A0on=C2=A0examples=0D=0A>>>>=
=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0v1->v2=C2=A0:=0D=0A>>>>=C2=A0=C2=A0-'make=
=C2=A0dt_binding_check'=C2=A0result=C2=A0improvement=0D=0A>>>>=C2=A0=C2=A0-=
Add=C2=A0the=C2=A0missing=C2=A0property=C2=A0list=0D=0A>>>>=C2=A0=C2=A0-Ali=
gn=C2=A0the=C2=A0indentation=C2=A0of=C2=A0continued=C2=A0lines/entries=0D=
=0A>>>>=C2=A0=C2=A0---=0D=0A>>>>=C2=A0=C2=A0=C2=A0.../bindings/pci/axis,art=
pec8-pcie-ep.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=
=C2=A0109=C2=A0+++++++++++++++++++=0D=0A>>>>=C2=A0=C2=A0=C2=A0.../devicetre=
e/bindings/pci/axis,artpec8-pcie.yaml=C2=A0=7C=C2=A0120=C2=A0++++++++++++++=
+++++++=0D=0A>>>>=C2=A0=C2=A0=C2=A02=C2=A0files=C2=A0changed,=C2=A0229=C2=
=A0insertions(+)=0D=0A>>>>=C2=A0=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=
=A0Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml=0D=0A>>>=
>=C2=A0=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/devicetr=
ee/bindings/pci/axis,artpec8-pcie.yaml=0D=0A>>>>=C2=A0=C2=A0=0D=0A>>>>=C2=
=A0=C2=A0diff=C2=A0--git=C2=A0a/Documentation/devicetree/bindings/pci/axis,=
artpec8-pcie-ep.yaml=C2=A0b/Documentation/devicetree/bindings/pci/axis,artp=
ec8-pcie-ep.yaml=0D=0A>>>>=C2=A0=C2=A0new=C2=A0file=C2=A0mode=C2=A0100644=
=0D=0A>>>>=C2=A0=C2=A0index=C2=A00000000..d802bba=0D=0A>>>>=C2=A0=C2=A0---=
=C2=A0/dev/null=0D=0A>>>>=C2=A0=C2=A0+++=C2=A0b/Documentation/devicetree/bi=
ndings/pci/axis,artpec8-pcie-ep.yaml=0D=0A>>>>=C2=A0=C2=A0=40=40=C2=A0-0,0=
=C2=A0+1,109=C2=A0=40=40=0D=0A>>>>=C2=A0=C2=A0+=23=C2=A0SPDX-License-Identi=
fier:=C2=A0(GPL-2.0-only=C2=A0OR=C2=A0BSD-2-Clause)=0D=0A>>>>=C2=A0=C2=A0+%=
YAML=C2=A01.2=0D=0A>>>>=C2=A0=C2=A0+---=0D=0A>>>>=C2=A0=C2=A0+=24id:=C2=A0h=
ttps://protect2.fireeye.com/v1/url?k=3D87636683-e61e8c00-8762edcc-74fe48600=
158-e7a1c3794076f0b9&q=3D1&e=3D35e09b7f-4fb1-4c8f-83ac-7ec33e124d44&u=3Dhtt=
p%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Faxis%2Cartpec8-pcie-ep.yaml%23=
=0D=0A>>>>=C2=A0=C2=A0+=24schema:=C2=A0https://protect2.fireeye.com/v1/url?=
k=3D36f56c4e-578886cd-36f4e701-74fe48600158-afd7270f84937054&q=3D1&e=3D35e0=
9b7f-4fb1-4c8f-83ac-7ec33e124d44&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-sch=
emas%2Fcore.yaml%23=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+title:=C2=
=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0Controller=0D=0A>>>>=C2=A0=C2=A0+=0D=0A=
>>>>=C2=A0=C2=A0+maintainers:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0Jesp=
er=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.com>=0D=0A>>>>=C2=A0=C2=A0+=0D=
=0A>>>>=C2=A0=C2=A0+description:=C2=A0=7C+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0This=C2=A0PCIe=C2=A0end-point=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=
=C2=A0the=C2=A0Synopsys=C2=A0DesignWare=C2=A0PCIe=C2=A0IP=0D=0A>>>>=C2=A0=
=C2=A0+=C2=A0=C2=A0and=C2=A0thus=C2=A0inherits=C2=A0all=C2=A0the=C2=A0commo=
n=C2=A0properties=C2=A0defined=C2=A0in=C2=A0snps,dw-pcie-ep.yaml.=0D=0A>>>>=
=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+allOf:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0-=C2=A0=24ref:=C2=A0/schemas/pci/snps,dw-pcie-ep.yaml=23=0D=0A>>>>=C2=A0=
=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+properties:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0compatible:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A0ax=
is,artpec8-pcie-ep=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0reg:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>>=C2=
=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0Data=
=C2=A0Bus=C2=A0Interface=C2=A0(DBI)=C2=A0registers.=0D=0A>>>>=C2=A0=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0Data=C2=A0Bus=
=C2=A0Interface=C2=A0(DBI2)=C2=A0registers.=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0address=C2=A0=
space=C2=A0region.=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0reg-names:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>=
>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=0D=
=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0=
dbi2=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const=
:=C2=A0addr_space=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=
interrupts:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=
=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>>>=
=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PIPE=C2=A0clock,=C2=A0u=
sed=C2=A0by=C2=A0the=C2=A0controller=C2=A0to=C2=A0clock=C2=A0the=C2=A0PIPE=
=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0descripti=
on:=C2=A0PCIe=C2=A0dbi=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>>>=C2=
=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=
=C2=A0master=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>>>=C2=A0=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0slav=
e=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=
=A0=C2=A0+=C2=A0=C2=A0clock-names:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0items:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=
=A0const:=C2=A0pipe=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0-=C2=A0const:=C2=A0dbi=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0-=C2=A0const:=C2=A0mstr=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0slv=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=
=C2=A0=C2=A0+=C2=A0=C2=A0phys:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0maxItems:=C2=A01=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0num-lanes:=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=
=0D=0A>>>>=C2=A0=C2=A0+=0D=0A>>>>=C2=A0=C2=A0+required:=0D=0A>>>>=C2=A0=C2=
=A0+=C2=A0=C2=A0-=C2=A0compatible=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0=
reg=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0reg-names=0D=0A>>>>=C2=A0=C2=
=A0+=C2=A0=C2=A0-=C2=A0interrupts=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0=
interrupt-names=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0clocks=0D=0A>>>>=
=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0clock-names=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=
=A0-=C2=A0samsung,fsys-sysreg=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0sams=
ung,syscon-phandle=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,syscon-=
bus-s-fsys=0D=0A>>>>=C2=A0=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,syscon-bus-p-fs=
ys=0D=0A>>>=0D=0A>>>=0D=0A>>>=C2=A0We=C2=A0are=C2=A0making=C2=A0circles...=
=C2=A0This=C2=A0was=C2=A0before=C2=A0and=C2=A0I=C2=A0commented=C2=A0already=
=C2=A0it=C2=A0is=0D=0A>>>=C2=A0wrong.=C2=A0You=C2=A0cannot=C2=A0have=C2=A0s=
ome=C2=A0unknown/random=C2=A0properties=C2=A0in=C2=A0=22required:=22=0D=0A>=
>>=C2=A0without=C2=A0describing=C2=A0them=C2=A0in=C2=A0=22properties:=22.=
=C2=A0Please=C2=A0list=C2=A0all=C2=A0your=0D=0A>>>=C2=A0properties=C2=A0in=
=C2=A0=22properties:=22,=C2=A0except=C2=A0the=C2=A0ones=C2=A0coming=C2=A0fr=
om=C2=A0snps=0D=0A>>>=C2=A0bindings/schema.=0D=0A>>>=0D=0A>>=C2=A0=0D=0A>>=
=C2=A0I=C2=A0missed=C2=A0that=C2=A0when=C2=A0adding=C2=A0new=C2=A0items=C2=
=A0to=C2=A0=22required=22,=0D=0A>>=C2=A0it=C2=A0should=C2=A0also=C2=A0be=C2=
=A0added=C2=A0to=C2=A0=22properties=22.=0D=0A>>=C2=A0I=C2=A0will=C2=A0add=
=C2=A0the=C2=A0following=C2=A0items=C2=A0to=C2=A0the=C2=A0property.=0D=0A>>=
=C2=A0=0D=0A>>=C2=A0samsung,fsys-sysreg:=0D=0A>>=C2=A0=C2=A0=C2=A0descripti=
on:=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0system=C2=A0r=
egister=C2=A0of=C2=A0fsys=C2=A0block.=0D=0A>>=C2=A0=C2=A0=C2=A0=24ref:=C2=
=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>=20=0D=0A>=20This=C2=A0=
is=C2=A0ok.=0D=0A>=20=0D=0A>>=C2=A0=0D=0A>>=C2=A0samsung,syscon-phandle:=0D=
=0A>>=C2=A0=C2=A0=C2=A0description:=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Ph=
andle=C2=A0to=C2=A0the=C2=A0PMU=C2=A0system=C2=A0controller=C2=A0node.=0D=
=0A>>=C2=A0=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phan=
dle=0D=0A>=20=0D=0A>=20This=C2=A0is=C2=A0ok.=0D=0A>=20=0D=0A>>=C2=A0=0D=0A>=
>=C2=A0samsung,syscon-bus-s-fsys:=0D=0A>>=C2=A0=C2=A0=C2=A0description:=0D=
=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0bus-s=C2=A0path=C2=
=A0of=C2=A0fsys=C2=A0block,=C2=A0this=C2=A0register=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0are=C2=A0used=C2=A0for=C2=A0enabling=C2=A0bus-s.=0D=0A>>=C2=
=A0=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0samsung,syscon-bus-p-fsys:=0D=0A>>=C2=A0=C2=A0=C2=
=A0description:=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Phandle=C2=A0to=C2=A0b=
us-p=C2=A0path=C2=A0of=C2=A0fsys=C2=A0block,=C2=A0this=C2=A0register=0D=0A>=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0are=C2=A0used=C2=A0for=C2=A0enabling=C2=A0bu=
s-p.=0D=0A>>=C2=A0=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitio=
ns/phandle=0D=0A>=20=0D=0A>=20This=C2=A0two=C2=A0look=C2=A0unspecific=C2=A0=
and=C2=A0hacky=C2=A0workaround=C2=A0for=C2=A0missing=C2=A0drivers.=C2=A0Loo=
ks=0D=0A>=20like=C2=A0instead=C2=A0of=C2=A0implementing=C2=A0interconnect=
=C2=A0or=C2=A0clock=C2=A0driver,=C2=A0you=C2=A0decided=0D=0A>=20to=C2=A0pok=
e=C2=A0some=C2=A0other=C2=A0registers.=C2=A0Why=C2=A0this=C2=A0cannot=C2=A0=
be=C2=A0an=C2=A0interconnect=C2=A0driver?=0D=0A>=20=0D=0A>=20=0D=0A=0D=0Abu=
s-s,=20bus-p=20is=20a=20register=20that=20exists=20in=20the=20sysreg=20of=
=20the=20fsys=20block.=0D=0AIt=20is=20the=20same=20block=20as=20=22fsys-sys=
reg=22=20but=20is=20separated=20separately=20in=0D=0Ahardware.=0D=0ASo,=20g=
et=20resource=20is=20performed=20separately=20from=20=22fsys-sysreg=22.=0D=
=0AThey=20set=20pcie=20slave,=20dbi=20related=20control=20settings,=0D=0Ana=
ming=20=22bus-x=22=20seems=20to=20be=20interconnect.=0D=0AI=20will=20add=20=
this=20description=20to=20property.=0D=0AI=20don't=20think=20it=20need=20to=
=20use=20the=20interconnect=20driver,=0D=0Aso=20please=20let=20me=20know=20=
your=20opinion.=0D=0A=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=
=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20regards,=0D=
=0AWangseok=20Lee
