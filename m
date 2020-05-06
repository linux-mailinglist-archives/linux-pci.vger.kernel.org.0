Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95D51C73D5
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgEFPPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:15:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37130 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgEFPPY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:15:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046FF5rV005231;
        Wed, 6 May 2020 10:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588778105;
        bh=4g2ILaxNCm1SNUD5tcC/SNftOmpCaWGgvx+JRfgFemw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gqMr7JpIdytVBhLOI40xg5ztGNbHakdtnQYUHWvQpFyuSbX9y+7qiH0hHxaUipMMq
         hIJus7A25+NrBSG62TM46iYNqxkjf1B1R1F74yLcrW+BCyfuTQbqNr3GonE0mCWJkx
         ySY82a9Sm8eDWjcfju32T5XXK4qURFpv1BxfwAzo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FF5VF016529;
        Wed, 6 May 2020 10:15:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 10:15:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 10:15:05 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FEUgE119457;
        Wed, 6 May 2020 10:15:01 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v4 08/14] PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
Date:   Wed, 6 May 2020 20:44:23 +0530
Message-ID: <20200506151429.12255-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506151429.12255-1-kishon@ti.com>
References: <20200506151429.12255-1-kishon@ti.com>
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
index 7c220671e66f..c7dc7be0da40 100644
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

