Return-Path: <linux-pci+bounces-45012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66CD29AAA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12A283012E99
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197E3358C6;
	Fri, 16 Jan 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n7RJeChA"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAC2E7165;
	Fri, 16 Jan 2026 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527764; cv=fail; b=k4nDTQMO8dLrIxDPr6fL94Z7/JQsG68pZ1Lae0ltiUcRRXfmVyA5LTn5Aqh/Ok4xdSO+Ksy++Rp3I1eeY2wT4pQm0EOzFBRXXEpxHEe2zge0wbmEJ7CbvmNdo5jIcnGJCkbQilGFr2p9CX9IgpW1G5SOyqaXzEbkMGgsUbTIuJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527764; c=relaxed/simple;
	bh=mMipAnSDDgpfEoNMSjQesXgB2SJqfb/6Qv8CYjFq36o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgpKrV4jnkYQMo41nKRq15Nj0l9pvxc0IF9/Vk+IYpMx7/Iz0cc4kHcjIqcVAo+uXnTd61J35XRNHKhXYoN1McbH4fI5y7S2SwWSPAxkt2bJiLlmNdDm1ShjctWTzOx17zALLgqD7YfjNdVOyf3UVa7qPyCvqKOwCt6Kljx+PqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n7RJeChA; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK5RSj0JdireOJSvdWvtZt/euKWt/ngV9k8w6QR6yNgSwU1SxbyhvVwdYoObIg8+2yyQCLwAawntbBHXJYBtGrcJpaHG8w5NizT9HhxE/xR2bQDapUdqcJt/mlqKyPxCJ5J8BCfq9E0+xruXkX7JJo1pBRRIC1PXEntE7YL4916JuyuoRt8pgsBIVOPwJhNtvsPeDsv3WKH2iXY72UcIjaABROEqL5FZeupnMKni2yoq2OXNA/h34Yzm9s+UGleOswol9tOKmsaDHoQ5p1+YPQsJi9JMbFz5WcS65WbjZYri10WM6I1ZvPkM/3dqJGug5vpE3+dadCuNsbPPkdgB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LuohYvOkUSFUMrUNeBMr6Cj3pYE2raZUMfLCmpd/hc=;
 b=nBaYYAj1QE/oSPIoQRqOQwGBR5mn3S/A3J5o502ADrf0kCPmyK2qBYUPD0oYh5CMEp2kd4qQ7UXFpFeR71bz6sawpqOy+JoElB5VwPqttBsk+fanocHMQX0Y0ZC6IpAC8KIho1Wz7oPXm3GAiKo+JTkOT3vJnxi8w3nH8OZ9iRZGJ60QIPQlY9FWr4zYLIHjo2tcnVVB9/ij8t/4N14JJ2Y6YwyBrm4wUDQpA1akGEcAoegGtMu7OPwVUBNBJdIIpFfGluc+92+KWUYXisGuYuXZT6nKaZzdUFJmowSRqzXHSk7OGArND/gvNl0X3nAQyZIPclGfTKkaYZb9fdIVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LuohYvOkUSFUMrUNeBMr6Cj3pYE2raZUMfLCmpd/hc=;
 b=n7RJeChAQqRFoTkICHrzCk6E0LHnAKvaHayiB8BMt2J3ubeRPmNL5IYuwa+9oEjyZregXFmv/nd27xh9nkRWdj5bmomwfq4xWzRnFc+rGek5SvOyoktbFgUm9qSWxoqcyDaN6RomQL6Tu9JaKAwRnMETLLIa7HrP5l68qOEqtHD3f5fjeoICPWtg9zJsmyanAb+UWXeyfFfv61cEH9ZJdnHTdYqYadd7geYV2QBsj9MEKtBeI/UffkpF4hIERg0qH+g4RHZ4ARSCLze9+rfqIOg6yvbfRUrAjE+1PIBoviJwQ+aMiaW2hNZnXAdngN7boM21ENIckD3ZYCMYRxo9Aw==
Received: from BLAPR03CA0179.namprd03.prod.outlook.com (2603:10b6:208:32f::33)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 01:42:25 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::e0) by BLAPR03CA0179.outlook.office365.com
 (2603:10b6:208:32f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 01:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:07 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:06 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 8/10] cxl: add DVSEC config save/restore
