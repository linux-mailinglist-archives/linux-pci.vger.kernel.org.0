Return-Path: <linux-pci+bounces-9178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F99147C0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968FC1F2327A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13B137752;
	Mon, 24 Jun 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbZlN3a1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DD13791F;
	Mon, 24 Jun 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225792; cv=fail; b=TBP4Hg7mW0bgoGu/bwqeaSTWaraIWQQZpw7s3xrok6LOtzCgIwaDdTAiSkMAgtm5jMCOtVozB+O+ipLJRMwX6bI9++LXudn7q06BOy7SIeRojPCRncd79xTOiGPx/F6HAcpsCTK4tWmYx8ZhLYG9Rfom/Nb5H4vrag6y8lWvSDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225792; c=relaxed/simple;
	bh=G8GTwrEXm9q29Ypqw9fegSHrZ124NiHk1UHEoZo3pMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJiPczp5rQzJ6nP44FD53iPrQeOO8tqIeCBhpgKmu3nfY6F5mP1GD1QMFoMNpG6A4drxVI79kS1IdU3TozEZ8I5uG+U2V5U6sBCWhtD8mxWQk31rNU2awMoPf0Wo+wMthL3IgyounKcxV7vZHqLDEQmWXOMdrDSmRJ4mWVVnT5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbZlN3a1; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdBP4t+WoQd+BoNENexqi5ayliKxtoW+NVnvNNklF/cJnD5rbCY9rJvxbeDFP0AsnmazhLAvRXO60zYtxI/ltX9vFbPiAwRp1TKweKAVjitozDztRUY4lzHfOnc5KU4XNT/22RODcvtDI5AucTZmVL3on14Xhv+nUkSPPu1ISZx/jbMdRN8lyCqwB8Q4OwaPCOuS7HHkuuTX9MAj0ONnifhU4l3QF4tt67jqjvIGYJPk7AIYIYLHlgsa/O1mtsCdKSYX/NLg5Uxn8sJycuFmve9AG0BWF2tK3e0dQyy/y4HhgFSWR2wPM56UlgF6dY8uq95IkWZTcANEDBIC6iT7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5xbvILO+7Sv9OFuN/NzUsM0XKp5fJkyQq5pmEOflN0=;
 b=lcl9BgYN7MXZa8pHZhW7QdmMCjecD1a9eZhydQ23z188kS4szSugGl+ASK1djhlZ0xQGMTGKi+CMUC6zD6Z9YKEp/4cH3RP7mxiNBJ5oDpnlTVWSBSE6sZ3q6qxZyrFQBdAsogP6wXiNSbSOtpxXhqc/AcH6xB0Zk8BIT0CKgmN/hJ2DFSuZ5zBqnw0UpPopiCJNk/2LBXe29rzrU8+D/svo/aMiZUbMGXo9+cV5GSVrDwfAg3a+wH4lulwGfJHspuPxbstGhQMKr770/9rPJtKKzgOt253m7ftBh8QB6hdluu9exSX4SfAHl/SEugChdIZQGRnAQYp2f0S58+Fs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5xbvILO+7Sv9OFuN/NzUsM0XKp5fJkyQq5pmEOflN0=;
 b=pbZlN3a1ZYIfDKJmqiXC7XrScQIeFN8hC4gg7lXDhfPS33Upkt0EX+BUiHuXin+8jaCd4UFwV87R5WKElziM7kklBy3HFMWnSW971nlyruVhgrSDOXHi4c7zMtOa+0ugCOQg+aLPwCVm2gW35crYUtU9X5b4B1GeTDVCCaal74w=
