Return-Path: <linux-pci+bounces-3989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4878668C7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 04:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63FFB20F5C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFED134B2;
	Mon, 26 Feb 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EwMvYrEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E4C8C7;
	Mon, 26 Feb 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918290; cv=fail; b=ILe/vNjIyqql06PAmVnFKRFq1eINZoYfsx8MuOJAJyOw6IV1QMFSErtD+pgt2Dr7lsWjs/Sml8HTvUmH4qbxVdYb6Mxz7GSUYp7vvhmOBKZpRceRST+8qcMfJB6GNXF7hX2xwql/N9wa2NVnvZ1B9ILacTDXh8vpZR+6vymbuQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918290; c=relaxed/simple;
	bh=Sj0ZivCRL2oqi48w+6tkFj3grP2WYOy9T5gE0qTUHxg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WsXuqTmiB1FTn7tSOrLEs81WoYXu6IqBrBpj+jRfj5eFBGUaD5dUXugYhs3RC2o32UCXJeGuIMs6Niyox/V1DdWDdTgb/PFnQW42qe0XHxfmSB3dbJHeZTgKhmsHojw7Q3xD86juTJMjdpm9QcRo0O/patN63YVakykMwCKSlak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EwMvYrEi; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAcimurMFv2t9Jjkh3RBtDAM9kv2mMT1aI01TeZUnUnrrbD7MxSXFxEu6PqlH6C0A5/L01xFJ7QHD7LSipTMkq/tlY3ISL0VX3sCpPytI3+tHaJrZVfuBIZp+C+A5gMOE/DuKG/C7QpJ8ReChJEAUvO+nu/bqBdSil9CUiWKoaRTqkZpu1JeyVTvCAx3c/n5tPkKL6LkJfd5q07Nr+ruyEy/yD6di3/whhAadS6st+Qs/XXsfpZC/guA5ClOaHFXIuKUDraueR5cdyBEUDaUbbBBK+P2wyHzy1M4x1giqN3EIKAJ2/J4N87Yn03SVyTtn496c//pi9JuzyOuuCQNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFE7soO2Wosk1H8u9LU9hbw/dNpeK468h8N8GEpRttw=;
 b=cbrORB3Z46GL/4bTR2tgND/5Drux+Cz4VhMoDjPHsQcV0MsLypxwPJ2xFiPERS8YetCiXbnP3sUb6YNA8ETt/3LJsXPSWdfjY4Pi5I5xPUN8C9pj4NFm6SnWanaiCEmxgEHXvKnJ8sE0fBlafd4jOZ2sDLkZaWH8acjl58veqOuRSv9mrXx6SwEOXu6yfkI75BEVSbCPqyJa4VFzqNNOplZWetGjc5WffUqEdFqPUsgDaUYMSsdAGwn6tzeXXZEjfLEGU6ptZMNw6dXQXrzi6MS1bEWzBS/oKZaw7w7hNrcFbWAexCUbcQYy3tUa0kCVS6lyICt/dxd1EhsXXXzFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFE7soO2Wosk1H8u9LU9hbw/dNpeK468h8N8GEpRttw=;
 b=EwMvYrEih7w6ZVxBl9PilB/QZy+yPrHd3WSRZjwpGE+/+bI+tbaUW4wzdwLyS8DZJLaaPh051GPg7RVChHf8L6sfbVqpuuXGeE2lBjScGCVby6libADQINobp2IgiFHMAZ/JEwP7avs9MJrTOUpA86V+XmpBFyziQEbNyCwz3xY=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Mon, 26 Feb
 2024 03:31:26 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::98) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 03:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 03:31:26 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 25 Feb
 2024 21:31:24 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel v2] pci/doe: Support discovery version
Date: Mon, 26 Feb 2024 14:31:14 +1100
Message-ID: <20240226033114.3100118-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: f6497197-15ff-44ac-20ca-08dc367b6a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kBEqHDnhMfv64bbfHp23UV9DJD3SsXcGTExOuDL8FpxPTvMtbIVqGZ6g5pV+cfwIRATKOq4Spi5xI9QOzVusI5g3kbaaHDL3XrPfsInYhIkXthNl1wlrpcKW8IVz/nJhuGBlb7QEyxr/yLm1WtiCNDDFNO7vHvpRtjWK8DWOENlUGVCgS82bnaMwaWDFXaThytrOXF7+L3dfR0U935rZtlAOAS82pLfIw+P9UFoy6BDJ41uwgr+Ejjm6IShUrXDApgAeBWbRQKR/di9DNQMUq2EqS2j+XfrsBGzgbH2Y177gye0/9ACUgYmdWhXeactkcHcycKGIvEF4iRHU6jxO0ygE37vqVG23ZNJh+gS4Wm5c13o4ibs36PPr3vouYnPzcq4mTZYXuJKle7jEwK9NYcAdjKJ1v7sn429XsQbre44BFz50scIp2XT2CbLreVrWcEh4xveDxe720KGP7dmPwyqr54brOVafMK276NgR3ju99QwSjneotMzvteWvWqmT8zbDNtVJZmSll8u5x2KmF//PdHtcTPCSJVQUCmySXPTK+zmzht063TMElwd5x2ZHSsI8GASdp2SNAn9ONfhSmPvIxe6hjD9PPoIqqZHZJWSmoyoz/awgyAz7ESP8EtAUAIrDDJcPu73AnRKCUrdfSn1KW2DtuazCmiKJQMSw9x1+R8IoYM2iyJXrGuVtDWGrlZpKWt+yIJPxZLaVTI1lb7ZeKPPdshTu+YeVAQPFlKjCgcDNi+JkZqqMbGzhcJJr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 03:31:26.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6497197-15ff-44ac-20ca-08dc367b6a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153

PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
the DOE Discovery Request Data Object Contents (3rd DW) as:

15:8 DOE Discovery Version – must be 02h if the Capability Version in
the Data Object Exchange Extended Capability is 02h or greater.

Add support for the version on devices with the DOE v2 capability.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
v2:
* added the section number to the commit log

---
Does PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER need to be in pci-regs.h?
It is only going to be used by doe.c and yet a bunch of
PCI_DOE_DATA_OBJECT_DISC_REQ_3_xxx is already in doe.c.
I am asking as I have been told not to expose PCI_DOE_PROTOCOL_xxx guys
which is somehow different (?). Thanks,
---
 include/uapi/linux/pci_regs.h |  1 +
 drivers/pci/doe.c             | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..b9c681f14181 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1144,6 +1144,7 @@
 #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
 
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 61f0531d2b1d..f57def002175 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
 	complete(task->private);
 }
 
-static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
+static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
 			     u8 *protocol)
 {
+	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
+				(capver >= 2) ? 2 : 0);
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
-				    *index);
+				    *index) | disver;
 	__le32 request_pl_le = cpu_to_le32(request_pl);
 	__le32 response_pl_le;
 	u32 response_pl;
@@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 {
 	u8 index = 0;
 	u8 xa_idx = 0;
+	u32 hdr = 0;
+
+	pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
 
 	do {
 		int rc;
 		u16 vid;
 		u8 prot;
 
-		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
+		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index, &vid, &prot);
 		if (rc)
 			return rc;
 
-- 
2.41.0


