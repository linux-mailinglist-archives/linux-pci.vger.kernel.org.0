Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD054E90AD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiC1JDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiC1JDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 05:03:49 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659404EA25
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:02:08 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220328090205epoutp0250d34ff17c361d8451269d82c6ee551f~gf_6CsVsL2340023400epoutp02y
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 09:02:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220328090205epoutp0250d34ff17c361d8451269d82c6ee551f~gf_6CsVsL2340023400epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648458126;
        bh=eF3iknj3DFZy4JaEdicp6aGFJOG1Z9lY5FCFTX5urrE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=B9OytBArcn6xcmhvJc/CvP/GJ5t4XRHf5+aXhrHxzRcnO/UjP1ce3pLuUQLAetGWE
         ZcfgxVCvCgB4JPdbPJ6P44fS6QswJ2a/t0GxZA8qDtQMQXJUl5/I9ajrNWmorf7j93
         q8lyI63NfqIlN12Ls+32mVvJj70ZA+wUcL+g50Rk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220328090205epcas2p46d90d925fa6c81d906e1c5c372b2a6d5~gf_5WBIOh2027020270epcas2p4s;
        Mon, 28 Mar 2022 09:02:05 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KRmsj6GtHz4x9QT; Mon, 28 Mar
        2022 09:02:01 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-a2-62417988c360
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.7A.25540.88971426; Mon, 28 Mar 2022 18:02:00 +0900 (KST)
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
In-Reply-To: <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
Date:   Mon, 28 Mar 2022 18:02:00 +0900
X-CMS-MailID: 20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmmW5HpWOSwcKnBhZLmjIsXh7StJh/
        5ByrxfNDs5gtPrWoWlx42sNm8XLWPTaL8+c3sFs09PxmtTjy5iOzxf7jK5ksLu+aw2Zxdt5x
        NosJq76xWLz5/YLd4tziTIvWvUfYLXbeOcHsIOSxZt4aRo/r6wI8Fmwq9di0qpPN48mV6Uwe
        m5fUe/RtWcXocfzGdiaPz5vkAjijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgF5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gV
        J+YWl+al6+WlllgZGhgYmQIVJmRn/PnwnKlgnkTFvf1zWBoYj4h3MXJySAiYSFz4sImxi5GL
        Q0hgB6PE90X7gBwODl4BQYm/O4RBaoQFnCX+3W5lBrGFBJQkdqyZxwwRt5b4NOUyC4jNJmAp
        cbH1IdgcEYFvTBKzf7xiA3GYBW4zS8x//p4FYhuvxIz2p1C2tMT25VsZQWxOATuJD997WCHi
        GhI/lvUyQ9iiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg526ouJTEgieHoOZUS+z/+5sJwm5g
        lOi/nwrymISAvsSO68YgYV4BX4me6fvASlgEVIF+74Na5SJxauI0MJtZQFti2cLXzCCtzAKa
        Eut36UNMUZY4cgvuqYaNv9nR2cwCfBIdh//CxXfMewJ1jJrEvJU7mScwKs9CBPQsJLtmIexa
        wMi8ilEstaA4Nz212KjAGB63yfm5mxjBiVrLfQfjjLcf9A4xMnEwHmKU4GBWEuGVPWufJMSb
        klhZlVqUH19UmpNafIjRFOjLicxSosn5wFyRVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2x
        JDU7NbUgtQimj4mDU6qBKSbZyKc810Pt4bHASe8fnha75MIhtXTRnF07/91eIeTwX1trE8uM
        A28DYtUTHrlGae9WrzW1qP7Tl1DJLLBw4YNUPi2rOu6lvatXf2jYfMs6s19kt+YjiyVTqzt1
        /xkcDno0Yd3ej884IpczfEzPesud2e4b5uZ0+bXXm/1TfWXnmx9srLu+cY0Dm+meq/OOWDa6
        iZQHS8uXP9a3O/JrT8vCsm9/vhbwr5/i2bn0/qm1R5tXT+86/+L2U/aZkv3u/yQOl+un7Wds
        miM/+b7VuflFV622/Ap927zIX0hH8+XMbWrT/+ssP5fxyaupfdOTeybld259nP0nK7/ZTI79
        f2NlZNoy+R9mLwqXeXob3FViKc5INNRiLipOBACCdAQSXQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1
References: <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
        <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
        <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p8>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Krzysztof Kozlowski=C2=A0<krzk=40kernel.org>=0D=0A>=20Date=20:=
