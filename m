Return-Path: <linux-pci+bounces-22164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B8A41674
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6F8170D94
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237819DF4B;
	Mon, 24 Feb 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O8sKuW8s"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508918FC9F;
	Mon, 24 Feb 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382927; cv=fail; b=GZFbS30j1zeQntKe1gdyS+0oQgMPMOc53i70CokZdejcIxq6WA+46rfOpXVjouuGBLmG9QmT7R5fVAEPMvV2FTh2bEB7aaafXNpIxF7cHx1dguh6EP8Ct+H8uH8vbhV6JoX3Jm3p7SjbKdNzSwc1FzNAN/BWROarYqGhyJ+V4OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382927; c=relaxed/simple;
	bh=lgfkgtDlz4uB1OX+/gHIsGJJBqmYOIdPXUbOt2Wgefc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/v08EnlLLGmp+7SFLgUklvaOZIaBsynC/nwMAvWac6EJrAKgmHs5LJqJDIbNfzE+k2TlhaCKh+tgDRDipklnEPx8kCPXiQAJdsreyCPdKn7TU+GoUJaYqdH5fwyCdBYya3mTw1rLXgt5CAHogL/dUW9tua8x3q90TLrU+wIJLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O8sKuW8s; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W95MSBiW+WFELztHrbKigh+KS9c7wULmGb6C06bfo6GHNN7GLy0/ac96AFRaDSA8O+LdOUgoWMqHYVbYyEMesjYf2RIZd0GXQwJc1DCaglw5sDWu2Wf+Qk4RtYVT8lvAT/f0ehGP4oK2yn16dZxtfypufWiDNBHvmZAkfQERzE3Y4I8CsFw7PDkqKaN0QLLfxPdPqjMjHmzOf3gv/ZOrKNk9Ntpyx3STJp90jpVLQGo89tqhK+RNMwWwTHzT4vUnVnn2klApCKAJI2coitSHUYa+/eew+/BO38JswxYbHXQ2zhgRigycf1qOsHVeE30jRqrbe4IRhpj7RLKqJTIBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFeqsMD2zzSFWSbc7Xgwsh3Llt+UBQKP1BXN4soPFpo=;
 b=gTGK0gAOV+G4WYUcbw7DRbrC+Q/VeNBpR5CWCKj0fSyFbgiDtXfYPWqGRqJmAuUUv2LJSA2o3P0Uh09At18z11ufZ3RH2bEI4M/ob+GHeyjkfKKLYTet6BcU5n2V2bftQ90o81YLOQPdJNXBYQNp6f44Z2m+WScKZPsqKqgPSXgIUu8vJZOdo7Y7ifkrLvfwdsVfLtG4DesreF8d4YkC43YnmPyAg9NXD14/u9k5wSa3/yVN6eOMuJZAftx+n3FAV014RdvU3ZCYCSzq//Tl8RRJX5udvREfJhvJfllYzdw67k7NmJ05/+lPSNMv4wXx4iWzyWn0yfKd7axn1EWvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFeqsMD2zzSFWSbc7Xgwsh3Llt+UBQKP1BXN4soPFpo=;
 b=O8sKuW8sHSgpx7uAoT/cnzr5jqAlgUI/b+nbKHckVnIzuMJEj4/XSM5O1uOwI+x05kw6k5Xa6eNwjlW1T5q6ulRRrdwxdTdTbxVxb4J9zkTlwh6dAqF1pyAgpHzDsdRm4y8EmAPf1FJbTDHPQNJmQ6V0kiNjWbNX1vj/Q3oFqzQ=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 07:41:58 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::c0) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 07:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 07:41:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:56 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:41:52 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
