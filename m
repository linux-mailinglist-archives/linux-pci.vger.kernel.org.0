Return-Path: <linux-pci+bounces-21686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8FA392A9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 06:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DE3B1AC4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C11ADFEB;
	Tue, 18 Feb 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxfBc9hl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F41B043C;
	Tue, 18 Feb 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856684; cv=fail; b=K2D5SZVqZX7LZ8mXUxG7gGldL3os4wKSHWuJB5CrZuwOqugtq3fF7qtdo16ANOmAGEtEe8G3gTL3rckY5C7iiVIDOV2PQ5+h74UVG8ZK3EzYG4o55aaqkMePe5Gtjx60Pd+5x5MzWOWCnwZzMhlhCBvlzIQq9kPi+4ZPFYBYwLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856684; c=relaxed/simple;
	bh=FXky1Qyc32vLOVLg0L5U0S0y7ADNyW4x2lKgbV3Kqkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSbXso0sh0D7lGLbm6XGkQzdVcKxDqGPpczqpx52uSAVIvWCjXQPbWhWbo0q0d2fS3lREOU7z+Y9AIyyQKA6wtyWCJhFuKNbp6Pm3f82gCTYrNIlMtl1iKI4PsKI8NlddW4R4bzxeXtwCoyf8HSVz9a83TWrXXd4tzwhYuAoi6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxfBc9hl; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di+Uu1w1QOdTqHTmdhC9ufVkuDC92/INcfKrknz9jYq7aMwjtxF5eILWuMgcuO1eznmvr9PM9Sz9iz9unolxEeVU/1G7A/sj7asZvoWU6avUb/DGMrmbdg31SCmxkO+hDlBXOtRYLsRrPFTIQ2Gtcv6M2/Twk17tQ9itgUy9CIwvRy142to0r5sWwOip5kmvrEGM96ifTSkHxz09qY8zc7BDcKOaJg97IhxLVbBYBdlFJr9eIbNuMqxAp+HnOCKEIDlscFk+QqJiLt8Nfa8YFN94nnOZtAjmqshhfv3BwxgAxRmHYDW0wBofQnN25yI8QFFPn2LH4E62gtAI4bsAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYzDeX9vCvIS2ejx86tozZm8ISL8uq5mTO+oyjKA8Os=;
 b=JoqDV7V69AsG4jgSSxCSPzBBiPCmtTm6k+pN3HfUW5ZFkoXcOshCoiRNpfDy/iuHuUUap6NBoA0sFEGDpQasHK5WoZziSBlD0FCysNwxVYNcMCDc7GJY/JSz9vbzfM7vHilMtd/ZteSFhkWCTBGpARgEQyBbnFfh3Mqxx+e+7ygbRh8hH/plXrAtweEPC0m5LdPCvuSw/x+zuz7x9s8Ms6Z/hOn9w7q331ApAPSt2JwrrLDDbTOi0UX284/z1rtm2JHPBttih/Q/CQjyw4EQcEmRZF9c8M2FP2Onf5Cig0zvdqAtyy8GRLGXRKg1VjCuG/uzaVRRWCZGtnPzokFCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYzDeX9vCvIS2ejx86tozZm8ISL8uq5mTO+oyjKA8Os=;
 b=bxfBc9hlEa7LBpgrSiabq5qmcb1SrH3qc86Vcp7r7IdK7cxrfwao29qyiayEbcOucN37BLVTPwMFeyoGf5EBcAA36QwAeOm5zh0hjllw7fEbRuvNyH/qZZv3JFgCzR9KVPW9kjpVhLMe2B3VSrCNqbE11NkSzS5GsAQYHHIdv8Y=
Received: from PH7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:510:339::22)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 05:31:18 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::a8) by PH7PR03CA0019.outlook.office365.com
 (2603:10b6:510:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Tue,
 18 Feb 2025 05:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 05:31:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:31:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:30:45 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 23:30:41 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v12 0/3] Add support for AMD MDB IP as Root Port
