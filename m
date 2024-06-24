Return-Path: <linux-pci+bounces-9179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D291480B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FCA1F20B64
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A813665F;
	Mon, 24 Jun 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdfAoNsK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97727137753;
	Mon, 24 Jun 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227286; cv=fail; b=XYnvdt5Q93pz9cVaZ/HM5/Yb3b/t0/rgTAmTNwtYe9J/R/47j2N7DGl8v4Av5VvTyRY9I81ulpfglVwwAgZUvZAZY/MbqV23AY6vj3kYiWG/hgY4cgy6/0dM9/v6R71PvUbQCQYKELYdq1T/wleQWSAoo5Vpku9fJH89sLawCoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227286; c=relaxed/simple;
	bh=ldSr8n/6t6+7cU1NLJhmTy/OZYzJJfGvKxRumQu/+l8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9HZIC9jUXsSeHqMbIBGUGYL9ZUxjd3ZFdneg0kTN96xxBdFplPV5OdIM9/i/nRW9AJywpPklxycaSYK9WgsESiU3/9qJPOW+K4B0QGE2W3MF+v2m/hpSHWLR8ZGVjiy9Zi6rdS1dLC1f+jhv8fD3tJaiUsn1WPwsFzaobWy43I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdfAoNsK; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkfaYZKSafque+NAF+latO7OoHMVAS9xKLDexosrsCjtcHUZOQhTJiwHT8eLx+wUNeSDtK31zGEefSwf5ieK91zsR89Q9V3MoWetzzP8vErGeJ3UEby6QvK7DK2/5eR52Hd0nb4/rjIST+Th1gHQRrDPjl8k8yCDZafwEF5dq0AVRgzwRg2/tGPTsHctl2M+CwCf+k9V0p6pLnXhPqdLpKSDqZNB0yruEvg0PQU6mORevoU8tzWW713+sv1aHG4STe4Zz6CwZ38h4M6vO/XfrHz2hbiERois8p4gTP7GrWSOmbuBJDDzo4wQhyb0MIWxfBjWFd63ZekEbqw5sBppdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvso3/X6AUqqRquNnZnjSNR7EFPfVLWUVXjHPHcVjqM=;
 b=Nd3uLtRDqmAN4fSeNL62wX9jePC2oV1guGJQXNIazTd4HkOS3EEwz1fGa7ONjLUm+TTWJjtpYMKdDJj5L/OgRwStJk3SqTaMHTSVFwtFAnZP2SH9ijtgHHOzVX1/6yQs26AYqtPr+4cxZsSD3bm3Fphq2awLX06GKtgzQ8RR6xWW83F+sA+IiKeW5CM/vcBLJ6qNOlEF6jYlnUKuNN3XEG/WR1EIfH4uVVfH5kHenLl198KR/8Vu4RC8QCa28S8UbhJCuer+0HO8mx3/ACzmxtaFmDY4qtebeGDQjr92MInd0X1qovybrpn2/hPKPbVXCpmJhZQtU2AWJvgBx8cQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvso3/X6AUqqRquNnZnjSNR7EFPfVLWUVXjHPHcVjqM=;
 b=sdfAoNsK847wFuXRE1wKihcUUSzk3VAwIygYzIUe767LNeUqN3WRynrP5uArDoXt7kcv63SX0QCT0ZbX5S+1aoZtbcDgY2q8O5eCa0AfnOJvo2Eyg8hO+Xe8SkcQSxBz6+00HnwyI1NTod88l/wq5QihP40JrQ6P5rREOKfkiS8=
