Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63930593D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 12:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhA0LIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 06:08:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:25887 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhA0LCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 06:02:07 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210127110123epoutp0188f6ef0f85e46a82e4d721fa17f44e99~eEcvJ4lDe3189331893epoutp01S
        for <linux-pci@vger.kernel.org>; Wed, 27 Jan 2021 11:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210127110123epoutp0188f6ef0f85e46a82e4d721fa17f44e99~eEcvJ4lDe3189331893epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611745283;
        bh=+WFdC02goCFGZzYcpoeCleblOkSoxduOC1jHDN5LsTc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WEqr2i2DOtMxJaaoRQe6fzeD6kKK8VCv/sS2oOQyJD1Fnv9U1j1/0czEC90jv+lIE
         D2lTA5gGR5oOlnGTSXOCJL6cE2iK1+2Ybg2guVyIMk2+F7y9TpfZSPNwstuSG7olVA
         erDFFefCQBo0/r/wfrOB26/phzN/V8a/7bfhLmVI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210127110122epcas5p3bb7cae1156ef39860d17a494e250a86f~eEct-QiGN2721327213epcas5p3e;
        Wed, 27 Jan 2021 11:01:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.A6.50652.20841106; Wed, 27 Jan 2021 20:01:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210127091202epcas5p31b5919d2a078ab232010ad4684d7dd64~eC9QTb8VJ1592715927epcas5p3g;
        Wed, 27 Jan 2021 09:12:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210127091202epsmtrp2cdf76ef7ef3f443f9dc7388683b30c21~eC9QSjqZ30912909129epsmtrp2P;
        Wed, 27 Jan 2021 09:12:02 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-37-60114802ba6a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.9E.08745.16E21106; Wed, 27 Jan 2021 18:12:02 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210127091159epsmtip1c407b73c6dbce5cded99365eec1942f3~eC9OOW9JR1269712697epsmtip1g;
        Wed, 27 Jan 2021 09:11:59 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Leon Romanovsky'" <leon@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <pankaj.dubey@samsung.com>,
        <sriram.dash@samsung.com>, <niyas.ahmed@samsung.com>,
        <p.rajanbabu@samsung.com>, <l.mehra@samsung.com>,
        <hari.tv@samsung.com>
In-Reply-To: <20210120052925.GL21258@unreal>
Subject: RE: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Wed, 27 Jan 2021 14:41:44 +0530
Message-ID: <156901d6f48c$79238ca0$6b6aa5e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwxsy/0exZ02HWY9tkJuphsuoUGQKa3YDmAkSCdskB+z4tgQF8nKVVqkTOuSA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmui6Th2CCwasbAhZLmjIsPk5byWRx
        4WkPm8Wd5zcYLab8WspscXnXHDaLs/OOs1m8+f2C3eLJlEesFkc3Blss2vqF3eLGenYHHo81
        89YweizYVOqxaVUnm0ffllWMHsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugStjZetd1oImiYov
        c68yNzD2C3cxcnJICJhIrLuxn7WLkYtDSGA3o0TnlIlsEM4nRolJH2ezgVQJCXxmlFjxLBqm
        Y9nH3UwQRbsYJa4s/s0C4bxglNjQuIQRpIpNQEfiyZU/zCC2iICmxIbeS2BjmQWWM0nMudLG
        BJLgBCo6s+0YWIOwQJTE+TnzwRpYBFQlth56zA5i8wpYSnxbOoEZwhaUODnzCQuIzSwgL7H9
        7RxmiJMUJH4+XcYKscxP4tKKC0wQNeISL48eYQdZLCFwgENi14zXjBANLhKL7nxihbCFJV4d
        38IOYUtJfH63lw3CzpeYeuEp0DIOILtCYnlPHUTYXuLAlTlgYWagx9bv0ocIy0pMPbUOai2f
        RO/vJ0wQcV6JHfNgbGWJL3/3sEDYkhLzjl1mncCoNAvJZ7OQfDYLyQezELYtYGRZxSiZWlCc
        m55abFpglJdarlecmFtcmpeul5yfu4kRnLy0vHYwPnzwQe8QIxMH4yFGCQ5mJRFeOwXBBCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8OwwexAsJpCeWpGanphakFsFkmTg4pRqYdGyjmirerymz
        /+ks8GZ50bojlinWRZ+Z7vSuPF4jn2Zp/EPnjlpQyn2NT5HnnJ8afH4rK+YqLGr9qHKJmk5H
        L+v+7yyZJYwOVhuXLg1J/TD/4I+d+/lDngb7vihzW7BbksEoKmLFTYuf+ypDCxPUS45XbTpx
        8p+WQHTJN131B/rzVrL6uXALTJ7x7LpDgdqT9P/Tjh0+4mf+YuEl/2l/VESaLbqi2Vorf1n/
        L1qmP0/mV9zDU4z+5zbPT56yOFJ5M5dFXtUr9ZkWm1ycdq5ymvX6RLXn+R0hO6f80MxxL9mz
        /8u1rTZ/yzz5Tv3cwL7t4YnOiBuXLX7oPjill2bXH5nB0vE1ZtOh4I9fr+9XVGIpzkg01GIu
        Kk4EAMF+6v3NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnG6SnmCCweMTzBZLmjIsPk5byWRx
        4WkPm8Wd5zcYLab8WspscXnXHDaLs/OOs1m8+f2C3eLJlEesFkc3Blss2vqF3eLGenYHHo81
        89YweizYVOqxaVUnm0ffllWMHsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugStjZetd1oImiYov
        c68yNzD2C3cxcnJICJhILPu4m6mLkYtDSGAHo8T72U2MEAlJic8X1zFB2MISK/89Z4coesYo
        8e74XDaQBJuAjsSTK3+YQWwRAU2JDb2X2ECKmAU2M0msOPuPBaKjhUni9bfp7CBVnEAdZ7Yd
        A1shLBAhsXLHAbBuFgFVia2HHoPV8ApYSnxbOoEZwhaUODnzCdAgDqCpehJtG8FamQXkJba/
        ncMMcZ2CxM+ny1ghjvCTuLTiAhNEjbjEy6NH2CcwCs9CMmkWwqRZSCbNQtKxgJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcAxqae1g3LPqg94hRiYOxkOMEhzMSiK8dgqCCUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwde/nmMmifmPC
        WWmrB1lNT9Ze0MypWMMq+86ffeIVzv+nEvZ4Pm/dulc6W12d9de1rwY3S6f+FkiaGlLMKm+Q
        pHN84cGcxF+nF7m63jmvfeTVWo2yNp9u/+KNjx1y31uzhp6OTvkz4XS7a4X5gotH3+83TVrE
        IPBJbpZvm4DYV9sjd/+83R8q3pl33tR4qsE9h3NrZyfpBtV9WPf5eUvsK0YVu8o1npdv3t24
        zvaRXPWUXk+7/C0nGxf4RvpN5xabt7bOTqcl6ctNjkV1W04W/TGrnRUU+0dt3jHRJ0cllTmC
        5//cyHTQtWJb1P65vv7u3YsEZZPXnctIdNGMXLaNY42tzeT9cqt1FK5w6s5XVWIpzkg01GIu
        Kk4EAL4t8GwwAwAA
