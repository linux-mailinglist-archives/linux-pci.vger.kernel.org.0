Return-Path: <linux-pci+bounces-7258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72A8C0377
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DEA1F230F9
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F612AAEC;
	Wed,  8 May 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oid2V30v"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4956128383;
	Wed,  8 May 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190172; cv=fail; b=KgtW5Y1IxMV0Lm4iKY66PZlgSL2acVscid5p11YcB4DKr3BExtYXeMiAMgO7SceZw+q4bgMTNqz2cY+f0er6tTDpV6hs29Hl8uXmza6TBveF53qWCXJuGK6+HACEGH8BZIcaNFjU8KbRYsgvHZPbkjhvYb5NG+pfkJQirUcnD5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190172; c=relaxed/simple;
	bh=NEkqk3BiZEHczsKQDO1QqvOhPFwGrhEeeIXkiI7vaEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyY6esA8i2xFf+k0Mxwu5dpQqP2VsbU669IXxrsFByAWVGN5OJ64GFOmkx4FfdLr1tUWVrE11Dung96H8Ojbpn6HjPLAH3iF3Nn+3xcN8ekqb0jkx1G/tfpyrSGF5FoDP2TRCEzwvBplPon/56ClzDERFXJ+vW4Y0zp2TwrTG0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oid2V30v; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIFx2Yrocpb6mlm10XmF6VS6xFEQ8xslzra3wYb0PsgttaiJKDRNIfDODHE5px+nVDidGGRJgB7P33CKWnGQ2+cHT0WKCIyYzU//KqM4Qg6JFjdPJhixdqnXPXJ0kgPjTbPMyXSLUADYx/WRoXmn3ob+hDur0mWBA/RQSFuyUy02gwIWkIDFyhNtIL1wRvqou4vnFWIhYBfazAX8aQxgFzfAhIq+0+nSn1bElO+Ldxoq2kwduEzm5vgUBv6XdbKy4uI+q6mgxPtvf64NTUaENQcoP0UW9oko7DWZpqQsUMuQakGj60z/6wyvcFwO02/OaNolboe8nqBPP266SXe+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Yn++iQ9U9uabJZAwDKvB6h6xp9uewjL/y+O76dY7A=;
 b=hG8ECeIDFhk7huUUQA+62RS4uqudsdh/KQjSmR/5lcweY6pgD0lgTmDAmIPozd5kBfRIzF/67fVfVUAHSJO4P0Vrj/PfULBkUpnEJLXePPy3iOyCzPWpM2SSfjo0QrYYtJEn7QJrKCwvzs2AWH0ih4WRKaZ2NYtz8p80oS8uMQbje7Ke2h4zhN8TfJD117Pyo4wvtwiN2OBFB44u5hXCCxSkkx/8Sd1knmDb/d67bzPTSJQnDbIGagJpDA+cxV4IYPuPbaiPI8JS1+FUEtME4DEFTlilH0EjM5It7mE7ZFZAdzkJgGavKJfiurk+Ki54CseWyq5O5/D2JiwxtYZPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Yn++iQ9U9uabJZAwDKvB6h6xp9uewjL/y+O76dY7A=;
 b=oid2V30vlti9Va8RYZMAjds37sfJ6QtVF4NGxSmLE6pUu4X0ToGrDc4156/Fhanz/24N6uzGyAl/VaLSfyrBnNeHL20zTEHOzPGOondufpazgZbJ/+KDQfz3A5+ELTCjD8lbyyt2Vim7zo7oQuleCd/zTfy2+pb7oaO78Ut927LpKz3Hfo7sXeNL2AfP+TpRPiOImrydNfYY07f6/lc4rdA1LKMo881l5+rY6owuZbugOFUcTVSVInB7KQlIvYRwS+ujS9clgAPoCLPW5Cq5rkP1ksCPypys+tQyINIslgWuSWY6s7zqpnFb4Ej5o1NcIKxydtRkORyDoHHjuvIxYw==
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:42:35 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::64) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:42:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:15 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 10:42:11 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V7 4/4] PCI: Use preserve_config in place of pci_flags
Date: Wed, 8 May 2024 23:11:38 +0530
Message-ID: <20240508174138.3630283-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 28de7354-08a0-419b-5ca2-08dc6f863f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4vAOQFKwH6NQAeCRUE2XbaDxU2AawJsRj67mki3QzCD07m/397h7gZO0Qed?=
 =?us-ascii?Q?91g9BVjRnuT5z80XOUTUf59/pJ5kSp/HydjctiXDa8WbdV8jfeW60D8F2JOu?=
 =?us-ascii?Q?jZZh6lucgso33x1se14MqAbcYvUbLcYhn1i6L/sxniCRABp148a8pRZsnNWl?=
 =?us-ascii?Q?3XnKmQ5beRQSy4WAtQBkjUyk/UN5t43TBgSkHF2QQDoY6pDFOrOpMgyuHCAU?=
 =?us-ascii?Q?V+5pyR+CsOoWj60K4Y7WeTjtZoiR23I6AHJmJDroC6mearpIdko6czxsDyuI?=
 =?us-ascii?Q?r9DWMSXctY8UkW+3PQaIlyO9cpNSHaodpRlD/70qBvisRhXQWaM18h6CHhE2?=
 =?us-ascii?Q?t7XMpr+TYGBg165I9vpL+g1xKP++nCX34cawrHU8vzQqFn4Rh3NWxtW4Olsk?=
 =?us-ascii?Q?UmcPdiEE+yICiCusYEHLjSNK7d5TNH+RoKZDeVpygTTm6/L//ocR4GFaEvoh?=
 =?us-ascii?Q?2XyhZxixgKSDeaVlIA6VZZf7yLOJewcUoAq6VrcI3sZDR2taFupAoo8afKT+?=
 =?us-ascii?Q?AHkeFFYbR3s44evuqh+6MScuRZgci3j/XKUs9Zy97NpEP/2qizt8pDZUQ8DB?=
 =?us-ascii?Q?wJFabBrg9JjSKF3Xkf07qroHxUYcN4t4wEfJh8r6FIlAP7B395fmv+a5AcFJ?=
 =?us-ascii?Q?n0yqGuCxv57kC/XHP/VgcCwvtwS6xsndbBeSQK27exYrfJ7FvlswARd1F96/?=
 =?us-ascii?Q?ZMSaWoU5i4pU0U0HjRp7I8k+FbNKl+usuh3ZOzIdhHwC44UQ7jL7CGryvb2Q?=
 =?us-ascii?Q?qqX5Y6UZcpNrkm8RQtpwEfb9078Gnlz/+xtjQMcABdhNXfwfQt2hWJkvzX13?=
 =?us-ascii?Q?/48NkK9HX6eNnzmJ4YmNqgBD4psVTT8Dq7SFOhGSmLqfjBoeMw1QrAop1kU/?=
 =?us-ascii?Q?cUuC1Pe2IvFHneTw9CIp5rfi0k3UHZnT9pjPeUGqwkbuanxWWy2BlRfjJs4g?=
 =?us-ascii?Q?nBvB8jCvplL+JElDpaJpfI9VY73Dc7asO89eMG0tXo0I5iwtR1oqFIA6pjb1?=
 =?us-ascii?Q?NqSixjHU4FToIOzaB12hklFC2x0xv8bqRHn3uF4GE5U5WcwWWVHIA16S/91y?=
 =?us-ascii?Q?Ade4ODPtQJa6CBAoCwaGHe/6OzSuPF7OyX9/zRaKz7DlKHYvaB2AdtSbX5Dr?=
 =?us-ascii?Q?BwSZ7bgTo5/VXBH26n1bvgMUmhT815tMuvlaZXAE0vW+FOThLRlGjRBJoosg?=
 =?us-ascii?Q?rs9cAhBaELbbp83Ty1wp89JPhLWaTF7z7Y07Gbt/k/NpJJZFyHj7IhbxzC5x?=
 =?us-ascii?Q?5ap6jsZVPK+Am+wFqpXfxOvqOIvD678aN5XK98SimLFoqhmCrzfyzS89NRXI?=
 =?us-ascii?Q?7G3gyVnUAy36awQRLYEc2RijEOZqJNQcNL41CGNDwiZhvkd/nHjyO0x4DYBR?=
 =?us-ascii?Q?0bM01Ns9o0uLv0SHn6dwn4IXu5T6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:42:35.2840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28de7354-08a0-419b-5ca2-08dc6f863f0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

Use preserve_config in place of checking for PCI_PROBE_ONLY flag
to enable support for "linux,pci-probe-only" on a per host bridge
basis.

This patch also obviates the use of adding PCI_REASSIGN_ALL_BUS flag
if !PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources()
takes care of reassigning the resources that are not already claimed.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/pci-host-common.c |  4 ----
 drivers/pci/probe.c                      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 45b71806182d..c96b2de163b5 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2c232c22d6af..b4adc33f88cf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3088,20 +3088,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
-- 
2.25.1


