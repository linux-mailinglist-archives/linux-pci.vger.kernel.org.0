Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B395504D28
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiDRHXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiDRHXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 03:23:39 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046313CD3
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 00:20:59 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220418072054epoutp0150af7a97f3f6a289cf7c14990b1cb19a~m7Ji63AVU1947319473epoutp01i
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 07:20:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220418072054epoutp0150af7a97f3f6a289cf7c14990b1cb19a~m7Ji63AVU1947319473epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650266454;
        bh=YYtRa5V6YFOQcb0Dnb1EWlf8BLba7dBd1YOsZoRaqGg=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=R3sZ/kYI0dAF69UFjK0TFWIMdS+SaeFMGIZb6bqwKnicAkHjDmPPfTHfdg9szjPR+
         qi8BqcARw+Wqu8MgpQFzZjrXheMo+YqsKetWMQgWGFNpB/rV+tDAuWw8U/I3YzwzQ3
         vPwIeiKSR6ww7bc5OLM9JQog3FlB/T8NiUMl3eWo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220418072053epcas2p40c34b72d4534b5a70682d784f52aa5b5~m7JiQaIAe0288902889epcas2p4U;
        Mon, 18 Apr 2022 07:20:53 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KhddG0R6Bz4x9Q3; Mon, 18 Apr
        2022 07:20:50 +0000 (GMT)
X-AuditID: b6c32a46-ba1ff70000009dd5-1e-625d11513e80
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.F2.40405.1511D526; Mon, 18 Apr 2022 16:20:49 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        robh+dt <robh+dt@kernel.org>, krzk+dt <krzk+dt@kernel.org>,
        kishon <kishon@ti.com>, vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>
CC:     bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
Date:   Mon, 18 Apr 2022 16:20:49 +0900
X-CMS-MailID: 20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmuW6gYGySwbRVxhZLmjIsXh7StJh/
        5Byrxe4Zy5ksnh+axWzxqUXV4sLTHjaLl7PusVmcP7+B3aKh5zerxZE3H5kt9h9fyWRxedcc
        Nouz846zWUxY9Y3F4s3vF+wW5xZnWrTuPcJusfPOCWYHYY8189YwelxfF+CxYFOpx6ZVnWwe
        T65MZ/LYvKTeo2/LKkaP4ze2M3l83iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
        qGtoaWGupJCXmJtqq+TiE6DrlpkD9I+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
        p8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjS+syxoJbcRWPTr1ha2CcEdPFyMkhIWAicWfu
        XKYuRi4OIYEdjBIXf/SxdTFycPAKCEr83SEMUiMs4Czx73YrM4gtJKAksWPNPGaIuL7E9RXd
        rCA2m4CuxL/FL9lA5ogILGCSuD93BthQZoH/TBKvGo+xQWzjlZjR/pQFwpaW2L58KyOErSHx
        Y1kvM4QtKnFz9Vt2GPv9sflQNSISrffOQtUISjz4uRsqLiWx4MkhVgi7WmL/399MEHYDo0T/
        /VSQZySALt1x3RgkzCvgKzGnqRHsHBYBVYlbU7uhznGR2PKtHWwks4C2xLKFr5lBWpkFNCXW
        79KHmKIsceQWC8wjDRt/s6OzmQX4JDoO/4WL75j3BOoYNYl5K3cyQ4yRkdj60n8Co9IsRDjP
        QrJ2FsLaBYzMqxjFUguKc9NTi40KjOBRm5yfu4kRnLC13HYwTnn7Qe8QIxMH4yFGCQ5mJRHe
        niXRSUK8KYmVValF+fFFpTmpxYcYTYEensgsJZqcD8wZeSXxhiaWBiZmZobmRqYG5krivF4p
        GxKFBNITS1KzU1MLUotg+pg4OKUamGx9OFa95doc5LeDd3FpYfHEV3PjDjXs2/vr94o7iprb
        ZnZH52/5KxjaPHvi0TC3qrkBE2bdM3u+oM9tt2TEiT9eDgqf/j3IzXKr01e4qVWYvfBFdHyf
        QPqZfP37sgVyEyf/tSubnOh8w6nyzfyCLZ801dd+Dv9zmLO2auPK9a8av3i9XG9+U1HBupDD
        9NAxaekZVzO27f2t8oHn5HwXsWqV+KC9c5rNEr59Vn/1+JxJ2QON1Or7rBd3XdiQzK3/+3RN
        l//xKyoe15NsEuZrpIftOGrxYpfahoQTa6dcy/T6//NMZ/GDjbbTlZ4o+n1z+86wMW5RUccU
        xl8pBQc2B3kbHlfXYhJXPWGV4S7ts1aJpTgj0VCLuag4EQBc2jCiYQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1