Date: Fri, 16 Jan 2026 01:41:44 +0000
Message-ID: <20260116014146.2149236-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7698e4d1-5495-4421-6ae0-08de54a07fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWFYfcCvurdDhnL0eU8HV072Le8xpOJ2gb+9WU6qchVB2uIDiFgd9SVIFWds?=
 =?us-ascii?Q?+UTHejwZAQAfBqL5mpfC0VlaOEWW+Wv3Erchg5gpqZyKqKtbrt6qVHx8Zpgk?=
 =?us-ascii?Q?xEalO4ujpH75g0pmJxfY+LFP2g0ozAL1jmUTAr3J9DP0IzrqY6T3G1QZ5NqO?=
 =?us-ascii?Q?cF9sQ9opwQhrkEYq5WZcyh2E4COQpRmgpFoSXN+tlq967aOEN7BLDLUASlgb?=
 =?us-ascii?Q?HAc+gRFV7BQNvBL+LVk83IZXVFB8TbUBHSw5XyKeS9TB817V23JENptlxeDb?=
 =?us-ascii?Q?tLEr61KEwZDoSZMNheTpSrFwmvU2Rj049o3jQbDFpnvdEGWbAk48wbHrkCIQ?=
 =?us-ascii?Q?mmcY2egNcZPjVv8xk1aqT0ppjU0IN0vmdvHSIsHauF5g++EQ/8U8+tiD+QJQ?=
 =?us-ascii?Q?aj8Hnq3dxhm2UtNwRgQDBd9fAxslAwMsXjRKdLVyWFuxlJKRFkolvgcjhtJu?=
 =?us-ascii?Q?vGKGh26rGEfpY2c8nj9WEt6O9sULU0G64a0IItcZFhWhZWOvkvkl6oZrCDUe?=
 =?us-ascii?Q?E6WhN9x5bfmuxTqSDMIH+V1Z2J5/O0q85xeRNa+EFBiZm5LTZc7i6J9OqYX3?=
 =?us-ascii?Q?LZANIg+ECFtor9dmlmGMkEtr7NqZBJAQun47p6K1WqphzYksYd0XPNJumghs?=
 =?us-ascii?Q?OySya0xRuVUK9mdY5FdKpmGtHzlSKCBce6zD8VjqoaaDFcdDj0noT6vU7b7d?=
 =?us-ascii?Q?siHfFcBBnT/XlQfGUUXbSMdWdN6WEZm9+457PlI1MBk5At7+Fwtm2JQO0znA?=
 =?us-ascii?Q?KxFkOApQzizKGTP6gS++lKHOzsBgJno8ONveJqR2ST01INBc9gyKT8Sc19Us?=
 =?us-ascii?Q?xjLwR5nNxrttRMGpp4PCgZrf7VUlVZ/JkEHBm1w8JpqU8X6FV0kqjKSR6V+8?=
 =?us-ascii?Q?G0/ir7WEFobU1RXehwBIE6HHcrMfG1z/7NzC6UaTRI1KIDFXcD/7baX68LyC?=
 =?us-ascii?Q?QgZOjojR9fYjjWK6om4eJuPHtxljqqerqHdoeZblpqG5CulhpiCMgjk8Cv0n?=
 =?us-ascii?Q?lT/siegHliF3aZFYX9177KZz+23eUR61NbiFhXxsYqvKIPLeCiK30bmBH9FW?=
 =?us-ascii?Q?nYkuo1SJg4shPnAZM7ERCv+lOeuW2WMPOGCATzZBh4lkMDzjvZVFH0dAiOYh?=
 =?us-ascii?Q?P6TH6x3fvHhNZ1slpCQwDRTAqzr/lbmiYOUCmWEtu0jR78kx7DVXeWV00Dxi?=
 =?us-ascii?Q?KZzpOaQsq8aZkq7aJ31sDTAWFqZye6RSsf1f1dMN/EGH0W2tir5t0oTRKOZG?=
 =?us-ascii?Q?KODVzihpjkmNjLqJDfECrXwFpcM67LCfra+/HzYiSF15JjuvxRJvrb4r2myp?=
 =?us-ascii?Q?kl2IKgDtuurzt2VQFtgY6YRekGSvfWTJ9cUkhIOMRlqgPFBNMMKWy/tb0jBz?=
 =?us-ascii?Q?Y8qbdgzsgHxd3ty40oyVMYGETBoFTIt2CFUv6Ryua9+9BlSozz82zXz1iX+J?=
 =?us-ascii?Q?bCfbNs9v0HGaRl3JJc20irXVBwtLC8m5tCHAkJEK1Eu8kbpfZHJGbEXSBGr9?=
 =?us-ascii?Q?b/kb0Fm+UARpjNiFeP2YUHpUs4FHzqLP0Dp5chwHFCQQ6lLVwjvpv/uomxQT?=
 =?us-ascii?Q?xbW7ANostZyTlolYE1fptMaRfwl9CRzyfDAjhe61RDrsyPtB3GFF86EeIJca?=
 =?us-ascii?Q?8rfdcfDC18suzg2V3KtP0VZd2lFvauBUQVV1y2gxFsQ8wOvyRk3W59cRj92f?=
 =?us-ascii?Q?yNMnGpm0cyLbqHB9+5STe03ErA0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:24.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7698e4d1-5495-4421-6ae0-08de54a07fee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save and restore CXL DVSEC control registers across reset with
