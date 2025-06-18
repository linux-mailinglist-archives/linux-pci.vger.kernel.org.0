Return-Path: <linux-pci+bounces-30019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AAFADE541
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0187317A574
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987A27F002;
	Wed, 18 Jun 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IbxPeQx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69E27EFF5;
	Wed, 18 Jun 2025 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234195; cv=fail; b=LkgG9fB0WiruC/XBc/gJNTWuBkXIzlW/GofMceWLdvGrkv4Fd0xliA8lLeqHmOft3rl2x913Zu7uC/KK50G2ZPQbiQKq+NB9QSwWV+Cei1OBcdBoHD2XKfX23LP47xah4QZQdN0YkN/SJteHgnAeuwyizPv5hTJngvOd7Px40lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234195; c=relaxed/simple;
	bh=U2oAUO2T9ap2Ytheabz3m5gJ0PZ2iGqvJKiQEt9y1UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WE3lBuZWknFCn4DkRkf8ux88ixNgOr6yvxo+ANwdy9qAsbFJEU48PS8rvt0I+ThzathTk2P93m6+qUcdj24rGL75QX8BiYGwfntFxhG9SOZIyuq4VQ+U6ZBnK6m1Y0x0dPOUCoDqqdXz70yJXFIy6MAjBs9VWw2Xe2nRGbRdj8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IbxPeQx0; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTLdn1PpXxBnbCdwkzse3gG7tlbW2AmdZIV7ztWcgrh30ihhizD6DN+TpxeUEl917beA6zHtZsu3O/SoBiWbqUS7oNLXJzqtFidHsGbtfas7QIdsmKceEq/G+xRc2A0sj6yBiy0S3cJzQd9sKKnIIXdB9dD7zQ8mbkfimHRfOZmWV3S3XGQ8Z24mXEwcXR0NMrlLJFqv21ESWuNoc/l1cHfesNEN1bONz5rttK7BpnUB0PZhgMUdvRWqPJIACgIhi+Lx+rXfChnDpjWzOGd1qZUOSquhpalX6XMarHZjRV86tGWHdSzM+E/jitS8ouhUzdgz7AyK/9JygtB4LzLJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvuegM2OmNNzdm5mTrQZ+2CHj5Eh+SML9d3n7MXL8y0=;
 b=nsbo9lYhnrNbdF17NQzghRE6sbkJOFqgADQZCGmkqAQj1LpMqebn/iiX1NIAEeRlUvzZi9aHv/Hjt/S9r4yCe0NVJvT3dpU/tw+TWwKrSNTVMECgYvnzZRLbURwH4wyiEb4OiPhB5Q/DSEU9YvrJFSd0LPqB+U4HmozXxJkRj2vAlL5Klwavf5waUKfEjjCgmjL8L2Nz6UKRJNyqBpRp8zO/ypV0ots0XMJjppGH6JRvDAAi5aGHGp0Eksyh0sBZSup5YUeUjtfEWx+FbLTTFFR4gxwT7ni4Sr2tKhyQ34DleE4/TRI8hvVUbUaHmtmkppow+C6bgGU+8EkAcGytNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvuegM2OmNNzdm5mTrQZ+2CHj5Eh+SML9d3n7MXL8y0=;
 b=IbxPeQx00yRgsHtSr8t15Z5MBqo368eqXo23X2EWcr2PfpM1/2wHr6Ikx+yIYS0ldrUV5sQyqnUKAZJbpjOqviUTxIAo2jpchXUNt+WRMq5uEBDaR+4j671XBJiIQzSTTLuBaBTUivL/h/WdkPLX7WkWxyQHRZ2pS3K5FWaP+n4=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 08:09:48 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::9e) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.17 via Frontend Transport; Wed,
 18 Jun 2025 08:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 08:09:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 03:09:44 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 03:09:41 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Wed, 18 Jun 2025 13:39:31 +0530
