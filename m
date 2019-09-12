Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3CB0F81
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfILNDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:03:17 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:47725 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbfILNDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293396; x=1599829396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YCI9/8/j431HdcQDOyry7Imqjc6V2OFviDdWb/2L/qc=;
  b=OlAQGPUpoGNvz9JhHW3M2IFOBN+nv8Evi8xAUa3cfD5HqVxF6ikL6EuM
   nfEYymKYFLFgfUuWGQ69ZZTinSMxB7Tool5BlNSK/blP1lpObUaq4qZLp
   JlEUBQMdlUCCMqlRo6/gGRjZBDZUtd0cqPqEZOO+XI8RSUaJIUiSRMrux
   w=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414911959"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 13:03:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id BB0CBA1DA2;
        Thu, 12 Sep 2019 13:03:09 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:03:09 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.99) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:03:03 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <andrew.murray@arm.com>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <ronenk@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v6 7/7] PCI: dwc: Add validation that PCIe core is set to correct mode
Date:   Thu, 12 Sep 2019 16:02:38 +0300
Message-ID: <20190912130238.15682-3-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912130042.14597-1-jonnyc@amazon.com>
References: <20190912130042.14597-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.99]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCIe controllers can be set to either Host or EP according to some
early boot FW. To make sure there is no discrepancy (e.g. FW configured
the port to EP mode while the DT specifies it as a host bridge or vice
versa), a check has been added for each mode.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  8 ++++++++
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 65f479250087..3dd2e2697294 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -498,6 +498,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	int ret;
 	u32 reg;
 	void *addr;
+	u8 hdr_type;
 	unsigned int nbars;
 	unsigned int offset;
 	struct pci_epc *epc;
@@ -562,6 +563,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
+	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
+		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
+			hdr_type);
+		return -EIO;
+	}
+
 	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
 	if (ret < 0)
 		epc->max_functions = 1;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d3156446ff27..0f36a926059a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
+	u32 hdr_type;
 	int ret;
 
 	raw_spin_lock_init(&pci->pp.lock);
@@ -464,6 +465,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
+	ret = dw_pcie_rd_own_conf(pp, PCI_HEADER_TYPE, 1, &hdr_type);
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		dev_err(pci->dev, "Failed reading PCI_HEADER_TYPE cfg space reg (ret: 0x%x)\n",
+			ret);
+		ret = pcibios_err_to_errno(ret);
+		goto err_free_msi;
+	}
+	if (hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+		dev_err(pci->dev,
+			"PCIe controller is not set to bridge type (hdr_type: 0x%x)!\n",
+			hdr_type);
+		ret = -EIO;
+		goto err_free_msi;
+	}
+
 	pp->root_bus_nr = pp->busn->start;
 
 	bridge->dev.parent = dev;
-- 
2.17.1

