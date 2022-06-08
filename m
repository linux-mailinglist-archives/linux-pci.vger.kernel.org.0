Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24045421C8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiFHGBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 02:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiFHFvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 01:51:10 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE101ACE58
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 20:30:44 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220608033043epoutp027128558bdfaa099fb41fdd52dcf1d545~2h6IJT8zk0532305323epoutp02Q
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:30:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220608033043epoutp027128558bdfaa099fb41fdd52dcf1d545~2h6IJT8zk0532305323epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654659043;
        bh=svUnNcvZi8FnB/eO2kX+puEXSJbtaaVEi8Nbh0KTMmw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iR6WGEBciq5CM+3mCwZaRaFf/60z2JEB7pKrhNEuGuJqovdQpYwJYazso+vO1TpB1
         5RzElJ04GcM/4VT6lG+9LfMKaVf3uW9LBX7A3rkx8Fa1KBnXwztS9IMISNmhniOZZm
         SVGl2SIZk1bNXAQ2fSytBubHzydiBT4SkOVfut/c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220608033042epcas2p3f91c1864435e7c11cce0b8953655c6b9~2h6Hg0tKA0952709527epcas2p3a;
        Wed,  8 Jun 2022 03:30:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LHt6872Lzz4x9Q7; Wed,  8 Jun
        2022 03:30:40 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-4e-62a017e02523
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.6C.09764.0E710A26; Wed,  8 Jun 2022 12:30:40 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
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
In-Reply-To: <45aa26be-625e-47eb-c21f-92497e60b6dd@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220608033040epcms2p5807e0bf6528ba9f6b24863e9f2244c84@epcms2p5>
Date:   Wed, 08 Jun 2022 12:30:40 +0900
X-CMS-MailID: 20220608033040epcms2p5807e0bf6528ba9f6b24863e9f2244c84
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmme4D8QVJBj8WmFssacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9Nou9r7eyWzT0/Ga1OPLmI7PF/uMr
        mSwu75rDZnF23nE2iwmrvrFYvPn9gt3i3OJMi9a9R9gtdt45wWxx5/BZFotfW/8wOYh5rJm3
        htHj+roAjwWbSj02repk87hzbQ+bx5Mr05k8Ni+p9+jbsorR4/iN7UwenzfJBXBFZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAP2opFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmDKplb3g
        pFXFj7mzWRsY2y27GDk5JARMJP7ce8bexcjFISSwg1Hi0o+zQA4HB6+AoMTfHcIgprCAs0TL
        0mCQciEBJYkda+Yxg9jCAvoS11d0s4LYbAK6Ev8Wv2QDGSMisI5ZYveNtWAzmQWOsEjcaf/O
        DrGMV2JG+1MWCFtaYvvyrYwgNqeAncT1kz+hajQkfizrZYawRSVurn7LDmO/PzafEcIWkWi9
        dxaqRlDiwc/dUHEpiQVPDrFC2NUS+//+ZoKwGxgl+u+ngjwjAXT1juvGIGFeAV+JrXtmgZWz
        CKhK3J9zHOo0F4nL9z+CjWQW0JZYtvA1M0grs4CmxPpd+hBTlCWO3GKBeaph4292dDazAJ9E
        x+G/cPEd855AHaMmMW/lTuYJjMqzEOE8C8muWQi7FjAyr2IUSy0ozk1PLTYqMIJHbXJ+7iZG
        cGLXctvBOOXtB71DjEwcjIcYJTiYlUR4JcPnJwnxpiRWVqUW5ccXleakFh9iNAX6ciKzlGhy
        PjC35JXEG5pYGpiYmRmaG5kamCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYJKNO8X9R6qu
        xP8Zg/C3J7Ok/ePWPthdK/LZZ0Fd0uUdmyJ0dBuXelm5Fivb6H7KeaTcKHBoStmko02/HGWt
        hIVWPgl1SrWoeKK/OsFuBUfBCf2ZCaaiOeZnp5z3WrOwmF1LmEkq5nvjJe0Zfj5ruK+wWBjW
        ryp6pXuyMObT3mOVahMvXGoXXajFnTTxVlT3pEf7iy9/9d26TWNFZ0CAyQ6j5W0hnTrT+dtj
        lKojf7lG+m66sXj3XO/bLss2zubt0A5Z+PCnS0+DoMi5hrpK5RiTXXXXJFyvRxrwXFyW9DJ3
        5Qbbq0+4tzsFfT3qd7S4+s+tj0+Xe5dmijVPVrCtPDvbxYPfbOqvjYt/lWyTUGIpzkg01GIu
        Kk4EAOS03Zx1BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <45aa26be-625e-47eb-c21f-92497e60b6dd@linaro.org>
        <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
        <20220603023158epcms2p6949f6cd93926b9e811e1b4d52fbef91b@epcms2p6>
        <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p5>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A006/06/2022=C2=A019:16,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=C2=A0On=C2=A003/06/2022=C2=A004:31,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=