Message-ID: <20250618080931.2472366-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
References: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b27782-f264-4a5a-febd-08ddae3f7df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3ngoSyajaJTopVcxc+PEgmXAgMtMp2J1DojnNds8DK6tM/b3vZ+p/fix8/A?=
 =?us-ascii?Q?GVnr3LDbKYE1jDLxYDEBdAvZgWmPD826ikDgTLEx+SJq1svyo4YBbzvaLv9x?=
 =?us-ascii?Q?N1NxNqKGkh+PCWWO34tmEXB2jIA6Je1xfYrjDtaKFG3HIqHANF4uOlIGAdHx?=
 =?us-ascii?Q?Tt7484CUANJ4UVDp/g1WPWqGoKfQZIMIzvnYxaD1SlCF2ex5T/07F8FYkcK7?=
 =?us-ascii?Q?uLnsMVKXV6DkERStiMYs4nDScHf4vUr0R4T1qBesyWWKPZTf0naCZt0CfCdo?=
 =?us-ascii?Q?Ob/E2c1xRCHiP+WBhPEhSUtLpS+S6/qw65C80c4lY5MPeiw+0xnUCM3yQ7eA?=
 =?us-ascii?Q?bK+DKJir4UMt5tDJPw/MAFyemw4W6SgZwagkqZBDpITcIcaTJpzBq3QavEWV?=
 =?us-ascii?Q?W4oPHIu5Lp+qN9wbhNmO8Yi21Ii5CYqgTs79SGLLcBs7f8iYPJAFu2zsj0lo?=
 =?us-ascii?Q?PsZ1VdF5QideSy1BuMa37At7ZN+V3HYLThC5I8LM7nK/+aIxsLDukatXbjmJ?=
 =?us-ascii?Q?sN0rCbZmVJ8TLI2Bf293dMxDncPR23w3ZjYHgWcZlHS8F3xJHGKqgoruOJVh?=
 =?us-ascii?Q?XbeJkopKx1jdbmFCv0eBVBDtof23Z46/LpY4D7U7B2ZIQZJGPAUruRdK9pgc?=
 =?us-ascii?Q?08glyGkCc8N66r7M4Z25cVOTPqH9gFW8SFrGeSgMaIcfXIo2dkkA5WYaHVwn?=
 =?us-ascii?Q?ZBr4WIF8Zvikt+/PW94sGtbcK0YM8t8VgmvUIRWm+RKhB46FVonEdfj9AoEE?=
 =?us-ascii?Q?2am2ztoeJyhWyoaAPwTrQA1hF1EhklH8YLFXr+Cvbx1Lik7tP5bipDBWarv+?=
 =?us-ascii?Q?teVp0sDbBX6VcM2KAt57p581ebJEIOEPW6WBFJWRiDitI/mNW1dCj6Dy17ap?=
 =?us-ascii?Q?U/qqo9aa/juXEx/3BeOEENRy/d2+HBkiR5rIL/1kuAbntJENQxQHl/9qLOOW?=
 =?us-ascii?Q?3cFjsLie5uVhsGTdNSW5uayRzBb8CPSbBvo81h0Db/akjt3Bx71xH09TY9ks?=
 =?us-ascii?Q?h4sAnq739wFlEvCeD7w9vdQyLDiMGWFGO2koyz4S2ajkhMAWH5eJ7UuywobO?=
 =?us-ascii?Q?KPpGMUjqj8APB8M3DO3+CJ6e/ihkg/cURwyQIJy6WWXMyA7tvGgFGK3WXP7F?=
 =?us-ascii?Q?o/yan8xo6vcSBnnzszLSBTZsC08/cKa+AwBs/YZxrpJlkfuqwsrxFTFznmRa?=
 =?us-ascii?Q?z3Wv/P7HdSSIRg4ZAG4rQ8EBIXAxtLlpb5eY+pFE7N91714pcGA0OwtNxrVW?=
 =?us-ascii?Q?/naspXMCFp4/c/gtiFdG0BRikGeFhEyYkW6UmWAp/e0uWSNP/Pjo0e3BDHjs?=
 =?us-ascii?Q?uu3NsFWBhBbYh/DyGGDAaakD2frWA+QUPc7dPdMse9kOPUOJMCU7ir0iGa7I?=
 =?us-ascii?Q?OFhEgdBJIbTFidTpcqldHmXdQejf2BCZhCIllAi0u8gUf9GAe3MTMEiKtRkG?=
 =?us-ascii?Q?HTfdbEiw7v2kA4HGcl00HKXDJ+OvWbM2sOJry0KnpkthB4SvVBgf2fmm18DA?=
 =?us-ascii?Q?cBfe/MagYkjqS3fIT3OCWlGwR0oWaiKspNVU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 08:09:47.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b27782-f264-4a5a-febd-08ddae3f7df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339

Add GPIO based PERST# signal handling for AMD Versal Gen 2 MDB
PCIe Root Port.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v3:
- Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.

Changes in v2:
- Change delay to PCIE_T_PVPERL_MS
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 45 ++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 4eb2a4e8189d..b4c5b71900a5 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -18,6 +18,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
@@ -63,6 +64,7 @@ struct amd_mdb_pcie {
 	void __iomem			*slcr;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*mdb_domain;
+	struct gpio_desc		*perst_gpio;
 	int				intx_irq;
 };
 
@@ -284,7 +286,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 	struct device_node *pcie_intc_node;
 	int err;
 
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -ENODEV;
@@ -402,6 +404,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
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
@@ -426,6 +456,14 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 
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
@@ -444,6 +482,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct amd_mdb_pcie *pcie;
 	struct dw_pcie *pci;
+	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -454,6 +493,10 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	ret = amd_mdb_parse_pcie_port(pcie);
+	if (ret)
+		return ret;
+
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
-- 
2.43.0


