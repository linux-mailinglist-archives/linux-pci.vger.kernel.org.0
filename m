Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC361EE480
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFDMfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 08:35:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:57872 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgFDMfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 08:35:51 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from ayal@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jun 2020 15:35:49 +0300
Received: from dev-l-vrt-210.mtl.labs.mlnx (dev-l-vrt-210.mtl.labs.mlnx [10.234.210.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 054CZneB007097;
        Thu, 4 Jun 2020 15:35:49 +0300
Received: from dev-l-vrt-210.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-210.mtl.labs.mlnx (8.15.2/8.15.2/Debian-8ubuntu1) with ESMTP id 054CZmE9012267;
        Thu, 4 Jun 2020 15:35:48 +0300
Received: (from ayal@localhost)
        by dev-l-vrt-210.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 054CZmmI012266;
        Thu, 4 Jun 2020 15:35:48 +0300
From:   Aya Levin <ayal@mellanox.com>
To:     Ding Tianhong <dingtianhong@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>, linux-pci@vger.kernel.org
Subject: Adding support for Relaxed ordering on a non-root device
Date:   Thu,  4 Jun 2020 15:35:48 +0300
Message-Id: <1591274148-12230-1-git-send-email-ayal@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

I am writing to you regarding your commits titled: 
1. a99b646afa8a PCI: Disable PCIe Relaxed Ordering if unsupported 
2. 87e09cdec4da PCI: Disable Relaxed Ordering for some Intel processors

While adding support to relaxed ordering on Mellanox Ethernet driver I
tried to avoid the Intel's bug with pcie_relaxed_ordering_enabled.
Expecting this to return False on Haswell and Broadwell CPU. I run
this API on: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz (I think it is
a Haswell, right?) and the API returned True. What am I missing?

In addition, I saw your comment in pci_configure_relaxed_ordering
(pasted below) the non-root ports are not handled since Peer-to-Peer
DMA is another can of warms. Could you elaborate on the complexity?
What is the effort to extend this to non-root ports?

Thanks,
Aya

---------------------------------------------------------------------
static void pci_configure_relaxed_ordering(struct pci_dev *dev)
{
	struct pci_dev *root;

	/* PCI_EXP_DEVICE_RELAX_EN is RsvdP in VFs */
	if (dev->is_virtfn)
		return;

	if (!pcie_relaxed_ordering_enabled(dev))
		return;

	/*
	 * For now, we only deal with Relaxed Ordering issues with Root
	 * Ports. Peer-to-Peer DMA is another can of worms.
	 */
	root = pci_find_pcie_root_port(dev);
	if (!root)
		return;

	if (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING) {
		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
					   PCI_EXP_DEVCTL_RELAX_EN);
		pci_info(dev, "Relaxed Ordering disabled because the Root Port didn't support it\n");
	}
}


