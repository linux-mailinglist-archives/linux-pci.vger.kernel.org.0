Return-Path: <linux-pci+bounces-11579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC52594DF98
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 04:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB57B20A2A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54063A955;
	Sun, 11 Aug 2024 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ToQ0VKOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC979F3;
	Sun, 11 Aug 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343048; cv=fail; b=sPgK8ruX+bZaTlhAsR13c6ZgtrMVPKPrnJjD2Lu+pQekBcYGVpi51irSoe/ucwPvlaYIt86A8a0knItlnvm440tvNWY36B3tcSbIgX/ETx2LpuNzjTo4ZIyLZWE+wEm4wnVHACNz3X6Dd9NrU/qPzaLhq+mTvF4ER2sscko6c78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343048; c=relaxed/simple;
	bh=g8bPGD+gKdADeORUOgReuWBfLKimrg1gOTWxU7G4VAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CHnGjm5KeKBufy8fs3J2Zdud4wjp9cOUgO6+YQvK4yHm0Up1zGISXOpVwIbns1jMGVDIDUAzAmfbCcBdDagAnhcssq+70Ijq7mgQNGw4Y2vdN7e9Vton2BE4jrNcMbFHI7E+NNSKuSukLFiA4qqeO2fv0uIgTDm0aHwDzCHRh3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ToQ0VKOR; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqECRGYD8SspnE0pCYZph5zGGGHTNjUC1SnmTm6y8JFKOjsn8Wm+Dsyh0EOMLCJeyZPnoJ1HAH3dbWoR8ZSMwioKpgvzZXVk36E4KIQoF9IZv2XhI3o53KzjK7kqzXMXvHz33ZSF4F7YQ/LQzNZiPyqi7XTqHFx0DVz7Zcu1wl+b5CmODyLTDYWiBUXwRSBqJx/K3us3rOskGCk/tSr50enjjH4q97j10rsaQOM3TxK27iV5t0LDgidDiRVkA+ugd3rMIhjXSRjGZ567FpVQTyAeOhgFXb/p6VEhk5UnZ+B099BRsw7UoEsI+spS0M71/x91KuTc7Tt2JIMkJ1/sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZtWp+vNbFxljbkic3U3abJ+DosqPxaZcwHlr44sMLY=;
 b=ixqqfTvOlo74qkHcgJYMBpkoYddfSy3zPi49zZFsUvOB4oF/Sq+LGOgKBEnBqQCMJDkwrNjvwMAAC7ffVODBee4AvHDtYU/wpKycQbZO4cGuW11G3kCIAHIDqCLi0D9r6nCQEBGr4Mvd1DFckOqs4z+dTnP90mr/ucfvVzI54oL9knDbRMvd1/zDRICX9ixqDYuF2TIzPmBNhbEM7Ps8i6GBc5WVvYhk88oSxZn/IfceeIxe71oeYibuohF4QWjU01+szESbXi9Jq3hiajeLAg+xxBG8YB6Ah7BhdgCgTokcefIukkg+lrCs63dJRXiIRwm3HiGn0iZRJRAlB9Wvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZtWp+vNbFxljbkic3U3abJ+DosqPxaZcwHlr44sMLY=;
 b=ToQ0VKORPkTxWmh5Z8tKr0dxJOh/wrGW8HxTlALMJLkYa74WSV9IiA0MJuCmUeN5NWNIyKTL88zjfxedcEvHjPWsnmxWP+Vcl+XcjP0AjvYIHr4X9I8GV7EZhSjRSn1uSwf85B3/3nn/IWag3gOSDpyFRycyFrqkkGYnpbUTl/Q=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 02:23:59 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::4c) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19 via Frontend
 Transport; Sun, 11 Aug 2024 02:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 02:23:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:23:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:23:58 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 10 Aug 2024 21:23:55 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH v4 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Date: Sun, 11 Aug 2024 07:53:43 +0530
