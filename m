Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B6567DAA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 07:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGFFU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiGFFU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 01:20:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793ED1FCF8
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 22:20:26 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220706052024epoutp01d1c12b93dd2e3b1b9f7eaa6417594317~-Jd4zlTte0070000700epoutp01e
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 05:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220706052024epoutp01d1c12b93dd2e3b1b9f7eaa6417594317~-Jd4zlTte0070000700epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657084824;
        bh=f+ua8THa6FizjnAsXlAoxZZd0pO8JVwXvlSUl0eu28s=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=dE7VlihhkxqrhpMEpWxQ5DjU8wlwK57TYaIAeT9tYGYK1e8mNoPd58SeQpRqEU7Lr
         lB84ovULeF9MZP0zf4jsZP1MVwYphriPh3mERbOXUnwqnj7DMcmfjvufvmVQ2XboZ2
         MtZ3Jaw3IL8ZFq/atCWQrK4s0CB2TQJ2tLir7jgE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220706052023epcas2p42c3b36dc283a34e4155af641625a3b5d~-Jd3_gpvL1642816428epcas2p4h;
        Wed,  6 Jul 2022 05:20:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Ld7Cp5S6pz4x9Q2; Wed,  6 Jul
        2022 05:20:22 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-9a-62c51b96a027
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.F3.09642.69B15C26; Wed,  6 Jul 2022 14:20:22 +0900 (KST)
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
In-Reply-To: <43a075c6-ff48-acf2-0be7-634d292daf30@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220706052021epcms2p700172d20dbc02303cf9c6f7e66cebfbd@epcms2p7>
Date:   Wed, 06 Jul 2022 14:20:21 +0900
X-CMS-MailID: 20220706052021epcms2p700172d20dbc02303cf9c6f7e66cebfbd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmqe406aNJBs07tSyWNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem8X58xvYLRp6frNaHHnzkdli//GV
        TBaXd81hszg77zibxYRV31gs3vx+wW5xbnGmReveI+wWO++cYLb4tfUPk4Oox5p5axg9rq8L
        8FiwqdRj06pONo8nV6YzeWxeUu/Rt2UVo8fxG9uZPD5vkgvgjMq2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6TEmhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbGj+RtjQbdIRfu28gbG48Jd
        jJwcEgImEpufdTJ3MXJxCAnsYJSYu+kpUxcjBwevgKDE3x1gNcICzhK7/m9iA7GFBJQkdqyZ
        xwwR15e4vqKbFcRmE9CV+Lf4JRvIHBGBWWwSS74uZQJxmAUWMErs/72PEWIbr8SM9qcsELa0
        xPblW8HinAJ2EnNPH2KGiGtI/FjWC2WLStxc/ZYdxn5/bD7UHBGJ1ntnoWoEJR783A0Vl5JY
        8OQQK4RdLbH/728mCLuBUaL/firIYxJAV++4bgwS5hXwlZh4CeIxFgFViea9fWwQ5S4S594/
        BFvLLKAtsWzha2aQVmYBTYn1u/QhpihLHLnFAvNUw8bf7OhsZgE+iY7Df+HiO+Y9gTpGTWLe
        yp3MExiVZyECehaSXbMQdi1gZF7FKJZaUJybnlpsVGAMj9rk/NxNjOAkruW+g3HG2w96hxiZ
        OBgPMUpwMCuJ8K6adDBJiDclsbIqtSg/vqg0J7X4EKMp0JcTmaVEk/OBeSSvJN7QxNLAxMzM
        0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVAOTTUNRsWXQ/AkiEo2H3HJ1Jv+8cci5
        6PgRT+eeme1ctl6rntXcq7p76F+H0dkrRe+vmBcErI5TT278G/j5zJ8ri9z7HzzneSjEcbf8
        jGijdu/fX9P9DW+1KQk2L+ufvNcyRk5Swdyx0vd8pu4mlt0B/Knz/G9XJ/6Vv7SolP1VbFr1
        5knFLxr5O3n4Fv5V/7ic6/i5hG4pOU3fjn363BxmLs6ua0+eftHQaR1kd0Rausj4BZ+jn/n3
        zrZnlYv0bH9o76r41T/PREnr9m7Jrrefd4cV7rg3xevY+mvP9c6qvwx43+Z0JKfXsmhxiYbC
        7LqFBk9CZ0zi8uMPYAs4yXX40qGTy94E5jlJfeQ+81SJpTgj0VCLuag4EQCuPlWyawQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <43a075c6-ff48-acf2-0be7-634d292daf30@kernel.org>
        <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
        <4b4b08af-887b-89e9-b4a5-93e7d8a03222@kernel.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012916epcms2p5cf8d55e7420dea10bb4a05d91aaf99dd@epcms2p5>
        <20220629071829epcms2p65eab75702495a939f3f6e4ea020181de@epcms2p6>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
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

