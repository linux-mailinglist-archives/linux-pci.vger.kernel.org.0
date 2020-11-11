Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED742AF50D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgKKPiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 10:38:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgKKPh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 10:37:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ABFbnvO097943;
        Wed, 11 Nov 2020 09:37:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605109069;
        bh=ccIYM3BWSztQJNWt3tuc6dHrpKFHfV4QEGAhdlAGYe0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V6EnZkssJLkcuAaaWXrA6bNJvC9/gRhJ10rlwBAYb8GizJrYiE6pm7spekE/gyuNI
         1+pPsB8jnT8AfUSJ2xF4UfjzunaVRjI5IZT5BCq2KUZ43IN2LG2WsVNIC8OxVkjb67
         Alt5iYmDxH12Ir8rObdrQ09zqEhnkI0swpYfjsQM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ABFbnCq095792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 09:37:49 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 09:37:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 09:37:48 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ABFa043042109;
        Wed, 11 Nov 2020 09:37:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
Subject: [PATCH v8 12/18] PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
Date:   Wed, 11 Nov 2020 21:05:53 +0530
Message-ID: <20201111153559.19050-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111153559.19050-1-kishon@ti.com>
References: <20201111153559.19050-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of functions supported by the endpoint controller is
configured in LM_EP_FUNC_CFG based on func_no member of struct pci_epf.
Now that an endpoint function can be associated with two endpoint
controllers (primary and secondary), just using func_no will
not suffice as that will take into account only if the endpoint
controller is associated with the primary interface of endpoint
function. Instead use epc->function_num_map which will already have the
configured functions information (irrespective of whether the endpoint
controller is associated with primary or secondary interface).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1fe6b8baca97..4e4eb30cd1a2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -506,18 +506,13 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
-	struct pci_epf *epf;
-	u32 cfg;
 	int ret;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cfg = BIT(0);
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		cfg |= BIT(epf->func_no);
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
-- 
2.17.1

