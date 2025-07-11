Return-Path: <linux-pci+bounces-31906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAAB012A9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 07:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A2E1C40453
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54F1C84D5;
	Fri, 11 Jul 2025 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiM6cagY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA01ACEDE;
	Fri, 11 Jul 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211464; cv=fail; b=s/cufqeqqY0qnVrlaZBwBG9wn7eU2jQIAqL7c1sjTQkXSupdJ2usAsqrGY3hCjD8xlZ/0Mgrg/h9FgjWuTkTQjANpcH2+xDsP7henoSwEJj/Of2TSCtjUj+EDK4GKhg02IlAXBUzrzYt9g8pvS3R8/HIxeFROGulqqMuENBiz0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211464; c=relaxed/simple;
	bh=gp7C2VbssemmLLlNzQWOhgFjjbux3Kg8+FeMeo7VJmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQCqQD1TVtx6/m1CFs5Yi18hEkuG49IWc1gtHI1ofNvDjZeGr23mKuFHaUxI7JV05EaDfWCDCFDZxxtfjfCMlhsEQuIBSeHcF3b3Y0qxHV5lGFuY26vl17MZFCWu29apRXzf9QR20bE9IBamjB2UxAFI6mDpfr4LgAYnqPFcygE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XiM6cagY; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIpUyjZkzColSR2m8k1Zf/O9J6qZ+DUwfNj0w+Cfu2JbmsGZ0s/Vuon7l2gN3nQgixpf3JTTffpzompKYv74DKgX9O00KEvSEFqE20/1y5NngAKBtGQ3QYv8NPWuedtlxpe1WYDvb/XqziMFRoHEWMV/bckkOeaY82pyQlaRk5IAvd+QlGfHX8JHnBs5pRpAixni+VyzNGuo2UyGUEL8//vQk5i7Y0+3yPYylRZfp/OUBdikXt4oQmryjg64K+ZmVOMvm70+6d8gTmG0Yi2ey92F5Zcn1Y/uPx47zMW9j9R9NaTbs8vuF3H9NB7h4uqdj3/jltHBHNMt5LXRdl28Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk/OkMt8wTbuNdftdWHsMgXyoBY7aOt1aNe3pxRuGHA=;
 b=W6ciIjHfQNw0tm4l2JfrYpKfrmGtX+/04U7xpTq2FLesc7AjYCEm1Q66yrwor/eZUepj3F/uM0+dE1Wmm0V5RfdP6Lc6jji+5UgCL2ni85J1kCFYXGJj30qp6R83nsIkN8Bv/zGw07s5RJljJvIE5vdjD8+IksSJfQ8TBjWj2KzXFv0zH7VGdnGG1ShA1laxgMei+iQEvlFYvigKBvwtJzVgs8gI9JdzP6+ZyE0fcQvAaJ6BYCFM7VeuVgiEbXegxmlVoDwzTTp8/9mqzAy9Kf0NVzN2E/uKq0W9OOuyFq/ilBUjYsVxTT+Vju8O8TA024861C5ajfmT0F62ElYSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk/OkMt8wTbuNdftdWHsMgXyoBY7aOt1aNe3pxRuGHA=;
 b=XiM6cagYXoyeDjwJv8u7XY3wLp9dwBPiszmPJcnWFWBQnE1r65N2mup96lZlIcDq/cFDWsgWTPHRJf0HOR2n8Bdd6TLxoQSqwnBs8C07O2MhKqdQkbrMo8mphPmjvrBh1thLqvFQcY+HalbK4u4zSzkiNjeRIc4wUNmO54e47Kc=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 05:24:17 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::3) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 05:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 05:24:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 00:24:15 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Jul 2025 00:24:12 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Fri, 11 Jul 2025 10:53:57 +0530
