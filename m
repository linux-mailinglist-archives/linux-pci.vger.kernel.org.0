Return-Path: <linux-pci+bounces-1869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F765827E0B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 06:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964A91F2262B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD1646;
	Tue,  9 Jan 2024 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dfo/g4Gi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576F639;
	Tue,  9 Jan 2024 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Xtz4ZFFFUVvoO45Sw9TbI7Mq7bI1Ow8nimWveeJqRTZ0e/iod8t++vwzCiiODPe6VDXHCqFjD1aIDGzINEPokNZ/9QNW6tpX2duLgvrv8t7GqzyJoZwaDWeidhnVi25xPSbcZgoEeyt48gR+Q0ZIxtscWAIWDMiCY3CiQwKtL7ebv2w/lDZdO13tOdm1Gke68oLUgRAhBnZSGygGaK7uTgbapye/ruehMt++5ONOUxBYMowAIHyEOH6KnDbfJSa4MpFQjDuET4nuXhbEKQm/v72Q3uPct0nrXsNSPb3Im26hr9L0vGT76iWljH+VuEYdalaEzvn8LNzIcoRH9iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AMy3VJyk0bfRu6mwzej14nLb9kH1tjkqa1R6d3hsB0=;
 b=ffQkeJkE2bDPp2+eR8ZersfrVtClMsHhdDonnJqRd3jXN7uEgHKn6BDyXo2aobiLYMdj6pUakjZGHjryJmxtGT4HjY5DOfjUBcuNwIi1oa72N63m9m923MtKmNtvEMXGCpYum0DySSPZqiuSWVou60DX/fOnZmRresFWQZid/S3LWwLMjcY5zLViFD5iX441/eKKyCBS3CpZmMfku3J8xN1az4j5If1hMX+uddRDkh7pcQttCfP3FieHZUmt9olxHrh5THGqthTSe27uZsJOecWP0VD0r14gpqeibFNdh/AJMrPswHLx35hOhgOmCXlGYgYv1c5MMWybFB/3CoXyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMy3VJyk0bfRu6mwzej14nLb9kH1tjkqa1R6d3hsB0=;
 b=Dfo/g4Gi7k1KQWUrXLtZw8mgoveqyGysngHb2ivgeNNOsHvaXGfqe3h/oWB/5ZnyuVmwHaDT60neKmu3tpl/r7aZZ8NFuqfOGGVf8TGT9GKyrmLGOCFtqZ5fi9Z8XSSKUitsT8M9FUV+X7bccWIMiua/52CdS+1dkzTsDjJ2SPY4vLYScDlKfY7V8MUBH33TO6/7S2pwoiLBB4xjuDXERRILDIDD3lEWfZtaRWkZ6OuJNnf4woYhKZJ5TTR0s65oBg56YRjnxTqgT2EB069wCxjmrNYYsVXJIFYFVxp0+UDkkov1HHsYLVB5rBeyLEFkF1zcHwWi3XkH9zO8Vtwv7Q==
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 05:07:14 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::c) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 05:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 05:07:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 21:06:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 8 Jan 2024 21:06:58 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 21:06:54 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 0/2] Add support to preserve boot config in the DT flow
Date: Tue, 9 Jan 2024 10:36:46 +0530
Message-ID: <20240109050648.1347255-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: a14472d5-192d-467e-19fd-08dc10d0d7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYb6IbxhLtyMAtL2y4FYs5GTiMbxn3UAfimNZUjbHEPM2iB4+z84K2Cm4vCsxAhNdTMzWfIRAsMrIrYugh/JeG09ddS5htuzgolT5Y32KJOUoSNXxLhp/RWtkkZjKT9t6iyYvGUuRHk87VGTy3yPyPSo4GTV7tnBXWEA64fXHFbYPDWaudljgl5GcJLKX4rYVnQyL8NPaFsLxS5Sv5nlyeXKal1lv0tXvradmxUrLVLXTJKSFPW94RHqoQuZ+2HD4z3FjDhXIjWnglAaW2tuvkY79E0+1l80qActFB1MZD+wpe1M/JPLSn4In7pWlzgmYFvruJj45dT8srcdwpRT8UuvtC1uxRprGltcmyHmEpYhYEWZlhHysMmPmOBDHdKmqxzeAKbCMJfzAAtngS4bKI8YvIsPE2D49ZtM3uYl66+5yZS685jAZX68x0BiPSpDUUFZtsFz+sOO7kW7EZyor/pVAIkXnFa8NetoDiS29i8CekRc7QBbfwgrrwXRaSl+BiuP6ceCfYntJrGM4jADcgMJcN9ljaxIgu99tXJ/+XwER9kfkSR4LfrWEs4nyYzwsFJ9aZgljJQMZvNCN12XpuiMwIOxwHJjq0GOwh2hUJcVY9FSX3GiwtEKe7XfNEdAEPw1CeiAleOoe8bga+1WT1s893VQZEVLm27G/k3uCaKyDWAWw69PtmycP4W2ynrY2BOkGdytb9m1L80ZEBTMj6INLOc4agac/MD4vwg22SSeOkckZIW8YrzPpv1ccn5h
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(1076003)(336012)(26005)(426003)(2616005)(82740400003)(47076005)(36860700001)(4326008)(8676002)(8936002)(4744005)(7416002)(5660300002)(2906002)(7696005)(54906003)(6666004)(478600001)(110136005)(316002)(41300700001)(70206006)(70586007)(7636003)(356005)(36756003)(86362001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 05:07:13.9089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14472d5-192d-467e-19fd-08dc10d0d7d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Add support to preserve the boot configuration of the PCIe bridges per
host bridge basis based on the presence of the DT flag "preserve-boot-config"
in the respective host bridge node. The existing "linux,pci-probe-only" works
at a system level and can't be used at a single host bridge granularity.
Also, the support for preserving the boot configuration per host bridge basis
is already present for the ACPI based boot flow and this patch series extends
that support for the DT based boot flow.

Vidya Sagar (2):
  dt-bindings: Add PCIe "preserve-boot-config" property
  PCI: Add support for "preserve-boot-config" property

 Documentation/devicetree/bindings/pci/pci.txt |  4 ++++
 drivers/pci/controller/pci-host-common.c      |  5 ++++-
 drivers/pci/of.c                              | 15 +++++++++++++++
 drivers/pci/probe.c                           |  2 +-
 include/linux/of_pci.h                        |  6 ++++++
 5 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.25.1


