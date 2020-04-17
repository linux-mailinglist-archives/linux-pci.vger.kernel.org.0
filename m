Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945EC1ADC65
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgDQLnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 07:43:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52138 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 07:43:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhWuR034298;
        Fri, 17 Apr 2020 06:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587123812;
        bh=4p1lIn3EJMxqLcKLHJpXFBYOnV80cp+ytaLCxJxeVys=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C2MYEEEFKqUKe3M0NTM29X5sg7Ae550POv5GOnplb4TCmJXi3YFTM2SR8gWFZZ1t5
         UlyBULoohP3Gy1gaFRgKWqolbwfvCq9HgwZnWWSoYQo+cZ/vH++KsIJl+1sonN/+uI
         2taahmjbBnuosvLDWxxCs6ohPQB8qHKsKRvuBiqU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhW8x079693;
        Fri, 17 Apr 2020 06:43:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 06:43:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 06:43:32 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhN9p088610;
        Fri, 17 Apr 2020 06:43:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property
Date:   Fri, 17 Apr 2020 17:13:20 +0530
Message-ID: <20200417114322.31111-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417114322.31111-1-kishon@ti.com>
References: <20200417114322.31111-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
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

