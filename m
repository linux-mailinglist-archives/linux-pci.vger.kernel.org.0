Return-Path: <linux-pci+bounces-32584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0006B0ADAF
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 05:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244935A1A10
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7921B9E7;
	Sat, 19 Jul 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="406F27Jw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B3219A9E;
	Sat, 19 Jul 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894614; cv=fail; b=rBRsvegA64SKeFGg9pgr7UoLmtAFF+VuARFsy+X8rilZh7+VJxXAxqRk8RzzAww6pa6xyt0zBAqBjGRFYVvCXWXiHY/+WXQhFrIrZqQ/BSEGg5C/7588dQU9wwYdUajy5rgfn1Kh8J6CufJwe+zMit6HC0xY9CuOryQYVlPA5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894614; c=relaxed/simple;
	bh=RfbiWl5+4TTndmn9F6uaUauP++zkBM3sMocUJnI8dow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P97WIqjVCvc9r8cFntceXi3shwRIBN1PRUPjOku21eQn4lBwNda+/ieIEytLVcQg9l3ZhLzz+2WjDB4WQ7ZpZlzRS3bssMZe4ONw90QjYkj3GDd0MDAwRi0GxeLI1NnBXedMsqqBfwY00kIS19dniV62/9IuVybP7ybKOtTV1QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=406F27Jw; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUhCETXlDwakLbzHFAjRASGClssO3tGZaJrXC3hL8Iu7CUT7sG6fky5mdrxGvBV1/PZFLeyINGpHTzEHkHT3UZHT5NwbUFasUySuolugKHrIDoTmYcN/v25PQ63F9uRNyRkcY9JECFshM7nx/dpnrrJyVDuUuK+pMALp8i3dBPSkmtoHufcfF3uEM7FvQGtRt+SdX6QucBoPnUwZbjyOSwZ8LM9keq3QDxNACQ5RHYv5+OcpM6b9PJTGWOg0h74BYPuIO225UHNx4V3m/p3H8gQtSKmF6AdYazF3KPdXNlT0tdk9o3y+ZnlpeOYrqv8sW3jsnigwrA7atXqusXTdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grib/Xnl1C7G3Hk41BOXgxy0UtrbYOLSbD9PAxamBmA=;
 b=PEodkvTaFwNt3YqG2yR2oXji7xEGyc/MoFR4XvQrhEuvb8yhJEyK9u2t8O0e/NGu9iWWl9SFVgpuIM+b6rIRcOnR+ZmWIJwkVbBH1J70JazBLxrAuZat0r+zj1ItB0WPIzEw1ZeY99qa91t6tWfgn+RNMMD6HTp3WAxpg/mGTJ1TK4sW8IO3TfxTh6Yk73Jldybzv5zc3FkOJKLTK/llupSSN2EigCBqUrcu3M6PZhHBm1mRvN2pOG0RYi5O1Co78cEjgsXNY2AVOOoKNCZdc/tNcKYhw6GJ9Ot+zNdX7E1l/xsOKRngDL545HwGDz4KHCXhpbeqc7SxN4d7BI4ZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grib/Xnl1C7G3Hk41BOXgxy0UtrbYOLSbD9PAxamBmA=;
 b=406F27Jwxu9a0xH/DGz+ncYW6c5xkM9+vSX0BDBm2HitIXiVEldQPwaH0agwaewFyXrL94rCj/TPtUEd6v6ra8UrUBBGTRdUhM6fp0SR2NjxY2uIw72X516746iw5nyDGcqODkHxDWqLk7DctcNXuNpQgVXhEozU0neX+WdZKNQ=
