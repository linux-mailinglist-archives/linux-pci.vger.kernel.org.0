Return-Path: <linux-pci+bounces-24721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE9A70FD5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 05:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2682189795C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 04:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB273130A7D;
	Wed, 26 Mar 2025 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEDpxp7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16711175D5D;
	Wed, 26 Mar 2025 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962521; cv=fail; b=jAuiAq40gdAJrE7MUp7QRWGJo858Uzy86bW5W+c4JrkhOMEDcLlIo6+02dMDHzxGugYD1eqjfCQjWb+0h8iJkr/fbLiqJDuGKeXphCktM2voVyUBuli5crwsQhJIhWQHOmlblSpwKFCO4eivbykgQTeDdP556jaoqaSH1fVhNdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962521; c=relaxed/simple;
	bh=4EQnFzwSK6NbgMcrjZPMjCB+RYOxTU7lurzHbB2GPKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYjcLjFfRsnwnUSYXw54XRvvcc1BqfIovkdapxv0YPWXLux6oC4RHyHrLv6KkbONIvZCYytte8Lb/cfzrJNGOYqFT14wF3xDLMW1Hn6KH58cI9lhIeKwHH4fWE8EyMrsfWHMhoDnXfD280pQmKtBvzvGZ2OVXvlU9jM/ut8SCCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEDpxp7k; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib+JCa9treo6s8QlXy9C2txd7MJeHlnkHUOBj4nv4gT0N1cex7nbeDvl2HqH5ONjv0JaUSAdeA4AVHhHUOZFeSdeARIM3uta/dnn1Ld9kpZ/oxjBcLGpclL1NdgcPGluLOKfR48XjdgbpPVZDR5cexz0Rg77/XgVYG7P75RoFQ6BIQlz/ncI34v69x3AyQURd/wnHdOEsqJ6GxVJBKrINSR5wmjr5wTizOIFg0zorktxrGU8v/iBcnz8EcxjPO6sVNahR9IBMEGFlx9OsgZvW5zzh7WH4iPDlk7W4gmxA9ZTW+4ChFv034B0uDwzCwAbmPJ6fN0NoJBfuX1KYGxXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99zYm0Jt2rD4ctoNktLntQgMtobvttct4H61mUtOOrY=;
 b=T1JhPpDhY7viOFf+A/EjY/LWwQUQ9Qdt3W85i0KGhEseAvh/wBkeaRhJBQgbSqglYdGyrRaIoDJW3KlBf/2wetxcG+yTGtsP4yhuorLJNsrEF5XhkqEwO4KpGu1OBJvCiW+pW4sHjyqD9Et9af1+za+1M9ixxbdm8saY9fKTWxz6Bbu1RQiFWa3LLABHdENjpHZqqwOv6cB3xdKe9KI02bXEfTgbsOWdkDE67jR1gQPQrSG1GR5KoBUxWGWOVtQYA2is/62QHM0zl+osDJR621Wgc+X9ReM5U49cvRyqfvWq10Tn/WdWzRGItvNWT0kcytaH1ibGC9cBZYSngGz3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99zYm0Jt2rD4ctoNktLntQgMtobvttct4H61mUtOOrY=;
 b=SEDpxp7karWDD5LWO/VkSHX9tktCL07LzpptKma3CAgsc/5fsTIKiov5PHzAXCNHfxj0sHPtBZofB8WWCG7ynRASLogLZWJiQrcD4eNCu+7OUam2GMzYIBPdGlPjnpaEy7e7TiM7X9DsS3dDETZPRSh3j6g+wEVdCp0rI0PCV+k=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 04:15:14 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::b6) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 04:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 04:15:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 23:15:13 -0500
