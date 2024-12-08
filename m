Return-Path: <linux-pci+bounces-17885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE99E838D
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 05:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A21281AE5
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634F4EB45;
	Sun,  8 Dec 2024 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9zsVOFs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9745005;
	Sun,  8 Dec 2024 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733632799; cv=fail; b=sjnv87+6Yyng6MM1A+levN7n35t0fuMdV/YfJagnNp/KG874TNewbhBrGIWb7tuIpF41zuxjL+xEPu+nI/OFmbfipv61lpLz6PKkPii28BRUGrpkbomtr2jyNnM/w1K1Z4a5pWJIxtyEv1RXc/5v1UORLVY0ncSITfuCQmWQVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733632799; c=relaxed/simple;
	bh=LUkd46oYVoghRXDPs2DqCXwa+H6TZuOmbobrY9Vm1mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2LiEtsyxHwkOqrXoOw0z0pCVvmasPbzlQpr1L/oQv8onZeK5RT2vdO++9GNt9rJcfGIMvVFUfTG/Ql2OMDzgXINbOuPmMTxnwdO1+hOc8ZzQczRy69TT/TR0NlLGDRV7Xj5vL2zZYOGcq1fJ2hmpX21itmJuHkB7lNAuoHUmZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9zsVOFs; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1QPrAQyQ361jv6+Qmxx3Y8j7pY9Ejr4BReVzkW0FzO+zXELRSSaezx6DvH9sPz1lu15MyStH1oAjDLwxyaxdJk+CLuBnx4B71bMTqBhFbzsnZT3QwtuynJdRYX/7R3XUZY7v72O5UGZWEhJnSRCaY7LFlVrelj+9BZrlQmoHvf7Eks2MiYtA2d7PKkSy7iBiDSqB1LoRnjQAt7FzTkLqM1uWHawaXfu4uOI+905DrLQLvlmuN1/G7/AMoQGRq7raA9KKg12zks0ytINlVGu59lJm9bLr1mOrKwjTd28xHc/7EaqGaoGfx9Nolkt+AkH1CNjsepa7/iKgfuMKhe6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTxvKM27TnnFZsfdDmKzFnnw3NjvXD91BO8p/poI5Tw=;
 b=Ah0V91g89OUCWOvUz5coB+ivVg57HU7aiLCeBx8UMmv92/gj3sPV6YOiNv7fSLDlv3N9ykhyEjAEYWmVEROsOHPLhtPTqa5iVFbSbAM8NWx6/CCmw4Kz13LG9C89Yk3x085XNwJDVY9AXatozxG+AjD6z1Y2Zh9sxPUe10TjI7ZTJvF94VKHjdCWdMOEjBs0WmGM6AlF8CWSE6Wm/OcngVZqMsOufqdsdZCwl5BuGeL9io45HIj7Kc0srpdMfxzHdhIqGlwiOuxCm+u9OY78/XyvzZOy2X77dF32TkblRZCf9g7o5Y2Q6N94tufCE3+qi13SggqdtS6qBWLpGzquCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxvKM27TnnFZsfdDmKzFnnw3NjvXD91BO8p/poI5Tw=;
 b=b9zsVOFs4vhb5rYcxNSpVMde2cQdlJgxe1TBUBrRtJjAbj+4luc57ma2suAlfRzSEDw6snxDhqOQt1C/W9rRbj2+/H2LvcNAPcQ8PvyGSphrhjoqbrmzTKYhzSWOm0Ur+NKMrVtIza9oiO0DkAXZRcge2oxsvVUi988lym288p0=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 04:39:55 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::a3) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Sun,
 8 Dec 2024 04:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 04:39:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 22:39:53 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 22:39:50 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Sun, 8 Dec 2024 10:09:26 +0530
