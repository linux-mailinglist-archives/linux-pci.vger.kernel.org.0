Return-Path: <linux-pci+bounces-20529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A00A21C4D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE764166DE7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCB186615;
	Wed, 29 Jan 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNGnL7Td"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F71BEF78;
	Wed, 29 Jan 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150252; cv=fail; b=bfjZVkjXS2CtMwevE1NOtLlCg+To+AKY5YztuCnnJvr6JHY5IU57aQTPCtSH7hfNzUxapQzFmggk296a1D8SplL5KQiIXTa042aDEScTh1V0N6211dCeF7V2fhLAdB+M/zppL3G9yscHUz9YHT2OXNEaFn49+IksLX9rBQTevpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150252; c=relaxed/simple;
	bh=mgiOabbj7bXkAkzIpID6CQMJsA+RyzCGvUs5pPVqp4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB925bKJ7FYH5Tq7cbheNCm7ZgyCuYWnL+3A9Mh6PN3oAhNTAuSyE2lfA/TVfgO8i8z/5E6TOv4hio+ZrEXlrkUR8hkcPZd0vS4sS+x1+tDXHFz3H7HEiGRABeiBcPXjjceGCfTysDw09pfJMODyoNpk0tigcR5bb8mvIzXsJxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNGnL7Td; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S903kZcF8VDq6mU8P6WMnY+O9mNoJuva52Thi20Dau54E6YT00ffVrQ+3ISNhUWUzPJ30IdydIdAPbLKzNBv4zmgKsZ6lTQQd1NX61DmQdxOF9s7hqsbGaSf02Ul3QzcH+koE4UzYP7APNQ7v9dnWe04Tap68XC1uYcnOcFkLZjXx8hk6QKYBbQmaZaRElvAVxUq/MUY/uwkPcCczEvCyh+gkOHm4O/5BsP4SUBmgaAVSEiQTMItoXZgGb5IRIJu1sta5e66BpOen25xGm5N6VpcAFVimDaege6ShsNojdJtrMKUQK6UPb69KPIqWQlo2V56y34yMYpxIpCJbJSHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOcbGx+BsFdBghN68Rll5mqVS4CIO0gqOfn/Rj+BXDs=;
 b=Lw+5RMdlAmhXYgEVo1c2XBJjHQmTvdtLn4OgaCW1IFQ/fpKP4+2Ng5M/FIznHYnBzQnfCqW7BlFYO769X8/tsxYJvmo/qh8rr2v03BTfxuFtZOjHFmEOalfutLWt/F/1xyGrWdsYRDH5MbbRrI+tAgmul0Cg8CUBsO7NooFxdTQMT1VFeUsSZa2aEZ8A0Px9005mleZj1pVzIEU4MAqKaEtVK/e1dMGOGB5als1hv1Ji0js3Sytxfr4CU0tK+Gt0XuUCF0B4FpXDwyMV2TY6z4RcsQT35xfF57TIqwQvy2oP+GgHXm4uUUTQGKaVowdosZjU8QGpi9QoLU9msM+0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOcbGx+BsFdBghN68Rll5mqVS4CIO0gqOfn/Rj+BXDs=;
 b=WNGnL7Td2/7Ggs5nTS2NpDEJmtagx/Iwzy0pdsSPGcu957Bx2pAQ1o2GaFh6mCYfVyBsb6JVyWvMHL/NVSIw6NKNakl6YeOiRz5v5bz4eTCphpiCCm7I9Rvh5vgHmcK5MMszcIT3pX/8aKfSFkM7T9EAF0mF27w2xttzjKolnpo=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 11:30:43 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ec) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Wed,
 29 Jan 2025 11:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:30:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 05:30:42 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 Jan 2025 05:30:39 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v8 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Wed, 29 Jan 2025 17:00:27 +0530
