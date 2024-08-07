Return-Path: <linux-pci+bounces-11441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D20D94ACC4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4483B22F9C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879F84E14;
	Wed,  7 Aug 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="djZS1vP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A512F5B1;
	Wed,  7 Aug 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043868; cv=fail; b=hXPxZBZogiPixnlFuXRTb+pnAswEyM5MkXwYHxQ6q+27h8m1WuMXeEKCqZ9phRqVN6h86Gr8lD8hlTIJbmXL+4E+SQFj9RbZGS5Ku2UvftT2+kwNmq+QmtDX06a9SnLYAnn5b8tTOi6h2zVer2TYMHgke5CWD8f1jxUiESouEmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043868; c=relaxed/simple;
	bh=gXXfhf4woFguESRPS2CMN46Pq4Zw0K+E4mmrr9mk0V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDmjCa7LVqZD5HYX0EoovzonYPWp61JHOpXchTp1KimNtXfc2C7ZBNy/Xim6A8ndeQb37XHVrwrXpGHXcuP3OZvb1iAD1Jckv3PbS26s0Uz2E6J4LK9g70J1wuis2O6N8YdEWc/6+Xima+g+8jm4siVn1vZEEN6T5n75puac/fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=djZS1vP6; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTCbeuNTJrPcdfMeKKrYnye/3W0UC95/oo2e+aYwqQ8yH0RadFipmIpFHCJJY1yPd3knR9Tbwe77G8oijEqkbvqh2NVqCVT5h26ezR2eqHHct8586Z8k0tGBIY6ArR20uaC743AnrehBYa6cB/JZtslohSn0qBWVahg58tVs6D876KoymHHY4MkytRkcHmPgQ68syWtptYUMw9eofpVXGgJ+a9VFT9nNPkKqdirSEyVq3A/EyngfREnYD1fTpJTWysPMqkHkYFuH3/bFVIdsCAMAlYtjDXXewXovoKNCQu/4ibIhOT4VdRHCdN8AKOyabP8frDHqPHnLaMFjnNBgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLFg0mg+YVGWGwkYxp5keBZXpsyMlteDCbkUrVXS3cA=;
 b=sxAUFzMHVJzEh9Jxvs5ySC6IvPo8yFAtKsC+FGmndgxrk2R0aXlwAnMaOyQMFTPT0/b5qH0+q9KBYBeMaLTjRPg4kx7t8gCQIQ7cSgixqBkHDeZ+LNuo8AsVF3AMkW4I9XSUGacOE3xlK1OGUfZzmrZ6buJ+SCnPdyAmr2XE8gsrbKl73kpqYWBtrhEzV8eef731B3HRhY7ZNSePJcaXGoTsz7lT7MWw285gkMfcyesxzoNvvvCytF+a2Jxp6jCMJaHY/zUKMCHbgIoUVInz+YV3eW7t0smzgqlfx54onz88wgUnVzl7c0YAkPOdgalT5I7A1WV2lXeFK75hPnDTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLFg0mg+YVGWGwkYxp5keBZXpsyMlteDCbkUrVXS3cA=;
 b=djZS1vP6t80J2GP4ElGjTN0Lmnql6vYw1WgEAJRXwoKLdCyOXMHSAZPgvuXW3MeTQxHdsm9vEko//7rUBiSdtZMuMtCUMWxwQ2C0/T5XOA6NMGjVGtr+LLQKQjTST4eZeJVmgTPlKn5CMIoqfmku7e7aa5eXC+BVfBxP6QoWNUw=
Received: from BN1PR14CA0010.namprd14.prod.outlook.com (2603:10b6:408:e3::15)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 15:17:41 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::e) by BN1PR14CA0010.outlook.office365.com
 (2603:10b6:408:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 15:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:17:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:17:40 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:17:40 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/8] PCI: Don't unnecessarily disable memory decoding
