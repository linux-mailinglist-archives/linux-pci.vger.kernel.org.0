Return-Path: <linux-pci+bounces-30685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA3AE954E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9425A5817
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443421C197;
	Thu, 26 Jun 2025 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckOCMwp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A361A83F8;
	Thu, 26 Jun 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916959; cv=fail; b=WL4OeLadliNIU1vH1qBhypQPvhSh3P7py+gaQvB4+FXjBZka4ZbXCMCKR0J1e9+ScmWpSEkaoaTJahZpG3L4rVYWURepTXFWI6IRuIqgVc7grE2NRrKbjgO/m9VEuGoPg/65dSdrPh9+xzRcrswVwqxT6uDr2Lh9GOjw8H6tPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916959; c=relaxed/simple;
	bh=vND9Ppp5wOMU+4lTiRRV++6ZXGzYeyPpQk3mhlX6K4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iFpqdu2AsYrDasisETGiUUYv/QQnkxy7GPGhi680Jeumfgrv+GDKXYPTMBHwtJ+bERgK9PqWBdEeU3qXnS0L/2jkh6zJ7MLa/DlxqmIo8+70QpQfBw+i1QhpLYMkkAAHRuJVOEmo+WalYQbOn150aqF7PYLptLLPnnNLGz09HOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckOCMwp6; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY2WTO99gIGMyRaqYcXq+Iw3FKKEZGoK9KumqzjG+IdpgqcO5IZA+HJnpOCgpvHvSzyRbbx/g2gHamW4krGg36O/ISfLZqKRhBDEinNaLUIdv7qbxBEeeUWgNu6ztNQ0r7iwU9iEOwkx11xC6+BwEWI4QpVugE6qIFn52G0iVeW8NkaSWvi/hyYov9PcqOmhx27n1BYLyo7NjT0VoxmaeCPCBlpnpxr3ll76zS9TELlqjLm3/5D1RrkGwANYVkGmDlEsJeU+D12mpUYiUUL6f7p8IMEnirth2HuSW1O/NZpis+f2K0RU8Emw2yBb9xyNKdc4G5PSsn4E6SNd7LhHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJNQDy0UPMJLW5cnQcu9Tcqlv1T0hbkVMNuR7Hy4Xog=;
 b=ifxnKpHj0zA0IfhRStwtoOUmGyoiQihvO1bD5USdKC2U9/Rrxkm/n4whV0Lid27OYBTC4HQQQELN0yv4cu4ot0DPeMzzfpBwhMzgsu3jYywXQb1jS13P+M31JSYQrkAa7SNaWbcmzaEggmURDZQNvpS1weDniylN7UfW6Kop1r39/wSSwcqP+/N0Yx+pA7PIFu2V7pNO4EEkUUmqMcDbXF8o5f5bcFhz4wSjWLoh1dqyjaxGTFoiT6+5j3d3QsZ0qLMrbztLbp5gTUt8CTu+nCkvxztU6qW2QK1w9JX3R63CSg3beGAEIGej738AQR7u29nOAmQByI1dpynf6SpuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJNQDy0UPMJLW5cnQcu9Tcqlv1T0hbkVMNuR7Hy4Xog=;
 b=ckOCMwp6Ep+YoiuFQVaCgA2WRtZFqQaF1gsLptB6UjUa0w5Rsg81K+EnSB79Q5bvdGN2a/lp3hjpbEHT2usx97VzlZ9x1zwv5yf47aVioRjSZcZrQ/Td0p4roOrtTDIVJunoWfpTgNUkJQYsdTuLbNBxnRC+LxGZ1D7zoBxjVOs=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 26 Jun
 2025 05:49:12 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::3f) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 05:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Thu, 26 Jun 2025 05:49:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 00:49:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 00:49:11 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Jun 2025 00:49:07 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
	<thippeswamy.havalige@amd.com>, <sai.krishna.musham@amd.com>
