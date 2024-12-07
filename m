Return-Path: <linux-pci+bounces-17876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB09E8128
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B5A18842AD
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918714D2AC;
	Sat,  7 Dec 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJlCBOXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45A14B94C;
	Sat,  7 Dec 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591511; cv=fail; b=oQVzBBc2FvCBfeOOkSLHlDkb5u2DkirQQncjSkO/VJDzWlonK/bN2ViPrwUBDRi1+eqQTHC/bHYVDLvZGRywwPkPhfum5xJe2mROkHBM4dEEOD3CPQvTVv4HCEoBnOAvcOAqglW2KNOglCal3HWA1w9LToeaI/BfvpWD00wLLQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591511; c=relaxed/simple;
	bh=HQQpSPAWu7IPqALdQnmzsAUxZ6yp9bUhwyZllQ+FHnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmDdUCoZgVpoROn2e1uayPuInbnIPIZzjhYivrRPS2FUvoRfEvII/nUjx6Guc5FXaWsAHjAP5t+qt8chv5poOBjTTTgzTycPIQPfLbvsSbqRpoVuqXR+cADF++2KNNJQ10QN2015p5Yu9G1EAIJUDltEc3VgWinN1c9iQs/5OF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJlCBOXF; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9/xXTSYC+gqOaJyTlOBqDKuKfi/MwHRUdBWmYcezDIsUu0BQaZTUTp/7XWhk3awfdcEn2K1GGemQfeDGPDQF67Z8pz5Y8SLfsi5slFPfZpEl5OhUrajshrQTtaEnTWL4fMD/3DhaHYd73LnxqBwgEyFRTcNyGOx7ode5JCLQlclvZIqQg6Ebfq2Th6onOtIqsmc6oh1OsbLI8dYbYtoEqe1zAnK18RF2ogas7Z3W9uOIOoKqgkdpcMFsxiv3hCAmOpxu9Vjq80dmXL1zDDlKCHAxjybbO+Uf6CuCs7r3YKjreIvrXEF90HeekYIeCpoBC6y+ByxefoGt3FZigg3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yeadDKvcsX97IVdXG8I+35qQRen4sNC1TcuMrLp438=;
 b=UcyyGmUnQhoInSwRm6dYJJ0mv3NoDZrs7JGTlGa11OV9TeRem7Z3rdLeUiDjvdNsrXPL66B2xIp8rLwF8JIgAuYNZnARPJRerv6om3odnnP14b+GzPp+AmRsnsRwJ1A59lzJTEZ4jxDuDnkCzZTsfQ3iccFeyLUVr8WNJ/WgOVLDEF+D2TxoLxII5ZeGLoiuIQorrxTGLfvaeNHlTcUgrXoxkiTnWAKLZRhtBODc3nKyqnxkykC31CxURkJIvX52si2jeyAK4XU7lhDkrhTBQle50uyp4RChJli7uypI3L7d0QoVLURGrOm+7N0P/7sKmG7yla6XHgUL9uTisjNCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yeadDKvcsX97IVdXG8I+35qQRen4sNC1TcuMrLp438=;
 b=gJlCBOXFvvTtiH6FD5iZUC7MMeCjLf9WIjwiNKLJfZVJF+XqkT5ProSlrR2p1tic7KM9p/V1DOthe7drrFhoqe9DlJeQp8C4mvc9BZKzi7B3cgymcKHgRqZxmzocbmXwJTrTbiV2CfiUgZa/Wzl6WENcV6orI13Kl0u6opqAVDg=