X-CMS-MailID: 20210127091202epcas5p31b5919d2a078ab232010ad4684d7dd64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
        <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
        <20210113072104.GH4678@unreal> <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
        <20210120052925.GL21258@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for -
> >get_features()
> 
> On Tue, Jan 19, 2021 at 03:25:10PM +0530, Shradha Todi wrote:
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference
> > > for -
> > > >get_features()
> > >
> > > On Tue, Jan 12, 2021 at 07:32:25PM +0530, Shradha Todi wrote:
> > > > get_features ops of pci_epc_ops may return NULL, causing NULL
> > > > pointer dereference in pci_epf_test_bind function. Let us add a
> > > > check for pci_epc_feature pointer in pci_epf_test_bind before we
> > > > access it to avoid any such NULL pointer dereference and return
> > > > -ENOTSUPP in case pci_epc_feature is not found.
> > > >
> > > > When the patch is not applied and EPC features is not implemented
> > > > in the platform driver, we see the following dump due to kernel
> > > > NULL pointer dereference.
> > > >
> > > > [  105.135936] Call trace:
> > > > [  105.138363]  pci_epf_test_bind+0xf4/0x388 [  105.142354]
> > > > pci_epf_bind+0x3c/0x80 [  105.145817]  pci_epc_epf_link+0xa8/0xcc
> > > > [ 105.149632]  configfs_symlink+0x1a4/0x48c [  105.153616]
> > > > vfs_symlink+0x104/0x184 [  105.157169]  do_symlinkat+0x80/0xd4 [
> > > > 105.160636]  __arm64_sys_symlinkat+0x1c/0x24 [  105.164885]
> > > > el0_svc_common.constprop.3+0xb8/0x170
> > > > [  105.169649]  el0_svc_handler+0x70/0x88 [  105.173377]
> > > > el0_svc+0x8/0x640 [  105.176411] Code: d2800581 b9403ab9 f9404ebb
> > > > 8b394f60 (f9400400) [  105.182478] ---[ end trace a438e3c5a24f9df0
> > > > ]---
> > >
> > >
> > > Description and call trace don't correlate with the proposed code
change.
> > >
> > > The code in pci_epf_test_bind() doesn't dereference epc_features, at
> > > least
> > in
> > > direct manner.
> > >
> > > Thanks
> >
> > Thanks for the review. Yes, you're right. The dereference does not
> > happen in the pci_epf_test_bind() itself, but in
> > pci_epf_test_alloc_space() being called within. We will update the
> > line "causing NULL pointer dereference in pci_epf_test_bind function.
> > " in the commit message to "causing NULL pointer dereference in
> > pci_epf_test_alloc_space function. " Would that be good enough?
> 
> I have no idea, just saw that the rest of the code at least partially
prepared to
> deal with epc_features == NULL, maybe
> pci_epf_test_alloc_space() should be update to handle epc_features ==
NULL.
> 
> Thanks
> 

In current implementation, epc_features has been used in quite a few places
in the file without proper checks. Anyway, there is no point in proceeding
to bind the driver with no EPC features implemented, so we feel it's best to
return as soon as possible instead of going ahead and returning error at a
later point. (eg: during allocation). I checked that alloc function is not
being called anywhere else except for the bind function.

Thanks

> >

