Return-Path: <linux-pci+bounces-20528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7DA21C4B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD3D3A3685
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87819597F;
	Wed, 29 Jan 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSdn7ibq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA66186615;
	Wed, 29 Jan 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150245; cv=fail; b=cOTnZiv2udxv3DkLdFaXL4t4zFzjbTLl1F/xeisCELSOe53bgd/MflvRfxTPgnqh47863JjA6vKHuzChwIdVrmQnHmCe85lG51w3xUuhBwm98oGeOZFMhSahgJ+2DI3zOb9eifVzCa/f1zDVCTywzL63F53hfeFeTSqTw94Eey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150245; c=relaxed/simple;
	bh=288cl/RGcs5+EeU3jOg0ygRMsckXMW2CrRJOAE/7l8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=crLJyUoD3fU9AWeE3IefpSMx6Ay/FFj2DTfEccSmwHkgUnYeKArbDb9eoDQ6ddyqelLqUJnRvilTDh27/oMu6ibTAvVvbA9BYv2YDLn9HP9L6Rbwc0EQn98jOQlJc7GIVw5ixerXRL8tv/p/OSK/m1v8FVYAkyQU+PteFriKZvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSdn7ibq; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eND5NLwJ4P4oD3qP2xddxBaNpzr5GcmSKoP78elnq1MjQlDF98bvenhR69W6OGTiMUt2HI9tC8oWqPtp8085L6nIX2pYxfHVrOQQHrsJ5rv4scjMiUFEWNNdJh7kHjb9k+shqKBx13obaFbqDsSicKLos59aykq/x5QLAP8jROdlkJEbCJ3kkxMwmCvnd/GtWUyyveYJdZLpfdlZTvqsT3HT3JRbKZXQGdeE2rmOLS+a61A4/iw5bQCUdCO2D3q0SjCxh91pOotM4Djxhy0wE7NJQNk5OClXCUtns7QV/wnjEBwucunrSyycpftlacuUZFsVfoZA8EbD5O4OJbs9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UMW6OOl6ggSWfMMV8BxocWiYH0+5Ekh8QSNqNSJfU8=;
 b=QqAOyUpDMxg3BqeQ8qHORIzdck/pDS0VCsHWtE2LTdZ7wjjjRxSXFvSLQM9XmiWMdYx7Lu4oDawDMEq5gAzqnqF3svMR9d0dvT+fIKi3WV5tYV8rw1V3c0m+WR+KosWln2NTmnAQZXa2T4GFmnh51Ff/tCod2YJ+B17sZrsCCPmxm/iHkF3rMO7A/UTdESQn9xYnPV2u6Q1AdHyC2cBZBrX/Hsfv1N/+HWsmFMn+c50k0HuQSCTMEjXK1rGJgBoMClGfHVRTPxQM9n9cejEmUX6P00h5SJ0397BxBH9RUxuGfeUYx5kMtS8RFyS2lAU9KYiNb3r5GnNdCH24lLANSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UMW6OOl6ggSWfMMV8BxocWiYH0+5Ekh8QSNqNSJfU8=;
 b=uSdn7ibqnKluTHlcwOtiKoBjuZ5enn8b8ihXLXiomX1p3D40DSVKsOCwdpwqNRRDkM7YBlxX2RXPYqh2JAu/VSM8zoPfMEDxnxWSoS5Cvc4f+2vFzVpTSzB9fFVIuaqczX4YuPSimAq2sLOtfv3ZYHmfeedYFeQ8rjehL4O7Dww=
Received: from BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 11:30:41 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::d1) by BN8PR03CA0009.outlook.office365.com
 (2603:10b6:408:94::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 29 Jan 2025 11:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:30:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 05:30:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 05:30:38 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 Jan 2025 05:30:35 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v8 0/3] Add support for AMD MDB IP as Root Port
