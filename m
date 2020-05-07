Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2684F1C8AEF
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGMfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 08:35:12 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:5168 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGMfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 08:35:12 -0400
X-IronPort-AV: E=Sophos;i="5.73,363,1583161200"; 
   d="scan'208";a="46285059"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 May 2020 21:35:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B138A400C089;
        Thu,  7 May 2020 21:35:06 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v10 4/8] PCI: endpoint: Pass page size as argument to pci_epc_mem_init()
Date:   Thu,  7 May 2020 13:33:15 +0100
Message-Id: <1588854799-13710-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588854799-13710-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588854799-13710-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epc_mem_init() internally used page size equal to *PAGE_SIZE* to
manage the address space so instead just pass the page size as a
argument to pci_epc_mem_init().

Also make pci_epc_mem_init() as a C function instead of a macro function
in preparation for adding support for pci-epc-mem core to handle multiple
windows.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 drivers/pci/controller/pcie-rockchip-ep.c        | 2 +-
 drivers/pci/endpoint/pci-epc-mem.c               | 7 +++++++
 include/linux/pci-epc.h                          | 5 ++---
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c173dad67d1..1c15c8352125 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -450,7 +450,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 		epc->max_functions = 1;
 
 	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
-			       resource_size(pcie->mem_res));
+			       resource_size(pcie->mem_res), PAGE_SIZE);
 	if (ret < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_init;
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d743b0a48988..5eaf36629a75 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -615,7 +615,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
 
 	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
-			       resource_size(rockchip->mem_res));
+			       resource_size(rockchip->mem_res), PAGE_SIZE);
 	if (err < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
 		goto err_uninit_port;
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index abfac1109a13..cdd1d3821249 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -93,6 +93,13 @@ return ret;
 }
 EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
 
+int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
+		     size_t size, size_t page_size)
+{
+	return __pci_epc_mem_init(epc, base, size, page_size);
+}
+EXPORT_SYMBOL_GPL(pci_epc_mem_init);
+
 /**
  * pci_epc_mem_exit() - cleanup the pci_epc_mem structure
  * @epc: the EPC device that invoked pci_epc_mem_exit
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index e0ed9d01f6e5..5bc1de65849e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -137,9 +137,6 @@ struct pci_epc_features {
 #define devm_pci_epc_create(dev, ops)    \
 		__devm_pci_epc_create((dev), (ops), THIS_MODULE)
 
-#define pci_epc_mem_init(epc, phys_addr, size)	\
-		__pci_epc_mem_init((epc), (phys_addr), (size), PAGE_SIZE)
-
 static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
 {
 	dev_set_drvdata(&epc->dev, data);
@@ -195,6 +192,8 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
+int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
+		     size_t size, size_t page_size);
 int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
 		       size_t page_size);
 void pci_epc_mem_exit(struct pci_epc *epc);
-- 
2.17.1

