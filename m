Return-Path: <linux-pci+bounces-20127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DAA16454
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 23:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2E41885308
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2E1DFE39;
	Sun, 19 Jan 2025 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtZ8CsVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9421DFE17;
	Sun, 19 Jan 2025 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737326603; cv=fail; b=p+P9PnIk/D7XnnzzpDYybtmKeh0jlMCAY8NDQgWKXjShv4jFJv+Z74AAbNl/LAp/5lyn3TK4cQjrI+QRc3bqzDOzi51RNw/lMX44oDhHGID4KIxulXKDzaQZ9/hUUFu/dRRLyE5TWcrc/Q0Qb6ohIC98r7sVRNnDNOnduSJyqY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737326603; c=relaxed/simple;
	bh=7gEMO1KAAqzR73R4UfGeKAjtEYqaafrN4pjIVyTWRJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZN6v1IowZ5IgPWuIG6w3xK0aa09Q/osOFkpH7hGKrDNTjO57M+UXCl5F04VXO/+SAL/rfpEB2woMWRHX4WV2hlqmajZSasrwRp/Fa+Ye023Ok0T1GTR7+stcsWR5Sod/8o6s97jh+ColZtXP1WC7FdsuV+1ZL3gprZwlSKus9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtZ8CsVH; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKJY9nY2/fS75g8GTgtc5OXGay/I7UMCFkF/wY4jTG9qyCshU2D9nMIPGlzo0CytYJwVhEGyUH/0I2qMEhKArMKNQqxUnfqvwXvlj1PMLaOj5DWbP6cPWqLTVQXh+Gpq01u6T09jslw9XHU0jDlYDkInx9hXe8h1mRYYRpx3/FqYPGIqy6YhfuE1b8bgrUS8FysSfbV7zqIX89S6qfBP6DTuga1anqV5p1Gf0dHynE3CM2KOSBMYCSP4tbABqptEIHJxRTbzReispT0lwm+ZVefm2BVirk541mAnv3G+z0KoEy2EqKvNGTDBJ70uMZanQue0E0FOTMs28KzpjbhOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct/ANPqcwqDPf/8xhmPrECuk/Jgbn0oSPDPogabJwKI=;
 b=cA0RzzNi8XASrjJ9hY5v72IMrqETiiZLTMXRn++CS3oJe2oL9DY5BKCr48rSAkrAZG7pRx1eWXzrI0BP6U77xsI3T44uf2sHdRYyqMfZFELVdqhZ/8xwG6fPtZQXym9VyIxpYl0QeGPvIyydLqfQ5n4Jimx//aCuHmRQktmNhwTOwGpE+pFZlQ7AGO2/quvj10tDLTMUJBcSOigfDgvILhpmjUqXYT81zh9DrJxNxOVRaaWtRSwILAHFDOQTBskz4/aP8PxtCL+fJa1Zfpsc+fzKfZBSQv2lQRjoxbDnwCFLWrVpaNxPrN/AeLlKwpTypNXNyYGkPrX+dxVvkL1cwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct/ANPqcwqDPf/8xhmPrECuk/Jgbn0oSPDPogabJwKI=;
 b=PtZ8CsVHWMhGkgChR1GnjCrAKYo/C0Q0r1m/1FWnz2d3hWcqY407fUi62zouMM6XFvFmWFNcUq+1o/MTDc7oPN8rOk1ZhzO5dFAmhQgcOmwRCK1Dj3f4949QkSlQXw+E8jSmFq0d/EPWhcKlfhPi65VSNWBqXWoi9Yd40OWng5w=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sun, 19 Jan
 2025 22:43:17 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::bb) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Sun,
 19 Jan 2025 22:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 19 Jan 2025 22:43:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:16 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 19 Jan 2025 16:43:13 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v7 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Mon, 20 Jan 2025 04:13:03 +0530
