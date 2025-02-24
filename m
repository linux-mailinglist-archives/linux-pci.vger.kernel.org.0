Return-Path: <linux-pci+bounces-22231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0076A42708
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16785188EE79
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51760261371;
	Mon, 24 Feb 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rXW93wew"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DC26157A;
	Mon, 24 Feb 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412248; cv=fail; b=nPSnJA3JRqggrwVO8gsOF0EN0SG6RWj60UPe1nNeJWSZkL+PATCoJ980l3GCIP0IdZAElU8zQxsu5pYa3ZWle8Ih9yPRd6h3GJuVWkaThB0GavpQmUWPKg7b+gxbA/tpw3CLA7ejGDGsGnEphrG3al8Enw8PvlS/EvuvylL1Z5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412248; c=relaxed/simple;
	bh=yKYPPxGuNopiJX972gaVEzZZD5L3YwPgsCWXktV4VUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgV/++TCMb5xY9BYD4pJsq1F5J5eP2y8bNkWBaTsXkluvcCeoLhqGb/F9xbJYiiItBsCkN4Z29aohiBZOXsHsP5kJwHznyxceSN9aQBr5fAJIqoFIKmnJ7KYeym+Woia+hLarbwLK8BV9Wy2N07oJKBSveQMdD6+QozgmaXy2BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rXW93wew; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGV6xOmn9CXlbGzGVUncQZye4qxG4slpTerZY71jubb8C4ErYyp+6EH71j0+m63NwhM0sjfXpK0JliD9bfCg0L8NItq61haKlfdCujO9T3bKTHTSmIAcEtgYj4WYI+07iiRxjpFWFemykyWM11RmfC+cc6jBJci6zeX6ijDKg3RgAaGwEqInZCmMxcFJqRLiDzRvZEvks6RfPqWAARmBoWtTU3WAw5TaeYEaEUGZpmdmh0dMLpQuT63EuNm408R7jK5ehd2eRYc090iAMFq4EJwEuD2RSi+QSwB1DO2gjRAQvTRnD2nuBLAtCKf24b63NjDrVQzFKCbRlsO0jiktpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS6vKUjNrwzBwmBLAOIseFiGCw82kPWhNVktwvX/eGo=;
 b=Mn6kNpSFu/mvRRZB40n9011jSdGadqmEO0c2EFvvVmeZzmpEsdiyksNL3xVWfdBr6Te/wcfE+RG/7rKCGMq2UVgQLD0XWRbvAL+HRN1NA/oSlF95NppP66ELhJq35wksJ5V0swWBmOR9mvq7OKRcJeX6/big4e1rPT6dbPaVL/U9szroJ4xvkZ0m/6DzuN6fo577E8jTiw35Lkx0Lzq9ceVF6kNMc2LyJdya1S2YZDsw1EvW2IP/lCmCGQ62w+TcOBWCNX8S5aY9EPUol+n/vNnzzpXnBjIWz70B3Q+ehV0oosuw6s/AtmZmZSY+S/HDtwZw/+EmUEJF4pBmdLoXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS6vKUjNrwzBwmBLAOIseFiGCw82kPWhNVktwvX/eGo=;
 b=rXW93wew2cRgt2q+EL2y3y6zM86NLPKjYZ9NgHEfqIDPCQkavyEyB1ijDFqbc3msLk2DwsOVNmqBP8LK6siHycc589sZS7Lu2wA9+AAPcCP//T7TBF7OMhhB8a6Czwqfib9lRjRZSyBt2BQwr7OJVSU3kZ4Yqe/fDdcoIZnX58U=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 15:50:39 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::6e) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 15:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 15:50:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:50:38 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 09:50:34 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
