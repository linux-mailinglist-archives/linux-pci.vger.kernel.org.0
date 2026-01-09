Return-Path: <linux-pci+bounces-44307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8029D06960
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 01:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B25A3020496
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF8500945;
	Fri,  9 Jan 2026 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ad0mEclB"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37A249EB;
	Fri,  9 Jan 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916961; cv=fail; b=eo5x1NJSwtJMUuPxwxh5OymGat58Fbi0jf2MzjgBeprhP/Petg1z4BH8qLxvD0P3EcUBmis6sJT+bhI60i0/n2pFPRRJ2oFfWIe9jqKpdCATa+8kPprHHyZ1l1W7d+xDo97uQqN/lUm3L6RNvvVPkQknC79c/JJnPUS5TVWcNTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916961; c=relaxed/simple;
	bh=4sGDsNAy6pg6R6BBWzwS+X853YN1pBWYW4RgyoYzegc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=USWqU66D36sgwUQlJENyhjPuDLIOSFxrmFIWGabeV7NwuR+wI5u/54lpgOmsSykHmMecxV7W5EP0cM30p4UgmyubY1lU9PbCuDqj/hWcj5JqMtAQznLllsbF5iNCGojCJWdDDKLWH838nKQzKaHf2wbUd/IL+DT506MlInsgWhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ad0mEclB; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfqu60xg85Tgi9HEtCNUmXDlhCRCNbt/HdqSga7wadCHkYpdxJtFy+SMp034XGaWhgjbk1wyF7HBDTHXWIFupatyXBKRbT22E8d1EmUp4U9peNXdpl/JvN0K+x3GhpfRwNOdROPQ0rxKASB1aIvJ2syNY/n/DMx4GO2+V7oIf1rUCNXujMpXA+tK1K5nSfgueeqLc9/ikdkfszI3sql9VjkNYP+4zjwWpZQovopeN0zoiAFVOcXGn/nephJDvIKy18pqukfO0zXY9bQP3cB5VItPVdvluIdihvBsntwBXghbjYbTYloT1i5OkIkqO7jPjSuG+jUujcbUgcoauS4chQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os83DcOkhiFkzSlqj0SszI2EiTYWcWD0At6oasiSN4o=;
 b=MvXUMrTLgfKpxRYt358zlQFQSc4qnOOTn3qCGJJOf3LjdYo4KCtpEzGMA42Kk/Nt0maqO0XgJi6m2LuIusXxkc5HaMAkKLN4M76YiueZIZPnf9W5frNrDI5wXJ8SQxATrN/fP4nGfY6yQ7vT6/7S2ghrjnYel3rRHBCK+I12ELgY5s5jhFMzt/FRAnul6hE69bxqpbQ7Q7CHvalnEC+t+G7OEA9A8o6wWb0foTGOXh+aP4lkujYUbF6ETbHaPPxWnpvw4BJevnVlgTvYNAl7fPA4EYq7cAlD9DgPx81YjFATjG9YUmHLrmdiEVfCWvtlacr/LGpXNXnRMkOFqd2Qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os83DcOkhiFkzSlqj0SszI2EiTYWcWD0At6oasiSN4o=;
 b=Ad0mEclBLk6Q3XFk7GiwwiHwXTjHmqqRCvhVDv5iiZeUGv19iJBbTvGzXJyX1g9E8lvI5fBsLpMNHSdVk7RdbDipcUsVLwdd0r3pgj/mHUd8XCKW4pg2oJ7qKY1qUyerCyGJZTuXIb4qw5xHnsDIxH/iKFPqgbNIpBvfwLWFBSIW2RQVCwQm35YBbJgHSLCJRm1fFQR6OhB5fZgFnaWxg2dwx14qPoCC8pniBdBr/B/0nP5RcRgVTEEdwluMSfIT/sNbpN1O488unweqzhtMsX5DjrbEZEvCeS4o0G6Gx3hBOuh9lzhJSHeb2XaScX9RH7UGPlm0FtGIzVvoNynIDg==
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 00:02:34 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::d7) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Fri, 9
 Jan 2026 00:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 00:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 16:02:20 -0800
Received: from meforce.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 16:02:19 -0800
From: Alex Williamson <alex.williamson@nvidia.com>
To: <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex@shazbot.org>, Patrick Bianchi
	<patrick.w.bianchi@gmail.com>