Date: Tue, 18 Feb 2025 11:00:36 +0530
Message-ID: <20250218053039.714208-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 860904f2-172e-4dc2-af57-08dd4fdd7842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FKKxinZwK6lKS3kDTi34rogS/XL14lwT/9giGd5PCEYWkENRp/LEdml5yET?=
 =?us-ascii?Q?ig/RVJOf/+SKO8Gs9/yS2xddMNEs6gXebzpj8G9heC4ePJO7GnRmWO35nDj5?=
 =?us-ascii?Q?KDv1sDZka8Ix7Ez4SZ/ukhpTbBcsbQ0sRbr2VtZYu5g+VB9SK0vuJXxOn6sC?=
 =?us-ascii?Q?XikibLBavIw0jXXD+cVNGDyZbAykOHbCPXDyDsE+jfxxW8Bt/1XOtJ5/EPPi?=
 =?us-ascii?Q?QwfGYPi2yzx2WqqAqfL1uKDfoI20pDtX+bgd4mdkTEiwvarWXqGwq+T3WNKP?=
 =?us-ascii?Q?/M+ptFUiRphVz4qlwT7IreqMB2HtxNNfTPi7ZUaZ78WJp3BnjdrphWBdKdxC?=
 =?us-ascii?Q?zEFRDRDykBimv+Jxb+65kvLAYsTeAAMp2C1LWLFD90sXiWc/aDGkBhK03jtt?=
 =?us-ascii?Q?MxnxYS1x3XQCXNOaZm0FgytzRfJ7AwpuTntkEFU4tQWkmtYN9WYNJi2TsOyB?=
 =?us-ascii?Q?i4T97wVNYsLCr8L++L6QUxbG7fcDz+0EWfX41eLQ69jaXj9R7BVE8KhdfEMn?=
 =?us-ascii?Q?7DNqoDKvFIDIYByEIOHrjwYJB1rLDVVx+mQnb8TfAv+QNPvN+aFPOBQ9POeh?=
 =?us-ascii?Q?6JBbwSidg7zOpoIN4rF/Y10scbLWm6QHS8c0QdC06+/3J4E0fLo3PTk+FMyM?=
 =?us-ascii?Q?otZRXY/DUhIjk8VxjyraxPneUaypxiM7pl6xPf86SOEs0T3169oKovLpq7um?=
 =?us-ascii?Q?qJZtwBrV1Z/e/smFIDSkRSYr6Lfzzl9P+PS/OQACExsxEr/fr93WTx5tM6Zf?=
 =?us-ascii?Q?yzJkbCyGWXdirz1HNRj6zuexy8/CEPWJpUY3J6E+Nh/L9/zq1dkB9Rk3nH04?=
 =?us-ascii?Q?hWDtcO8soaTWU57E2QDXyxPZh48yrNBL82FnuwnwGil2lclNnjr4W/DhzmUt?=
 =?us-ascii?Q?k8b8nPK7TbNyPZOHwYAhLvUvknkeJs7cg4w3u8Osde9FZz8kbtvFxyWEDeLs?=
 =?us-ascii?Q?pBGxI/WvI2pTSazqmiCMURm7u0j2W6c/b9QtFxrqG42dLrVjktIrRe3V9lnO?=
 =?us-ascii?Q?0Q4EwzzdHVpAxyJbwICMRsTF4PMTP35tZztJPj/GvdNdwwjPBFVIjw1bXKu/?=
 =?us-ascii?Q?8LEJOBTJ9G3hF59VLgkXf07LSDMWjBNnbFZb81A93RbSU9IXsysyMJhA0lR+?=
 =?us-ascii?Q?uExUUENn1l64PFdHbWe/SLi5gm6ljts4Nb8FK88dNzHCuiEVaUgkWdD93vwr?=
 =?us-ascii?Q?eQycnO31pYurljr/n7lu9YNXMwxkDX41rb+i2u390po6lpUy/RA8VhPI/nKw?=
 =?us-ascii?Q?kjKRTzuxsV5Hiqn4K+UKxMURe2AFPex9OOhAXn0mpmcxn5EfX6rubpOr7hMN?=
 =?us-ascii?Q?ILiw8PIrvAduTwa/E0P49kK89AvO0ops79AggdsCxfiDAFbizPsqDdIwY2mm?=
 =?us-ascii?Q?Yhd0hpPvkPBNNMwVwavD9TDJsbe365HpOw8NCXKo9uadPmlEWduz12h0kKdu?=
 =?us-ascii?Q?HVuOMTj0wKRoBh3wnvYhIe6TozDmN/WKoTTLv1NP53F8jvuvJSkNO4NrEB5m?=
 =?us-ascii?Q?vB2dfSRQlAG5ibs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:31:17.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860904f2-172e-4dc2-af57-08dd4fdd7842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 469 ++++++++++++++++++
 5 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


