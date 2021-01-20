Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8037A2FCAC4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 06:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhATFcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 00:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbhATFaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 00:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88DEF2311C;
        Wed, 20 Jan 2021 05:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611120569;
        bh=OOFp8zk9k64cA2yzlao8KtjRGH2xmQ6qvuD9AFDkcDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkDsSl0gzP76Ppo+xnBjytT2VkbLwIO5td7FVnv7ZIwah8r5mDE/5E9CzOJS27uq9
         z02mbEszuSv7biDFCJ1/VG6Law9IpGCoG4rwj6U1CCT5FyM7hNwnfnDtGIjJ76rJfL
         nZs12+Qh2wMTj7w7VsuM4dR5VeaVmJq4dqOFAbAgXpUJTUmtg5u1Tu1yvfRxwRZWV/
         SGvauH7p4WEz0tIJCdK8SYybd1Hj1jkiedN5BFwpH5D+HpzhdOnJ3uHGSyEmEdpirP
         3gmn+IkSlC6P40JJg0PvBOWYTLEQwjheGu8O03Lje8I/OgmIRGHe3mw9Z3ydJuD0IY
         uImCVRHJi0i+Q==
Date:   Wed, 20 Jan 2021 07:29:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com
Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20210120052925.GL21258@unreal>
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
 <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
 <20210113072104.GH4678@unreal>
 <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 03:25:10PM +0530, Shradha Todi wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for -
> > >get_features()
> >
> > On Tue, Jan 12, 2021 at 07:32:25PM +0530, Shradha Todi wrote:
> > > get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> > > dereference in pci_epf_test_bind function. Let us add a check for
> > > pci_epc_feature pointer in pci_epf_test_bind before we access it to
> > > avoid any such NULL pointer dereference and return -ENOTSUPP in case
> > > pci_epc_feature is not found.
> > >
> > > When the patch is not applied and EPC features is not implemented in
> > > the platform driver, we see the following dump due to kernel NULL
> > > pointer dereference.
> > >
> > > [  105.135936] Call trace:
> > > [  105.138363]  pci_epf_test_bind+0xf4/0x388 [  105.142354]
> > > pci_epf_bind+0x3c/0x80 [  105.145817]  pci_epc_epf_link+0xa8/0xcc [
> > > 105.149632]  configfs_symlink+0x1a4/0x48c [  105.153616]
> > > vfs_symlink+0x104/0x184 [  105.157169]  do_symlinkat+0x80/0xd4 [
> > > 105.160636]  __arm64_sys_symlinkat+0x1c/0x24 [  105.164885]
> > > el0_svc_common.constprop.3+0xb8/0x170
> > > [  105.169649]  el0_svc_handler+0x70/0x88 [  105.173377]
> > > el0_svc+0x8/0x640 [  105.176411] Code: d2800581 b9403ab9 f9404ebb
> > > 8b394f60 (f9400400) [  105.182478] ---[ end trace a438e3c5a24f9df0
> > > ]---
> >
> >
> > Description and call trace don't correlate with the proposed code change.
> >
> > The code in pci_epf_test_bind() doesn't dereference epc_features, at least
> in
> > direct manner.
> >
> > Thanks
>
> Thanks for the review. Yes, you're right. The dereference does not happen in
> the pci_epf_test_bind() itself, but in pci_epf_test_alloc_space() being
> called within. We will update the line "causing NULL pointer dereference in
> pci_epf_test_bind function. " in the commit message to "causing NULL pointer
> dereference in pci_epf_test_alloc_space function. " Would that be good
> enough?

I have no idea, just saw that the rest of the code at least partially
prepared to deal with epc_features == NULL, maybe
pci_epf_test_alloc_space() should be update to handle epc_features == NULL.

Thanks

>