Received: from xhdlc190412.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 23:15:09 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 0/2] Add support for AMD Versal2 MDB PCIe RP PERST#
Date: Wed, 26 Mar 2025 09:45:05 +0530
Message-ID: <20250326041507.98232-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba5299c-85a6-4537-5255-08dd6c1ccee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jDPSdUM13hguncLuXaHhg1bJMy4h/EsaziyooKftIQT23yRU/ovnk/ppkgea?=
 =?us-ascii?Q?Lx78sYXdfrfPxY7hTTQSpoGhsndCQl+aoUvBXy9MQaPKCO0W6oB3NtoUOvHE?=
 =?us-ascii?Q?Ss7h/rgMyTt4KFZQJcm515w1XceMEMfH2qsszV6KpIWEncjCuE04AsrxaeBI?=
 =?us-ascii?Q?VFBa+jQ5xiE6AWlKBs4MBA6kXy+wqR/9RTXyigmnj9TtCy+gQthseBShsF2T?=
 =?us-ascii?Q?xc66j6SJ+qlP4hbjdeZvwQz9VRlNpvvFNihnMRcsIy67cUJ9cSQ6EA9QYlKA?=
 =?us-ascii?Q?lww3CuANfShZes5zihX4QpkWFlFIo/jfidXa1rsh47ESSwjxRnYL9/qhlzcU?=
 =?us-ascii?Q?vOoQnwTWBRQ/7eKgoWiRk1kqNAavwyL4snmPA85dSnSoX5q8khoZrPwDubO7?=
 =?us-ascii?Q?zyFVaEE+bjCwIoH/GGmmaFirAzV30vYkwEjeQ80I1f99eeEByBbsc5b5ryJ7?=
 =?us-ascii?Q?vc1RMOlcyodB8mf/ZOETmwpZFQHFFNmT9ET/m4pdKyPV7+NLY/XzNuGrkEam?=
 =?us-ascii?Q?27uAixsnA7BZsCmvHVzORSoJR3NUwxWGIPs7Gn0oioUcvenX6mZzN5fi2rsU?=
 =?us-ascii?Q?1Mn7DJxIU4+cb1I+WsiAItGBFV54g8TFj3qhYby2Xx4J6QiTcP2CyNqLzUeN?=
 =?us-ascii?Q?hGV3gb4EqK832nA3vDIUHq8A26x+qGf3Wx/RATYfea5AMfFxlPFRazxxmNeX?=
 =?us-ascii?Q?jGiTGVhGjFKEVQu1I1fOTcnA4L9bxHxFip5fBbSYzUHysRgTHuAeTDDs9bm6?=
 =?us-ascii?Q?JkzPuca2sPl7zj2ukTcn4XU7HkULFGOJtXYh6GeWT7UUbm4sIxd8wGGR+5V2?=
 =?us-ascii?Q?I7c+ATjn6SSmm/S+UnhydgEIcEgvz8iMDfB1vt41uESwiqM7fBuJIfG/5IbH?=
 =?us-ascii?Q?7eLD7Tm3Lj5bnQ3IprMfWTJBP1KY8qpGrUkHJ0tJA/TFgiQijVBmSQ9lFVao?=
 =?us-ascii?Q?IKKOGYZJDCd6L+9oQ5OOAPwa9qBriJTFzTtz5mhH/XaIIRqZejrtz6ITcUnk?=
 =?us-ascii?Q?L45Mf7tXxGQoPy+0C0JyJwJ6NbpBCg4vHcTbLtuwVs2IuSm8WiRah2iy3HF1?=
 =?us-ascii?Q?73im+om4wqZQ/FuJMJxRythJsbYMZNBPOUp17ekrHYkRBX58GCegcOpgJOEd?=
 =?us-ascii?Q?jHW3OmFygdsyKJdRDiBJy+xiBqnI9aWb+S+nVTWEPiX0OA4bHZGZvdQBUvim?=
 =?us-ascii?Q?knMEw0DJ3ZCXM191WcI4z/f9x2TUG0UWy7jgl1FoX1Rg17S6vpSEJXNWlLAR?=
 =?us-ascii?Q?HNt5/HzpI7xhGem8PsDzzaiQS3qw3LGkHNgHHJ0Mz44kwyjeFDSA/f54eUFK?=
 =?us-ascii?Q?fbHRTmlXhlHAIvDwJJF5xGg6TCidhJTm84w2+ZPvPRolLGylWdIz10lRoePg?=
 =?us-ascii?Q?5HGmS5aauv3IofhFo0WG4nlmVX/nSFz5T8bLbp/6nMXkoAuUebMxkdMyv5uj?=
 =?us-ascii?Q?43AarNeYl2o00xJR1eY5VjvxeryGigppjviFtGW50Dy3jidVJHZmyZQfmQ3j?=
 =?us-ascii?Q?Jj2VI0MkG1e15Cs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:15:14.1898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba5299c-85a6-4537-5255-08dd6c1ccee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

Add support for PCIe Root Port PERST# signal

Add `reset-gpios` property to AMD Versal2 MDB controller binding.

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add reset-gpios property to handle PCIe RP
    PERST#
  PCI: amd-mdb: Add support for PCIe RP PERST# signal

 .../bindings/pci/amd,versal2-mdb-host.yaml    |  2 ++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.31.1


