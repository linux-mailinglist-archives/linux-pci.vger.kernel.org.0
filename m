Return-Path: <linux-pci+bounces-21586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E3A37C20
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128657A25F5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FB18DB33;
	Mon, 17 Feb 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4oGf3GLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948E28F3;
	Mon, 17 Feb 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777249; cv=fail; b=Dk73eMmjd8Ns4ktkqPDXG1Fn1XS9TLrmoYpJQWrkcnHT+wyly/iDwkxV+VbUKJ8yyY9+jQdyep5mqDOlU0g23aMG/6NfiZN0+IwwaQut2MWp1r70AzX1TEGe50TNtnjlzBeYNPgJzZs2pWaw7P3cLvffqOEbqK6gkE9+avGsA3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777249; c=relaxed/simple;
	bh=AlxXzmLfWq+D6zItW1ywrULZhcDSEgTTWmxt8rsSaJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqnWQP6mh1oC915UiCj4iFKcmxP2kTV0pKSIfqoSvALbb+Lxt9Hj+RdjrsdyMR5Ay/MHvKWdvC3OHvLvmGtEHJK3oM29ebe0gcfKyHANMpwjMn0+k0T+z7FXGp9tXOTcyVp3UioFZfkWODImPHnmQpFKojP8QWzaEdifka4NcpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4oGf3GLE; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzYrCMkqqPiHK2ApN29Ozo5YaDB4xf6ZlZra9hRkZXJmGzx13Q1IrG3x6C7vL5f1v/fmrt8bbP6f5svqqHEKpsJHb2dqe2yH/w5TfEkkIAswmLONyCrMHap6+gucypiBk24yYpMOl+ywYSZ6lGgFv8sRUbFLqVib0XOZJ2Oe4wkIZOIQgvWuviKc4OMwxTLcBM0yn5UxOmzhIrf1EA6H+tHH2CLZ4DsvvPZvsvn2Sm24AuNIXEoJtZpbnkfzg+k0JLGy8fnIYNHC0OxtBnM3OxorVZlWHwIPPlI03J/i5LvX05n0/aPoe7X05S25g7BMGSimMx58TatdXWwh6Wb93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBNK3bLh9MsL4VNrH0af+K69VTmOmWtxbO0ff/SGbsk=;
 b=icfdl0hpyvxkf0pBcm8lczeFal1eKxNfi3d/GS4+tzyDC9Fs77QdvafdCDdGIO/QIn2tCBue87B189z3mu5sczf7Gsc8V+VGv/LHCplzzSQ0REsXIHzYsxWSSI4NeSiQjodHpjGv8lFk68evZFbgWhdcF7otG+JW2eQBQgdwpcHnMygNvzXfjbEBmRpXSJp3EnxkyRlh4RsQ32QgvYngZBWjBwuLRECpBy9fAwFBdJKqE4cKPVa7sGp0FpFT3bCKdcrxrOH2jfiyafrWaHeAAgzK/vTY+a8J3AS/3mT1lYmmsninpZzpWOCYls2NUYFF1Qze0JfJG5OiuOba26JSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBNK3bLh9MsL4VNrH0af+K69VTmOmWtxbO0ff/SGbsk=;
 b=4oGf3GLEyV0hJ4HJBoMpATodzXA8Wkg5frwRPKjiVhNOXbyFUhymrBjLR2tt4vU5y98PQSTVKQrqxmcOF0rB70X0MkB794ApOAPYyDf4xaguQBE6P6dm9z939ED0MGW9oUTWWNyglvzMQFHfHsg78o56B3pV7SYpeGE9Z/yEZtA=
Received: from SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) by SN7PR12MB6959.namprd12.prod.outlook.com
 (2603:10b6:806:261::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 07:27:23 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::2) by SN4PR0501CA0104.outlook.office365.com
 (2603:10b6:803:42::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Mon,
 17 Feb 2025 07:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 07:27:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 01:27:19 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 01:27:15 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v3 0/2] Add support for Versal Net CPM5N Root Port controller
