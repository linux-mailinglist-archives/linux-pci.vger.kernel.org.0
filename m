Return-Path: <linux-pci+bounces-30687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CEAE9554
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA171892280
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBD233727;
	Thu, 26 Jun 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hxMApc1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAA22DA1F;
	Thu, 26 Jun 2025 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916968; cv=fail; b=RlYx7hDioYN7rPr50snpuOLv1ubTLdRqLbfv3wFjiwg4neryg6KKzi+uBRNrUtqWDaptsFhzvBb4tfQDsJAG/AgYmFUXWEIhP5AGdhGoaOzMGkLSUpv9z8d15mqeLyLlnja7wAorac4C1422oxLmFQ8xO7m9GpsuTxdKtwl2NVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916968; c=relaxed/simple;
	bh=tvDh++WUv76Yhv9UdHgk+eh0jGXphkX7bmaNmhZif/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUxlGKyp0NfcNPy1DpROM6HKW0dZiznOXkLoGDY6L4V/Hz5Ej7AKE4Y90rSXjd/CTQG8MMGq8i/Gwwi8Oc6qJ5QpdwqprIn2Kd+Y1hlmlk3Rc91nTq2FXvMKu9SKwUxJiTpUe9TTDLiN7ryktyOMa4elunZo2hL35J63UNUtvXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hxMApc1u; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbdEo5+J7RJnT67GBQ8cWVFn+QzzW9vPr0xxCgR+dAu3s4QISrKiGzEmiTriLRcwNgqYgAHnsddRqlGIuNfUTnBY/MRvbyH4TvQG0o1CZXKux/ypUi6GMtv0g1DHp+xEazvz5/41U9EOqazYTSt6j/I1Er6vq8VVMW2DJR0596gtLUzVLi2okzmjbIvTzwH+FsMzlpZgEv7kdLryBs93rOqD4kdpeqmLn8fZhw0IRnm8CIqd1F/MfbobtPv8rf34zqTjjtU12bDt2KcaGfc3P3/0CiA7uoITPfephYLHsPb2/xQ+ON1vqIYTxOYVIFuNV8wLmuzMaSKpbnFuaEUgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mz8QknZLfz39LyNnvtopzyaKNTxvTIzQtr2dP6bFCM=;
 b=wyzwY992VcU7JDbRg0LrrnWYzadbthJ3v26VJqoMQ8xaJ8FWrfAKzyQzi3ZHzyvOibzur9SPqURlmElR7gyekXaPyT28oE9N67PvyRlLJoRXfGgdiDc47SARaZkyNSaPjVaxY6nKwF80UODYkYeZVmOXexzYMdIj6o+H9phVtaLGotxs0NmyEiVThjR9HPmcqGrRPxU5mOcNESONWHZiUtC67A9BOFG407Gte1gSVFjs0+RbPf31zMz4wNoyqH3tc2uMSyk2oJw0czGaFq0i+P38SdhGZctpfKPy6ltA101PGq+MjmGLZ/hB7yOQyIpn4V0ati/r1AR+/Kr0M2JbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mz8QknZLfz39LyNnvtopzyaKNTxvTIzQtr2dP6bFCM=;
 b=hxMApc1u5HN9Ka0iR4h3G+dM/eznRJ286+YGmD9RhxPn8crSB9lSdNsONogpJMtcoGdAB/jNUW6/2u7rOrAqEFA0AI7p7R2xsUYZflzEAXu/5Uy41LY/FERMG/3FOpbbPW6y+oLFJ94t697PcYzsN2z5SaXRuozZBirD3a6FA+s=
