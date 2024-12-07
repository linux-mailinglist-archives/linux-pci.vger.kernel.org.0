Return-Path: <linux-pci+bounces-17875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46E9E8126
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB016550E
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748742A81;
	Sat,  7 Dec 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pknP0bfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD389460;
	Sat,  7 Dec 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591507; cv=fail; b=lOQ/7Da37UBeoxoZveXL269Sc82ViIQNSSoNyibK/yrNntE+eayovT7AdWLbWbqTvWk1JPDI/PpoMSgn17kg4fG4LczHvpxggRi4WLkXpAx32k+Hvl2t8q+vCYToZsZcgHIiuiOLEv3/oy9y0ZlBKz2KdlNwFOe7nOAEOsRZbhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591507; c=relaxed/simple;
	bh=V061oBFHHdLp7jlGcAQ1o8Z5TQhPnPInVfL7fYSs3LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EFONUS4e4faKaQOcAa5p7o4Psw8oaFp6XQOJV4ONFe02IV4IgkxyluLNqCz/Nll3ctzWbb7/jqFFrTGHUx37HJSj4LhMeNKLDVAnsMUMJV33IhzH6D2mHqUmg+b+BVtHnc73E3tT2ZmCcSEo8AdF41zAEV5q5V6xHdosPxC5API=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pknP0bfF; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y57JcMxM2vl42i1HpzsN/lkN8pu9tcEP+qfSUQWOlkFa4NsvYWLJmxZxnxqu1OkM6IhljOe51SihLSPIOYhkfC+XZcJNqfMAsFFkNGTaZBsaNkTroqyMV206VIQz9nuEj08tDddI5hPwUPVTvU29gF3jzLQT4fehT20QgjVZbQpec9JTsZqw2GyI2CzcumBWg2zYI51nKV/1CFXYRRwPikMYuUmarF3vg2V9yIpQWwI3XUpReTO41so7Cu/BQ7if3jEm75mJ+mbEfaaD7CcRau3rmgKfxE7Cruzxm+5St3bRotVTfrOawSf+oBBwQGVk8JcYaBQaRs7ohzJ0z9812A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=qatVysmYObAMcP8zQ9TvIDxPWC/bphc/05ZWuAT8oAONDttE11U+HxukBgBhuqpnxWRwkzuebW6FQmx04gzN1ByDye6q9wdQdsVf4e+hC0BiHTfMnOgiPCW1yCzLfUTGOfr6E8jEAkoXcn611vgFgh8q1Xd7D++nYu6xwDzD1XQmko5Z1e7UY7Ml+h5FgYo73bEXDtTA/YbIowNieDCeVTLW42aMeBDuMDvtoIX8mhipmaJXCkorvB6EFDW3tnxrxdrZTkevdg1yiwgBldETWe6vdTPACDK03YwrxdbLKxzZIgp2mSkBQiA8kEaSNbYoozxSQu8eKjJIeLcgp1aDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=pknP0bfFvFkDFpZAIVQAHvd/POd0KfHYmjt5ubG7MJGuEQO2CT9ObkX0eENbRKvp8iXdpr/SAS40PkvX1/ttkvORMUCVSqP7exUIOYiOhANT/zYBpKf3/18MRGvHG7CY7PPXxr67a5A+/ZjnPGAOKNZttsKm7POC3bWMNPPv/A4=
Received: from MN2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:208:1a0::12)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sat, 7 Dec
 2024 17:11:41 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::65) by MN2PR07CA0002.outlook.office365.com
 (2603:10b6:208:1a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Sat,
 7 Dec 2024 17:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Sat, 7 Dec 2024 17:11:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 11:11:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 11:11:39 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 11:11:36 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v4 0/3] Add support for AMD MDB IP as Root Port
