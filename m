Return-Path: <linux-pci+bounces-11524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B694CA2D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDCA1C22D5F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 06:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821C16D4E4;
	Fri,  9 Aug 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRtZ6Kdc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AE16D4CC;
	Fri,  9 Aug 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183830; cv=fail; b=HCTxDYOV3nvrIhEz/dAL8HjxKTrMfr4pJs7FKWHE2ztKb08M97KxI+2KIoC/rNYLAjj4Z8O9XYZ6XQv59t+rG8ahyJQy6TuxCCEx2Ruxrha6zs6pZCOnEjbjXL3TtaTqMTikFoNpfRggRhTUcoblRV0FSKSXTamZlgKCzeBufVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183830; c=relaxed/simple;
	bh=rpVW0vpP5b/EWMBsKmMl69gcAxJwM0YmDSEy12QalIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkuTddVAf+0mYbM4lXWml7nS51EW20zF7baZq0M1yQ0wlJjsPKYmz2PdmiNDhlKGonCrSg7ZYR/f3WTc1DPwJzOou/XAw+YA/HbvrwVTyYMr0fDojTrXRaHg8nflQ8IJprmt8/+y5m9N3wa/MXGDVYetOH6Y5r5ftNsSYWlmFrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRtZ6Kdc; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X50pZJZvyJ8yvC9qZCBEKm9LcM/ZFSKL8Op4/Hm1IXNpRrZ9q+CDd+3MCMFeF2QWl8J6a5D4eoZu/8FGbXJRQJOGKm+tRwO5ukyryp8YlnPLXeamWMgoGfgovKSaVaDm5K67irALKdZotHm4301jnuuR/vbJYYuM7z7SiJDrOfY2BOufNTzPA9loRbj6+MzsY9TNjY5LKSZMeav7n1TuiVvZ4gRK+aDFFilb/fDOMweF14cTbsYS7f4uKVRgfuf7nPzpy8MYX0JipXB3obFnvgOF+33jWoJYlblebWqTKQLsOFQIauzgX+dXFv1u/XrW5a38mXC0VPqJ8JIAXIUqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSvliGXM6RjpleEhm3T+02cYltFUJux7sC0V/5wdjOI=;
 b=xAUcpGtybWhWKr5tYa1mygLHDZ5y1O5PNfSsVtga1g9o2OrmUc4gXYnz9BvPI8uHL8GOA0I8cgoh1CeZPnfGRKjhZNoIv1xmil5Hp7f+AWHXHSRUgZp1/L090GGSyePKRDIpKnKrqKlEX4KHZWLKaBY5C7xeReCBaB34WqAAXD0YpGmSD1M/nA50xHzRqCqgCuIAAXX9k/69gBzFOX1JsHWHCpFKY18CubCZ/yeI/vRB89PkrvIG+LM3pApvjXQItlWY9U4rGVC1n0C9NBilxnuKS65TYQnunUS21aMi7YXWtTZgAHrnEMySt0oapoeIVxO4+VcK3fzxGkbCXRkX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSvliGXM6RjpleEhm3T+02cYltFUJux7sC0V/5wdjOI=;
 b=WRtZ6KdcX5EzbzBFzwIZ3fBYSRsqO6N0lhBSWa1wBG5YlXS55L6BHASnKsODsczFNnyWqbBa6RsKcnVMygeUyqxzjhx86nc9N04Jsr936+9LrwSTgGwNgE4V+ukxiZClm1VoyzA9BWD7HSBANzSiZhjUAZUad3/oezJmzj6k5XQ=
