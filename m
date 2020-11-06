Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE92A983B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKFPMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 10:12:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46666 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgKFPLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 10:11:25 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FBIC4005681;
        Fri, 6 Nov 2020 09:11:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604675478;
        bh=+w+BvgepGqWvkDQjkbFxCvpUQOSLcIumtRNyUhWS6aA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C2O5x+JMLdwDN//H2DjeC9kaO5INQ0EjkaA6ALeDnHwjwjcy52/VJK4YbV42wmrEQ
         bVbztdaugnqEfBxoWwv1gFDkicQTFjb4Q9yZw6BZseS6LgQvnyA89PN8jzluzYfKEV
         CijF7w3an3/EsIMXhirMm5AqydwIOL720yKQZHwE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6FBI7W019613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 09:11:18 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 09:11:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 09:11:18 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FB7Th092540;
        Fri, 6 Nov 2020 09:11:14 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: cadence: Do not error if "cdns,max-outbound-regions" is not found
Date:   Fri, 6 Nov 2020 20:41:07 +0530
Message-ID: <20201106151107.3987-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106151107.3987-1-kishon@ti.com>
References: <20201106151107.3987-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that "cdns,max-outbound-regions" is made an optional property, do
not error out if "cdns,max-outbound-regions" device tree property is
not found.

Link: http://lore.kernel.org/r/20201105165331.GA55814@bogus
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 9 +++------
 drivers/pci/controller/cadence/pcie-cadence.h    | 1 +
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 254a3e1eff50..9a4195af958e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -531,12 +531,9 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	}
 	pcie->mem_res = res;
 
-	ret = of_property_read_u32(np, "cdns,max-outbound-regions",
-				   &ep->max_regions);
-	if (ret < 0) {
-		dev_err(dev, "missing \"cdns,max-outbound-regions\"\n");
-		return ret;
-	}
+	ep->max_regions = CDNS_PCIE_MAX_OB;
+	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
+
 	ep->ob_addr = devm_kcalloc(dev,
 				   ep->max_regions, sizeof(*ep->ob_addr),
 				   GFP_KERNEL);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3038f4..30eba6cafe2c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -197,6 +197,7 @@ enum cdns_pcie_rp_bar {
 };
 
 #define CDNS_PCIE_RP_MAX_IB	0x3
+#define CDNS_PCIE_MAX_OB	32
 
 struct cdns_pcie_rp_ib_bar {
 	u64 size;
-- 
2.17.1

