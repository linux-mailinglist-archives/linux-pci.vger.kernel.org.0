Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE3134F3C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgAHWBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 17:01:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:30969 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgAHWBJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 17:01:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 14:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="423051046"
Received: from unknown (HELO skalakox.lm.intel.com) ([10.232.116.60])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 14:01:08 -0800
From:   Sushma Kalakota <sushmax.kalakota@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: [PATCH v3] PCI: vmd: Add two VMD Device IDs
Date:   Wed,  8 Jan 2020 15:05:10 -0700
Message-Id: <20200108220510.12063-1-sushmax.kalakota@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new VMD device IDs that require the bus restriction mode.

Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
v2->v3 Removed from pci_ids.h
v1->v2 Squashed

 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 212842263f55..c502b6c0daf5 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -868,6 +868,10 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
+		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
+		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
-- 
2.17.1

