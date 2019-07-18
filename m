Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC66CC40
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfGRJsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:48:00 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:20365 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRJsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443279; x=1594979279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=r3UejI0fEyx4nycQ3vf7JrpqMGHRZyoys9vsmeuSdCk=;
  b=GDC5OizS5WHpC3cbPd/r5NuDPuP1vwku0BiQd6EopTebsOWOmgEvdhdh
   CsNwPPvTOLexzBRsuerepZpGzWRXy0hzPva5xjML/DGlch+IDfKVW0ZpY
   RN5+jvWmckV2EqZaHZ5iTx5O+wsonJsmsjQwB6Ks4U40WXuU7fJmV0MVj
   s=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="816920794"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Jul 2019 09:47:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 2F37AA28ED;
        Thu, 18 Jul 2019 09:47:54 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:54 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.219) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:48 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 8/8] PCI: dw: Add support for PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Date:   Thu, 18 Jul 2019 12:47:18 +0300
Message-ID: <20190718094718.25083-4-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718094531.21423-1-jonnyc@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.219]
X-ClientProxiedBy: EX13D19UWC001.ant.amazon.com (10.43.162.64) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This basically aligns the usage of PCI_PROBE_ONLY and
PCI_REASSIGN_ALL_BUS in dw_pcie_host_init() with the logic in
pci_host_common_probe().

Now it will be possible to control via the devicetree whether to just
probe the PCI bus (in cases where FW already configured it) or to fully
configure it.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2ca748e4c85..0a294d8aa21a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -342,6 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
+	of_pci_check_probe_only();
+
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 					&bridge->windows, &pp->io_base);
 	if (ret)
@@ -474,6 +476,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->root_bus_nr = pp->busn->start;
 
+	/* Do not reassign bus nums if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->dev.parent = dev;
 	bridge->sysdata = pp;
 	bridge->busnr = pp->root_bus_nr;
@@ -490,11 +496,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-	pci_bus_size_bridges(pp->root_bus);
-	pci_bus_assign_resources(pp->root_bus);
+	/*
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(pp->root_bus);
+	} else {
+		pci_bus_size_bridges(pp->root_bus);
+		pci_bus_assign_resources(pp->root_bus);
 
-	list_for_each_entry(child, &pp->root_bus->children, node)
-		pcie_bus_configure_settings(child);
+		list_for_each_entry(child, &pp->root_bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
 
 	pci_bus_add_devices(pp->root_bus);
 	return 0;
-- 
2.17.1

