Return-Path: <linux-pci+bounces-20126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C89A16451
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0AE163DEB
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 22:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5C1DF753;
	Sun, 19 Jan 2025 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AMMeADOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6E197A7E;
	Sun, 19 Jan 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737326599; cv=fail; b=Wkto4filRl+I4zZhKBdkoiyEWnUQ7vfWSXHEIY/2wJ4vC1ZemiLYY5w8Xyk955J0llN3LbCpSUkB/Pd7HI6h3m0pAw/FmzjfOE6ZQYqy4fBk+mWiNNWOFU0MNkXjcVanH7FduG7nAW0rOcvmhDjM4CtJFHAsJHYMMCi0J3AsBm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737326599; c=relaxed/simple;
	bh=KiB/j3M2WEWA1sQHQKb0ATBILLI3pkDZUq0fWDi7buw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zd4p00j0j5X/fR3MuMQnskPnZkMhZoaObMPhYwm1Rzxmdl6Q3YPjx6dgZUwIJLeMCvRSvDWMQnSpYQDayFeGtsizH+JjyNEaPV4esOzKc8a/z9xUsIMkrDUKI49SJIlceFNc6mdWPD9Iu2Y4fs1XRozotxQ310uWZIhrOJDAWgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMMeADOl; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoGuuDoYcKGSWHIGexAdC8jAW1B4Jmt01gbH2Z5n8uVwqtjEVYB0lgWY4jZChdCRegUgybHlIgoAM1xv+0NqEXOrJ50q3mOqXDt6O3S999XaAAe+6k8raX5BwU3Ntu7ka2JFrMiiCL5qYDcLYkq3RmaVNHMkJ2iTk9fYwxKFJybEnj+RWDHugAGrHzUUVL//sJPlZTuk9xFrO7z7Hra8jCsR33R2CFDNl/4Fq4vP3BQKK77TI2SXeABtOzxeaKVbrHjxgmR/KOj2UZRINj8BtixzVFR9Fwi8tGsDtcQNjHzvhMvjaAVUGN+9lcWBa+92ElRrNSwHITFt1h2k1SYqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoNrreO+cqjozw64fJEKusEmvweoFmPU/m6yrcHA7sw=;
 b=mlQFuaqF6fPabIdXIrrf5xnjywecI1xdsxGY8MhjMvhvmT/cZDci7P8cwn/WIm1mYuPDfKmnDHXysGQZs7dnf0lvH9dwNesAdfmo6kRaLh+OtlwTTI80/K7nqXbKhGGmBCEd/BHp68bTaHu0a1kemz1xp0KzOhOMsDWzSrHBxl6Xy8NNxpj0XFlGTdjkORswzxqBp2HT+jCGDQeoMh4RynDCWOSmYC7Xn9uDdAa/DetrnggfiCrQmxHn7MdX7t3ofW/5p3Lg8JOxjHilT21eUviAASv+iuREEsuFB0dDDidWTzwdRV2lMmByDsG67a/2Y79l8d1xoyWUdvI/EhPtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoNrreO+cqjozw64fJEKusEmvweoFmPU/m6yrcHA7sw=;
 b=AMMeADOlOuq7IWwrXeJL2poDwrKtE4DxkDEISgkS9qj4atiU1JvyDifgQRmwsYjdwTS3NciclvBvB2znQbdEjuODO6fDgjHoWEeVQbdKi6hjfLAD1QfxANgZe6wHuAMEGp88UExwva+ArFYyWzQ/2sCCQ8iGdvx0INqDic8rNFU=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sun, 19 Jan
 2025 22:43:14 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::a4) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Sun,
 19 Jan 2025 22:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 19 Jan 2025 22:43:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 16:43:12 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 19 Jan 2025 16:43:09 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v7 0/3] Add support for AMD MDB IP as Root Port