Message-ID: <20240811022345.1178203-1-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbe6bce-c70a-470a-af78-08dcb9aca896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYVH7JDNWl8tQ/UUyZXwwVACJdSerZo1DK8gy9zczbNDr1emfJ+B3l05K7qw?=
 =?us-ascii?Q?HIu3O9jclJUK7GYrjx0NFBkia5hEHzZYytR0F1O7yQvj4G7HgQChLOey4snl?=
 =?us-ascii?Q?i0shZnvYGQBeXNUi4wcjg6CXyIPUmaRMaifhMbXqtSc4jQaYKAR0Tu6fd78T?=
 =?us-ascii?Q?63X6bMrGsH0NzqC6z4yeNyJLGUs+o5aNb/yeslut/pbOKgLr/OXRfCw6B3qC?=
 =?us-ascii?Q?7D48dB3E8q8HBISJrh0rm2FcDt1oY3z+hvEgQlCDJTOdQ9htCRz2bxeU/rpO?=
 =?us-ascii?Q?07VNas8AEIsbviYoMlIvQDcYeFSSNIytqaXrkwWTqlwVHz5G02WME+62dcqw?=
 =?us-ascii?Q?1N+KeF/jn+xxdr5TbSuLCTKay7ELaEJePCpeDqITEB/9wzeq3mGT/FHn+UPY?=
 =?us-ascii?Q?9TuIgti3nQpDxHhWB2lQbWHrYiOfP8VPR8IFXa5hNgHTQZhHYuy+9Ouv0u3G?=
 =?us-ascii?Q?yof1+zcuCR96ZgCKdy2023BoVXhUAjm6A0sjjkpJwb1J9vrJyYnlqJqX4Axj?=
 =?us-ascii?Q?aM6deNkZ7GQj2S6W1s1pQYcYImL02QDGEizgdxs8Bv/9MHVLHjDN7fB/EK5R?=
 =?us-ascii?Q?DzDrCbtjD5erBahZeM7/gXdgiItUdh4Mj4rPNCulK0Fw3gTuimCGTREf//Oa?=
 =?us-ascii?Q?nECDGVkm+B+sc8NEX3Ig8TAFw1TCq4QGNLA4z7gqNzPl/m+cIWims6QPIWmr?=
 =?us-ascii?Q?iGHhJfTlTWbvv+UDDqM6XVRFngfDuT9xl5ZGzJixA0Gu5CEGW1i2wK8z2FLV?=
 =?us-ascii?Q?tSW6JOaEZ7uDhSUGVqy3m0pRNfDIAilg2EwAuKyzDP0Tdqm/6al8+iVSqJI5?=
 =?us-ascii?Q?oU059QD1K260qsVZhxnKARVA3M5MUC+NQSIP2FQQxmeYOJ/CcvOoxHOmW9cI?=
 =?us-ascii?Q?QHbxKrmh8/ajVh2QpBtbSfHA9ZjLkLLnU8haOFuOHu/UbT4HUnLjClWhI8YD?=
 =?us-ascii?Q?HcUVpbDkIYfUOZXUw7+E9Nr9aU1X5prJZwwaL2iLKpdSSZQctWrz+0nLlF+2?=
 =?us-ascii?Q?V76+GNAe4+CB97ZAvChxFq2O9p4MaNQOJPquqX3Wi55UGp5jvMCO5+Mek3xh?=
 =?us-ascii?Q?kvwhqbtIbDmdto9BIDyl8N01GrgD4cGuCTJeCRCPMcJR7yJGPCku9LnxGEGX?=
 =?us-ascii?Q?H81nnavOq+7lC16FCGuw1qoyeuHT0VelLUYn9bwkV34D+AWbOiLPf4+Q9c2q?=
 =?us-ascii?Q?zeP7ZfTVUpJQuFK/VkGFHyVe1Nck7nqIkSj4YS+LXAR63BuwW7FKZrLvN+9d?=
 =?us-ascii?Q?VPuPOA/8zmImTega588c6+BPlUXkK8Bq2X6z+L36nfb9a7QZ2A8R73gtbWNx?=
 =?us-ascii?Q?gEyFMZhQg7IdHLS4hcRsHXmGHr1onMtZDb1or26bWMcqdd1VgfySlJ0avHx6?=
 =?us-ascii?Q?Yi7aXTiF+EYyLYYFwerX1HpRrqDISR3dwCX/d8K5nrfk6E634Ev8wqY1GrOA?=
 =?us-ascii?Q?rDdEVU2kwVMymXwZIoAIDeeS2lU5W6K2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 02:23:59.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbe6bce-c70a-470a-af78-08dcb9aca896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

This series of patch add support for Xilinx QDMA Soft IP as Root Port.

The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
    Port Bridge
  PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 36 ++++++++++++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c   | 54 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.34.1


