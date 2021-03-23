Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943BE345C6E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCWLGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:06:11 -0400
Received: from foss.arm.com ([217.140.110.172]:43996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhCWLFt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:05:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F95D1042;
        Tue, 23 Mar 2021 04:05:49 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC00C3F719;
        Tue, 23 Mar 2021 04:05:47 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:05:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     'Leon Romanovsky' <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, kishon@ti.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com
Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20210323110545.GB29286@e121166-lin.cambridge.arm.com>
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
 <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
 <20210113072104.GH4678@unreal>
 <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 
Remove the timestamp information as well from the commit log, that's
completely irrelevant information.

I shall mark this as "changes requested", waiting for a new version
(please keep the review tags).

Lorenzo
