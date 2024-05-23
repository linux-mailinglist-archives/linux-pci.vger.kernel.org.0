Return-Path: <linux-pci+bounces-7770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19A8CCD7C
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4136FB203AD
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338913CABA;
	Thu, 23 May 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tFjGxyqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D4339A0;
	Thu, 23 May 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451108; cv=fail; b=ENyudilY1RIkxwIKxufMr1LiTm1RNNNAj3LyZg3//f1qdB7/C7aGzR/vDKqBHCxN3PRyeBx+vMzAI2kyMwwW87sIT9VgmxDsNyd/U0JDCLGGqpI211KWX4cIijusRL3aRVuluynttXcY0OvafHch762SzaHVv/Qsd/0V/VlfowQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451108; c=relaxed/simple;
	bh=rZAFnYK9X2DxnoRkZrs2BQlxrNsiFfXr/Yc2/QP4GSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pv0f8DWEPdrn9/zvqg53bh+8vk2AfSq/F8rkOopwkXlr3/RR3hqnlVVzNUaBLV+JguvcG5/MNg/3q8SohfZ7wZmwtAc2AKklnKu7gfWAUm96R7l7qO8Mwc1/nuIrWCMUVOaeEspCh7kzwqxH3Q52ILLbYeAKzfVxPTZsAIoKasY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tFjGxyqN; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcuz/vfqg8CWwF6IX8HluOOCsKf4JhSSVUp4TxxQnRw9b+35XHq/bX8gvFBAQznIEdVlInG67pz0AO49VSQotqCmL0KRx87yYQV7NwhvbWNLVBI3zty7oyq9cUI2hS4pQagTbhKXQkg22wEZJTcFTHgLJkNiIW8XvZhIrYyRLN8yky0Lm+fDLmpcRxWmsWy711fNeqpTxxatRhDNzaxCXSzGD/QYD6S5vX1SplnpUe3mys+yhR37NpnWuBrmhSsnFJwIfxLNm3E1Kx8rt89QNeXjJ/JOO4+UbVll/bJ2vsrspQ95vAqbj6h3sLKDiMMY0jkmfisoY6Q9N+I91uukfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ENBEAZ2OUGMx3S8FXtTlvcmee4PDXZTmoMOSE5z8Z8=;
 b=mEZELo9DLZYppD25i1IVeUVNHewPE4LJOBJ4IeVaTvqw+5EjpaTMAMH1qX6tHgRxAED8Ha1sxO0CjHEtB208CDwBcTQF3/Cm7ziqLlsJsIHCDAmemjFh/L4ZodH/+W05P/hiP+aL1XlS/XwPYZxQj7Ulw/rloxpNQIGRAhx28M6ETwKLJuzF4MsI57eaaTRapnNu52s8sto/8xNSu2WJWkravmNTDFWnICNVmNwiCRjiZ5/wRo8q6dEA2NJ6qFtHnEhFFfF4WVsSzX3ctFOHpfkKwqErUrmkdhSb3+9gL/t3aZLzzsKcnVSjcSFP9zZjj+nX1KWknCdM9gEbUk88OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ENBEAZ2OUGMx3S8FXtTlvcmee4PDXZTmoMOSE5z8Z8=;
 b=tFjGxyqNPqZcILFbtoXZRXPxakypqXiLqqfRTzx5DdUBumRf6+VwMecBrj47h9kDFp6SX13I0zJu4EbRoPmCnFV/7GEDnBPqKsxchrK5C1gVWJjhOz6Jjz8az1I0ueeMeq6iFTbeyZ02IbqwGLxI8yRTUeI8QMx4Lp+8YWzTUw8=
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 07:58:24 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::b4) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 07:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 07:58:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 02:58:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 02:58:23 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 02:58:21 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: HaiJun Chang <HaiJun.Chang@amd.com>, Jerry Jiang <Jerry.Jiang@amd.com>,
	Andy Zhang <Andy.Zhang@amd.com>, Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 0/1][v2] PCI: VF resizable BAR
