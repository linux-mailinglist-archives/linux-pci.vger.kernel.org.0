Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69E30FC47
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 20:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhBDTLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 14:11:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:31186 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239580AbhBDTKH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 14:10:07 -0500
IronPort-SDR: 86dATtHS4AYJAaY3CEI0mKI/SGuZse2Uph30xs4M/t/oOipt6aGMuk/hR4c3FR+jUXfv2EhoAw
 erqRwIoJuC7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168988743"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="168988743"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 11:09:23 -0800
IronPort-SDR: w0atSNMjsRFsy4Ai8n7QIQ836ydnbir2pqCTllgrKm/NZlsqJ4GYxh3J91sf2CDZ84DDCYr88w
 FTJCJe5k81Wg==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="434070462"
Received: from sgklier-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.212.165.190])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 11:09:21 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Will Deacon <will@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/2] VMD MSI Remapping Bypass
Date:   Thu,  4 Feb 2021 12:09:04 -0700
Message-Id: <20210204190906.38515-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
it changes downstream devices' requester-ids to its own. As VMD supports PCIe
devices, it has its own MSI/X table and transmits child device MSI/X by
remapping child device MSI/X and handling like a demultiplexer.

Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI/X
remapping table. This allows for better performance scaling as the child device
MSI/X won't be limited by VMD's MSI/X count and IRQ handler.

V1->V2:
Updated for 5.12-next
Moved IRQ allocation and remapping enable/disable to a more logical location

V1 patches 1-4 were already merged
V1, 5/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-6-jonathan.derrick@intel.com/
V1, 6/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-7-jonathan.derrick@intel.com/

Jon Derrick (2):
  iommu/vt-d: Use Real PCI DMA device for IRTE
  PCI: vmd: Disable MSI/X remapping when possible

 drivers/iommu/intel/irq_remapping.c |  3 +-
 drivers/pci/controller/vmd.c        | 60 +++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.27.0

