Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B72567DC1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 07:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGFFW1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 01:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiGFFWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 01:22:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC08820F45
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 22:22:20 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220706052219epoutp01514d6944fb7dbd816295ca68d35cb5a9~-Jfj98SZA0168401684epoutp01D
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 05:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220706052219epoutp01514d6944fb7dbd816295ca68d35cb5a9~-Jfj98SZA0168401684epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657084939;
        bh=Ispl4LOX16CobeM8SQ1UfhF/UhNI9nkTRJAg/7f9IJ4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=nWv7EhoUb4Fjg4+cDL27uRE8kYM2k0+dqgnNXG++QxetC/2BPOGvf904r0RixSEUy
         AcF3ZA8pSaUVGBSsbYF3UWQj4Tcyc9Xf3gWtRRktW3OvzObHFB/+q/RvoiD0yQXALX
         CSV+rzmz28xv/SI3s2OqFLlq/jh9+SAoJb5661pk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220706052218epcas2p2a2f562156ae6b09914c56e6748bd98e0~-JfjJMIWF3204232042epcas2p2-;
        Wed,  6 Jul 2022 05:22:18 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ld7G14xwcz4x9QG; Wed,  6 Jul
        2022 05:22:17 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-60-62c51c095a2d
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.E4.09642.90C15C26; Wed,  6 Jul 2022 14:22:17 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <20220706052217epcms2p444cc8608b21d483a66a43ecf4f2140d4@epcms2p4>
Date:   Wed, 06 Jul 2022 14:22:17 +0900
X-CMS-MailID: 20220706052217epcms2p444cc8608b21d483a66a43ecf4f2140d4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmmS6nzNEkg3U9qhZLmjIsXh7StJh/
        5Byrxe4Zy5ksZk49w2zx/NAsZotPLaoWF572sFm8nHWPzeL8+Q3sFg09v1ktjrz5yGyx//hK
        JovLu+awWZydd5zNYsKqbywWb36/YLc4tzjTonXvEXaLnXdOMFv82vqHyUHUY828NYwe19cF
        eCzYVOqxaVUnm8eTK9OZPDYvqffo27KK0eP4je1MHp83yQVwRmXbZKQmpqQWKaTmJeenZOal
        2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gB9pqRQlphTChQKSCwuVtK3synKLy1J
        VcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzljzLargt0TF7FWXWRoYl0t0
        MXJySAiYSGy4u4C9i5GLQ0hgB6PEidWH2LoYOTh4BQQl/u4QBqkRFnCW2PV/ExuILSSgJLFj
        zTxmiLi+xPUV3awgNpuArsS/xS/ZQOaICMxik1jydSkTiMMssIBRYv/vfYwQ23glZrQ/ZYGw
        pSW2L98KFdeQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe/NwNFZeSWPDkECuEXS2x
        /+9vJgi7gVGi/34qyDMSQJfuuG4MEuYV8JV4eGIG2DMsAqoSv5+uh2p1kTj18C/YWmYBbYll
        C18zg7QyC2hKrN+lDzFFWeLILRaYRxo2/mZHZzML8El0HP4LF98x7wnUMWoS81buZIYYIyOx
        9aX/BEalWYhwnoVk7SyEtQsYmVcxiqUWFOempxYbFRjDYzY5P3cTIziFa7nvYJzx9oPeIUYm
        DsZDjBIczEoivKsmHUwS4k1JrKxKLcqPLyrNSS0+xGgK9PBEZinR5HxgFskriTc0sTQwMTMz
        NDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cAU/Pqqvf6S6eyzBG3KIsMdZ2cVLJz2
        cpqFc+/mlpkSuxOy2D4qfD9Z4p3x9ff50K5FW4yZ/8W7zYpZunJxaFnaqc7Upt3ZxfWqCw0F
        9vxc0Dr3Rua610pfzdVnpXzTOJHddO9s5ffCj93disJzz2VHvS+Y8ODAM7Z3L95tmMnWOG//
        F2VzGdHFKd8ij1Z4vS+OW2zP7DtN4cIhfp6yj084jv0/fkd9S83+DxZnN4m7fk/R2zfBuMuk
        7N6eryFOs9QFWipu7JV/UBF//6nMve3H3PdHN5RXthqvNpn8Qy311d2y1uWXHefNDm9ScNPt
        Sr0cfsljemnZ2eagDfe9FfwUXpyTF8q9btfpYz2n6OEKJZbijERDLeai4kQA3PVmIGoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p4>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A005/07/2022=C2=A019:59,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=C2=A0On=C2=A029/06/2022=C2=A009:18,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=