Received: from BN9PR03CA0422.namprd03.prod.outlook.com (2603:10b6:408:113::7)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 10:43:08 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::2d) by BN9PR03CA0422.outlook.office365.com
 (2603:10b6:408:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 10:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 10:43:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 05:43:06 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 05:43:02 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <bharat.kumar.gogada@amd.com>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Date: Mon, 24 Jun 2024 16:12:39 +0530
Message-ID: <20240624104239.132159-3-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624104239.132159-1-thippesw@amd.com>
References: <20240624104239.132159-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff702bd-ed17-443d-34b4-08dc943a6f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6fII/9DI+AeGTcAFgFd+9VJxkWerU4TJBvdj/1SFIogaKSncB17xh0TWgNl?=
 =?us-ascii?Q?cGzH22EjqMp2rUli/WrfVas7VQ0iru1whZWEEtylrQ3V1EWL5uAG94wKILP1?=
 =?us-ascii?Q?7kL46C+SDMaB7ZatrlsnSZBHAy1fQ5v+3o8IpNtvbzbL2QQp4rOc6a5vsKNH?=
 =?us-ascii?Q?8cJgq3SS7I/bhsnb5sIA9ySofZeu74RqlP5TmWHA2aMOOwXAMU6v1iwZH8On?=
 =?us-ascii?Q?qB7NXmWDQtCUQGsgNsgK3IkB7lkM6eft1qCJ9n+KrHoQB1XIy9pYfEdBCXgb?=
 =?us-ascii?Q?P+GDZ5ctfc9QY3hIuqzpWHFCaCGXSuQ/83J8nidC2oiLWpecM0xvYlLz6Q/f?=
 =?us-ascii?Q?58S76Ct2AfRBUWkGvI2UjRYzxpL3TM+WD6xqm1eF+GAuiSSGrNRMra7WHWTK?=
 =?us-ascii?Q?h2dl/YA4Q4yeyyKh3KaeK9NDQQhBr5XEgl8ng7q2yjIGJkUgnirgjrCEI/3G?=
 =?us-ascii?Q?2J9oVWLWYmCMTBpmT37o9vlF7qMSRwHzKPb21mqzx/GhrU4SylEJqG8UMq7A?=
 =?us-ascii?Q?clwo/Gat/4nBJXDqVrKfiG2XvWrSh/iNgRyMk4kngEHSb0b9Mpn2Ss0ydXqC?=
 =?us-ascii?Q?ZDwTGDSkdjSH4KfggKYSfAnBmuBVT5Wm7AZF583vPkvUd/kqSzSAx946tGQg?=
 =?us-ascii?Q?p40UeaVnGdS97uHiR6bBmZ1qqs1iuGwLkfKO8JqhXdg0/cxm7io2fLxOAaQV?=
 =?us-ascii?Q?d+H2FdLz+8RvB504dCeojEabVpI/NmfypMSvOJRfdH5/6QJFs29zmivppeWP?=
 =?us-ascii?Q?TnUctDgL2LzY872QTmR71Wp3Uyw9LiWoSr62lPD95DxJaLve0SYjxzmSCR7U?=
 =?us-ascii?Q?tvtfve7o6QSe36QlG6xNEHx6RBLKEsVFSUK+N+SGIGTp4JgLAWsCeapKDlDW?=
 =?us-ascii?Q?7I247wEVBP4oIDmEiLEWBSEB1RY62bAA/gcOPs0Ncvu9Ei/NGLDmjFvYcN5y?=
 =?us-ascii?Q?HWUqNyTUyb2eWu9u0jg0O+Wbb13BLkkrhnxKiTCiRh5KouDKGQUtPo3f0oiB?=
 =?us-ascii?Q?hXF1JNe538INysc4zuWqga/460Ki3SN1OBxVRpZc4ZrXXcHybbmAcy0osEaq?=
 =?us-ascii?Q?Y+BQ3bBMuhLKEyjwrFGKEfKDYKEHzkg+JptT4IEk3IwR/eESMaQKP8Gs87c+?=
 =?us-ascii?Q?XBa0c5HGyJ27gwnhQpE+9doq1TSA/znZZLq+Km+QAt1BOKDwVZQqXrJvWspu?=
 =?us-ascii?Q?wOq1IQwSEnE0Zg5zcQpljlMDZQcZtaCx1S3VjDgN6Wcfz+q8ej5M0r0HBztK?=
 =?us-ascii?Q?Kp+7I39jMBbzjO+qzxuQbrxXCG+pl/PGUU+sFVM2WFFR1/lW3tK5/2UZR92s?=
 =?us-ascii?Q?7QlRMXWAZoCzSPpJjzQ09lIlzvpTQyT0k905mbmWz53glqKzIyaCXqokjA/r?=
 =?us-ascii?Q?nn67lxFCIHFYIkFXIjTqI5FVxiiPtaXmOD4sUgmt1+JpHmWdEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:43:07.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff702bd-ed17-443d-34b4-08dc943a6f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150

Add support for Xilinx QDMA Soft IP core as Root Port.

The versal prime devices support QDMA soft IP module in
programmable logic.

The integrated QDMA Soft IP block has integrated bridge function that
can act as PCIe Root Port.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 56 +++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 5be5dfd..11ba656 100644
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
+ * struct xilinx_pl_dma_variant - CPM variant information
+ * @version: DMA version
+ */
+struct xilinx_pl_dma_variant {
+	enum xilinx_pl_dma_version version;
+};
+
 struct xilinx_msi {
 	struct irq_domain	*msi_domain;
 	unsigned long		*bitmap;
@@ -101,6 +116,7 @@ struct xilinx_msi {
 struct pl_dma_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
+	void __iomem			*cfg_base;
 	int				irq;
 	struct pci_config_window	*cfg;
 	phys_addr_t			phys_reg_base;
@@ -110,16 +126,23 @@ struct pl_dma_pcie {
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
@@ -173,7 +196,10 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
 	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+	if (port->variant->version == XDMA)
+		return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+	else
+		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 }
 
 /* PCIe operations */
@@ -731,6 +757,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
 
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
@@ -760,6 +795,8 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENODEV;
 
+	port->variant = of_device_get_match_data(dev);
+
 	err = xilinx_pl_dma_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -791,9 +828,22 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
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


