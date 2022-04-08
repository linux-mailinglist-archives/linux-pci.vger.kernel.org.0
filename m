Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124084F8D89
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiDHFfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiDHFfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 01:35:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80DB1A91
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 22:32:56 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220408053251epoutp0482b48a46fd45559fba68c0fcf5f77bc6~j1OWWFUqh2821328213epoutp04j
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 05:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220408053251epoutp0482b48a46fd45559fba68c0fcf5f77bc6~j1OWWFUqh2821328213epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649395971;
        bh=Lc+Qq8U7mqQjLpZb//qUlsfu0ffmHEEuJu5KkBVKAPg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=qBTNIObRiNz4HBo0xHVNYfa/JRJ3TBH48ZQ993gwMtzfmdjTQj5lmJvV1sm5OCdAL
         FtEnU5Pght7nnsi6Rp44CRxyTc4M76HYe9RJsY6aF7K15tP6HrMOS/XIn42gotsB8r
         6ZpZIqZJNIjgYxVdHSb6hzCvOl33/Z7L0Z1Ko+OQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220408053250epcas2p3c9e8b42ed95fbbfb4e957c9c9953973b~j1OVpAC_O0922709227epcas2p39;
        Fri,  8 Apr 2022 05:32:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KZRjB3Z54z4x9QH; Fri,  8 Apr
        2022 05:32:46 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-94-624fc8febc58
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.5C.25540.EF8CF426; Fri,  8 Apr 2022 14:32:46 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Yk/CxUxR/iRb9j8l@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
Date:   Fri, 08 Apr 2022 14:32:46 +0900
X-CMS-MailID: 20220408053246epcms2p73d79512797c778a320394fe12e07edc6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmqe6/E/5JBhMnSFv8/r2M0WJJU4bF
        y0OaFrvudrBbnJ6wiMni+aFZzBYrvsxkt/jUomrR0POb1eLsvONsFm9+v2C3OLc40+L/nh3s
        FjvvnGB24PNYM28No8f1dQEeO2fdZfdYsKnUY/MKLY/Fe14yeWxa1cnm8eTKdCaPvi2rGD22
        7P/M6PF5k1wAd1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotP
        gK5bZg7QA0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQS
        K0MDAyNToMKE7IztkxaxF7zhrDj4bzF7A+Mhzi5GTg4JAROJ200NzF2MXBxCAjsYJXbdXMXe
        xcjBwSsgKPF3hzBIjbCAp8SuPfvYQGwhASWJHWvmMUPE9SWur+hmBbHZBHQl/i1+yQYyR0Tg
        LKPEoz1PGUEcZoFpzBL9lz6zQmzjlZjR/pQFwpaW2L58KyOIzQnUPWP7ZUaIuIbEj2W9zBC2
        qMTN1W/ZYez3x+ZD1YhItN47C1UjKPHg526ouJTEgieHoHZVS+z/+5sJwm5glOi/nwrymATQ
        1TuuG4OEeQV8Ja7dXgDWyiKgKtF7+xjUaS4Si2/uAYszC2hLLFv4mhmklVlAU2L9Ln2IKcoS
        R26xwDzVsPE3OzqbWYBPouPwX7j4jnlPoI5Rk5i3cifzBEblWYiAnoVk1yyEXQsYmVcxiqUW
        FOempxYbFRjD4zY5P3cTIzgpa7nvYJzx9oPeIUYmDsZDjBIczEoivFW5PklCvCmJlVWpRfnx
        RaU5qcWHGE2BvpzILCWanA/MC3kl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KL
        YPqYODilGpjC3qSahrp+OCpgM/8i25dKuUMZJ44qr2C+8f/I5b5Tm8vfvvdQOjBfzMVB955S
        8AIpjfm/bnEfXaOaolVZHqM8kUfjvz1f4qH1Lt/7n0mwvTPq3xrtbilW+HTd2g1PjGKs9O0/
        vOmWsJ731mS9wb33n2Y9lwzU/q4utvqW0G71qMKPhgfKuf+U39/3sedBhXgzj9cPLc9cz4s6
        10vs2aZ/c/+WZ5jJsetd0iKuCu14W5nW8PD5/09vWvRiK9eiWw8yti19HrTAXOvM3kTfZz1b
        py97Xywv9zEzS/3kauee5TxL1n1YrCl8c7v/0avWPqoqR/YyTY/wicwV5Pu0+H2Z9/MWnoMe
        F54yf8spe1uqxFKckWioxVxUnAgAxD51TlMEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5
References: <Yk/CxUxR/iRb9j8l@infradead.org>
        <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
        <YkR7G/V8E+NKBA2h@infradead.org>
        <20220328143228.1902883-1-alexandr.lobakin@intel.com>
        <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
        <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
        <20220330093526.2728238-1-alexandr.lobakin@intel.com>
        <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
        <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Christoph Hellwig=C2=A0<hch=40infradead.org>=0D=0A>=20Date=20:=
=202022-04-08=2014:06=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=5D=20PC=
I:=20dwc:=20Modify=20the=20check=20about=20MSI=20DMA=20mask=2032-bit=0D=0A>=
=20=0D=0A>=20On=C2=A0Fri,=C2=A0Apr=C2=A008,=C2=A02022=C2=A0at=C2=A011:34:01=
AM=C2=A0+0900,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0Hi,=0D=0A>>=
=C2=A0=0D=0A>>=C2=A0Could=C2=A0you=C2=A0please=C2=A0review=C2=A0this=C2=A0p=
atch=C2=A0in=C2=A0the=C2=A0context=C2=A0of=C2=A0the=C2=A0following=C2=A0pat=
ch?=0D=0A>>=C2=A0=0D=0A>>=C2=A0https://protect2.fireeye.com/v1/url?k=3Ddff1=
6c49-806a5556-dff0e706-000babdfecba-c817c3fb701d2897&q=3D1&e=3D5862d6bb-abd=
b-4e80-b515-8bc024accd0c&u=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2=
Flinux-pci%2Fpatch%2F20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c=
%40epcms2p=0D=0A>=20=0D=0A>=20Isn't=C2=A0that=C2=A0the=C2=A0same=C2=A0(brok=
en)=C2=A0patch?=0D=0A=0D=0Ayes,=20The=20same=20patch=20that=20was=20reviewi=
ng.=0D=0AI=20would=20like=20to=20continue=20reviewing=20the=20pcie-designwa=
re-host.c=20patch=20below.=0D=0Ahttps://lore.kernel.org/all/20220328023009e=
pcms2p309a5dfc2ff29d0a9945f65799963193c=40epcms2p3/
