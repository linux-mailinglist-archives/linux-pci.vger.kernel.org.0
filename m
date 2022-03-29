Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E04C4EA62F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 05:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiC2Dvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 23:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiC2Dvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 23:51:40 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C6D15FE5
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 20:49:55 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220329034953epoutp041532b5618263e48307096637eb854b42~gvXmNrbUb0975909759epoutp04_
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 03:49:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220329034953epoutp041532b5618263e48307096637eb854b42~gvXmNrbUb0975909759epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648525793;
        bh=PS7xjfk7eSwGLAi/Q3oQyLCdyKqSh7gNFdsMgNu3oEk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=NJ3FKO0SexvCUom5lmq38pbK9n97OGUtOQks6/IGGcRZbcL8TR5UQZ5TQzIQHzDLB
         EBEef5OmGDNuKd4my3672ww5vqu2FWiCY23PinolwSRJfKpcwuvQGTYYi3ShJOgb2k
         hkjyFIrh3sUO9P+ihFgJpOWb91crvqU1kg45wRKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220329034952epcas2p30b60294081e0903c5ddc4125a1222ece~gvXlkKTTa2083920839epcas2p3T;
        Tue, 29 Mar 2022 03:49:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KSFv167Rcz4x9QH; Tue, 29 Mar
        2022 03:49:49 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-b5-624281dd3fbb
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.F8.16040.DD182426; Tue, 29 Mar 2022 12:49:49 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220329034949epcms2p1717d820646c878f314b03e07c2d092ba@epcms2p1>
Date:   Tue, 29 Mar 2022 12:49:49 +0900
X-CMS-MailID: 20220329034949epcms2p1717d820646c878f314b03e07c2d092ba
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmqe7dRqckg68HRSyWNGVYvDykaTH/
        yDlWi+eHZjFbfGpRtbjwtIfN4uWse2wW589vYLdo6PnNanHkzUdmi/3HVzJZXN41h83i7Lzj
        bBYTVn1jsXjz+wW7xbnFmRate4+wW+y8c4LZQchjzbw1jB7X1wV4LNhU6rFpVSebx5Mr05k8
        Ni+p9+jbsorR4/iN7UwenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9Ar
        TswtLs1L18tLLbEyNDAwMgUqTMjO2HlxP1vBRceKm2/bmRoY39t3MXJySAiYSOz6uoGli5GL
        Q0hgB6PElEOvWLsYOTh4BQQl/u4QBqkRFnCW+He7lRnEFhJQktixZh4zRNxa4tOUyywgNpuA
        pcTF1oeMIHNEBL4xScz+8YoNxGEWuM0sMf/5exaIbbwSM9qfQtnSEtuXb2UEWcYpYCfxZpk7
        RFhD4seyXmYIW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXkljw5BArhF0tsf/vbyYI
        u4FRov9+KsgqCQF9iR3XjUHCvAK+EhtP9oONYRFQlVi2/R3UKheJ25t3g8WZBbQlli18zQzS
        yiygKbF+lz7EFGWJI7fgfmrY+Jsdnc0swCfRcfgvXHzHvCdQx6hJzFu5k3kCo/IsRDjPQrJr
        FsKuBYzMqxjFUguKc9NTi40KjOBRm5yfu4kRnKa13HYwTnn7Qe8QIxMH4yFGCQ5mJRFe2bP2
        SUK8KYmVValF+fFFpTmpxYcYTYG+nMgsJZqcD8wUeSXxhiaWBiZmZobmRqYG5krivF4pGxKF
        BNITS1KzU1MLUotg+pg4OKUamNT+VhUl/vn89VpTUEvgbE315kMfEmwdZv2wf1UYpXln+mKr
        4+8PTrUPkpO5OdttTquFimWhi8tyLaX7r6QEN01121XHfDWz42W0xKUiKYnW/MA8zic97EoF
        i6OPNL2Y+HPfhreOxyeoOV17wefBcPzgLxHjU5KR4uctj0uUxT79kBH5LvTiq9l3LTomVHFF
        /jRumJLBsv/thwuzNB4X+CtN5at+w+fouMx6y/OICa6TZ6qbvwjY3fbO0G62tPyjZOF/Lq8z
        b9tc43Sy3CWz7FrUO9UTeXYJ70TndG3YtUAicmWkuLqs4F+jmJMLUgNuG/mxcq87odU69emk
        4p8bl8ZV9J18Lf/MJIzfN7pOXYmlOCPRUIu5qDgRAKvHCopcBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1
References: <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
        <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
        <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
        <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
        <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
        <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
        <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Krzysztof Kozlowski=C2=A0<krzk=40kernel.org>=0D=0A>=20Date=20:=
