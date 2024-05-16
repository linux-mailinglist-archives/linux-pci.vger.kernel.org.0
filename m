Return-Path: <linux-pci+bounces-7561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E98C73E1
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1661C232C7
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C51143C70;
	Thu, 16 May 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o7AhWu1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517CB14389B;
	Thu, 16 May 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852043; cv=fail; b=k61beu0YZa4ZdgdTC0aHRIQejJ/TAFSkfUYlUpCwcM37hSUPVuUxqxw86Ji8VzhUuv3quwU3aV0J20IjAdtmj3RSz2OiqW6gKFBzLI5URblwaxFWGyYKd6jpXiHbxRgeclxAMfz0xC3Or6kCanWbKSiaMKo145uqn0Rc1evYVLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852043; c=relaxed/simple;
	bh=USpbp+mI2kYAyj8ogxWxCBeCoNKeGXcUhP3jobHhxYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRAzwWnuIOMwAwCZamYUTD6/TVe9SGEUiP4nnwWILQtTQE4VcX0MoyvjEod4QKBI6odt36y2uV2yBrcrKZ6+9p+zYv6KoNwyd6zFSc/H9ZQiZ8Q963MFwy9aMmWsLmX9JwcvHNIZR464hKxEnPn49Fkqxhk8j64rjYBBBpPGNoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o7AhWu1K; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOKxp+bTMGlFl1pdwjBMINtMx46VMU7X6CZ4286TUSDubVKdsexu4dgXe0+H4ySL82Kh5caxecyvw/mXK2PgtfTSc8RxczOe44h3D36lsHBQFdC+TfCB90LRHT4yySFOfOPx8L+nf5ny42q0vrfM7oJUYGyoPCLeaeOl13SLFbNvyCRSRQROYxZdRrh29euEMDJJ0I3WHm7nLzY2OqS/Gj4e86hUY6AxZ/KWBUr2zYb1kxMb+80/98WW6t4FoAUKNN74Ol0s2gzyjXeScdp/fJOdrdOOM/s/dUJxDbMmVWxXNRRPf0JMIm+5B3S3W+pUZMKO8pkWv9WaeKZTqdj5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAvMw9UFEhZ6lax5oHWCl0uxEmMvrW2GKjQ2jZ1qNhg=;
 b=SWiA4b/xzSOX8/NLXxxRnXpLaodd2NQbZz7xNA3vylsa9fChbe6ARqhuN6ZVSOCMEHcjC7srLXKSuVxxRXbYaRT18ZBtFMnRkNpuMUbfCixNx9VK7J4uYutqsc7TY4QPqP1Nkt6Ki2cDCGHF5/jcImF+Wgy01dRvIKrmR2gkkQ+ouamm+B49flvfHzC6U0gs2OXePOEumTwgwrfsLXa/YStULmmmwDOK99L57fhw77uc33liNgw3nA9u67hEVh6ALoX5PTb3Hv66RCzznLNihNBg0o0RGxWNG1/lawgPNXIN5jcv4lzdZp3RtgpmMjrk2E5qTFTohzjIID/vZakrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAvMw9UFEhZ6lax5oHWCl0uxEmMvrW2GKjQ2jZ1qNhg=;
 b=o7AhWu1KX7KREf7o+4Sei2GlB0X7m92RJjEmIDxZJplDJmPpzefwmo3hv5+kyrtP7j4gs5Wmg0Rxak0T7QN+j3MGkzljk8INzDTX/weo3lpJyybF3SzYP3m4+UAOsoop5nV/8zl6bNMc3tUUugFHVKaO9B+nW7YKPh8vMgi+PRc=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 09:33:58 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::76) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10 via Frontend
 Transport; Thu, 16 May 2024 09:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 09:33:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 04:33:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 04:33:57 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 04:33:56 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 0/1] PCI: VF resizable BAR
