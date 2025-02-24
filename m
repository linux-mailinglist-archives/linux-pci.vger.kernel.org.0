Return-Path: <linux-pci+bounces-22146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B5A4155F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67DB1895536
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97BE1D63C6;
	Mon, 24 Feb 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBumx5Ir"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A01624EB;
	Mon, 24 Feb 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378668; cv=fail; b=jvv9SfbkfzgYjcc4MkpuoQC5gYAH/P83S9XLnc/Znkl/1OFOqnw8O39xxwdjOpvKwdrnuveGNq9ylNl379oUnV8hloLq7KPv22bZotIdznMEIwl7ar6iL4TwdodAFzCdj1/n+GpLRLiLfLDx/zsUQzLhRirygMId2wBCCvTfzB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378668; c=relaxed/simple;
	bh=xP7ysYTbCEtHDccVL7ds/tTkMcoIKbw0aXouzLHCSUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V96MXUNJy/IMsUfUslV3doliJfoivtmsl2MOj2vGyVrd/EP+m4+5DCXZ9u5hdVe7R9gDaQpwlC7jf7YOPkCUp+7LXC6VtY2BinnPACDNeZR/nVyah5MDAb6eY0mwoM8rnXGiuZ6WMZnICJOvkK5NaMtf3K1+9qnCh3VQ8XDT8PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jBumx5Ir; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAfrFcPwtwVbZVUbLea2bHBvl/65SRYeX8rvrw87WEhCIJDcJUrO1OC4VMEm67RrEAioUzxzciFTFtIX+p1d4aLjS8ipkf6sZGpBjBZ3l1kisryEhNwsfbd44OJ33FdAQMEPG/TeWsrN6YAn8222aM9F8oEjiTHtEWupWizHO/zdw3PCwRbItKS7iMCBpNOHPPKsKKpW5OaOe+PRrKIERYvEXK+ZOo+UCtIZYxS/tzE4OXxWZHJI08yoSkutWw2hQco9Ojn2U7ovgERmGoR1IqK0GvTtcoszaiVsxHu2anKI/7XitOh3su1o/1qjFcdxR6GnHbKcjXqGlWpEWRV9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0FK1aoH7Iwl7U0du9DLi/lFPrNThjQc9HuqbuKtYG0=;
 b=sXp7NE9QnXoVN11FDuXiwc3+xSahD9KgsGZriifQ0asIWvKuQpXBNpLdCo6cl7lQWwF9Fs8gOcgPyNHm6TiO2xY8PtZ18Qnf6QJXitLsdVYDf9yJqF9trpPwuWS5/6auRu+CN8uOm7z6QPlHz3RnCwJ6VY4S/ZYT0vg7aZnJwYyZWBsF6UPcVD+ujlHioyiF2/YtmzZu2oBKJ2nZ0nJaTpw1gHeKBC3Yci4oZfCvXS/ipSWfUSM5sUWKr33UxV6pxVTEZgaO84f3KYqggtdDJZ1zN8KtNlJ4UwNe9r7l6otLKRIm2X5J9yyt43uHzas0S01seXiEIUT8fS2cJVpuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0FK1aoH7Iwl7U0du9DLi/lFPrNThjQc9HuqbuKtYG0=;
 b=jBumx5Ir0aSlzZ4jW62rY9QO4eNzLH/mLRlIFcNVjrhIGTtuQA/WDtR54pz2nHFu7aaph+zgdpNtALzJ5ad9gdm4nxACJf1TrMoBDRvvW+cjfshLQW8+kY97YDgMzRgPfRrSaaNFkj9HTaQhbDNVFryYZxuWV46c4mvuRxntK1w=
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:31:00 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c2) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.14 via Frontend Transport; Mon,
 24 Feb 2025 06:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 06:31:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 00:30:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 00:30:58 -0600
