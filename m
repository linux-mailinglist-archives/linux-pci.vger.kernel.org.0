Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979151F0047
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFETIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 15:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgFETIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 15:08:12 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2332074B;
        Fri,  5 Jun 2020 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591384091;
        bh=WO9xYPQFSr1420rzuSZYXBs4vgIB9Ategf/ULgW/q0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Uv0LGWqgaCo5hCiH9IvI5oqwvhmIeB0fjyW3BcqY/IFfFGPCodZsA5UONQ/EKD2vR
         fOv2UYYaVqfupz7D1d6gIpI0CA7IhYZ0ijmRgx8jrew9IP1a9+DvM8k2z1ipZNT6aG
         xzqd+YnF3QYEPxpS46uGTXGK6ptR5ms/jD+/KEZo=
Date:   Fri, 5 Jun 2020 14:08:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aya Levin <ayal@mellanox.com>
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>, linux-pci@vger.kernel.org
Subject: Re: Adding support for Relaxed ordering on a non-root device
Message-ID: <20200605190809.GA1144451@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591274148-12230-1-git-send-email-ayal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 03:35:48PM +0300, Aya Levin wrote:
> Hi
> 
> I am writing to you regarding your commits titled: 
> 1. a99b646afa8a PCI: Disable PCIe Relaxed Ordering if unsupported 
> 2. 87e09cdec4da PCI: Disable Relaxed Ordering for some Intel processors
> 
> While adding support to relaxed ordering on Mellanox Ethernet driver I
> tried to avoid the Intel's bug with pcie_relaxed_ordering_enabled.
> Expecting this to return False on Haswell and Broadwell CPU. I run
> this API on: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz (I think it is
> a Haswell, right?) and the API returned True. What am I missing?

The quirk is based on Vendor/Device ID, which of course is a problem
as new devices are released.  What does "lspci -vn" show on your
system?

> In addition, I saw your comment in pci_configure_relaxed_ordering
> (pasted below) the non-root ports are not handled since Peer-to-Peer
> DMA is another can of warms. Could you elaborate on the complexity?
> What is the effort to extend this to non-root ports?

There's some discussion about this here and in other parts of the same
thread:

  https://lore.kernel.org/linux-arm-kernel/20170809032503.GB7191@bhelgaas-glaptop.roam.corp.google.com/

> ---------------------------------------------------------------------
> static void pci_configure_relaxed_ordering(struct pci_dev *dev)
> {
> 	struct pci_dev *root;
> 
> 	/* PCI_EXP_DEVICE_RELAX_EN is RsvdP in VFs */
> 	if (dev->is_virtfn)
> 		return;
> 
> 	if (!pcie_relaxed_ordering_enabled(dev))
> 		return;
> 
> 	/*
> 	 * For now, we only deal with Relaxed Ordering issues with Root
> 	 * Ports. Peer-to-Peer DMA is another can of worms.
> 	 */
> 	root = pci_find_pcie_root_port(dev);
> 	if (!root)
> 		return;
> 
> 	if (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING) {
> 		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> 					   PCI_EXP_DEVCTL_RELAX_EN);
> 		pci_info(dev, "Relaxed Ordering disabled because the Root Port didn't support it\n");
> 	}
> }
> 
> 
