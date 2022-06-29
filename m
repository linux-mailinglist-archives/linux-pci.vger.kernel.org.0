Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43855F8A5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiF2HTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiF2HTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 03:19:13 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49433EA4
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 00:18:36 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220629071831epoutp03dcb969d5f130160a6e9e45d6f0bb3192~9BkBYMM4x1657716577epoutp03W
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 07:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220629071831epoutp03dcb969d5f130160a6e9e45d6f0bb3192~9BkBYMM4x1657716577epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656487111;
        bh=1wS6cRdRjTdFjT3S6Lk+8PVzesqj0XsuvTbIfj3KJOI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ItIV6k3kAysuTVNtmru2Lfh+kwOHeq48XGZ7C+ATdwo/Y/EovLapo7iKA0zQ05Eva
         iiZdzb4masqIpUsY5Q9yT3+aDJ/7qwoHgo4AF8kL+2wl2I1ZQJdJyYygbFOKkAQNgb
         9NAILRfk40ujnZV9iJp3f+wHTirCsHv1L9jFneWc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220629071830epcas2p16267bd2ee8f19f7cc80872ccc82441de~9BkAzc2M20582005820epcas2p1T;
        Wed, 29 Jun 2022 07:18:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LXt9L1LCNz4x9Pt; Wed, 29 Jun
        2022 07:18:30 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-00-62bbfcc50a4e
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.38.09642.5CCFBB26; Wed, 29 Jun 2022 16:18:30 +0900 (KST)
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
In-Reply-To: <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220629071829epcms2p65eab75702495a939f3f6e4ea020181de@epcms2p6>
Date:   Wed, 29 Jun 2022 16:18:29 +0900
X-CMS-MailID: 20220629071829epcms2p65eab75702495a939f3f6e4ea020181de
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmhe6xP7uTDFYeZbJY0pRh8fKQpsX8
        I+dYLXbPWM5kMXPqGWaL54dmMVt8alG1uPC0h83i5ax7bBbnz29gt2jo+c1qceTNR2aL/cdX
        Mllc3jWHzeLsvONsFhNWfWOxePP7BbvFucWZFq17j7Bb7Lxzgtni19Y/TA6iHmvmrWH0uL4u
        wGPBplKPTas62TyeXJnO5LF5Sb1H35ZVjB7Hb2xn8vi8SS6AMyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbaF29YC76ZV/QsPsXUwLjM
        rIuRk0NCwETi6NtOxi5GLg4hgR2MErf2vGfvYuTg4BUQlPi7QxikRljAWWLX/01sILaQgJLE
        jjXzmCHi+hLXV3SzgthsAroS/xa/ZAOZIyIwi01iydelTCAOs8ACRon9v/cxQmzjlZjR/pQF
        wpaW2L58K1icU8BP4vH95UwQcQ2JH8t6mSFsUYmbq9+yw9jvj82HmiMi0XrvLFSNoMSDn7uh
        4lISC54cYoWwqyX2//0NNbOBUaL/firIYxJAV++4bgwS5hXwlbg0dyMbSJhFQFXi9VMviAoX
        idcPuEEqmAW0JZYtfM0MEmYW0JRYv0sfokJZ4sgtFpiXGjb+ZkdnMwvwSXQc/gsX3zHvCdQp
        ahLzVu5knsCoPAsRzLOQ7JqFsGsBI/MqRrHUguLc9NRiowJjeMwm5+duYgSncC33HYwz3n7Q
        O8TIxMF4iFGCg1lJhHfhmZ1JQrwpiZVVqUX58UWlOanFhxhNgX6cyCwlmpwPzCJ5JfGGJpYG
        JmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtSi2D6mDg4pRqYkrYfmn9AgCvULH7FpCeX98ld
        P/yQfaKOfwOHvxPD69hzrDu6DfLXZV80TZ74K+df27wJMrnfXdLmP74upBiysHjL9lnqRsea
        xXe9rU/6rPFi3yH/zU17w9+YmrIl/zBrDzQR2mSgZrbUZCLD3ai/vGK7NEyW5PuKpS7Qb5b+
        p2w7l/2enbJlTba2u4h8/cWqSycOhxtE9lqVqH5OVVEPuPHDs6Lb9tYpPnHVFe5eLz/5737Q
        GXb7cP6WvNuT9vGkKzx4dvPt9x6rmBkH2bJcA4rmRta5X+NrzHssNv1czMGqcOGSaMmijh9c
        n5b8bfkeXvjh5g7+T44/H/TMqN6qvd2/7/B2gx8Lt/5juHxCiaU4I9FQi7moOBEAlf9ktWoE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
        <4b4b08af-887b-89e9-b4a5-93e7d8a03222@kernel.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012916epcms2p5cf8d55e7420dea10bb4a05d91aaf99dd@epcms2p5>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just a gentle ping for this patch, if any concern on this patch please let =
me know.


