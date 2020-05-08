Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511E1CAE2F
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHNHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 09:07:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgEHNHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 09:07:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048D70F9024868;
        Fri, 8 May 2020 08:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588943220;
        bh=9OzK3cQ79vBtHjYhXF7SZZ/2/l/Kv3M5T/+KgLUKvlA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L577MJo6qayHav2G4S58GJbhUHozlXmfu5TOzzGjtYSV3s9EDMKaVl+5ib9LgzJd8
         MQxIXWavf6SgoYrb778kQuGriJH9PolZ+1YJ65Gs4p86Fux3wFko0FiVDPJD2yu2Up
         lzctd0+DSbq4o1xgEpXNguVaSKexgUPpX/x8woXY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 048D70E4007596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 08:07:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 08:07:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 08:07:00 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048D6kYn018673;
        Fri, 8 May 2020 08:06:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v3 3/4] PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
Date:   Fri, 8 May 2020 18:36:45 +0530
Message-ID: <20200508130646.23939-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508130646.23939-1-kishon@ti.com>
References: <20200508130646.23939-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI Bus Binding specification (IEEE Std 1275-1994 Revision 2.1 [1])
defines both Vendor ID and Device ID to be 32-bits. Fix
pcie-cadence-host.c driver to read 32-bit Vendor ID and Device ID
properties from device tree.

[1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tom Joseph <tjoseph@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 079692aa4da1..6ecebb79057a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -243,10 +243,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
 
 	rc->vendor_id = 0xffff;
-	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
+	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
 
 	rc->device_id = 0xffff;
-	of_property_read_u16(np, "device-id", &rc->device_id);
+	of_property_read_u32(np, "device-id", &rc->device_id);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
 	pcie->reg_base = devm_ioremap_resource(dev, res);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index cf1afd85c2f5..f349f5828a58 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -277,8 +277,8 @@ struct cdns_pcie_rc {
 	struct resource		*bus_range;
 	void __iomem		*cfg_base;
 	u32			no_bar_nbits;
-	u16			vendor_id;
-	u16			device_id;
+	u32			vendor_id;
+	u32			device_id;
 };
 
 /**
-- 
2.17.1