Message-ID: <20250119224305.4016221-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
References: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4a5f5f-0d73-4d1a-9a70-08dd38daaac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lDYAPKsSmOcQhx5wkuQlRM3xDrf39WzkZoCI9ZARBdwENSL2cwBsPV5wZn0f?=
 =?us-ascii?Q?9AIwGNXBgXhBjPtBdS7H/sgSsY63tHoXcMeDd3A8kMzC8FLK55rK+s+D3WYQ?=
 =?us-ascii?Q?JKkBxMGBTOgkUcq+f8vDfhnpXWzW/Kty/mqVhO64/lJas0enIrF1qMawBWUe?=
 =?us-ascii?Q?x0WrmjyLqqb+1AqjIllBMCbSycF3NUnXuUzsFmK+Dv31m8dOEVXzjg3pAJ57?=
 =?us-ascii?Q?NKWvEEiRU7AUgZjEwYVhPlUbkDr2X9nDyYGk+cdcKTngMQWd7Tw/dNYTK4OF?=
 =?us-ascii?Q?NuLjbehwq+dRryvkRQzZvDz7ErjMxDZ+ir/8DqORCht74FnkCRNy3d9M8IgY?=
 =?us-ascii?Q?bZc0ZFRVAPJ9UgMjT0MIgblfE0fSlCaj1+xSa7JtFtaPK9x0uHJ2Mub/zjA9?=
 =?us-ascii?Q?o9YaVR4KRqFDxre2/VkJ0xzlldp8ScWArTtGKO0WcSzSrzshUsVQw0IdDKZS?=
 =?us-ascii?Q?EhHy4fstdr908oGd9ZgavhUmZe90Uzq+QN8+c24V4MmExT5+Zs7su6ZHI48c?=
 =?us-ascii?Q?58RbMOh1kMdfmtQzQ+fzUDNOAciMk5sXRDvTJEwBmMIUmbcZlui84M2uR02D?=
 =?us-ascii?Q?TK3Tfnne7vv2KKkOpKBllP0ytfOstNvdlm5o4VZ+Junm9T5gbbg4Du7sa7oT?=
 =?us-ascii?Q?OriMygCLPN53dKPtfnxWRv2VL98EH44BMy+u3HsvzjNAAviaaCn9kr7xMDW9?=
 =?us-ascii?Q?CZEMEID0spQ5Ia7FCK7BCjlwW+WAmrrcRaZ/xASP6AoJkUzMtAhPu3hEdF83?=
 =?us-ascii?Q?MLIH0H8+FHOqStnidjA3h61Ckgt+g5EGBs4xmxhvAbxE/Esv9+R60f8bua+4?=
 =?us-ascii?Q?bdpwbOOXwUoSfTKsXuA3lqZEDEdVs6BBfyCdPKIjifbaSpVGoY9crfuee611?=
 =?us-ascii?Q?/mXm+kIbDuH1KOMKfueM9Z5GlOhWvORlXjcSAJQ6e+rp7nCPdAMKWRCAK2zF?=
 =?us-ascii?Q?VtjfGt3QsOavlBwtvs5hsmK5z/0HFJ2ji2k4DnkdIRnzpjubK7keqIItpd5j?=
 =?us-ascii?Q?Ozf+9/fe/CbKosTd7uErPmiL/ADWnR16wJ/G++r7w7ULqmf0ilJXbl9Eg3zK?=
 =?us-ascii?Q?EsyJbzndADXYDrfkmFFvrgKCTcTvfqbT+YXmyOVUnq9t5CRfBBbFaOhnnztX?=
 =?us-ascii?Q?KujpFKg0ltP0FibNJtITNUiQbz6eev59G2TWxvz6BKL/RkE9X7YG1uL2XkYg?=
 =?us-ascii?Q?lLHcXUsDelM9S9gZayNK7gykYQ+PhEtAdn8FuCRPymHekRJT/4FVRLPrJJet?=
 =?us-ascii?Q?SjSVFqmI3o0FGYcpzJCTboxj0Snv8f3FmCBGbmbX7F8cAB4TPSKvff7VROaN?=
 =?us-ascii?Q?6l7F3201ec9fOCQoZ3D9FAK4ue/FsxaGav/QZ2QYt0cFltYe5CcnGMNAIcL7?=
 =?us-ascii?Q?59OWhODFiaoBEsUwnAF017fiN2uOcjs0TdztcQA0Kzs9zIzQKXnlwv5yERaD?=
 =?us-ascii?Q?qRiYtyzo7/kQmO2eGs0Wk/gc58hVD4lcm8HzsJJC50r9Sl6vH0ZVJl3fUG/W?=
 =?us-ascii?Q?poFcCELtJPot2rQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 22:43:17.4381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4a5f5f-0d73-4d1a-9a70-08dd38daaac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
Changes in v6:
-------------
-Modify slcr constant
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 205326fb2d75..fdecfe6ad5f1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: slcr
     allOf:
       - contains:
           const: dbi
-- 
2.34.1


