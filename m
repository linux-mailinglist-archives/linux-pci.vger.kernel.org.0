Return-Path: <linux-pci+bounces-18198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA99EDBDC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E2918877DE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC31F37C6;
	Wed, 11 Dec 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PalfcSEy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED81F37A0;
	Wed, 11 Dec 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960482; cv=fail; b=aU8DeNTLsE9u3ZtEihOXX8GGAu46WbQQtpAeE2+FfxNTPN50RwTA3kI2UFXXe9/HT0xswQfp3pBo/mqW1b3dp/DkEqq3kQ1+Bhb2nPyaA1jJvWN3c06F76Mqb6ScOxIFX2B44hDXqxgyAPA4NVeWsv+2C2h7wg314Dc40mHRh18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960482; c=relaxed/simple;
	bh=4xy79RvMUBTSuuqkSgmoDFbN2MhKV7BM8fw6S2gWZcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3I5NLno13xnxeeDCxOLzvkAM0OA31z8H6mJyvGTt5rtuHGeTi1I4gp/ocNS51TSGAClzK2OzCk/gKLPNBvTjXGhYK79xnpWMPCTBE4UjSNA4xXuEoi7hA9Lr0jEgvrxDuKw7kV9L7yJ9hkf+ppK9BlfgPySILLDgNm3/Immiw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PalfcSEy; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsYR2gHRa9Xoec2ukZeX7HkEQYcH9vpdRfWVIsaJOBCFJj0nvc09QaJekAUAw3nHjvk+gBACB4Qnt+IzvgWLciuQWfJ5B9FkETAt4ZQlrSfg5/OaG+iNeVcGKiMAkwjWeZINurn7MKz6HMMjOq1zao6jXzaJ5C5BbYmNpIYbBtuhQVkBegb91p6NxWtKS06kRsunfKZFM0NXt05l/zMXDYhEbYDQsGHR+HSeOxlUcIA+1HUAgUi4KgoWGUiuQh8cZ31NjKF5kHW+rSLqFiqOapuwme3QkK2QVhLYLNIhCkdxCWlIv/pPW4p3+VPvRnPbGfqZD6TEQsb5GwBXQcdJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec7aZQy4HhCIDEEOv/YdM1v3AL0Ausk68X92atOdWKQ=;
 b=YfObB0eirFFjNRIux3OXAYIgWj7o+jhFf7HWi1ba8ILPcmgfQdhWYpRh9XLcVtCv8ktHBUIpR90x1qtc1jBsP4TJcg9H+tB4kLaUiOgHK5VdZZgip1UJIjiDjUSIwHC5FHI6gOLku9D/HXfYDriGcLKtInjxiAI7Qq6DClT7yT/8n6pD1aPteWB3Stcto+hDqZ9k1r313sm4seaeEED5fJaFMu9wOmi3+itYFYjoFc5QAVaEFFMgGhAc8NYjov/EWkIbp1274amyOQgIKJZvUZpg63NN0GO3eQLSeLkWELp7ZoFmtTkYhLY4WxXLEkF3IkoOKFoJbYC1pjNqWziK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec7aZQy4HhCIDEEOv/YdM1v3AL0Ausk68X92atOdWKQ=;
 b=PalfcSEyv6MABjskYOrKLYA8P6E4A8dWOEevkRBgXh4KhJFo/N1Dw2MhLnV2TUTOMI+O+R8MgbghAJwJ/QThBwhw8wR6LzA5LGz5H6ZC7VdL5SWy9tEbIR0rraBXSRyS2+wvPziCm4vg2DGeMa8tiiXlXxn4SjXP1z/002F46LY=
Received: from BN1PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:e0::22)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 23:41:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::50) by BN1PR10CA0017.outlook.office365.com
 (2603:10b6:408:e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 23:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:14 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 06/15] PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe Port devices
