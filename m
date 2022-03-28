Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F314E954C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiC1LlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244067AbiC1LhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 07:37:16 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6724BE7
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 04:29:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220328112922epoutp011ff9a544335bd1590d675e7881bfbe47~gh-fp7Vzg1018710187epoutp01m
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 11:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220328112922epoutp011ff9a544335bd1590d675e7881bfbe47~gh-fp7Vzg1018710187epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648466962;
        bh=vSUewbMNA8HwQeSd5z30bPDEh+33/q5/Gq8I560ttKc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gakbeW79Y0jc0ql5GIXom6Qw7gE0yqON97hvR1zPbFODfr7XRP+uQspLTNW2xKQjJ
         0TxVxEWqATpZMZZ3EQCv0iyxA5D2FaWggKjumLw0kLkJZX2HT/bRHNgOLk1u5zUJM2
         mLSjDVT4VZUyHWhjMhMY0oFlX2qrSdpgvsmJYFiw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220328112921epcas2p1d144d08a77e255896603a159bddc0568~gh-eoj-I71362413624epcas2p1w;
        Mon, 28 Mar 2022 11:29:21 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KRr7f5WN9z4x9Pw; Mon, 28 Mar
        2022 11:29:18 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-7a-62419c0e60bc
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.82.16040.E0C91426; Mon, 28 Mar 2022 20:29:18 +0900 (KST)
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
In-Reply-To: <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
Date:   Mon, 28 Mar 2022 20:29:18 +0900
X-CMS-MailID: 20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmuS7fHMckg1+PNC2WNGVYvDykaTH/
        yDlWi+eHZjFbfGpRtbjwtIfN4uWse2wW589vYLdo6PnNanHkzUdmi/3HVzJZXN41h83i7Lzj
        bBYTVn1jsXjz+wW7xbnFmRate4+wW+y8c4LZQchjzbw1jB7X1wV4LNhU6rFpVSebx5Mr05k8
        Ni+p9+jbsorR4/iN7UwenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9Ar
        TswtLs1L18tLLbEyNDAwMgUqTMjOuHFmF1PBMc2K2Ut0Ghg3aXQxcnJICJhIrOhaxwJiCwns
        YJT4tMKqi5GDg1dAUOLvDmGQsLCAs8S/263MECVKEjvWzGOGiFtLfJpyGayVTcBS4mLrQ8Yu
        Ri4OEYFvTBKzf7xiA3GYBW4zS8x//p4FYhmvxIz2p1C2tMT25VsZQWxOATuJPweeQ8U1JH4s
        62WGsEUlbq5+yw5jvz82nxHCFpFovXcWqkZQ4sHP3VBxKYkFTw6xQtjVEvv//maCsBsYJfrv
        p4I8JiGgL7HjujFImFfAV+J162WwMSwCqhLb1q+BKneR+HD7PlicWUBbYtnC18wgrcwCmhLr
        d+lDTFGWOHIL7qmGjb/Z0dnMAnwSHYf/wsV3zHsCNV1NYt7KncwTGJVnIQJ6FpJdsxB2LWBk
        XsUollpQnJueWmxUYASP2eT83E2M4CSt5baDccrbD3qHGJk4GA8xSnAwK4nwyp61TxLiTUms
        rEotyo8vKs1JLT7EaAr05URmKdHkfGCeyCuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAoJJCeWJKa
        nZpakFoE08fEwSnVwJSf6+jWNLm9XK36/oPytRe8+tWkjHYcUihuiTzN91FbcXqxpNbGpwX9
        N7aEKm4xN4xatNpiYgn7/rkzVMMvtDXdOSVVFsx39mJ6y4sc0ZZtuy9MyFvOf+DruaKlgnrm
        ihvkUjWffq+6P7PTa/nGFAHzKwfZxL9lpZ5c02zNGbXpu9hj28btR8zu9WjOuKrh9fcys/LW
        TV9aud547b4y4cbMCf/4NghfrJvdWXWTWcPP3uzC4WsC/0x8PnBuizqzOlXE9/f/n4czjvmE
        /E5dVKR42kE20Nb3Q8jFSQ2ea6frHhFoc/ikHiCzdfnPzDd/60M3XOnQr26942z6r/p1/zeV
        PstL7eXen05Fns45+FqJpTgj0VCLuag4EQDI7jzTWwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1
