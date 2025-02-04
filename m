Return-Path: <linux-pci+bounces-20697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048CA2724A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A903718842B4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0F211A15;
	Tue,  4 Feb 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yu+hrloj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC241BC3C;
	Tue,  4 Feb 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673200; cv=fail; b=kXpgasuulI2t/JBw+c+cRaJKKS099DoAGJfHC5cg8tvxA7zkTBWvdUazyULLWzobMZyTvVzu/7hdTcQEhPyiFgfLCd2DHQswvgL4BOo+2cal1FUcRz0aOZ6AYp+fiTFo04mmYhCzUBvZdfqTstZYh7NF6QTP9l36pasyftaM2L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673200; c=relaxed/simple;
	bh=SlHA42N8vicuBD0LsTxSAFmTG3EZwu+qT6RkjjaZ2x4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4hctSp0rP2lfO/eny2tOREX8uTXJsum+e3/4XK5zkZ2TTqRPG7FQzMoqrvJY3mbz2d4WFhrfH4u4j15sjq8J5Uf/QxmWPdAbBM/Ery91ezqIJKCDyHOru2vMnertXVY4FBjRGx1Bs5hO/wwTyI0hK4OljA7PkxM1jeDmzE50V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yu+hrloj; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhAalrPxvTdqnoJaF49qu6OHyXXN1mZuRqRB6l72PSZ22FgWuN8Iuo5gcYLV+0O8Jji8WeNmyzKI8DXkaYKYMGm0qV5OtU1BSyDPGqE1E3budAGxSrnQVUcc8ECNRQiZjGwmyAqDLxNNz+Td0r07O/LzGlQKnASNMvZOE+97QOBV88a92nUIh4X4qMr3hvkqIckih6cmI/qCiszj6sN8fvXjCGZPb6d3mIsDbh+v4XFz6RWeAiXFG0Vhr9HRAWP3d1Yws7LSHr5yTRks9/It+ufJhF9FrSkJZ5z8aLKkUCCmCg0VqC9C9zkqeDqPsBrndDgMsR19l68DT4WvnyyE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=jtCcvJ4peS3FYLuOUpYsuTtPh8gWjQJzgcKTu09cQwS4BZdLm0LKaenJZWWsu//dsCKyqN8TYSjOYRFYvBSFXfpJgOg85sy2Z0QMO0LGG1s0Ts5KUYAVgt1m/z14benWOgNYlyWKBJ8l5vMm9UJfYzycmWMNG8PbG/2x4VJ3KmJ2KMEfGJveXPzPzmbFZDA90nXG3cwVdhpzt5mluIpTC21VmhyefeoOrUZY5CZZPlbX7wlbKnQnvwz6pAGbjpxmRrFIFlLbRwlUgnm2vcaf+T3iageHJwGJEuzEISPIWRj3Ax6RLtr95qQTFGG7HsG1NdNVZdF884DpJTs7n2za3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=yu+hrlojW8iXySU5PVqjgTMpTXeUQJFN74HAemq3MfS3p2+YmV4Keiq88Gm6lLl6daJfxRDgyrGCQCHPyY5aYJX2wfBwvzsItPwKxdtd7zMGJAXL/mLjlPskWAvooB6XKteeWOwb0METR/DRapszXka8qj8sJo8UBcKHIyl5xAA=
Received: from BLAPR03CA0097.namprd03.prod.outlook.com (2603:10b6:208:32a::12)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 12:46:35 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::80) by BLAPR03CA0097.outlook.office365.com
 (2603:10b6:208:32a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 12:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 12:46:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:34 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 06:46:30 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v9 0/3] Add support for AMD MDB IP as Root Port
