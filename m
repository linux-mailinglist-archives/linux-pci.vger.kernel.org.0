Return-Path: <linux-pci+bounces-25779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364BA87632
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D273C3AD3D5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BE5D738;
	Mon, 14 Apr 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gPwV5sI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86898DF5C;
	Mon, 14 Apr 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601001; cv=fail; b=unLXzxiVw6QW5TKBj1B8Xy+Z23BQbcMb1XxW5WXs0cquvex/yHs2WrIh4Z6SUwKSeb5n3AWVZlroTUYWbHElr1+D2mrZcP7ukufrtuokw1beq3oU1oSo1l2fYwaVlsBuubNUwDnzEZtQCSPbOClLV2LxtqR1kZbpofCJtPFsNng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601001; c=relaxed/simple;
	bh=hyryQGVNl9jnenAlsw5KjBIX9ioJgHFs8BVk86PTBLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVoZ0ruiqOBvZr673k+w2G3C4VRTCYY5axYRj3oeDT1fqSfgWQuy/YgkN5rzetfqJy6Fdb8gnfqenjrovofoPdRlgGlmZdUIGtPC78+GXuZivX2H7XluLqlUJgEi1Jhcue22JV91AIkTGLrEV7wNSzBQkfEjo9wKJ704BsdE3po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gPwV5sI0; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5W1Xmv5e95rqav4mGfP+J1NjTBDEQfS4v7xGQExyNSEnc4JvIr7Iyp3IoEwd70inDQ08uWfSiin70CuaZdNx0vH3Jhn3ggGNeZ+WszC1IX5Hbf7EF8fsySfmNVrBAqbj+mIpTqHqBK72C/HbIj2GGZVsyvwZ3RgGtxgvpod4UabkRdunfWlQGANcuyGRxFaGaOmxvHNRGT5lIT8sSCDpfAYrpe382MpDzWJ+IGyKb79qikmIFx1OXM3qNCh+xCDuIzO1/SLi3LGhDQuk6oCSfg1hFLKz5pgDu6YYrvi6rihNrwIhVNURmyHuz5Zfm825noeSGFMLrzkuMXZFP2CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oglVPY8ihSiT3PY3Bxz0zpCQIPEC+2NQrl36+6515yA=;
 b=PS72zmwOO+pRPcYJoTPv2iPm27jufFUNEwee5JVCP2sIdERo2S8EAKIRVKZl44rWJ3kVx7Wzdu+U/an3yoshYWx/S3ZAmnPJfEemc1aUkfYmSMkE6PaGEuonOvQSb6yjhiecK7b5AzR8f7jgW/YdhLRqvlBbVtbOrZH1HnC4ophqaC+wDc29aIp+kBEc/feslNodkIiFQXK4WK7k3bDR6YAdORar8ZW6RSPCNQP6VpLU85Y26G0YouQHghn2IbMhQOZNRjxppiKwWNBB6lflu7BpiCbgcWHTnIj8fR5FC+0mPg4tYvSbjQYR6C8x6B7iFggck1C+vJWgZB01wD9iCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oglVPY8ihSiT3PY3Bxz0zpCQIPEC+2NQrl36+6515yA=;
 b=gPwV5sI0gQfip7sg1+4ZRwzrpbj9qiWXSlKqHJ5r0TFI/efWQJoe2JLSgLSBKssC+kqmePGWlTRVX+MJ0suPzA5afy8gfAHcCVP+QvpGj7Jl0aGnXj/bY7v7bRj3k4d/MvA05vzMBbNxn5ppGSxzWqQCuyRSpKQByEqDwDzJYT0=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 03:23:15 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::66) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 03:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:23:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:23:14 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:23:10 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [RESEND PATCH v7 0/2] Add support for PCIe RP PERST#
