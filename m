Return-Path: <linux-pci+bounces-22120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BCA40CC3
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 06:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552177A3D64
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88335946;
	Sun, 23 Feb 2025 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0t1HU3dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0817588;
	Sun, 23 Feb 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740287244; cv=fail; b=H422mhzevTzu+YM/F1bSuxkDVVU5eOrm85ICrs9Amc8bTSyDj15SLPa4Kia7UmJPr+VFh00a5DKv0bqGbCd5VOTp0QDhIdiIGl5y6U70G/43INe3LJjz4gPZDcx/SjKkAwq/AdJFcOKcD0lv+T1GOXd0JYbQee6ntreWAZ/Nv94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740287244; c=relaxed/simple;
	bh=cLYU7Opx+syvUIaMku/z7nW/2PBkhk8xPSx6s3laUyU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Is8He/qxQoyseqEWvDZsfDjyP7MHEyI2JLAsdmTSKyaam2xGalqnEE1+WEyMzFTJJfakUZBJ5/mFU62PY1kdZLzPs2/D/UaJPwQHzN1ssyxjnCeYGsoNtgoYEZLBg1E3gu4TEeE/va6tzYOwqpEYu6df0JNwoFOkvy7A5RuM/IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0t1HU3dc; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCqX75ODNOZ3b35XqxRKYvC+z+qgmT6DnkR352TnAmAtjkrY19PwxzJ6loQfJIJHsRzvHcmO6Onu0qz4XQwuFezQ/VWgdLrBcj/JfPAfO1zexPNz70uKHUEHLca2AOtLYGsQ9liLMFG24s4u3ns/TUZ3Vag6T+WT/aOZD47CPy1eRLfBzO7RU/MZaLfA9wkQg/14JlB2w82vNly1tJyMCti582niPPqk3L6FkaLoedVVB1Jg1+u2e0iUAAQHiwrPwov0hUgTkNj/Qt4fAsFhtDQc+MAsSTB0aWJUvIEvaMapELz+gY1lALThq5FsH0ew+gfK9Hg5F6bp/3+C823l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inQ+5QPTfvstZ78gK5507J/61Ig09sGIxO8Ibpb8+vY=;
 b=ljXzmP0HllQD+/X0ksaNudMMZVx2UFbunLxwYSycSAr9lL2svUyMGZy6+1OFAOZa01S6Pm/5+pcGiwUKQzAOvH9bC+btkTspwJFYuCgRtVrR8WWoU5bTdjs3JfnPAoeMxBcRz5y7DtBsyaEb6FZQn7uLI/SLzBLMMEUChy/+ry4ckefbnGBbqQ3T4BFIEo7/K+pZnkKRtvS98P7ZkuhMLru2H9HkN4S5jMrBHtpEAJNU9HRlHcLmwxOYC3+HZdBT9rBs4KY9f3NA6dloElCJxxPZvjBV9Pmpt5G4LTk2Lo+n71u0ouft6KLKczRNAwMR//zsSUofZFJeAmajdQELmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inQ+5QPTfvstZ78gK5507J/61Ig09sGIxO8Ibpb8+vY=;
 b=0t1HU3dceNkHXnWKANN63yPilxbcgwqCP7J/WsYplJ1vqxxvzr+jgYLy2cv2xgOHmPwWrH4ruxrwZCr8M2s6I/zzeD/PJCgeoAvd9NoUlgUtIQIBLWDTJnSihYIxy5R/IjBBuGYS8z1fx2Qx61/xX3ZKLOHx1Hf7d3BCHlBubX0=