Date: Tue, 4 Feb 2025 18:16:24 +0530
Message-ID: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a5b7d6-58e7-454f-8e52-08dd4519f56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/g40hC604/1RO9kXW/Qhh4sMsGh2lQcXEDvsHby8rNUf4hPlskOmNvsjy1Mb?=
 =?us-ascii?Q?U/LWoW9XqvWFDIcRHGhvfSnjrz8WolBT3FEKUIjCYN1n0TjTaB/BBWpDGaJp?=
 =?us-ascii?Q?5QFC4d+6PdmuKDC0l8ErtFrhvEfndw++B0oQrmA5ecSfAnTKHmPA2avqHhsO?=
 =?us-ascii?Q?XleOUVnM99w3Vixc4E6WmBl98G6oNqn+Nog6xHbN79N1DdweKJbHBpKyohvw?=
 =?us-ascii?Q?Iq//diw1o8D0zMfgXR6JB91/OD/4RFbfRaA0/nlbjlWaQ9Vm6U6hwTg+5YWx?=
 =?us-ascii?Q?712A+3O3x/EvYQeW/KSzptoK/q7f5a002k9YX8mneUv7TcxCIH1g0HrWsnbY?=
 =?us-ascii?Q?3RVbQgcx3IUM6J47+t35v9CPpMSqHvts+pSf+ORdCVurHpnYfmCU6obYh17d?=
 =?us-ascii?Q?8KDeVf4wlAzvQAAYO6mFdueL8M1hrpmcywRghBCjwc9pJM2Fk4Zux+Ap+JQx?=
 =?us-ascii?Q?l3bzftATs3rZ168uPK7JiB97lmKEKgUvVR2zp6sVsj3iNA0LbA6f4ajJA1iM?=
 =?us-ascii?Q?dUZxjCjAadKZ1vpX9wzop8p9Q9Kxm1gMEmbfnpG04tk5UcE1kY/AXBi4R60d?=
 =?us-ascii?Q?b7G5h9vJYB/bkYUt+pgEkE+p4c6sKIFY9hrIjxnwmEzosr2NSAfBfH5Sa96j?=
 =?us-ascii?Q?HDxzkS+eR7HAatiPEtRZ/tEOfH79pAgg6GrZdDJRa5b5OVSSF4mu34EJ3ReY?=
 =?us-ascii?Q?hQ3pDPVp0nJKTQB530zpCebLEocirJ0mT0eP+2IEbMwvOnZY2j7DxPSfAHnS?=
 =?us-ascii?Q?J1nbeVDtNBQM9/UBq0X9XM+QmqzqbpBVk92Qkcq33XqrAdS3VXyvkDe06Dez?=
 =?us-ascii?Q?bDm+Vm5+LB3US3JUqfsSghSQ2rbh9U/SgBdxSGsHkqeA216j7bL2np3O0lmi?=
 =?us-ascii?Q?H4N/0W12BnGeW9FiJjwM3/VztXyTaBicuCgUxFmwoGNxV4navWCCns4ygOXM?=
 =?us-ascii?Q?ucLbAQMvz9lVjHTwaZuEIOkxqqUYk9/Gz+zvypytsFPdRSRJmGEGxPbhbKV1?=
 =?us-ascii?Q?yDzq2L5mX1Uhpyo30t3mfcqtP5kNgA9FLbEUdvWhZrSSYZgBqiOlytHfJ0gc?=
 =?us-ascii?Q?5qZijiGy16a/LxT5vgHY+cOV2fmk3FYoF48dP8cAEWJr2ZDCaMh7CntujDqI?=
 =?us-ascii?Q?RabCjsN+sIyaA1p4zhfVSMsROVPnZkonjEZXlOdrD1moUc2PRKcIvIGLvUj6?=
 =?us-ascii?Q?SrCF5dluTlo0wuI93mK6p8axzU1o4EfwP01VDPNjFgcJ+RnfAgznga2RpHiK?=
 =?us-ascii?Q?3ZpNEuWWIb5uJ2+4ucJanDJBeEGB0ahQIKt4XLoAASpTjjN61qMy5/fCLsbA?=
 =?us-ascii?Q?QW/cDGAJ7mKg2Q0ROELNve+w4HYuNEz10nKlQktNJT2m0nUZ00ls75s0y9kh?=
 =?us-ascii?Q?nexZOl9mXk/5K6NWCUTrzUPMyJ7pw4TWrfb55nU3ZqH7mIrkI69TsantegYC?=
 =?us-ascii?Q?A3J3DrtdiRMKeiZm5DUZKlYm8P1Lp2NJpmRbHhO3iRoCL2GO+o8f7woIcXIs?=
 =?us-ascii?Q?CcH9T4APdOovJx8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:46:34.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a5b7d6-58e7-454f-8e52-08dd4519f56f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 474 ++++++++++++++++++
 5 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


