Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFBE24CBF3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHUDz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:27 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38762 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHUDzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:21 -0400
Received: by mail-il1-f193.google.com with SMTP id 77so337794ilc.5;
        Thu, 20 Aug 2020 20:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzA5Li0O8wMWcSVtXd/0wN/DTjqwQIp+nFPJ5Byn0Ao=;
        b=Zsu09IIVotTBL7XD8OZHbaAD7kKw4RsGoAjMd8XgBt3MUjgsuLzHFUD+0OtwTPf3gY
         aJNZhqoyN4kkZffeWhp8Wu5dgiAvNKUiM86425KTVWv6JCBzAIjlI8kM/34Apl7k81Ds
         3auATMuRwC89JGmQ+6Epqt1foPJpBeQRJtwW6ZNFNBQkBeSoVHqBHAfvzzZMp+T21+im
         MNELfu1X+SMtslxI7bts248j2T/ASHUAZDiIrLBvHDIs6VQgloKLABEvFmtdCLobwN1V
         vybFsz8nYNS1zRM0npufgsVyS6ug+DjSjQcFtaXb1hS8e4i8NUHQccNEpKTI7uc2grJX
         hkpg==
X-Gm-Message-State: AOAM532xBqNnWm/0yiNelgVNwt9yKtQCV40tX4TstIJZARr8TJX6ewad
        TtSCY7ZgczvyoAzfK4U+MQ==
X-Google-Smtp-Source: ABdhPJzc1LE/Tdy0xRmiGMzYiTEmO8pmLRpngToU2Ig8re+Zg0QljB3LIZO9lG4SEHYgPPOeBnT1rg==
X-Received: by 2002:a92:a302:: with SMTP id a2mr1022465ili.116.1597982119184;
        Thu, 20 Aug 2020 20:55:19 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 13/40] PCI: dwc: Use generic config accessors
Date:   Thu, 20 Aug 2020 21:53:53 -0600
Message-Id: <20200821035420.380495-14-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all the platforms with custom config access handling define
their own pci_ops, let's split the default config accessors to use
different pci_ops for root and child buses. With this, we can use the
generic config accessors. The child bus accesses mainly require a
.map_bus() hook to reconfigure the iATU on each config space access.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 119 ++++++------------
 1 file changed, 37 insertions(+), 82 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 33e632a24466..07791b4ebaa7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -20,24 +20,7 @@
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
-
-static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-			       u32 *val)
-{
-	struct dw_pcie *pci;
-
-	pci = to_dw_pcie_from_pp(pp);
-	return dw_pcie_read(pci->dbi_base + where, size, val);
-}
-
-static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
-			       u32 val)
-{
-	struct dw_pcie *pci;
-
-	pci = to_dw_pcie_from_pp(pp);
-	return dw_pcie_write(pci->dbi_base + where, size, val);
-}
+static struct pci_ops dw_child_pcie_ops;
 
 static void dw_msi_ack_irq(struct irq_data *d)
 {
@@ -443,7 +426,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_pcie_ops;
+	bridge->child_ops = &dw_child_pcie_ops;
 
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
@@ -487,14 +470,14 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
-static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				     u32 devfn, int where, int size, u32 *val,
-				     bool write)
+static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
+						unsigned int devfn, int where)
 {
-	int ret, type;
+	int type;
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
@@ -515,79 +498,50 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	if (write)
-		ret = dw_pcie_write(va_cfg_base + where, size, *val);
-	else
-		ret = dw_pcie_read(va_cfg_base + where, size, val);
 
-	if (pci->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_base,
-					  pp->io_bus_addr, pp->io_size);
-
-	return ret;
-}
-
-static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
-{
-	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
-					 false);
+	return va_cfg_base + where;
 }
 
-static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 val)
-{
-	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
-					 true);
-}
-
-static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
-				int dev)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	/* If there is no link, then there is no device */
-	if (!pci_is_root_bus(bus)) {
-		if (!dw_pcie_link_up(pci))
-			return 0;
-	} else if (dev > 0)
-		/* Access only one slot on each root port */
-		return 0;
-
-	return 1;
-}
-
-static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-			   int size, u32 *val)
+static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
 {
+	int ret;
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (pci_is_root_bus(bus))
-		return dw_pcie_rd_own_conf(pp, where, size, val);
+	if (!ret && pci->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 
-	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
+	return ret;
 }
 
-static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
-			   int where, int size, u32 val)
+static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
 {
+	int ret;
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
 
-	if (pci_is_root_bus(bus))
-		return dw_pcie_wr_own_conf(pp, where, size, val);
+	if (!ret && pci->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 
-	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
+	return ret;
 }
 
+static struct pci_ops dw_child_pcie_ops = {
+	.map_bus = dw_pcie_other_conf_map_bus,
+	.read = dw_pcie_rd_other_conf,
+	.write = dw_pcie_wr_other_conf,
+};
+
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
 {
 	struct pcie_port *pp = bus->sysdata;
@@ -600,8 +554,9 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops dw_pcie_ops = {
-	.read = dw_pcie_rd_conf,
-	.write = dw_pcie_wr_conf,
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
@@ -660,7 +615,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * the platform uses its own address translation component rather than
 	 * ATU, so we should not program the ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_pcie_ops && !pp->ops->rd_other_conf) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
-- 
2.25.1

