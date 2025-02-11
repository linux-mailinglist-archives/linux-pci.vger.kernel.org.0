Return-Path: <linux-pci+bounces-21140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5CA303B5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B95162449
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7A1E9B3D;
	Tue, 11 Feb 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XqILzl/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B31E9B25;
	Tue, 11 Feb 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255950; cv=fail; b=ucaF2YwGYJOBTus7+qgKUxuc+ecZtyIzUbXmgFTuotf56oyfpr7cAQA8xAB1rQ0nkvm8om9GQxkamRj+pWxQwzHdCkJeCzUeanGqQLKCz1XW7OqdhB2J1MHhbnWdAkl/1GQ1bWsC+S9IOFAaea6e9cY8cmDdZX6crkwvl/8QkCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255950; c=relaxed/simple;
	bh=5Fd4TF3sj92GYjpg8MYn18J8WHvD957aeMdwJ+7spBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDxGZQyPZRlgUdr0XvX1EZ/DzaHImdtkxa+q3914+lyyVXNOUM+L/Mc1tkffr15TXnPtz+6dmeILZxd6sI7hsEKKbDqXYzHKbZQ0D3kxTp4qfwsTqnMXd2biY6DS3kXH2jFgMt+Dj8eHYgJ8PnCRPOfz11NJEeaNnLgT7IHrqok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XqILzl/f; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S82kiZAtyhKyXDIcA0XGouEzbwXb9q0f6CvqVveW/xAfZm7Bw2j1a72A9KeLhAGv2fxns4N1tLHg0jE+hBKiPb+rXtPD0CIk8YkG5riPn7PVjqSavwRqB8YED38Ovl2hQeM3hjFjIcCwdK1iKOYoyuuy604QtjvCHQk4uhYD22FwVp7Mdg+oQA5zkPGbDgukllZNZgca3Lajtej7AXTbx651PkQVUWYnlLXSB/iEkPaz0RKNNLxtQ+YRC37jmVhTScyIZgHzFPW39KhVIfdtzcYag4CIcMy3EX3Z0R74WJBfMuBwqXYIDlNAdCGasb7atfJQ5XEKmfo8nuhNmuvodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmuiMExSuLi857K93Wzl2hGnv/r3L2sbz3CADuHqcww=;
 b=o1YjDTpg77+sJ6SEwqbb0lb1/dmW6xbwLq1mRhSBvJudi8RmcxtI0yTDVhX7tT8fWSqX2wk2kBuklyrAGuK4WaoArXi67TxTHamYba1QHwgUsjnr5TbxAJlixBW5JeKIzpAmN7t8npo72FNXO7NECFlE7JGrmFO19iDJz6pWU9dYs8oLt0htMNahFVlET1cZO+UEwx0ogqSNhG606x38dbOYJVwzz+d8QWDKvFYMwP8/hTcDtNMGIJwKSAu/VnBYSaJNazhalRRrSoEP+E01ZzOdG8eAiVQCO8hJ/561nxYhGtvcpx+xWxNj9edOb/g2/SZv2vTvQkliAidV8xpWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmuiMExSuLi857K93Wzl2hGnv/r3L2sbz3CADuHqcww=;
 b=XqILzl/fiVZIGUeloHfdXRdhBDUUhDSEq9cFM3yfncujrjMvg55aPF3MC42Fm48t/hMYwDti7vyd06m0SAyI+WQmUhCJzZrJRjrsKDbYGKqTnWiWCZCTLQFIMqflahCcj5ie4IA1VxqIrucwUdfWgwHo75EEt27xlD5gN+rgxjw=
