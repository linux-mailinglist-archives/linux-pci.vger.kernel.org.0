Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF1131044
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAFKTp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 05:19:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46532 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgAFKTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:19:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AJYns108616;
        Mon, 6 Jan 2020 04:19:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305974;
        bh=NcwJJVNOD+mzf5/jYJ1c5VMcJOFJgmaeatJ2GMl1K5E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UDBY3L+vwEODxCwoTJpJZpFyfHam6IauosRMb8AZvjPR86g3l0Hdu7QBSIa10HYvA
         fe132vBM4m+vNuAElIWz5jzm0q1u0Elsjy/Ta8s9v5S4ITgpSMCNfpb+oyZJNBKwLZ
         g7GTFGF34siSEL5EVdJjfsKpBomEDJRHdjbUvJCY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006AJYsM039872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:19:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:19:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:19:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqY1118652;
        Mon, 6 Jan 2020 04:19:29 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 09/14] PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
Date:   Mon, 6 Jan 2020 15:50:53 +0530
Message-ID: <20200106102058.19183-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe
controller") in order to update Vendor ID, directly wrote to
PCI_VENDOR_ID register. However PCI_VENDOR_ID in root port configuration
space is read-only register and writing to it will have no effect.
Use local management register to configure Vendor ID and Subsystem Vendor
ID.

Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0ec21486ae17..5c57e78870ed 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -70,6 +70,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
+	u32 id;
 
 	/*
 	 * Set the root complex BAR configuration register:
@@ -89,8 +90,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
 
 	/* Set root port configuration space */
-	if (rc->vendor_id != 0xffff)
-		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
+	if (rc->vendor_id != 0xffff) {
+		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
+			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
+
 	if (rc->device_id != 0xffff)
 		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
 
-- 
2.17.1

