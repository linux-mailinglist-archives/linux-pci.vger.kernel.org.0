Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D441ADC6A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 13:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgDQLns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 07:43:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41248 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 07:43:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhc3J117988;
        Fri, 17 Apr 2020 06:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587123818;
        bh=uIHdkFGjC9VWJ1dYkQdiB11X9Q9MgdISnGvSAMPmGOk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UQPIvFrIGRIgPv38LmUwM8V77wmp2WwDQbHN9JZuruf1RVfbVejgbm7xxQ3fzFABs
         JoFIc7otCdR+Ko/AQkxJuulz/ZSoikmToRAh5NTZUaGK/di2EFSXq+7zxIWBeknNiB
         dKxHhk+FrxtWvQD+aSPT4OgSlMxHUefwodhOLi2s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HBhcVh004871
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 06:43:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 06:43:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 06:43:38 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HBhN9r088610;
        Fri, 17 Apr 2020 06:43:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
Date:   Fri, 17 Apr 2020 17:13:22 +0530
Message-ID: <20200417114322.31111-5-kishon@ti.com>
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

The PCI Bus Binding specification (IEEE Std 1275-1994 Revision 2.1 [1])
defines both Vendor ID and Device ID to be 32-bits. Fix
pcie-cadence-host.c driver to read 32-bit Vendor ID and Device ID
properties from device tree.

[1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8f72967f298f..31e67c9c88cf 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -229,10 +229,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	}
 
 	rc->vendor_id = 0xffff;
-	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
+	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
 
 	rc->device_id = 0xffff;
-	of_property_read_u16(np, "device-id", &rc->device_id);
+	of_property_read_u32(np, "device-id", &rc->device_id);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
 	pcie->reg_base = devm_ioremap_resource(dev, res);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 6bd89a21bb1c..df14ad002fe9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -262,8 +262,8 @@ struct cdns_pcie_rc {
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