Date: Mon, 20 Jan 2025 04:13:02 +0530
Message-ID: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: bb472ee0-c563-402c-9730-08dd38daa886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hR17bvIEmS2nM3nUIMN1IWdJWLza3FsiUw8xaQEmtV48pZUbHD+heBQNjRq?=
 =?us-ascii?Q?/qmwtdOgWRmwBksJKa6AQ5IIxwHFiln4XU/aqtXxxj+4DkR3heloC5kMhlDP?=
 =?us-ascii?Q?K2cPdHttFJH4hPnvwh0m5+XiQO4Oyq1DOMktSc3Oby8yTkF2VTcC6hfyy8d/?=
 =?us-ascii?Q?xrQExhBLFrFzQvBHnzEWbdhza+fgNNlWV9DKBBGIUgxeO9SIi9ynXolbDDm+?=
 =?us-ascii?Q?tPS33/vyyNM5XnZX379DwsHDlpF8fn0NzFfEhI08O2OPcYU+RugtjG5zROZr?=
 =?us-ascii?Q?o7JYhITiiJWR/ZbcEwdxiLtmwdGD5wRX0TuNXcK4YTwrp8zDYs2P+JXi62W8?=
 =?us-ascii?Q?MkduJ/F+H1FcpbiLLvQP7S39nqUpl+zTQ8SkwoX7MACrTsqsr3fyZrtZngmU?=
 =?us-ascii?Q?6BonRiavs87q0u8HxpNlPvNQbN14UzAp6TcZ8CBDKn1P3wc+m/ZsEkt7W91z?=
 =?us-ascii?Q?hNEdX9Y7/RFoZEZfbdP+0OE9GQF0npLNZ8g+wmteu+QZaYiei4FHk4vz1DRl?=
 =?us-ascii?Q?4l5/0fZJZMP5+feUyxFaTyQDQOyCWfCHo5YBvdbdDNUszGKEIAOcsfM+Vbp3?=
 =?us-ascii?Q?afxbVx2Jg/BlwyeTG7gAUtywF2sZDfnYJfJLatYWdkz7mluVmU+/v/vzOVUG?=
 =?us-ascii?Q?d8++T6IxNT03TxlYXFrVhrvvLf5HlTIUBw8KrodNES8l1DaiC8gFhK3DZkcE?=
 =?us-ascii?Q?nueWSgzpWwqtL6sZeVMfcnnrqiViSbRz6JDohz/Ae7EjphK4J+kCtJaEES5+?=
 =?us-ascii?Q?G4O25XVnPU/JOwG3OYE+p+23n3NZ9fEMhTHIqixKV0Liljo08xBSH7P/GQOE?=
 =?us-ascii?Q?/jVLnzOAd9S4fwNc+cTcS4MzbB91uhcdUqgXCYZ/XsTpUow6366xUThAvfsp?=
 =?us-ascii?Q?LKA5mhAxVKDPIALBmOCu1e//GZjxI4e+6649l5hvN143fcWx5yCBw1lKzPt2?=
 =?us-ascii?Q?e8hrK47fFHytGifdDDVdzJUJwRbC3sMgke9B9SEDiG5tcaLlTT/OY7k1+Im8?=
 =?us-ascii?Q?OUyMHjVaKT01N9LumNDBM5ExZSrwoTfuN1q5IetpmjIdngn3NdoDqmt6JrUK?=
 =?us-ascii?Q?X7YgEDnPeTfgoc1f+71wpiz5TQdHce9FpC32ijlyR9VRxHjMqA4JgLSU8nLN?=
 =?us-ascii?Q?QBZl9PQylz53xbiebuKwybDBV7/P2ow7cMnhOuYYM9dQ4qxdHkAcWeg+WMni?=
 =?us-ascii?Q?Sw7FoJV68UZwVb8iJRCiIH2wOFvyFY22Ra5fMBF0jzjCML7zGiL04uGGBzeM?=
 =?us-ascii?Q?pNN7wbgc9pIyO9R+AZzWNCaUCRyAsfnMFuvasvTQeFqQ8goH7xbMKBPrHnJ9?=
 =?us-ascii?Q?OkYNBHHRcp6Ia4VOKoZ8qkB6w/uKPytGDiKSuiQFp7j2n9/htgm+DTu4AMwg?=
 =?us-ascii?Q?tpbs/SYCOiqLQa5p9JdxrsTA1hUWtgTH/aAaJJhj9hEbUWpEqXlY7548+GgL?=
 =?us-ascii?Q?HJTEuMPcmvAknqh2HLHzC8tKihagIDORzHp08OOjYVHWbYR3IpjkhlprLDn9?=
 =?us-ascii?Q?XP9SYZ69lAqW9cw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 22:43:13.6803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb472ee0-c563-402c-9730-08dd38daa886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 436 ++++++++++++++++++
 5 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


