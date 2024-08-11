Return-Path: <linux-pci+bounces-11581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864F894DF9D
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43017281A79
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751C17BA4;
	Sun, 11 Aug 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+bub5rz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52175134BD;
	Sun, 11 Aug 2024 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343053; cv=fail; b=JshVOb0hVNs7vWjDhihS5POK1eeO26MQBOY0zDNVE/I6nYcKAPz8h3EzcrQwMR6FK+kMi6OdAvwaq4wNQM3MOEaMIDX4D31hQrzEgHVfxjVyudKfCjGfrdqnpcGfrsRuySPM2Zpze35rlrsbuasmptiWOdLzpJ19Ri+alq1kL7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343053; c=relaxed/simple;
	bh=PIvbBKs22GCb64KD89ZQi1GElsSnammdCkD3WcrutZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfaYhkzgvPTWLrFOCpvYXSPEfOrBZ17C7c1DPSL8ngn/5Lj0oj1Vy3bP0H6qDYgbcG2pySy/jh+ToVdyRpyvirZquCpK1VK/pQwrgsqlUzM9waKXBrsY8bRU/Y7ngcw9WkK+zb+4Rkg2DGDmmKj+ADozaMPa2KOKFabzybZUsME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+bub5rz; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWoe+nDjDv//1uyIPnKzEDG6O5830elLCwgZasLNlBZpi7JmTOxaQfimBAHKT2gwlQWmKEL5CmQCWNfwvdUWCV56aL1VA/U5HeGrQF/79gPQn/05si/Ttx3x4J6/QBrQ4gPQ+8QKsXlYCbkrcUILfGGVdfNe+vjRCLCnEAWhaFeJ957oYtPgCKm34djVOtAL5V4ApLL/jwZLzbGbe3VBB14LZtSyq9YW28iHJhizb6oVptXdg9t85cCFAOEQs2jRwstZNa+Md8VAzD7FZOcK+/OlbVDnxF8ft7ODElJViXzdf8fjyPAMovTC+enxbpp+D3IryMEaLr/sSHij/T8cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2rc8i2Mj2nzPHOkyHFlQiZPHFWOIXenaKXby9DdNoQ=;
 b=kEEs05TCZQHwGn5wAyb3kMcf2WgMgrkAl/QKet+GvUk+nM8qZU+gshKPeBO3gF7E5WTQs2WIO1NemMn+gX2KjWCtX3iwrEBCaBSvSFmGVVuB/F/mGNKWdDo7JYS6EwheFj1qm/G13Z4/G2Lphy0KTpSYHR4FKNndlqgP4Dtv7FJBJR2/MoS4OpsOFRtoYdUTumEKXKRVhblTQZ7ro3KnfYK4I9g1XYgjAhTVWM8i8BV2CEwb9mZPjcBx9cdeR5jft4JoxllRdt0HdMXvbUr92g+DeM7xx2RB62w1BSji5h7to0cOTRcTX9VzChOot5Kiub9ObuU7QuCYucbPRdIW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2rc8i2Mj2nzPHOkyHFlQiZPHFWOIXenaKXby9DdNoQ=;
 b=Z+bub5rzmklwYV6BHYft+0jezFEzaPryL6C/q3gQQUyWADDqeyKfFgU8hd1EXZGphglggcPTzuVSTksbuXgrKU7wpm0U3g4UmjgO2OnPRV8XGM2zP7kFDyDn4TT58Rj6/y1YIlysUpuVbUfohlzzwRz/ptJrDVq6ZCXIRIQyC2g=
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sun, 11 Aug
 2024 02:24:07 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::ef) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 02:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 02:24:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:24:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:24:06 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 10 Aug 2024 21:24:03 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Date: Sun, 11 Aug 2024 07:53:45 +0530
