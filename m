Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673EC5421B0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiFHGBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiFHFut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 01:50:49 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8820C6DE
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 20:30:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220608033025epoutp04d6843fc3c5474b2e006d4a6cd237c1ef~2h53iLyKz0605306053epoutp04x
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:30:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220608033025epoutp04d6843fc3c5474b2e006d4a6cd237c1ef~2h53iLyKz0605306053epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654659025;
        bh=guH8loHJxxbGUUwZG4XzfpB4NPSIv0UYz2OMW4d7Gvc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ceJMBmjVNIG28HHI7cjGQNgrt/Khgj/T5siC4axjYJ96rpdPSjgjg9HUykpw7j0uI
         ga09fKaQLgiSsV37ynQkHreVynpHn1XOvzU8Jxepi3/fZwP1WXmQ8Dp0hcBARGkjn6
         XkFhz7JTqjpL/Q5+YFUKpMDWt6muwN0/rjNQ3tqY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220608033024epcas2p31aed9e5e988b727bc7e7078b168ebbdd~2h52naSmc0952709527epcas2p3z;
        Wed,  8 Jun 2022 03:30:24 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LHt5q0F4mz4x9QF; Wed,  8 Jun
        2022 03:30:23 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-69-62a017cedbbb
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.CE.10069.EC710A26; Wed,  8 Jun 2022 12:30:22 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <0ad94a8f-eec7-ab76-3b2d-99d4d3fbf21b@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220608033022epcms2p8874fe3a5c8c56bfe85e8e8fb0261efca@epcms2p8>
Date:   Wed, 08 Jun 2022 12:30:22 +0900
X-CMS-MailID: 20220608033022epcms2p8874fe3a5c8c56bfe85e8e8fb0261efca
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA11Te0xTZxzdvV9fwGouFfVbXRxeghHKo7cD+rGAg6FLdTMimDi3LHgtd4CU
        26YtOjFxDaNzMlDMgrBuK7AqaEEKDEaFMZPCYAnSzcmEOV5RUBAfczM4oJi1tOiy/05Ofuf8
        zvkeAiCa4okFOaye0bK0iuT5c77rDkORznXVB6QOezw6W5iNZhxhqKrHyUWdlXU4+qL8CkB3
        HCaA/ioKRb9MlfDQjGmMh7pm2/jIULLIRT33HgF0ue8Cjq51fMVDA+Y+HiqzznHQvcVpPnJa
        cpCxq4ePLo38BNBI9wAHLbS58KS1igZzA6YYakxVVLfkK1qsJ3iKkevf8xSTgxW44tuzHylO
        tloxRd9wO674u2VDqv+7uQnZDJ3JaIMZVqnOzGGzEsm30jNSMmLjpFQkFY/kZDBL5zGJ5Na3
        UyPfzFG5O5LBh2hVvptKpXU6MnpLgladr2eCs9U6fSLJaDJVGrkmSkfn6fLZrCiW0b9GSaWy
        WPfg/txsi6WIr5lrwT58YGkDBqy2ESvG/ASQiIGlTZX8YsxfICLsGHRNmPBiTCAQEoFwyb7a
        M7Oa2AHLhx/jHiwiSGhvMAMvHw2Hzn/G9WAeEQmfWmZ4Hp8gohHAzuGLy6aA6OHAkeNP+N5t
        Qlh5fIrjxethe13bcgo/Ygusma7hevnN8J/aUuDFa+Dv9ff5K/hhb5UvdRA0jg34ZgLhxHyn
        jxfD6kmHz+covLy0iHuxAYOnxhlPMehObR961UMLiZ2w1ty3HIdDhEJjcYUv2la4ODi6LAWE
        BNbWzAKPFBBh0NYR7XUJgT03OCulDM2L/P9jQKyCn3YvPePt5klfmE3QfOESKMNCTM8P2vSf
        Xabnu6oxYMXWMhpdXhajk2moZ7erVOe1YMvvPXybHfv8/p9RDgwXYA4MCgAZJHxpb9UBkTCT
        PlLAaNUZ2nwVo3Ngse6Wp4F4jVLt/jCsPoOKiZfGxMVRclmsVE6uE+7IbKJFRBatZ3IZRsNo
        V3S4wE9swFv3266c2275oOTj3yruTHQNpqal+626HnZEkj7y8jdE681XAo7VjLlct3ptw49k
        GbY9nySMFilLTK4NAfM/fp1LyULgkDV9gH9Ge03V3lZ/pjACHTxpbDp/6wHnh7tjsVffeb/g
        EHE6TDIbdy6idS/lZIK+VIb+uk/8R6BlqvRmuHUTlbYQDMuTnD+P14GUwGntDfZJMre9YufF
        6LldR7nSF16/eywc7eIULNQvJUnE7D6JY3RCFLDnsIu6KptxRq0H/casjm3Dp572px0cHO/f
        XJjSnPy4/rDfbYGkZsG6e0KJTjhab0tn1L1lzQ/b522hu+Xbk+Th71W88eLG5AjWQHJ02TQV
        DrQ6+l+nvOhReAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <0ad94a8f-eec7-ab76-3b2d-99d4d3fbf21b@linaro.org>
        <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
        <20220603022353epcms2p5d83a4a7d95584ce6a65a63356cd46e76@epcms2p5>
        <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p8>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A006/06/2022=C2=A019:12,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=C2=A0On=C2=A003/06/2022=C2=A004:23,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=
