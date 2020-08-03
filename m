Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134EF23AF12
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgHCVBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32872 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:53 -0400
Received: by mail-il1-f194.google.com with SMTP id p16so21556272ile.0;
        Mon, 03 Aug 2020 14:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saXc7GUoDkesF20I7UFsdi9hPtbZ6gcBdE2OHbCMpCA=;
        b=AeuRLWSgFcKQKmcANc4PQpwnG/FfjVS5DBAAZmtpNLJ2Lz2mTjil0TYg78nbYTcf1c
         PBCRbI4wkh8CDQuvRQm5vwU8KNy0g6Uvw4ajb9GgJoRdiRN/z3d9q/wyw81CxC2PJAXe
         6SKg4I2awpPeU669tvQW6/jZLaqzDfO+zI4A93vQ+K9p6ZEYrIqL+A8U94ixzGxfzlo4
         /qeF5z0Ql/truWgtft41t+ZIBYK5nplUtDy7vp2LIvMU5nuS15h/RlyNkkldqP9JeYzz
         RpMSJe2VRJXZZ12AH9RaJHGxuU19CQpdnJpD73M707LV5fh56ep5wqVnAFT1PGCipylL
         6k9A==
X-Gm-Message-State: AOAM530kyD9aBgA8kgPBFWtk/Ymwuoeg79HyUu+VzQWFbDeM8HCSGCYv
        h1+P37VmaH7SCDdNkxDlRA==
X-Google-Smtp-Source: ABdhPJyvv0uRK79mfofQnWPAX/lrUkNhl98uSGAQALtBwC5yCmLzPHG/gk1AEvK1d658EgveC+qAIg==
X-Received: by 2002:a92:d1ce:: with SMTP id u14mr1318029ilg.270.1596488511699;
        Mon, 03 Aug 2020 14:01:51 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 13/27] PCI: dwc: Use generic config accessors
Date:   Mon,  3 Aug 2020 15:01:02 -0600
Message-Id: <20200803210116.3132633-14-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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

BTW, if there are only 2 viewports which means config space and I/O
accesses are mutually exclusive because the iATU window is shared,
how are accesses serialized? That seems broken...

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 120 ++++++------------
 1 file changed, 42 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6e9f106e8e05..e9778f8ee955 100644
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
@@ -448,7 +431,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_pcie_ops;
+	bridge->child_ops = &dw_child_pcie_ops;
 
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
@@ -498,14 +481,14 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
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
@@ -526,79 +509,59 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
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
+static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
 {
+	int ret;
+	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	/* If there is no link, then there is no device */
-	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pci))
-			return 0;
-	}
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	/* Access only one slot on each root port */
-	if (bus->number == pp->root_bus_nr && dev > 0)
-		return 0;
+	if (!ret && pci->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 
-	return 1;
+	return ret;
 }
 
-static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-			   int size, u32 *val)
+static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
 {
+	int ret;
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
 
-	if (bus->number == pp->root_bus_nr)
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
+static struct pci_ops dw_child_pcie_ops = {
+	.map_bus = dw_pcie_other_conf_map_bus,
+	.read = dw_pcie_rd_other_conf,
+	.write = dw_pcie_wr_other_conf,
+};
+
+void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
 {
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (bus->number == pp->root_bus_nr)
-		return dw_pcie_wr_own_conf(pp, where, size, val);
+	if (PCI_SLOT(devfn) > 0)
+		return NULL;
 
-	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
+	return pci->dbi_base + where;
 }
 
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
@@ -613,8 +576,9 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops dw_pcie_ops = {
-	.read = dw_pcie_rd_conf,
-	.write = dw_pcie_wr_conf,
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
@@ -673,7 +637,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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

