Return-Path: <linux-pci+bounces-24720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF14A70F11
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 03:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A8D189EA9C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565CD14B965;
	Wed, 26 Mar 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2rIkMgXY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070413DDAA;
	Wed, 26 Mar 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956162; cv=fail; b=kmq88Vlipf3WwvX+RPreoB9zeMjT5MZ5VsUmlmR6SJfWQIXnfqiTTNfgbkuYti1KO7CFnsbX8uhFX7esRcpKbrjeS89OYV6k/R9G3W2zjzpET8kj9liK6DGwfNWtMX5Ix6/Hu0YUAAQLVYtAMho3NhPCb1QFeXC62jlpaZ3/rT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956162; c=relaxed/simple;
	bh=FQboUH8ChAFDFDD04CIFXAaF8c1X5kYO4lz+61Kd8eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFZSSwBVGakUylNjloKsZY83++PqcDsD4hsRHgmCH8eDLCrYhURMk/q/rdUXC/ctDXogpA5d2rJTN2eEkKlwWrLA144mXc1b92xlhR9BzIT7MeeMtoR1NqBYih/D9CeUO9PUmftOAwJR5/O2KIyGWt/gYh79s5WwVsPSG5SmmCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2rIkMgXY; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJdtx7jKb0C9jHIZjW5egrogPSBskxgiEoYdSL7BVBpP4N8W1TK3muLs8TFry2lV+Vz4tE3W9AnWxhg+DKFH/W6oCECiyqC4hMLN55R/X4ts4cF1B/I57L92E56y1idEtxMZ5CLodPgGG+9y61ALmzn87ZSpNJuxPo1hEJiAaZuXKafjZxYrRHW5lmwID5+cTr7/2p7tJwwtboEAXfkXYrVK/rdQ7O8POobk2YPPXts6T2LkhPxk5w7YYaDGqfa65YMu5QEm6cPLSjHVpA5RjJw2bAMiKpoLxWoEx3vTC+W5Iwk8D8j2bHQDiZ69BuopP4H2eP7+bCcNmP5RkXrhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z4F4zCnJP3j4iPZ9Un/Z8oCxf+vFAszHh/XFmtslK8=;
 b=uOTtcfAF9Tu4wirmeWzI/k902vBulKvgPb3MY4g+v9t5FV4UM/JH/7lVolMZIYIEQNVk7fR5JlUaN7UGAajSBxbPQovVMnDcwU/9WHYYQ1lUGCWgqzWeQU5rPonO66QarDk8pXR4IohT9S6pFk2MhKHfz9HbDOAugrb0Ini+w8nEaE/WTGEslrVqVWt8esXgxXSESIYNwLApvcQewfKtiNoksEgBNh8OSxkgGj3CHde6tM7hl4fiF9bOm37cwibEBPAkrNAnre7ekK9b33RF4WGDv8IgpdiWdLIsY+jS8g3iCImbhhJ027txRPrqBvEHQLBviUyq2DvF1EnbTNEy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z4F4zCnJP3j4iPZ9Un/Z8oCxf+vFAszHh/XFmtslK8=;
 b=2rIkMgXYIF1p38YTWo3V5GZw7trfPpgNVV/qDw5PFrX2EkuUwrHjsQ4WhNHx1t5aYjHVjSbWnilDU1EjKFNNQYOJR5hpwzbxEHGRCAe/oLOaQ3q56v4GJhNzx8TktAvdFbFs0ANJxmWwjnaO/XGHLRdTXFSkzQg6cq44Gdr3xBE=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.43; Wed, 26 Mar 2025 02:29:13 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::8e) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 02:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 02:29:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 21:29:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 21:29:11 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 21:29:07 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Wed, 26 Mar 2025 07:58:11 +0530
