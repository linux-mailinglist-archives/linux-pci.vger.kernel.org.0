Return-Path: <linux-pci+bounces-10583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CAE9388E6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F025281258
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BF518052;
	Mon, 22 Jul 2024 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CckNxvr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377771BC40;
	Mon, 22 Jul 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629598; cv=fail; b=fbpEQwJPXrn08Pqu++6K4VQFl2sHghqcRnHF8JVs9XrmjI+SysFcoSrMQ1RHDEfM9f1nw4koPxKk8iLQqYWjLd1pCXjM/mV7m+sDHQi22WRJxTRBD0Hrt1n5OAtFOot6s0EU84WTiWiwRI0y1HTQ2Kpz1+bgedxSPWfoQRkhWxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629598; c=relaxed/simple;
	bh=JHjIK7qZfB1tYQ/MwFW7Zc7/YJCZycvQwY9G1awJkyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHulkFNjL7ciXb1s+CQkXuQwJEScr38ZIpu79UhGD3ukb9QMYjqBFUsHHQjyG5AEkInRkLvg6dCOQJuZCfsT0TQENM5rEYtCBQgSd5ngqSS9KHkZhCIlYOHyySwrWQl1mnxRekl7wfxO0WytB33y6CkEdVUfm9tKAaNshEixqU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CckNxvr8; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MANpQgS1bl+1VoK8MtR73k/kfe3dVDhfo8DLBYI+ZzrRDbMkzk+q/7fIv2+LG9JcCKj6KXFH+mO0cw6yX/+LPcRZGGkkOgSa9ckqEcdBtmA1ac3t/BjjCh2p4pP+RkHLtrTwKDXqvyjwBX1FEnU/mwIJWru+q4CxRdh+swrQuUq74mD4PSYolnzM5ZrcdLwxqvNu6xjNcK6FOH25sElzs7jvba8AeWGkLaH3S3mx+epIopN0efHwVi/KSuVyjA7c6XROITpx2xsiRweu2wR6VthfqfoR4imqBylZRxVy4gTpBBeurxSa73/bK/WAkZfnFTB++dPoCcpzlbYwe17uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPa5N7tmghtSEV/oNpdhGvF7mzdGeBTsG7Fm6bcCEvQ=;
 b=wploxtGnObTELkoJArgd3ZXNwYDXS316/dy/S3Sy10gbNOmzZz0sLGNydbXeDLbH+cdLwQWFwdDcZIXKHoIsaMg3demvd1zJPms0SuPaG8TlNMc/5wAPARGbFW4UPS7AoLtwhSMHkWKch87C+uqsWOkoDxQRG0LA68BK8+X13jGK0oGYODOoyvovlz65ZFWOYR4ebi9403mK23cvn8Bh77vJ6wkBvyNHzYfSHfyKK4hz8pwb/5n+LHn1MgycXW+XE3bSAYk9Kj83vVT7oITnRK96k8Rc1TjgpSQ9eNNjCG660maL0i4M3gmPC+3zQ5aqY9obthyTcLBGw/8xegAMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPa5N7tmghtSEV/oNpdhGvF7mzdGeBTsG7Fm6bcCEvQ=;
 b=CckNxvr8Wy7k8sKs315zAyFvl6/SAHc0VCeeTjdRfBSjBD/aGIYjVCc13b7NPTjJErl2glmgxvTUomakrEnEecCmYBrY+P7hZl3vrvBT3STPJ6LEMDPzGYvFOk7rSuKPizzVLIHmp/ST7Y9tKM2Pf4Vp0h/7arE+wHDA+flJyR4=
