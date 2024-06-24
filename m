Return-Path: <linux-pci+bounces-9181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9200914825
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B80B24587
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D612F360;
	Mon, 24 Jun 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ni+uYZhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D2442C;
	Mon, 24 Jun 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227436; cv=fail; b=pjA+ZFLdroFO6RSiqnzalktvIHu3egnLa7QupTGlFdlpELt4BnypISqSL65BhXEczkz537/dvzuP06LXB2bLWGR9nrU+N10Cp6W3LI2Mr1OrWwMzYPv35CIV7xyGDbXw8p+q77/m21eEzGuMn7LJMJ322V9k+7NdTLT9Fp1dru8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227436; c=relaxed/simple;
	bh=kDCfSGsgfih1HQ4S2u8NgUPGpxCw+E/CyoYFnbj5/Vs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhDJIhRwoR9L/HFmvQGGbU9O7+iRJWvzmt4uEpl39trlH7+pS5VJY2fUHqtT6fPKrTUNEBWROFAZ3w1OConeFKAt+naFzZujQ8woh76Cj6kNzlol6SNiDgh4G2KeCMIqmD3iT073dpXvg8FNI5bVVA4R2BJaJZnX9ps/FzJv5Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ni+uYZhI; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNeP8rurn+V2/rYLC6pmw0QGTI230mL4CCPlrrcHUs43Q/5mJY82p4vL0OFiYRn9WQVIUsk+kEgdq0t81nZB6OB6FbJEgEk1lldugWWKLl/zEcPjS7EAY/YgRGnz6f1yvDNytsGFSXE/OI7x+I3AZTDh0x5V1fjjzT6UWR5SSa7OrpfiD/vUbQ/LPsVsxw9QgAZWzxsz/gnR9NPrlCg6WW8hp6HqqZEWDWdHd/f6RLGZl0EwV0SsxG+pn/uxzI1ZpH/GODptdkvto0xFLm14+bB8eNV8chuIVnXri+0SifImFHJFHCMSYTrv+c+hLA07yaiha+CPMrx6ImA6pEBKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n59ZcMAy1XtJCrPYS2CTiY8oqK+OLtAY0n7AJDlB3g4=;
 b=XtF7oJxVQOs5Ij4DvRPlGk6BbowYoSIaYGAy247S6pljE/dR+eXI3nlzMDGezalUNFdhb0ljytsK8Q2AArUkS8TLyMKRbkkdXGOMbbY8ev7//kJTRaUX/ZemXecy1iq6CQ+Cv/qPILb9HJBKIQtWCw7xfrihUr6kH6yQ7GtSm0xCnZpWIJ2sTnZStZTp45/0TujUT3a545dINh3JbSmfPrdZ4/Q5PmTpxck+y3h7ZDxLDU8KjSG7Kri7/IsHYjPyzqXurk4Xx8agK+2sQtEH4+Ko6h56+0QtrV+BZ5q4El8cKhyL+CISMn0EbVSQo8UsgAjGoyeVvkzLWK5QblWT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n59ZcMAy1XtJCrPYS2CTiY8oqK+OLtAY0n7AJDlB3g4=;
 b=Ni+uYZhI5U8WljqUSO7oShs31NL6/lAXvI+iiNRmjH8v18rkAKCVHVaJTGERn/Z2qbjtxFbZYXqIMPI7Ia+WbxAhSMUnV0SdrVd3SvT905NP1xkdqKyvlwTdNh2yurqHhWW+ykiMnwn3m4CXvsvOTPVvIj2D7HewQBByVDVSRjM=
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 11:10:32 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::74) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 11:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 11:10:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 06:10:30 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 06:10:27 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bharat.kumar.gogada@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH] dt-bindings: PCI: xilinx-cpm: Fix ranges property to avoid overlapping of bridge register and 32-bit BAR addresses
Date: Mon, 24 Jun 2024 16:40:22 +0530
Message-ID: <20240624111022.133780-1-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd1af35-5295-4922-cb5c-08dc943e433f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MPbWwqIBKt5yPrlknheAoxjqrJnC+yB2KdfDd+mLPDb0VkAqRXkTwQJwxTkp?=
 =?us-ascii?Q?Pf3kPmA1VeZKSMYUkDFL9VrV6XWXm53fSWFJms9c2DaINgCNT9bLcIszlQMN?=
 =?us-ascii?Q?ioAd92CjPRUn2Q/EB+2pxtgXFNIMuJFa8VETzeBeTgFj7WiIiP/qD4I4u8R+?=
 =?us-ascii?Q?2X8RRDONAS/EimA8JDsqyam+Cu8IpHvYV7I+dbRZfD+XaD8zCIR+B+krjSBm?=
 =?us-ascii?Q?QhaaAhcwhx6am85qVUMWVVQEtkkBoM2gyTKv2Yh/OefzyzoZjxrs5I61mBCN?=
 =?us-ascii?Q?ldefFxxPiEm522TwKBA+0CXJrKcw+f47x4JYqBYjz+TXoZxfPX5sswNrtdcf?=
 =?us-ascii?Q?Rtn6ZuX4SL6pewwKjSBln+vj+F0ga+8/POp7fy8xHQE/cYA2TWUubP22eP/v?=
 =?us-ascii?Q?S82HdTShf27utPMmE3EjFZGGMTSodniMmPe3KfY0/9P/4gd/M/Uf2yEBcCjC?=
 =?us-ascii?Q?mkeJkPw/Fi9QfA/GKkD2GEpw/2PjlUtLuzyD5yiagx7xoqknA6/PqNPKsZwy?=
 =?us-ascii?Q?adQupvyAB7tu1PLrN5NOqCorXxxBuVBQ+4PwMwBZcembgzNcG6agwGE0GPbe?=
 =?us-ascii?Q?uA7RGQ3+/Bf80quXfBhXxltMX8m7CM42NkyujNj5a47qLRrsws7LzPb7bppG?=
 =?us-ascii?Q?vRuzRhEtrJF0hOClHEZjK8T0geNhaFtzFoX3Q2t2Ex/f1JLwO4JmH827LwuT?=
 =?us-ascii?Q?zi1H9ZbY3R1tkcT5C8wC2NssInfmfA9hfkdxloHz0u8nqT/aI4n2WFFiGKKl?=
 =?us-ascii?Q?6cTHtXs+S66E14kErGi8cbEre6Q9rk6qw0kqEGMwOeNpdZ7ajXZaA5W2HF0L?=
 =?us-ascii?Q?Jd9NCZhlNCmA5ZkbD3fFH4JfACEZx9KH29g2D1I+45D6tqZVGNqFYAG4XgZp?=
 =?us-ascii?Q?DzmvltvUSeXC/BBmvOFyWpgcSX23oP1Q/88pdEygSuksgHmswvSylIAwmS3G?=
 =?us-ascii?Q?q1ZyJoHw7Geymg+81/whZ319sntHrY8BBFS9ry60pFh4qdPvLWx+Or2GYOVk?=
 =?us-ascii?Q?OJDzuE6Yj7xV9YIoomrbfn535r1uJPLhTq+6K5Iyir0N4DBrcPhCq6zW+l+8?=
 =?us-ascii?Q?2EgyBu6pJe2i74t6L3GhQEwOzTQmwvP06cqVuvdxoWG9RIFI6g0h+zb8w8Hw?=
 =?us-ascii?Q?SnQn8etqrKUPmDaWZ+BqJ+1F+cgk8BP1svYVyTIk+IXHB4g5dzifs81AwX5s?=
 =?us-ascii?Q?BrBk6PgIAKAIynV6biaxQllGvduyuQJaFhJ3MNK2cCW/lVAZh6sZYnPBNkLU?=
 =?us-ascii?Q?B8lUcZAzUXzCDD8pE4BsOquX3z5Gr7v476Ia0fC7kNQEi+35pvqlf3O9vg+O?=
 =?us-ascii?Q?5etmIWrlJaSxWpJJm9MO/CLPMrgc7nOS/KX/FuiJ/9MueJ3IsO4ixCiChLjb?=
 =?us-ascii?Q?szOanbOTsnT9uDoePP85QENgIIUM80xKh+cmO/OWHf/yAv6TRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:10:31.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd1af35-5295-4922-cb5c-08dc943e433f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

The current configuration had non-prefetchable memory overlapping with
bridge registers by 64KB from base address. This patch fixes the 'ranges'
property in the device tree by adjusting the non-prefetchable memory
addresses beyond the 64KB mark to prevent conflicts. 

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 4770ce02fcc3..989fb0fa2577 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -92,7 +92,7 @@ examples:
                                        <0 0 0 3 &pcie_intc_0 2>,
                                        <0 0 0 4 &pcie_intc_0 3>;
                        bus-range = <0x00 0xff>;
-                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                       ranges = <0x02000000 0x0 0xe0010000 0x0 0xe0010000 0x0 0x10000000>,
                                 <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x0 0xfca10000 0x0 0x1000>,
-- 
2.25.1


