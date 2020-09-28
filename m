Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF027A532
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1B0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:26:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:64441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1B0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:26:09 -0400
IronPort-SDR: iGAfyU/ZKBTVYpQ74sC9WowQUygYtaignH+w/QD/KtVozshbUFk895uEvVBj96ceMZCy05XBNZ
 MB7hkkSvd59g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141939480"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141939480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:24 -0700
IronPort-SDR: 42i1DP5Sb2AtqkUyWUrxGWSArXnTG/7ce/dVVHGewZ1hRjxp40YgS5rfGHO6pKGF3vapqTMmPM
 CKm3d+Leflnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456639894"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 18:26:23 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/3] PCI: vmd: Wire up VMD for fallback resource assignment
Date:   Sun, 27 Sep 2020 21:06:09 -0400
Message-Id: <20200928010609.5375-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200928010609.5375-1-jonathan.derrick@intel.com>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD subdevice domain would prefer all devices be assigned resources
and working rather than a few or none assigned, but with valid hotplug
bridge resources. The resource assignment fallback algorithm works best
for these requirements.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fdc1a206f73e..4debc547c813 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -777,7 +777,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
 	pci_scan_child_bus(vmd->bus);
-	pci_assign_unassigned_bus_resources(vmd->bus);
+	pci_bus_assign_resources_fallback_sizing(vmd->bus);
 
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
-- 
2.18.1