Subject: [PATCH] PCI: Disable bus reset for ASM1164 SATA controller
Date: Thu, 8 Jan 2026 17:02:08 -0700
Message-ID: <20260109000211.398300-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c95ec8-d0de-4752-b621-08de4f12646c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8OImGiPY7ygfqMZksh8I/JsnfjifW2ul0yeKj15Eb/lJzyxCtHiCjxs1hR/s?=
 =?us-ascii?Q?HPEiqEXUb8byeIMUyf+7KAhnMNgRmOmTfAb/SN0wxWa6b8nBfaR+cPL/ZBLm?=
 =?us-ascii?Q?7IZaS7yjYi0Q5K3Bjs2vWnZjgX6jUr6chklwwqqz8JquMwEH8TAoFEhqcUI5?=
 =?us-ascii?Q?3RnuLW9FcplwofF1OCPLo6kZJW5tuXruA6aRZAjAbkjzat7qbDoMUHtW/uM8?=
 =?us-ascii?Q?XazSOmGfBbZ+D1+ZDqyinHhsnvPNOJNqbUYzkFei2TgTfI4XLcr+rtXaqfrI?=
 =?us-ascii?Q?U0eSRKrqsvBd2i01GnFjq8qQWEJytq2v1HaBlXhYi83o34u56ZLvSmUwgZgJ?=
 =?us-ascii?Q?fVeADuSbBCItvz2CjjLLlGV/GNkGXQlmLI6j3ViDkOlcU8pNGE9OVFhR1z+/?=
 =?us-ascii?Q?YbPFx1GCA+YfH0xu1J0TxK6XM7+Pyn7UKAgZBBcqcNUJYtsard7px1kDmtmo?=
 =?us-ascii?Q?H4o8L0NvSEjlr68ThFTtooIdPQLP9An9UknHag1hEpImdVUxIa+s94G+O7GQ?=
 =?us-ascii?Q?/pgrTPWABZC6RkoMTDsRtkWhCz8ngiFfG1hgGd/xD4FKXhmhSUdS0hMuQI5S?=
 =?us-ascii?Q?bIy0RykNossnJDFUwpf5ISUzKkCW5xutql7e568KmmcEHGHugkLuBxj7+z8I?=
 =?us-ascii?Q?xFsAciUkq+i4sJ/e1Prpd+89deEVT+UfnEFNOfrGGK7Zp1HNn6bbcrHwI7jK?=
 =?us-ascii?Q?/Jlc/HmEMMg5daG49lTnYMRtmmk9jVvC87biM7qrHGeLNwAkHx2h+8N0mLde?=
 =?us-ascii?Q?4x23wbimSlzVea4wxG6H8FKNu3MuUmRcKpz8gX4PSI5H2lSchtA/HTGaAL8w?=
 =?us-ascii?Q?6eE5XC4BDKaKl45zPFypVGUQmragtzprKxhLEDR9+rqXWPUMw2wZ4MJQ9L9e?=
 =?us-ascii?Q?pyzerpXmn7DU6gbBV7M6wD7uZRCyWg/PP1cczHyotgRkMtTX0XgO+MmdtlvP?=
 =?us-ascii?Q?HsvOxMyIWDmuvETqxfBr6jD78GEa30U8WzIsqXE6bjYDPstd1EzMGa/48fSG?=
 =?us-ascii?Q?99jDY1k/vrGI3JNFtZa6e2gk3+o2jo2mfA2RyyGkb2qs0JrOJZurEvLdkRe8?=
 =?us-ascii?Q?Tv+GcQ4EMzO/WNowYFM+UgnByA9clFt6WHDs/ymAX6J+xTk4sgt0Wef/lx7V?=
 =?us-ascii?Q?UgTA8rjSB+7BoHRGAmrAAZPGracnBA7R904dKeYH7FMbO8w+qFYulV4bKCRJ?=
 =?us-ascii?Q?PU0YxGdWgv9XIV2j7/d1aQohGCrqoxcDdb9IdSPh/lpZGPTcBDuX+RVfxwGn?=
 =?us-ascii?Q?5E1cE02exMrf2HjvMfk1Z4L/0lDZuT1TyDS+Qz75XLOXgw5nWzXknsvpIWvz?=
 =?us-ascii?Q?8VBf4o7AaJ5SEr4k2+hb+sONR86ZGfrRYfRY9KaENOyz2JLAO0LvI/A3H4bU?=
 =?us-ascii?Q?QmYgDf59sYFO1BsAkpsYwSMZRFiEoCeU4mm6W+oY3L9m57s6prUHhxtBu00W?=
 =?us-ascii?Q?OlOkjuVbXruJB2ES2Ej2oTAJYmvgAEoYFAsj9eURQk0Q9F0VKaNTWlzwGt1D?=
 =?us-ascii?Q?aLT85xrsiKe5BwI6HJzw19S6oJT3BoktcO9CeVa5pl2iwK6M3wwlTu2zFOGM?=
 =?us-ascii?Q?Kbn33trkVTbGgbshgYg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 00:02:34.5492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c95ec8-d0de-4752-b621-08de4f12646c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

User forums report issues when assigning ASM1164 SATA controllers to
VMs, especially in configurations with multiple controllers.  Logs
show the device fails to retrain after bus reset.  Reports suggest
this is an issue across multiple platforms.  The device indicates
support for PM reset, therefore the device still has a viable function
level reset mechanism.  The reporting user confirms the device is well
behaved in this use case with bus reset disabled.

Reported-by: Patrick Bianchi <patrick.w.bianchi@gmail.com>
Link: https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..3a8d5622ee2b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3791,6 +3791,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
 
+/*
+ * Reports from users making use of PCI device assignment with ASM1164
+ * controllers indicate an issue with bus reset where the device fails to
+ * retrain.  The issue appears more common in configurations with multiple
+ * controllers.  The device does indicate PM reset support (NoSoftRst-),
+ * therefore this still leaves a viable reset method.
+ * https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.51.0