Date: Wed, 29 Jan 2025 17:00:26 +0530
Message-ID: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: a0338da0-f8fb-4fca-509d-08dd40585baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PaFpt9wcHWYE7hBaA7bI4WJNWu0kF2j7taJOtQ39N5klqBYm2/CPocva5ASv?=
 =?us-ascii?Q?sFvD4Ds91iHQBslss3wQp1FpleQ4fb73CA/tIOU3CicxzvEosnmjVTwsLekT?=
 =?us-ascii?Q?JedYvckb3pE7rIYfy+4nwa4/p9JRQYJAs/4ZDYPvYJWVYdnTJlaw/CVWS84Z?=
 =?us-ascii?Q?YUd5M2KVriFnqKeve0fqQd+w3W/uJYwAabR7k8278PRirxUNhQBBh5ARUE9X?=
 =?us-ascii?Q?bgNRFycQeO+v9CAez4RGYhlqeSd0Q5Pi5sMBTjP36tdC2mwZOTXMnzzlvNUx?=
 =?us-ascii?Q?yJk28T7+qtekiHjfQ1nw7okVPBqq5WrEv3cIpXf/Ry6uubBo4RjFLJ9wYDS/?=
 =?us-ascii?Q?uHlch5Kv/ivNfP7goriUWYqAD4MhCb9PAwpp5JlTrklJUOZNWWeDi21UEh4j?=
 =?us-ascii?Q?Cj2AeVh246lnKHNHxAiwK+wgRcecrD+//QoGgdNFRG9R4eyFpSiOJZ7SsGms?=
 =?us-ascii?Q?pVFsOqQKTfMMRqFgLairpbdXd/GlUbnOS530FPz1F2pclr5/msHzH580WuSr?=
 =?us-ascii?Q?oEWW0KRPqi9IdNWv7FYO2873J/9NXkTlAUcOM1XhJriHaZSgHM9VRbc9oKyL?=
 =?us-ascii?Q?pwcYzksfwRC3m6S5w2fpNUD2Z/a0vZd5YGkFfb2IqEXxViKYgN+qVvapsOPg?=
 =?us-ascii?Q?doNHnASkNsXzAxw7InJeGrMkIJVwij/xH48nV3jjO2qTIbkfR3Gw0lZ15Knc?=
 =?us-ascii?Q?5OmVv6GIk5uru6Atc4lowMZ31v/FA7DRN+XKDy7F+Kw+L6IfI1JsK7QdRygZ?=
 =?us-ascii?Q?TIkp/7s5WDhtHx6DQ4eMn8UawJ+34y9OrF4gXaR7uxSyTkbQQjf4Vk6gwFkb?=
 =?us-ascii?Q?/re34WOUsQY9vtdNnW1HxUwCQwWgS/HH15m7e+YwMg55cocy8PitjjUccUDA?=
 =?us-ascii?Q?QUZsn/lPL+G3lXCQhuFw16nLiTkicGcKAUyvm2X2fS/x7Qsi9g+oATObS4cg?=
 =?us-ascii?Q?SwW4T1RoHTYId3mRLU4+DvU8caDuVarvsmfrjxWJjScHRZwkVySOuuZ7vtPc?=
 =?us-ascii?Q?MD7zlIhYaEW8kSHKbuiQxEGKhnub6amWYfg0h7EJdj6VI8PAfiaTFmgp4Bv5?=
 =?us-ascii?Q?nPOQpJIKoBo/ISVwV8iEk8w/LBVF6Zl0216rujoHnheJop5Gr30VS73r5XcB?=
 =?us-ascii?Q?wasjwhPaH4bS9tK1stSu/7eu0a/ryNGAQfeRG9Q431lO6oL0LaPf+PLlg8kr?=
 =?us-ascii?Q?ETA0oUmVPfapwIAgHq9TxclwxYe2afslP5IZuWI6gwoOeXqNKEEgPj1COXCf?=
 =?us-ascii?Q?mmE6NGMlKP1DL6POoZX3d/m/VYAq6/Ddn+erTyxyJ3ugsjAJ9RnbiYu+wl0L?=
 =?us-ascii?Q?vGC+bwOBCauFcKXCEvUzlMsz2ZbRy6LuM/PYZXw6dsRw0LGCKWvRbEwngTlG?=
 =?us-ascii?Q?dosYmxUY5Xgz41j0wv39y2qYedAyfhScT97UzacM18nC4kq+EfTCE4o2VSHW?=
 =?us-ascii?Q?3a9aU29L0l/+WDxa3jf6y7jG2C0ZgCj1JnODgYNvEYjk5Mvp1lna/cDWBiMR?=
 =?us-ascii?Q?GfySCJJ1gZT+6xw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:30:39.5212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0338da0-f8fb-4fca-509d-08dd40585baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 476 ++++++++++++++++++
 5 files changed, 611 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.44.1