Received: from SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::26)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 06:26:32 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b) by SA1P222CA0070.outlook.office365.com
 (2603:10b6:806:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 06:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 06:26:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 01:26:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 01:26:31 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 01:26:28 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v2 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Date: Mon, 22 Jul 2024 11:55:58 +0530
Message-ID: <20240722062558.1578744-3-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240722062558.1578744-1-thippesw@amd.com>
References: <20240722062558.1578744-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f694b3b-32fb-42cf-546c-08dcaa173aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ov0XAOi6PdAwqOqILvJsgRnr0H2jM6hreW6MRLNH3Dg1wTPHXzwFotaXZ+1?=
 =?us-ascii?Q?uSDYpQFhmV/21ydPw6KxhdV0SMwC1HMd21GtZgJZMNxqxoFkgrWW20royltV?=
 =?us-ascii?Q?WOBjS/we7WkdfiZwAcKm1clhYKaLJvRe9Nn2jdvkLYRcuw22awKnsP1moLBT?=
 =?us-ascii?Q?noTi9rMvWv0keg8/Rgsuw0GewUiNT6JRtPN3ln6+p0L6Bg7s/l1bHTtHr4Dw?=
 =?us-ascii?Q?RbQ2g8IEPys/czFcHgXdmzGYTQ0uLMZ8kdHE5oUyXkeWUhx7YoYXL3RZOBhB?=
 =?us-ascii?Q?Azb8M58JlkiiAyCUn3DQx5eL5tceChg0UevRNnEBDQ12fPLcfsLvmpxOreYN?=
 =?us-ascii?Q?t5mSRQpPPPttY/NQLf4zc7dCkSapGR08sNXaEfbIHz7jIA/ikM4ZLGWeP5Fh?=
 =?us-ascii?Q?fHrXbZA2dRKrj80jNcvdcKKcTJ+ib6C6MEwF+8KfVbPEYh7pKsDPoFGkwlEm?=
 =?us-ascii?Q?FRpv9wtVK5fsXUJMxO2ioCeFgP2jm9ZxP/P0nYsdVOVZp2V6kwY0ZmNwD6I/?=
 =?us-ascii?Q?AGQjsWFuH6YFadLHiSr27GtZoZXPPz7zwrBgSMood8zMrL/WLV/UDE36uSQv?=
 =?us-ascii?Q?ENkH/bfOMlGaxc0bqHi6o//Ps2DkYcosyXNsusOzd1mQ+549Auso5rkcNtEs?=
 =?us-ascii?Q?KJBpoH8LxydBjlGaNcN+a920TVIx9TaKehgeKc9/CNse2Li3R0rk0WAD23kl?=
 =?us-ascii?Q?1kCSKOMDbX04A1i3qxg3LMhpsfEkliGhlbvspb1k6+zM8BniqJeEH64jy4X4?=
 =?us-ascii?Q?yXHeGilc5K0Rl0MLbw0E1aG7uU0/SQa/pt9V9lOfY/reSVg01FmJf/qlKKnp?=
 =?us-ascii?Q?D4NAkh4hxdHujMDAxuRQWxX0mKwncs+X6axvpGozv9lSzkpL4Id2dmnEH0qA?=
 =?us-ascii?Q?8/Rnkl+sGfnSpkWphRg5lPxugHkk0NEWELjxrdXuGVnVZzsMvM9jVvtHQqWP?=
 =?us-ascii?Q?bzI+6KiiXD05BDqx1TXIQ+CO0hEl2LSqYDk9gjTWgSgl4d19speauUdVJFIn?=
 =?us-ascii?Q?vnHFM5MUnbghrnBSKftE33rxmIo7qAgbZFazEu7YkVcPYxvYtiFSBzjsv2rJ?=
 =?us-ascii?Q?8AEy/Xl+3BWAgrDnmpBu+fx+zrEZbRPco82JZ3zvbLAKRCZZg6dMQbJjt76k?=
 =?us-ascii?Q?1i1u8Q5L6jPS8FVrcrAhQu+GYK3QDRn2jty2qKTRxtcFBEXTSlvYcAtpx9Sg?=
 =?us-ascii?Q?X6BmYxDCnVPbQ15yPQFDIcd7mnqtWe4JmDX9K89T+iiwpRDDsjsC77xPDQmd?=
 =?us-ascii?Q?zH4APohfh04WEn9IvSUAO0J5h9PrE9DOIYrHgy0TVTKT2jjoMl1ZISdMuT4a?=
 =?us-ascii?Q?oPNnFpxO3jTfmwZXW2X3pSnXIhM+o9U5FQ4o3t1BRpppPuIFiYJKw8V/MZD1?=
 =?us-ascii?Q?cFgGqUaFmC+MAeLmb+R6ZYDB18mO6QVVYvKASxBCEdvpxB5f0Jb7gs6u/mvh?=
 =?us-ascii?Q?l5QbUMD0gtMabx7jvzA7P2y5/kg/+zIL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:26:32.5089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f694b3b-32fb-42cf-546c-08dcaa173aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

Add support for Xilinx QDMA Soft IP core as Root Port.

The versal prime devices support QDMA soft IP module in
programmable logic.

The integrated QDMA Soft IP block has integrated bridge function that
can act as PCIe Root Port.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 58 +++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)
---
changes in v2:
- Add description for struct pl_dma_pcie
---
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 5be5dfd8398f..933be090f92d 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/of_platform.h>
 
 #include "../pci.h"
 #include "pcie-xilinx-common.h"
