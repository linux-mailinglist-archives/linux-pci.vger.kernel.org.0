Return-Path: <linux-pci+bounces-21587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C3DA37C22
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154DA16E342
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED028F3;
	Mon, 17 Feb 2025 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OVcgxI1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC51199FA4;
	Mon, 17 Feb 2025 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777254; cv=fail; b=QfllNcKBlegTJ5M242Q/g5crgGyk5583OQma8LUObJeCSuUjzW/OEYd/l/lKN/vpMUQA8QB1KPlHkGBDzi7SgAiCGbMCkUJ8Cn6YzyPFA5ZLBlpYqZfRHu4a6OA4PEP+6rhsoLa+Sx4OrBSodFeINsJjpJVah/BgKzcBZT0gBtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777254; c=relaxed/simple;
	bh=kekPsNfeXeBTThid7KrZ+PqSYfGAYiI7KUcXZWUcn0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF4MwyKQK2UbbSViHrXbFI5RwdxfiZwQwRZkRTyOScnLi68cbg9NQPjo3LJIJ0kpYPgW26hSJn7rnMHGmPANVmibI8+58fqA9poV3lWiR9xacTohOmdmF6ET98p2gnwyK3pNmLJqQN+RBdMBfSZPBUNUqSjasXNAMrCRFPFTnP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OVcgxI1n; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU27oe4cTr+Lb4yaxiedXPciWNnOyCQ/LB3feu4F75EpVleoNq5ICYxg6hUqqo85c0wVM0PQSj0NI3C/o7bR41iGxg8sZHlELqQB8b3rQOpJ4ziWun9xuDYjv6Hj2c0p7WTGZB/xfy8Vb4PTDhf60TvKgnDcgU/5fK1bbzuDpOE/36qZnxGxTxJSF3Ja/C/NY7+Q+YgG46jfN2GvnlNHGVtv1rAwXDib6Z5w5wErDZ0aQUioynyXeU+flubr4uhLiguVxF838yNaUzdki9ma9LwbiasETfN00DNkAY293wvnFoZ+EBAQeSXlBErw52LBv+Jq7+MYfN8873/lm3DfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuTziXkqYRhGVr9DD+rTC4/VG/2DwiQZ//dlfznXFqw=;
 b=sKC9t1EFsOzRk2Zd+/h3Wi86MzNLIpjsqFUoog8cDiYzszYJp7rKRoV/5GFxecP99/xYymDvN6dNTULh3uKKu8IlQsN3uuhF6zZyExNykBxh0sDzNWIp8DLc7NeX70H9IAII5wxOGGXb7KATpYTISpuHkj9567pfD7BLcp6wrmaDKJ4V0AK7LdSYFf1IqC9scL6ZI7epObdE3Qbjsf86BkwrWcwvUFNgttlQVkTN4qtWhaUmJd4hyLFbRJgt3XYYBUpCSvzBTksafGIFOY+B4hxEgLzP8FN1kKjWAXeCJfqJ9VPw35oL4FBwcmcjprXZS0vwFSZ0Vf2TTnwkQCvsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuTziXkqYRhGVr9DD+rTC4/VG/2DwiQZ//dlfznXFqw=;
 b=OVcgxI1n3gpkNjvVvGFgwXQ8jQudoO8VAJuvceZVwwZTX82jg2DN3sJhpKTVS77+xMfcaXep4zw82ZcmgJOQnsyGrvU/j8dRt09RHTmQDoLjlekojsWd3dkKsLn7E2htPdjS8QGMJSWqYwK/SE5ZMsLHdJaL62fGh0Wqv6JDYw4=
