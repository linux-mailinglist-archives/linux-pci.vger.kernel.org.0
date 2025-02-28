Return-Path: <linux-pci+bounces-22626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE26A49545
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C76F3BCB1D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7D2566E3;
	Fri, 28 Feb 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NMIMDJ2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B6256C6B;
	Fri, 28 Feb 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735290; cv=fail; b=KWTnY97ZoSRlFs9OQMaN9Q37ykRZE0GjxB61Cr7FX5EkmypqOaA8xpVtDr8g7S6E8LeHxgF/X6q6r7de9pc5FNl+viaLA+3YQqWe3jurmVY1paZuuJf8P+rBf4vX2l6E5zsTXzVWx/JGwiDGKpYO2kamt/Kyb0Q8fU93/35d7/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735290; c=relaxed/simple;
	bh=+UTyB8nsXV5K0BpdzDnECdZY8cQQeWWbAOc3qnOCaos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXxMWln5KGfy8o7ESv+dZJY0vjW2wjPagijkUO2gzRsU2A34eKlNPkAaCRO38cCQ+MPaikrKLxKeeN6UvZcHSH/hPT7KCwOSk7kci8xGfZYkCG4EP7LGR2vM8pKplOIt1nlO1bgNiVaby5vrofnrs4Ke35EoTD2n20gpDh3fLlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NMIMDJ2d; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMDax4Uo/JNH4K7WchH2eB3IMqvPFiS+zwFuYpV0LFYLNK8adASmsMGkuKiiH2vClAIL+YCS4PzEBribtA+s0mA5O97NAbCrjHOdxx8Tb0ncTYlfhwGTKW/TdPDypxsF+ov7Tg17s6wiTQs8pTgG9oDspX0ocDCf+Jgz2eSwlImcsM2BADfucL77NGOcjtvEmNB8MfOggPIRIp1m/Kk41TqxK8nLZxqt4/WleB3/cT6p2RbxxUZeVKRx2+Fp/bLGPnvqUBEIY1HVTychUBNQcONKFYNJv6qu4ct2N5CM87UYKLQncfIn0W2yWlrLD4jhotl8wuzmvrLg+cUJN/UY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGZjLvD3n7qXuKBMTFCUGueA6NyyS/uR256M6YbarvQ=;
 b=lFkn6NzJ1p0ziaE7Qt2oJQXe1Zi64XMos/xwE/ExLTBoWaRMB6Pw8JWYtCIia7808vW55fJ8ib0dOQGnjIQls5EPiJYnciioiow5bIpArYaoGHCObg5bcr6lfFU5QG6kgK8M0xhO2MuZyGa3sFjb6A+nEcxJMwkVQCLqa0Jae/NgrDhwJaxjk+kM7PhmyVYqI6P2HKt2glOYesblPBlIW63+jUE/MaE6ux6nhCBX6/hAqBvOQBPdpxiLKQ/0CwFIlO16w1pTKPX6591dcXUQ+gC231y4THT4w3IOtK360PYN+YmCeMNlR42py54DaLRCuSpi7oa/y1qzsh0O8YTNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGZjLvD3n7qXuKBMTFCUGueA6NyyS/uR256M6YbarvQ=;
 b=NMIMDJ2d5JniefHBNvY4HbV6xBkl6ypQ4XNa4fm9v2dn32E/LLGgFyxxM4OD+2VovbwWzhNhKac8YYMUTjG2Zg0L2XLmg1FMRBc/NjO/BJbJL5ysDfvHZyRwY9PA3zt712D5fUIP+zFXSUn4co6+GBmwS8ab+21IHQ+vt/hRVlI=
Received: from SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::8)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:34:46 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a2) by SJ0P220CA0021.outlook.office365.com
 (2603:10b6:a03:41b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:34:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:34:10 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Feb 2025 03:34:07 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v15 0/3] Add support for AMD MDB IP as Root Port