Date: Thu, 16 May 2024 17:33:33 +0800
Message-ID: <20240516093334.2266599-1-Lianjie.Shi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b9d10e-b66a-4633-c9f2-08dc758b5029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9gV2977qRhjvSlKCmszwKOx4ynDM2HudAih+VIHWt+SXbHXck9Ig3trSVNgI?=
 =?us-ascii?Q?7wVadDGIlrHUc1eDGO+90kBET/ZpS1MWmpFGYRBoj+Az/jNwWZDENbjdbL2B?=
 =?us-ascii?Q?nyCWLUNZxmXOkfjt00lqZNsZXPYNBSNs4BZhkSmEgJdTiIVuuDf9z0eCA3LV?=
 =?us-ascii?Q?wk0iQUunJpayLmcYxw0FWMp0COBD0/VYocwC+YL/+2gp+gjl3J6htko7XkYB?=
 =?us-ascii?Q?4HOppz0WyGa5rrdiOA8sDRMIPXqEMRLWwTX8nJpXvKnoNlI0s/fO4847EZCz?=
 =?us-ascii?Q?ERzksWTkmUJVxVlf3WGWYDubgXqse0xuN+8eaAbU2ZPZysK32h0cYVZUSbGs?=
 =?us-ascii?Q?5jTmVy6GtTbgtctemM4mCTK/g0za2jidQxTFEdPgriVyG1/9w8vks0J9evHR?=
 =?us-ascii?Q?soQk4Zcyo4B/B5oHrm5uwtnbGFYOkvcaJa0grEXCVb1voWwjrkKtgnbH3j14?=
 =?us-ascii?Q?aQYIINsYxDHiWj89YAH3JBd4fCXkKCuxPc0dePkF9SFtZ07mXm0rExqx+FmT?=
 =?us-ascii?Q?9/FnqW/oh8989zkcMR0Rb5nwlbjUxXgGezrDUj2lzYYTDuzL36YWMtbEa/yf?=
 =?us-ascii?Q?/2peqydPCnBuX2ItwZDzw8YBjqF6CerCCpG3wfjMLSkJNJgBnnLW9fiW2opr?=
 =?us-ascii?Q?WSE5SW7PrIu9gQ+zcSNSwDccVmN+FujNqVf0vrmlkNQ04FzqrTgg0Nbuvk8M?=
 =?us-ascii?Q?7Oft2Yw5X9XgCJ0fjqRSrICQJ650HgWBQVxODnycH+nk4ODTW50tjg5x73hg?=
 =?us-ascii?Q?3/upG9nPOnX3+06baOIyPIKpVLDG2sRMCx4nN6gQdNJnQEizKIK7hLjhbxi2?=
 =?us-ascii?Q?/rY9dM2FhDzhbKI023OSCuKAvfhsZAhRDVWuTyQ6In0CCLAWt2fSFNtVDZH4?=
 =?us-ascii?Q?OPusB1EUg3DuCeOdQL+OWyCHIpaXveXq5iy5eNDmwY/cEC6mOiOy0x5m+J9z?=
 =?us-ascii?Q?uIE7vS34yAYK3syTbGe65O2wCgUI4uvDeQiivV7SGIRFUY8YmUJd3SCObrJ7?=
 =?us-ascii?Q?rB9Oe9Y7QPUVSGwi2fiDpLNT465UDjYRB6bZld3K8ApAJg25q7972SaonO8i?=
 =?us-ascii?Q?bkqecEkL8io6eD1/g/xVDab0PQJwH9U7Trbv4ZqBoPmOFhFJmQReCnoSQhfh?=
 =?us-ascii?Q?+Iyd5un89F3h2vQFOQTo/7LxpSM4+uxv5bJMHi658b9ui9dC5WLM3/VGph5c?=
 =?us-ascii?Q?phtK8/Q9KgsGXXSVEJvvyNZODaeABL7TMUthPagVWnZbELh65igUIN/4AtTl?=
 =?us-ascii?Q?avvBmkgoLbkStbexFyAY6VoWXHqgnMciDX2AUXrZf3ej5O383BMe7+A+qb0k?=
 =?us-ascii?Q?fs4JtMeZ2pJz+9yMcMGfx+xpD+NH342ip/dN7RXSyKYMtIk1OXkZKFUrwcm/?=
 =?us-ascii?Q?hGiAc74=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:33:58.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b9d10e-b66a-4633-c9f2-08dc758b5029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

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

 drivers/pci/pci.c             | 44 +++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 82 insertions(+), 8 deletions(-)


base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
-- 
2.34.1


