Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3D311A40
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBFDiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 22:38:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:16481 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231593AbhBFDfw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:52 -0500
IronPort-SDR: N1Jy17ZFBHkVqHFQGh/jVK2QtKP3auZFC+6urMTW+tg1+GEwZthJ3vlZ9tZgJZCMepjIv6Wli/
 VFypMY063mTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181581381"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181581381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 19:35:10 -0800
IronPort-SDR: 45plgOWjxXoSgKZ9Lpg7N2xYOHrLJi70ic3mz6JaGwYXS/VqsjjaF0RNTPqylM1PCpbcdD7klB
 9PpKCz63cI2g==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="576921846"
Received: from rgrover1-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.209.102.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 19:35:11 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 0/2] VMD MSI Remapping Bypass
Date:   Fri,  5 Feb 2021 20:35:00 -0700
Message-Id: <20210206033502.103964-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
it changes downstream devices' requester-ids to its own. As VMD supports PCIe
devices, it has its own MSI-X table and transmits child device MSI-X by
remapping child device MSI-X and handling like a demultiplexer.

Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI-X
remapping table. This allows for better performance scaling as the child device
MSI-X won't be limited by VMD's MSI-X count and IRQ handler.

V2->V3:
Trivial comment fixes
Added acks

V1->V2:
Updated for 5.12-next
Moved IRQ allocation and remapping enable/disable to a more logical location

V1 patches 1-4 were already merged
V1, 5/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-6-jonathan.derrick@intel.com/
V1, 6/6: https://patchwork.kernel.org/project/linux-pci/patch/20200728194945.14126-7-jonathan.derrick@intel.com/

Jon Derrick (2):
  iommu/vt-d: Use Real PCI DMA device for IRTE
  PCI: vmd: Disable MSI-X remapping when possible

 drivers/iommu/intel/irq_remapping.c |  3 +-
 drivers/pci/controller/vmd.c        | 61 +++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 13 deletions(-)

-- 
2.27.0