References: <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
        <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
        <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
        <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
        <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p4>
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
=202022-03-28=2018:38=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=200/5=
=5D=20Add=20support=20for=20Axis,=20ARTPEC-8=20PCIe=20driver=0D=0A>=20=0D=
=0A>=20On=C2=A028/03/2022=C2=A011:02,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=
=A0wrote:=0D=0A>>>=C2=A0---------=C2=A0Original=C2=A0Message=C2=A0---------=
=0D=0A>>>=C2=A0Sender=C2=A0:=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0<krzk=40ker=
nel.org>=0D=0A>>>=C2=A0Date=C2=A0:=C2=A02022-03-28=C2=A016:12=C2=A0(GMT+9)=
=0D=0A>>>=C2=A0Title=C2=A0:=C2=A0Re:=C2=A0=5BPATCH=C2=A00/5=5D=C2=A0Add=C2=
=A0support=C2=A0for=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0driver=0D=0A>>>=
=0D=0A>>>=C2=A0On=C2=A028/03/2022=C2=A003:44,=C2=A0=EC=9D=B4=EC=99=95=EC=84=
=9D=C2=A0wrote:=0D=0A>>>>=C2=A0=C2=A0This=C2=A0series=C2=A0patches=C2=A0inc=
lude=C2=A0newly=C2=A0PCIe=C2=A0support=C2=A0for=C2=A0Axis=C2=A0ARTPEC-8=C2=
=A0SoC.=0D=0A>>>>=C2=A0=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platfo=
rm=C2=A0of=C2=A0Axis=C2=A0Communications.=0D=0A>>>>=C2=A0=C2=A0PCIe=C2=A0co=
ntroller=C2=A0driver=C2=A0and=C2=A0phy=C2=A0driver=C2=A0have=C2=A0been=C2=
=A0newly=C2=A0added.=0D=0A>>>>=C2=A0=C2=A0There=C2=A0is=C2=A0also=C2=A0a=C2=
=A0new=C2=A0MAINTAINER=C2=A0in=C2=A0the=C2=A0addition=C2=A0of=C2=A0phy=C2=
=A0driver.=0D=0A>>>>=C2=A0=C2=A0PCIe=C2=A0controller=C2=A0is=C2=A0designed=
=C2=A0based=C2=A0on=C2=A0Design-Ware=C2=A0PCIe=C2=A0controller=C2=A0IP=0D=
=0A>>>>=C2=A0=C2=A0and=C2=A0PCIe=C2=A0phy=C2=A0is=C2=A0desinged=C2=A0based=
=C2=A0on=C2=A0SAMSUNG=C2=A0PHY=C2=A0IP.=0D=0A>>>>=C2=A0=C2=A0It=C2=A0also=
=C2=A0includes=C2=A0modifications=C2=A0to=C2=A0the=C2=A0Design-Ware=C2=A0co=
ntroller=C2=A0driver=C2=A0to=C2=A0=0D=0A>>>>=C2=A0=C2=A0run=C2=A0the=C2=A06=
4bit-based=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0controller=C2=A0driver.=0D=0A>>>>=
=C2=A0=C2=A0It=C2=A0consists=C2=A0of=C2=A06=C2=A0patches=C2=A0in=C2=A0total=
.=0D=0A>>>>=C2=A0=C2=A0=0D=0A>>>>=C2=A0=C2=A0This=C2=A0series=C2=A0has=C2=
=A0been=C2=A0tested=C2=A0on=C2=A0AXIS=C2=A0SW=C2=A0bring-up=C2=A0board=C2=
=A0=0D=0A>>>>=C2=A0=C2=A0with=C2=A0ARTPEC-8=C2=A0chipset.=0D=0A>>>=0D=0A>>>=
=C2=A0You=C2=A0lost=C2=A0mail=C2=A0threading.=C2=A0This=C2=A0makes=C2=A0rea=
ding=C2=A0this=C2=A0difficult=C2=A0for=C2=A0us.=C2=A0Plus=0D=0A>>>=C2=A0you=
=C2=A0sent=C2=A0something=C2=A0non-applicable=C2=A0(patch=C2=A0=232),=C2=A0=
so=C2=A0please=C2=A0resend.=0D=0A>>>=0D=0A>>>=C2=A0Knowing=C2=A0recent=C2=
=A0Samsung=C2=A0reluctance=C2=A0to=C2=A0extend=C2=A0existing=C2=A0drivers=
=C2=A0and=C2=A0always=0D=0A>>>=C2=A0duplicate,=C2=A0please=C2=A0provide=C2=
=A0description/analysis=C2=A0why=C2=A0this=C2=A0driver=C2=A0cannot=C2=A0be=
=0D=0A>>>=C2=A0combined=C2=A0with=C2=A0existing=C2=A0driver.=C2=A0The=C2=A0=
answer=C2=A0like:=C2=A0we=C2=A0need=C2=A0several=C2=A0syscon=0D=0A>>>=C2=A0=
because=C2=A0we=C2=A0do=C2=A0not=C2=A0implement=C2=A0other=C2=A0frameworks=
=C2=A0(like=C2=A0interconnect)=C2=A0are=C2=A0not=0D=0A>>>=C2=A0valid.=0D=0A=
>>>=0D=0A>>>=C2=A0Best=C2=A0regards,=0D=0A>>>=C2=A0Krzysztof=0D=0A>>=C2=A0=
=0D=0A>>=C2=A0Hello,=C2=A0Krzysztof=0D=0A>>=C2=A0Thanks=C2=A0for=C2=A0your=
=C2=A0review.=0D=0A>>=C2=A0=0D=0A>>=C2=A0patch=232=C2=A0was=C2=A0sent=C2=A0=
to=C2=A0the=C2=A0wrong=C2=A0format=C2=A0so=C2=A0sent=C2=A0again.=0D=0A>>=C2=
=A0Sorry=C2=A0for=C2=A0causing=C2=A0confusion.=0D=0A>=20=C2=A0=0D=0A>=20The=
=C2=A0first=C2=A0sending=C2=A0was=C2=A0HTML.=C2=A0Second=C2=A0was=C2=A0brok=
en=C2=A0text,=C2=A0so=C2=A0still=C2=A0not=C2=A0working.=0D=0A>=20=0D=0A>=20=
Please=C2=A0resend=C2=A0everything=C2=A0with=C2=A0proper=C2=A0threading.=0D=
=0A=0D=0AHello,=20Krzysztof=0D=0A=0D=0AI=20sent=20patch=232=20three=20times=
.=0D=0Adue=20to=20the=20influence=20of=20the=20email=20system,=0D=0Athere=
=20was=20something=20wrong=20with=20the=20first=20and=20second=20mails.=0D=
=0ASorry=20for=20causing=20confusion.=0D=0ADid=20you=20receive=20the=20thir=
d=20patch=20i=20sent=20you?=0D=0A=20=0D=0A>>=C2=A0This=C2=A0patch=C2=A0is=
=C2=A0specialized=C2=A0in=C2=A0Artpec-8,=C2=A0=0D=0A>>=C2=A0the=C2=A0SoC=C2=
=A0Platform=C2=A0of=C2=A0Axis=C2=A0Communication,=C2=A0and=C2=A0is=C2=A0new=
ly=C2=A0applied.=0D=0A>>=C2=A0Since=C2=A0the=C2=A0target=C2=A0SoC=C2=A0plat=
form=C2=A0is=C2=A0different=C2=A0from=C2=A0the=C2=A0driver=C2=A0previously=
=C2=A0=0D=0A>>=C2=A0used=C2=A0by=C2=A0Samsung,=C2=A0it=C2=A0is=C2=A0difficu=
lt=C2=A0to=C2=A0merge=C2=A0with=C2=A0the=C2=A0existing=C2=A0driver.=0D=0A>=
=20=0D=0A>=20Recently=C2=A0I=C2=A0always=C2=A0saw=C2=A0such=C2=A0answers=C2=
=A0and=C2=A0sometimes=C2=A0it=C2=A0was=C2=A0true,=C2=A0sometimes=0D=0A>=20n=
ot.=C2=A0What=C2=A0is=C2=A0exactly=C2=A0different?=0D=0A>=20=0D=0A>=20Best=
=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AThe=20main=20reason=20this=20p=
atch=20should=20be=20added=20is=20that=0D=0Athis=20patch=20is=20not=20the=
=20driver=20applied=20to=20exynos=20platform.=0D=0ABecause=20the=20SoC=20pl=
atform=20is=20different,=20=0D=0Athe=20IP=20configuration=20of=20PCIe=20is=
=20also=20different.=0D=0AWe=20will=20organize=20a=20driver=20for=20Artpec-=
8=20platform=20and=20=0D=0Aif=20there=20is=20no=20special=20reason,=20maint=
ain=20this=20=0D=0Awithout=20adding=20it=20from=20the=20next=20series.=0D=
=0A=0D=0AThank=20you.