Message-ID: <20250326022811.3090688-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f606d21-97e1-4bbf-313b-08dd6c0dff15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sCZNY74i7ztNAp/lNGyI1rqyiItbMEH6UcajPBBD7w20a9Flpy8N0Xgy8P0?=
 =?us-ascii?Q?UghVryyryzX5+y84CIUzlOjTLyKaow91StHm+y+kmsS/oJjzURBD6BQPUnoz?=
 =?us-ascii?Q?HEfnAESoAko4lyDkEWOybHP9EU0bSV165Cywb4J9/otCcUrLdbNF5C0A1Lz0?=
 =?us-ascii?Q?CFAS/ql3qciJx14Sqg9SJHq3rOwIE/XChX0yGBJ186qY7yZ9QqxvcRRjvxFG?=
 =?us-ascii?Q?SPA538ZN7M1HTGI1HR8637QlkrP4bdVr5ixELKZwMdj8+YxmjDXjveYQUCFR?=
 =?us-ascii?Q?4AnvKs3J+OPAwz07Pm7zy9yxxeZC7UP+59+BOa14OL4w0LOSG07fX2kDM+oJ?=
 =?us-ascii?Q?I7JSwlYdhiDIZaQGaNC9EmScI8x8NQyClnegII3MphwId1dKZH1rArEMBMS6?=
 =?us-ascii?Q?srggmUZQigr3MCInOYEPWJrCcO8jC9IGHzjKQ9PrEFnU9tXC6QyZW/Uas+t0?=
 =?us-ascii?Q?iA5to8g9RD5oDJnKFJUDStHFnXch4bZOei0m5nBIpTX5tdZ82mToLkZWy4gk?=
 =?us-ascii?Q?WR7L5PDpd2SA2X4fv6O++ZfJ9M9OCmzYvqgGbHqsuD1PR6bBfjhwTTggS3dd?=
 =?us-ascii?Q?iiHnf0lRHrHyMhEiBC2r3zE8jP4HIZu+LBZeePzpXs6E9qhg0Lah4MHMWCX3?=
 =?us-ascii?Q?46stY89n1JZot3hOGEnT+ystSgqxVQ0KTxhMHpp8IlwX417j1rpAkBvMgTYo?=
 =?us-ascii?Q?ha5gd+rUOuCyVsWZtlcIEaO5nuM9noxf52oZkkvL1TO+LuduBiIyZ7w1Pq4Z?=
 =?us-ascii?Q?iW5WVAoiwd0dYsik86U7Fpl/OCAPpJ0ZpjUQSZ//99vtsunXcUOFus50H0FS?=
 =?us-ascii?Q?8nd39vMrYnRHP99WzfyQtmFp4VWxOQVPD17uF1AHcVahOkwTcvO/FuriZi6B?=
 =?us-ascii?Q?1DYjJk74q4hz46gFcPTmOp7fIfgkqutzlL4T5KJd2/THhDPHswlGG4uuh2kZ?=
 =?us-ascii?Q?m2o5uOY0uYGCw8wVjoZDkEFdINPfSPIfpYoNUZ7eN8fTAE4pCSapNm5ZtGt1?=
 =?us-ascii?Q?/cLiPQRAX5j6vbh9+N5S2UHxGLmOUIwIY5mQnaZNu/RDRDMcC4etZKDnsCta?=
 =?us-ascii?Q?ZVLhob/A2+9NqtXIXWLG63NwS+5ZjTmikt0qbG8Vzqg+YBv5JHGlDtfQYe65?=
 =?us-ascii?Q?sg2cBzlcVa1rdW4uyjXrWRVzU5WUBIuskRdvgmKuR45/qmyr5rl5glbWX+YF?=
 =?us-ascii?Q?JeAXPnYmmSfdhEBoAXTHiMBlNsnuBRZb6IGCWdab9jVpjvrf0KJVzX13RSMd?=
 =?us-ascii?Q?kEI52iQwQvO0fKKppjVw2OkjufzQMqHu0lcNPYPWbt7EGJxow5lLh3dfN8f9?=
 =?us-ascii?Q?er5+c/6EOaiXo+Jfof6LExCE55TTyFj89zqyLDeAYYA66onZRj61JXSh27Sl?=
 =?us-ascii?Q?m8pgMcsfJi3ZIHLW/pxOn0c1dU2cwOXOR82BLwUaCrpieXKkZfR5WHevzz8S?=
 =?us-ascii?Q?SQaG0zmGIb5Ko6SzZjgmMVWtSP5MYVlFZleUhiH4s3NpIi/6gij+0xo1cSgZ?=
 =?us-ascii?Q?HG8YVTYWWHUhGCM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 02:29:12.5025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f606d21-97e1-4bbf-313b-08dd6c0dff15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Add PCIe IP reset along with GPIO-based control for the PCIe Root
Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
signal's assertion and deassertion avoids Link Training failures.

Adapt to use GPIO framework and make reset optional to maintain
backward compatibility with existing DTBs.

Add clear firewall after Link reset for CPM5NC.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v6:
- Correct version check condition of CPM5NC_HOST.

Changes for v5:
- Handle probe defer for reset_gpio.
- Resolve ABI break.

Changes for v4:
- Add PCIe PERST# support for CPM5NC.
- Add PCIe IP reset along with PERST# to avoid Link Training Errors.
- Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
  PERST# deassert.
- Move PCIe PERST# assert and deassert logic to
  xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
  Interrupts enable and PCIe RP bridge enable should be done after
  Link up.