Received: from SA9PR13CA0166.namprd13.prod.outlook.com (2603:10b6:806:28::21)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 07:27:28 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::e4) by SA9PR13CA0166.outlook.office365.com
 (2603:10b6:806:28::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.8 via Frontend Transport; Mon,
 17 Feb 2025 07:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 07:27:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 01:27:24 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 01:27:21 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
Date: Mon, 17 Feb 2025 12:57:12 +0530
Message-ID: <20250217072713.635643-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e61153a-ad2d-44a8-ec57-08dd4f248883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X551SdLTcNeX3rjhe9qCP9T9N99fA5rx2pMR8qvvT4RoEUFaFzCCZzv6pu52?=
 =?us-ascii?Q?gSlsEufT373IAioVYGwxpZ/46Zk/buOxanSDgLKEqZKABAj7lhStAmLZvpsl?=
 =?us-ascii?Q?9QP5OoP0KtWTjgXi1c0rccuwlgXNEqvCD32010c89sQgNxwKB7bM7NBrbPvz?=
 =?us-ascii?Q?nT/8FTJ5yNtvBlGHmmIMfkBMVshpIT50rqkjBg1DN6IsOtO4u+a1hDjnoaXx?=
 =?us-ascii?Q?OClAIfqU0jRnWpXujKQbSXaQRStBUO+RsP1i4GVdZpI1WpTpENSYcaDGUBX6?=
 =?us-ascii?Q?19zgATPuZ2/y594KHqRFprwbrTfHl6vMBki2mybysoHbFI/3EsuTqCN02IhL?=
 =?us-ascii?Q?RAE4Q/Ld2RLJkoYEw6t5mzMrKCZ/m71q2YXuTblW9CDLaP2QXMcdCn4qCJ7o?=
 =?us-ascii?Q?uLfQ2feUM77AWEKprTfRgE1cAnWwaDgCm9PJJ7Et5wrqsEEOVaYtaSovLPdG?=
 =?us-ascii?Q?VPvo+onuCtuH/Q8EXQi7j9NLskgNRFw0TLa7U5M25rG5S/umxwgPBhiivPxz?=
 =?us-ascii?Q?uk4ERzGNYC9d7S7Xfp1zZjjF/RZB9SNixvfQ67eCTgzOEHbv8QQxpSzD61W/?=
 =?us-ascii?Q?dmqFkAkEO2ktfJp1LBTfBRaUaSBIZLDFim7f4vwjwu1ifASNaMu3X5J96Oqd?=
 =?us-ascii?Q?PwLYIm1EfILWbMRPQLvS42FrmBXeb1Fb4qr30Dq8+qQdlaf+pZKb9BxzVoIm?=
 =?us-ascii?Q?uQLOT4/TbZGhMoa0u+jACe3Jwf1vj3WAdecXJsKKvApYlEOMfSG61SybYLdQ?=
 =?us-ascii?Q?LlPuivKuRS76bx+8bud9MA9IqFijLiZaNd7dSExyhAcw3Zpdd6X+7wcnF8WH?=
 =?us-ascii?Q?0ukcjpk3CirQ0DcpKfLejPRVC02qT1erl3V8HgJ/ccajPTFCULKZOcyN5gx/?=
 =?us-ascii?Q?YLKtUkk6Rh70gv3UoFq/bisJ09GRc0/wdRi/NXkytlrulC1aaphLk2c46EWh?=
 =?us-ascii?Q?WCoU8GXreX2OqOy8g1f4GRU7MZpnZQFenh7IxTTPzPHbO+7uGj8mWGGfhUDV?=
 =?us-ascii?Q?SgwDTsNPkV6BUmAU4I642BIC0PrNahFJhuB2mI+1zgy4juA2vwdaWODLXuKV?=
 =?us-ascii?Q?IDBsPnWtvOwUP6uwisrZotH1lrDf3WjoY+gJcCHv1l1Mvb0xzTj3QoUnkTzU?=
 =?us-ascii?Q?Zo+3i6pHaKoQ1Eox/slV28lFvAqPxDOx0flJIbbi8t4qjpEpZr0frUw+mCWp?=
 =?us-ascii?Q?pcGLbozCq47HVZbN29yrn0cHxFVK+E5j2cjdr/d+/BMi65mvQZzYGMoml0H7?=
 =?us-ascii?Q?G4T3373be3szfxQ19nvOKzfZkFkhMnLpEB0dbjF4hp44pBPL+Z40IoCVisfQ?=
 =?us-ascii?Q?+bRRNujCtDBXD2MuNEkSBP4DIzcAomSMwsdHF/ty2b8h8wXT19XkqoGswc28?=
 =?us-ascii?Q?WH8CWiPsCiIW5tMfb96LV8pCrA+ru6/6bEYtVHGh8nDUqqeAaeBrjIZHd61s?=
 =?us-ascii?Q?vY69G6kdY3J/XYawPA4RvX08BtHBjFunZggOOyKjH0BgSYM4XSuFaJXCyWrn?=
 =?us-ascii?Q?tih3+AWI8fR6pFA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:27:28.3461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e61153a-ad2d-44a8-ec57-08dd4f248883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497

The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
Next-Generation compact (CPM5NC) block which supports Root Port
controller functionality at Gen5 speed.

Error interrupts are handled CPM5NC specific interrupt line and
INTx interrupt is not support.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