Received: from MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Sat, 7 Dec
 2024 17:11:44 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::bd) by MN2PR10CA0012.outlook.office365.com
 (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 7 Dec 2024 17:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 7 Dec 2024 17:11:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 11:11:43 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 11:11:40 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Sat, 7 Dec 2024 22:41:32 +0530
Message-ID: <20241207171134.3253027-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
References: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: e4452743-695d-4a84-b713-08dd16e239f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fc/7EAW65bdBh3R3NixK+BKnpYo3Ie5f/UqhlzJ1/TGd+bWOBZXYiQJvh+TX?=
 =?us-ascii?Q?axTpud1FkRh8LqEFmN5Q1onj1Yds7uyphIg0sU4QbunOPYighEFAhUP0e6nC?=
 =?us-ascii?Q?5VY9qO4iUVAe+jWWrm4clN785MGgtbd4NMoMSusOvYTBVzdW1hJU4OJMsqLR?=
 =?us-ascii?Q?S4v9J/6srvqqlTGmymeID986GcRncnQkTmHt5ClnWX5qzd5a54/sZy8Lmbgg?=
 =?us-ascii?Q?tCY3L1DqMbsBuGkCJDtoySnCI76dYPcfa6tzSO4ZotZi5tMSYL2MVeGzGMw9?=
 =?us-ascii?Q?z6GOlkWgEjSrzBBZAG63SDyb89ZP1STVQbONCUes1LNCgojbahknS84Gbfsv?=
 =?us-ascii?Q?X7ReZ9mc4HZQyKnutIIuZuYsLzqsB8NwhhomTGwqU6Iv3gtnWbYv3EYWIaHR?=
 =?us-ascii?Q?iXaM+OK3aiv3d46tXIlcLWfzzeSaIUpkQIiELh/KYl+JGDl/JiKNAVLAObhR?=
 =?us-ascii?Q?pgkmyTWx3PLe0RrGt1DgCLsV41/Yz31EObNooqgDu+wzGawNxIOZpjplZmhd?=
 =?us-ascii?Q?sBAto6Ttup3FMeTG/JsFgY7pNPk1//ebpFhpNQtTuY+EJGrpT9xIs14Ora0o?=
 =?us-ascii?Q?gBA+WIpN/Pxu/JGIhvj9MV7YIJ/BiZVOGOPnTZEEpUqd2NGbQ4vcO3Omx9Ar?=
 =?us-ascii?Q?MylJBJ2vt23xpnx0lAph80mHY67STgbOXyZMTLgZ6h0WQ4BMGZlzCFv4ZXuF?=
 =?us-ascii?Q?5nVL6NKW9TxDNSnA9s4+BrF35YpekIMdcAnRtxE6ZvmuNSargeTTuSuXn8Id?=
 =?us-ascii?Q?PD+cuq5y/AhX3ShzjUCOwRxklXrtcC9GjBW8jtgDVIL+lfoy5WVSVpB8x4Ms?=
 =?us-ascii?Q?6gPoTg6I8CrEJUVXg8ByBduuyhsSN4ogj7WUC6E4YzkP1el+qJ6O6CIIHJfA?=
 =?us-ascii?Q?5pjWhXmx4Rv1X4ZN11N9EuVLu0QEqmi7J90cvyLTnjTn9F1AOMG5CtsVQQW1?=
 =?us-ascii?Q?ayg8pbz87RBt0E6avBU2cxGYmO+2bqErIQJB/hhE/Bj9BGPBFOaENZIQ0hRb?=
 =?us-ascii?Q?W1O1U416X6AiD3Ra4vPogU3GKe62L5fDQCuLd4jzGCYLM8DVZH9I1XC1Y0oy?=
 =?us-ascii?Q?oqSrLrXQ7PHhGRnKYJn+diBnvYv189pNQNz+qVJNE9jIXW6S6yFHQefwCiua?=
 =?us-ascii?Q?L214ErHxInSJXlzOM2tOKh4UceM0W3cr+BzBb9/qwbJ+38w0ISEbm9NBNC0O?=
 =?us-ascii?Q?72mC96BxOzemue9dgbxwTOes+iuphN83HyxYRvylHrmPnUI2/YoTbX3ZL36K?=
 =?us-ascii?Q?V//P/HkHjGNQoOy0LU/2iVnlaacxkxzO0lTBcBkHn/8F2ittNvVNEY0u4i4t?=
 =?us-ascii?Q?9GLTCHvqXuJc0AD1vAgf0ij58n26Enue9MtY0UPNR9Xgt92Qf4Ht+nV+S4Ti?=
 =?us-ascii?Q?7ZPUkZzjcWQlN2EQjC9GGrtsaYMatJWbPoNoJfYQc49vNTeIuF41sHVPzO7D?=
 =?us-ascii?Q?L9vFuTCGIDNpWaGlAfbKJ9UATVmAzQSA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:11:44.6612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4452743-695d-4a84-b713-08dd16e239f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v4:
--------------
Change enum to const.

Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 548f59d76ef2..019c4390eab6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: [ mdb_pcie_slcr ]
     allOf:
       - contains:
           const: dbi
-- 
2.34.1