Received: from CY5PR22CA0091.namprd22.prod.outlook.com (2603:10b6:930:65::9)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 05:49:21 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::6c) by CY5PR22CA0091.outlook.office365.com
 (2603:10b6:930:65::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 05:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 05:49:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 00:49:19 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Jun 2025 00:49:16 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
	<thippeswamy.havalige@amd.com>, <sai.krishna.musham@amd.com>
Subject: [PATCH v4 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Thu, 26 Jun 2025 11:19:06 +0530
Message-ID: <20250626054906.3277029-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
References: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b2156c-cf75-4c05-56cc-08ddb4753281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7bHA2mmKU4lxL9kSR4522DxzVhJGPr9Po/dPzUd+7YcITL1m5D2bxbj4KBO?=
 =?us-ascii?Q?b2h8zAR0Z8B78uSSkXsaY/jGMl0N6uCUYsspHjBjRlkTBuQPmT9/y2WDLCJE?=
 =?us-ascii?Q?3TbR7ljjlwdJrcBGtYCSffU64gI07jzTm5NlmtJf1/YB6gFMXsarKWCw7tG7?=
 =?us-ascii?Q?cGgV1+obMQvF9P+vazV7hqXrNP1m1cC4bQkoWjO47FYyU5TwbB9I9WlNggFC?=
 =?us-ascii?Q?WJN8dg7wDfiac2XShzwvA9IFQhEAlUrE+2/pUnSfWC8U4du4KHhE1eAOSYa/?=
 =?us-ascii?Q?5g5ipnNx14br6NU/EVFeknhToiBTuU34fpnk79W9jVeh71cwqChx2pp67B8Z?=
 =?us-ascii?Q?M/FZYpr1L+m17BMUHPAn4sFtTm9zf1SslweU2AkH1nlvq7LR6XnoTLxhpBL6?=
 =?us-ascii?Q?wt2tdpr7Q33Pk0isjxkQOOJ0CSgWAG5gdmEmnVRJWc3G05ebo26dMK7+N5fY?=
 =?us-ascii?Q?ouLckFDwmBJUxx/CmIfJbuhlSRV0a6cDY0BzWBjZmTFqfpOXePaebdMW43//?=
 =?us-ascii?Q?oUraD3Wo0c0lZlfh2/PRLl5QqvJo8Blfbox9MwZnDm+WxmP683talWBptgeF?=
 =?us-ascii?Q?LDMaSoAvVq4OpL5cVbVZUz/byZ4KgxZSDNhhRgPgVuoXvPodmXwui5hV1m0E?=
 =?us-ascii?Q?2F64RfjUyp2ntYteHuBlXeQ7eFhnSH0vbNvnDnTqwQDGXeW35VDyqpiSloJd?=
 =?us-ascii?Q?4IZfcqfVR2h6WgulN8RsCa1R3PL1d1vllaNhyc/oZ2VXnRqKliRptIN5lsSH?=
 =?us-ascii?Q?qM9UPAQlFpJvLyYLhuSV0qLg5JFtxVc5dr7xERkXgd8i6nD5N4HVzzaU7NP9?=
 =?us-ascii?Q?6D8frRpX8199Wvw2HFfb7U2OV4at1ElOfDo3738Ngu+eJZL0gOHjGu4ZZxhn?=
 =?us-ascii?Q?uVNlF2sdTs1B54M3JiZ5neYhi3AWXxl5LVduO5JY/IlDPazPlCnkcizvaFuQ?=
 =?us-ascii?Q?XwPEFChSIe5rbsJUkZ8jj07u+aN3VQ5UXs0ST8WB0kHiBAfcb4f/ruGX1ahe?=
 =?us-ascii?Q?VQhFeAccbHnyx/XmJJGi4Ju2w4UA28Swf6FQktLLCecBLtfo6taejw0BJwin?=
 =?us-ascii?Q?RD0SZS1oDWUH8sprBmE1pETDLo47I7fRSGCgwypmheyUbFgM6JgBP7zDB+6q?=
 =?us-ascii?Q?++svAmGX5obdybli7btV+JqrFuDh8CmmwTaWwb08Sxe4eaxof0io0iP1yum+?=
 =?us-ascii?Q?9lIQkTQpOSjaqRZ5WcTEyxbSXYhhC5BiUYJyhgJAmhuMNf3rDFmpYgz/9D2v?=
 =?us-ascii?Q?FUQ0XXvwZ4W2+KH79/miKO2NxL36hf1vJY3LuXnf2zUpfSPOJbfNvbYxczJm?=
 =?us-ascii?Q?NccKxm7uZPqS+JkStUbS4krWn0rJ+eluKYHne2aIzoQSUvzEkTnPK9+R80M1?=
 =?us-ascii?Q?dspsS+jeFBwfu9GkIO/bp1lDSuDiJAYIll8IcGSiXZtHm/5RcKMwTpGjItWX?=
 =?us-ascii?Q?8pXpACBpf5Q4bKvMnII8APVZVeuatJZeO4u0zkeo4vTXgIDeXDC+DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:49:20.7092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b2156c-cf75-4c05-56cc-08ddb4753281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
signal via a GPIO by parsing the new PCIe bridge node to acquire the
reset GPIO.

As part of this, update the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child(), since the PCIe
node now has multiple children. This ensures the correct node is
selected during initialization.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/
Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v4:
- Resolve kernel test robot warning.
https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/
- Update commit message.

Changes in v3:
- Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.

Changes in v2:
- Change delay to PCIE_T_PVPERL_MS

v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 46 ++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 9f7251a16d32..f011a83550b9 100644
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
@@ -454,6 +494,10 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	ret = amd_mdb_parse_pcie_port(pcie);
+	if (ret)
+		return ret;
+
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
-- 
2.44.1