Date: Mon, 17 Feb 2025 12:57:11 +0530
Message-ID: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 54408014-934f-4c63-7edc-08dd4f2485b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yo2M0hluy3Wfs5dLpP3GgwH8KgznQhcRFxkbCmSNrbRUooOlnN8TPKOJ0OY?=
 =?us-ascii?Q?jHbDC1LE2HQKDakPxjO5qxVlXLSc+f4n+KXb0WkGwE7s0yoGjIhxKbi2B3EA?=
 =?us-ascii?Q?YFpmF6E+n07CUl5BOr5ipXzerSKCfPNV4eq5uOvqfTjaDrrMwiWmisLsHLR+?=
 =?us-ascii?Q?cu/CeXdX1Tf6rVaFFWKa4aRYX2GrVXmlK4BjxfFskCuKSYmIRMUQTXY7hVcP?=
 =?us-ascii?Q?aKHOSLd826Rmt0Fc9NNryy1pr0hXE8HhM3Y9aWBYpB9V6KvVuAuhuxc+wD1j?=
 =?us-ascii?Q?KKwbP3UzZ+D5Co0/1lEFQLVRbpqKhi4R9hsihYQApDAzex8C5BRsUptRTbkK?=
 =?us-ascii?Q?4rixnB0VvylIAsS7nDuBcgBmJzRL/v9rCfVFlsu1cpZyTzAfP9mDfPAr6NWz?=
 =?us-ascii?Q?GhYZRlykYTX9nBil/oRIetEl/TO4TZoz1vsOHCcz/Pgcj4Jx3LU8UMb8e8xD?=
 =?us-ascii?Q?f3i41sDHVewH0ynX+dk8DYjl03hYVxzbnpsiorWLev67zGidNkkunrc5KhKa?=
 =?us-ascii?Q?gcNLuJnUVQND4TgZBG9ek14Yl6IAvihWp01fx99gQLuf39hzSOECb8+vL6GJ?=
 =?us-ascii?Q?Kt8YpPx+uYG5n+sy+MWAzDUUyDd/fjU142a+4VBWzPCm7k3qVl2Znm5fubkk?=
 =?us-ascii?Q?L3QiRZzVuhnu8ZlV06qBnXM4fgTaicskJcbVhOLPZDdmEMhCJSjw0MV1qHZH?=
 =?us-ascii?Q?nMk732dens+08Jot4/zn1GZemI+8+VuxHCPvXVn1pb+/Anh9cwifwA/J+On8?=
 =?us-ascii?Q?Zkmsxz97ZsrH8nKXtyOZfG5oc5IP/Shf6/+cqTT1FiNRKdDkRvbIcsr5bN3P?=
 =?us-ascii?Q?CJM1+RmflABC3y9zkb1nIQk68vdNF3F/SR/+4HlvAP38OY5KRJ6i2/8tZm0s?=
 =?us-ascii?Q?gygfQV+f/ZCEdEqYuQiAub6OqK1j/Docrag5NIVA88A76fJ5ZMx+gmS3ZJTV?=
 =?us-ascii?Q?yj7eAq8+ka/0d705QJi9BpjgRttG2IOq+LMXb3hpj8LNIcWNSza+F06Qj4AR?=
 =?us-ascii?Q?vWf36coxwU4mrdrjp0Mh8Km4o6+RzEjCMCoM75b4gElds8zRcg0Py3lifQl4?=
 =?us-ascii?Q?BFmUB3owuvNOml4X6IAZy0z1j4G3Fq8Rp09yO91gFOqbAjIv6RWNGHFftyna?=
 =?us-ascii?Q?cm0zD4M7YFlHoNG92Gah+BFAPIf7DbPxj35VJnALE5cilnZancvqRtF2biA1?=
 =?us-ascii?Q?SEYSF9slOOXKIKyppUV/T2HAma4WaqDWG7mNdADxV0ZYVCZKTWcF0zxrJu+V?=
 =?us-ascii?Q?MDrY+VyzEbT1n+mdABrB4XOsw5kR0qbFN32I1spnVgHJNJnMQaFTCqFnMmUM?=
 =?us-ascii?Q?weZbypuZM4YYFHsNEGhrpoxPBuXfDTkK1UgxYwFVk2fuEDqFzylN2Uv0LpTp?=
 =?us-ascii?Q?vHmcjdXhUG6s7z6K+vbmWyCVe37FX3wOtH5P2H+ZqdrZn2t60Xe2T5Pxur9u?=
 =?us-ascii?Q?O22uBl6XFvodf38Hio9oJru6xSUrrAJhpVsi9D3DdiXHuYzXuQCODeGw5tFz?=
 =?us-ascii?Q?WJtNyzEHnVeU594=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:27:23.6312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54408014-934f-4c63-7edc-08dd4f2485b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

Add support for Versal Net CPM5NC Root Port controller 0.

The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The integrated
block for CPM5NC along with the integrated bridge can function as PCIe Root
Port.

Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
specific interrupt line & there is no support for legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal
    Net host
  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port
    controller

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 48 ++++++++++++-------
 2 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.43.0