Message-ID: <20250129113029.64841-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
References: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 263af377-4bfc-4002-782c-08dd40585df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31XQdeku/fcISdCPFF7w8vpP08Pr/LyLk5Tk3iE7RL+iAk+rNXBiNdgOEILE?=
 =?us-ascii?Q?TzYALakuxHdTJ1w4QkxpyHUAB+HkdUuklKgcrrnRWuCGr9ImpsughJCN/dQN?=
 =?us-ascii?Q?eFDoTiHcQEgeWc/onH5nRB7F0WlcSBVcX8na7DTe1FQvNU7w8gGl4WEPGk5U?=
 =?us-ascii?Q?lTTBpjgw4zOswl/2oGjLj6E1QERHevSN2ZqiZlVr9qyC2CUsugan6/wKF8r/?=
 =?us-ascii?Q?Zt7SFbf0vz93DPgIGOkal9b826lJDpwWq3oKERO7lYqg+abMgFljuFbIxw73?=
 =?us-ascii?Q?S0T+HT7zUM1mC8iPJR1hmTr3i/rDbTgzJU54320OGhYfgMa64LEresW0LnF0?=
 =?us-ascii?Q?Y+fBnQ/D59Palikl/wpDd/0TfVOTjRYkWul6sR/TSsKDvofz7ut5BKr4/PHn?=
 =?us-ascii?Q?p7zevCS3NOFYIKNm0q+cE90midi87P/L19HpeRoX+yj+jg+9raT1qi4L/PCj?=
 =?us-ascii?Q?Qj+FU6b3pgyveOBWOOnp0erjcXIDqwHG7Zf5drx9tkgAPhDR5F/wf9rl1i6B?=
 =?us-ascii?Q?ikpetQUkPmcspNFBe8odPzaUXU5wtOQRem6yBTjCWOUfblysVmxs0OttKxXk?=
 =?us-ascii?Q?WSDCcLDcaO6Sg1AxQwBDEmyyX5lCnHi7OZPBZ/0a3FQqSXtYZIA4LfGApAzb?=
 =?us-ascii?Q?o7JaYFLG73f7oTrlokAJ+qoz7g2NntJO7um7myMF7TISnLFl4kQ/3iLJPwJH?=
 =?us-ascii?Q?CfNSFlGk3U9hqi/4OR8IK1+ECv7oRDaoLIxYvktW7ohNb8cuSyswgaQArfWM?=
 =?us-ascii?Q?jq2nCFdgkfc+nsgRFCLmzWX2y39NI1eLERYqJyFs4JB7g4x0NwNCtOQRjUBs?=
 =?us-ascii?Q?BXauTHstzBUG9+i/0piUDW4VFU/UJRNFgkX8llLUqLRIHuZPV6FY6cGyz2FG?=
 =?us-ascii?Q?52EB6J46Dj0+pi8B4NXlOeakWktwzpC1AOrZdP/Sc5UW6u1s6MiM1SujNUcl?=
 =?us-ascii?Q?Hf8UF+U6GRunBSQ1fC5M4LqQj+HLnfIpeQ/EukRnyzQ2/i5Ktf2lEc6VWijU?=
 =?us-ascii?Q?3/5D7WOhQrklIq541eUBbiVNTuYJ8BtYUxx2EBh7dms7MUAXBlVoF0HgZAiD?=
 =?us-ascii?Q?j4ymgdcnRqVY7bY3+gXEcEFLr8ThrCUutFvaUP5lK3WfMhbn95DgAVbE08DP?=
 =?us-ascii?Q?NY0XhC3feESWnnnXB2fFWmfa35PwdgM6QJ+rBgytVUiuoBHZpmQ9oujhMhVq?=
 =?us-ascii?Q?0RCunpgvHfgTtPEHcQTMyCyStq/qKB1b/ofoYXglFHm20qqeFJGhh19EXiGQ?=
 =?us-ascii?Q?dR0MYW7GSiS3HGUpzeCm+QVmYgLzg0VgPPDjA0dkVuBlDrt/Fy4mB/S95KQm?=
 =?us-ascii?Q?8f83OEQTw10rKTIbt8wLQ9LuCw6NVql+4uuGHL7OnUPAfQUdRPWXOqlLL74e?=
 =?us-ascii?Q?vXEKsrJjaOZYlCz1AkuJWzYytkgSxcBp9ZI4HD/xUbLQ7uWfoUFLdMNq8cSy?=
 =?us-ascii?Q?G9d6GQOQndPjV/H6j/zpdfHC6W0sqjJPrKvEWVRENRUAxYzyyZz20oEnLk1I?=
 =?us-ascii?Q?BPghx+W/fbUUmH8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:30:43.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263af377-4bfc-4002-782c-08dd40585df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

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
2.44.1


