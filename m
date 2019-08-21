Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A051097F55
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfHUPsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 11:48:25 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:62916 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfHUPsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 11:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566402504; x=1597938504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sNQOZhJUfbz+nC7+KNBC3O+NbzfXKJgSiWivUBW5VoI=;
  b=FWFJ4Bai+EpJzhnh5LgUCeDRIj6YxMOWk7vJxLOMUavZXFqqQ2L0N2a2
   6HsK4iKRqzTCjKPe5KIRlm/R2ZNtwPJTQRsMT4WbY7EInynRxpXPi8iuK
   j+syS+xl4e2pnFiANmL4OHJC8pZHYKOunYhpd+39I/xgla93BIAnoERid
   0=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="822280226"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 21 Aug 2019 15:48:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 7648AA2680;
        Wed, 21 Aug 2019 15:48:17 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:48:17 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.230) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:48:10 +0000
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
Subject: [PATCH v4 7/7] PCI: dwc: Add validation that PCIe core is set to correct mode
Date:   Wed, 21 Aug 2019 18:47:45 +0300
Message-ID: <20190821154745.31834-3-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821153545.17635-1-jonnyc@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.230]
X-ClientProxiedBy: EX13D12UWA002.ant.amazon.com (10.43.160.88) To
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
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2bf5a35c0570..00e59a134b93 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -531,6 +531,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	int ret;
 	u32 reg;
 	void *addr;
+	u8 hdr_type;
 	unsigned int nbars;
 	unsigned int offset;
 	struct pci_epc *epc;
@@ -543,6 +544,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 	}
 
+	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
+		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
+			hdr_type);
+		return -EIO;
+	}
+
 	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
 	if (ret < 0) {
 		dev_err(dev, "Unable to read *num-ib-windows* property\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f93252d0da5b..d2ca748e4c85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
+	u8 hdr_type;
 	int ret;
 
 	raw_spin_lock_init(&pci->pp.lock);
@@ -396,6 +397,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+		dev_err(pci->dev, "PCIe controller is not set to bridge type (hdr_type: 0x%x)!\n",
+			hdr_type);
+		return -EIO;
+	}
+
 	pp->mem_base = pp->mem->start;
 
 	if (!pp->va_cfg0_base) {
-- 
2.17.1

