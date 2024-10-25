Return-Path: <linux-pci+bounces-15364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39DE9B116E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820E51F2A39F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254F21B848;
	Fri, 25 Oct 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pw0dvQd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2831215C52;
	Fri, 25 Oct 2024 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890331; cv=fail; b=ffxZwUq5gqCE9LOW3L4820pIML6SMMYr/y4IUMhgS/IKEB7kT/RUXqzPNI1yicD0yaHXnEu3BdbYagSq35KE7v4k0eO/uwIviZC0TSDB3KahQEnkNgJu+bYl39sKecxVaCDVs0i5Xhk+NzKj7QSkkfsiXQwi3qUdboQwBxukWkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890331; c=relaxed/simple;
	bh=kTFGXrjGtDr14Ze9C1YsLS+2I9uGo4L3/doNRo0AhY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAoJui6mfp76kwHRWgSx9JBDrj0/9PtM7+R+EwPVDTFCdAk48LnkCZWPw1Xq3kyKNXeVQTWhZnvIuZSK06SEF44Rg+ujAaS6yJfcgJ0g5E5RffuIr9y6zIoJWW+6PJPcLNy9taavUrJgMW0u0UXBMvSh6/OkpAC3W8nsjlBF/Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pw0dvQd4; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUfCQILDmkJNYYyxuTc633fZW9a8UGGiTP2X8cu/+iHbqsJmuz3usE/giTHUBgpZMWFV0cl5o53oFgbRsQ6gWrz3rqlPYUfWT1G3Zy5n8SD9tycM+95XeHFPUg0ke5DMcKL0OBV6ZyMboHmfcroos8JyNYeUkA8mh/XFqffptGYA8P1g/MLmXHI2ND2rOq2oVB/OcIpRtCwGoSiCq5EEpEPrcEePZ+9f+tjqXmZRK7uMunjawlB8EVSBOtsPY2t5Nn7iau6oDF8XMjOcv6zyjdenPW/LS/52X60d+ItZpWHL3ka/CYbrqvsXGyhrJ+6FNZU9/AXa+2fPmX1RXjiNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIXbX+PP79KuODXXgLzFsESgnJddbJNI2TQr7VPs3gw=;
 b=gQqMo8xTCDD5TZcpSnbq5nERLvRNdPPT8p80axpN0qiBzGQ8z2QmO7fcNECmw6uS/VVTJXkOIKRvh/jZVGgEe614cYgd+3V4tE2rJf4nNLwe8F1qSke1IjfVc+yVA0NfSKbNVqxypE5zESUBpKG29Oi8zHGtKL6g8uMcg6z+ikb9Xi9yY45o9YoHBdu2FfDiUYNoTFjOjB506lCH5qoyCRjcAFTMNO0XxDewvHKdymjuzEkvbKRflS3MVFD3KxCvIOltIhnNIqFYsF7/CQ2EpBpC6ZGRPPnIJWkMdrg0vMoLid6TnT57/oUsFeH8BghVRjRH1o3CDtqOrUXXhT1FKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIXbX+PP79KuODXXgLzFsESgnJddbJNI2TQr7VPs3gw=;
 b=pw0dvQd41bZy40sbrvCpIp42Wskx29CofCFNPv0u7hFDY7wzzut8USH7Ibywn2XqRTZpHJdWNToZYPm+gBla5kepUAWauTr5koNMZddZlWDFKNoVhbCxImkYw/qwH9Sm5V9Zksj3b7V8IPhR3BKNRlP5gPiSyLGqdIj+gPmGkB8=
Received: from MW4PR03CA0075.namprd03.prod.outlook.com (2603:10b6:303:b6::20)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:05:24 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::13) by MW4PR03CA0075.outlook.office365.com
 (2603:10b6:303:b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Fri, 25 Oct 2024 21:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:05:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:05:22 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 12/14] cxl/pci: Add error handler for CXL PCIe port RAS errors