=0D=0A>>=C2=A0Just=C2=A0a=C2=A0gentle=C2=A0ping=C2=A0for=C2=A0this=C2=A0pat=
ch,=C2=A0if=C2=A0any=C2=A0concern=C2=A0on=C2=A0this=C2=A0patch=C2=A0please=
=C2=A0let=C2=A0me=C2=A0know.=0D=0A>>=C2=A0=0D=0A>=C2=A0=0D=0A>=C2=A0You=C2=
=A0received=C2=A0comments=C2=A0to=C2=A0fix=C2=A0in=C2=A0this=C2=A0patch.=C2=
=A0Exactly=C2=A0four.=C2=A0Four=C2=A0important=0D=0A>=C2=A0points=C2=A0to=
=C2=A0fix.=C2=A0Therefore=C2=A0what=C2=A0is=C2=A0this=C2=A0ping=C2=A0about?=
=0D=0A>=C2=A0=0D=0A>=C2=A0Without=C2=A0fixing=C2=A0these=C2=A0items,=C2=A0y=
our=C2=A0patch=C2=A0cannot=C2=A0be=C2=A0accepted.=C2=A0What=C2=A0is=C2=A0mo=
re=0D=0A>=C2=A0to=C2=A0ping=C2=A0here?=0D=0A>=C2=A0=0D=0A>=C2=A0Best=C2=A0r=
egards,=0D=0A>=C2=A0Krzysztof=0D=0A=0D=0AI=C2=A0tried=C2=A0to=C2=A0receive=
=C2=A0your=C2=A0opinion=C2=A0about=C2=A0the=C2=A0fix=C2=A0point=C2=A0.=0D=
=0AI=C2=A0will=C2=A0request=C2=A0a=C2=A0review=C2=A0again=C2=A0after=C2=A0m=
odifying=C2=A0it=C2=A0in=C2=A0the=C2=A0next=C2=A0patch.=0D=0A=0D=0AThank=C2=
=A0you.=0D=0A=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0PHY=C2=A0reference=C2=A0c=
lock=0D=0A>=C2=A0=0D=0A>=C2=A0refer=C2=A0to=C2=A0sample-schema.yaml,=C2=A0e=
ven=C2=A0if=C2=A0the=C2=A0clock=C2=A0item=C2=A0is=C2=A0single,=0D=0A>=C2=A0=
it=C2=A0seems=C2=A0to=C2=A0be=C2=A0used=C2=A0as=C2=A0follows.=0D=0A>=C2=A0=
=0D=0A>=C2=A0clocks:=0D=0A>=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>=C2=A0=
=0D=0A>=C2=A0clock-names:=0D=0A>=C2=A0=C2=A0=C2=A0items:=0D=0A>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0ref=0D=0A>=C2=A0=0D=0A>=C2=A0If=C2=A0o=
nly=C2=A0=22clocks:=22=C2=A0are=C2=A0define=C2=A0and=C2=A0clock-names=C2=A0=
are=C2=A0not=C2=A0define,=0D=0A>=C2=A0the=C2=A0following=C2=A0warning=C2=A0=
occurs.=0D=0A>=C2=A0=22'clock-names'=C2=A0does=C2=A0not=C2=A0match=C2=A0any=
=C2=A0of=C2=A0the=C2=A0regexes=22=0D=0A>=C2=A0=0D=0A>>>=C2=A0+=0D=0A>>>=C2=
=A0+=C2=A0=C2=A0lcpll-ref-clk:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const=
:=C2=A01=0D=0A>>=C2=A0=0D=0A>>=C2=A0Unknown=C2=A0field...=C2=A0custom=C2=A0=
properties=C2=A0need=C2=A0vendor=C2=A0(axis,),=C2=A0type=C2=A0(boolean)=0D=
=0A>>=C2=A0and=C2=A0description.=0D=0A>>=C2=A0=0D=0A>=C2=A0=0D=0A>=C2=A0=22=
lcpl-ref-clk=22=C2=A0has=C2=A0an=C2=A0enum=C2=A0type=C2=A0value,=C2=A0so=C2=
=A0i=C2=A0will=C2=A0modify=C2=A0it=C2=A0as=C2=A0below.=0D=0A>=C2=A0=0D=0A>=
=C2=A0=0D=0A>=C2=A0axis,lcpll-ref-clk:=0D=0A>=C2=A0=C2=A0=C2=A0description:=
=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0the=C2=A0reference=C2=A0cl=
ock=C2=A0of=C2=A0phy=C2=A0and=C2=A0initialization=C2=A0is=C2=A0performed=0D=
=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0with=C2=A0the=C2=A0reference=C2=A0clock=
=C2=A0according=C2=A0to=C2=A0the=C2=A0selected=C2=A0value.=0D=0A>=C2=A0=C2=
=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/uint32=0D=0A>=C2=
=A0=C2=A0=C2=A0enum:=C2=A0=5B=C2=A00,=C2=A01,=C2=A02,=C2=A03,=C2=A04=C2=A0=
=5D=0D=0A>=C2=A0