Received: from xhdlc240022.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 00:30:55 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 0/2] Add support for PCIe RP PERST#
Date: Mon, 24 Feb 2025 12:00:44 +0530
Message-ID: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: f42fe449-aaf0-4fb4-2534-08dd549ccde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E6Er1VsbyuzxMAvZoydmt2X9NhV4KlqONteOEkcRb94INNB4Jqnf6DZTEVzZ?=
 =?us-ascii?Q?KwCGbwZsArYlCkzwLNSKdM6gxhALcUhGxCek5Z0vR247qA8/6c6dGnwQBMA7?=
 =?us-ascii?Q?CkVbSEApZrP5XbBjtVI1+HqCj76Lnn1049k1MUSqmzlDZM0pNr1FooB3Akas?=
 =?us-ascii?Q?XKJ7M7OdU2O7+fs0Jie9rK5z2y2OWXwO1tWii4GX86YWIznz59f04JS6tFhI?=
 =?us-ascii?Q?WpkaHhMupMfPQZ99r1IJyvcR73J776RiIQu9y3IfFtiSNA9TDvhoQLS7zSF8?=
 =?us-ascii?Q?YsxfNNPmKxEciGZhd5MJ1yXcBN+x/Sft04P4NwCRn4ywJfjvgfnsMslCefaN?=
 =?us-ascii?Q?/oJuRczAXmHIL7+AjCOLr2VzZaOVWxOb6spN3511izDYp6h1xC/dMSCPLd9f?=
 =?us-ascii?Q?NfuB2mV9dH8tUDwaWGF8PvcDJcDdsGvShC76QAs9eQV9pHUR7mWMWTE1uOqS?=
 =?us-ascii?Q?2PZpWMM7aLjH3NYOC1ABKttbCzjAFCjCkaiXycLd/kert9EDMrjIGz4FFXBM?=
 =?us-ascii?Q?8BwjLy4MvA2j4jKWLvXAd5AdSE+6asY7SG4zBW/SaWn+F3WTuqxkvNUfa4or?=
 =?us-ascii?Q?s6usNnG7hEs91zJqahNVhmwWdKagEChwGfxitDcNpo0EryacO+t53pt4glL0?=
 =?us-ascii?Q?fOYDVKQq+cauwOm54MQJImkbdP1mhHlLBSf9M1ItFNm7ZeK6Ty6AgbXuoijv?=
 =?us-ascii?Q?XlIwOKoenAAag8kHBW9cDhcxpQGu3M0ipJ8jcFkF3Q4z7Upf5MWX6mmrxZRw?=
 =?us-ascii?Q?ixcbAkOm6bMnKPOtjLVRNygwKgMPPyvRUE1IulyEgU40atMWWHtToncT6qk7?=
 =?us-ascii?Q?mPLSAzuvGm5/H44tepOWf42s0ZcUZdczs5M02128ctcN9J0Xe3uCTfQzEGIE?=
 =?us-ascii?Q?X/xRFewebsXkyTERbZOI9nsz3kGhkaZXPXhqdRHpewpESuhprsk4sT2d834m?=
 =?us-ascii?Q?DFXzpQBhbUqKbppsoMStKhs0jhcbxUspqYV8AvV2BMyYJdNjvHvsKPY+LSdR?=
 =?us-ascii?Q?nVZrT9PSIGy5lbuRKyFq2/2X4KmOWxTviYho+dqhpPpxS996CK/r0Smsom8b?=
 =?us-ascii?Q?Gcuo/aUE9dKHrsW1hOc55pPEtWWGYTbEJhvIvXTlzeHYbGtuehKos53J6Mnx?=
 =?us-ascii?Q?Ev78f0oAXOsUyBuYPtDZs40d1uOzJdIZDJEfksDIJZiwny9JHy9fdGQd0dIB?=
 =?us-ascii?Q?XtJAVVSQguRm8yWdleiQMyPKpS8r/gZG5wh6oId6p073gaydnWrorkxtZzHP?=
 =?us-ascii?Q?2Z2WbphKqTqTY1kzZR5TZN8wfxFfPjqRSXqM/hJySdMTAymQyZb7itLACcuj?=
 =?us-ascii?Q?baUQKEYd+K7QQrUrzbD2fanwO7Jg1K80e4w0UkhQubY7Jd80Yh30uSKxPz/m?=
 =?us-ascii?Q?wT3emrvbPgc3AH7UoPelRpKrvcMJN0Bd+RwcP32yLqGZUvQOPsmsIQZkdpC9?=
 =?us-ascii?Q?ucX2O33bXQeN2hz9oAiG4jgVsHOF+Pi982DyzbbTf+7jl/3kLx+WoAD4UD+1?=
 =?us-ascii?Q?bjxVmEosnGnH2dY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:31:00.0540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42fe449-aaf0-4fb4-2534-08dd549ccde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       |  6 +++++
 drivers/pci/controller/pcie-xilinx-cpm.c      | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.44.1