- Update commit message.

Changes for v3:
- Use PCIE_T_PVPERL_MS define.

Changes for v2:
- Make the request GPIO optional.
- Correct the reset sequence as per PERST#
- Update commit message
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 86 ++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d0ab187d917f..b10c0752a94f 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -21,6 +23,13 @@
 #include "pcie-xilinx-common.h"
 
 /* Register definitions */
+#define XILINX_CPM_PCIE0_RST		0x00000308
+#define XILINX_CPM5_PCIE0_RST		0x00000318
+#define XILINX_CPM5_PCIE1_RST		0x0000031C
+#define XILINX_CPM5NC_PCIE0_RST		0x00000324
+
+#define XILINX_CPM5NC_PCIE0_FRWALL	0x00001140
+
 #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
 #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
 #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
@@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
 	u32 ir_status;
 	u32 ir_enable;
 	u32 ir_misc_value;
+	u32 cpm_pcie_rst;
 };
 
 /**
@@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
  * @dev: Device pointer
  * @reg_base: Bridge Register Base
  * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
+ * @crx_base: CPM Clock and Reset Control Registers Base
+ * @cpm5nc_attr_base: CPM5NC Control and Status Registers Base
  * @intx_domain: Legacy IRQ domain pointer
  * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
@@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
 	void __iomem			*cpm_base;
+	void __iomem			*crx_base;
+	void __iomem			*cpm5nc_attr_base;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*cpm_domain;
 	struct pci_config_window	*cfg;
@@ -475,12 +489,45 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
  */
-static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
+static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
+	struct device *dev = port->dev;
+	struct gpio_desc *reset_gpio;
+
+	/* Request the GPIO for PCIe reset signal */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		if (PTR_ERR(reset_gpio) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
 
-	if (variant->version == CPM5NC_HOST)
-		return;
+	if (reset_gpio && port->crx_base) {
+		/* Assert the PCIe IP reset */
+		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
+
+		/* Controller specific delay */
+		udelay(50);
+
+		/* Deassert the PCIe IP reset */
+		writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
+
+		/* Deassert the reset signal */
+		gpiod_set_value(reset_gpio, 0);
+		mdelay(PCIE_T_RRS_READY_MS);
+
+		if (variant->version == CPM5NC_HOST && port->cpm5nc_attr_base) {
+			/* Clear Firewall */
+			writel_relaxed(0x00, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			writel_relaxed(0x01, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			writel_relaxed(0x00, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			return 0;
+		}
+	}
 
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
@@ -512,6 +559,8 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
 		   XILINX_CPM_PCIE_REG_RPSC);
+
+	return 0;
 }
 
 /**
@@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 		port->reg_base = port->cfg->win;
 	}
 
+	port->crx_base = devm_platform_ioremap_resource_byname(pdev,
+							       "cpm_crx");
+	if (IS_ERR(port->crx_base)) {
+		if (PTR_ERR(port->crx_base) == -EINVAL)
+			port->crx_base = NULL;
+		else
+			return PTR_ERR(port->crx_base);
+	}
+
+	if (port->variant->version == CPM5NC_HOST) {
+		port->cpm5nc_attr_base =
+			devm_platform_ioremap_resource_byname(pdev,
+							      "cpm5nc_attr");
+		if (IS_ERR(port->cpm5nc_attr_base)) {
+			if (PTR_ERR(port->cpm5nc_attr_base) == -EINVAL)
+				port->cpm5nc_attr_base = NULL;
+			else
+				return PTR_ERR(port->cpm5nc_attr_base);
+		}
+	}
+
 	return 0;
 }
 
@@ -602,7 +672,11 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		goto err_free_irq_domains;
 	}
 
-	xilinx_cpm_pcie_init_port(port);
+	err = xilinx_cpm_pcie_init_port(port);
+	if (err) {
+		dev_err(dev, "Init port failed\n");
+		goto err_setup_irq;
+	}
 
 	if (port->variant->version != CPM5NC_HOST) {
 		err = xilinx_cpm_setup_irq(port);
@@ -635,6 +709,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 static const struct xilinx_cpm_variant cpm_host = {
 	.version = CPM,
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
+	.cpm_pcie_rst = XILINX_CPM_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host = {
@@ -642,6 +717,7 @@ static const struct xilinx_cpm_variant cpm5_host = {
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host1 = {
@@ -649,10 +725,12 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_misc_value = XILINX_CPM_PCIE1_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE1_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE1_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5n_host = {
 	.version = CPM5NC_HOST,
+	.cpm_pcie_rst = XILINX_CPM5NC_PCIE0_RST,
 };
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
-- 
2.44.1


