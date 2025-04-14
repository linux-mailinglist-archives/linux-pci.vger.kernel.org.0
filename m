Return-Path: <linux-pci+bounces-25774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB91A8761B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09333B11C5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0A198E60;
	Mon, 14 Apr 2025 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9gnIQtF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C93E571;
	Mon, 14 Apr 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600155; cv=fail; b=hino+px5l5pDv8CSgnFaA7lOfEWc6zsOgJndhM1od6eJup21fXVp9WFp2CDNXfbHDElqiaE3c+H77RqF8JanduqghFRs403LF95cHgzmS2Bbv5WiiJXNhO38aCBtPfURlDU5EeW5XKNB2DKh/D8qLMIOH+/9M6u+fGASRQ5Z04M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600155; c=relaxed/simple;
	bh=aoTUak1EbkNKk0XIx/+b7ZFr2ycUtGb2VgAbphHoTYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCsinEoB4j4h298bbor9HBwBMbNl5Wo6LkJYCM9Vga+OHLjsOLC9URxXS/JNoUj4CS9B3r0SfxLjQe1hS5Bvz+FtyTW6VFV6BE7yMYiMzIQzj0FpCdrfrkl7ptiPDWM9dZbxHeqUAs7FOl9CEs/Eoiv80yOBV/AfqrKxCHOZ+Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9gnIQtF; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVXfjho2hOPuSgO2rLQhCiZ9yMTFnATGtfANqII0aCZ7My5My90SK0R6Dlt5Qm5LYXo5Vo2Ze/slPWAKnL774JId7HM48TbUNdyABPe0DOH84SoBAcg9wbCEmGCX3WXr5OXOy4v5JYZH4u3hD28f8VWYWgs8el2HscPcXAk3DPQhZEcr1tQyCCGQKrp2XB2A0g82c5nRjle+qCr9WIlfT3fPGgK7eOGkDNHIbuQQmtab377RyklDK6Tn0+kGa7mG2pL0KHlzi3nD2SbJhKWSpnxcsz+0pf62e950DNiJbMKl24KB5lfNwY8k+BL/gECSpijbkPF/jL2ffeKfWF9JBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5lm4OtzGWA3FO1KkReRtd9VLBWMxs0yCq3Gs9lvrhs=;
 b=RsABXBVpRaug9QFfKR3KKlYAxsoRif9By0Hiz/uvxXVJc8zzZmRtJCAJihuGYbely1nsyo1FUkcfdwve9emFtMRLWxeCkMXJQrco3FW1/R/O2AhGExfQN1RD8dOPnd0oQFasoFRL81tDY6DPIbBxNaINBk13w69Sk8/QQIE+3eLXK478iXQMLkS8Uu/hT16q/R7OqEzWZN+3pOEhbpBegcPLa62oZWtnxU3jsFu+dC160f7LvidydU4M/j+tpK3MR0qnZhHQO3LtX4Ci9c/Hc57jkV1oMTWNzkNidpBZoBFx8HAU1IZRWC8CNbqZraPbewFaQLmNpWbWP4fuAXp0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5lm4OtzGWA3FO1KkReRtd9VLBWMxs0yCq3Gs9lvrhs=;
 b=g9gnIQtFRpvu53HhbCx+SuoIRgw6KyKy8qK97voza65CFkcu2Z6v1PfM7WYHCly2uEU94M/Op5Ikl7StmpVthi+xrPulKp9nE00fEOcKQeGXG3pXUX+LaK2abeuVHzcESPpkri3ix2g/b9mjoz/qLMRbaILB7/Bz/m4Rr9xqw7s=
