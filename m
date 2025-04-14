Return-Path: <linux-pci+bounces-25781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E0A87638
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859AC188F8C4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E293199E84;
	Mon, 14 Apr 2025 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="of/vPcHi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5B1991B2;
	Mon, 14 Apr 2025 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601020; cv=fail; b=RYZeM+/88RQN7xu0mxWmVBXQDrzJJ1VnRLJkeuQRWhFvNXuzsJDwwoBAFkxMqnPQS1y0ketvFepQgNZWqkWVpzEtqXz31++fWYzbTC+03uQpO7hZaUpzj1MiyqMbLtSSrJQCvlt9mSuAm5bEbcE1cGSdBrojz8pqjB9BB88xpe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601020; c=relaxed/simple;
	bh=aoTUak1EbkNKk0XIx/+b7ZFr2ycUtGb2VgAbphHoTYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2aB2FJPQYyiG4gzxkFsGf+xrtpbiPlqEZsIwi0xD5wL4FJKRl2C1g3Mr5rUbytXfItAUeQDHuNiLNQJ3cur2gPQLB1HDRyE5uNgLPwltO7yu/mDA6CyVleUR39Qf+LNoFtGcaSjLy6IU/01UUUtMEeLNr+wWr2hgrtjcPRXr80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=of/vPcHi; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v42KU640q7ZiebBJobV/+MLbssoeXCpU9XErpDSa6kXItBWkjf8qHJSgtyfefnPlu3k6Sq4OrIutn72miv0RG8AO+/XhVryXJGRir7fIgZVdLusEvmi2TU4/gOeb3y5D6lcieeIUZpYj/ekaVCkXyaU69R6TYTMpob9pAQiBur/GrqGKrzTbWnkd+Xrtelhu5sCVyZheNyQeJqezevAc2jnDRcJs+Z1gjmMK31Qefuvb14hax6l7VC4qhQocZUafaxcl3W9NUOrcHepF1dC1YsMUe/PrrKovJGpqIhqQwooHl7fjuMx+wCMWe/9sS2Ws4vmJlEzTjb2CZSPH+zmBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5lm4OtzGWA3FO1KkReRtd9VLBWMxs0yCq3Gs9lvrhs=;
 b=ybibuqb4nFfd+R2iGpKIo7xkHhnV3sqWHieeAcXh04LJpX47mVj/GNIz0+iScm5n+UmkI/FmA+L/5ZgKUPkidc8WqJGSHs7p1Ij3WQHR5Y0t+Z0F2Ig8GT4V4Kdgd1Sfid2uHqir+9rv+WzjKYKeIV59vHo7VBDrkGWtVraUJQ2QddCpc6o9Uk6OAKGr8/i0GpyJhEVrwbyK+t15Kob5dHIvqUi3i6u1GEwILpQubrAczdnwJS+p9bBpnGp9Bs1/anZuHwA+RfyZl2KaQl3rT9Xj3tWq2wlwB2/M9kxHu6/RgMM9eD7JXgto9IeCA857t/1Z4v9di7KhwadtsNaK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5lm4OtzGWA3FO1KkReRtd9VLBWMxs0yCq3Gs9lvrhs=;
 b=of/vPcHiv88fa+2eB3vyo3Yca6tC2vmKH0ikaAQ+mmikqC2MVR4mV0dwclsoEpVLOye3ei4sjdr0t7cU0fnWjeuTWMt8fbyY6d+HMnnEnUGQkek7TAhkqpcMre331l1ko+T0/xMtqCJdnjtrwJxGGvDwCcvmjCNBVeqzX93xWJk=
