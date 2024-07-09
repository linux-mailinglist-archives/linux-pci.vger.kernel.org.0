Return-Path: <linux-pci+bounces-9996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C292BB8D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66190B25E62
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1216A954;
	Tue,  9 Jul 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D+bbJ1KU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BE15FA92;
	Tue,  9 Jul 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532225; cv=fail; b=b5L+nHCaGxf5Hf+VSZwlR+xHtEhYsG8Jvo+brADI4529kHie09ZNIqICIM1QJpBbeTYxhwlZBN2NnP0O9pDg7TmZdg1BVXSw7Z2ATNBOa1OpZN36v/NLYEHvg0zBGLVWEys/qixDcOOx9wc2WPyfUFu8SGYoD3eVjXnKxd1zjwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532225; c=relaxed/simple;
	bh=an60jdYUqPCukqyC8gqEbp5u74A3I7rEmSCc5k0usG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaC2deMUnKI11HnJ4UbaL7ceer7LwdcZf4ZrwWCszJBQ1nwdNKhWiNP+KtLk1dCaG6GSgUgZAP7ssGy8ahJ1YoT7hnqaXOCGYvXkUtPvmKwfTuaGFiYIkmBGig4qwdsS84xWM0hL/Siqddg66x3MvslOMc7agN8moNCjmTzHVC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D+bbJ1KU; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtZBO/D3ZJOm9yYhmEGaVsmoMwCsiiHv50JKm6YM5K/vWqLEy8KW/dZIvaRvxEehW2YFCFz10TGbQFZK0kc17aRyVk3qCmNGSSe07eo5OFd3lg5nASggUU0PfzyEtQUguPoCMoys+vu6PAP/dKvYtyiamA/wnLVG8eevsH42iYyqVv7ll+VsKP1q8kIaSKTevNLlXat34Rc0ebxRWH8v7WUFZGOHueONE8aIj4R9nZoST6BJCDnD8nms2yNnN1hrrMjhBSJpAQCUTEdwAqfx1vp5Q1VY/7BtE7/xv1yt7qFkSKN8fNXIO2rJBwlWatXBxsspK7WeGGfVtv2LlRinJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDBMbENE49/Yg9F3kDv942Neil13fXGmY2MRG+xLQfM=;
 b=emrZSsfGdxzsanKbrjEPSwr5BbT7Hh7l8kI2zu1MUOOonIuLo5YO2KaxdqTyLmrZmHg0kg5NsL1Is4r/TpMFKa4gqrVrsdtuazyghEWBPlbtbD3bJ+cJjKTbsThczmtaIdbpJlDEoWdprNp7clvLSCBmoAuUXLjkzBS6qP2qk+cL2dPy4TquuFODIVSOMTEG7AUrv2EHauh+ByoCV777mgWWDjCvV+PaQUBltTi52nf4kfoK7UyNYWnd4DLIvep4Dz6OLoYntYdOFqZX+Mib9zXDKcGIuM2KjUCcwul/CcDqoI9eKZdkHeHR+EdnkDcjf2w8AbX0eUWHMsdCMtW9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDBMbENE49/Yg9F3kDv942Neil13fXGmY2MRG+xLQfM=;
 b=D+bbJ1KUf5+VXaErKG3DMuwcqdRvmlHoBXXU+7WjEgFeDmia5vrQWtWhn81qJ3wRmQ4MpFhL6Yv3CAWIHb8bI43TrGlrIweajEAyyB0HHw/+P+O0gmcW2oBvhFBwTBtv+dFwgk9kwwMmLlj/ZuO22YlcckQoNMHQv9OpUjefLw8=
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Tue, 9 Jul 2024 13:37:00 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::9f) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 13:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 13:36:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:58 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:58 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] PCI: align small (<4k) BARs
Date: Tue, 9 Jul 2024 09:36:03 -0400
Message-ID: <20240709133610.1089420-7-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 257e210a-3cbf-48b2-e335-08dca01c357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mix2Svk3uZIFXhtAS+3ZrSbKQy/UeisJI8Z/PmjmvGh5UAJXFd8R321wAwl4?=
 =?us-ascii?Q?AOCedPoKZF5fm+Ks0rpZCSNwvSjVa1Zf+2CIOzKs3PLogYFP+bnK658CsnQ/?=
 =?us-ascii?Q?27736WylBN/5cnBQqVt4ElME4w04Eb23kjG3QiG9jjAYKTBvP4qiuhgNRJXb?=
 =?us-ascii?Q?3P63j//vPzM8oa/YaAeCOaf/fQrDyWLpJHMngnWFMHLhEpd7cT+cCCmwrO+T?=
 =?us-ascii?Q?uNRjUyOO3ROlgZBZ2Y8PXGgAWfeDDHni/MPPS9cFZn2MDyjIrmNu+b06qi1r?=
 =?us-ascii?Q?4IHcHb40pRFiXJR09C9UIrca0syvZ/WcynRMurrh/ji0ciLG8PtPDyzU7goy?=
 =?us-ascii?Q?OupqrB06x7K2sdR/uo07KRM7gEmUrrYAbYewYsLoX64bstNLfxuc4XqQVBRW?=
 =?us-ascii?Q?YTMkD12Vbqf0xtWM6Givsqpe9jBV4O/WVTNIXj3Ujz3CUGxzwCymG3FXqZb4?=
 =?us-ascii?Q?eLjihM7ZwRO46uY++DOH9xv9vsW04ZM7mfrJjg5BwX5jyXTFM8o9PEgvyBCn?=
 =?us-ascii?Q?LPJSp6NFGc97sQukRFsL7f3wlJy9qVS8Jbww6PmdZ1w03PMcZaasO4cZXF1t?=
 =?us-ascii?Q?x6Snvh2I74vYu+uglXcrQP+ziKNTK06kuvvc8XUydYvJkfKXJcpJwxnX4eDl?=
 =?us-ascii?Q?R2Dlx5P2nh7MId8aIJPR1tuRp5kashoHIqU0EAo6xk1zEbF/lil6skbHnUnF?=
 =?us-ascii?Q?ZgPEFAhZIobo7NveOLbTzaiR05vRrgytDcY7Z/AoTPPFR/1AM/ey2vjb2PSa?=
 =?us-ascii?Q?CucqOkMK+xtqt861YSEUcudwZ1qgbhGN4hZL2VwQjQlbiZRQ6yI7v5ZKnDlt?=
 =?us-ascii?Q?+9vQdpWzGNDSGoASh0NmiriqmYExsNrhnbORftb+PYsugaEbYi19cVfHsirl?=
 =?us-ascii?Q?ovgL/H0NIbK7YV/zERDCSNDOmba4ovw97lAUi9uX35Zk1c02W96x/81hgKC5?=
 =?us-ascii?Q?6DJ1myLXUUSvsjpnpudZK4A/lXcgdgNZbKCTa8j5Z3v9/D0ecnWsDfFVwHoz?=
 =?us-ascii?Q?mzSa/397ITVcMmTNy7gXNe4Rv30cdC8VjBLLtkmwlhIegzvwn3pHi0BXG/BV?=
 =?us-ascii?Q?P65J2IsPTcgcdVp25mkWV0QnWQttk7K2rxcUHvMzW6Q/XBE0GejZv2NExCQ8?=
 =?us-ascii?Q?MKsesQpxnKse3i0/hAHs/tMnSSsH52hKiiggVZL9807bek8mkidzSRbLSrPh?=
 =?us-ascii?Q?vP/fBfiHWhPfvl76uiu08ne/46h5UPHWBP2I/P5rx/zyP9ZmeYyFt+v1g6eW?=
 =?us-ascii?Q?fpLFFpvDsts2cKD5jxP9XEfLrlLlC+bQMN5ddLZYNsuSPHEV597Gttb6Qi7p?=
 =?us-ascii?Q?Xm4BpJdoBx4lGigfmJNX6v158AjGmx4pv5xio/I58QR1LXaPYx/0fU1nqB7I?=
 =?us-ascii?Q?YRnoc42FwtybDzlDWwyyFoGlg5itTRdBX3+9pCFkg4VRjfsX86xDItuZXsAc?=
 =?us-ascii?Q?UYZDbizLF0VgzWnMvrJz5sozID7ZmvGm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:59.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257e210a-3cbf-48b2-e335-08dca01c357c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