On=C2=A020/06/2022=C2=A017:38,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=20=
On=C2=A017/06/2022=C2=A007:59,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>>=C2=A0On=C2=A013/06/2022=C2=A018:29,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote=
:=0D=0A>>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<wangseok.lee=40=
samsung.com>=0D=0A>>>=C2=A0---=0D=0A>>>=C2=A0v2->v3=C2=A0:=0D=0A>>>=C2=A0-m=
odify=C2=A0version=C2=A0history=C2=A0to=C2=A0fit=C2=A0the=C2=A0linux=C2=A0c=
ommit=C2=A0rule=0D=0A>>>=C2=A0-remove=C2=A0'Device=C2=A0Tree=C2=A0Bindings'=
=C2=A0on=C2=A0title=0D=0A>>>=C2=A0-remove=C2=A0clock-names=C2=A0entries=0D=
=0A>>>=C2=A0-change=C2=A0node=C2=A0name=C2=A0to=C2=A0soc=C2=A0from=C2=A0art=
pec8=C2=A0on=C2=A0excamples=0D=0A>>>=C2=A0=0D=0A>>>=C2=A0v1->v2=C2=A0:=0D=
=0A>>>=C2=A0-'make=C2=A0dt_binding_check'=C2=A0result=C2=A0improvement=0D=
=0A>>>=C2=A0-Add=C2=A0the=C2=A0missing=C2=A0property=C2=A0list=0D=0A>>>=C2=
=A0-Align=C2=A0the=C2=A0indentation=C2=A0of=C2=A0continued=C2=A0lines/entri=
es=0D=0A>>>=C2=A0---=0D=0A>>>=C2=A0=C2=A0.../bindings/phy/axis,artpec8-pcie=
-phy.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A073=C2=A0+=
+++++++++++++++++++++=0D=0A>>>=C2=A0=C2=A01=C2=A0file=C2=A0changed,=C2=A073=
=C2=A0insertions(+)=0D=0A>>>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0D=
ocumentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>>=C2=
=A0=0D=0A>>>=C2=A0diff=C2=A0--git=C2=A0a/Documentation/devicetree/bindings/=
phy/axis,artpec8-pcie-phy.yaml=C2=A0b/Documentation/devicetree/bindings/phy=
/axis,artpec8-pcie-phy.yaml=0D=0A>>>=C2=A0new=C2=A0file=C2=A0mode=C2=A01006=
44=0D=0A>>>=C2=A0index=C2=A00000000..316b774=0D=0A>>>=C2=A0---=C2=A0/dev/nu=
ll=0D=0A>>>=C2=A0+++=C2=A0b/Documentation/devicetree/bindings/phy/axis,artp=
ec8-pcie-phy.yaml=0D=0A>>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,73=C2=A0=40=40=0D=
=0A>>>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0-only=C2=A0OR=C2=
=A0BSD-2-Clause=0D=0A>>>=C2=A0+%YAML=C2=A01.2=0D=0A>>>=C2=A0+---=0D=0A>>>=
=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3D84f6a8c0-e57dbdd=
9-84f7238f-74fe485cbfec-e81bd79bfd1ff442&q=3D1&e=3D6739af06-730c-48db-aef8-=
026a9aaee1b4&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Faxis%2Cartpe=
c8-pcie-phy.yaml%23=0D=0A>>>=C2=A0+=24schema:=C2=A0https://protect2.fireeye=
.com/v1/url?k=3Db4f1a4ba-d57ab1a3-b4f02ff5-74fe485cbfec-7f885cbe82dc7860&q=
=3D1&e=3D6739af06-730c-48db-aef8-026a9aaee1b4&u=3Dhttp%3A%2F%2Fdevicetree.o=
rg%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+title:=C2=
=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0PHY=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+main=
tainers:=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper=
.nilsson=40axis.com>=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+properties:=0D=0A>>>=C2=
=A0+=C2=A0=C2=A0compatible:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=
=C2=A0axis,artpec8-pcie-phy=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+=C2=A0=C2=A0reg:=
=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=C2=A0registers.=0D=0A>=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PHY=
=C2=A0coding=C2=A0sublayer=C2=A0registers.=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+=
=C2=A0=C2=A0reg-names:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0phy=0D=0A>>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pcs=0D=0A>>>=
=C2=A0+=0D=0A>>>=C2=A0+=C2=A0=C2=A0=22=23phy-cells=22:=0D=0A>>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0const:=C2=A00=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+=C2=A0=C2=
=A0clocks:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0PHY=C2=
=A0reference=C2=A0clock=0D=0A>=20=0D=0A>=20refer=C2=A0to=C2=A0sample-schema=
.yaml,=C2=A0even=C2=A0if=C2=A0the=C2=A0clock=C2=A0item=C2=A0is=C2=A0single,=
=0D=0A>=20it=C2=A0seems=C2=A0to=C2=A0be=C2=A0used=C2=A0as=C2=A0follows.=0D=
=0A>=20=0D=0A>=20clocks:=0D=0A>=20=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>=20=0D=
=0A>=20clock-names:=0D=0A>=20=C2=A0=C2=A0items:=0D=0A>=20=C2=A0=C2=A0=C2=A0=
=C2=A0-=C2=A0const:=C2=A0ref=0D=0A>=20=0D=0A>=20If=C2=A0only=C2=A0=22clocks=
:=22=C2=A0are=C2=A0define=C2=A0and=C2=A0clock-names=C2=A0are=C2=A0not=C2=A0=
define,=0D=0A>=20the=C2=A0following=C2=A0warning=C2=A0occurs.=0D=0A>=20=22'=
clock-names'=C2=A0does=C2=A0not=C2=A0match=C2=A0any=C2=A0of=C2=A0the=C2=A0r=
egexes=22=0D=0A>=20=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+=C2=A0=C2=A0num-lanes:=
=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>>=C2=A0+=0D=0A=
>>>=C2=A0+=C2=A0=C2=A0lcpll-ref-clk:=0D=0A>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0const:=C2=A01=0D=0A>>=C2=A0=0D=0A>>=C2=A0Unknown=C2=A0field...=C2=A0cust=
om=C2=A0properties=C2=A0need=C2=A0vendor=C2=A0(axis,),=C2=A0type=C2=A0(bool=
ean)=0D=0A>>=C2=A0and=C2=A0description.=0D=0A>>=C2=A0=0D=0A>=20=0D=0A>=20=
=22lcpl-ref-clk=22=C2=A0has=C2=A0an=C2=A0enum=C2=A0type=C2=A0value,=C2=A0so=
=C2=A0i=C2=A0will=C2=A0modify=C2=A0it=C2=A0as=C2=A0below.=0D=0A>=20=0D=0A>=
=20=0D=0A>=20axis,lcpll-ref-clk:=0D=0A>=20=C2=A0=C2=A0description:=0D=0A>=
=20=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0the=C2=A0reference=C2=A0clock=C2=A0o=
f=C2=A0phy=C2=A0and=C2=A0initialization=C2=A0is=C2=A0performed=0D=0A>=20=C2=
=A0=C2=A0=C2=A0=C2=A0with=C2=A0the=C2=A0reference=C2=A0clock=C2=A0according=
=C2=A0to=C2=A0the=C2=A0selected=C2=A0value.=0D=0A>=20=C2=A0=C2=A0=24ref:=C2=
=A0/schemas/types.yaml=23/definitions/uint32=0D=0A>=20=C2=A0=C2=A0enum:=C2=
=A0=5B=C2=A00,=C2=A01,=C2=A02,=C2=A03,=C2=A04=C2=A0=5D=0D=0A>=20=0D=0A>>>=
=C2=A0+=0D=0A>>>=C2=A0+required:=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0compatib=
le=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0=
reg-names=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0=22=23phy-cells=22=0D=0A>>>=C2=
=A0+=C2=A0=C2=A0-=C2=A0clocks=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0clock-names=
=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,fsys-sysreg=0D=0A>>=C2=A0=0D=0A>=
>=C2=A0Same=C2=A0problem=C2=A0as=C2=A0in=C2=A0patch=C2=A0=231.=0D=0A>>=C2=
=A0=0D=0A>=20=0D=0A>=20I=C2=A0will=C2=A0add=C2=A0the=C2=A0following=C2=A0it=
ems=C2=A0to=C2=A0the=C2=A0property.=0D=0A>=20=0D=0A>=20samsung,fsys-sysreg:=
=0D=0A>=20=C2=A0=C2=A0description:=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0Phandle=
=C2=A0to=C2=A0system=C2=A0register=C2=A0of=C2=A0fsys=C2=A0block.=0D=0A>=20=
=C2=A0=C2=A0=24ref:=C2=A0/schemas/types.yaml=23/definitions/phandle=0D=0A>=
=20=0D=0A>>>=C2=A0+=C2=A0=C2=A0-=C2=A0num-lanes=0D=0A>>>=C2=A0+=C2=A0=C2=A0=
-=C2=A0lcpll-ref-clk=0D=0A>>>=C2=A0+=0D=0A>>>=C2=A0+additionalProperties:=
=C2=A0true=0D=0A>>=C2=A0=0D=0A>>=C2=A0No,=C2=A0this=C2=A0must=C2=A0be=C2=A0=
false.=0D=0A>>=C2=A0=0D=0A>=20=0D=0A>=20yes,=C2=A0i=C2=A0miss=C2=A0it.=C2=
=A0I=C2=A0will=C2=A0fix=C2=A0this.=0D=0A>=20=0D=0A>>=C2=A0Best=C2=A0regards=
,=0D=0A>>=C2=A0Krzysztof=0D=0A>=20=0D=0A>=20Thank=C2=A0you=C2=A0for=C2=A0ki=
ndness=C2=A0reivew.=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Wangseok=
=C2=A0Lee