CONFIG_LOCK handling so RWL fields are preserved when locked. This
maintains device policy and capability state across cxl_reset while
avoiding writes to locked fields.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 include/cxl/pci.h |  15 +++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5d2bb4431de3..9a9fab60f1e8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1161,6 +1161,113 @@ static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
 	return 0;
 }

+/*
+ * CXL DVSEC register save/restore
+ */
+static int cxl_save_dvsec_state(struct pci_dev *pdev,
+				struct cxl_type2_saved_state *state, int dvsec)
+{
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+				  &state->dvsec_ctrl);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				  &state->dvsec_ctrl2);
+	return rc;
+}
+
+static int cxl_restore_dvsec_state(struct pci_dev *pdev,
+				   const struct cxl_type2_saved_state *state,
+				   int dvsec, bool config_locked)
+{
+	int rc;
+	u16 val_to_restore;
+
+	if (config_locked) {
+		u16 current_val;
+
+		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+					  &current_val);
+		if (rc)
+			return rc;
+
+		val_to_restore = (current_val & CXL_DVSEC_CTRL_RWL_MASK) |
+				 (state->dvsec_ctrl & ~CXL_DVSEC_CTRL_RWL_MASK);
+	} else {
+		val_to_restore = state->dvsec_ctrl;
+	}
+
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+				   val_to_restore);
+	if (rc)
+		return rc;
+
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				   state->dvsec_ctrl2);
+	return rc;
+}
+
+/**
+ * cxl_config_save_state - Save CXL configuration state
+ * @pdev: PCI device
+ * @state: Structure to store saved state
+ *
+ * Saves CXL DVSEC state before reset.
+ */
+int cxl_config_save_state(struct pci_dev *pdev,
+			  struct cxl_type2_saved_state *state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	int dvsec;
+
+	if (!cxlds || !state)
+		return -EINVAL;
+
+	memset(state, 0, sizeof(*state));
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	return cxl_save_dvsec_state(pdev, state, dvsec);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
+
+/**
+ * cxl_config_restore_state - Restore CXL configuration state
+ * @pdev: PCI device
+ * @state: Previously saved state
+ *
+ * Restores CXL DVSEC state after reset.
+ */
+int cxl_config_restore_state(struct pci_dev *pdev,
+			     const struct cxl_type2_saved_state *state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	bool config_locked;
+	int rc, dvsec;
+	u16 lock_reg;
+
+	if (!cxlds || !state)
+		return -EINVAL;
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_LOCK_OFFSET, &lock_reg);
+	if (rc)
+		return rc;
+
+	config_locked = !!(lock_reg & CXL_DVSEC_LOCK_CONFIG_LOCK);
+
+	return cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_config_restore_state, "CXL");
+
 static int cxl_check_region_driver_bound(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 71d8de5de948..2c629ded73cc 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,18 @@
 #ifndef __CXL_ACCEL_PCI_H
 #define __CXL_ACCEL_PCI_H

+/* CXL Type 2 device state for save/restore across reset */
+struct cxl_type2_saved_state {
+	/* DVSEC registers */
+	u16 dvsec_ctrl;
+	u16 dvsec_ctrl2;
+};
+
+int cxl_config_save_state(struct pci_dev *pdev,
+			  struct cxl_type2_saved_state *state);
+int cxl_config_restore_state(struct pci_dev *pdev,
+			     const struct cxl_type2_saved_state *state);
+
 /*
  * See section 8.1 Configuration Space Registers in the CXL 2.0
  * Specification. Names are taken straight from the specification with "CXL" and
@@ -23,6 +35,7 @@
 #define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define     CXL_DVSEC_CTRL_RWL_MASK	0x5FED
 #define   CXL_DVSEC_CTRL2_OFFSET	0x10
 #define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
 #define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
@@ -32,6 +45,8 @@
 #define     CXL_DVSEC_CACHE_INVALID	BIT(0)
 #define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
 #define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
+#define   CXL_DVSEC_LOCK_OFFSET		0x14
+#define     CXL_DVSEC_LOCK_CONFIG_LOCK	BIT(0)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
--
2.34.1


