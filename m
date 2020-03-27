Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BC19559D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgC0Krr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 06:47:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58438 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0Krr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 06:47:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RAleSF117640;
        Fri, 27 Mar 2020 05:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585306060;
        bh=Nz7JeIi4Dm/Ixg7bAHRn/fYPyi7q2qtBRcaV3XEapOI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G3IsZgl1w9qZW3PaCOu7cfsn1AxxxLggwnCapJkwU4pQuyLYonnqDNj0fdAZYNn+g
         BdlHEncqhjj2WvhmIEZeoko7RBy5UOM6fXrnkcTC5ZQT921a4w2z4Od7O2n9qqcCdP
         UmiSeA27LvmGljLn73TZ4GO/62xBEoBOBXI/eQrI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RAleNE090655;
        Fri, 27 Mar 2020 05:47:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 05:47:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 05:47:40 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RAlT8q128190;
        Fri, 27 Mar 2020 05:47:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property
Date:   Fri, 27 Mar 2020 16:17:26 +0530
Message-ID: <20200327104727.4708-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327104727.4708-1-kishon@ti.com>
References: <20200327104727.4708-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence PCIe core dirver (host mode) uses "cdns,no-bar-match-nbits"
property to configure the number of bits passed through from PCIe
address to internal address in Inbound Address Translation register.

However standard PCI dt-binding already defines "dma-ranges" to
describe the address range accessible by PCIe controller. Parse
"dma-ranges" property to configure the number of bits passed
through from PCIe address to internal address in Inbound Address
Translation register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 9b1c3966414b..60f912a657b9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	struct device *dev = rc->pcie.dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	struct of_pci_range_parser parser;
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
+	struct of_pci_range range;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
@@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	rc->max_regions = 32;
 	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
 
-	rc->no_bar_nbits = 32;
-	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
+	if (!of_pci_dma_range_parser_init(&parser, np))
+		if (of_pci_range_parser_one(&parser, &range))
+			rc->no_bar_nbits = ilog2(range.size);
+
+	if (!rc->no_bar_nbits) {
+		rc->no_bar_nbits = 32;
+		of_property_read_u32(np, "cdns,no-bar-match-nbits",
+				     &rc->no_bar_nbits);
+	}
 
 	rc->vendor_id = 0xffff;
 	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
-- 
2.17.1