Date: Wed, 11 Dec 2024 17:39:53 -0600
Message-ID: <20241211234002.3728674-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: adf6eec0-1a6b-4ac4-78ed-08dd1a3d4d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rw7v9Gt3tr7H4g1L24wmAIH3aoWcT/bzag//m36sZjwCR4zyLkvI9qoIrfb4?=
 =?us-ascii?Q?3u+JqlWC6zT/62te6K49zBhD++ro/AzFI51r0YSvKS6o1QcZb2UQe1IvW1Ow?=
 =?us-ascii?Q?mbcecSt5IBYwBph2glNYCYyChaEwdkh4qQh8n2SRoVCRfFm50hhPDcCknmB7?=
 =?us-ascii?Q?LErLnSkiQ6gjBmpv7/d+j/Rt5OxFytFQR0Yza39idjDxLXv8Era4YDKsBd2d?=
 =?us-ascii?Q?1ZxS8YizpG1pm+VZSPLxsoa/DeyYRXcIyk88VYLN2lvDJAzy6xoKSZ9mn7o6?=
 =?us-ascii?Q?fzxDZoi5I43pgghuLssoPKHF43t1OgAhjQ4nCgA04K1A9E0tfCce5krxexVx?=
 =?us-ascii?Q?6Q0l5VPl3pQYh9LkGcP0FZinEvh+jCRsyDbt1+Mxp6x8IcOD3Q77OamLZLxi?=
 =?us-ascii?Q?0KLQwuno2bhxSWnlTwuBPaw9H//7DbXkUhJNDGfYWa8GFHZA0T342pHLZ7wb?=
 =?us-ascii?Q?uY7nFgl3yEsIEt6tzhz15y+7vkh0Fph+q6jQdptxqdV23eOqOTja/2X+Yc+1?=
 =?us-ascii?Q?eg0P6559Y6sCtaPriDnsQdEHI7wAUbTIc5TVsXFzMicFyEtcPI4pg9C98e37?=
 =?us-ascii?Q?aqVCLkmqB+LIXvenWFYQksl+FdvCrF5T3zYBYqQajX47F6HPoBooiDJM9oS4?=
 =?us-ascii?Q?rEAYRKYsmzsThCE9mftk2kXRFoT6QSbHFPBkkwlWiQSBbkqY23aa7XayeGJu?=
 =?us-ascii?Q?ODdLn4IIQ+Bkb4pgpAd3tHDDiWS8j9m3KGIw4N01lv37+2Sbi3HOBH1dlvs1?=
 =?us-ascii?Q?sMK/onObZE5Rqh4Kth9QhK5nT5PsrthXAyyZ8sbR9cezohpH7DrPpbgSaEjy?=
 =?us-ascii?Q?bV1fMaaMr3VacYlgc44sBxd2tC8H5DqK6+zTLApqCy+1Tpy7yf00zyForNEx?=
 =?us-ascii?Q?cW8/k/mLdcZVamYxtn2eWPPAHxutzwWfZrNfYtEpQf6bEbe3cgKBOez/v3m6?=
 =?us-ascii?Q?4mIExDGc6em4zKTEMaEUuu7F6GIKjoz2avTYzrJL/8KvubgOM+AjZqE1dVyV?=
 =?us-ascii?Q?RqJNVK7e/lLQ/yv1MoAfWRW+903VzEx95qxpXsxkgydxqkAHsSbjd7lHbL2p?=
 =?us-ascii?Q?HJmVdaYGEQJN+Vib5Qn4z66P7BptKSn8m5jWzxCnEtJD0K/pHifA9jBx14hm?=
 =?us-ascii?Q?uV+onZnb4v02bgnvbOdZDU4sBP4242MMZnUpWCZMo8APohpPch2FAvUupEPW?=
 =?us-ascii?Q?uZrsnq1VnvDhQonSYVZtxF1ynNTlufnbZiavvncCTtG6u7ZSqQU3IhAPsuQX?=
 =?us-ascii?Q?6PUNoZcB/OyahXWsYQWaaVilfwCMR56mwHldCZ0oob5AHMQK8e68kuCg8clq?=
 =?us-ascii?Q?o4Qu66ISEhxAMW/R/3iKSMVBb3A03u/EDfdX9/S7CMYG8Xfaya9hKdvbPrrP?=
 =?us-ascii?Q?tQiSdK1W3hiZ8HuXA3hvkD2sg+wAqbT/PWBIztvWz8cKf+eA8tgk0BNtAOhf?=
 =?us-ascii?Q?9rhgGV8AdMVCNa4uajUCCArVLfTuhl3gMpeOa//rA+NJl3R4eQuoiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:15.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf6eec0-1a6b-4ac4-78ed-08dd1a3d4d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

The AER service driver's aer_get_device_error_info() function doesn't read
uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
including CXL Upstream Switch Ports. As a result, fatal errors are not
logged or handled as needed for CXL PCIe Upstream Switch Port devices.

Update the aer_get_device_error_info() function to read the UCE fatal
status for all CXL PCIe devices. Make the change such that non-CXL devices
are not affected.

The fatal error status will be used in future patches implementing
CXL PCIe Port uncorrectable error handling and logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d75886174969..c1eb939c1cca 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
+		   info->severity == AER_NONFATAL ||
+		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
-- 
2.34.1


