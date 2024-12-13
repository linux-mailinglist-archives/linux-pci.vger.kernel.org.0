Return-Path: <linux-pci+bounces-18351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB29F04EE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A511883A2E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567E18A92F;
	Fri, 13 Dec 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DUr1px0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C115383B;
	Fri, 13 Dec 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072059; cv=fail; b=TOgYm2Xn/P/Lrq1erKt+khmA0i2sf5aY7oQFJWR2ursy+ps6McnXfok+JA4kjrhlGgcTtklpFOayksF98T9Uj5gKX3AhWYwC2ydjUvmBmNBU5ODHszw3V0jN9Xgh2pj3d2z0nuWbDcZyWgmGpMxvRXO3syEuR40OM+lM3q8xeek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072059; c=relaxed/simple;
	bh=V061oBFHHdLp7jlGcAQ1o8Z5TQhPnPInVfL7fYSs3LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlMIQ6rXGw7EABWYHWJ+BOrHa7bMG63BHjjH4O3WZR82PwrpMp7qiUkbqmAk5nDPzmfz6LrXRBPs5T0AmnepJxqLCEmuReeWlv8L/UjVi3z2W9m/HimLpE3CfPuWv4w2v/r6L11PKEIYMccyqeZteAEZxsRQ8vqoFo5M1Y4GKo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DUr1px0X; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNUBz6v/AlSsjyEsnrpENGLHLuDMKwBAKAo2cWtGjrusoNpFB/uw1cIQP8/eA7BUqP9neQ7kXkKfhIQRWtZcibzU1vmVFGU1KTuTERiaCvuN/jcnx3Br/VzYARsKRevDK6vh/1kfZ2I3TtAiQTbf5We9iVDXKGAtFpBF8K4mFel5yJRqzC9n8RFbqxU+7p3bLywQGL4h5pHga3tP0qLBiyDVoBqjNMuGX+e/zBHnXgt8/4+qVgBTCJ751okQ9Un5r4c5Nni5+evs91tOw+CtzQaHVYzoIP1K6bmttKd00vw4UbRsLOLo6Etu+cN/8piuW9F44ofxQ2aFrCHUEQrhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=CY34ZHkm0N41T/iLLhJL/Kwmu/6Zj5IbO4dEAwitG+LN0zQANjHQjd39lzZdYrYHV5+gmR9ysTvfZ+gKswgSfe27frIqk4nXT5obZD0z7Xy6hsAcDWQu3JMPY+PA24COR+vfH4AYGEF6TP1/TQME7j71aUXTGNAZgtOvdDmdXtHMGbVRYJHhuTbliGG1BVw8ENUnSCVIbhpUEu20TogVaFEVd/c9HchVQqBheKNUvm1ZeHTUdbtllkP8+kMfM/2jJytNs1/jWkre4DJDlkHHWVpMxqhgaMYl1htDRPQLVuk0SmnDTYxPDpqsvhmbBV0+TvcOTljlb88K9yE97CRtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=DUr1px0XIC2FZbIKz05UL4wu5dnCm3vBatApORFpal8wmALFDoRGBzWwca5UIZ9pyG2V/AgV0VUS3Lx05lX/izITFPNckSjlU5Hb9qz1bmJterA+CHuXaHheTnq1YTpd+Lj6a4I6389MtbhgNkqPZLoiNowSkHjl3l3v6rNdcqA=
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 06:40:55 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::89) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 13 Dec 2024 06:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 06:40:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:40:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:40:53 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 00:40:49 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [RESEND PATCH v5 0/3] Add support for AMD MDB IP as Root Port
Date: Fri, 13 Dec 2024 12:10:32 +0530
Message-ID: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: f6099dab-915e-437e-4627-08dd1b41181d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmSljl7mv3w5EMV6c0miDJ7tvjuy6iJxU0fodkIzDJrv9ydzxi4Ug5E96ohR?=
 =?us-ascii?Q?fIcmZPnNUr4LWUDqaj2rbYrXyYzlAnpRyqglwIGn2kVKl0AHT7vnt/YYYqNU?=
 =?us-ascii?Q?H+sSvz1/UhYH29GsKt6i2DJg2P7wKSQPtHEMfHZINhlc85bkbMbvJ/+/siz7?=
 =?us-ascii?Q?egzX//kRxo06dV/SGTpM4a79JhoPi1nxOuoBzpIWVKziXAvlhqDhJM/2jD85?=
 =?us-ascii?Q?rNnLq/fp0dy6qIqZhWbZ9Ulkx9f3Gy77tC+KJqPIwu7JXOs071RiKjD2YXL0?=
 =?us-ascii?Q?GgNf/1HxwT7DBH7lExKjay7DQCQ3KZIPKHOAMtZhpWDeNnKAxkr4tkkqX7au?=
 =?us-ascii?Q?Ugn+jzLAf7JQoBj5ESFxQ0owaLiHnC6NOs7bbtc5F5tbPoSUb6NC7D3cZ5wj?=
 =?us-ascii?Q?H4Komww0vP9MNivLJhEUuGLtfd5f4sQ7ZGxEz15XD3fifmyzRsuJN8DNEEGO?=
 =?us-ascii?Q?x9hKI/O0m6Wvb9UglRyZQQOs9qkcqSFSkTHirezoOwUKo6QoIfqoJ4o+rlhJ?=
 =?us-ascii?Q?dZesaWraPRrohU3onxrtvzLQfykJ0Z8QLm08xEv+NMRfmnHk4R5PiDnh6BuT?=
 =?us-ascii?Q?b9/BaHixHuozEwdQ7HHZCPKBNP/POf36kMEwJGWH4PA9bRsKz4uqTNOJViV8?=
 =?us-ascii?Q?mG/NkBfGMLupW4i6TXSrh20+qJbaIpzOztQP1A0gYDXCQ104bVVueM5f2lP9?=
 =?us-ascii?Q?VgdCY2zsjYU3wDOx+iPhwSHTWANq4hIZAVioS6HGilCJZJ2UO1xYcy+Mvuk1?=
 =?us-ascii?Q?7U7z1D2HjBiKcvCGfaDGCkphokW6SRLZ8D8TxUSHaorOGNw9BLyGfNntObm8?=
 =?us-ascii?Q?FDPEDxTAw1bmQSKmaDyQvsnFGLVePndk0odJ4cDoDsCCwtcxGHAMpqXLznZZ?=
 =?us-ascii?Q?Ty45f9IC1Lakelup8tlgkywlQqAhlRyOWktC8nZVzdXzJE1Hm6jP5seH3Ysw?=
 =?us-ascii?Q?Tvl3zkCoKMyW6oMAMhpymybQ2pLcnBXbXqqO4Cxc2hUdLkfe8+2g+nZlxB5v?=
 =?us-ascii?Q?r4/f7vJgMW7UxDyVjejXY4/gPr7HarvX5haBN41H7mPWjowxiCKQTZCPJnGz?=
 =?us-ascii?Q?LQi0WLPGtquD1yZmyAbYMALmPP1TEEYEqdAvwgHhly/CwXdNQUr6BVB6SXtD?=
 =?us-ascii?Q?G+c+a9GAKaJrthqvvW0UOn3ao9uw2Giw/tBsfhFGmEJnYbfEMqajcqN0DEd6?=
 =?us-ascii?Q?FQBC4N83IC+jwHsYZgsxhgmnjr6xkAyDhVQMb8D6V+2guu2wBX17peMYZJUv?=
 =?us-ascii?Q?Lg8V59aQo9KD0IzC/l3yCFpVuuc3TnBAa80J2PRiuYIoPTFNVgCQLuHst7E5?=
 =?us-ascii?Q?GXN+biOs9dTpswJ7JMeJcP7vO2Xhm/b6CJ0b1Qr1mozVfqEPxJWiSsOPeE8d?=
 =?us-ascii?Q?R3fNHu1ZpNf61Riw/zvFeGS8QHE9USfy3R1b3qPXHKUsoqR54MvB29jIfJZ/?=
 =?us-ascii?Q?YfI5+d7yFTDVXwwtV55fiPzSEyAfG196?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:40:54.6311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6099dab-915e-437e-4627-08dd1b41181d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

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