Message-ID: <20240811022345.1178203-3-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811022345.1178203-1-thippesw@amd.com>
References: <20240811022345.1178203-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ad6829-c137-427d-03a5-08dcb9acad42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTZrOodY04CF9R/b2STY8GsUf+oFpMH5rkMyd59wq2gA7trv0dGLEr5nVO4I?=
 =?us-ascii?Q?2LnNhes5vU+AMer18a1QWi9FL/TxtSEPp/KrSBgWWDsg0VAuCBExg5nAVmji?=
 =?us-ascii?Q?0A/wUS6Hc44hFheZ8nmW4hX2G0xJKzcFdy32mUSJSHD5RIJnj2qaT5ZOxrJ/?=
 =?us-ascii?Q?Lp721zDG2MAjNZe3Jw0EgGoxHuhT6GhMk9DgHpeZj744ahPUOe7N6+qQ0FGm?=
 =?us-ascii?Q?Oc1iwvyTgY0F6RkI701e8T0sax0fR6RHm4JmIrcu/LhsYyrVFMt32oMTGZBk?=
 =?us-ascii?Q?oD/mPRBR9sBxR1H49EgNEr9XDUymrvGAXSvMF5Q2andL9qjiib7rNuCXZW0B?=
 =?us-ascii?Q?kuqDKhmW7UyxCGir90kWhk7EaW7nN1L8DiNipN9EfkEM20H7sYbuAOeLrfds?=
 =?us-ascii?Q?BhSfUIgtKWqYfeYe5P0aO1p0wNnK+a6PViGwFogmpFHkug0G/ttnDroVeVvI?=
 =?us-ascii?Q?AksLoFbCr2jTKnJlwlblUJ4+2ZVM/abLHCJFwZh8EprsHWJtf/mLshqWhhhY?=
 =?us-ascii?Q?XjW16QR72qpK536BOtYPmk/DNk4hcw6+It1ZkR6FjqchehycuCzPtRr22kQk?=
 =?us-ascii?Q?GKylrT0FGF1v1srh+oRpsCLhw1ZBeKSw0rMWtgIYYwsXhgG43aw+CaMEdQ+u?=
 =?us-ascii?Q?ZJNXUos1Rp5ALY478YfHu9ApJijKlv5fi3lLSlL/rMEJ6ZEgwi3u6H81NlnC?=
 =?us-ascii?Q?KHHYI2bt4hm18LaZt3kPWURybGpFY1HQ7qhETEnL/QY9ODZXqui1olCXuHsZ?=
 =?us-ascii?Q?sFeZ7NkmaSEWbqKCiwxjvIOi456YKWlQAWaPe+yQ5CsTNCCPRPjVV5wjeiZC?=
 =?us-ascii?Q?HJbiDrkfH6ly00fqqMsW55CT2h4mF+b4GkH1ul7Pqo6/PprFWFJjCjTgf8Bv?=
 =?us-ascii?Q?VBHoH0oiwhxhPDzqwXAhxtE/eHU4etffMtYnLztaKLRjjLpbceNHUtL1ZQF9?=
 =?us-ascii?Q?qaww/RybTYIOKwJJK0VqgpR5be4A3ANVl7Ev75XqkvAwAmHRXN5UTS27EOPH?=
 =?us-ascii?Q?ZJPB6YItcQx0CLssCcKZO0cBbf6JyAiV+PIVfOxE4hcEjR+kGPMThFa/rHW8?=
 =?us-ascii?Q?nJH07wrA6ViTtx3v84KsD3CDfLwe4kJAmMGoly2tuRWkXHuA0ioK1OfiVgNp?=
 =?us-ascii?Q?1i35GLIn9BJirBvXlAbQR28+iVRCguGtYQk8/lnp2iWhu38DaKeuahhtC/eU?=
 =?us-ascii?Q?FWrCeSBu2kb+F1FxiWq+U2bomrZUCueDySI1EI3WUhaU7e8Ydv7QpL9Xlgm8?=
 =?us-ascii?Q?IiF+NU/bM4UBs5TswZxqTh6sdwZn0OFV46opcLXxbVKzrav4GvkReWLU0wmQ?=
 =?us-ascii?Q?YqsVLxRjgrCinMPzrVpsmJclrUKI2QCLTo8ZKRo/mL0S9hgkqpQu4BBkuaB/?=
 =?us-ascii?Q?aDw6674JsmFeTkO9KtYpbCxSlbF5MMXNb7rLNJ+YPyN+QUsKng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 02:24:07.1440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad6829-c137-427d-03a5-08dcb9acad42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

Add support for Xilinx QDMA Soft IP core as Root Port.

The Versal Prime devices support QDMA soft IP module in programmable logic.

The integrated QDMA Soft IP block has integrated bridge function that can
act as PCIe Root Port.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 54 ++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)
---
changes in v4:
- none

changes in v3:
- Modify macro value to lower case.
- Change return type based QDMA compatible.

changes in v2:
- Add description for struct pl_dma_pcie
---
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 5be5dfd8398f..1ea6a1d265bb 100644
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
+#define QDMA_BRIDGE_BASE_OFF		0xcd8
 
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
+	if (port->variant->version == QDMA)
+		return readl(port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
+
 	return readl(port->reg_base + reg);
 }
 
 static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg)
 {
-	writel(val, port->reg_base + reg);
+	if (port->variant->version == QDMA)
+		writel(val, port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
+	else
+		writel(val, port->reg_base + reg);
 }
 
 static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
@@ -173,6 +198,9 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
 	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
 		return NULL;
 
+	if (port->variant->version == QDMA)
+		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+
 	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 }
 
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
2.34.1