=0D=0A>>=C2=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ART=
PEC-8=C2=A0SoC.=0D=0A>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platfo=
rm=C2=A0of=C2=A0Axis=C2=A0Communications=0D=0A>>=C2=A0and=C2=A0PCIe=C2=A0ph=
y=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY.=0D=0A>=C2=
=A0=0D=0A>=C2=A0This=C2=A0does=C2=A0not=C2=A0look=C2=A0like=C2=A0wrapped=C2=
=A0in=C2=A0Linux=C2=A0commit=C2=A0style.=0D=0A>=C2=A0https://protect2.firee=
ye.com/v1/url?k=3Dc73ae309-a6470b4e-c73b6846-74fe485fff30-d00b7249c2c0a970&=
q=3D1&e=3Db8b33895-af3d-42ce-80ac-4835057078e7&u=3Dhttps%3A%2F%2Felixir.boo=
tlin.com%2Flinux%2Fv5.18-rc4%2Fsource%2FDocumentation%2Fprocess%2Fsubmittin=
g-patches.rst%23L586=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0i=C2=A0will=C2=
=A0fix=C2=A0it.=0D=0A=C2=A0=0D=0A>>=C2=A0=0D=0A>>=C2=A0changes=C2=A0since=
=C2=A0v1=C2=A0:=0D=0A>>=C2=A0-'make=C2=A0dt_binding_check'=C2=A0result=C2=
=A0improvement=0D=0A>>=C2=A0-Add=C2=A0the=C2=A0missing=C2=A0property=C2=A0l=
ist=0D=0A>>=C2=A0-Align=C2=A0the=C2=A0indentation=C2=A0of=C2=A0continued=C2=
=A0lines/entries=0D=0A>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=
=A0Lee=C2=A0<wangseok.lee=40samsung.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=
=A0.../bindings/phy/axis,artpec8-pcie-phy.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=7C=C2=A070=C2=A0++++++++++++++++++++++=0D=0A>>=C2=A0=
=C2=A01=C2=A0file=C2=A0changed,=C2=A070=C2=A0insertions(+)=0D=0A>>=C2=A0=C2=
=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/devicetree/bindings/phy/=
axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0=
a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml=C2=A0b/D=
ocumentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=
=A0new=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..ab9=
766f=0D=0A>>=C2=A0---=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/Documentation/=
devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=A0=40=40=C2=
=A0-0,0=C2=A0+1,70=C2=A0=40=40=0D=0A>>=C2=A0+=23=C2=A0SPDX-License-Identifi=
er:=C2=A0GPL-2.0-only=C2=A0OR=C2=A0BSD-2-Clause=0D=0A>>=C2=A0+%YAML=C2=A01.=
2=0D=0A>>=C2=A0+---=0D=0A>>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/=
v1/url?k=3D8784225c-e6f9ca1b-8785a913-74fe485fff30-b4af51b9b3670f43&q=3D1&e=
=3Db8b33895-af3d-42ce-80ac-4835057078e7&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fs=
chemas%2Fphy%2Faxis%2Cartpec8-pcie-phy.yaml%23=0D=0A>>=C2=A0+=24schema:=C2=
=A0https://protect2.fireeye.com/v1/url?k=3Df78efaf3-96f312b4-f78f71bc-74fe4=
85fff30-583950d45c073877&q=3D1&e=3Db8b33895-af3d-42ce-80ac-4835057078e7&u=
=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+title:=C2=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0PHY=C2=A0Device=
=C2=A0Tree=C2=A0Bindings=0D=0A>=C2=A0=0D=0A>=C2=A0Same=C2=A0comment=C2=A0as=
=C2=A0patch=C2=A0=231.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AI=C2=A0will=C2=A0remov=
e=C2=A0'Device=C2=A0Tree=C2=A0Bindings'.=0D=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+maintainers:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=
=A0<jesper.nilsson=40axis.com>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+properties:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0compatible:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0c=
onst:=C2=A0axis,artpec8-pcie-phy=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0r=
eg:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=C2=A0registers.=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=C2=
=A0coding=C2=A0sublayer=C2=A0registers.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=
=C2=A0reg-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0phy=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pcs=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=22=23phy-cells=22:=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0const:=C2=A00=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0clocks:=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0PHY=C2=A0reference=
=C2=A0clock=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0clock-names:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0ref_clk=0D=0A>=C2=A0=0D=0A>=C2=A0Same=C2=
=A0comment=C2=A0as=C2=A0patch=C2=A0=231.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=
=C2=A0remove=C2=A0_clk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=
=A0num-lanes:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>=
=C2=A0+=0D=0A>>=C2=A0+required:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0compatible=
=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg-=
names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=22=23phy-cells=22=0D=0A>>=C2=A0+=C2=
=A0=C2=A0-=C2=A0clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clock-names=0D=0A>>=
=C2=A0+=C2=A0=C2=A0-=C2=A0num-lanes=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+additional=
Properties:=C2=A0false=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+examples:=0D=0A>>=C2=A0=
+=C2=A0=C2=A0-=C2=A0=7C=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=23include=C2=
=A0<dt-bindings/interrupt-controller/irq.h>=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=23include=C2=A0<dt-bindings/interrupt-controller/arm-gic.h>=0D=0A=
>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0artpec8=C2=A0=7B=0D=0A>=C2=
=A0=0D=0A>=C2=A0Same=C2=A0comment=C2=A0as=C2=A0patch=C2=A0=231.=0D=0A>=C2=
=A0=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0modity=C2=A0to=C2=A0'soc'.=0D=0A=
=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=23add=
ress-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=23size-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_phy:=C2=A0pcie-phy=4016c80000=
=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0compatible=C2=A0=3D=C2=A0=22axis,artpec8-pcie-phy=22;=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0reg=C2=A0=3D=C2=A0<0x0=C2=A00x16c80000=C2=A00x0=C2=A00x2000>,=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x0=C2=A00x16c90000=C2=A00=
x0=C2=A00x1000>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg-names=C2=A0=3D=C2=A0=22phy=22,=C2=A0=22pc=
s=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=23phy-cells=C2=A0=3D=C2=A0<0>;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clocks=C2=A0=
=3D=C2=A0<&clock_cmu_fsys=C2=A053>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-names=C2=A0=3D=C2=A0=
=22ref_clk=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0num-lanes=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+...=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=C2=
=A0Best=C2=A0regards,=0D=0A>=C2=A0Krzysztof=0D=0A=0D=0AThank=20you=20for=20=
kindness=20reivew.=0D=0A=0D=0ABest=20regards,=0D=0AWangseok=20Lee