Date: Fri, 25 Oct 2024 16:03:03 -0500
Message-ID: <20241025210305.27499-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d1acc1-700b-4a2c-c5cb-08dcf538be68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wv8bViy98dwWCm2YToj0soiTQLJRfLCy/t7Fq8Z3aD7OJwefrVBfTfgof04f?=
 =?us-ascii?Q?IbRAYbMdDl/FkvNk0ZdK4SUiJrqDQ4w9mwUNxlp3FgvtFe24hCuifBodspZS?=
 =?us-ascii?Q?wY3XzPq89yoIBsSWoRdrLS7R2sU3Yw+0UF00JXZ8UOaoKX/8FJ89LlDCyv0/?=
 =?us-ascii?Q?ci6Zf5syQBFqAg1WuCROcP0Xuy/Lyr/CyQeYebUeP/GoHwUOgtyl9UkojAUc?=
 =?us-ascii?Q?sfm8G64UI/VGJr4FPeoGHPpb/FL/vuUHZp9KKecfspjwrQKQ9vn+H+IGz/W+?=
 =?us-ascii?Q?IMJZ/1shkp2/cPMYAJb4DTL9MObLrBR/2Hni8dGvmCK7Gkt6y1UxlPrIK05b?=
 =?us-ascii?Q?w4Y8SqshNPx3kwq6amfVgePKq4AYQjbXxMZN4A5XG4KjiGC+k5jfu/3T9Fl+?=
 =?us-ascii?Q?UGZTi+b1KJObprspPpRqCtt1n0gM9nwfTvuKM4ivwTeyf2rEH99uFeiQ79A1?=
 =?us-ascii?Q?cApNS+TfDG0kZ5WPIaVG7ZxOQWZweEhdH7pOpFvjb1g7axQMHA/zYywl2T3Z?=
 =?us-ascii?Q?S92FzUa8jaDplPTJQCbgopDdLqgeVi8C8tQ6d4X9Vlv24YjKbv5VXjnvj2qP?=
 =?us-ascii?Q?FqH/vPkP+02iz28061lwFVp3mCyVgfllpLuRxHdpK5qqN/VvUkHIoXKAiuvT?=
 =?us-ascii?Q?w0sReMMm7xqjrjqAzomUAtVPYF251h19yRR1fLMsv7cLVCvBZRmv0RB0wwYY?=
 =?us-ascii?Q?j+qhxkydrDecECy/hxV2xLj0LGZo4wgwZjgYoUea2MGswry7K+pMJvIGNhpy?=
 =?us-ascii?Q?tVPcHbbytrfI6NCk0kg+G5Wbbqr25V31pJLJwfQRFVydVjRR35TifscmL3JC?=
 =?us-ascii?Q?7KY5Puw+k04w2vvrpaI64YETk2HzDddD7NXc3r0grxQ/ELwktRcy1TzsyjC9?=
 =?us-ascii?Q?dRr2i2zZWHxKUepqliAbPxQIWXK+laOa9UYv83F9dyumahSSQ8nUgFf/MloO?=
 =?us-ascii?Q?L2+lleeZzunbdCBcziMhe0GKfWq71/KBDpZvYkfEp/W/j+4jMLD65q5TX+Op?=
 =?us-ascii?Q?jXalMs9CTnKxDoTv7PoY24eAydqomjc7EfF+aJeB8zrVZkrmQL2tGwvL179T?=
 =?us-ascii?Q?cWZoU4jQ3myW5xfK9ag598JGY7vqpFn/faPi7LZ++tBvY1EWkPVmlIYePewI?=
 =?us-ascii?Q?eDZ6t1YrEEJE3jypZMm9r9rnp6MWHoW6Xuh70c52/YuJnyW1icDvryvKqQae?=
 =?us-ascii?Q?jYcQxndRpo43J7EuaTdOQ+apgPZREDRx8kvWim1yWhrOzfBz11ulRVDgS/0V?=
 =?us-ascii?Q?GLrWdhsG0D+bpopu85AuoZjj0bhPNwV/zCrDYYnnWg7w8JHge7sHDNSKXP+Q?=
 =?us-ascii?Q?1xlOYN9STrlpJmTuhNIZkw4Owzp8qUP8rEQ4nCyHhaGbvhf+fzq82VMy8nEY?=
 =?us-ascii?Q?lGMwj2RL3j3ryPGh+3Vt6SrJXIry?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:23.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d1acc1-700b-4a2c-c5cb-08dcf538be68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Introduce correctable and uncorrectable CXL PCIe port handlers.

Use the PCIe port's device object to find the matching port or
downstream port in the CXL topology. The matching port or downstream
port will include the cached RAS register block.

Invoke the existing __cxl_handle_ras() with the RAS registers as a
parameter. __cxl_handle_ras() will log the RAS errors (if present)
and clear the RAS status.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bb2fd7d04c4f..adb184d346ae 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -772,6 +772,65 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+static int match_uport(struct device *dev, const void *data)
+{
+	struct device *uport_dev = (struct device *)data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+
+static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
+{
+	struct cxl_port *port __free(put_cxl_port) = NULL;
+	void __iomem *ras_base = NULL;
+
+	if (!pdev)
+		return NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
+
+		port = find_cxl_port(&pdev->dev, &dport);
+		ras_base = dport ? dport->regs.ras : NULL;
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct device *port_dev;
+
+		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+					   match_uport);
+		if (!port_dev)
+			return NULL;
+
+		port = to_cxl_port(port_dev);
+		ras_base = port ? port->uport_regs.ras : NULL;
+	}
+
+	return ras_base;
+}
+
+static void cxl_port_cor_error_detected(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+
+	__cxl_handle_cor_ras(&pdev->dev, ras_base);
+}
+
+static bool cxl_port_error_detected(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+	bool ue;
+
+	ue = __cxl_handle_ras(&pdev->dev, ras_base);
+
+	return ue;
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
-- 
2.34.1


