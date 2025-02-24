Return-Path: <linux-pci+bounces-22158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63573A4164D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8CE7A2284
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53504148855;
	Mon, 24 Feb 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r25O98/+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CB1BC3C;
	Mon, 24 Feb 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382298; cv=fail; b=A47fsaxJzzo3xGsKTMuUi5xwsCg5EBOLFlcSnExuFWi/I/cqFT984piudLCCfvJJLa/j4SXxpJAQ7nriXVlmSXx+EIk2G2LfTbtuBtb7TT1uO2LN1J1VCzRTAuPAvL3CZs70crZo35LNTWMbW2ie/psItjI945Ml1ArNMmQAnig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382298; c=relaxed/simple;
	bh=aSk5B5lpxfvjqPKroxO2vD+p+ThgOtJoRxQtDh2yAPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkzIt9vzRa+PxI7El7OQ+dlvU5Y1FvGoKc6H4Jwo01awHhwahxt4Zio++NyQoA7eI0z0qvDk52daifJ8dLID7RXR80k4OoLE17PM2Q42C8qXjPgmZqRsjWZCJK9/UWOdqUKHx7HNltdf4L0yMRLecdfIx3ohsqYtBM7AMGpOl9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r25O98/+; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKuTP9HvjrhIbHPMs7HMUA8Y0JK/gjob90eT2HyQHoyjdvJOcJ4QYuJ8PuEO2df6iS+KSOc4YOMG/m2ge62g9ziyLjPFkFRrba/R6RDKBrJdKD0O7A/xpM/D+tLQKEPdrDTndCV57wJUBTjHGkyVK5QQiG6vXDQ8FwoVtiBGnAyypIuJkrJpRhdXVYOLGzP8eef3PqSjzzBG4VSaVInE8oAs6ZPd/XDBRSnA6WpGvzKCrBduEmcag4jFEdgTzjVl4IUQtS2/+1JTCJxws+mw2nXfqU8P5peWXE65RIxFeuHVL4mTANPuDVtdCQuhTc5EfLC/nCOX9GboWfIv6qFMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhukL/MRiJzBEp9WhQhJYMTpvKRPoGuD7Hv4g+970Tg=;
 b=xYafvduA6dH7FgBgT+rawsqAEfncaGJ2FPmfeRSLgPs2mCU/jLbssXsrT+ES38WT+sM9uDAnaF/6al8kLK86jMsCFSEIdrZ12vZhiEbpc/ZqVqHaLadDVkcu+Ci9n4p3WCrO6/9CLS6OLuMb2MIghWiRygd7+jpywP/MasTwN9U3MqPSd6jkah3Q8ZOj6M0a77A81ul4o5t9P5cCB8z4KGL5BT6+19XPZyQrJe0YKJx39/g2GBaAyavhQreWtw2CEk03pxqmZU+ZgKtLW/IxtKhB59Tvr2L8j1mM+Molxiitc3As4jniRZiCgimR+FIeLq5JwRRbNPx3U/PfYVxsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhukL/MRiJzBEp9WhQhJYMTpvKRPoGuD7Hv4g+970Tg=;
 b=r25O98/+PWbDZpHp/49179pHKd464Vs9LRwEKpVZpQzDUWNkNmcsuBY0iOvnRH0LwMUSG1xkvhchy+sML0cX6fIi+FX+Bbp5IRRsSfV0Tk61UUZG9bBt4Yc3TnCt3F1YrvO1AMrxRVDnpidt5YtBibQB33Fh3/tkN+cTVisJCHc=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:31:24 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::e4) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 07:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 07:31:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:31:23 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:31:20 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v14 0/3] Add support for AMD MDB IP as Root Port