=0D=0A>>=C2=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ART=
PEC-8=C2=A0SoC.=0D=0A>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platfo=
rm=C2=A0of=C2=A0Axis=C2=A0Communications=0D=0A>>=C2=A0and=C2=A0PCIe=C2=A0co=
ntroller=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0Design-Ware=C2=A0PCI=
e=C2=A0controller.=0D=0A>>=C2=A0=0D=0A>>=C2=A0changes=C2=A0since=C2=A0v1=C2=
=A0:=0D=0A>=C2=A0=0D=0A>=C2=A0Changelog=C2=A0goes=C2=A0after=C2=A0---=C2=A0=
.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0i=C2=A0check=C2=A0the=C2=A0linux=
=C2=A0commit=C2=A0style.=0D=0AI=C2=A0will=C2=A0fix=C2=A0it.=0D=0A=C2=A0=0D=
=0A>>=C2=A0-'make=C2=A0dt_binding_check'=C2=A0result=C2=A0improvement=0D=0A=
>>=C2=A0-Add=C2=A0the=C2=A0missing=C2=A0property=C2=A0list=0D=0A>>=C2=A0-Al=
ign=C2=A0the=C2=A0indentation=C2=A0of=C2=A0continued=C2=A0lines/entries=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<wangse=
ok.lee=40samsung.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0.../bindings/pci/=
axis,artpec8-pcie-ep.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=7C=C2=A0108=C2=A0++++++++++++++++++=0D=0A>>=C2=A0=C2=A0.../devicetre=
e/bindings/pci/axis,artpec8-pcie.yaml=C2=A0=7C=C2=A0123=C2=A0++++++++++++++=
+++++++=0D=0A>>=C2=A0=C2=A02=C2=A0files=C2=A0changed,=C2=A0231=C2=A0inserti=
ons(+)=0D=0A>>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/d=
evicetree/bindings/pci/axis,artpec8-pcie-ep.yaml=0D=0A>>=C2=A0=C2=A0create=
=C2=A0mode=C2=A0100644=C2=A0Documentation/devicetree/bindings/pci/axis,artp=
ec8-pcie.yaml=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/Documentati=
on/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml=C2=A0b/Documentation/d=
evicetree/bindings/pci/axis,artpec8-pcie-ep.yaml=0D=0A>>=C2=A0new=C2=A0file=
=C2=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..3512e38=0D=0A>>=C2=
=A0---=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/Documentation/devicetree/bind=
ings/pci/axis,artpec8-pcie-ep.yaml=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,10=
8=C2=A0=40=40=0D=0A>>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0(GPL-2.0=
-only=C2=A0OR=C2=A0BSD-2-Clause)=0D=0A>>=C2=A0+%YAML=C2=A01.2=0D=0A>>=C2=A0=
+---=0D=0A>>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3D6948=
615e-08c37447-6949ea11-74fe485cbfec-fea93affd4665d88&q=3D1&e=3D501044d4-19c=
b-42be-bca2-b59852a39c26&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2F=
axis%2Cartpec8-pcie-ep.yaml%23=0D=0A>>=C2=A0+=24schema:=C2=A0https://protec=
t2.fireeye.com/v1/url?k=3D629fe254-0314f74d-629e691b-74fe485cbfec-f3d83f3fc=
a174eef&q=3D1&e=3D501044d4-19cb-42be-bca2-b59852a39c26&u=3Dhttp%3A%2F%2Fdev=
icetree.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+titl=
e:=C2=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0Controller=C2=A0Device=C2=A0Tree=
=C2=A0Bindings=0D=0A>=C2=A0=0D=0A>=C2=A0s/Device=C2=A0Tree=C2=A0Bindings//=
=0D=0A>=0D=0A=C2=A0=0D=0AI=C2=A0will=C2=A0remove=C2=A0it.=0D=0A=C2=A0=0D=0A=
>>=C2=A0+=0D=0A>>=C2=A0+maintainers:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0Jespe=
r=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.com>=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+description:=C2=A0=7C+=0D=0A>>=C2=A0+=C2=A0=C2=A0This=C2=A0PCIe=C2=A0en=
d-point=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=C2=A0the=C2=A0Synopsys=
=C2=A0DesignWare=C2=A0PCIe=C2=A0IP=0D=0A>>=C2=A0+=C2=A0=C2=A0and=C2=A0thus=
=C2=A0inherits=C2=A0all=C2=A0the=C2=A0common=C2=A0properties=C2=A0defined=
=C2=A0in=C2=A0snps,dw-pcie-ep.yaml.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+allOf:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=24ref:=C2=A0/schemas/pci/snps,dw-pcie-ep.ya=
ml=23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+properties:=0D=0A>>=C2=A0+=C2=A0=C2=A0co=
mpatible:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A0axis,artpec8-pc=
ie-ep=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0reg:=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0description:=C2=A0Data=C2=A0Bus=C2=A0Interface=C2=A0(DBI)=C2=A0regist=
ers.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=
=C2=A0Data=C2=A0Bus=C2=A0Interface=C2=A0(DBI2)=C2=A0registers.=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0=
address=C2=A0space=C2=A0region.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0re=
g-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi2=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0addr_space=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+=C2=A0=C2=A0interrupts:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0maxItems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0interrupts-nam=
es:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0intr=0D=0A>=C2=A0=0D=0A>=C2=A0Re=
move=C2=A0the=C2=A0interrupts-names=C2=A0entirely,=C2=A0no=C2=A0need=C2=A0f=
or=C2=A0single=C2=A0item=C2=A0with=0D=0A>=C2=A0generic=C2=A0name.=0D=0A>=C2=
=A0=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AI=C2=A0will=C2=A0remove=C2=A0it.=0D=0A=C2=
=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0description:=C2=A0PIPE=C2=A0clock,=C2=A0used=C2=A0by=C2=A0the=C2=A0co=
ntroller=C2=A0to=C2=A0clock=C2=A0the=C2=A0PIPE=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0dbi=C2=A0clock,=
=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0-=C2=A0description:=C2=A0PCIe=C2=A0master=C2=A0clock,=C2=A0ungated=C2=A0=
version=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0descriptio=
n:=C2=A0PCIe=C2=A0slave=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0=
+=0D=0A>>=C2=A0+=C2=A0=C2=A0clock-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const=
:=C2=A0pipe_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0co=
nst:=C2=A0dbi_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=
const:=C2=A0mstr_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=
=A0const:=C2=A0slv_clk=0D=0A>=C2=A0=C2=A0=0D=0A>=C2=A0Remove=C2=A0=22_clk=
=22=C2=A0suffix=C2=A0from=C2=A0all=C2=A0entries.=0D=0A>=C2=A0=0D=0A=C2=A0=
=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0phys:=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+=C2=A0=C2=A0phy-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pcie_phy=
=0D=0A>=C2=A0=0D=0A>=C2=A0Remove=C2=A0the=C2=A0phy-names=C2=A0entirely,=C2=
=A0no=C2=A0need=C2=A0for=C2=A0single=C2=A0item=C2=A0with=C2=A0generic=C2=A0=
name.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+=C2=A0=C2=A0num-lanes:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=
=C2=A02=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+required:=0D=0A>=C2=A0=0D=0A>=C2=A0My=
=C2=A0comment=C2=A0was=C2=A0not=C2=A0applied=C2=A0here,=C2=A0so=C2=A0please=
=C2=A0fix=C2=A0it.=0D=0A>=C2=A0=C2=A0=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=
=A0i=C2=A0miss=C2=A0compatible..=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0reg=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg-names=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0interrupts=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0interrupt-names=0D=0A=
>>=C2=A0+=C2=A0=C2=A0-=C2=A0clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clock-n=
ames=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0phys=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0num-lanes=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+unevaluatedProperties:=C2=A0false=
=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+examples:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=
=7C=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=23include=C2=A0<dt-bindings/inte=
rrupt-controller/irq.h>=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=23include=C2=
=A0<dt-bindings/interrupt-controller/arm-gic.h>=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0artpec8=C2=A0=7B=0D=0A>=C2=A0=0D=0A>=C2=A0Gener=
ic=C2=A0nodes=C2=A0please.=C2=A0Did=C2=A0you=C2=A0see=C2=A0=22artpec8=22=C2=
=A0or=C2=A0something=C2=A0like=C2=A0this=C2=A0in=0D=0A>=C2=A0any=C2=A0DTS?=
=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0i=C2=A0will=C2=A0modify=C2=A0to=C2=
=A0'soc'.=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=23address-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=23size-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_ep:=C2=A0pcie-e=
p=4017200000=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible=C2=A0=3D=C2=A0=22axis,artpec8-p=
cie-ep=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg=C2=A0=3D=C2=A0<0x0=C2=A00x17200000=C2=A00x0=C2=
=A00x1000>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x0=C2=A00x172=
01000=C2=A00x0=C2=A00x1000>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<0x2=C2=A00x00000000=C2=A00x6=C2=A00x00000000>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg-names=C2=
=A0=3D=C2=A0=22dbi=22,=C2=A0=22dbi2=22,=C2=A0=22addr_space=22;=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=23interrupt-cells=C2=A0=3D=C2=A0<1>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts=C2=A0=3D=
=C2=A0<GIC_SPI=C2=A0115=C2=A0IRQ_TYPE_LEVEL_HIGH>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-na=
mes=C2=A0=3D=C2=A0=22intr=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clocks=C2=A0=3D=C2=A0<&clock_cmu_=
fsys=C2=A039>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<&clock_cmu_fsys=C2=A038>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<&clock_cmu_fsys=C2=A037>,=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&clock_cmu_fsys=C2=A036>;=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0clock-names=C2=A0=3D=C2=A0=22pipe_clk=22,=C2=A0=22dbi_clk=22,=C2=A0=
=22mstr_clk=22,=C2=A0=22slv_clk=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys=C2=A0=3D=C2=A0<&pcie_p=
hy>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0phy-names=C2=A0=3D=C2=A0=22pcie_phy=22;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0num-la=
nes=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-range=C2=A0=3D=C2=A0<0x00=C2=A00xff=
>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0num-ib-windows=C2=A0=3D=C2=A0<16>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0num-ob-windo=
ws=C2=A0=3D=C2=A0<16>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=7D;=0D=0A>=C2=A0=0D=
=0A>=C2=A0=0D=0A>>=C2=A0+...=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/Documentat=
ion/devicetree/bindings/pci/axis,artpec8-pcie.yaml=C2=A0b/Documentation/dev=
icetree/bindings/pci/axis,artpec8-pcie.yaml=0D=0A>>=C2=A0new=C2=A0file=C2=
=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..945a061=0D=0A>>=C2=A0-=
--=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/Documentation/devicetree/bindings=
/pci/axis,artpec8-pcie.yaml=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,123=C2=A0=
=40=40=0D=0A>>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0(GPL-2.0-only=
=C2=A0OR=C2=A0BSD-2-Clause)=0D=0A>>=C2=A0+%YAML=C2=A01.2=0D=0A>>=C2=A0+---=
=0D=0A>>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3D1de15b04=
-7c6a4e1d-1de0d04b-74fe485cbfec-aaaa8e4e3891e6f9&q=3D1&e=3D501044d4-19cb-42=
be-bca2-b59852a39c26&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Faxis=
%2Cartpec8-pcie.yaml%23=0D=0A>>=C2=A0+=24schema:=C2=A0https://protect2.fire=
eye.com/v1/url?k=3D66c233a3-074926ba-66c3b8ec-74fe485cbfec-9eadff8200c7df97=
&q=3D1&e=3D501044d4-19cb-42be-bca2-b59852a39c26&u=3Dhttp%3A%2F%2Fdevicetree=
.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+title:=C2=
=A0Artpec-8=C2=A0SoC=C2=A0PCIe=C2=A0Controller=C2=A0Device=C2=A0Tree=C2=A0B=
indings=0D=0A>=C2=A0=0D=0A>=C2=A0Ditto=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=
=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+maintainers:=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.com>=0D=0A>>=C2=
=A0+=0D=0A>>=C2=A0+description:=C2=A0=7C+=0D=0A>>=C2=A0+=C2=A0=C2=A0This=C2=
=A0PCIe=C2=A0host=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=C2=A0the=C2=A0=
Synopsys=C2=A0DesignWare=C2=A0PCIe=C2=A0IP=0D=0A>>=C2=A0+=C2=A0=C2=A0and=C2=
=A0thus=C2=A0inherits=C2=A0all=C2=A0the=C2=A0common=C2=A0properties=C2=A0de=
fined=C2=A0in=C2=A0snps,dw-pcie.yaml.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+allOf:=
=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=24ref:=C2=A0/schemas/pci/snps,dw-pcie.ya=
ml=23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+properties:=0D=0A>>=C2=A0+=C2=A0=C2=A0co=
mpatible:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A0axis,artpec8-pc=
ie=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0reg:=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=
=A0description:=C2=A0Data=C2=A0Bus=C2=A0Interface=C2=A0(DBI)=C2=A0registers=
.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=
=A0External=C2=A0Local=C2=A0Bus=C2=A0interface=C2=A0(ELBI)=C2=A0registers.=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=
=A0PCIe=C2=A0configuration=C2=A0space=C2=A0region.=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+=C2=A0=C2=A0reg-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0elbi=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0confi=
g=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0device_type:=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>=C2=A0=0D=0A>=C2=A0It's=C2=A0not=C2=A0a=
=C2=A0list,=C2=A0but=C2=A0just=C2=A0a=C2=A0string.=C2=A0No=C2=A0need=C2=A0f=
or=C2=A0items.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pci=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+=C2=A0=C2=A0ranges:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0ma=
xItems:=C2=A02=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0num-lanes:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=
=C2=A0=C2=A0interrupts:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=
=A01=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0interrupts-names:=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0-=C2=A0const:=C2=A0intr=0D=0A>=C2=A0=0D=0A>=C2=A0Remove=C2=A0en=
tire=C2=A0property.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=
=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0descr=
iption:=C2=A0PIPE=C2=A0clock,=C2=A0used=C2=A0by=C2=A0the=C2=A0controller=C2=
=A0to=C2=A0clock=C2=A0the=C2=A0PIPE=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0dbi=C2=A0clock,=C2=A0ungated=
=C2=A0version=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0desc=
ription:=C2=A0PCIe=C2=A0master=C2=A0clock,=C2=A0=C2=A0ungated=C2=A0version=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=
=A0PCIe=C2=A0slave=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0+=0D=
=0A>>=C2=A0+=C2=A0=C2=A0clock-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=
=A0pipe_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=
=C2=A0dbi_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0cons=
t:=C2=A0mstr_clk=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0c=
onst:=C2=A0slv_clk=0D=0A>=C2=A0=0D=0A>=C2=A0Remove=C2=A0suffix.=0D=0A>=C2=
=A0=0D=0A=0D=0AOk.=0D=0A=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0phys:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+=C2=A0=C2=A0phy-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pcie_=
phy=0D=0A>=C2=A0=0D=0A>=C2=A0Remove=C2=A0entire=C2=A0property.=0D=0A>=C2=A0=
=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+required:=0D=
=0A>=C2=A0=0D=0A>=C2=A0Previous=C2=A0comment=C2=A0not=C2=A0applied.=0D=0A>=
=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0re=
g=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0device_type=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0ranges=0D=0A>>=C2=A0+=C2=A0=
=C2=A0-=C2=A0num-lanes=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0interrupts=0D=0A>>=
=C2=A0+=C2=A0=C2=A0-=C2=A0interrupt-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=
clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clock-names=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0phys=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0phy-names=0D=0A>>=C2=A0+=0D=
=0A>>=C2=A0+unevaluatedProperties:=C2=A0false=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=
examples:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=7C=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=23include=C2=A0<dt-bindings/interrupt-controller/irq.h>=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=23include=C2=A0<dt-bindings/interrupt-cont=
roller/arm-gic.h>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0artp=
ec8=C2=A0=7B=0D=0A>=C2=A0=0D=0A>=C2=A0Same=C2=A0as=C2=A0previous=C2=A0patch=
.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AI=C2=A0will=C2=A0modify=C2=A0to=C2=A0'soc'.=
=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=23address-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=23size-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie:=C2=A0pcie=4017200000=C2=
=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0compatible=C2=A0=3D=C2=A0=22axis,artpec8-pcie=22;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0reg=C2=A0=3D=C2=A0<0x0=C2=A00x17200000=C2=A00x0=C2=A00x1000>,=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x0=C2=A00x16ca0000=C2=A00x0=C2=
=A00x2000>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x7=C2=A00x000=
1e000=C2=A00x0=C2=A00x2000>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg-names=C2=A0=3D=C2=A0=22dbi=22=
,=C2=A0=22elbi=22,=C2=A0=22config=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=23address-cells=C2=A0=
=3D=C2=A0<3>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=23size-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
ice_type=C2=A0=3D=C2=A0=22pci=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ranges=C2=A0=3D=C2=A0</*=C2=A0=
non-prefetchable=C2=A0memory=C2=A0*/=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x83000000=C2=A00x0=C2=A00x0000000=C2=A00x=
2=C2=A00x00000000=C2=A00x5=C2=A00x00000000=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0downstream=C2=A0I/O=C2=A0*/=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x8=
1000000=C2=A00x0=C2=A00x0000000=C2=A00x7=C2=A00x00000000=C2=A00x0=C2=A00x00=
010000>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0num-lanes=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-range=C2=
=A0=3D=C2=A0<0x00=C2=A00xff>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts=C2=A0=3D=C2=A0<GIC_SPI=
=C2=A0115=C2=A0IRQ_TYPE_LEVEL_HIGH>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names=C2=A0=3D=C2=
=A0=22intr=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=23interrupt-cells=C2=A0=3D=C2=A0<1>;=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0clocks=C2=A0=3D=C2=A0<&cmu_fsys=C2=A039>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&cmu_fsys=C2=A038>,=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&cmu_fsys=C2=A037>,=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&cmu_fsys=C2=
=A036>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0clock-names=C2=A0=3D=C2=A0=22pipe_clk=22,=C2=A0=22dbi_=
clk=22,=C2=A0=22mstr_clk=22,=C2=A0=22slv_clk=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys=C2=A0=3D=
=C2=A0<&pcie_phy>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy-names=C2=A0=3D=C2=A0=22pcie_phy=22;=0D=0A=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+...=0D=0A>=C2=A0=0D=0A>=C2=A0=
=0D=0A>=C2=A0Best=C2=A0regards,=0D=0A>=C2=A0Krzysztof=0D=0A=0D=0AThank=20yo=
u=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20regards,=0D=0AWangseok=20Lee