Date: Fri, 28 Feb 2025 15:03:48 +0530
Message-ID: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 195563d3-60e4-4214-b11b-08dd57db23a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FI8psmhE300UOSKu1FZRP48acx2iWb5muTravvRBvokRBpn9Soo8eO306zVA?=
 =?us-ascii?Q?SAm9WR+ddNnzwCzWQBImUWbD615EEfX0GvCGC7pvoiIOi0i5XGiLPiRJ/pTH?=
 =?us-ascii?Q?vzeBcVF+uHxWdwxaKcOeInj4E/Lm6X4P+7YFD0ah5tfsDnOFF5mf2TIXG/0i?=
 =?us-ascii?Q?cn2G8TGlnJ+eggPtb6bxQRBZ5y1z9dc+bD9LKz0vn4pCaVZMfDb7JM47ehzU?=
 =?us-ascii?Q?CnadlIWcdUTsUXN4jt5b1+U19Eku6S+cl/NIUbRMBr5s/bRNWkjqgqX7B+Ms?=
 =?us-ascii?Q?VHi2BVghXREf96PK2CL4gh/N1b2T6l9nQTfDGfOqoTbS9RnmQdmA285cv//x?=
 =?us-ascii?Q?pn7hXBW2FCEcTqJwNyb1E+ENiKUeI1zhbxVn2qblhQWiQ5c7nv30irTRfHhG?=
 =?us-ascii?Q?F9MLi9E+i4JvXSd5aIHDyo0W4+dtSw9otEvmCmvXWa+dXp9hkaFdcoU+Z2yb?=
 =?us-ascii?Q?tVQf3clUMB7rJikSvmuJd3NbgSVI4zczcZvVXMuRt6DVveyAaStn7CUCORRy?=
 =?us-ascii?Q?tpfvWT0e3RO+wFlSpNMfugrtj7vgjluFc5KpQz1IhOEham0QelvgHkJp7EP0?=
 =?us-ascii?Q?spurfYFvmzVdSxpjaHpfOwhbFF7/vqYMxL23xIHgtRQcvfLsaLTHMqQcGX+y?=
 =?us-ascii?Q?bhhNg0inBtJa6hDDwIksHeKcaf0KB6nzJU3/g3kaLFF5N6KC3Vqv5mx6/kVa?=
 =?us-ascii?Q?qkmMeuXzU+NSjymo7coZFfxGwWLqauGbMwC+cYpp+LXC7dsvh2i67eRl38MT?=
 =?us-ascii?Q?CXTaEGP2bLa4MnWdSoReYLKJ9WV8KP1TizoVI/gaiBJj7CDsxl9wvFqQ5eGw?=
 =?us-ascii?Q?4DjMIzSZXNn5SP74a2B86dm64FsERHckA63iflv+3QdBJPj6vsNJvJ99YAOT?=
 =?us-ascii?Q?tLd3TKIMZt8UKQMokHGBXrk0S3fedVQ8VBRKsdnctuTY2JMjHrqd8WHqkRtV?=
 =?us-ascii?Q?iS6jHCQwKYLMZDbSO9alO/d/G7HzN9VgIzWsfBcc6H23x3CcGsk+6Lgsr0uh?=
 =?us-ascii?Q?O8Qvz07OfQEbjEnw65ec+88HBw9DXU+wsQKWo0yU9upPbqoFmbraCnJHR6ed?=
 =?us-ascii?Q?pj8xlThWQPlvJOPJ9kBH8wgZjAkxawqBUnuRPnc+Ci1Min9m9McPXlCq2gjb?=
 =?us-ascii?Q?vyim7yFLHOw6D/z4Z4JIo68EDGfTrNqgAkBkbuWchgxK79+x/iHlOnxI+t62?=
 =?us-ascii?Q?DyCfY/tg5DxyrNyAdUauaEkMxHqJAiqz1h3FJEt3eOytuPbJiCL80ZgiaGHF?=
 =?us-ascii?Q?0gKbTGFQHKd+BPkmAqRtObkdBYaphtLDSU9rpfQQ8koHuMc+9N9+AsmTs5X4?=
 =?us-ascii?Q?KfssXGX6s/foDkYy2J0CfOGV55M64U490/vuOfUGr4nMwDMM8WJS4HyxatOB?=
 =?us-ascii?Q?4bkUkGnkG4Cau7/5ZUm4plT4xRoTcpeLYwEwGGghBfB91egxEZQnGR44jq12?=
 =?us-ascii?Q?YR7R1SDsGBXX/1nsB7R+nVZLf7SymZ2tqr1jlf5440PKhOGwKdMrtygrc0Zj?=
 =?us-ascii?Q?tyjlg0AS9Lh4Je8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:34:46.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195563d3-60e4-4214-b11b-08dd57db23a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 472 ++++++++++++++++++
 5 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