References: <CGME20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Krzysztof Kozlowski=C2=A0=0D=0A>=20Date=20:=202022-03-29=2015:41=
=20(GMT+09:00)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=200/5=5D=20Add=20support=
=20for=20Axis,=20ARTPEC-8=20PCIe=20driver=0D=0A>=20=C2=A0=0D=0A>=20On=C2=A0=
29/03/2022=C2=A005:49,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrote:=0D=0A>>=
>=C2=A0---------=C2=A0Original=C2=A0Message=C2=A0---------=0D=0A>>>=C2=A0Se=
nder=C2=A0:=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0=0D=0A>>>=20Date=20:=202022-=
03-28=2020:44=20(GMT+9)=0D=0A>>>=20Title=20:=20Re:=20=5BPATCH=200/5=5D=20Ad=
d=20support=20for=20Axis,=20ARTPEC-8=20PCIe=20driver=0D=0A>>>=0D=0A>>>=20On=
=C2=A028/03/2022=C2=A013:29,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrote:=
=0D=0A>>>>>=20=C2=A0---------=C2=A0Original=C2=A0Message=C2=A0---------=0D=
=0A>>>>>=20=C2=A0Sender=C2=A0:=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0=0D=0A>>>=
>>=20=C2=A0Date=C2=A0:=C2=A02022-03-28=C2=A018:38=C2=A0(GMT+9)=0D=0A>>>>>=
=20=C2=A0Title=C2=A0:=C2=A0Re:=C2=A0=5BPATCH=C2=A00/5=5D=C2=A0Add=C2=A0supp=
ort=C2=A0for=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0driver=0D=0A>>>>>=0D=
=0A>>>>>=20=C2=A0On=C2=A028/03/2022=C2=A011:02,=C2=A0=EC=9D=B4=EC=99=95=EC=
=84=9D=C2=A0wrote:=0D=0A>>>>>>>=20=C2=A0=C2=A0---------=C2=A0Original=C2=A0=
Message=C2=A0---------=0D=0A>>>>>>>=20=C2=A0=C2=A0Sender=C2=A0:=C2=A0Krzysz=
tof=C2=A0Kozlowski=C2=A0=0D=0A>>>>>>>=20=C2=A0=C2=A0Date=C2=A0:=C2=A02022-0=
3-28=C2=A016:12=C2=A0(GMT+9)=0D=0A>>>>>>>=20=C2=A0=C2=A0Title=C2=A0:=C2=A0R=
e:=C2=A0=5BPATCH=C2=A00/5=5D=C2=A0Add=C2=A0support=C2=A0for=C2=A0Axis,=C2=
=A0ARTPEC-8=C2=A0PCIe=C2=A0driver=0D=0A>>>>>>>=0D=0A>>>>>>>=20=C2=A0=C2=A0O=
n=C2=A028/03/2022=C2=A003:44,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrote:=
=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0This=C2=A0series=C2=A0patches=C2=A0inclu=
de=C2=A0newly=C2=A0PCIe=C2=A0support=C2=A0for=C2=A0Axis=C2=A0ARTPEC-8=C2=A0=
SoC.=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=
=C2=A0platform=C2=A0of=C2=A0Axis=C2=A0Communications.=0D=0A>>>>>>>>=20=C2=
=A0=C2=A0=C2=A0PCIe=C2=A0controller=C2=A0driver=C2=A0and=C2=A0phy=C2=A0driv=
er=C2=A0have=C2=A0been=C2=A0newly=C2=A0added.=0D=0A>>>>>>>>=20=C2=A0=C2=A0=
=C2=A0There=C2=A0is=C2=A0also=C2=A0a=C2=A0new=C2=A0MAINTAINER=C2=A0in=C2=A0=
the=C2=A0addition=C2=A0of=C2=A0phy=C2=A0driver.=0D=0A>>>>>>>>=20=C2=A0=C2=
=A0=C2=A0PCIe=C2=A0controller=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=
=A0Design-Ware=C2=A0PCIe=C2=A0controller=C2=A0IP=0D=0A>>>>>>>>=20=C2=A0=C2=
=A0=C2=A0and=C2=A0PCIe=C2=A0phy=C2=A0is=C2=A0desinged=C2=A0based=C2=A0on=C2=
=A0SAMSUNG=C2=A0PHY=C2=A0IP.=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0It=C2=A0also=
=C2=A0includes=C2=A0modifications=C2=A0to=C2=A0the=C2=A0Design-Ware=C2=A0co=
ntroller=C2=A0driver=C2=A0to=C2=A0=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0run=C2=
=A0the=C2=A064bit-based=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0controller=C2=A0driver=
.=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0It=C2=A0consists=C2=A0of=C2=A06=C2=A0pa=
tches=C2=A0in=C2=A0total.=0D=0A>>>>>>>>=20=C2=A0=C2=A0=C2=A0=0D=0A>>>>>>>>=
=20=C2=A0=C2=A0=C2=A0This=C2=A0series=C2=A0has=C2=A0been=C2=A0tested=C2=A0o=
n=C2=A0AXIS=C2=A0SW=C2=A0bring-up=C2=A0board=C2=A0=0D=0A>>>>>>>>=20=C2=A0=
=C2=A0=C2=A0with=C2=A0ARTPEC-8=C2=A0chipset.=0D=0A>>>>>>>=0D=0A>>>>>>>=20=
=C2=A0=C2=A0You=C2=A0lost=C2=A0mail=C2=A0threading.=C2=A0This=C2=A0makes=C2=
=A0reading=C2=A0this=C2=A0difficult=C2=A0for=C2=A0us.=C2=A0Plus=0D=0A>>>>>>=
>=20=C2=A0=C2=A0you=C2=A0sent=C2=A0something=C2=A0non-applicable=C2=A0(patc=
h=C2=A0=232),=C2=A0so=C2=A0please=C2=A0resend.=0D=0A>>>>>>>=0D=0A>>>>>>>=20=
=C2=A0=C2=A0Knowing=C2=A0recent=C2=A0Samsung=C2=A0reluctance=C2=A0to=C2=A0e=
xtend=C2=A0existing=C2=A0drivers=C2=A0and=C2=A0always=0D=0A>>>>>>>=20=C2=A0=
=C2=A0duplicate,=C2=A0please=C2=A0provide=C2=A0description/analysis=C2=A0wh=
y=C2=A0this=C2=A0driver=C2=A0cannot=C2=A0be=0D=0A>>>>>>>=20=C2=A0=C2=A0comb=
ined=C2=A0with=C2=A0existing=C2=A0driver.=C2=A0The=C2=A0answer=C2=A0like:=
=C2=A0we=C2=A0need=C2=A0several=C2=A0syscon=0D=0A>>>>>>>=20=C2=A0=C2=A0beca=
use=C2=A0we=C2=A0do=C2=A0not=C2=A0implement=C2=A0other=C2=A0frameworks=C2=
=A0(like=C2=A0interconnect)=C2=A0are=C2=A0not=0D=0A>>>>>>>=20=C2=A0=C2=A0va=
lid.=0D=0A>>>>>>>=0D=0A>>>>>>>=20=C2=A0=C2=A0Best=C2=A0regards,=0D=0A>>>>>>=
>=20=C2=A0=C2=A0Krzysztof=0D=0A>>>>>>=20=C2=A0=C2=A0=0D=0A>>>>>>=20=C2=A0=
=C2=A0Hello,=C2=A0Krzysztof=0D=0A>>>>>>=20=C2=A0=C2=A0Thanks=C2=A0for=C2=A0=
your=C2=A0review.=0D=0A>>>>>>=20=C2=A0=C2=A0=0D=0A>>>>>>=20=C2=A0=C2=A0patc=
h=232=C2=A0was=C2=A0sent=C2=A0to=C2=A0the=C2=A0wrong=C2=A0format=C2=A0so=C2=
=A0sent=C2=A0again.=0D=0A>>>>>>=20=C2=A0=C2=A0Sorry=C2=A0for=C2=A0causing=
=C2=A0confusion.=0D=0A>>>>>=20=C2=A0=C2=A0=0D=0A>>>>>=20=C2=A0The=C2=A0firs=
t=C2=A0sending=C2=A0was=C2=A0HTML.=C2=A0Second=C2=A0was=C2=A0broken=C2=A0te=
xt,=C2=A0so=C2=A0still=C2=A0not=C2=A0working.=0D=0A>>>>>=0D=0A>>>>>=20=C2=
=A0Please=C2=A0resend=C2=A0everything=C2=A0with=C2=A0proper=C2=A0threading.=
=0D=0A>>>>=20=C2=A0=0D=0A>>>>=20=C2=A0Hello,=C2=A0Krzysztof=0D=0A>>>>=20=C2=
=A0=0D=0A>>>>=20=C2=A0I=C2=A0sent=C2=A0patch=232=C2=A0three=C2=A0times.=0D=
=0A>>>>=20=C2=A0due=C2=A0to=C2=A0the=C2=A0influence=C2=A0of=C2=A0the=C2=A0e=
mail=C2=A0system,=0D=0A>>>>=20=C2=A0there=C2=A0was=C2=A0something=C2=A0wron=
g=C2=A0with=C2=A0the=C2=A0first=C2=A0and=C2=A0second=C2=A0mails.=0D=0A>>>>=
=20=C2=A0Sorry=C2=A0for=C2=A0causing=C2=A0confusion.=0D=0A>>>>=20=C2=A0Did=
=C2=A0you=C2=A0receive=C2=A0the=C2=A0third=C2=A0patch=C2=A0i=C2=A0sent=C2=
=A0you?=0D=0A>>>=0D=0A>>>=20Maybe,=C2=A0I=C2=A0don't=C2=A0know.=C2=A0It's=
=C2=A0not=C2=A0threaded=C2=A0so=C2=A0it's=C2=A0difficult=C2=A0to=C2=A0find=
=C2=A0it=0D=0A>>>=20among=C2=A0other=C2=A0100=C2=A0emails...=0D=0A>>=20=0D=
=0A>>=20I=20think=20you=20also=20received=20a=20normal=20patch=23=202.=0D=
=0A>>=20=0D=0A>>>>=20=C2=A0=C2=A0=0D=0A>>>>>>=20=C2=A0=C2=A0This=C2=A0patch=
=C2=A0is=C2=A0specialized=C2=A0in=C2=A0Artpec-8,=C2=A0=0D=0A>>>>>>=20=C2=A0=
=C2=A0the=C2=A0SoC=C2=A0Platform=C2=A0of=C2=A0Axis=C2=A0Communication,=C2=
=A0and=C2=A0is=C2=A0newly=C2=A0applied.=0D=0A>>>>>>=20=C2=A0=C2=A0Since=C2=
=A0the=C2=A0target=C2=A0SoC=C2=A0platform=C2=A0is=C2=A0different=C2=A0from=
=C2=A0the=C2=A0driver=C2=A0previously=C2=A0=0D=0A>>>>>>=20=C2=A0=C2=A0used=
=C2=A0by=C2=A0Samsung,=C2=A0it=C2=A0is=C2=A0difficult=C2=A0to=C2=A0merge=C2=
=A0with=C2=A0the=C2=A0existing=C2=A0driver.=0D=0A>>>>>=0D=0A>>>>>=20=C2=A0R=
ecently=C2=A0I=C2=A0always=C2=A0saw=C2=A0such=C2=A0answers=C2=A0and=C2=A0so=
metimes=C2=A0it=C2=A0was=C2=A0true,=C2=A0sometimes=0D=0A>>>>>=20=C2=A0not.=
=C2=A0What=C2=A0is=C2=A0exactly=C2=A0different?=0D=0A>>>>>=0D=0A>>>>>=20=C2=
=A0Best=C2=A0regards,=0D=0A>>>>>=20=C2=A0Krzysztof=0D=0A>>>>=20=C2=A0=0D=0A=
>>>>=20=C2=A0The=C2=A0main=C2=A0reason=C2=A0this=C2=A0patch=C2=A0should=C2=
=A0be=C2=A0added=C2=A0is=C2=A0that=0D=0A>>>>=20=C2=A0this=C2=A0patch=C2=A0i=
s=C2=A0not=C2=A0the=C2=A0driver=C2=A0applied=C2=A0to=C2=A0exynos=C2=A0platf=
orm.=0D=0A>>>=0D=0A>>>=20Still=C2=A0this=C2=A0does=C2=A0not=C2=A0explain=C2=
=A0why=C2=A0you=C2=A0need=C2=A0separate=C2=A0driver.=0D=0A>>=20=0D=0A>>=20P=
CIe=20driver=20of=20artpec-8=20is=20not=20available=20in=20exynos=20platfor=
m.=0D=0A>>=20because=20the=20PCIe=20of=20artpec=20and=20exynos=20have=20ver=
y=20different=20=0D=0A>>=20hardware=20in=20SoC=20design.=0D=0A>>=20Not=20on=
ly=20it=20is=20the=20SoC=20different,=20=0D=0A>>=20but=20the=20hardware=20d=
esign=20of=20PCIe=20is=20also=20different.=0D=0A>>=20Therefore,=20we=20are=
=20using=20driver's=20compatible=20=0D=0A>>=20as=20axis,=20artpec8-pcie=20r=
ather=20than=20samsung,=20artpec8-pcie.=0D=0A>=20=0D=0A>=20You=20keep=20rep=
eating=20the=20same=20over=20and=20over.=20What=20is=20different?=20Drivers=
=0D=0A>=20can=20support=20different=20devices,=20I=20already=20wrote=20it.=
=20Just=20because=20device=0D=0A>=20is=20different=20does=20not=20mean=20it=
=20should=20have=20separate=20driver.=0D=0A>=20=0D=0A>>=20=0D=0A>>>>=20=C2=
=A0Because=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0is=C2=A0different,=C2=A0=0D=
=0A>>>>=20=C2=A0the=C2=A0IP=C2=A0configuration=C2=A0of=C2=A0PCIe=C2=A0is=C2=
=A0also=C2=A0different.=0D=0A>>>=0D=0A>>>=20What=C2=A0is=C2=A0exactly=C2=A0=
different?=C2=A0Usually=C2=A0drivers=C2=A0can=C2=A0support=C2=A0IP=C2=A0blo=
cks=C2=A0with=0D=0A>>>=20some=C2=A0differences...=0D=0A>>>=0D=0A>>>>=20=C2=
=A0We=C2=A0will=C2=A0organize=C2=A0a=C2=A0driver=C2=A0for=C2=A0Artpec-8=C2=
=A0platform=C2=A0and=C2=A0=0D=0A>>>>=20=C2=A0if=C2=A0there=C2=A0is=C2=A0no=
=C2=A0special=C2=A0reason,=C2=A0maintain=C2=A0this=C2=A0=0D=0A>>>>=20=C2=A0=
without=C2=A0adding=C2=A0it=C2=A0from=C2=A0the=C2=A0next=C2=A0series.=0D=0A=
>>>=0D=0A>>>=20I=C2=A0don't=C2=A0understand=C2=A0this.=0D=0A>>>=0D=0A>>>=0D=
=0A>>>=20Best=C2=A0regards,=0D=0A>>>=20Krzysztof=0D=0A>>=20=0D=0A>>=20Also,=
=20as=20you=20know,=0D=0A>>=20exynos=20driver=20is=20designed=20according=
=20to=20exynos=20SoC=20platform,=0D=0A>>=20so=20both=20function=20and=20var=
iable=20names=20start=20with=20exynos.=0D=0A>=20=0D=0A>=20That's=20hardly=
=20a=20problem...=0D=0A>=20=0D=0A>>=20Compared=20to=20the=20existing=20exyn=
os=20driver,=20=0D=0A>>=20you=20can=20see=20that=20the=20structure=20and=20=
type=20of=20function=20are=20different.=0D=0A>=20=0D=0A>=20No,=20I=20cannot=
=20see=20it.=20You=20coded=20the=20driver=20that=20way,=20you=20can=20code=
=20it=20in=0D=0A>=20other=20way.=0D=0A>=20=0D=0A>>=20For=20this=20reason,=
=20it=20is=20difficult=20to=20use=20the=20existing=20exynos=20driver=20=0D=
=0A>>=20for=20artpec.=0D=0A>=20=0D=0A>=20Naming=20of=20functions=20and=20st=
ructures=20is=20not=20making=20it=20difficult.=20That's=0D=0A>=20not=20the=
=20reason.=0D=0A>=20=0D=0A>>=20Our=20idea=20is=20to=20register=20a=20new=20=
PCIe=20driver=20for=20artpec-8=20SoC=20platform=20=0D=0A>>=20and=20maintain=
=20it=20in=20the=20future.=0D=0A>=20=0D=0A>=20We=20also=20want=20to=20maint=
ain=20Exynos=20PCIe=20driver=20in=20the=20future.=0D=0A>=20=0D=0A>=20Best=
=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AHi,=20=0D=0ASorry=20for=20delay=
=20response.=0D=0AI=20have=20listed=20some=20parts=20that=20are=20different=
=20from=20exynos=20pcie=20driver.=0D=0A=0D=0APHY=20driver=0D=0APHY=20is=20d=
ifferent,=20so=20register=20map=20is=20also=20different.=0D=0AThree=20refer=
ence=20clock=20options=20are=20available=20in=20ARTPEC-8.=0D=0A=20=20It=20o=
perates=20by=20selecting=20one=20clock=20among=20XO,=20IO,=20and=20SOC=20PL=
L.=0D=0A=20=20However,=20the=20exynos=20phy=20driver=20sets=20one=20ref=20c=
lk=20though=20sysreg.=0D=0AThe=20reset=20method=20and=20type=20of=20PHY=20f=
or=20initialization=20are=20different.=0D=0AThe=20overall=20sysreg=20config=
uration=20is=20different=0D=0AArtpec-8=20requires=20a=20separate=20sequence=
=20for=20phy=20tuning,=0D=0Abut=20it=20does=20not=20exist=20in=20exynos=20p=
hy=20driver.=0D=0AArtpec-8=20requires=20pcs=20resources,=20but=20exynos=20p=
hy=20driver=20does=20not=20exist.=0D=0A=0D=0AController=20driver=0D=0ASub=
=20controller=20is=20different,=20so=20register=20map=20is=20also=20differe=
nt.=0D=0AAnd=20it=20is=20different=20handles=20lane=20control,=20link=20con=
trol,=20PHY=20clocking,=0D=0Areset,=20interrupt=20control.=20=0D=0AThe=20nu=
mber=20and=20type=20of=20clock=20resources=20used=20are=20different.=0D=0AT=
he=20overall=20sysreg=20configuration=20is=20different=0D=0A=0D=0AAlso=20ar=
tpec-8=20is=20performed=20in=20dual=20mode=20that=20supports=20both=20RC=20=
and=20EP.=0D=0AAs=20described=20above,=20the=20PHY=20and=20sub=20ontroller=
=20are=20different=0D=0Aand=20the=20regiser=20map=20is=20different.=0D=0Asy=
sreg=20is=20also=20different.=20And=20there=20are=20differences=20such=20as=
=20reset.=0D=0AThe=20driver=20will=20be=20much=20more=20complicated=20if=20=
both=20hardwares=20should=20be=0D=0Asupported=20in=20the=20same=20driver.=
=0D=0AFor=20these=20reasons,=20my=20opinion=20is=20that=20better=20to=20cre=
ate=0D=0Aa=20phy,=20controller=20both=20driver=20with=20a=20new=20file.=0D=
=0APlease=20let=20me=20know=20your=20opinion.=0D=0A=0D=0AThank=20you.
