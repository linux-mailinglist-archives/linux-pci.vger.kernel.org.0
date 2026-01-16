Return-Path: <linux-pci+bounces-45004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9ED29A99
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898383069D64
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F39334C3B;
	Fri, 16 Jan 2026 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZEz8qwzB"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B778325738;
	Fri, 16 Jan 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527744; cv=fail; b=AwVrrUO7vMLRXOLkzduG8t2RQh/Kxdun2kpRbqdDN2r7MFEYdhg4fGoigg7jyrBSSUXddHpZ5W3gAFwckjeRpDz8livekT0O5MougyZ7zT1/7twa9+SE+RNz7CZ25MA4lYdjQJoLCA8f7v9S9fIC2WXAySubUFhW/02seqZkZT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527744; c=relaxed/simple;
	bh=x/Tik72q4ReX3zocXAJtcFoqwRW6yR5TSpefQQTiH7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNNfE66mBcepv6bWdvEl6dA9iTq8p/VNIJCXMlMFD24B1hjOOWOlaWTiTBe1uRoRt5ScnVrXnCADpZT6pPbO2j2vS2PfcS7IE/BTO6idiSCv5snzGNxH3K7zxnhF9FyRMM0nIjD2EdjbiJu3KvEb2f1jl3RTAY0IqHWxiIuFb68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZEz8qwzB; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aql+LOLOUPqvSLhM1UmsZrJFktp5Cjl+M3lR14FRDfQ/4A7NNlJkSPRRG2b7iaERu1DPWdLnMygupOUPL/qbpybY/wyCe519HodbjAARVkZonk9CUH+JVS8D+SvlRJABVnD1VPMV8TtwjcKeP8zWtVc5U9/jLlNXw99iOk2+RBIyjcinPCcKndgcVh3aaT4cIz/PlLMFGMv9x6EPOFKH490DQU+S5e+ryXDHf6YZogax45/KK/HSjstXFztI5kHcJI7RnJSr8698TOnFvE3/2A3XSghJjDtPwD5405QBGetEgpRD0eNT+gLzEGEDxwqmS6jPKbxuZfL0VAm4AjaymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFEXGCpwMgTLiML+OSjb9F5+X7WIyqzkEejI2jEOTnY=;
 b=LiQp/FCJDyDDOyFiHmsuv9n66D3ddFPE0hLF2bHelMDhUgw67OPK+mvrZzPHWRjZvlkpxHehBTMH9F9nyCE9ZCWhBOp+AxEUedMAhUxVYuHQ25D0B22vl5PIab49mQfXRL8nzZWGdQj0nO23efm3yFApdaUVDe3NoTtH3MOUOx3DCH9rtNyFXd0eDitXgmke5z1HS7mnJ1R95VNKh/tb6ZHALWnPAYjgQfQhicnoICQ3GmSyKBFML2XAem4CH0JWjumwuwTLRIhoHAR2XvOr4J9JAUFudXhaqr/WbxIIjw8lZ0wtH+Pb7+KEJqZSMgfbkkb0ejdNiVghto/adfMHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFEXGCpwMgTLiML+OSjb9F5+X7WIyqzkEejI2jEOTnY=;
 b=ZEz8qwzBHW9kCydHk8XjlQ0fUpD49JNcShovadpOBEUBLQ8NegmXeSWqPE9iJVBiPfiPPWfoLCGCn0acTRS3QXhSaptJzrEjH5HMXsALB8XX03v7qlGa8hcRrUhRyjadK8xKMlMAn9Vz41A/RZqqgZ7eG4qabXBSBRHRefQIJbqfeuC3iZW6PDoZ06G8aUThciM9DRYiu5H+bdArnjeRPL8c4qea6mgrnIvSIQbkeg+i1utHkxxW8KoIw78hYZDmM30/XeWcD6EvEuVUm8C2CDTrA5IiUW6D6uQ9ZDFhV0v4PtdUv3LFrYUhYlJ9TejFe8aPdLEulMSvntCIEl+/LQ==
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 01:42:12 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::6) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:59 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:41:58 -0800
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
	<jsequeira@nvidia.com>, Srirangan Madhavan <smsadhavan@nvidia.com>
