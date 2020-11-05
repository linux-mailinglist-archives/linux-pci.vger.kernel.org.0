Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06C82A8893
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgKEVMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37784 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEVMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id m17so3188054oie.4
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6R4H1g6vXOgAE77RIvtrXBSttU89rZUu0tXug8LN9Q=;
        b=Z+3S/M70GKQ8GbvF1qYjQkbKdZpV538rBdtQyCo8G2YwT2tD/DwVSzOD3Cl9h8+HMx
         OPwbz6LqrL1Q074yeTQBRWe8M1BuQvwGCM+bs/t9KHQ/PZp1mEInUxgHc0vLoDZZU4R6
         6DGOg1sJMxFNMIqL/meTHXqfocFhpGq6SNC5kSQCRocP3V4duMhJ/2l05d7B+HnBjD93
         cODLlov6I0+J/Abh1tm+c8c/iSa+xT8B9olNo/cKOEMpaWtec5edpl+bHr86VbRRcWnX
         QJE6YZcXlgCkspqLI77j7pf65IB4D5M4tlnipLM3u4xhU2fMJzsmoHnIRZeLW9cFLOyI
         Gqyg==
X-Gm-Message-State: AOAM531HfbEkvMR/4DmR1oSxzDzr4YkEx4oucEh2OoVXXxn/l3CCVxEq
        fVfTVlZ0E18z2/Es+KYW0VwI6C3/Duay
X-Google-Smtp-Source: ABdhPJzRRgPYI228nYGhQP0KXdxEp7EmSKvVZtf3/2UUVia+C9yEJNc/ybenYHFl3pwJLWFsefoc3g==
X-Received: by 2002:a54:4094:: with SMTP id i20mr930382oii.0.1604610723873;
        Thu, 05 Nov 2020 13:12:03 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:03 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 01/16] PCI: dwc: Support multiple ATU memory regions
Date:   Thu,  5 Nov 2020 15:11:44 -0600
Message-Id: <20201105211159.1814485-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current ATU setup only supports a single memory resource which
isn't sufficient if there are also prefetchable memory regions. In order
to support multiple memory regions, we need to move away from fixed ATU
slots and rework the assignment. As there's always an ATU entry for
config space, let's assign index 0 to config space. Then we assign
memory resources to index 1 and up. Finally, if we have an I/O region
and slots remaining, we assign the I/O region last. If there aren't
remaining slots, we keep the same config and I/O space sharing.

Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +--
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 44c2a6572199..a6ffab9b537e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -464,9 +464,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-				  type, pp->cfg0_base,
-				  busdev, pp->cfg0_size);
+	dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev, pp->cfg0_size);
 
 	return pp->va_cfg0_base + where;
 }
@@ -480,9 +478,8 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
-	if (!ret && pci->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_base,
+	if (!ret && pci->io_cfg_atu_shared)
+		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -497,9 +494,8 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
 
-	if (!ret && pci->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_base,
+	if (!ret && pci->io_cfg_atu_shared)
+		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
 	return ret;
@@ -586,21 +582,35 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		struct resource_entry *tmp, *entry = NULL;
+		int atu_idx = 0;
+		struct resource_entry *entry;
 
 		/* Get last memory resource entry */
-		resource_list_for_each_entry(tmp, &pp->bridge->windows)
-			if (resource_type(tmp->res) == IORESOURCE_MEM)
-				entry = tmp;
-
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, entry->res->start,
-					  entry->res->start - entry->offset,
-					  resource_size(entry->res));
-		if (pci->num_viewport > 2)
-			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
-						  PCIE_ATU_TYPE_IO, pp->io_base,
-						  pp->io_bus_addr, pp->io_size);
+		resource_list_for_each_entry(entry, &pp->bridge->windows) {
+			if (resource_type(entry->res) != IORESOURCE_MEM)
+				continue;
+
+			if (pci->num_viewport <= ++atu_idx)
+				break;
+
+			dw_pcie_prog_outbound_atu(pci, atu_idx,
+						  PCIE_ATU_TYPE_MEM, entry->res->start,
+						  entry->res->start - entry->offset,
+						  resource_size(entry->res));
+		}
+
+		if (pp->io_size) {
+			if (pci->num_viewport > ++atu_idx)
+				dw_pcie_prog_outbound_atu(pci, atu_idx,
+							  PCIE_ATU_TYPE_IO, pp->io_base,
+							  pp->io_bus_addr, pp->io_size);
+			else
+				pci->io_cfg_atu_shared = true;
+		}
+
+		if (pci->num_viewport <= atu_idx)
+			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)",
+				 pci->num_viewport);
 	}
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9d2f511f13fa..ed19c34dd0fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -80,9 +80,6 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_REGION_INDEX2		0x2
-#define PCIE_ATU_REGION_INDEX1		0x1
-#define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
 #define PCIE_ATU_TYPE_MEM		0x0
 #define PCIE_ATU_TYPE_IO		0x2
@@ -266,7 +263,6 @@ struct dw_pcie {
 	/* Used when iatu_unroll_enabled is true */
 	void __iomem		*atu_base;
 	u32			num_viewport;
-	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
@@ -274,6 +270,8 @@ struct dw_pcie {
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
+	bool			iatu_unroll_enabled: 1;
+	bool			io_cfg_atu_shared: 1;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.25.1

