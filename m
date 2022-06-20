Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3935512F9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiFTIio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiFTIic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 04:38:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F257615B
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 01:38:28 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220620083823epoutp04772f48344db81ef3fdc6f0fb5385a9be~6R2L7fkQb1724017240epoutp04X
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 08:38:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220620083823epoutp04772f48344db81ef3fdc6f0fb5385a9be~6R2L7fkQb1724017240epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655714303;
        bh=7WqPjom66N299uGJGfpNf6CIRF8tcg1yUJvVRQPJqh8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gyywQ6dvLw1SYD0FEcQsdgmyA/Y+SP+HFvT5d11ZvMH3zV8vROv+C6n1Hcodt0FTo
         qw63PyGmY3BnYKKhSfv0ixIPII/COolntlbcPzZzvw3/7evr8PZ/u/BmVDApHKcNjN
         SXh9wiNWAQO+mW7XaqdkeM1m3e9HSHlsI5j3VUhk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220620083822epcas2p3683203bccd2dcdd78fb65793f6c3e980~6R2LAgSjp2039920399epcas2p3C;
        Mon, 20 Jun 2022 08:38:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LRNMd5p8gz4x9QG; Mon, 20 Jun
        2022 08:38:21 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-77-62b031fd25f0
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.07.09650.DF130B26; Mon, 20 Jun 2022 17:38:21 +0900 (KST)
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
In-Reply-To: <4b4b08af-887b-89e9-b4a5-93e7d8a03222@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
Date:   Mon, 20 Jun 2022 17:38:21 +0900
X-CMS-MailID: 20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmme5fww1JBo+e61gsacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9Novz5zewWzT0/Ga1OPLmI7PF/uMr
        mSwu75rDZnF23nE2iwmrvrFYvPn9gt3i3OJMi9a9R9gtdt45wWzxa+sfJgdRjzXz1jB6XF8X
        4LFgU6nHplWdbB5Prkxn8ti8pN6jb8sqRo/jN7YzeXzeJBfAGZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pn9V9MBV2WFTc7N7I0MJ4x
        72Lk5JAQMJHYMncRYxcjF4eQwA5GiY27mtm7GDk4eAUEJf7uEAapERZwltj1fxMbiC0koCSx
        Y808Zoi4vsT1Fd2sIDabgK7Ev8Uv2UDmiAjMYpNY8nUpE4jDLLCAUWL/732MENt4JWa0P2WB
        sKUlti/fChbnFLCTuLHgDBtEXEPix7JeZghbVOLm6rfsMPb7Y/Oh5ohItN47C1UjKPHg526o
        uJTEgieHWCHsaon9f38zQdgNjBL991NBHpMAunrHdWOQMK+Ar8S8P9vBWlkEVCU2TbsAtcpF
        orHxHtgYZgFtiWULXzODtDILaEqs36UPMUVZ4sgtFpinGjb+ZkdnMwvwSXQc/gsX3zHvCdQx
        ahLzVu5knsCoPAsR0LOQ7JqFsGsBI/MqRrHUguLc9NRiowIjeNwm5+duYgSncS23HYxT3n7Q
        O8TIxMF4iFGCg1lJhNeGe0OSEG9KYmVValF+fFFpTmrxIUZToC8nMkuJJucDM0leSbyhiaWB
        iZmZobmRqYG5kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmef6lwgtuN9i9l3Q3c5y6W/Dc
        sm1dmULmT1M27pOY2/B91+Pqjc75tzhbeTd/XPc8RvNWz+F92et6Z3aZlv95WBkuuGzjwryn
        z3NLhBhMNG1brUyCw/+80RZUDTjHeC3/Xc8yA94pNv9k4tN9/s9/+nw/U61hRfD2xlXlDydt
        fr97unjKbZ5gbmXJ+/afCl1nexv/fNW2Oert4+/muSq6v0KL1ly5PXXrnPtWDXNvsk436rsU
        +jNYMNYy7cNC2VKxbAunu+G7F+kaf07oPXvgBO/69cXs62Zeuav7se2ewctlp1rtHA+Hix/z
        0Bf+FdLAMLv09BWhuevFPzBddJr2c/NO73X88vFfd5/Y9IBVS4mlOCPRUIu5qDgRAA5JO4ds
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <4b4b08af-887b-89e9-b4a5-93e7d8a03222@kernel.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012916epcms2p5cf8d55e7420dea10bb4a05d91aaf99dd@epcms2p5>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A017/06/2022=C2=A007:59,=C2=A0Krzysztof=20Kozlowski=20wrote:=0D=0A>=
=20On=C2=A013/06/2022=C2=A018:29,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=
>=C2=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=
=C2=A0SoC.=0D=0A>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=
=A0of=C2=A0Axis=C2=A0Communications=0D=0A>>=C2=A0and=C2=A0PCIe=C2=A0phy=C2=
=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY.=0D=0A>=20=0D=
=0A>=20No=C2=A0improvements=C2=A0here.=C2=A0On=C2=A0v2=C2=A0I=C2=A0gave=C2=
=A0you=C2=A0link=C2=A0pointing=C2=A0to=C2=A0specific=0D=0A>=20paragraph=C2=
=A0of=C2=A0our=C2=A0documentation=C2=A0which=C2=A0you=C2=A0need=C2=A0to=C2=
=A0apply=C2=A0-=C2=A0wrong=C2=A0wrapping.=0D=0A>=20Is=C2=A0there=C2=A0somet=
hing=C2=A0unclear=C2=A0here?=0D=0A>=20=0D=0A>=20Please=0D=0A>=20do=0D=0A>=
=20not=0D=0A>=20wrap=0D=0A>=20in=0D=0A>=20different=0D=0A>=20style.=0D=0A>=
=20=0D=0A>=20=0D=0A=0D=0AI=20think=20i=20misunderstood=20your=20review=20co=
mment.=0D=0AI=20will=20modify=20it=20as=20below.=0D=0As/SAMSUNG=C2=A0PHY/Sa=
msung=20phy=0D=0APlease=20let=20me=20know=20if=20there=20is=20anything=20I=
=20missed.=0D=0A=0D=0A>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=
=A0Lee=C2=A0<wangseok.lee=40samsung.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0v2->=
v3=C2=A0:=0D=0A>>=C2=A0-modify=C2=A0version=C2=A0history=C2=A0to=C2=A0fit=
=C2=A0the=C2=A0linux=C2=A0commit=C2=A0rule=0D=0A>>=C2=A0-remove=C2=A0'Devic=
e=C2=A0Tree=C2=A0Bindings'=C2=A0on=C2=A0title=0D=0A>>=C2=A0-remove=C2=A0clo=
ck-names=C2=A0entries=0D=0A>>=C2=A0-change=C2=A0node=C2=A0name=C2=A0to=C2=
=A0soc=C2=A0from=C2=A0artpec8=C2=A0on=C2=A0excamples=0D=0A>>=C2=A0=0D=0A>>=
=C2=A0v1->v2=C2=A0:=0D=0A>>=C2=A0-'make=C2=A0dt_binding_check'=C2=A0result=
=C2=A0improvement=0D=0A>>=C2=A0-Add=C2=A0the=C2=A0missing=C2=A0property=C2=
=A0list=0D=0A>>=C2=A0-Align=C2=A0the=C2=A0indentation=C2=A0of=C2=A0continue=
d=C2=A0lines/entries=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0.../bindings/phy/a=
xis,artpec8-pcie-phy.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=7C=C2=A073=C2=A0++++++++++++++++++++++=0D=0A>>=C2=A0=C2=A01=C2=A0file=C2=
=A0changed,=C2=A073=C2=A0insertions(+)=0D=0A>>=C2=A0=C2=A0create=C2=A0mode=
=C2=A0100644=C2=A0Documentation/devicetree/bindings/phy/axis,artpec8-pcie-p=
hy.yaml=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/Documentation/dev=
icetree/bindings/phy/axis,artpec8-pcie-phy.yaml=C2=A0b/Documentation/device=
tree/bindings/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=A0new=C2=A0file=C2=
=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..316b774=0D=0A>>=C2=A0-=
--=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/Documentation/devicetree/bindings=
/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,73=C2=
=A0=40=40=0D=0A>>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0-only=
=C2=A0OR=C2=A0BSD-2-Clause=0D=0A>>=C2=A0+%YAML=C2=A01.2=0D=0A>>=C2=A0+---=
=0D=0A>>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3D84f6a8c0=
-e57dbdd9-84f7238f-74fe485cbfec-e81bd79bfd1ff442&q=3D1&e=3D6739af06-730c-48=
db-aef8-026a9aaee1b4&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Faxis=
%2Cartpec8-pcie-phy.yaml%23=0D=0A>>=C2=A0+=24schema:=C2=A0https://protect2.=
fireeye.com/v1/url?k=3Db4f1a4ba-d57ab1a3-b4f02ff5-74fe485cbfec-7f885cbe82dc=
7860&q=3D1&e=3D6739af06-730c-48db-aef8-026a9aaee1b4&u=3Dhttp%3A%2F%2Fdevice=
tree.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+title:=
=C2=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0PHY=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+mai=
ntainers:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper=
.nilsson=40axis.com>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+properties:=0D=0A>>=C2=A0=
+=C2=A0=C2=A0compatible:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A0=
axis,artpec8-pcie-phy=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0reg:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=C2=A0registers.=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=C2=A0codin=
g=C2=A0sublayer=C2=A0registers.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0re=
g-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0phy=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pcs=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=22=23phy-cells=22:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0const:=C2=A00=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0PHY=C2=A0reference=C2=A0c=
lock=0D=0A=0D=0Arefer=20to=20sample-schema.yaml,=20even=20if=20the=20clock=
=20item=20is=20single,=0D=0Ait=20seems=20to=20be=20used=20as=20follows.=0D=
=0A=0D=0Aclocks:=0D=0A=20=20maxItems:=201=0D=0A=0D=0Aclock-names:=0D=0A=20=
=20items:=0D=0A=20=20=20=20-=20const:=20ref=0D=0A=0D=0AIf=20only=20=22clock=
s:=22=20are=20define=20and=20clock-names=20are=20not=20define,=0D=0Athe=20f=
ollowing=20warning=20occurs.=0D=0A=22'clock-names'=20does=20not=20match=20a=
ny=20of=20the=20regexes=22=0D=0A=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0n=
um-lanes:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>=C2=A0=
+=0D=0A>>=C2=A0+=C2=A0=C2=A0lcpll-ref-clk:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0const:=C2=A01=0D=0A>=20=0D=0A>=20Unknown=C2=A0field...=C2=A0custom=C2=
=A0properties=C2=A0need=C2=A0vendor=C2=A0(axis,),=C2=A0type=C2=A0(boolean)=
=0D=0A>=20and=C2=A0description.=0D=0A>=20=0D=0A=0D=0A=22lcpl-ref-clk=22=20h=
as=20an=20enum=20type=20value,=20so=20i=20will=20modify=20it=20as=20below.=
=0D=0A=0D=0A=0D=0Aaxis,lcpll-ref-clk:=0D=0A=20=20description:=0D=0A=20=20=
=20=20select=20the=20reference=20clock=20of=20phy=20and=20initialization=20=
is=20performed=0D=0A=20=20=20=20with=20the=20reference=20clock=20according=
=20to=20the=20selected=20value.=0D=0A=20=20=24ref:=20/schemas/types.yaml=23=
/definitions/uint32=0D=0A=20=20enum:=20=5B=200,=201,=202,=203,=204=20=5D=0D=
=0A=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+required:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0compatible=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0reg-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=22=23phy-cells=22=0D=
=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0cloc=
k-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,fsys-sysreg=0D=0A>=20=0D=
=0A>=20Same=C2=A0problem=C2=A0as=C2=A0in=C2=A0patch=C2=A0=231.=0D=0A>=20=0D=
=0A=0D=0AI=20will=20add=20the=20following=20items=20to=20the=20property.=0D=
=0A=0D=0Asamsung,fsys-sysreg:=0D=0A=20=20description:=0D=0A=20=20=20=20Phan=
dle=20to=20system=20register=20of=20fsys=20block.=0D=0A=20=20=24ref:=20/sch=
emas/types.yaml=23/definitions/phandle=0D=0A=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0num-lanes=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0lcpll-ref-clk=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+additionalProperties:=C2=A0true=0D=0A>=20=0D=0A>=20No,=C2=A0=
this=C2=A0must=C2=A0be=C2=A0false.=0D=0A>=20=0D=0A=0D=0Ayes,=20i=20miss=20i=
t.=20I=20will=20fix=20this.=0D=0A=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzy=
sztof=0D=0A=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20r=
egards,=0D=0AWangseok=20Lee