Received: from BN8PR16CA0011.namprd16.prod.outlook.com (2603:10b6:408:4c::24)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 11:08:02 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:4c:cafe::3c) by BN8PR16CA0011.outlook.office365.com
 (2603:10b6:408:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 11:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 11:08:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 06:08:01 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 06:07:58 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <kw@linux.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bharat.kumar.gogada@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Date: Mon, 24 Jun 2024 16:37:53 +0530
Message-ID: <20240624110755.133625-1-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b3b7a9-af5d-4ac4-4542-08dc943dea07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iSptv4GFeTu/TY+bnAe1YV/Bp7TYOzkTnior1HMQSI9sOjMs3rSauLux0cG?=
 =?us-ascii?Q?sMRWCgnEod2ZMSF0V+BFYnyIm03UCQhG5yA3JhAQLc/SvVLTJmGzm4QiGq2Q?=
 =?us-ascii?Q?U0p6Kj8weQBxJUeYLedITzdrQRLlOC37SIg2TmZAbs4rzYLdkbPRwK3JLgDY?=
 =?us-ascii?Q?eAxdLRuOi3TlGa/e09CDy9dqQIxpdUo6w7WSKTItezp8/izEedP/FLyIlj6K?=
 =?us-ascii?Q?9j9NuOgUhg7r9OO0GaxY1Zd1c1su0DlcmbZfpDB43U0h7YUtsrtXgcWDT+SK?=
 =?us-ascii?Q?SBnJ/0yT7hzE5faZ/rqy8JEmWaE/6RuL1nNnKJT5Cv8kkgbOI/9UcBcEcbfn?=
 =?us-ascii?Q?VoNDiBsIL4FGg9xYeumPR7WSXplWfZkacDduHH9C/BP5SL7652ght8LeCmhD?=
 =?us-ascii?Q?r3L5DnCtBm3IXKOOU2ttUxn/rFJkCXvS+sSQBk0rukv60xuBmlveCyzzojZv?=
 =?us-ascii?Q?5ErrSy0EGbdRJC6nbpHR8a6XMJ6DlQOc+RHP5MK8qIpzCLJs9/anYMdPGPEX?=
 =?us-ascii?Q?9sVBJF5sEZQo6Bhymvel3fqkAHKDZcWejYQ9CYFKhEqjnS5Q/pj6YWaQszt0?=
 =?us-ascii?Q?ZZis0/gLy0QF6ruAVTxMWquGidXr0ffb/nwcjNlc5y0IMTVq27iE+y4dduN3?=
 =?us-ascii?Q?dq5qgcvXJHa94+zwz5H19ssaZxf0v1C2cDKA6f1LMu1sQZbb/9DEvyzVPDKZ?=
 =?us-ascii?Q?286M/prNDVTcI/v4LMWx+2brTume58F3ioeVE+zYEj93j3s3972WHF6J7IOp?=
 =?us-ascii?Q?GEWbHAkuK7E2iGNJ0S6wWBRAK3BTt7xJ7kqGBngAbR9vz7SooEwIbnnfcyFR?=
 =?us-ascii?Q?Z6dn+YrlD/y8RI86oSbEiW7xn2UvvOqD8kGLSO7c4wErvI86l96+elvv8WLg?=
 =?us-ascii?Q?Gh6r3b51q0FpCcYHp1S2BwxYpRIpPCDjXN+rYWBTRMCp894JirL3VrRrHHCu?=
 =?us-ascii?Q?wzWEhOkqfEcpeSyyORfnbsijpXtu0NWvh5MZj6bJYCePgMdghDFk6B0for8R?=
 =?us-ascii?Q?LGcmOhJDcOTj0YtFqMBhGJBIoZwaiOvBF7Z2Msbtdkz7R0OfL3eOY1VIzQUo?=
 =?us-ascii?Q?v/h3zjXMIUThAOYUyg+AMNcUFCX9GjquQGftKoRqLN8xnSyqF+JCucAwIVF0?=
 =?us-ascii?Q?9pg78R7+iAON3L5VNVYvShG8WNQtm7gX8o/OE16iIx+lywPGlgbU+tvWzhaG?=
 =?us-ascii?Q?z3dA/J4/0VnVZzXkCd3ZrtTeR0HUEX2u/UkV9YcrnFDm12KFSF0S1u7y4rFj?=
 =?us-ascii?Q?IUWrz4vf2RgkdCrkbTaDF75UPVKK76L/YhsBz0CBQamcuLT18/aoWqyAZvIi?=
 =?us-ascii?Q?WSqH2nfT+FNkVsH0t3e/RTqnZ5nGahTYvRrskV1KQMHqC+OwDald/1MYIuna?=
 =?us-ascii?Q?8ToxMvWrP17868WvCJ3DETy4A5TYHKYMAebX5STXhgHlUJKhFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:08:01.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b3b7a9-af5d-4ac4-4542-08dc943dea07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

This series of patch add support for Xilinx QDMA Soft IP as Root Port.

The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
    Port Bridge
  PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 41 +++++++++++++++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 56 ++++++++++++++++++++--
 2 files changed, 92 insertions(+), 5 deletions(-)

-- 
1.8.3.1