Message-ID: <20250711052357.3859719-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250711052357.3859719-1-sai.krishna.musham@amd.com>
References: <20250711052357.3859719-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b31dc3a-172e-4cdf-09ea-08ddc03b2e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ujy2hp4pd4wGtudvPmTphugjyXNzHaveJabawLbt023eBBMYuKx1nNACqvfP?=
 =?us-ascii?Q?4e/1ZB6JXpep9y8z6V46tCa+gMvUoKsVrZPjwpLgLOXS1i8tj30S3vb570ur?=
 =?us-ascii?Q?T3sPIc4DUfrv+Uo9MsFje9mz5LqF6Sj6kl2akWp5Scn1Y2nDHZWL6zuVqRyA?=
 =?us-ascii?Q?fvPd5ZokJkzGhrhtlHIJgSLYS4Tre+o5ZXGaXJjtNIfPNZRufIhhIXZEL+PQ?=
 =?us-ascii?Q?j+OTw/tofTakl4CrcRFn50kLlyx0o7HPt/2zWG8+5evuBEhF4gXQIOEQVukx?=
 =?us-ascii?Q?oK21whSMpUahA5kwjQJVL+bi59sKoB8SJ3R/ngKm4l2GZyhCog+5UCx9jnvi?=
 =?us-ascii?Q?2fpxd0my1EyhkhtWA5WXh+hQzrDjhsn2Ww5J9hl9C0jWaKANTxQuCr2bWLZQ?=
 =?us-ascii?Q?JwsOIpnUwecmIP97eSRV1r1KmT1Sl1kVL990s/p8BUU0ci2ReRXTTVedkust?=
 =?us-ascii?Q?ePgL3R7JEXq80qi0+crlnD3ClvWgAfts58WGQtaUk7TsshCN8SNk44twy9Cu?=
 =?us-ascii?Q?PQ/AtCXMXzPfaN9NnIoaGuq5aVInkpW7+/tajgYQ1Kl3LXljhBllXkoPu7M0?=
 =?us-ascii?Q?AfJ+Y/ey41mrhME3fOQnH76KtSHlhLxfNesYuaPQR2TOfOm5Cx0GPO8hfEY5?=
 =?us-ascii?Q?LEvOv6P3BfW/gM6XxLg48yI3L9bNhnzaZ/z8rRbdV4eR8HYEO+lXKbyE72+u?=
 =?us-ascii?Q?N4qWSPdsamPOheXiEmGzt7EtgWDJ+6FuNNbbx1NNv/TZ3dw1ketYmiyxHH4p?=
 =?us-ascii?Q?1MnMwB5dthjOMiKKd5ye4UemvbISVtubhrzRviKn3lwdRvDv2X8hWiWdQIrq?=
 =?us-ascii?Q?jSeyip8NLwCvDr3tBkZAilY1fbvpFtb6K5Z0nG3Ro1O61dLEB0SIuD0eKwbH?=
 =?us-ascii?Q?kI2RSJ5Jfoh80QUU+TtA9eu7SlgRDCO1l7+fDWl0uK6TJ6uKDhMM+9EmLmy1?=
 =?us-ascii?Q?eRDPdyO5vbHCVJvMDuM4jFV5gUT75p0Oo8/6aAVcPqDkZi3OWa0AetTr7Aiq?=
 =?us-ascii?Q?xpvnfGT3z+WGJO2KKc//dtq+6bHhx1n5244gwOqH8umDnWpW4k2moO0KonJx?=
 =?us-ascii?Q?fjRKHXuWIPLzetshAJMdNOIxFWwU5tSjg1zFfo4/feFBAEHXIY9fzmEsNrhg?=
 =?us-ascii?Q?ACBMDQfLZN4bVjJ6lVAG6jUyMFanD2BljTU5YsjsFOf0zoWE60FLA5EVSocU?=
 =?us-ascii?Q?wqeWnOlhoc+sc8M0aZ4g5Q6DEbAs4JrhASldbZPv+jAEeW/lMZJR3X+oIfo+?=
 =?us-ascii?Q?BsRdcd+KapK+QetcaEVr104oK91Jkw4ZBVnWbEY1o6Tbnx+PgRaHbyx7CLWw?=
 =?us-ascii?Q?alCbTupmPoqX5bqxRx2Y5Gsp27R7tM0uY93JU7LBHAIqzDrMhTCJ5zS6ShOb?=
 =?us-ascii?Q?zwXuPKCrtbWtuog/f2NPsuxfrx39wEHifcZKLlvTIC5idAjt18je/m2+Pg39?=
 =?us-ascii?Q?OZcT7eL4LLdTeUHhFVlXyWbXtEjo5Tw69yGgtohSLvFXRwMxLRGpi8ySB5t6?=
 =?us-ascii?Q?xmUlctRqAkyeNt+J+REZ1VBb7CKQZkEdnPATMbL7QUmml+oICPAHTbar/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 05:24:17.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b31dc3a-172e-4cdf-09ea-08ddc03b2e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