Date: Mon, 24 Feb 2025 21:20:23 +0530
Message-ID: <20250224155025.782179-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c9859a-cc51-4826-3720-08dd54eafc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxYK6x8z2fcK7Iro41Tbg+6u+9bmQ7iO6ykYrAUtx+2XGmR0KfDaryDLA/BI?=
 =?us-ascii?Q?jtTknL+cpjzTOPTH889cN6beyexGv1Ndsurak6iaYbf2RzOpg3UHsjY+SB3o?=
 =?us-ascii?Q?zFT4TBh6B8YvVR09owbHdNLGQkV1O0vJAZCkxioG6IW7JO8kLY0c5kK31i40?=
 =?us-ascii?Q?vHdq8MtcvyzxkhbYn/UHf9CrfV0banChv8+fNlmf9ewyL2ykw5Cmnlbf0X5n?=
 =?us-ascii?Q?4lvD8S9sC8+SXqKa7tVgXcQn91tK0YPoQipTdMj+DU39LBgu7hcDtsz5MZ2O?=
 =?us-ascii?Q?qOpiYcrTXjhoppl8H/hLWX5U8BdCjlrAIacn6q7tEVAEZ1E4QLcFieGS+Jzc?=
 =?us-ascii?Q?S3IRayzlduoEngsm4Qgy7eJDVUkisjRdFBAUbLe6Mpm7kvNXfpo6qWE5vEQt?=
 =?us-ascii?Q?hNRgNlhJyHKkauYu9AC/hA7rdY+OR1r/+RBaXbSnZg7UnKISs5a4znYEueQO?=
 =?us-ascii?Q?fs/zmVVsZy9IAaHLdfFxUtLMrvNZ/0HD8nO9IitgEdE+jHsTR8s/gS7ZL7Hk?=
 =?us-ascii?Q?9OfzietBsLrSfstcLYRIDNArhugQPk6U1ULzPKzA0QO5KMjd9N44WZKkCKmH?=
 =?us-ascii?Q?RShVm6iYOTvMja3ZcCILcAcWGG8ckkHZQA3MHE8Kn285ondpdOnt+D314MyB?=
 =?us-ascii?Q?j0+3JS1OV8uWScuaKdNjc+bWqV2ybazzBQ4PCljCbPdXu1JDLuUK9o44ILbI?=
 =?us-ascii?Q?BdoqDcpr3jpiL0zfjD8O2GhAIfpTGcO5GGzCZCTehO7NV3swwZG/zg7HDy/6?=
 =?us-ascii?Q?kwTuwQcnHG1NecY6EEQyMvBmzahb85J90F5evBaXXroSujTWihAucOpuX8US?=
 =?us-ascii?Q?cmpi4KSIwlGaybIS8YD4qTQESdFF6mIGQ+62H2zIlUDlTpKFpfVIHByVan0E?=
 =?us-ascii?Q?jUUW9R3+lh0rCtq8kmM8kID8zDYSFZDL60E3VkO3ZAY0Wq7jzwfu4ixMff+g?=
 =?us-ascii?Q?VXiGmgBDQTWYJkLMpGzjh8v9XYufxBoRR808RJsfWn7WYSjZYMKN2FP/qRN8?=
 =?us-ascii?Q?24exYiUDLs8GFZVuC/KDxvBaeuz7Mq28vncSjgOQuGUhGI3EvwnU2acMu3fA?=
 =?us-ascii?Q?r9jF5aqNrwSoVo2jMrLixTVidqVzhBON09sIRfoRRdzwswgZcyRpCXTbOGzB?=
 =?us-ascii?Q?ypX/77/wu7Sho38rD2P1nKSz9vjjPifkF+pQuPJ2h6IcP6Yx6HLmsZdf+CBZ?=
 =?us-ascii?Q?Hzamo/d6t2TE/uzQ7Ww4CEDODREWVNkBGwLDw0Uf3qpve2eVVHaJdURlRFIl?=
 =?us-ascii?Q?PFVg6luSlaKG2GgccGlBP72aNjz3asfmlMyWkv6WtPzXHxE1w/sqd4QZ27dG?=
 =?us-ascii?Q?sxfRh2Tf0rfKvEbhhWnhwFlElJwy2vf599D7Uh6IuxnssD2YoTtwuatY414g?=
 =?us-ascii?Q?hNqp++IH/UmdgmeEdMG7DjMoGpjwZYrWBKgK2Xs8+DhIqd2gbvPr7jdiDtx+?=
 =?us-ascii?Q?TgUAySg0/Pl3l2zOA/hoPxRPIdjJsdVwcbpNI+EsjtjyEWh/vGtCRKdeN2Oo?=
 =?us-ascii?Q?PNo0Fvc0xCPAYIs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:50:39.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c9859a-cc51-4826-3720-08dd54eafc71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
Next-Generation compact (CPM5NC) block which supports Root Port
controller functionality at Gen5 speed.

Error interrupts are handled CPM5NC specific interrupt line and
INTx interrupt is not support.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Update commit message to INTx
Changes in v3:
- None
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index b63a759ec2d7..d674a24c8ccc 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -18,6 +18,7 @@ properties:
       - xlnx,versal-cpm-host-1.00
       - xlnx,versal-cpm5-host
       - xlnx,versal-cpm5-host1
+      - xlnx,versal-cpm5nc-host
 
   reg:
     items:
-- 
2.43.0


