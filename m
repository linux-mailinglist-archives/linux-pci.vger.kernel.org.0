Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CC231379
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgG1UHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:63202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgG1UHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:04 -0400
IronPort-SDR: I476TLL5f/Aom0cr2Dxh9J5X/aQPYkvNNaJrS/bxBVEmIZnfu7sXgNXk41oKd4HBoXooBOIajy
 pxzSY+M/8rFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287325"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:03 -0700
IronPort-SDR: TO+0uiPdkYj4iseKQ3HuEWf0eq30qM/DaBxXGP7ml9lx553Xu2n5b7PM1/q/upIBbj22MxqHSb
 ZZuRphpZZsuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756371"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:02 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/6] VMD MSI Remapping Bypass
Date:   Tue, 28 Jul 2020 13:49:39 -0600
Message-Id: <20200728194945.14126-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
it changes downstream devices' requester-ids to its own. As VMD supports PCIe
devices, it has its own MSI/X table and transmits child device MSI/X by
remapping child device MSI/X and handling like a demultiplexer.

Some newer VMD devices (Icelake Server and client) have an option to bypass the
VMD MSI/X remapping table. This allows for better performance scaling as the
child device MSI/X won't be limited by VMD's MSI/X count and IRQ handler.

It's expected that most users don't want MSI/X remapping when they can get
better performance without this limitation. This set includes some long overdue
cleanup of overgrown VMD code and introduces the MSI/X remapping disable.

Applies on top of e3beca48a45b ("irqdomain/treewide: Keep firmware node
unconditionally allocated") and ec0160891e38 ("irqdomain/treewide: Free
firmware node after domain removal") in tip/urgent


Jon Derrick (6):
  PCI: vmd: Create physical offset helper
  PCI: vmd: Create bus offset configuration helper
  PCI: vmd: Create IRQ Domain configuration helper
  PCI: vmd: Create IRQ allocation helper
  x86/apic/msi: Use Real PCI DMA device when configuring IRTE
  PCI: vmd: Disable MSI/X remapping when possible

 arch/x86/kernel/apic/msi.c   |   2 +-
 drivers/pci/controller/vmd.c | 344 +++++++++++++++++++++++------------
 2 files changed, 224 insertions(+), 122 deletions(-)


base-commit: ec0160891e387f4771f953b888b1fe951398e5d9
-- 
2.27.0