signal via a GPIO by parsing the new PCIe bridge node to acquire the
reset GPIO. If the bridge node is not found, fall back to acquiring it
from the PCIe node.

As part of this, update the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child(), since the PCIe
node now has multiple children. This ensures the correct node is
selected during initialization.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v5:
- Add fall back mechanism to acquire reset GPIO from PCIe node when PCIe Bridge
node is not present.

Changes in v4:
- Resolve kernel test robot warning.
https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/
- Update commit message.

Changes in v3:
- Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.

Changes in v2:
- Change delay to PCIE_T_PVPERL_MS

v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 63 ++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 9f7251a16d32..d633463dc9fe 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -18,6 +18,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
@@ -56,6 +57,7 @@
  * @slcr: MDB System Level Control and Status Register (SLCR) base
  * @intx_domain: INTx IRQ domain pointer
  * @mdb_domain: MDB IRQ domain pointer
+ * @perst_gpio: GPIO descriptor for PERST# signal handling
  * @intx_irq: INTx IRQ interrupt number
  */
 struct amd_mdb_pcie {
@@ -63,6 +65,7 @@ struct amd_mdb_pcie {
 	void __iomem			*slcr;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*mdb_domain;
+	struct gpio_desc		*perst_gpio;
 	int				intx_irq;
 };
 
@@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 	struct device_node *pcie_intc_node;
 	int err;
 
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -ENODEV;
@@ -402,6 +405,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	return 0;
 }
 
+static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
+{
+	struct device *dev = pcie->pci.dev;
+	struct device_node *pcie_port_node;
+
+	pcie_port_node = of_get_next_child_with_prefix(dev->of_node, NULL, "pcie");
+	if (!pcie_port_node) {
+		dev_err(dev, "No PCIe Bridge node found\n");
+		return -ENODEV;
+	}
+
+	/* Request the GPIO for PCIe reset signal and assert */
+	pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
+						 "reset", GPIOD_OUT_HIGH, NULL);
+	if (IS_ERR(pcie->perst_gpio)) {
+		if (PTR_ERR(pcie->perst_gpio) != -ENOENT) {
+			of_node_put(pcie_port_node);
+			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
+					     "Failed to request reset GPIO\n");
+		}
+		pcie->perst_gpio = NULL;
+	}
+
+	of_node_put(pcie_port_node);
+
+	return 0;
+}
+
 static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 				 struct platform_device *pdev)
 {
@@ -426,6 +457,14 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 
 	pp->ops = &amd_mdb_pcie_host_ops;
 
+	if (pcie->perst_gpio) {
+		mdelay(PCIE_T_PVPERL_MS);
+
+		/* Deassert the reset signal */
+		gpiod_set_value_cansleep(pcie->perst_gpio, 0);
+		mdelay(PCIE_T_RRS_READY_MS);
+	}
+
 	err = dw_pcie_host_init(pp);
 	if (err) {
 		dev_err(dev, "Failed to initialize host, err=%d\n", err);
@@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct amd_mdb_pcie *pcie;
 	struct dw_pcie *pci;
+	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -454,6 +494,27 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	ret = amd_mdb_parse_pcie_port(pcie);
+
+	/*
+	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
+	 * PCIe Bridge node was not found in the device tree. This is not
+	 * considered a fatal error and will trigger a fallback where the
+	 * reset GPIO is acquired directly from the PCIe node.
+	 */
+	if (ret && ret != -ENODEV) {
+		return ret;
+	} else if (ret == -ENODEV) {
+		dev_info(dev, "Falling back to acquire reset GPIO from PCIe node\n");
+
+		/* Request the GPIO for PCIe reset signal and assert */
+		pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
+							   GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->perst_gpio))
+			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
+					     "Failed to request reset GPIO\n");
+	}
+
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
-- 
2.44.1