Subject: [PATCH v3 4/10] PCI: add CXL reset method
Date: Fri, 16 Jan 2026 01:41:40 +0000
Message-ID: <20260116014146.2149236-5-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9e0fb7-fbe5-4273-57e0-08de54a0783c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2bcNyMOLr47LqwAVLFDTOQDs9U9OZSOLW/CFubNxGAqwEOs/k2NiEil/rUzC?=
 =?us-ascii?Q?svvgoal/W4NOwIt53JnsWvcvwShOJOLvkwKuw70O8va0pSB76tZJeRgpqUyg?=
 =?us-ascii?Q?SQiROMmCXcbH3FTUG2I0FGoFrO96sH1ftq/tv4R4jgB8+QRbi55otWe3GM5y?=
 =?us-ascii?Q?+A+Ez6vh+loVE95fJNckdYGBCT5eIfBMcCeeaX0R1UEE97Ot+YsIDFR9ws5x?=
 =?us-ascii?Q?eUFeDCk6Xir/7xE8bQ/DKi5ck4b/0BsSTYKH8Pn8ttYjqd09zdvv6NNuAclN?=
 =?us-ascii?Q?diRzZ0JBUmpM+KF2oLwpARl0IupkAvR1OC/WWBuIKCuNrjiX5GdRiww26lod?=
 =?us-ascii?Q?nor8OAqGyhRtAAmWK9T9/567uHoq4CqdX/rDNVA5ilFOvsMXrM4fHcsbMkBc?=
 =?us-ascii?Q?424qkvFqSEs6m/cSvGpGxte6D1rSJWfSR+on/yaELfHR1d8cQx0IwpQNlwq6?=
 =?us-ascii?Q?mCEmy20luCRJeGujjeOD1cLAKNvX3P3G75dFjMR1iTwa0jpXb5TvjG7VHBqQ?=
 =?us-ascii?Q?XT9Epdd2IqLhuwdaIBvwhqZgQPJXI/m1QorEHUNItvKtdhIwPmqKIvNQwoii?=
 =?us-ascii?Q?oEojOk7VC1mMK8sut9/rr9BBUPu7tZkpWk945hoV4MJBXgqTK/wVYTC/hb0Z?=
 =?us-ascii?Q?rHONQDSqJ/OTUyzTfC6LahLxSrsF1XY/FKhoLD5EnHlM0FzZ0WJkVy2WPJA7?=
 =?us-ascii?Q?xRLYnqYzYhLqgH1SV5j25ftXBK4l12gectcqinXsdiKSdptpIFwnNhDIxGos?=
 =?us-ascii?Q?xhxmuWAAyEz++/Zn9I1OihgV2Vk1yyuyG2kG8bipEqK41ASaB9xvZQCadtTm?=
 =?us-ascii?Q?ZxuVoxObRE+s9EkI+2sitU2DrhyFo5qwPwVTJ3JhPHP3dVZdVKwmyMifpkO/?=
 =?us-ascii?Q?53UiGtfGKcncCqqxTw+hN3oyFwt3lzrDP8yJQumVFdQ0p26PgmK66OkA6sLs?=
 =?us-ascii?Q?VB3tFDRBTJirTQixGYju0bu6SRwBcIey3lwF15pXRFCkVs/kCVAWg9EDoqgI?=
 =?us-ascii?Q?0vE5A8JOJoIX9fiwtnvFTd/P98kVksjiXy1TGoHyyvQ5a/V9RkHCp+Qj1Y8m?=
 =?us-ascii?Q?03F+pt0n2DEowS51InSCdome4pA+FvECsdOAv1LP5rHIlFoFvxY+PixfxJdN?=
 =?us-ascii?Q?63JfuR5/dwVp+Id8L80PHwzx9RBWWBINZeACiOx0SWrY8dOmPP9EMJd/mzEw?=
 =?us-ascii?Q?zFpkjrZ+Pxp11mNEhdCcrCmeEIAb7tgRPmVz9lhDGC1Yj5ICs/bEjQzwIvdK?=
 =?us-ascii?Q?o/3qMI2vaS7fZg4OV/eKYzehj+b/FCegejZpSKVp83hBCVdIzJ1vZf8/TMLT?=
 =?us-ascii?Q?H8cgq78p5b83CE0QAiw4L6A1QrF6aNOdbQi+tPTh73EVhdQIONCyqldY6MAQ?=
 =?us-ascii?Q?JHmLlNSKad5WsVnJUnu+4tnB7i92QH848LJ7mWs2/wJ4msdHAfG2hE1bKdxo?=
 =?us-ascii?Q?zTPE6qTIxGhNXACELVR11a/5OYAQYSQKn8Epf0v+Na4UopbIgMgESenLgo6+?=
 =?us-ascii?Q?wSJKM6+I47NJARdDXKmo8hkZ1Vk0ej869Kt2vRpVLnDHTlF3csj70P8/4MiE?=
 =?us-ascii?Q?KFCBeLgpOo4BkYZ6AtHSolU1AjlI67vNUqF64XGaufbkkOVmwwul2kfv6g5C?=
 =?us-ascii?Q?Idov3tZdefpom1d+ULzSFQleahZgTcEgwh7soi4+aV1I9foYkOozWx1oYvU8?=
 =?us-ascii?Q?/I+q+p9MkBepAUnImuykE7kmzlk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:12.0106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9e0fb7-fbe5-4273-57e0-08de54a0783c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add a PCI reset method "cxl_reset" that drives the CXL reset sequence using