Subject: [PATCH v4 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Thu, 26 Jun 2025 11:19:04 +0530
Message-ID: <20250626054906.3277029-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: e58fe121-dcb9-4304-b4c6-08ddb4752d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HCE8tUpJNEBqaTs1moNcfbLNAv04Jkzcu5HVmv0GsTdLMSVWlgiViuHuC0L?=
 =?us-ascii?Q?xmIAP3S/7hvAoBmOVjkE1kx9g0TATvn4HZMG2zMRsFtc/aQBcRJCaVvOLr5q?=
 =?us-ascii?Q?u8E/xlSmx2bMHhw3Y5XjUo1PBZtnsafNcLevaWguzfeZ2ZeG6JvTbXZOYs9j?=
 =?us-ascii?Q?V8+504UBi4HjTNPnn2arIqfL1TJQdrjrrqKVESTt191NIuLyVWA+DzTN2y8m?=
 =?us-ascii?Q?PKjDK6JgjD8WQojPMmIPATxDFqNLbuS8Dh+VnTruZQh3W4/VMfFr7WqBcz88?=
 =?us-ascii?Q?NRn30w5a8qx2ZtmHDjg0lVtcXXxxWYt9uGWgeYQo+vIeSm86zGvoa8EGVFoj?=
 =?us-ascii?Q?OQnPa7ZaZ3EKtaYQX0iZPnpd8wMP/daHfJ6sOMtI4uYGpEp5kEYmgab2QLZE?=
 =?us-ascii?Q?Uk78B6JXESjtud55GeVU/8h0UKp7DR1k//NJJ+FgdLpOrOgax+G73PWbE8fO?=
 =?us-ascii?Q?MnleXvmpDxMEGfmn8aM858ZDZTXlg8bYcbBFri8jl0eOpl1iz1J/7LMVu4qk?=
 =?us-ascii?Q?MiA/PFfifA8By32OB7Udf8aIykau2JYeRKEJM94+7QL8kaQZ6pyepSE+fDBz?=
 =?us-ascii?Q?gIaPRp4mzfZePOAUQ5jtCct1DRZ4XY8I4+pd9+ndmSGNcIiaH1FL9gj+olfg?=
 =?us-ascii?Q?WlHsuJYYmvEbZ+/FWm4sIgewnMFOfiOQLfMEhZ2v44v1r6ckZnFN2B1tDFXo?=
 =?us-ascii?Q?N9+n7XgeT4Zt1EwPi/k6O3Df9R2pRF7/YmopcMVa68+EJ4s1yq3kXqp27gjl?=
 =?us-ascii?Q?NYpCyA9SpalrgbOJ/8BRG0G3CFep/qmdpsp4lIyHOKKACl7qZCOggP5S6Q3p?=
 =?us-ascii?Q?QhV9cd7kAvDgjqjqfi1flIfJ7NynzXewLBLWONr3PHFFsxwj/I5+njQl0hLl?=
 =?us-ascii?Q?wLoAMGeCDK1ZicAmyxpdXDhmIwuOcBovW9pL5m7ABCq8AffmdTAc1QONzrEq?=
 =?us-ascii?Q?uwJ69C/6U8b3UpD9u2DDvPT+qAUgCHUEpaW67K9gVqSRFi846HRFcwexwnRq?=
 =?us-ascii?Q?6CvktiPiXVb34GwYR+E2eBJq4hhUW1JHXDpMtIingMharpNpJEmEQ+M6F5pk?=
 =?us-ascii?Q?7YkxSXe3bBvRW1PnayuE1XN8+4FFTdMumRBDjOfcyLZj50302K370THctLKP?=
 =?us-ascii?Q?t8Ug24AOESz/fxSr9yTKEeTmmXEv5/szxSr/qg01OKjoLxOyfh/IZ9Itqhi5?=
 =?us-ascii?Q?3N31JHeQobuy8oINVTJ6IDq4/odEoOiBR60NtmnW1O+Yg3+X6kojBdtV6npb?=
 =?us-ascii?Q?puOQP7NilQLUV0cKqtc3mmxHfSkmSDBMf+xrPTJfwtyMt5FZNAgrh5cTO112?=
 =?us-ascii?Q?xDoGFOyqaiUPUkDypvDR45aVpu0zC1SI/HmjXhGO2M247VbSjF0t0M8EwVux?=
 =?us-ascii?Q?PrRzFXv31/8FX37DlO2clIV7EnjaF+MFm+t+9SIPMbRf7+MvkZObOZKSamxF?=
 =?us-ascii?Q?V0ws8F2YMyfA1Xt9UNouQNto3lKhcZOlIGS03RFe1YrqoPA7Qxg4KMEhAmy9?=
 =?us-ascii?Q?vPnFXDtXC4DuVjooS7HJnBTwTBEc+seZskUz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:49:12.4616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58fe121-dcb9-4304-b4c6-08ddb4752d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

Add example usage of reset-gpios for PCIe RP PERST#

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
    RP PERST#
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 46 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.44.1