Issues observed when small (<4k) BARs are not 4k aligned are:

1. Devices to be passed through (to e.g. a Xen HVM guest) with small
(<4k) BARs require each memory BAR to be page aligned. Currently, the
only way to guarantee this alignment from a user perspective is to fake
the size of the BARs using the pci=resource_alignment= option. This is a
bad user experience, and faking the BAR size is not always desirable.
See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
for further discussion.

2. Devices with multiple small (<4k) BARs could have the MSI-X tables
located in one of its small (<4k) BARs. This may lead to the MSI-X
tables being mapped in the same 4k region as other data. The PCIe 6.1
specification (section 7.7.2 MSI-X Capability and Table Structure) says
we probably shouldn't do that.

To improve the user experience, and increase conformance to PCIe spec,
set the default minimum resource alignment of memory BARs to 4k. Choose
4k (rather than PAGE_SIZE) for the alignment value in the common code,
since that is the value called out in the PCIe 6.1 spec, section 7.7.2.
The new default alignment may be overridden by arches by implementing
pcibios_default_alignment(), or by the user with the
pci=resource_alignment= option.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
Preparatory patches in this series are prerequisites to this patch.
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f7894538334..e7b648304383 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6453,7 +6453,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
 
 resource_size_t __weak pcibios_default_alignment(void)
 {
-	return 0;
+	/*
+	 * Avoid MSI-X tables being mapped in the same 4k region as other data
+	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
+	 * and Table Structure.
+	 */
+	return 4 * 1024;
 }
 
 /*
-- 
2.45.2


