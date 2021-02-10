Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C329D316ADC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBJQOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 11:14:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:47934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231868AbhBJQOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:08 -0500
IronPort-SDR: brOpo4J7Sz4XGvwe7MtUNv2Or/tCFepqrAajPx+CIz4NnrZIgFjUV7f+t5PuCD5rVkGYRLGFD5
 mCvwVFoUN7cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179543641"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="179543641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:26 -0800
IronPort-SDR: /xiRUGXUeGLG1htggB11SM/yhLjN57OHzbzANld9rmCFnmfriA8pYZshYsZdZlrHoHdgGJmXyF
 OSJned8nDOdQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380191372"
Received: from mjyalung-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.209.178.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:25 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v4 0/2] VMD MSI Remapping Bypass
Date:   Wed, 10 Feb 2021 09:13:13 -0700
Message-Id: <20210210161315.316097-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

V3->V4:
Integrated wording suggestions; no functional changes

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
 drivers/pci/controller/vmd.c        | 63 +++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 13 deletions(-)

-- 
2.27.0

