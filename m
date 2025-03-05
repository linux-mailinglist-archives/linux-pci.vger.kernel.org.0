Return-Path: <linux-pci+bounces-22946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BFA4F722
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74EA16D00B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDD1C5F27;
	Wed,  5 Mar 2025 06:30:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2106.outbound.protection.outlook.com [40.107.215.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546914658D;
	Wed,  5 Mar 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156248; cv=fail; b=tN+56REgvdy+qUgTjTojBqWaqaKANAwAgwBozJq9yLD85/dhO8yczjlsy4HaH5v3F0zUvGDEmMd1vG3g9ifHvnjhlCnodUUUCjSQlV9TG/HmsUoLpQGuFuZg74G0F4PT4Y5gYrnKGDHVDLL89bCcyxsNDcpwq2KB0jtWtqmlsTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156248; c=relaxed/simple;
	bh=VHgNUpmwTvDXRVCga0z4pHwTj63VSA2PJ4J2iPR5SGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIUpLcNrj9kBIGK0TpYxZD2u3pVHtCebuKCABJrGwLi9zN8rRAnqcaNyER9rYSHJFqXTByxBST314PcugtxehE9d7KyjSoWW4EC4QSnS8Jc7ia1UT4x1QM3LVQudqx0tRheFTV8m0LO1ga7R1WSs+FiPKctJ7fSfxlCJZScQS6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKDVndpmIcgmPQ8JKkPgn/zDUQnEUQfp2mBoAlPcdqHexz9fR/2jVTDp076VXXftyDnSaiiSi9ooe1G9AHJeHfzKQfxVg04DZ+lgXw3DvQUn/eO8ghJ8UuQIEhqf/scOBdcMM5/uBtfpfQekz2DI4qvgjgxboWgM+6p4yv5sDUFqSFTu/OGQSSBDAWA+M+B4hB/LdrvVGZSpocoLB1XmIuBumkUrLXfWBuNFuz47W3CkMfoN7/9gZWcx2DCjDaTkMs4Esbap0ONN/oajTilK8jhxW6OElnQLHwq01HrbDovPZtAdBimWM6vs8mgd3cna8C5CLmJH5lurjhYSXkCoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAVtwSnJ3+bGv7jaDOM8eND+FihcdEOwzGvPWg7tJwY=;
 b=Qx1JP6OB3HnWIuf5w9+g5bIslnIvm7KdF0s6MobvamI7rWcu4maUzMeaVHY4rn4J4IkoFnhA2LSTgRnAf0OXF5aU3/c5r6xLVi/hzIiLdnz5aOMtfeIwihwFcALyifu1+h+OhHu4rjrtqFNfoLd5h2/73mOQdwQjqLz98f6YCzEsRiiW5+LhITTHhHIcH7B63NwxdbmXnRcFApEEEgebvXLAGqnH/b2FJyb94vhhEYRZ1jXwUjbIto3Vt34z/HrlnUSekNbfC1f5gtB4kRXALyegJBsVV0pspOsdqXEQRFG1k6lCqqasPMSX/g7TwKU9fj1qMoSxKEmz1nqZ4JADlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0025.apcprd02.prod.outlook.com (2603:1096:4:1f4::13)
 by SEYPR06MB5232.apcprd06.prod.outlook.com (2603:1096:101:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 06:30:38 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::6a) by SI1PR02CA0025.outlook.office365.com
 (2603:1096:4:1f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 06:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 06:30:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9EAF94160CA1;
	Wed,  5 Mar 2025 14:30:36 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com
Cc: cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125 2.5GbE Controller
Date: Wed,  5 Mar 2025 14:30:35 +0800
Message-ID: <20250305063035.415717-1-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|SEYPR06MB5232:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c158a18-124c-41fb-a631-08dd5baf3e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIXBABUZgm4CwyUe0K6G0aEXeV7qxf/O/YUbbwA+dm2DlrwgNVww24Z8bEBF?=
 =?us-ascii?Q?LnFOpM8qFGW6bYU9AGHK96Dr/1s9NloUHZX+Rj+SWLb1hUY+yc2ugLTBDs6p?=
 =?us-ascii?Q?Ny/dU5ZmmGCiaLqiX1mDTYACAPPSW5DzYFBRW5GsIJr6qbIN8iYFhLi91dcl?=
 =?us-ascii?Q?AmRgSIjSA5hDp7OIQ9c/Gzo+kpgkAQCIFf2mMERxOehdSlV9fh19ZXCH2Y25?=
 =?us-ascii?Q?R/hYdESZM8L5DcjWSqec3X4zXw+iudUSZ+IfepEzT64/wPSTuAW42QKI/YNg?=
 =?us-ascii?Q?wfw8/jkdV3D5tR9tQxlru5mTmI4FcxOIPBpNoYcuj4iNgINfPqBDt/B10hnB?=
 =?us-ascii?Q?oCfG3vCjsit5KeDBDC0Vben6IOg0d1wdiuBu6bQhrg8d0r6J4muLBl6Cmmvz?=
 =?us-ascii?Q?ifohKwDkzk2LJbVg5oPb9bbuRM7HwpZiM3DE/R24AWdtwsrM2Xdzld3T3Ekw?=
 =?us-ascii?Q?BsfIqferH3uWFw8Y9/p/5esMgI9ke0W+4jteD9Wr0R9jkAoJILK2l0iXD7uS?=
 =?us-ascii?Q?wmeFmD6Qzb3XlhxIGByyUckRUEdffU33tAgbBl9jQ9rK0+qiE+oF5M+zK4R4?=
 =?us-ascii?Q?AUdheTae3S9Yy/ylrFTgorHcffrNYZaXFMGN/rPuNe8N5F4D7Juw9NLtZJ+9?=
 =?us-ascii?Q?vVe2jTFYNi4jsTuc4FKLf8RHc/+HnJoj+Nh2/z+Q80d53o1p0+tL0YSnomX/?=
 =?us-ascii?Q?ShXBM8hTbzuozlzbgFyKM2tVAYwDMdJe1JC1hWQuHuCp/CWjHBuJLSPIwGrr?=
 =?us-ascii?Q?3QmTHp+gbi/02ktMUlvhODI7aNd9stwqrgQ5Rotb9QeXoE5UuFpevVbt0VWf?=
 =?us-ascii?Q?doH+2CZ0/flvucaCjDX9NXzVEpS7jb26JpPzcH2/3oysNCrXK6kFC1j5m/z9?=
 =?us-ascii?Q?Tnu6motssxQiWTw+cuCBoNhBMRKXjITqB3yd97jzSFOX6qkWuOV1HuKMKujn?=
 =?us-ascii?Q?g09KEQlKgaE10iM8CFT4TMdwH3U45d1B/Z3CNZEO+yjHko/J8e/y+6YJNv9i?=
 =?us-ascii?Q?8me7cYDNbdtvLS5nGddk+oWmK/N4/7AL2VJ/eUMI9pKxTWgkTmhvlR3KyQN+?=
 =?us-ascii?Q?pNbR2sM+EA2X+zkNufvGvCsRKVfuy/uwIcFk9fcTojNJ23sTS63z1+zPDvs/?=
 =?us-ascii?Q?NmQZ6QTJxJOEoCum+i6C6hUWvMPhlrjPJuOfamP+Vn5Wqi/Ov8I1pCnWz7sj?=
 =?us-ascii?Q?4DjQweTiK2zfhbNZ7dpfeoWOKPPYRA0beW+zuyflaJFejsMLnJ0vZwDprVNX?=
 =?us-ascii?Q?gVaWytt3Tig+RCXfacIqevJSfpNOzajnDcv4ueA1+EirC3SED/Q47KcZ05va?=
 =?us-ascii?Q?6cQpbVBoQ474To+qfa9OUS716CtIMHhsM4MyOJ2wgFKoSMuXl5XxKcKqkiqe?=
 =?us-ascii?Q?dRW5KDSw33f1NuzmhR1votO9eEg2mEnYKxCUo8acDalDl7fn3KW6Rl+qxRSg?=
 =?us-ascii?Q?xbZ9fAdO2BQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:30:37.5242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c158a18-124c-41fb-a631-08dd5baf3e35
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5232

From: Hans Zhang <hans.zhang@cixtech.com>

This patch is intended to disable L0s ASPM link state for RTL8125 2.5GbE
Controller due to the fact that it is possible to corrupt TX data when
coming back out of L0s on some systems. This quirk uses the ASPM api to
prevent the ASPM subsystem from re-enabling the L0s state.

And it causes the following AER errors:
  pcieport 0003:30:00.0: AER: Multiple Corrected error received: 0003:31:00.0
  pcieport 0003:30:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
  pcieport 0003:30:00.0:   device [1f6c:0001] error status/mask=00001000/0000e000
  pcieport 0003:30:00.0:    [12] Timeout
  r8125 0003:31:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
  r8125 0003:31:00.0:   device [10ec:8125] error status/mask=00001000/0000e000
  r8125 0003:31:00.0:    [12] Timeout
  r8125 0003:31:00.0: AER:   Error of this Agent is reported first

And the RTL8125 website does not say that it supports L0s. It only supports
L1 and L1ss.

RTL8125 website: https://www.realtek.com/Product/Index?id=3962

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
---
 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..5f69bb5ee3ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2514,6 +2514,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
+/*
+ * The RTL8125 may experience data corruption issues when transitioning out
+ * of L0S. To prevent this we need to disable L0S on the PCIe link.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8125, quirk_disable_aspm_l0s);
+
 static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
 {
 	pci_info(dev, "Disabling ASPM L0s/L1\n");

base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
-- 
2.47.1