Received: from PH7P220CA0160.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::18)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 14 Apr
 2025 03:09:09 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::53) by PH7P220CA0160.outlook.office365.com
 (2603:10b6:510:33b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 03:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:09:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:09:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:09:03 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:08:59 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [LINUX PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Mon, 14 Apr 2025 08:38:42 +0530
Message-ID: <20250414030842.857176-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250414030842.857176-1-sai.krishna.musham@amd.com>
References: <20250414030842.857176-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb4dc95-4de6-411e-4297-08dd7b01b922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUIGHXtojXYwImz4nDEabbfewZ8UUocvOoKXgllpDXkGwdlFITYku3n1oYWb?=
 =?us-ascii?Q?8oGKYidTLtcNLmpQVM64EcUUbaS3Ch293TIIceFcUjx+YrqQqbGMvC2fty5z?=
 =?us-ascii?Q?Dxiec75wvmWvr8DkoPdo88ta+43hyhAewQyN7wdDDZab6gMiXsCx/znzO+6F?=
 =?us-ascii?Q?KUJ8gNRrSzlWwNkG6J96n4sFMd9lDM8rFWk+ASgb0S38dwVQ/vmmkEgeVpfJ?=
 =?us-ascii?Q?ZvwtxJUI3VzvJk8y78gnQixeYmnsF4SR2wDXMIjo6tK1e6YCVZ/+uM/W5NCk?=
 =?us-ascii?Q?/LRqNIb1MPXdpXb7m0gdqUeJZ3jY+nKyOYZnkLj3VX9PdGd3KXzjUN4jyueF?=
 =?us-ascii?Q?boreqV/CbnsQdS3pcMjrul5fWmDr05PLQE2BbYFlFX88esvEKmX8Wszr4NVs?=
 =?us-ascii?Q?QWjWjhDHXqCZTsjteGD+GySfKe9xcZQruzR3By2724yTcrl5LW7X4AbWt4Xa?=
 =?us-ascii?Q?CmxyUuQiIxNi4vhsh0yBi2T5rZyEb+OfCtLpiG6Ri+LCQCAJkFJ6XedCqt6A?=
 =?us-ascii?Q?6uWACMbRtnXbs8NjKf84ubYRHh7Qwfv0Z4gxKcv94Q7uhB9JB2AY0HmUtdUU?=
 =?us-ascii?Q?LVffxRvi6uw1wZR9nuZU9Xh5mYH6Mle4vdef163Ad0jc7eFID8fMUHx6Vids?=
 =?us-ascii?Q?d47mulbVCtzF1BBofFUzkghcWE6lbDlNzi9ysLpuxA0Z1iX14TbRcScLPTZm?=
 =?us-ascii?Q?hBipXqFGNL9eGPzUcBEW0Zw7r9BJwnp4csGg6nR3pJL5/I/eK10wOjyga5JJ?=
 =?us-ascii?Q?035PLfagJkgErUeWhPT4jz/n/Rd1y6FVgOkcYsd315LKmyi97dU3JGMfKz64?=
 =?us-ascii?Q?mA/fmE/uol/xe6oUWpeoFRTDYaYyTzMsw07xmn7Y/0zHpZE5IMV0gLBqtUVU?=
 =?us-ascii?Q?imJkUCJitZ9dF+E+5ApcKDgayE/n5of5sfLvz77ZrZX2KjgVxhTY0oHSBS6F?=
 =?us-ascii?Q?0F/J0VZ8TCFLV7n+qKgFHvMUaPnIzzdMyEdnGekP9exVoBUm+02ui0kxbvTy?=
 =?us-ascii?Q?XbRjax8Ct9a3OKp5BycpxqMwVivl6YOF/FlQgPh+4RCtZuj3jQoRb0zTCV0Y?=
 =?us-ascii?Q?+FEme+oxjwRa+pZJxk427x/9rc1JgF7v/kRX2rMFrbPb8lDMXhkfGRDYWVvZ?=
 =?us-ascii?Q?q73BRadnGevcAXQw3IpJyeU45SG28lZq4KEI4CEFRMVhWOYAKpfj7qiYxR9i?=
 =?us-ascii?Q?ehdJjoawu59uMbH2pZjYooEZPsjxz/9jcVa1XS09/NW5u/Dmfi2zvcUfPDzS?=
 =?us-ascii?Q?mswRM+ASs23ixUJSCxNCkijYDUfnIGZRp2zJ7PkrlGpRadve/1D1IdlQjKPL?=
 =?us-ascii?Q?6mF0TTJmgsCbUIueBcbVKQNV4ewGgXfLaKpOSE7meTwWkDFfUu186e6sk1AN?=
 =?us-ascii?Q?WqjkPy0Gei58Q6fbexRQkVOe6usmVAWxN1i8qRBLdXgD/S+pYhZ45iafN564?=
 =?us-ascii?Q?eAsjLiVGEiYPGmqWW+cx7VbrihQ+kn3v+4I3GQ44Mem4XWxby8MhSYbbIlxx?=
 =?us-ascii?Q?oOoC0quQ/DuaL2oIYYkpUl3o1lKSd9f/0fCk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:09:08.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4dc95-4de6-411e-4297-08dd7b01b922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

Add support for handling the PCIe Root Port (RP) PERST# signal using
the GPIO framework, along with the PCIe IP reset. This reset is
managed by the driver and occurs after the Initial Power Up sequence
(PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
function is called.

This reset mechanism is particularly useful in warm reset scenarios,
where the power rails remain stable and only PERST# signal is toggled
through the driver. Applying both the PCIe IP reset and the PERST#
improves the reliability of the reset process by ensuring that both
the Root Port controller and the Endpoint are reset synchronously
and avoid lane errors.

Adapt the implementation to use the GPIO framework for reset signal
handling and make this reset handling optional, along with the
`cpm_crx` property, to maintain backward compatibility with existing
device tree binaries (DTBs).

Additionally, clear Firewall after the link reset for CPM5NC to allow
further PCIe transactions.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v7:
- Use platform_get_resource_byname() to make cpm_crx and cpm5nc_fw_attr
  optional
- Use 100us delay T_PERST as per PCIe spec before PERST# deassert.

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
 drivers/pci/controller/pcie-xilinx-cpm.c | 97 +++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 13ca493d22bd..c46642417d52 100644
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
+#define XILINX_CPM5NC_PCIE0_FRWALL	0x00000140
+
 #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
 #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
 #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
@@ -93,12 +102,16 @@ enum xilinx_cpm_version {
  * @ir_status: Offset for the error interrupt status register
  * @ir_enable: Offset for the CPM5 local error interrupt enable register
  * @ir_misc_value: A bitmask for the miscellaneous interrupt status
+ * @cpm_pcie_rst: Offset for the PCIe IP reset
+ * @cpm5nc_fw_rst: Offset for the CPM5NC Firewall
  */
 struct xilinx_cpm_variant {
 	enum xilinx_cpm_version version;
 	u32 ir_status;
 	u32 ir_enable;
 	u32 ir_misc_value;
+	u32 cpm_pcie_rst;
+	u32 cpm5nc_fw_rst;
 };
 
 /**
@@ -106,6 +119,8 @@ struct xilinx_cpm_variant {
  * @dev: Device pointer
  * @reg_base: Bridge Register Base
  * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
+ * @crx_base: CPM Clock and Reset Control Registers Base
+ * @cpm5nc_fw_base: CPM5NC Firewall Attribute Base
  * @intx_domain: Legacy IRQ domain pointer
  * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
@@ -118,6 +133,8 @@ struct xilinx_cpm_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
 	void __iomem			*cpm_base;
+	void __iomem			*crx_base;
+	void __iomem			*cpm5nc_fw_base;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*cpm_domain;
 	struct pci_config_window	*cfg;
@@ -475,12 +492,57 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
  */
-static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
+static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
+	struct device *dev = port->dev;
+	struct gpio_desc *reset_gpio;
+	bool do_reset = false;
+
+	if (port->crx_base && (variant->version < CPM5NC_HOST ||
+			       (variant->version == CPM5NC_HOST &&
+				port->cpm5nc_fw_base))) {
+		/* Request the GPIO for PCIe reset signal and assert */
+		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(reset_gpio))
+			return dev_err_probe(dev, PTR_ERR(reset_gpio),
+					     "Failed to request reset GPIO\n");
+		if (reset_gpio)
+			do_reset = true;
+	}
+
+	if (do_reset) {
+		/* Assert the PCIe IP reset */
+		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
+
+		/*
+		 * "PERST# active time", as per Table 2-10: Power Sequencing
+		 * and Reset Signal Timings of the PCIe Electromechanical
+		 * Specification, Revision 6.0, symbol "T_PERST".
+		 */
+		udelay(100);
+
+		/* Deassert the PCIe IP reset */
+		writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
+
+		/* Deassert the reset signal */
+		gpiod_set_value(reset_gpio, 0);
+		mdelay(PCIE_T_RRS_READY_MS);
+
+		if (variant->version == CPM5NC_HOST &&
+		    port->cpm5nc_fw_base) {
+			/* Clear Firewall */
+			writel_relaxed(0x00, port->cpm5nc_fw_base +
+				       variant->cpm5nc_fw_rst);
+			writel_relaxed(0x01, port->cpm5nc_fw_base +
+				       variant->cpm5nc_fw_rst);
+			writel_relaxed(0x00, port->cpm5nc_fw_base +
+				       variant->cpm5nc_fw_rst);
+		}
+	}
 
 	if (variant->version == CPM5NC_HOST)
-		return;
+		return 0;
 
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
@@ -512,6 +574,8 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
 		   XILINX_CPM_PCIE_REG_RPSC);
+
+	return 0;
 }
 
 /**
@@ -552,6 +616,24 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 		port->reg_base = port->cfg->win;
 	}
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cpm_crx");
+	if (res) {
+		port->crx_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(port->crx_base))
+			return PTR_ERR(port->crx_base);
+	}
+
+	if (port->variant->version == CPM5NC_HOST) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "cpm5nc_fw_attr");
+		if (res) {
+			port->cpm5nc_fw_base =
+				devm_ioremap_resource(dev, res);
+			if (IS_ERR(port->cpm5nc_fw_base))
+				return PTR_ERR(port->cpm5nc_fw_base);
+		}
+	}
+
 	return 0;
 }
 
@@ -603,7 +685,11 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
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
@@ -636,6 +722,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 static const struct xilinx_cpm_variant cpm_host = {
 	.version = CPM,
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
+	.cpm_pcie_rst = XILINX_CPM_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host = {
@@ -643,6 +730,7 @@ static const struct xilinx_cpm_variant cpm5_host = {
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host1 = {
@@ -650,10 +738,13 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_misc_value = XILINX_CPM_PCIE1_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE1_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE1_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5n_host = {
 	.version = CPM5NC_HOST,
+	.cpm_pcie_rst = XILINX_CPM5NC_PCIE0_RST,
+	.cpm5nc_fw_rst = XILINX_CPM5NC_PCIE0_FRWALL,
 };
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
-- 
2.44.1