Date: Mon, 24 Feb 2025 13:11:43 +0530
Message-ID: <20250224074143.767442-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2476fcc3-3dee-4a95-a771-08dd54a6b777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pieJ5EwTJE4j43ukr5QPGP99uXLuN+rxj/w0EljeZ/E5eaSDqMRTJ6jD4oap?=
 =?us-ascii?Q?JEUuoP4Lplal4qA9kBXmS6U7TGppEdxD0QgM7dl5U4M+AnS0S0a9P+JcUZom?=
 =?us-ascii?Q?sFXjpsqhBB0UOiQCvGzvGwrNoPw71QSCEJpjCE658HMMhBGCe0E3+UzXO8P5?=
 =?us-ascii?Q?Bt7gCK4RepJkBMSsOUedBefzHQ+Q0wJwiwoIgGHoCBIA9KmY1QqwJzQTJ32H?=
 =?us-ascii?Q?hnzZ1Z/eK5C6CsiaeJG9Vp4ee5Q0EiTzeqiMnDD3Ulim6wofPmBAmndLiBnC?=
 =?us-ascii?Q?U/N/SPa0cO7GvkOsJLl4ylLx9sEK/HOeRUjROLksop6RfWn+73VpeTUFyJfT?=
 =?us-ascii?Q?4YPJX2j6R3ecNDSIG3xfgQLwC6frGloJHRwtYjp+5uTGMTzYxDdAsJKy/U1Z?=
 =?us-ascii?Q?2QAFnR6y4t1uP8bWe98/u/ZsXVK4ZjsnMcfCj+2VLyMfEWt/L0PVzSn8+tHx?=
 =?us-ascii?Q?3Oa//EGNepiBGFk6egGPYMkKl4hUfA22rUnfOnbquHanD1QJVTbicEAxgZIJ?=
 =?us-ascii?Q?pzmu9z3kRt2PKTBWaQJ4RKy7yqr3XxGQmncJR8NWT1IqEfB6Mo67upK7YJtS?=
 =?us-ascii?Q?/A5TZdnceyNXGPVGt3sZf8abDWn4Gft4QM4/be+ILXhzjSrrbCc0n6xVx574?=
 =?us-ascii?Q?mRq7zlBvCatPuQrdaGUv9obhIlq8egOj6U/INpfR/Qnez2b6NYxQIOwaUMzM?=
 =?us-ascii?Q?4TUqJtTPRjxNLWrQpSuyk/acoya1FtDLRve0+CI3KiktPJGvEelcUuicHH/g?=
 =?us-ascii?Q?tOYZ+4BaPbn0YvfTL6D2s+MpqHnycTnT9NaNNVOmuh1ptiGmGs+DAlhBd6sE?=
 =?us-ascii?Q?5zrZpZbRWYFyqGf4FQCM4gkF/ARfC8sH5UWVNe+/Bba4z/cZGg28Z9aDFmPq?=
 =?us-ascii?Q?jW5RpOZyapORcZEzToxafScdC5OeVEpxOjFVeRC+7qLaIJ12GFfBHL/QouZo?=
 =?us-ascii?Q?zVsp05lQY9Q83pWxOaRZzkg0ixl7aEPXa3t4MC4YRKbFR4LnttQOcIWoCDdX?=
 =?us-ascii?Q?XnxzgpMQH/jGltcPzko2Myg16sfvr7tOWEaffpZEF4VnUchiUuysVg6IR8F8?=
 =?us-ascii?Q?h1yMoIA0By4R65IZSTNyadywJvgo/qOaDGqrQayrBOAeQEVatgPHCBYnTKEE?=
 =?us-ascii?Q?nZafv+rFexQ/EPaSvyw9lzMfELqz0ytgZilot0Ilg/JlME3b/u5iyyp5mPRU?=
 =?us-ascii?Q?5+jx1uGYIPV2awluOJCGRMYQiRCway6e1/BP1HWO6S56cXfnE4L2PqukjqXU?=
 =?us-ascii?Q?3JYFyMpF9WdpWYrY4KXBzzvgb9gi6N7tfFJj/6zfDi/KiIarebpD4aqYRcZ2?=
 =?us-ascii?Q?17SSHVK17ilOKmr+mpTVKPHyU+WahjcNarJPNuTcaYsjecO2eYYwyf8tk7rx?=
 =?us-ascii?Q?Lwwss+0heoZY5xOJzc7WE/jXnP1brgicl/ysyZSyA8nHTKspQY85O+UBkAsY?=
 =?us-ascii?Q?McAvm1zokzDxsTje8P5ptJdu7m7z4boPzSDEHXGmn7ZkGJ+x5EhShpUoT5ek?=
 =?us-ascii?Q?z3FLYVrR7EVTOvg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:41:57.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2476fcc3-3dee-4a95-a771-08dd54a6b777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
incorporate the Coherency and PCIe Gen5 Module, specifically the
Next-Generation Compact Module (CPM5NC).

The integrated CPM5NC block, along with the built-in bridge, can function
as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
configuration.

Bridge errors are managed using a specific interrupt line designed for
CPM5N. INTx interrupt support is not available.

Currently in this commit platform specific Bridge errors support is not
added.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v2:
- Update commit message.
Changes in v3:
- Address review comments.
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 40 +++++++++++++++++-------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..a0815c5010d9 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -84,6 +84,7 @@ enum xilinx_cpm_version {
 	CPM,
 	CPM5,
 	CPM5_HOST1,
+	CPM5NC_HOST,
 };
 
 /**
@@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
 
+	if (variant->version != CPM5NC_HOST)
+		return;
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -578,16 +582,18 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 	port->dev = dev;
 
-	err = xilinx_cpm_pcie_init_irq_domain(port);
-	if (err)
-		return err;
+	port->variant = of_device_get_match_data(dev);
+
+	if (port->variant->version != CPM5NC_HOST) {
+		err = xilinx_cpm_pcie_init_irq_domain(port);
+		if (err)
+			return err;
+	}
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
 	if (!bus)
 		return -ENODEV;
 
-	port->variant = of_device_get_match_data(dev);
-
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -596,10 +602,12 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 	xilinx_cpm_pcie_init_port(port);
 
-	err = xilinx_cpm_setup_irq(port);
-	if (err) {
-		dev_err(dev, "Failed to set up interrupts\n");
-		goto err_setup_irq;
+	if (port->variant->version != CPM5NC_HOST) {
+		err = xilinx_cpm_setup_irq(port);
+		if (err) {
+			dev_err(dev, "Failed to set up interrupts\n");
+			goto err_setup_irq;
+		}
 	}
 
 	bridge->sysdata = port->cfg;
@@ -612,11 +620,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_host_bridge:
-	xilinx_cpm_free_interrupts(port);
+	if (port->variant->version != CPM5NC_HOST)
+		xilinx_cpm_free_interrupts(port);
 err_setup_irq:
 	pci_ecam_free(port->cfg);
 err_parse_dt:
-	xilinx_cpm_free_irq_domains(port);
+	if (port->variant->version != CPM5NC_HOST)
+		xilinx_cpm_free_irq_domains(port);
 	return err;
 }
 
@@ -639,6 +649,10 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
 };
 
+static const struct xilinx_cpm_variant cpm5n_host = {
+	.version = CPM5NC_HOST,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,versal-cpm-host-1.00",
@@ -652,6 +666,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 		.compatible = "xlnx,versal-cpm5-host1",
 		.data = &cpm5_host1,
 	},
+	{
+		.compatible = "xlnx,versal-cpm5nc-host",
+		.data = &cpm5n_host,
+	},
 	{}
 };
 
-- 
2.43.0