=202022-03-28=2020:44=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=200/5=
=5D=20Add=20support=20for=20Axis,=20ARTPEC-8=20PCIe=20driver=0D=0A>=20=0D=
=0A>=20On=C2=A028/03/2022=C2=A013:29,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=
=A0wrote:=0D=0A>>>=C2=A0---------=C2=A0Original=C2=A0Message=C2=A0---------=
=0D=0A>>>=C2=A0Sender=C2=A0:=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0<krzk=40ker=
nel.org>=0D=0A>>>=C2=A0Date=C2=A0:=C2=A02022-03-28=C2=A018:38=C2=A0(GMT+9)=
=0D=0A>>>=C2=A0Title=C2=A0:=C2=A0Re:=C2=A0=5BPATCH=C2=A00/5=5D=C2=A0Add=C2=
=A0support=C2=A0for=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0driver=0D=0A>>>=
=0D=0A>>>=C2=A0On=C2=A028/03/2022=C2=A011:02,=C2=A0=EC=9D=B4=EC=99=95=EC=84=
=9D=C2=A0wrote:=0D=0A>>>>>=C2=A0=C2=A0---------=C2=A0Original=C2=A0Message=
=C2=A0---------=0D=0A>>>>>=C2=A0=C2=A0Sender=C2=A0:=C2=A0Krzysztof=C2=A0Koz=
lowski=C2=A0<krzk=40kernel.org>=0D=0A>>>>>=C2=A0=C2=A0Date=C2=A0:=C2=A02022=
-03-28=C2=A016:12=C2=A0(GMT+9)=0D=0A>>>>>=C2=A0=C2=A0Title=C2=A0:=C2=A0Re:=
=C2=A0=5BPATCH=C2=A00/5=5D=C2=A0Add=C2=A0support=C2=A0for=C2=A0Axis,=C2=A0A=
RTPEC-8=C2=A0PCIe=C2=A0driver=0D=0A>>>>>=0D=0A>>>>>=C2=A0=C2=A0On=C2=A028/0=
3/2022=C2=A003:44,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrote:=0D=0A>>>>>>=
=C2=A0=C2=A0=C2=A0This=C2=A0series=C2=A0patches=C2=A0include=C2=A0newly=C2=
=A0PCIe=C2=A0support=C2=A0for=C2=A0Axis=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>>>>>=
=C2=A0=C2=A0=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=
=C2=A0Axis=C2=A0Communications.=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0PCIe=C2=A0cont=
roller=C2=A0driver=C2=A0and=C2=A0phy=C2=A0driver=C2=A0have=C2=A0been=C2=A0n=
ewly=C2=A0added.=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0There=C2=A0is=C2=A0also=C2=A0=
a=C2=A0new=C2=A0MAINTAINER=C2=A0in=C2=A0the=C2=A0addition=C2=A0of=C2=A0phy=
=C2=A0driver.=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0PCIe=C2=A0controller=C2=A0is=C2=
=A0designed=C2=A0based=C2=A0on=C2=A0Design-Ware=C2=A0PCIe=C2=A0controller=
=C2=A0IP=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0and=C2=A0PCIe=C2=A0phy=C2=A0is=C2=A0d=
esinged=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY=C2=A0IP.=0D=0A>>>>>>=C2=A0=
=C2=A0=C2=A0It=C2=A0also=C2=A0includes=C2=A0modifications=C2=A0to=C2=A0the=
=C2=A0Design-Ware=C2=A0controller=C2=A0driver=C2=A0to=C2=A0=0D=0A>>>>>>=C2=
=A0=C2=A0=C2=A0run=C2=A0the=C2=A064bit-based=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0c=
ontroller=C2=A0driver.=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0It=C2=A0consists=C2=A0o=
f=C2=A06=C2=A0patches=C2=A0in=C2=A0total.=0D=0A>>>>>>=C2=A0=C2=A0=C2=A0=0D=
=0A>>>>>>=C2=A0=C2=A0=C2=A0This=C2=A0series=C2=A0has=C2=A0been=C2=A0tested=
=C2=A0on=C2=A0AXIS=C2=A0SW=C2=A0bring-up=C2=A0board=C2=A0=0D=0A>>>>>>=C2=A0=
=C2=A0=C2=A0with=C2=A0ARTPEC-8=C2=A0chipset.=0D=0A>>>>>=0D=0A>>>>>=C2=A0=C2=
=A0You=C2=A0lost=C2=A0mail=C2=A0threading.=C2=A0This=C2=A0makes=C2=A0readin=
g=C2=A0this=C2=A0difficult=C2=A0for=C2=A0us.=C2=A0Plus=0D=0A>>>>>=C2=A0=C2=
=A0you=C2=A0sent=C2=A0something=C2=A0non-applicable=C2=A0(patch=C2=A0=232),=
=C2=A0so=C2=A0please=C2=A0resend.=0D=0A>>>>>=0D=0A>>>>>=C2=A0=C2=A0Knowing=
=C2=A0recent=C2=A0Samsung=C2=A0reluctance=C2=A0to=C2=A0extend=C2=A0existing=
=C2=A0drivers=C2=A0and=C2=A0always=0D=0A>>>>>=C2=A0=C2=A0duplicate,=C2=A0pl=
ease=C2=A0provide=C2=A0description/analysis=C2=A0why=C2=A0this=C2=A0driver=
=C2=A0cannot=C2=A0be=0D=0A>>>>>=C2=A0=C2=A0combined=C2=A0with=C2=A0existing=
=C2=A0driver.=C2=A0The=C2=A0answer=C2=A0like:=C2=A0we=C2=A0need=C2=A0severa=
l=C2=A0syscon=0D=0A>>>>>=C2=A0=C2=A0because=C2=A0we=C2=A0do=C2=A0not=C2=A0i=
mplement=C2=A0other=C2=A0frameworks=C2=A0(like=C2=A0interconnect)=C2=A0are=
=C2=A0not=0D=0A>>>>>=C2=A0=C2=A0valid.=0D=0A>>>>>=0D=0A>>>>>=C2=A0=C2=A0Bes=
t=C2=A0regards,=0D=0A>>>>>=C2=A0=C2=A0Krzysztof=0D=0A>>>>=C2=A0=C2=A0=0D=0A=
>>>>=C2=A0=C2=A0Hello,=C2=A0Krzysztof=0D=0A>>>>=C2=A0=C2=A0Thanks=C2=A0for=
=C2=A0your=C2=A0review.=0D=0A>>>>=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0patch=23=
2=C2=A0was=C2=A0sent=C2=A0to=C2=A0the=C2=A0wrong=C2=A0format=C2=A0so=C2=A0s=
ent=C2=A0again.=0D=0A>>>>=C2=A0=C2=A0Sorry=C2=A0for=C2=A0causing=C2=A0confu=
sion.=0D=0A>>>=C2=A0=C2=A0=0D=0A>>>=C2=A0The=C2=A0first=C2=A0sending=C2=A0w=
as=C2=A0HTML.=C2=A0Second=C2=A0was=C2=A0broken=C2=A0text,=C2=A0so=C2=A0stil=
l=C2=A0not=C2=A0working.=0D=0A>>>=0D=0A>>>=C2=A0Please=C2=A0resend=C2=A0eve=
rything=C2=A0with=C2=A0proper=C2=A0threading.=0D=0A>>=C2=A0=0D=0A>>=C2=A0He=
llo,=C2=A0Krzysztof=0D=0A>>=C2=A0=0D=0A>>=C2=A0I=C2=A0sent=C2=A0patch=232=
=C2=A0three=C2=A0times.=0D=0A>>=C2=A0due=C2=A0to=C2=A0the=C2=A0influence=C2=
=A0of=C2=A0the=C2=A0email=C2=A0system,=0D=0A>>=C2=A0there=C2=A0was=C2=A0som=
ething=C2=A0wrong=C2=A0with=C2=A0the=C2=A0first=C2=A0and=C2=A0second=C2=A0m=
ails.=0D=0A>>=C2=A0Sorry=C2=A0for=C2=A0causing=C2=A0confusion.=0D=0A>>=C2=
=A0Did=C2=A0you=C2=A0receive=C2=A0the=C2=A0third=C2=A0patch=C2=A0i=C2=A0sen=
t=C2=A0you?=0D=0A>=20=0D=0A>=20Maybe,=C2=A0I=C2=A0don't=C2=A0know.=C2=A0It'=
s=C2=A0not=C2=A0threaded=C2=A0so=C2=A0it's=C2=A0difficult=C2=A0to=C2=A0find=
=C2=A0it=0D=0A>=20among=C2=A0other=C2=A0100=C2=A0emails...=0D=0A=0D=0AI=20t=
hink=20you=20also=20received=20a=20normal=20patch=23=202.=0D=0A=0D=0A>>=C2=
=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0This=C2=A0patch=C2=A0is=C2=A0specialized=C2=
=A0in=C2=A0Artpec-8,=C2=A0=0D=0A>>>>=C2=A0=C2=A0the=C2=A0SoC=C2=A0Platform=
=C2=A0of=C2=A0Axis=C2=A0Communication,=C2=A0and=C2=A0is=C2=A0newly=C2=A0app=
lied.=0D=0A>>>>=C2=A0=C2=A0Since=C2=A0the=C2=A0target=C2=A0SoC=C2=A0platfor=
m=C2=A0is=C2=A0different=C2=A0from=C2=A0the=C2=A0driver=C2=A0previously=C2=
=A0=0D=0A>>>>=C2=A0=C2=A0used=C2=A0by=C2=A0Samsung,=C2=A0it=C2=A0is=C2=A0di=
fficult=C2=A0to=C2=A0merge=C2=A0with=C2=A0the=C2=A0existing=C2=A0driver.=0D=
=0A>>>=0D=0A>>>=C2=A0Recently=C2=A0I=C2=A0always=C2=A0saw=C2=A0such=C2=A0an=
swers=C2=A0and=C2=A0sometimes=C2=A0it=C2=A0was=C2=A0true,=C2=A0sometimes=0D=
=0A>>>=C2=A0not.=C2=A0What=C2=A0is=C2=A0exactly=C2=A0different?=0D=0A>>>=0D=
=0A>>>=C2=A0Best=C2=A0regards,=0D=0A>>>=C2=A0Krzysztof=0D=0A>>=C2=A0=0D=0A>=
>=C2=A0The=C2=A0main=C2=A0reason=C2=A0this=C2=A0patch=C2=A0should=C2=A0be=
=C2=A0added=C2=A0is=C2=A0that=0D=0A>>=C2=A0this=C2=A0patch=C2=A0is=C2=A0not=
=C2=A0the=C2=A0driver=C2=A0applied=C2=A0to=C2=A0exynos=C2=A0platform.=0D=0A=
>=20=0D=0A>=20Still=C2=A0this=C2=A0does=C2=A0not=C2=A0explain=C2=A0why=C2=
=A0you=C2=A0need=C2=A0separate=C2=A0driver.=0D=0A=0D=0APCIe=20driver=20of=
=20artpec-8=20is=20not=20available=20in=20exynos=20platform.=0D=0Abecause=
=20the=20PCIe=20of=20artpec=20and=20exynos=20have=20very=20different=20=0D=
=0Ahardware=20in=20SoC=20design.=0D=0ANot=20only=20it=20is=20the=20SoC=20di=
fferent,=20=0D=0Abut=20the=20hardware=20design=20of=20PCIe=20is=20also=20di=
fferent.=0D=0ATherefore,=20we=20are=20using=20driver's=20compatible=20=0D=
=0Aas=20axis,=20artpec8-pcie=20rather=20than=20samsung,=20artpec8-pcie.=0D=
=0A=0D=0A>>=C2=A0Because=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0is=C2=A0diffe=
rent,=C2=A0=0D=0A>>=C2=A0the=C2=A0IP=C2=A0configuration=C2=A0of=C2=A0PCIe=
=C2=A0is=C2=A0also=C2=A0different.=0D=0A>=20=0D=0A>=20What=C2=A0is=C2=A0exa=
ctly=C2=A0different?=C2=A0Usually=C2=A0drivers=C2=A0can=C2=A0support=C2=A0I=
P=C2=A0blocks=C2=A0with=0D=0A>=20some=C2=A0differences...=0D=0A>=20=0D=0A>>=
=C2=A0We=C2=A0will=C2=A0organize=C2=A0a=C2=A0driver=C2=A0for=C2=A0Artpec-8=
=C2=A0platform=C2=A0and=C2=A0=0D=0A>>=C2=A0if=C2=A0there=C2=A0is=C2=A0no=C2=
=A0special=C2=A0reason,=C2=A0maintain=C2=A0this=C2=A0=0D=0A>>=C2=A0without=
=C2=A0adding=C2=A0it=C2=A0from=C2=A0the=C2=A0next=C2=A0series.=0D=0A>=20=0D=
=0A>=20I=C2=A0don't=C2=A0understand=C2=A0this.=0D=0A>=20=0D=0A>=20=0D=0A>=
=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AAlso,=20as=20you=20know=
,=0D=0Aexynos=20driver=20is=20designed=20according=20to=20exynos=20SoC=20pl=
atform,=0D=0Aso=20both=20function=20and=20variable=20names=20start=20with=
=20exynos.=0D=0ACompared=20to=20the=20existing=20exynos=20driver,=20=0D=0Ay=
ou=20can=20see=20that=20the=20structure=20and=20type=20of=20function=20are=
=20different.=0D=0AFor=20this=20reason,=20it=20is=20difficult=20to=20use=20=
the=20existing=20exynos=20driver=20=0D=0Afor=20artpec.=0D=0AOur=20idea=20is=
=20to=20register=20a=20new=20PCIe=20driver=20for=20artpec-8=20SoC=20platfor=
m=20=0D=0Aand=20maintain=20it=20in=20the=20future.=0D=0A=0D=0AThanks.