Date: Mon, 14 Apr 2025 08:53:02 +0530
Message-ID: <20250414032304.862779-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: e30e2a2f-7ed0-4291-f4e8-08dd7b03b1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvWWhS4qLaE6DG5wO0EOFUww4NbkLdIIkdE+Tz6i+GY476ih3ee54FNV6UE4?=
 =?us-ascii?Q?bjO1aUqXdHybg4b8A1jJ+t41Ooxbq3nqFfbDqAlYeuZZadhBbCHYMUd2MPdt?=
 =?us-ascii?Q?Wp5FT5tE5xOIHsvB28isfkSsSoX3KDab2VoqmdAhmTqF6X2VUwkTVcHXr9bi?=
 =?us-ascii?Q?m1DWhP5R2s0WL+lC0ZQfevHTw9D32Y5hAnvQ1leM+E2yJMA6E6usUs2Km/7M?=
 =?us-ascii?Q?Ngs9nSu1LXZ8IoAOhbd8tDjOJD1s3Ii5HI7aRoKdW6KYvbNlVuINLs6p/nwo?=
 =?us-ascii?Q?dbELlvRAASB+hRkJ1yZlBLb5UF3fMdVWSkzk3Eqp5yf82E1y09L1w1LnKKFC?=
 =?us-ascii?Q?saNWtJjUUzObA07pWGtWrOp2Kc6lwMSnEP3ZuHd22fuyI9zv2+0i6dSq8rrL?=
 =?us-ascii?Q?KhYpP6fpBP2doPaUeg76HRJPENHaJ7641Wm6zsEaZNDgcnomfYj8qP32jpya?=
 =?us-ascii?Q?c1jGwoU+rZh8FyT5/9HxLvtCHWePb1qXnzvlsCY2LyDE48tyYPPICNFyuccK?=
 =?us-ascii?Q?PWh+8iUjzCXWf21R8G99sCFu2o6g/sz+VhReUqVBzNVy1JryQ3XszwSnjjB2?=
 =?us-ascii?Q?udw9nnnqUMlCMGcOiKZ9IVDLZNwDJAPXOzg35nLe6OxHOsUvDeJgRtU9RQDV?=
 =?us-ascii?Q?OxHIG68g1OZXQMv/sJHKCBe3KBTFvlqI8DtEbe6ncYnxp/o1soATmYbkUqki?=
 =?us-ascii?Q?5E0oHYP55K/AY3fE88n4UDi03nGGdBSIHPOfulwI9Xi0li2lTjXTV7VGzEAH?=
 =?us-ascii?Q?8uCuX2z4k97D/V5T6HcoYAgz5Dq6hDGJGnrCnw9n8c5r9mSzPALP+dzVbefL?=
 =?us-ascii?Q?xH44njC2aTKxMqYVdoz5OBgyBEZ01niQoJMofODoMk3U3VfhRYqDcQ4ZOOlT?=
 =?us-ascii?Q?gaAogpFpkONys20DWaPHdYpwTpN1+6ljL/TUquQpsl3PTitAZqcpWgfRH+9z?=
 =?us-ascii?Q?9O0MjVhiqJDqwNy6gX79AK8fnLH9cr8q/SKxTCEtg/vPR1PH1u7pt50h01M1?=
 =?us-ascii?Q?eRB//NSPTDAsJmanUUZWxR+Xvm/zI/OEkUqBQcJXwQ9/PK3g2mgyUcqVc/2/?=
 =?us-ascii?Q?pbos79+5KdBcKPWLuynpSo9HnZf4AM0YcJqlnaqIXfLjJefTo6pFqlZWU7FR?=
 =?us-ascii?Q?VgXZCu/1AbDMyDmaxN+8UeAGjS65F9METlo7YUMOPvHwvpEbPP+6gMW3syky?=
 =?us-ascii?Q?/NFDaqsIiFKF9IFNHIjWBtDToSLjr8FRTNVhyCz7Mhtxa3cKMtDh0/hHD/+q?=
 =?us-ascii?Q?yy0ddzZf0Y/Iuoj6dH1q7kvOrOq4lkvJFg398K7sWYFEDRTn+/k0MiV3VueZ?=
 =?us-ascii?Q?CLc24JMpJAcghlqglSH+efPCI/YQEe9Xt7xi2jDCav1ALdaIqJIX9SIXMHVA?=
 =?us-ascii?Q?6nU7wH6HnSoLQYc/hOQbGCWWU1Dt6juQrmfXH90rc07903Sj/CCtopjWKNqS?=
 =?us-ascii?Q?Y7ahvjwFgAkBbyDLbWKpH+avfPTUZDSGM495XCVNCxcwzACG/KF0cnVSuFke?=
 =?us-ascii?Q?CsMYpR80Dn/wylPPdg1sTRaWiSkR7Wy/S2Rd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:23:15.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30e2a2f-7ed0-4291-f4e8-08dd7b03b1c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller example
node.
Add CPM clock and reset control register base, and CPM5NC firewall
attribute base.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add `cpm_crx` and `cpm5nc_fw_attr`
    properties
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 129 +++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      |  97 ++++++++++++-
 2 files changed, 203 insertions(+), 23 deletions(-)

-- 
2.44.1


