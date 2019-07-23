Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA071521
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfGWJ1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:27:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21677 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGWJ1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563874058; x=1595410058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sNQOZhJUfbz+nC7+KNBC3O+NbzfXKJgSiWivUBW5VoI=;
  b=qcASuAkIsMZsG9v/nw6IcqIhr3Y/1w/FqHW1qY2T1aWFj2nocQS0/N9q
   gflEIeS6gDssttBZ32bdi8ZnIq4rqFQssQSYETY9x2QfbWlXI/kkCgQQ2
   bGgraaEsjeQFuJ5SJof6tzvdd+baQCu9mDzSE8Cg05J5wu8JDAfPzRfAd
   s=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="812905282"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jul 2019 09:27:38 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id D4609A1C2A;
        Tue, 23 Jul 2019 09:27:37 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:27:37 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.85) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:27:32 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v3 7/8] PCI: dw: Add validation that PCIe core is set to correct mode
Date:   Tue, 23 Jul 2019 12:27:10 +0300
Message-ID: <20190723092711.11786-3-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723092529.11310-1-jonnyc@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.85]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
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