Received: from MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28) by
 SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sun, 23 Feb
 2025 05:07:13 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::30) by MW2PR16CA0015.outlook.office365.com
 (2603:10b6:907::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Sun,
 23 Feb 2025 05:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Sun, 23 Feb 2025 05:07:12 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Feb
 2025 23:07:11 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: fix bug introduced in pci_save_pcix_state()
Date: Sun, 23 Feb 2025 05:07:00 +0000
Message-ID: <20250223050700.4635-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ae347e-726f-49a4-d694-08dd53c7eeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/SenL+zAXANmng8eEc9gkqn1qLblO7B3RAF3moQtgMF/YPuAnL1R3IuwAvjO?=
 =?us-ascii?Q?ZrbVHKjstLYmq5AoR5dzlMXrEZkEhCnzO9NBcNiMGyhKNFqIq4Bh8hF/gAzT?=
 =?us-ascii?Q?6UMKHpmmocCbyue3llvnyG+YMpSWLBbwXRCEIsfNew26HJuGWMazsg4UcdtW?=
 =?us-ascii?Q?5pBtzH3/TLs+bN5ugWRsJL+hjXS4A2RyMjd80qr20R7bFoG5qDapJ1k88YMk?=
 =?us-ascii?Q?u8TNoATOmpBpduzan62Nii9DClbSreUtHRqrLPr6cxKyUxTuoCurDCqk8vm+?=
 =?us-ascii?Q?75A6fP5EoQ0csNoEZ0S06meeETRYirV1c9XhOCyM2g4S383lvQlmcY6FttWi?=
 =?us-ascii?Q?mUuIZlcU2i5uM8O0lFM7KFdJH1QLFMa3tvXlT8d5kTp4xCbTz02T0xOca3uU?=
 =?us-ascii?Q?xyDkw/I5AAKdWyvlvjkknYaqHDxLZPxGcU3OZc4KaZX7l4MtkXPt6RWjH4HF?=
 =?us-ascii?Q?MKBkWSPTr6ImC2HSByOEHaE7pnb+vMfM4NLnifFYKD1RO75uYipBFanB1KGh?=
 =?us-ascii?Q?+QWx4mPSPTOvn75sHMwmgkqJyZRzBaVzohZOgluBw3htwGlAi42e4BReLgIK?=
 =?us-ascii?Q?jlxsBNg8QPZAWzOmaVKgUla+pZQqDe/ybSjYy8ic/oMu5+DvtxI5wJDTTzKh?=
 =?us-ascii?Q?c6KlgbBtDfser3oPiW0po1iNL0d3MSw6oUHJq43bsDVIvk6I3ZP2VIvzCZl3?=
 =?us-ascii?Q?60L/lwGJoNMNUVRlkUQon0r/hZhtD0h4CT2gd0qIpG2bnuzZqCZF2YusEIJZ?=
 =?us-ascii?Q?Q+yl9zxsGEZwmDeDijAtW1CJITRRd7eqEMiiul9gDW8mz5UvscfRQVNH3ccs?=
 =?us-ascii?Q?JCy7jTq1UOry2scLt3D/1ncdc9q69EvjmhvJKwW79vIS6QxQW1DJK4EGMLdI?=
 =?us-ascii?Q?VCR2F4Pf1+dNv0CnBrP0GFUQP+xRMqx6yvZ2mlEqUnvP1WAhZRRE2PUfnSfI?=
 =?us-ascii?Q?4SiDsSH1qDxKx2mD0CRLz/vYgxIYL2UzlqIPOGdD1c2DdBKrMG4XdIPaiM8o?=
 =?us-ascii?Q?Um6+7g6mJ11pntt5+rNwKxeC1nDrnUdpXPoydZ8JIe/ntNIo1RDQVIFhI6hn?=
 =?us-ascii?Q?iH7pD8I9wvXp99U1PqgUSSgr/idilhynt88PEVxHmlyDoj59E+jao7kIUc/V?=
 =?us-ascii?Q?dOqvNovSy9lN7DHoVyd1Gkt6B5/4nHCA25NtDphT+TrLPegqY76ws9uBhWhL?=
 =?us-ascii?Q?oSuxmcbpWp21m+h617Oox2HKKlx3JLE8uFuYk7DJvw/g1uqMGWd/YG5IRJGg?=
 =?us-ascii?Q?+nC2Itf4TjLRvVpg59Dl+7icSchPzqXMy8DS5FWq70eANj0o6yt5NG9appmA?=
 =?us-ascii?Q?d6vutntTaodsCyXs58weZEdjQyIXvF4qNTv7Ebot3Db0MXv4gloYarTKv3aN?=
 =?us-ascii?Q?NHD58PQq80sI+apJjixyn1tGIBiJtqtGIPul8Dl4g1b2aNcEHeMWm2Vy4NIL?=
 =?us-ascii?Q?5Uyw6CPV8PPRPclN4nBWCAQIqJTWXumExgcrZQQvg7HFhfE7XCwtbSYPF2aq?=
 =?us-ascii?Q?QGvCqVGopwxQVIo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 05:07:12.8257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ae347e-726f-49a4-d694-08dd53c7eeff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

From: Ashish Kalra <ashish.kalra@amd.com>

For PCIe devices which don't have PCI_CAP_ID_PCIX, this change in
pci_save_pcix_state() causes pci_save_state() to return -ENOMEM error
and causes e1000e driver probe to fail as follows:
..
[   15.891676] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   15.921816] e1000e 0000:21:00.0: probe with driver e1000e failed with error -12
...

Fixes: 7d90d8d2bb1b ("PCI: Avoid pointless capability searches")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ccd029339079..685463ea392b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1743,14 +1743,14 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u8 pos;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
-	if (!save_state)
-		return -ENOMEM;
-
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (!pos)
 		return 0;
 
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
+	if (!save_state)
+		return -ENOMEM;
+
 	pci_read_config_word(dev, pos + PCI_X_CMD,
 			     (u16 *)save_state->cap.data);
 
-- 
2.34.1