Date: Sat, 7 Dec 2024 22:41:31 +0530
Message-ID: <20241207171134.3253027-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7e67a9-461f-4f0a-4e0b-08dd16e23808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKURxg4u3AAfzJy5vwPosG2i5mYI4V8x323nEPl1xC/rNBvflsINPYvtZ9Ls?=
 =?us-ascii?Q?gcpx0YykL4w3EpYZ7B14y4bfNrzMhTtT9jO3HY+J0AMk23ZYxTkMlAe1J+Md?=
 =?us-ascii?Q?oPVT4v87iWcp0VrofapkTfECBz355YrLPHUiFSI0Sn8lR+oI3KdcGGZgdNrD?=
 =?us-ascii?Q?DWI66lGbqDRaKYj00qVFsvUeZG/7q01SDsdoEYEyohc5gtTLa2UnaQVwwtK6?=
 =?us-ascii?Q?a4fUWZIazO+U7LY+mT5PJs03TqsBYI9vKLIWx/b8XiI6GqkGRIqdeY8G/Phf?=
 =?us-ascii?Q?Uq4C2lxWuoNWTMTYzQ5TsGHW1HkXWXxnM91fv/xwHDT1RNMuQ7EhGofDww0Z?=
 =?us-ascii?Q?dgEFtwOi6qm2ihJpXk49sqYwgOwz4b1rI4SiW0xrD+rosjbz0Zex4T8FGvo/?=
 =?us-ascii?Q?T4u8PiRoCwQK1RneEX3CKZlmLKjiedE/jkKS94wak7k1zZQQPwy1x23S3Hev?=
 =?us-ascii?Q?y4TCq00gjxq/aUAwq7aO0zLeyRuFea6Fuo5ve8G3tjXaAg8BDJ43vTuJJtvb?=
 =?us-ascii?Q?G9DptUW75NbX6ZuEtfLO1TUxP5/SDtd0DzLAHLP0Er3m8bKOaBLRdLCLDNZ5?=
 =?us-ascii?Q?6C1pBTKHVa9DB2hqOI6k7UL2RXGw7QXa3fB9xyNsQF+MjIHPG5nWGAYGRqM0?=
 =?us-ascii?Q?jQXj0yU4ZPiRRDCEbwDH96xVyX2ZGy0DR5LgdbOa5f6krvpmH+DbrfUgiTCS?=
 =?us-ascii?Q?XVDxrx2BVgXHhQbhSq0hzM9Iq7mcBGvlu1pze7BDLOQSaxTeS9A0pbACsAvq?=
 =?us-ascii?Q?l6/1ssIVyKDKYORBuUfnl/WDUhXJKUaLg22Hg4mi2l4361io6fJ2bLigKv+N?=
 =?us-ascii?Q?npFV2m6nn6FQ79FtK/nKUwZy/Sil3/1f3vz7tfDvY9jMzyoLVqlzgcHoK8Dq?=
 =?us-ascii?Q?LoNCkdSXleAe4zUm31aoTzpxdp1/HqIRcNEqxtZ9uWS1Nq59xk3ImKtPkcIH?=
 =?us-ascii?Q?kp8wQqbCDahE4i7/FQZMpRvqIYae60Z3dPVHxQXNdPIR9GtsJbo0Wm4etowR?=
 =?us-ascii?Q?8Vrv+ni05CZrwiIwDPPxlYQVeGkqJI1PXawPPFWeSGBl6YxSHQ+RN7/7LsQ2?=
 =?us-ascii?Q?j584r1+a6uDxALJZztEU8Ln9M6aKlCqSn/oHJrvvm7k21Kwj543MkDxjsQTK?=
 =?us-ascii?Q?b50t6Zzv1JTr3N6dyj2eWtVTWjOHPNETB8bjLLiYG3Z4xn7R3LhKBGMM8bh2?=
 =?us-ascii?Q?SEcaKFTnHkXjCWIdZ5xx3WuG3lfPIvJM03M37BMK/2MmJi6z972v22bN0pbX?=
 =?us-ascii?Q?7iuOvCHPedm3Ga4V0hlCV76GlJ+YS5Dg1odenplyLd7WbMqiq9Fi4efAy4ta?=
 =?us-ascii?Q?3rLrLkK/SNfP8cK6V4FRDE+YSS4QUzxYMsKsjqekbGPHApDPWeqxeO4VsTpN?=
 =?us-ascii?Q?c/9PYhkIeJipt97Vu4OkdkafCw7i58cOOVQIN6soTfs4/qCodtpdgRvxVNIs?=
 =?us-ascii?Q?58LUSALtnmTaJWXTxDdYYMO/3QVNRUpD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:11:41.4185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7e67a9-461f-4f0a-4e0b-08dd16e23808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 439 ++++++++++++++++++
 5 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