Received: from PH0PR07CA0089.namprd07.prod.outlook.com (2603:10b6:510:f::34)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 11 Feb
 2025 06:39:05 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::52) by PH0PR07CA0089.outlook.office365.com
 (2603:10b6:510:f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Tue, 11 Feb 2025 06:39:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:39:02 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 00:38:59 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v10 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Tue, 11 Feb 2025 12:08:49 +0530
Message-ID: <20250211063852.319566-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
References: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cff9221-0f06-4feb-104c-08dd4a66c7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbfhlHMoJ4wZdHlync3cIrnK80A/9XRNfVlwOmCaAgCagPKp/83qKgcKIVBn?=
 =?us-ascii?Q?0eCKlGZX5unJbxobEJy2KUjZFt5e/24PeZvEazndxd+msPcdUpKxjrXDX75P?=
 =?us-ascii?Q?jN8bSf+Z2223fQFpTcKabys33XuGx9PMe0+xqzZwYFXvrqyIlyvSsVasnBOH?=
 =?us-ascii?Q?ZbHFAIRRiePoOa/o8PjHhrefKO1v2DXwy+uQ6MsHrY7YhJ7egYZ5nIXIC22z?=
 =?us-ascii?Q?3shCsQN65l/rCn1bPbG5H04CCMdl90/WP1RyddkcHGz5Vgco5t/IbtmuEQ18?=
 =?us-ascii?Q?I7jx6WfQTClkE/lDnGVjnGf24EQ6dzPPlQY7lF3LOaQVzjPISQQQ/Lpx/D+4?=
 =?us-ascii?Q?w6qM4+0yMS6DEZXsgSh+0gh58o5h+9XPW1gVolxG8PYoHqalfZ/+fX20hB15?=
 =?us-ascii?Q?Iw+/OY0IHc22sz4uY3M5ebC0UIOvEhnC/hMXuyjpBJICEez4YzsuqhXjVjJj?=
 =?us-ascii?Q?sAuhOR9Tc7eHfbGK3hdTsJ8bA9yl1Czw2Z0cUBvxMCIaz+4lOFWiboK5nTJW?=
 =?us-ascii?Q?K5lxQ73GESxd2UaG9Zlty2LIQPhaTsuk+3iG7NVLYNrW2niEKEOnfKsHXJmK?=
 =?us-ascii?Q?+dTYlyvOa3H7owgeusOOrl8oo9IIIKDbQioVEk+aD/L558s6on6fcN2EE13i?=
 =?us-ascii?Q?do3ZkjVHlQ++6ZaEcnKLG/5ElVHPt5H2OJ6+9rR6u3iXJ2rDh1DBP+sHkVwJ?=
 =?us-ascii?Q?c3DvlbiSg7GEW0e8VPocjEaDxBp7/xKRcj45FphfhXdHMZxAp18DtFft9p+O?=
 =?us-ascii?Q?3Kzpcka0qBiAlFyHUZBv9RAYTSN2leNeqIuC7J8on0CzvWD6n3ajAvCFWwrB?=
 =?us-ascii?Q?Kg46UXYjfvtN5RGQCXk/3XQ4On0xlaL21ah3DcufUtfCDhByhQTiYrXmtFEM?=
 =?us-ascii?Q?eQaSgijevVYJbTW2wxiawOiF29lXjP9uWfQIVE3QQi90HC+Q/Wu/5glczPOD?=
 =?us-ascii?Q?trRWSs2fmkwPomSo8kaxUnb32WSOVf0QRg6MBm5Ft9ihiNf6KVhqNEtibav1?=
 =?us-ascii?Q?vmXPOkaOHfUXvixtqbJPrrrGqAn3UOAlXgrGKB/ABiTGbxcAdP5gbl+cWKFT?=
 =?us-ascii?Q?JpKKZEJ6HrXQBdKX6Z0C4hht5CsyaeLrEgG4amZ7/gIC6pVAT6H8pw5rGXQR?=
 =?us-ascii?Q?0U30MzzD1GRMvnu+beOhw+UOq4vmRat6kqdzBGQYOQ3+A6MibpAcB3xjFrP4?=
 =?us-ascii?Q?fOTEkJMlbWmSS8xSN/1S/sOZ4LBZgU9vHQCCighH8TWDBf9OC9dxRQlHynIY?=
 =?us-ascii?Q?o2dLmt23q3YO6AFCDtGzh4r2RoxIRewFgkexvUXygtKwDM3HS9/6xv3YRcmb?=
 =?us-ascii?Q?SSAdmTckSB0xTUqWwIU3MgnUJckK//KHyqff+z5MShs5CVVAjZ6+uXbMpE9Z?=
 =?us-ascii?Q?k+qw+gYX2nQummaq7t61vXnMGASlqemBNEANk2EyIqopLCZyDeJyRO+AHcge?=
 =?us-ascii?Q?TQqA9bDN6eIH2TdbrzY3Ao7EHRc3wb0LJJ7TGcNQ8COauFyA7/bTNyHA+zCS?=
 =?us-ascii?Q?/FIPJPAk+sMniV0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:39:05.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cff9221-0f06-4feb-104c-08dd4a66c7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.43.0


