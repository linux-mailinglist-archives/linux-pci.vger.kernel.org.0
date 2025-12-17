Return-Path: <linux-pci+bounces-43208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A809CCC8B9D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20CA6300F334
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF32E06D2;
	Wed, 17 Dec 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nlLOKY/k"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81D2E06EF;
	Wed, 17 Dec 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988296; cv=fail; b=F7jwVVbxoOFXG5wCdtTNxTSNZQ4BlRG2H+up6otrwgroX0qKHqkXknmqRO3PR2zvCSzs4bGEeJkiooIhm+4UcfDJCXq1yjFZYdzekowagR5YQOX8GXrF1/GrOZJ6lwVq9obV3/8W3MiF7dmsSEBZBGKDOn/8V+nvr8BL7rmx8bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988296; c=relaxed/simple;
	bh=K7khJ0+pTmSQLC3k5PLz/kMdEQcC8hmGYRHUX18AVZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRyiBwWtAC3Yknp2DpXr71WC3RxjTmDrqZaTAMZm4PmEd+QPPi7zhGcblNEIo2cdERiGeT8oYLUv/1Os9hg6t/cyW21lEAMzwXB8XwLGnSkEbhCMgPHy+SKrJNwJPm8BIuqVqz8TZepTniUOChNGzoGmUiBWVd2U7o32nugQCcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nlLOKY/k; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf88GNzRwdbatFL69K2i5tNCDxEata5lorFhNCm+hDE/8KNA2J6E9QPsgNtRNY+7mijh7wjisH3zFtOCM8N2PXoL1fZoFotTfCLo54vIzt1QURaUed4Kfr09GK0ZwmNkrBIzLsqAFOCCgvtxaXJEkAIsvzqtFopzvKrEFSEsY2SS7smUS1ldiVSC6RkskJ4SyyhfOj1sxomeCpRzn3LHYXN280I67oUhud915GEWxHC4+XbnCOOpbmVTgGprZnCfIS0u4DhKfTt4ZkF+rUN1ReFtE9mCon0Jm0ctqHY2NXr1ZWTr0begvZdSwVAInBAhsGK2A8DAnERfwVZ+Ouriyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnYRsVjpLkhfGL9WlxfvWCGgIXUeeYERhuNhrP2x2ok=;
 b=fEQPvqYZ6dIWMHZM9H1/4cqXdSKlNVSH5lStHV0XYzQJ47INP6L4UbcZIO17DvL7mv7ZzsM8MCsB7TnVXWpJcv2X6qEqzRnFbPknQgBdOb5U7XMUMjztrW74U1fd0O6ZGmGax14XW6pf3MDYUXKybLf5IwNW/g2pLV0bEpHotyPepK7wq4y+R38aHwezSMKd0zleomjIoNihAfMP1P1XZHf9ZoM5JaQvW2C9P8y3cAQHyg/L1zlBlaZCSr/i1JjKWx0YxVZRqp1zFLCt46CPa1XXz9fqud7XkaUlfM4J8XREFGclaQ9YmCihEuQEmXVkJfOU6Y1qom7O7wknhRSkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnYRsVjpLkhfGL9WlxfvWCGgIXUeeYERhuNhrP2x2ok=;
 b=nlLOKY/kf3/kiKbnzhcEYwdoJcaZnK/Tt9ZNRqjIrVFfPLz3/Yu36A12yPepVGIIT2RjNU5imXp0cGxkXd62+z4HFReJf2DlPQGkHfDQ0lfehzZeHfUJC+crtGjGGYOiI1Um1qituNc2s41sVhVlJmZid0PcqWVPp+eNvgs7M2OvlEm1IK/tG6scy2CkKW8ajPDVYGkzwYt9u5WiR6+M7N6phWKVd6FeXOqi5RGUzY/6yyuTiB6/595eUNnyMCUtZaSrbwf3HCiJadCm6d5glKc7eT+l6Ud7U58oLdSDZEFgBtyhVtnuARU1l+111VYFW0IaakIPga6p9pmzxoATmg==
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 15:46:07 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:4:ae:cafe::ce) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 15:46:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 07:45:44 -0800
Received: from 82875d6-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 17 Dec 2025 07:45:44 -0800
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<jammy_huang@aspeedtech.com>, <mochs@nvidia.com>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [PATCH v2 1/2] PCI: Add ASPEED vendor ID to pci_ids.h
Date: Wed, 17 Dec 2025 07:45:28 -0800
Message-ID: <20251217154529.377586-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 05480c4f-b823-4df3-d2c3-08de3d8364b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?zTGEAuChr985toQ0SB4YOy/7MBwAsbZTqoxYRxPRDzwta53NWX7DVjlA/m3M?=
 =?us-ascii?Q?RB022/1+YEZ9DXnjoMwEpbRticvK1q8MalBdewycFMNtPziS3fpYYiypNhnl?=
 =?us-ascii?Q?7YErUPGY2X2Drlt1reS2fCDngyL3PeFotYJ1RKk0iwvFD7V8YhgNl6wg2/fH?=
 =?us-ascii?Q?1jXnGlW36gcuO/nXwt0PI7rDgrHlJN12C0ewMqtk9FIHWJ6AXb+orIGlUkXO?=
 =?us-ascii?Q?XX1mtUVI2KSinD2XLajDLTR5+4Y6mPMATXOn0+afxGxHEUEmAfyP/GXvOXfU?=
 =?us-ascii?Q?GCf8P/6sDGHMU/z28L8ds9k6pPvVpMyJDLVjInQXbPfCrp2HPeeD4cHSHqM7?=
 =?us-ascii?Q?jF10A5jGwo5ZDzhvUUYm1Hvh1j2OiWMgu3SZsX1IGLwDAhM5H5HT32U6PvKV?=
 =?us-ascii?Q?A28TDDXAOmuhT6gps3AG6I8FbAaFQlkZjZeHZ5X/5LYupdSjE/jPahL50KTv?=
 =?us-ascii?Q?M3n7yuF5N36tz6lvt1Nqeij0SSy2tp3u9fxngstXVwttRa72SjjH0GcwjmmO?=
 =?us-ascii?Q?agUeIXXEFpppS0MUs4En+sszZb1rew49wG4UVeeFBPlLo6FdEi9LINN0zaUu?=
 =?us-ascii?Q?2F4IEh5AOoeIYA6MLbyjLa3Yzofp4zdseksaX4yRa1Cvd/8XCYpYRzxsFYWx?=
 =?us-ascii?Q?5UXnfWoszn5ENLW0LXInusPMdF4o7Rch5R1TX6xE1JOHEJZYodQ9Nipr0a9k?=
 =?us-ascii?Q?BftaKQApXzXZF+I5JZa5oK5T9PezWzTmb4kLb3jVrXauJnUJ5QU8iiIzB7OP?=
 =?us-ascii?Q?V1Hz5QtiMojik1CNVjySrQsbTjpJrhI9wbGWOyJhtLo0lex+3evadOYF6Ztx?=
 =?us-ascii?Q?NduknwlP8COoLy6dUcgnGjcrcyD4HkBi+JER7tCIM9Mj0eF1+3QwyUi2BVqd?=
 =?us-ascii?Q?6CX24smwoZZAJRxC2l/M3J5xkkRluLsH/xg9DbSHYNX1W/shMAYkba3aXH1M?=
 =?us-ascii?Q?aQRNPPNwDNY2PFcZnce98WulAebOgtxxHZ1X4gC+njVOSmFzYqL9sr9L8zvm?=
 =?us-ascii?Q?nPdlcWGAGz9873Dfd6RCZyKOcf1gk2lI9/+RgzuEYCWKUv0kKZhvOYnUrujE?=
 =?us-ascii?Q?yYGI6jqq/XeqyL+om+4C4AZ4aXbCAV6/1N/XGwmQ6+juS/ieKuICp42MxRJi?=
 =?us-ascii?Q?sdFXgrO8y4P6eKGuq5dWSivN0rNb90qRQIDa/p3hcUDB9IbGSf2DVd/rGPVB?=
 =?us-ascii?Q?DM0XS1tY/AA//mEHvJtZeNqA2loAYRWEy3aKpRpVtDivm/0ylZIsOpb44woK?=
 =?us-ascii?Q?xTdvSQogbkS1pmRsOLDSS2nc21/g/GiIINq3qAHJodczPtM3xQN5MDi2ZUxH?=
 =?us-ascii?Q?Om9Dv7Qp08g53SZ9qaY6JrQav4nYxRtOkwj4qe8e0IFkU13vGNS4f+hM8dNW?=
 =?us-ascii?Q?WXECQg1nBZQzXkfsGwReypXsdjNA2DDEfpKl1+cYtAoSescW/PMUjAljdmO2?=
 =?us-ascii?Q?lQL9Cr+Gd1JIrlwfaktqRuG+1vPX3HE0xBi1GjbVnLbw5dFz2yiZ+kKfI1Rk?=
 =?us-ascii?Q?wPpSull38I+LHeErSGzvyRls6E6tYB5obR10lOblOA58LvUs2fEokwYyk3LW?=
 =?us-ascii?Q?4z95KLcaV3EAlH/WwcA=3D?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:46:07.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05480c4f-b823-4df3-d2c3-08de3d8364b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

Add PCI_VENDOR_ID_ASPEED to the shared pci_ids.h header and remove the
duplicate local definition from ehci-pci.c.

This prepares for adding a PCI quirk for ASPEED devices.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/usb/host/ehci-pci.c | 1 -
 include/linux/pci_ids.h     | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 889dc4426271..bd3a63555594 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -21,7 +21,6 @@ static const char hcd_name[] = "ehci-pci";
 /* defined here to avoid adding to pci_ids.h for single instance use */
 #define PCI_DEVICE_ID_INTEL_CE4100_USB	0x2e70
 
-#define PCI_VENDOR_ID_ASPEED		0x1a03
 #define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
 
 /*-------------------------------------------------------------------------*/
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a9a089566b7c..30dd854a9156 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2583,6 +2583,8 @@
 #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
 #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
 
+#define PCI_VENDOR_ID_ASPEED		0x1a03
+
 #define PCI_VENDOR_ID_QMI		0x1a32
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
-- 
2.43.0