Received: from BYAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:a02:a8::14)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 14 Apr
 2025 03:23:32 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::bc) by BYAPR03CA0001.outlook.office365.com
 (2603:10b6:a02:a8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 03:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:23:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:23:30 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:23:27 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Mon, 14 Apr 2025 08:53:04 +0530
Message-ID: <20250414032304.862779-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250414032304.862779-1-sai.krishna.musham@amd.com>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3db3e8-fa1d-4db2-6812-08dd7b03bbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVvtV6GezhAZBlmdeAIDSNheaNDLBuzPpvQDdqMdZ2y5dUXzezEJyfZ+2aGp?=
 =?us-ascii?Q?xW2Hc3u2sl1ktdaXtfqjEfJAxNNkiAzvD4FbNxCSA1QqMQ6t3RjVmqOLAyZi?=
 =?us-ascii?Q?pMNunXHWyk4GYcXE0zpqVtswWjyWwcfjs+RJ/ddactb11UGgeVBJ4ySBA5rK?=
 =?us-ascii?Q?ITI9XoHMVBkHJFnhSP36qrICjmjc1HL3U9zeSYFLpfRCMQqTsoOvnoNDJ8Yw?=
 =?us-ascii?Q?CncqwleiEU8sDkjhZ7kaorE8tQPab+l9+Aa9cmCj/FcyjYNCotG0JpLOcVy0?=
 =?us-ascii?Q?OG/TJmZcVTMbPL/hqKrAfyjEoWlE9rHZdLqi1gZH0DOYIOdRA00JHQRNdK4Y?=
 =?us-ascii?Q?rs8URDoYF7oFDBPT1/psWEWS0lWZU5qIM390+47bmWOYvDyv+5WukMOabTnG?=
 =?us-ascii?Q?DeHeJ1EOG7rI854wmVCIDjxuC9REhGgDcF0ocsVjatui/l8b92uMiX9AIJ+c?=
 =?us-ascii?Q?q7pZy45tOJDUPnclfCjSNLKaRh3Q1OT3BzlDO+iLbTNDtSsv92XS73mvxacx?=
 =?us-ascii?Q?T2hagJnOeyhyH8BQFx3+2XxaoQkcXUglkYe6oOJ0Hkz+P1P1FeHesewwcimy?=
 =?us-ascii?Q?ZaxJyeXUra/0jjAgNU72dglYb7MBN+SBfE7Oniy2eYnktQIWaMApJY3fsf21?=
 =?us-ascii?Q?ZiMgJOTpnNUrs9HEFoHS8ZdSJcxafgX3nO/1KppL2mmxMEH2/In9ygEVuxKm?=
 =?us-ascii?Q?xHjaKK0mHdwYKtkQKmq8rtaE5y5aDlwpNKEezOiBiS7WkvtLYCM5GHqTDJ1Z?=
 =?us-ascii?Q?7E+Db/02o295ZUh3MCCxSxorVw5aFnV9mBUat++74Jgci4tv+5KutZVm4L90?=
 =?us-ascii?Q?LjKgcGcnPmOCc8K1w+FUsvUYM06rXtD3eYo5n1egyLc/S/DPTyO75XjIzWB0?=
 =?us-ascii?Q?/8uqD/hZYV9Rohbj5fKEhDrwPRdO3J9PZbfO4zWnEi4J9doJfgb4iLxrJoIV?=
 =?us-ascii?Q?TJx13sDtMyZ3V7Aat5029pFw04Oa80vq62sPftBEgtzGy0O2aS4i2OzlWvG3?=
 =?us-ascii?Q?/X6zPEuT1+Hjf19CsnJNrIqf21QAGtR8vcZH/T5dgB1WaStl/muFSaJEiHdf?=
 =?us-ascii?Q?n4kK8qAthbjDxFrayKh4QRj6bUzeBDPrUoxS/sB196BRpTyi0KC7LiHLgMxS?=
 =?us-ascii?Q?lPdcduDUDz1L/WRPhi0pwNZxCeWX6ZMAqivStiYUj4eou1h1Vc03/AIX2c/n?=
 =?us-ascii?Q?jFmi7BOtIe6u+xtzxH4qCBRvL8amF8cTdmAkLw86s0Nr1b0NILkEhTpQgk4k?=
 =?us-ascii?Q?Qn8wHR2M/8lD+CbLDqCg338ivxBleIuhcCApBYqjY+RTIk0tnr23xjHdjPzN?=
 =?us-ascii?Q?R1vVb8EcQHnhme7PcEORPTnNAtoXFx4Xtq0VZdTIEaZQE3M5iloMcm/pDkTC?=
 =?us-ascii?Q?8WISTixvg+q8hk6J5AdiMGAA7auT1gD0/1c4DrEuicSiEKRmoSZ+45Y3CqUW?=
 =?us-ascii?Q?FMdNkVxMZ4+E2jyyLy2WZ6UgIrp9jx/dI4PxoOoL+aWMr/vrxvW+Fc2BAmLO?=
 =?us-ascii?Q?qAukJUplpbEu4nza7A0xRUV4DIDRvoEe5pBb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:23:32.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3db3e8-fa1d-4db2-6812-08dd7b03bbc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152

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