Received: from BN0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:408:ec::16)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Sat, 19 Jul
 2025 03:10:08 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::a9) by BN0PR04CA0101.outlook.office365.com
 (2603:10b6:408:ec::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Sat,
 19 Jul 2025 03:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Sat, 19 Jul 2025 03:10:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 22:10:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 22:10:06 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 22:10:03 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Sat, 19 Jul 2025 08:39:51 +0530
Message-ID: <20250719030951.3616385-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
References: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 82af4517-8465-4f9c-9edf-08ddc671c411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ZXISJe0ZZw09UJGpyenGTCV55JvzoAmFzmBECrF7bd014rCqTScV/xwjsBs?=
 =?us-ascii?Q?nJKdCu+OjA/ot/LnDN7Ri1gveWEQ4RA3tb+30V9jhSDtN5y6feobhP2Qkr7R?=
 =?us-ascii?Q?1MM/La3bOQGcH/M1nPYGwMbttPS2a0Wnmt/57LNQbBzu3q3kqedoORxip34A?=
 =?us-ascii?Q?kzSddt8gLHwI2P5mf8tcnBJ52RtNmwPDgthAUPaBzoqUKFdb8DHSwfYVF5ml?=
 =?us-ascii?Q?/fwC/GRDbWDGodBXsye3EPFHRvlmU6iK7Gah2GMaIjUJonJe9dctCgx1bYvm?=
 =?us-ascii?Q?t8U0eOaKuG54rqG/pXBB7X8ixqI+UQ09wHPozD5qHekRoHmjXsN0aUFWyAp2?=
 =?us-ascii?Q?xLyvICHN6si9UYUDTh1JfzSo3qKrr3CkfdOfIEA8bL+QgL5sdELwyqLCcgz2?=
 =?us-ascii?Q?7es+8sqSjbeizotyBbHZEqXEjqomPROB4uxuQVKDKyRBc60GRswoYWy5OWXy?=
 =?us-ascii?Q?A312wrKg/WDMztBAP252CTXChw3FobipBTGvuqSlj5ksEC1K+kDGvu0spaXO?=
 =?us-ascii?Q?Qhxiy/1OFY2GxMOTjAanUVfINjzwEzr46jW2Mf0wOgGL/arA1ws/K0SMHg9a?=
 =?us-ascii?Q?JemkneY6B3IiAWBaszWS9zA11kH+RZtMty7qo/AmgmaO/wr8DzS95WKwtd6z?=
 =?us-ascii?Q?/QeKbMFj3qN+qYpskfA0vKtaAx96OBZBMCe5Dorret7zo1dQbN0Yy3/g+SkM?=
 =?us-ascii?Q?v/0tsAvj09nwARG9QY3lEmYpImI9rDw1Bj0WMLdicRfcFekoxAOQOhifxfLR?=
 =?us-ascii?Q?gxO3FUSwkaIco+ZdU26zS/NkzSH3ukOKDZUjgMmzoFeJyWZ/ZojbEtMWudD8?=
 =?us-ascii?Q?cPYCQEguGqBQ7GfTTWOqgZL/l2DEzXa8XBm/eWjCXWJi4cQU7gYgKV/2/IdZ?=
 =?us-ascii?Q?v/NJqN4SzCJYcStIvMxqj3ogvwcw2Su9KuQfavhuCVH6a8JBrTZmTmko0vQ1?=
 =?us-ascii?Q?VU2VxznzALME/GHZcpI+zzD8/P7iG/v20YIMjB2IHmMNgm2xHsHY/wknR9JE?=
 =?us-ascii?Q?/bIpnKCX9y3cGtEfAehzK1an8r5y+BdT6m27yKEwktiBDZVbJ7Ive9nnpqDK?=
 =?us-ascii?Q?2vs9Ztv7Vw9aZ3F3e3AdXNig7pm+vwNoDR8s1/u0Y9rPptAaRKWLIN+z0HBF?=
 =?us-ascii?Q?Sri0RtORd7Jk9HzLKz7+P7o5wxIIGFSUnOsFKCeWqtk5bhb4WqoLi+VuN9ED?=
 =?us-ascii?Q?HRe+IPycB0bisDz2yHW38IGtP4nmQHgsWOTnLc5TXVWb9CvlzsccSYXbBTKe?=
 =?us-ascii?Q?mBbZFSce0noODnnVPTUYjZuct8sXP0Ruqw5J0QFlOhdtkjbAfDo3SoPwDxVA?=
 =?us-ascii?Q?8ndzhDasyEZ7VBWKTBAr1aY/at4Rz5/T/8IH07PYOd45iD6eVwD8lvwnPmBI?=
 =?us-ascii?Q?3UwtJXQtK+A+ijHxemOTyvvHCS06xPyB122mavP8YNUT6Ck5bu1TcxsLznBw?=
 =?us-ascii?Q?9s3gyf1aWsJaaFH7X+/uWk+R/AypMuuFoX0d+DOxgTCs/HrxMOVYDQ3mAmpM?=
 =?us-ascii?Q?Nj4fVlPg6snQxLSIIFZmqi9uRW9mXfkvK2d2+Ej51gBKg3kb+ojwXX+7dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 03:10:07.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82af4517-8465-4f9c-9edf-08ddc671c411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

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
Changes in v6:
- Simplified error checking condition logic.
- Removed unnecessary fallback message.

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

v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 62 ++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 9f7251a16d32..697f5b3fc75e 100644
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
@@ -454,6 +494,26 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	ret = amd_mdb_parse_pcie_port(pcie);
+
+	/*
+	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
+	 * PCIe Bridge node was not found in the device tree. This is not
+	 * considered a fatal error and will trigger a fallback where the
+	 * reset GPIO is acquired directly from the PCIe node.
+	 */
+	if (ret == -ENODEV) {
+
+		/* Request the GPIO for PCIe reset signal and assert */
+		pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
+							   GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->perst_gpio))
+			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
+					     "Failed to request reset GPIO\n");
+	} else if (ret) {
+		return ret;
+	}
+
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
-- 
2.44.1