DVSEC controls and timeout encoding. The method is restricted to
Type 2 devices, limiting the scope of the changes.

Signed-off-by: Srirangan Madhavan <smsadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |   3 +-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8bb07e253646..b3eb82b21c35 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4892,6 +4892,105 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }

+static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
+{
+	/*
+	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
+	 * under section 8.1.3.1 DVSEC CXL Capability.
+	 */
+	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
+	u16 reg;
+	u32 timeout_ms;
+	int rc, ind;
+
+	/* Check if CXL Reset MEM CLR is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
+		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+					  &reg);
+		if (rc)
+			return rc;
+
+		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
+		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+	}
+
+	/* Read timeout value. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
+	timeout_ms = reset_timeouts_ms[ind];
+
+	/* Write reset config. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	reg |= CXL_DVSEC_INIT_CXL_RESET;
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	/* Wait till timeout and then check reset status is complete. */
+	msleep(timeout_ms);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
+	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
+		return -ETIMEDOUT;
+
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	reg &= (~CXL_DVSEC_DISABLE_CACHING);
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	return 0;
+}
+
+/**
+ * cxl_reset - initiate a cxl reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a cxl reset on @dev.
+ */
+static int cxl_reset(struct pci_dev *dev, bool probe)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	/* Check if CXL Reset is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
+		return -ENOTTY;
+
+	/*
+	 * Expose CXL reset for Type 2 devices.
+	 */
+	if (!cxl_is_type2_device(dev))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
+
+	return cxl_reset_init(dev, dvsec);
+}
+
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
@@ -5016,6 +5115,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..056eff0b1e86 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)

 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9

 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
@@ -1464,6 +1464,7 @@ int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,

 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
+bool cxl_is_type2_device(struct pci_dev *dev);
 void pci_ignore_hotplug(struct pci_dev *dev);
 struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
 int pci_status_get_and_clear_errors(struct pci_dev *pdev);
--
2.34.1


