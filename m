Return-Path: <linux-pci+bounces-35247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F1B3DE44
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684B917A9AD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A230EF66;
	Mon,  1 Sep 2025 09:21:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023102.outbound.protection.outlook.com [40.107.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5930E836;
	Mon,  1 Sep 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718475; cv=fail; b=L6JlxvmHejQG8PtdGjen/fzZIIxeh9SEppmEP6sFzEdsiyNVjYM8tl7/Tzx9Ygper+oYbX4b4kGqJzi6OklDOyybc8L7B/U+d9sl3GZRF8ldG0QZpoGiJToGNi+MDgGZPpVF3/Sh6YbtvOj/aB9iGUBHpwS4TN/i9SWcuIyQbsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718475; c=relaxed/simple;
	bh=xB7s/L11s8XafWLm3UDOCd4o5qOzY6amgd4eu1x2OSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruXEHJ4a9dm9pPqmfwZkWbzawlIMyj9nfTzx7/94/3ZAc/280940f4wvKekK5YOWEnh8GFjZuLbtO21ZM+uqX2rVw83lb5bQtQottjQRrJAoj8gj+wIvAr/1VbrAtu2raw9EKauTboIEhxiiRvXkuVpb1Zmy+CgeaIj+hATqkBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJYTYyIhWjfvA9Pkb6w7HcCdFfU3w5FsbeO38+HxC45clJrxOa+HEsKEwXFhOPchXl+/uQcvOcVMQ8NeqkorM4sJ8YveGSRc2/s5k+g+oqowhEmsxXnUPcuotxYAyzhN5p0UxQV4sfLuBgZ9ixF6getosNpbMw9/7RLXdCapEJBKLwBF4/aJSOsgo7nvIVB+I73gYwnm9xrfBrh4Ekh+DvdZMmdTP0lfqD1Soj4CMrgbXXDH1GpucrvVAKVeHy/vI3me1xDCQ9pTns6D1csRSgwf7U4XZKN1YGbHDCRe8Fw/sugVpxmYke2i+szOY7t6eyPlq8rwkNAQt50J9kCjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1Q++zcAAE1nO+mh6fN6kkVO0qzaDUud0SsrxRUwW9w=;
 b=PxSmsuqqmcwxiumC8m0mECJCsIGX54PbCVQj7MZ4Kbz1XoIsERwmD2vwmTgpaX03FjYBeRTHIJxycqSuQe2ZeQLdOevXVAPSyTLS9pUDdUGW2sv6RODuEJ9yDyWYjEe+6gavlpo3+PoGpDBgQ2JzO66lFthM0/CPYY2fHvp/6GOabZFdBr11vRPpDRgajGcpNJcQav+nXnhaT/blUog6Mr6HJtjV7yjMevTaq4zy3YdVmjEUtu5cOOU2TBKSPEK+uZC3xZCmUQe6/l28iazfuuBZTkc8bQWYpS+zPMy/T2rnhu6Sq1iBR+CFa1QGVuNEjC/K3dsUBdEOCxFqZTdYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0032.apcprd02.prod.outlook.com (2603:1096:4:195::12)
 by SI2PR06MB5313.apcprd06.prod.outlook.com (2603:1096:4:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 09:21:09 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::22) by SI2PR02CA0032.outlook.office365.com
 (2603:1096:4:195::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 43CDB41604E2;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v9 08/14] PCI: cadence: Update PCIe platform to use register offsets passed
Date: Mon,  1 Sep 2025 17:20:46 +0800
Message-ID: <20250901092052.4051018-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|SI2PR06MB5313:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 132fe30b-d9d9-4ac0-6a8f-08dde938e2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1fMDpKnbRV0rfVfUEONhHhNHv39Lno/vNTpuhD/Kv/UQv3Ox7MPCvbOA9hR?=
 =?us-ascii?Q?CA3WU1zVTMFpvF5YOHLtNAIjCuw9uqTXlvDlYsiX4vJ+LvSXTEU7QlOB0b9c?=
 =?us-ascii?Q?4Fro3WmrHMkD5gre6MIVxEAs9214KLY9j1JzVOgcR6Fvvh/GcbjiLBCkbiQ4?=
 =?us-ascii?Q?uClzomqITpBq4qqkT3L+3eOJ9ba7tIGR2HyNzWSmKd+MNYCyvG7KmWebT35+?=
 =?us-ascii?Q?Pf2aN1elBL5pD1XvPe0+PD8vuRtpxXi4M7o8zJl/eeYsmzaVY4etZ+hXLwlZ?=
 =?us-ascii?Q?o9YYG/r+JB4dxPDrNUNqs4RCXr5tMbj28vevR7rcVVv9TQCbsYqnSQn6TkUb?=
 =?us-ascii?Q?BlMbiMaKb7JkdXz0WwNV1nJe7qPmlp1XojR0FtbXoDVBgsgcUBZuR8K+Lske?=
 =?us-ascii?Q?Wq84btaZaWapfLePUtjHVBEIOqFFAh2g1gWO9DnGvRjFLSFjETvtv066sa4e?=
 =?us-ascii?Q?irG3m9lIrqo2h+KOGGpWl/F75PQ/ZQQqLtu0Z426JBE9epHJvDo4GS6fzl/Y?=
 =?us-ascii?Q?4s38Ahnt40KsmG+aIEhbsuMBBV3kXmpsSYM7CVp3xLQxDCaKN2r2DeLcD3VD?=
 =?us-ascii?Q?wlVnjA4GA1pjG7/U2Sz0WSGCy/3JSORAC1m2BvoAWU/aE/kTlfDJzf9BkCpP?=
 =?us-ascii?Q?hwYCrMmlmoe45ZHAzuLcYlemkBWWD7N6XRAa2piYvK8IwO2/rvD5kkA4JWrq?=
 =?us-ascii?Q?q//m1p1K/mm4w4Xxn5z8fD/84/VqT0v/ApFrGzsOMt4fnIsuCghQpHtgqTJq?=
 =?us-ascii?Q?p8TzvSQ7wENiI89Nwj4hHa2A95vOR2GLPIhFKlbTmLYjfxxQRbuBZHoSAh2g?=
 =?us-ascii?Q?nTtguBEe4zJuzDDg4k0eEqlzmKyJ4YVsxK4o7so8NK742jssoSD1QB/lAqvR?=
 =?us-ascii?Q?PgUqjsEzm4DxAOrHaW98NXiOJN7jyQim6p2TNIgfVr8+wqM3IYq7ItulJaV2?=
 =?us-ascii?Q?MBK0F3c8oHO5SYTFNhpvMX+aUi4jdX7EbWZSEUUNXrJD16XHZa0L9NPT5mVZ?=
 =?us-ascii?Q?naiXOtU1F+GrGS/apb2/wff50QKWsE+cxtOZJl5bGrm5F4O+5zGuSxtuW+Lu?=
 =?us-ascii?Q?sca9pCoCIRqhH8NEr8Qw39kPhxOH5DmpU/HIHCWWn2Nj4/FKkOQpE5SyhkFT?=
 =?us-ascii?Q?VEZzoIDjw352uJ3T+aHJpQ+YNiLktlK/xP7hFXgE79Ijt4cNytrZAeRVgHIv?=
 =?us-ascii?Q?CW7oPDsH7ZHqhyCqscMuzneMbg6IAnvufEeEMT1D6633DvykDhm/jNxnuXpL?=
 =?us-ascii?Q?CFE67sIJmcNYiLQhS96mUtxeUIHpaYskG9q/FLOOlr1wkM5QPHzEvraioZ12?=
 =?us-ascii?Q?wwlhX/D04fcHKASV7HrbqbOFvjP/Lgrlz9gGyanoI511gWt57p5s6zfdFJ+Z?=
 =?us-ascii?Q?nS8i7+LI9brWrGC5r4nC+jQSIIRPN2sxYmwZD1gOXjs02yWklZrkoDOYQMg7?=
 =?us-ascii?Q?G0IQtHty3nL9l+/7KBq3XKhcBlE02w5UG5Jn1GC53O+2pDYT0ET13H2t1h/0?=
 =?us-ascii?Q?ZDJJry8X14lONLxZzCix3rSVzD96c8TenObd?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:08.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132fe30b-d9d9-4ac0-6a8f-08dde938e2a6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5313

From: Manikandan K Pillai <mpillai@cadence.com>

Update the PCIe Cadence platform to use register offsets that
are passed during probe of the platform.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..927ab5b8477c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -31,6 +31,7 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
 
 static const struct cdns_pcie_ops cdns_plat_ops = {
 	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
+	.link_up = cdns_pcie_linkup,
 };
 
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
@@ -68,6 +69,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offsets pointer */
+		rc->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &rc->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -95,6 +101,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offset pointer */
+		ep->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &ep->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
-- 
2.49.0