Message-ID: <20241208043928.3287585-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
References: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: a97aa39e-f6f4-44e4-2320-08dd17425ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yvMwXkKPNfp5Mmkm3gNhyrMYzblX290dMHfkelN9qHCV9P7cHIvScypVOdfy?=
 =?us-ascii?Q?FzQFSET4MW+PlDFAfM9sv0MMgQUeSFZGZF8pD0rXyRKFkpfVFtFyIoQX5Ozw?=
 =?us-ascii?Q?j0LLGzlJ1uLGAwX+e/RFLtNC8Hb3j5liCVi64loOW5Syt5dQOzfarx+0fge1?=
 =?us-ascii?Q?5i8ACiAgyysZrA5LOVmHXgsuAtBAlWxpeZeazJaksaN3zeIxaqMYtPBvCOmL?=
 =?us-ascii?Q?3IZEWgR6gz+o5ZIMta+0MZ78akKfdmEYgJ2Ttqux2igZa09Vyw6WMsPYtySX?=
 =?us-ascii?Q?YNGaAJ2x0+3wqLRxaMU1Ya8Y4BhLHxe5pCu2ZmVGZzKINhqTi4FE8xHSLcr8?=
 =?us-ascii?Q?uV4za4Osc96AbuCKs659WMl02sFMa+0w8XJ00cojkZykGldfW+jO/tO69UR2?=
 =?us-ascii?Q?jX0g0tStmjVv8aOFirjPrSoar//q0+qRixpwM+hVposui+D5KG07hqvKIvDu?=
 =?us-ascii?Q?7jJoA5qVD/GZw5LSDItZ5vFOPY7cou7KoNi2bsjqX71khQJPgR6o6cwtDCx+?=
 =?us-ascii?Q?PYmUcvvNDpkP5oEm6dyrUYdNo9ed49vBDLMIDhsEgvWfbZS+Wi6QGzREtEDB?=
 =?us-ascii?Q?rs8/FDqYA9k0oaOHiPIqYkV/4t4v3ROBFP7pIaR/zIDuOYM6qVjNkrGvWing?=
 =?us-ascii?Q?TH6RSEHh91Z5FdWNQPy4t8zpFv8dav6wnWCxSNC6vE4DFZff1wkicdD1CwVM?=
 =?us-ascii?Q?csqaBKizy+jcDaUbVhr/OfrfQlzzPkvskOuN97SJCSQ6TTYkHmIsCO+zEFaN?=
 =?us-ascii?Q?CzAJpCXdC1hKWoXllU4G6SkaYxNQx3eDxcgo00sUr2V5+3m0azbbcnr5wrFd?=
 =?us-ascii?Q?/vI16b63AZVMwqK7cN61SnDXGlCnfSefvTXwPw0AfWqNvglaiLLIrlAn1fhI?=
 =?us-ascii?Q?eUKc7EINZc0T2Aabd/rkceHhj2dk634GuWZEncQjSCNjLdft/RxvtMRysMa9?=
 =?us-ascii?Q?03iXLp9XaZpH5bU6m4NC1G3wzFRnTBIqj6jAAU9OEI0Tu43mfdS4gpUy/XiZ?=
 =?us-ascii?Q?1vhRm97LG9d3rbftrEjckjzLg3tg/VmSbzXq7/IOAmSQmW4W3hUtC6jEoYNl?=
 =?us-ascii?Q?cxXpb4woZeQSAVtQJcDyoMZeBH7CAdhAB+w9VtLcBpo6xAlNnxfaYlqPgris?=
 =?us-ascii?Q?8/ifVcxX02hbUT5gRE2KKGk83sb5h8alnKCuTFUpNijOwUtxtHPRh2Y4LTL1?=
 =?us-ascii?Q?o430PmbhhDqfWLFCrv0OzJ2hHIBmRSOetGJBwWIN1dZUBW2QEKbCybpe7P4P?=
 =?us-ascii?Q?IVcHMfg1TOXedjTpkeJiHQzhA6QndwPPl5R0k847fCO2/kfnBzu0ue1qix6r?=
 =?us-ascii?Q?kYjaRYlvZbGn2DwjcPmykkR6vKKrjM6sBIGvm2xLCLKegNkrpkoSjlTcXw6I?=
 =?us-ascii?Q?Jx5i/yBMGwQ7ya3xrgpwSUao9tAIVbfkNEVntNXePIGEqjl9y33grXTh3X9f?=
 =?us-ascii?Q?APjp9QJnWxNLqCcvfsKsGE63O/mLEN+l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 04:39:54.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97aa39e-f6f4-44e4-2320-08dd17425ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 548f59d76ef2..696568e81cfc 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: mdb_pcie_slcr
     allOf:
       - contains:
           const: dbi
-- 
2.34.1