Date: Wed, 7 Aug 2024 11:17:11 -0400
Message-ID: <20240807151723.613742-3-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1553af-f625-41fc-e303-08dcb6f4148e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIsh3ETLQYWurzqb6L39veielq2rhA1lXA3xmOE13ujD3Udsm6/e7sg4QD61?=
 =?us-ascii?Q?unRKbWYXpN37GXKu7qpWg1id3XtnAYlWgAY1ltDJUY2tCOLHrYBiK4CSvTcF?=
 =?us-ascii?Q?rz1ACIWIKTYix5LWVyf0/8uJ4FywZDfJTnFtvzVcLwKz56dbgh/j7JCcB/zT?=
 =?us-ascii?Q?NKgjIur/BaSeKiCnJD4IfqPTgq7qYDtEJT5U2ncr3PhkEhy/zrhZXsq+H5GP?=
 =?us-ascii?Q?gf+4XpxJ5i6xRVlculgrqGRF7ezQTTCkCC/DAPSw6eT3PlK9RPVkqHZaNNiK?=
 =?us-ascii?Q?p6ZylL9GQmkp6BomeO0VtX1TaT3B5GWclyZMyVwGWFhV/ltyXBCBHH3+LHTW?=
 =?us-ascii?Q?P4vO/X3OOrjmGIJg+u7J2/9gYtn3Q5rUIXk4LvQyKAtfP5Nc5ZRY1QuQiTR/?=
 =?us-ascii?Q?T8lwfONI3dhG8leULK+nXOKwWcj9XP2Ds4dH72OFBqH5LYmB3KxfA8GI5xQY?=
 =?us-ascii?Q?KlIBnNRLPVbDatsKiZA/fQdkUjCMDgokFp7u5BO2aJlfPQ7YFaj3H0pPigeE?=
 =?us-ascii?Q?amdEm89wRY2tIoJeIBEAe8ZpxMzTJO77+Eh+UkPFLWrnJalYMJ/kSzqLITvz?=
 =?us-ascii?Q?b+Fkst70m4jW2bfviSme6DoEvOnxUY/+MAZ3SnedGfq/zshjVOW+3E2EtJgf?=
 =?us-ascii?Q?D+m84pgJMmhhBTePZvIuq6XSIlnrg6o4nK9iTvx+H4SJVcuYTX2y+JOEiTMe?=
 =?us-ascii?Q?Ze+82GCr5Bd7C7/A0Crz/h7B3IIDsGiU4grnNC9P/6P6hl9xp2/VwMbZ/Qe2?=
 =?us-ascii?Q?d67no2gSz1+wIH3cmuRpiLsfCZyGDlrnBMg4eE64Bct+GcjFjMOTtggNo4jV?=
 =?us-ascii?Q?dhku67Q0EL2Pl4ddskid4tODNYwMmkcnDf1YhlN3EMYvjTPBsiReSw6oGETF?=
 =?us-ascii?Q?3pFDcbRBhm6gtYyQvolW76CT72dBb76aBlgdDN6HtCDbomWnLaGTJYk6/DKt?=
 =?us-ascii?Q?6DOfXzY23hC950NyqfZfuyVjTtGZBG1SQ93hlPdaL+iOVNfu5JVQJs7ihA80?=
 =?us-ascii?Q?tCb2N/6U+R+gr1Fkdf0NOHDnLQfkDiYccmVrWlwhpC8l8unvZC7vM/Z9uOf0?=
 =?us-ascii?Q?eAym7y6w+eSl5EfK2zcjjMc2uY3+mLIENN1YoeM91zUUSOS7HoIOqJV5EdWR?=
 =?us-ascii?Q?EdHRVGRgTdovX7Ospgwc076tg1EFhX96mKWmUtV0cipz24VxqRNVLzu7uk4C?=
 =?us-ascii?Q?h3A/cdA9jqbNKnWzSrOhLkSrAyDRqDbfZhMKp3VVj1ncscYKgk/E3xBythst?=
 =?us-ascii?Q?fRsw92nzS/VC10dLZxJ0EGHJpOx7vgUHY4e1U3ddUc9sir58ONaIpptBiSYf?=
 =?us-ascii?Q?SkD4yRlWgCowCTIWJVtMcNr3shQ9f6VY+Pbv1hphnHfmg0hx0iv6NoLUsIi7?=
 =?us-ascii?Q?cDZ7zomak+UDV/aNYGumsd5U2N1FStQXVPPF+KeqYJZ7dXreF5lci4UmyNKv?=
 =?us-ascii?Q?/PeM22CqOxwhPgKEf/IV+26e2U1nDgnL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:17:41.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1553af-f625-41fc-e303-08dcb6f4148e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

If alignment is requested for a device and all the BARs are already
sufficiently aligned, there is no need to disable memory decoding for
the device. Add a check for this scenario to save a PCI config space
access.

Also, there is no need to disable memory decoding if already disabled,
since the bit in question (PCI_COMMAND_MEMORY) is a RW bit. Make the
write conditional to save a PCI config space access.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* no change

v1->v2:
* new subject (was: "PCI: don't clear already cleared bit")
* don't disable memory decoding if alignment is not needed
---
 drivers/pci/pci.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..acecdd6edd5a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6564,7 +6564,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	return align;
 }
 
-static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
+static bool pci_request_resource_alignment(struct pci_dev *dev, int bar,
 					   resource_size_t align, bool resize)
 {
 	struct resource *r = &dev->resource[bar];
@@ -6572,17 +6572,17 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	resource_size_t size;
 
 	if (!(r->flags & IORESOURCE_MEM))
-		return;
+		return false;
 
 	if (r->flags & IORESOURCE_PCI_FIXED) {
 		pci_info(dev, "%s %pR: ignoring requested alignment %#llx\n",
 			 r_name, r, (unsigned long long)align);
-		return;
+		return false;
 	}
 
 	size = resource_size(r);
 	if (size >= align)
-		return;
+		return false;
 
 	/*
 	 * Increase the alignment of the resource.  There are two ways we
@@ -6625,6 +6625,8 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 		r->end = r->start + size - 1;
 	}
 	r->flags |= IORESOURCE_UNSET;
+
+	return true;
 }
 
 /*
@@ -6640,7 +6642,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	struct resource *r;
 	resource_size_t align;
 	u16 command;
-	bool resize = false;
+	bool resize = false, align_needed = false;
 
 	/*
 	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
@@ -6662,12 +6664,21 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	pci_read_config_word(dev, PCI_COMMAND, &command);
-	command &= ~PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, command);
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		bool ret;
 
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-		pci_request_resource_alignment(dev, i, align, resize);
+		ret = pci_request_resource_alignment(dev, i, align, resize);
+		align_needed = align_needed || ret;
+	}
+
+	if (!align_needed)
+		return;
+
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if (command & PCI_COMMAND_MEMORY) {
+		command &= ~PCI_COMMAND_MEMORY;
+		pci_write_config_word(dev, PCI_COMMAND, command);
+	}
 
 	/*
 	 * Need to disable bridge's resource window,
-- 
2.46.0