On=C2=A005/07/2022=C2=A019:59,=C2=A0Krzysztof=20Kozlowski=C2=A0wrote:=0D=0A=
>=20On=C2=A029/06/2022=C2=A009:18,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A=
>>=C2=A0Just=C2=A0a=C2=A0gentle=C2=A0ping=C2=A0for=C2=A0this=C2=A0patch,=C2=
=A0if=C2=A0any=C2=A0concern=C2=A0on=C2=A0this=C2=A0patch=C2=A0please=C2=A0l=
et=C2=A0me=C2=A0know.=0D=0A>>=C2=A0=0D=0A>=20=0D=0A>=20You=C2=A0received=C2=
=A0comments=C2=A0to=C2=A0fix=C2=A0in=C2=A0this=C2=A0patch.=C2=A0Exactly=C2=
=A0four.=C2=A0Four=C2=A0important=0D=0A>=20points=C2=A0to=C2=A0fix.=C2=A0Th=
erefore=C2=A0what=C2=A0is=C2=A0this=C2=A0ping=C2=A0about?=0D=0A>=20=0D=0A>=
=20Without=C2=A0fixing=C2=A0these=C2=A0items,=C2=A0your=C2=A0patch=C2=A0can=
not=C2=A0be=C2=A0accepted.=C2=A0What=C2=A0is=C2=A0more=0D=0A>=20to=C2=A0pin=
g=C2=A0here?=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=
=0D=0AI=20tried=20to=20receive=20your=20opinion=20about=20the=20fix=20point=
=20.=0D=0AI=20will=20request=20a=20review=20again=20after=20modifying=20it=
=20in=20the=20next=20patch.=0D=0A=0D=0AThank=20you.=0D=0A=0D=0A>>>=20+=0D=
=0A>>>=20+=20=20clocks:=0D=0A>>>=20+=20=20=20=20items:=0D=0A>>>=20+=20=20=
=20=20=20=20-=20description:=20PCIe=20PHY=20reference=20clock=0D=0A>=20=0D=
=0A>=20refer=20to=20sample-schema.yaml,=20even=20if=20the=20clock=20item=20=
is=20single,=0D=0A>=20it=20seems=20to=20be=20used=20as=20follows.=0D=0A>=20=
=0D=0A>=20clocks:=0D=0A>=20=20=20maxItems:=201=0D=0A>=20=0D=0A>=20clock-nam=
es:=0D=0A>=20=20=20items:=0D=0A>=20=20=20=20=20-=20const:=20ref=0D=0A>=20=
=0D=0A>=20If=20only=20=22clocks:=22=20are=20define=20and=20clock-names=20ar=
e=20not=20define,=0D=0A>=20the=20following=20warning=20occurs.=0D=0A>=20=22=
'clock-names'=20does=20not=20match=20any=20of=20the=20regexes=22=0D=0A>=20=
=0D=0A>>>=20+=0D=0A>>>=20+=20=20lcpll-ref-clk:=0D=0A>>>=20+=20=20=20=20cons=
t:=201=0D=0A>>=20=0D=0A>>=20Unknown=20field...=20custom=20properties=20need=
=20vendor=20(axis,),=20type=20(boolean)=0D=0A>>=20and=20description.=0D=0A>=
>=20=0D=0A>=20=0D=0A>=20=22lcpl-ref-clk=22=20has=20an=20enum=20type=20value=
,=20so=20i=20will=20modify=20it=20as=20below.=0D=0A>=20=0D=0A>=20=0D=0A>=20=
axis,lcpll-ref-clk:=0D=0A>=20=20=20description:=0D=0A>=20=20=20=20=20select=
=20the=20reference=20clock=20of=20phy=20and=20initialization=20is=20perform=
ed=0D=0A>=20=20=20=20=20with=20the=20reference=20clock=20according=20to=20t=
he=20selected=20value.=0D=0A>=20=20=20=24ref:=20/schemas/types.yaml=23/defi=
nitions/uint32=0D=0A>=20=20=20enum:=20=5B=200,=201,=202,=203,=204=20=5D=0D=
=0A>=20
