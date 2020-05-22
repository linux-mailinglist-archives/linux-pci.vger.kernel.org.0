Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102F71DDDF1
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgEVDg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:36:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50030 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:36:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3agN1038195;
        Thu, 21 May 2020 22:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118602;
        bh=giF+c2Per9KI83uYqkBut2N1cB6gGlc3M4nbnb5MpEY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GhWiCSLVo96F4UbualQP8wz4tCQQYJNkkI4r/OdPcHd+t7Rb5+4Z3hZpTrG0C8Z8Z
         ZQHe2WM3Oba0a6e0ZDoxdEHxSlIsFIPaZsgihTePyDxyXr4SD7lRbgRQv0HQ9CiiiS
         kW/QUK3OYufAfihvLf/gPM9dwmw2xHGP2kTAKWU4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M3agNq026365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:36:42 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:36:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:36:41 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aYbv062596;
        Thu, 21 May 2020 22:36:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 01/14] PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
Date:   Fri, 22 May 2020 09:06:18 +0530
Message-ID: <20200522033631.32574-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522033631.32574-1-kishon@ti.com>
References: <20200522033631.32574-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit bd22885aa188 ("PCI: cadence: Refactor driver to use as a core
library") while refactoring the Cadence PCIe driver to be used as
library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
and cdns_pcie_host_setup() but missed to remove the corresponding
pm_runtime_put_sync() in the error path. Fix it here.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 9 ++-------
 drivers/pci/controller/cadence/pcie-cadence-host.c | 6 +-----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c173dad67d1..1fdae37843ef 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -8,7 +8,6 @@
 #include <linux/of.h>
 #include <linux/pci-epc.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/sizes.h>
 
 #include "pcie-cadence.h"
@@ -440,8 +439,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
-		ret = PTR_ERR(epc);
-		goto err_init;
+		return PTR_ERR(epc);
 	}
 
 	epc_set_drvdata(epc, ep);
@@ -453,7 +451,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 			       resource_size(pcie->mem_res));
 	if (ret < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
-		goto err_init;
+		return ret;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
@@ -472,8 +470,5 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
  free_epc_mem:
 	pci_epc_mem_exit(epc);
 
- err_init:
-	pm_runtime_put_sync(dev);
-
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 70e0eaa15bf9..8e73a680b567 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -7,7 +7,6 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 
 #include "pcie-cadence.h"
 
@@ -476,7 +475,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
@@ -494,8 +493,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
  err_host_probe:
 	pci_free_resource_list(&resources);
 
- err_init:
-	pm_runtime_put_sync(dev);
-
 	return ret;
 }
-- 
2.17.1

