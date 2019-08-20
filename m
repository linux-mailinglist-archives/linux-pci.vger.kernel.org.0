Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC595B27
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfHTJk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:40:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:44289 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:40:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 02:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="189812371"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2019 02:40:23 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 1/3] PCI: dwc: Add map irq callback
Date:   Tue, 20 Aug 2019 17:39:35 +0800
Message-Id: <aeda3061a51824cdd7cacab6a1288a155b8ba5e1.1566208109.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like Intel need to configure
registers to enable the interrupts.
Map Irq callback helps to perform platform specific
configurations while assigning or enabling the interrupts.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
changes on v2:
	Addressing review comments to use if else {} instead of ternary operator
	to improver code readability.

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f93252d0da5b..ca7b40ff5c94 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -470,9 +470,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->sysdata = pp;
 	bridge->busnr = pp->root_bus_nr;
 	bridge->ops = &dw_pcie_ops;
-	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
+	if (pp->map_irq)
+		bridge->map_irq = pp->map_irq;
+	else
+		bridge->map_irq = of_irq_parse_and_map_pci;
+
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
 		goto err_free_msi;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffed084a0b4f..bc3657800dfa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -173,6 +173,7 @@ struct pcie_port {
 	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
+	int (*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
-- 
2.11.0