Date: Mon, 24 Feb 2025 13:01:14 +0530
Message-ID: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: bf13c252-aa52-4ee5-9765-08dd54a53e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?No8hAyj9h4FxPnM9dzTS9p/mzc9RVNxwTab5bc0RCX+AgNSZAb9vsLZ0SAcZ?=
 =?us-ascii?Q?P/Ow1nG8RFNmB04arH5p/oMyJFpeNn8Ayq2/4JvveCd1cakpnGJN9Hd55kbb?=
 =?us-ascii?Q?ldmZLGHX0i73vWQFXwyvbQqUl/cxBz4hvpbTTZUoCtYJLMfP4ofa/K4LVu09?=
 =?us-ascii?Q?qSOvSsC8sSufvz592l4cjEUuXcs6DHPlsSbkYNeatpvVUuKVB5yrxurtxHQx?=
 =?us-ascii?Q?TUMvqkqXkTfI9BtcKXCQlEPWLv+d2Vtr8lFvPzPcJK1bPZn0lPAgv0QSN9L7?=
 =?us-ascii?Q?6QNRXAsaDfXrjpgoT5pQNWYKRULxocJLPGRsLinc5MHwK8N/Ci5iZj5U9UIx?=
 =?us-ascii?Q?1PufsySH5UTtMU7nyiFkxUpvUb2CfM7EKjfSYgoHuxwLeaE7sr0yGcVsABTZ?=
 =?us-ascii?Q?3l15IWiJGoyDtVF8GZl5gRu/2h0U8aYYlz7/1q//fc/+NXP5KFlgJ3qzCMYJ?=
 =?us-ascii?Q?bQRVrBfAe9seKf3ygLj9P0FymcEazVmyAY4Uu/9YUaQRuvIPqa6txMxFJiXx?=
 =?us-ascii?Q?7iSV6CnkOALDGe1DaXOdoB9X2az3C+9ayg4i/r1xrUNUvLimH24sgoAHW0Dv?=
 =?us-ascii?Q?bUbsuslKyLQ5n96f3UtRAFnwwuJtKLenqfFfSqadSd7acqPIwTcX5iyybnO+?=
 =?us-ascii?Q?naFDCtAY1sOz2lFplhOVR7AvmQNLedUaAt+Obknx0Gf68xd9jTMnSyVTFVRM?=
 =?us-ascii?Q?elSzuL4dgtyxsDsvRrrWro5mKhMU19VVxoarOCbEtstO42uKyW4Ko52T2hvW?=
 =?us-ascii?Q?PUoj3kjclWdJdRQNLrVJypADuYlj1cda0DbKm79MDQAgb0IQoikHchuWSv/f?=
 =?us-ascii?Q?7GHnpsbXXByJ6ZopjW4VpRveaLoeoMHzcirF6e2Vfc3gUoq9BiLCZOtq9hGr?=
 =?us-ascii?Q?ChTZ5+lXEC6QGhlccuE9OBFVFNtJJvQ1wIGxke4XWCYkPGkWjJYaplBPuoj+?=
 =?us-ascii?Q?mMwfRd2iHRWZFXRQuS0tsY3mY9vjzCrEclnhaEMgC452mO1ntLarS9Xj979v?=
 =?us-ascii?Q?OU/C/yGTULjqFs8GZK5HMuB4jadEjJgUHDjNrw2GzZTuUY2SUgCbQOTnVWO+?=
 =?us-ascii?Q?EKd92TuZtB3xR7t880UNaU42PZZq6EIZjHVZChvxKYCmbSWB/8ox4yFcwYdh?=
 =?us-ascii?Q?VK2BY4sXtO1oBoY66ftQ6RC+713iZZLL5kMl6pQJZ/QFOaoq+/4v7hJM0Knk?=
 =?us-ascii?Q?i4W2pAE0Dtz63OAbu+tgFpKkGEPQqumwoMSvDBsheZmSHs3ehyTwMWV1wJfo?=
 =?us-ascii?Q?0RzED6cyjz8gAbRC+/A6GXRS5GePdqMZHxDSih8cim8GdO9k/+T95v1Ad2Bb?=
 =?us-ascii?Q?5YK0o7lqcikhdNqVpSXtlL9L6Z603GvDEMZp5HU63KBhyl7DaJPAc+Yy1mk6?=
 =?us-ascii?Q?yNlo/r2Y3k1HF5ythjved1YFgYaLm6kW0ckmZGdH/U/AlQJKqDe7iwOsVt0J?=
 =?us-ascii?Q?2lRpudoer61kSMxiEqK6SaDoIZ+IFSe8Chz2VbGEsSfHxnVBE6vhzUb31jox?=
 =?us-ascii?Q?4oqKzOCpTmQaNpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:31:24.3818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf13c252-aa52-4ee5-9765-08dd54a53e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 481 ++++++++++++++++++
 5 files changed, 616 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


