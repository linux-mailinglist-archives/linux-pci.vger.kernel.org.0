Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2E1C73B9
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgEFPOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:14:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgEFPOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:14:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046FEcgN005097;
        Wed, 6 May 2020 10:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588778078;
        bh=eBc8a0MLbmJPxtpYDORl+QAfug4Aj3yhXJs3ACP9m5Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IH/chraKtVLEw2FnsSy4Muzx6y4zosbClMykEBmyyNW9V+14NVpF87imZkXupPJry
         YH8KT97+m2wzU17kySmw7DYavqWF9W8oTSOtbakzq82+3GDThnG/huedo+KDqP+MzX
         JHH++jfmLE+BrkziTQ1GfyiWxcPVMt1AIywJ/kVw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046FEcJH118722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 10:14:38 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 10:14:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 10:14:38 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046FEUg7119457;
        Wed, 6 May 2020 10:14:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v4 01/14] PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
Date:   Wed, 6 May 2020 20:44:16 +0530
Message-ID: <20200506151429.12255-2-kishon@ti.com>
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

commit bd22885aa188 ("PCI: cadence: Refactor driver to use as a core
library") while refactoring the Cadence PCIe driver to be used as
library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
and cdns_pcie_host_setup() but missed to remove the corresponding
pm_runtime_put_sync() in the error path. Fix it here.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
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
index 31e67c9c88cf..465607202bb5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -7,7 +7,6 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 
 #include "pcie-cadence.h"
 
@@ -259,7 +258,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
@@ -277,8 +276,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
  err_host_probe:
 	pci_free_resource_list(&resources);
 
- err_init:
-	pm_runtime_put_sync(dev);
-
 	return ret;
 }
-- 
2.17.1

