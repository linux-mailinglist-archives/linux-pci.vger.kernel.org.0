Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1F461FE1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 20:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhK2TKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 14:10:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:16544 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234990AbhK2TIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 14:08:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233552754"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233552754"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:05:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="540104967"
Received: from ajmcfarl-mobl1.amr.corp.intel.com (HELO fmmunozr-desk.hsd1.ca.comcast.net) ([10.213.167.234])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:05:01 -0800
From:   francisco.munoz.ruiz@linux.intel.com
To:     linux-pci@vger.kernel.org
Cc:     helgaas@kernel.org, jonathan.derrick@intel.com,
        dan.j.williams@intel.com, nirmal.patel@linux.intel.com,
        Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: [PATCH] PCI: vmd: Add device id for VMD device 8086:A77F
Date:   Mon, 29 Nov 2021 11:02:32 -0800
Message-Id: <20211129190232.24375-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>

Add support for this VMD device which supports the bus rectriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Signed-off-by: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
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