@@ -71,10 +72,24 @@
 
 /* Phy Status/Control Register definitions */
 #define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
+#define QDMA_BRIDGE_BASE_OFF		0xCD8
 
 /* Number of MSI IRQs */
 #define XILINX_NUM_MSI_IRQS	64
 
+enum xilinx_pl_dma_version {
+	XDMA,
+	QDMA,
+};
+
+/**
+ * struct xilinx_pl_dma_variant - PL DMA PCIe variant information
+ * @version: DMA version
+ */
+struct xilinx_pl_dma_variant {
+	enum xilinx_pl_dma_version version;
+};
+
 struct xilinx_msi {
 	struct irq_domain	*msi_domain;
 	unsigned long		*bitmap;
@@ -88,6 +103,7 @@ struct xilinx_msi {
  * struct pl_dma_pcie - PCIe port information
  * @dev: Device pointer
  * @reg_base: IO Mapped Register Base
+ * @cfg_base: IO Mapped Configuration Base
  * @irq: Interrupt number
  * @cfg: Holds mappings of config space window
  * @phys_reg_base: Physical address of reg base
@@ -97,10 +113,12 @@ struct xilinx_msi {
  * @msi: MSI information
  * @intx_irq: INTx error interrupt number
  * @lock: Lock protecting shared register access
+ * @variant: PL DMA PCIe version check pointer
  */
 struct pl_dma_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
+	void __iomem			*cfg_base;
 	int				irq;
 	struct pci_config_window	*cfg;
 	phys_addr_t			phys_reg_base;
@@ -110,16 +128,23 @@ struct pl_dma_pcie {
 	struct xilinx_msi		msi;
 	int				intx_irq;
 	raw_spinlock_t			lock;
+	const struct xilinx_pl_dma_variant   *variant;
 };
 
 static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
 {
-	return readl(port->reg_base + reg);
+	if (port->variant->version == XDMA)
+		return readl(port->reg_base + reg);
+	else
+		return readl(port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
 }
 
 static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg)
 {
-	writel(val, port->reg_base + reg);
+	if (port->variant->version == XDMA)
+		writel(val, port->reg_base + reg);
+	else
+		writel(val, port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
 }
 
 static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
@@ -173,7 +198,10 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
 	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+	if (port->variant->version == XDMA)
+		return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+	else
+		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 }
 
 /* PCIe operations */
@@ -731,6 +759,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
 
 	port->reg_base = port->cfg->win;
 
+	if (port->variant->version == QDMA) {
+		port->cfg_base = port->cfg->win;
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
+		port->reg_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(port->reg_base))
+			return PTR_ERR(port->reg_base);
+		port->phys_reg_base = res->start;
+	}
+
 	err = xilinx_request_msi_irq(port);
 	if (err) {
 		pci_ecam_free(port->cfg);
@@ -760,6 +797,8 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENODEV;
 
+	port->variant = of_device_get_match_data(dev);
+
 	err = xilinx_pl_dma_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -791,9 +830,22 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct xilinx_pl_dma_variant xdma_host = {
+	.version = XDMA,
+};
+
+static const struct xilinx_pl_dma_variant qdma_host = {
+	.version = QDMA,
+};
+
 static const struct of_device_id xilinx_pl_dma_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,xdma-host-3.00",
+		.data = &xdma_host,
+	},
+	{
+		.compatible = "xlnx,qdma-host-3.00",
+		.data = &qdma_host,
 	},
 	{}
 };
-- 
2.25.1