Received: from BN9PR03CA0925.namprd03.prod.outlook.com (2603:10b6:408:107::30)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 06:10:25 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::b2) by BN9PR03CA0925.outlook.office365.com
 (2603:10b6:408:107::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Fri, 9 Aug 2024 06:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7875.2 via Frontend Transport; Fri, 9 Aug 2024 06:10:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:24 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 01:10:20 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v3 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Date: Fri, 9 Aug 2024 11:39:55 +0530
Message-ID: <20240809060955.1982335-3-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809060955.1982335-1-thippesw@amd.com>
References: <20240809060955.1982335-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c74092-8fd5-4cc5-84c7-08dcb839f5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZxTSyZ7z1QOVfDCoxke27snGTYuT1V4rNUnFrAnZJOlUOLfpHm1NpTIXYzi?=
 =?us-ascii?Q?5wTIhVVSgPqfQr7zFgk+Gnkyq/+oBIlnUniZs1gSkn03aGTMvAl+3EjMmXib?=
 =?us-ascii?Q?GusfBpb0YLMAp7ey4VVEizXGNGe6BzuiFgE0CVKeSyowvfRR5AnXGH/BNfpK?=
 =?us-ascii?Q?/frBmFh2xfk0Vh/D4kls4aogkqfBnLG1CBjzlKcWmFRTFtFnh7vmraICLepg?=
 =?us-ascii?Q?yXOsJZf0NztlU5AYe9rSbvmoZIe+ouVs8x/cQfY6Cg+fh6q6nehgcF11/ONG?=
 =?us-ascii?Q?I4ot1sFYlqgIc9jQl66jDHEMF21dXukx7JRV5VqfiEiGC53/sBBZi3tQryuW?=
 =?us-ascii?Q?3UiGIoObhq9xu6CMPKOukHCn16MYiNNp32dcmkQe63Lfwm+uhqPHyCrwlJ2v?=
 =?us-ascii?Q?lyYy/o3tbN4BpXfDS6vAT8hzk3iC9Eof3p5LUTCatY/3XnUclaTszQlfStch?=
 =?us-ascii?Q?g7DQPPabHvsHfLLnRrlrx5T8cENHAEPCoGsR8QHtmcfGuNxw9AGqTxnaHTdm?=
 =?us-ascii?Q?TBatHy684l3AwRqe3T3KO+VAceOcktwTvmtOP8LxQJoqKelksEjYekZcxA4g?=
 =?us-ascii?Q?tXQarxpz4s7NRf8cXvoGXlfjvs5UyjmtyBj+TCkRbRycVZ9T2GpBMYRiJomg?=
 =?us-ascii?Q?bicI/286rkVHyr9Vn3GidYTfaICNmag7KG/xwKe7israhq+b3Z/Qys2k5Waf?=
 =?us-ascii?Q?8N2giPYMPVkN7HcSiDsbLKSMEoIDZRtNNjoEWPivmvPMUyJC7tIeQAbwFsdj?=
 =?us-ascii?Q?fFL7KhAkBVBlIAZDP4FOV1U7e5mkhvwisxeoioZ3curQGrfzXASunVPECFlS?=
 =?us-ascii?Q?emrVe8HzDqWJurYf6AXT3Z2QgOQ+e+Rf1N+1hkRL0cTdhr5siLKi3G5vOzlu?=
 =?us-ascii?Q?7bTS6Ma7+Lp3Ztp1fpiI4FqTikKfex/LvJ80py+dCyHYmbeHW4Xx2WHvKU0Q?=
 =?us-ascii?Q?7I/5vj0d5eFa70BIz6H9KL+Yo8wGoHG1vkczSJMkpGLeqazIC45I5FekLAYH?=
 =?us-ascii?Q?BUDwSFpz+0FvKS1DLi9cpyCjqjxQlzNFkjapBYZWKm0NYmlGZHuy1VpJgwr7?=
 =?us-ascii?Q?eQ7WeiYPPJZbDQqFAvPfBxMgdVRHs+qDDFkSRpghXw9JH2c3XLQR4gE/QrAk?=
 =?us-ascii?Q?SoHbMqnSoRMaQmRH37lB4Z6sUYyoam0eElafLHdHxHkWMTpkpQ3DMnV+FU7O?=
 =?us-ascii?Q?1H4ihmLCbRTga87aKkc37XUyhKXUvaulDpSxet03LQOmTmkuf7MY+CdVn27E?=
 =?us-ascii?Q?+DrABS8TibgtT7gTKQlD3RNaHcLnE/oryZu77cgA33Uyoi87cCDeowTbi0CL?=
 =?us-ascii?Q?pyYF+/HU7+RJR97ldc9pnETqTdWWzYHZ57R7p+NI8Cw7DGBB6hNstyhkufPc?=
 =?us-ascii?Q?Vl9Gk0jGkiTfTvIg/i/v/Mbv9aiHyRfUw41qBXlAXoRO8TOHiuhu38LOMtJh?=
 =?us-ascii?Q?mNh0ozDH+8EfvOIEO/EIebz6twjgfM1o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:10:25.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c74092-8fd5-4cc5-84c7-08dcb839f5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

Add support for Xilinx QDMA Soft IP core as Root Port.

The Versal Prime devices support QDMA soft IP module in programmable
logic.

The integrated QDMA Soft IP block has integrated bridge function that can
act as PCIe Root Port.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)
---
changes in v3:
- Modify macro value to lower case.
- Change return type based QDMA compatible.

changes in v2:
- Add description for struct pl_dma_pcie
---
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 5be5dfd..1ea6a1d 100644
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
1.8.3.1


