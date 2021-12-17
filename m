Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD4479770
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 00:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhLQXMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 18:12:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:19106 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhLQXMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 18:12:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="220530436"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="220530436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:12:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="662978032"
Received: from picklau-mobl.amr.corp.intel.com (HELO fmmunozr-desk.intel.com) ([10.212.130.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:12:32 -0800
From:   francisco.munoz.ruiz@linux.intel.com
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@linux.dev,
        dan.j.williams@intel.com, nirmal.patel@linux.intel.com,
        Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: [PATCH V2] PCI: vmd: Add DID 8086:A77F for all Intel Raptor Lake SKU's
Date:   Fri, 17 Dec 2021 15:12:11 -0800
Message-Id: <20211217231211.46018-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129195302.GA2686292@bhelgaas>
References: <20211129195302.GA2686292@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>

Add support for this VMD device which supports the bus restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Signed-off-by: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d4..0e6ca6cae2c7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -953,6 +953,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.25.1

We are still discussing the name for https://pci-ids.ucw.cz/read/PC/8086
Thanks.