=202022-03-28=2016:12=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=200/5=
=5D=20Add=20support=20for=20Axis,=20ARTPEC-8=20PCIe=20driver=0D=0A>=20=0D=
=0A>=20On=C2=A028/03/2022=C2=A003:44,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=
=A0wrote:=0D=0A>=20>=C2=A0This=C2=A0series=C2=A0patches=C2=A0include=C2=A0n=
ewly=C2=A0PCIe=C2=A0support=C2=A0for=C2=A0Axis=C2=A0ARTPEC-8=C2=A0SoC.=0D=
=0A>=20>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=
=A0Axis=C2=A0Communications.=0D=0A>=20>=C2=A0PCIe=C2=A0controller=C2=A0driv=
er=C2=A0and=C2=A0phy=C2=A0driver=C2=A0have=C2=A0been=C2=A0newly=C2=A0added.=
=0D=0A>=20>=C2=A0There=C2=A0is=C2=A0also=C2=A0a=C2=A0new=C2=A0MAINTAINER=C2=
=A0in=C2=A0the=C2=A0addition=C2=A0of=C2=A0phy=C2=A0driver.=0D=0A>=20>=C2=A0=
PCIe=C2=A0controller=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0Design-W=
are=C2=A0PCIe=C2=A0controller=C2=A0IP=0D=0A>=20>=C2=A0and=C2=A0PCIe=C2=A0ph=
y=C2=A0is=C2=A0desinged=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY=C2=A0IP.=
=0D=0A>=20>=C2=A0It=C2=A0also=C2=A0includes=C2=A0modifications=C2=A0to=C2=
=A0the=C2=A0Design-Ware=C2=A0controller=C2=A0driver=C2=A0to=C2=A0=0D=0A>=20=
>=C2=A0run=C2=A0the=C2=A064bit-based=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0controlle=
r=C2=A0driver.=0D=0A>=20>=C2=A0It=C2=A0consists=C2=A0of=C2=A06=C2=A0patches=
=C2=A0in=C2=A0total.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0This=C2=A0series=C2=
=A0has=C2=A0been=C2=A0tested=C2=A0on=C2=A0AXIS=C2=A0SW=C2=A0bring-up=C2=A0b=
oard=C2=A0=0D=0A>=20>=C2=A0with=C2=A0ARTPEC-8=C2=A0chipset.=0D=0A>=20=0D=0A=
>=20You=C2=A0lost=C2=A0mail=C2=A0threading.=C2=A0This=C2=A0makes=C2=A0readi=
ng=C2=A0this=C2=A0difficult=C2=A0for=C2=A0us.=C2=A0Plus=0D=0A>=20you=C2=A0s=
ent=C2=A0something=C2=A0non-applicable=C2=A0(patch=C2=A0=232),=C2=A0so=C2=
=A0please=C2=A0resend.=0D=0A>=20=0D=0A>=20Knowing=C2=A0recent=C2=A0Samsung=
=C2=A0reluctance=C2=A0to=C2=A0extend=C2=A0existing=C2=A0drivers=C2=A0and=C2=
=A0always=0D=0A>=20duplicate,=C2=A0please=C2=A0provide=C2=A0description/ana=
lysis=C2=A0why=C2=A0this=C2=A0driver=C2=A0cannot=C2=A0be=0D=0A>=20combined=
=C2=A0with=C2=A0existing=C2=A0driver.=C2=A0The=C2=A0answer=C2=A0like:=C2=A0=
we=C2=A0need=C2=A0several=C2=A0syscon=0D=0A>=20because=C2=A0we=C2=A0do=C2=
=A0not=C2=A0implement=C2=A0other=C2=A0frameworks=C2=A0(like=C2=A0interconne=
ct)=C2=A0are=C2=A0not=0D=0A>=20valid.=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=
=0D=0A>=20Krzysztof=0D=0A=0D=0AHello,=20Krzysztof=0D=0AThanks=20for=20your=
=20review.=0D=0A=0D=0Apatch=232=20was=20sent=20to=20the=20wrong=20format=20=
so=20sent=20again.=0D=0ASorry=20for=20causing=20confusion.=0D=0A=0D=0AThis=
=20patch=20is=20specialized=20in=20Artpec-8,=20=0D=0Athe=20SoC=20Platform=
=20of=20Axis=20Communication,=20and=20is=20newly=20applied.=0D=0ASince=20th=
e=20target=20SoC=20platform=20is=20different=20from=20the=20driver=20previo=
usly=20=0D=0Aused=20by=20Samsung,=20it=20is=20difficult=20to=20merge=20with=
=20the=20existing=20driver.=0D=0A=0D=0AThanks.