Date: Thu, 23 May 2024 15:11:13 +0800
Message-ID: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Lianjie.Shi@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2992c1-5097-470a-eb5c-08dc7afe1f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMDRwKD3FvAEuo480HTNhVGFjkS5+lXRSazJgMuIWI2U+GpFAJ32lnqp5T+1?=
 =?us-ascii?Q?EcsDcwHuD4V107Y6zrQtQModQ/a2npPmnhlePlvoEGlcWIH3wi/DqtfKHwwn?=
 =?us-ascii?Q?CaZiJ7cTDzupg/rZbLQxs3Sa1bsDh5vdkAnuwcUh6i0RPBjuhGNKF2JcMHfZ?=
 =?us-ascii?Q?7PJVMHlzwr6/Yt8Vl5xbIS3GtUJ1esVtHN/Yf7iNZH3+zFFJ1ZzBH2ifxWYg?=
 =?us-ascii?Q?3Mz17lTUF6FSEfxcOge4jLG4HkvUB8EgAmOZOvMphdV6bm9JonItA0ScgvDO?=
 =?us-ascii?Q?1YbF1TTKheQz966R+RQOJuK0LAB5WEDfTOh1HXQz+YyomN6DXRXLheDoJAXk?=
 =?us-ascii?Q?zzbwJYN7FBCXFBBm+yaGz/NyFsUOMxts74f7yJZaBPYqlcB7yZecAOrLoBA0?=
 =?us-ascii?Q?vhYAyaziLBNDtYGuJBXO7k1+S3zpgddqFinKSA6rb5nVVInXeRmhAJAGb07I?=
 =?us-ascii?Q?5lOJKOh0jw1O23y+rDghm0P8zK4uijofqLZY9BrnE7KiNU0CtaOfdCYqNc8h?=
 =?us-ascii?Q?D52r4ho5EoMqVpQENFcdWeyxSU/QWyslDStRkgIu5HJax8JM0lYWchFqC+x4?=
 =?us-ascii?Q?D6w+YfStB5qhfrMKIcC8R0C5+Ue8dLdFrZ1eDvgcjluqYHePT5/gATqSekh5?=
 =?us-ascii?Q?SpCuVabu65+44NDbJcF8l6p3tYi5iEXLd2fSC9IZ+K3KJefBp8dqzqiv5F+0?=
 =?us-ascii?Q?0hkYEh8wjYhKlpCqgZNxj3TKZMQizbOeIbpDzJjPRA5EwMJqueIDpihyjVV4?=
 =?us-ascii?Q?rCKnpoeNz/pyj5cxiicMktc9Vl5eiAJzcJQiqiWHLj+FB6I5pTcZsDnDSnGA?=
 =?us-ascii?Q?VwgJ5PBy3pV7PsTQ0qAerJvgxaueP+vVglwqh2nNaKpgtc819l3whkp8qj4l?=
 =?us-ascii?Q?FZb5zBT8DE+6EnioOaDbZJ45R0k7EzrLq3sFaAFdYAL64+zCt9GZ2QVDBrEL?=
 =?us-ascii?Q?DZPs2TpvdLoA2+CGEvf9npXhK23LRh95kAYcT+5P7W9dttjfxojwN6o/yCUc?=
 =?us-ascii?Q?CPb7o5viU4CRe5Ayvl/B61ZcVjLmXYaEb7UB+r8FgRj5i3VVzbYIjx4nV6JW?=
 =?us-ascii?Q?IbJ6pZTFXt9Yiz82Qk5GR0ZDWlUDmdNtqXBIsbYh4h5RxsdAj/4p1xoeifAC?=
 =?us-ascii?Q?thMKkZC0rME+m38XRwCAzmGwUyIONm3Qt+es7bXwmGgGFQ1GD6VhJ5KJHEz3?=
 =?us-ascii?Q?xNtEGeY1iFBOqKHUhqyobCiVbqJNALaHf7uqblnepp1w0IgyfWEKQECcvcP/?=
 =?us-ascii?Q?rBzTiHnQezwPNnrMxiGi7yqIVwdxe3TZ3FaqeRBGRbZaMcqCOuN1jTXsKAd9?=
 =?us-ascii?Q?/FBp+Q7qsq0DSrXbqBkTN0GXS9oD42tJXwclDbIr7zKULcT+/zgkeDamxqCF?=
 =?us-ascii?Q?Ape2Bkc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:58:24.3374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2992c1-5097-470a-eb5c-08dc7afe1f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

Similar to regular BAR, drivers can use pci_resize_resource() to resize
an IOV BAR to the desired size provided that is supported by the
hardware, which can be queried using pci_rebar_get_possible_sizes().

This feature is based on the fact that (default VF BAR size) * (supported
VF number) covers all possible resource/address ranges (rounded up to the
power of 2 size). For example, the total size of the resource behind the
BAR is 256GB, the supported maximum VF number is 4, the default VF BAR
size should then be set to 64GB. When the enabled vf_num changes, the VF
BAR size will adjust accordingly as
- For 1 VF, VF BAR size is 256GB
- For 2 VFs, VF BAR size is 128GB
- For 4 VFs, VF BAR size is 64GB

This feature is necessary to accommodate the limited address per PCI port.

Lianjie Shi (1):
  PCI: Support VF resizable BAR

 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)


base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
-- 
2.34.1


