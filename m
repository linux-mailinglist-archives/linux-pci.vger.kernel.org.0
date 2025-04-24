Return-Path: <linux-pci+bounces-26626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D41A99DA3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AD53B8606
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522F54279;
	Thu, 24 Apr 2025 01:04:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023101.outbound.protection.outlook.com [52.101.127.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21471EA84;
	Thu, 24 Apr 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456696; cv=fail; b=OH8YU6GhsRvmzQCGaxuVq3XEFmxYWctt12kFzApj2AVPeM/xPjHk2IqSecxs8WYtdJWfqaryZJMNfNkiIOgSmG/E36wXt89DHfuBcBir8QPCNPKUeG+rZa3gDx9CwUDFrylvAvhR9xV7mXxhDQC932Fq9MO3+Ep/+eLhrrSG/pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456696; c=relaxed/simple;
	bh=ymdWcPeqV/+pQJ1VBxTJltrTP5tE4ppCXcpmiaFQMHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy+3AkuRBXX5yF05TjenO2QQWogMyJfGcodXKmz96bGR6y7jwk2VTiWge2JW1kJvcu1ykJpHACwGT43On7jayYhJfwk5lH4GAtiEL407jjYYwgEhlqTTMnU7uQg7EoH70ZzrjC9FYYGCAa4fwemFEzq3guf7KnaNMRctO7ttodo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqrueLcobHUK6GiFMc1ROoPoy+MhQ7NVLlnoc4/8EgKJ2OAmtIsPukJwGJini47V8hydnSy77pFryfuX32fsJWLhH/rzo0Ea878308Q8fbQww1GHGKhDLdjnbjci+5FeExUnt/+qKLcUz/m2epktDD87Lnw1se0IaOddUSll0PLLfgGkRNGngr4fRJ0GuRFLOuvUYPHOy4J48wzh0yorAZgWPo3c6hW+av3ChGUHf5MGyyczikLm4/llSFICbOvr9iDvObHDUQ6QQU2fb0BB+3ZYQjGIcE5HwZMCSmmnQ7SgMeXZe8aA4CAtRXgFVIhe9SbUE8MNr8l/c65D+30IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nosNjxA7Hz0g27af6Z5xio3309WNsqCYHXOfNefIwfo=;
 b=OVVlV0+U52vMY3BgaDz6MZKmgFMpDfeQkSbwqOY++k74EqBEcs431KGKebqEku3t+RmKB8QSl8v420gyJlVgeeMDFr5n0/1VbjaYsnePAha51JNUNMvk768DO2gLRwNqzYQMG22oA1exGvbbcFWsIRrbVKauplV3Ix45XQORRQFdts0ahV1Utt7xZ6/ncFdAtGFx1s4PX3+2ppIb1o902kzG7pwOfIitET6Tk0TNxLOkY04WsIm1RMpxt70HBsCQrTDrkhfN9wgPyRLiIvucIXGHCQ86NNlFAwjGWNdZ73QdvzMagCv+PT6OY71c9aGgEgSe4XyVcRojOmlpYvlegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) by
 SI6PR06MB7113.apcprd06.prod.outlook.com (2603:1096:4:247::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Thu, 24 Apr 2025 01:04:48 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::aa) by SG2PR04CA0169.outlook.office365.com
 (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 01:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:47 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AF988416050B;
	Thu, 24 Apr 2025 09:04:46 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: peter.chen@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for new EP configurations
Date: Thu, 24 Apr 2025 09:04:41 +0800
Message-ID: <20250424010445.2260090-3-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424010445.2260090-1-hans.zhang@cixtech.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SI6PR06MB7113:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8034342-825f-49d5-e433-08dd82cc0200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKLG4bkIf65L8f2RU7D55q5tihJ5ia6al5sBECNyu2ErhFCVXHic3q1bIh0W?=
 =?us-ascii?Q?rYKyU5zeYeWQIfbU89bStKTIFGwi0idwj65PvnfrkugqmlY/yX7fCqeIEtXh?=
 =?us-ascii?Q?AVCH30XVpVzCprMn2GRv1vKQvlL7RzoQrl0lOSJB3rachjOWQ+aUIqESwE2V?=
 =?us-ascii?Q?ff14ei5sxA1p98nYNltApgcn97PHmnLg8JgXdNBIgFS0eFeuWd94JKJuxXMd?=
 =?us-ascii?Q?KFfGSAsb94NcbaCZ+8aoWdSxRxdieMtaquGsfBiKkosA93lmo2hzAA7EXS9c?=
 =?us-ascii?Q?v0bNIHEOk8oFgs0k2tqEGqLwl5AT4qqVNfzyEzW9pR3NTNDSUItBlQExV2No?=
 =?us-ascii?Q?6FdNB822usGEWO64xk38KFmoIXdecCWCGKbEEvCShOxonJsx5yWSLyJVa3L2?=
 =?us-ascii?Q?OeM0/4s1f4rSp4exlBcbjb7DDAlMqckhbJtWHRVOQnjny9uhPm2gHieIhNxt?=
 =?us-ascii?Q?rHtE6HI6i0JZZHIHMqkNg6UX1moZ9SWNUE62bVpkejuQhcq6MfenIM7I0doX?=
 =?us-ascii?Q?e52qprQuO8hVyTfKST8g0nqfQ5HWLG4WAqr5yTz+jCtRwm1ayaTgYICZnjjX?=
 =?us-ascii?Q?CNCUDQM3t2MgdsyeGLioL8npPw1slZyIaNGxAk3Uh+rfr8CJdh8wxSYbuoN3?=
 =?us-ascii?Q?zyl7BjSbMUIhwC/wWt02313iXJlnE4+DvXm/n1GEwXH+/qFuqEBMrIDAkXKe?=
 =?us-ascii?Q?nHsbQ2HsoNRadZilgCaN8XvbXS7Wxj+8HnuGxSiMSSAq0Hm+qZBpyAoPqs9M?=
 =?us-ascii?Q?UsMC5pCeI4LnI+jsLtlojRNzempOtW1YHxJiCh6rk8X6SRDmm4yOc2rzYD8w?=
 =?us-ascii?Q?qGE1FkwYoMWgjm1QLmaHg5nyxRspeF8fczXWDb3Mh/2XhLn4B0QSBgmlmu93?=
 =?us-ascii?Q?t1zcRdJKVJQAn1F92WY0SvyD5xsquE7vyJtm5Snj4WZ2FgSpFoMb4XTc8e/a?=
 =?us-ascii?Q?SCsoJOZZNnmHjY/UAqxUpD05pLAf+yU1m+oTuTdubZEKfZey5y7GInkqLdy5?=
 =?us-ascii?Q?I4rQTuklduWLKhz67AGXhLY5b853/LK8Krh85iD6ITohdqVI5HJOgGDKP0RZ?=
 =?us-ascii?Q?mEAxdC3lcP3AREjUw6rdTfBab+FfMpXKulz4QE0bZL/YYoZx4jamC0JyuETe?=
 =?us-ascii?Q?V7qY30sFtYha2c+LesoiI4yKO1JQyDlBoteuEURdi+eTSaJCKL3aGXBz0iiB?=
 =?us-ascii?Q?F6kWkkhAFETnDjl3ithPucPOfTQr5pvWvEpSN6ze06iNNQiwNp9Zfs0VNT6+?=
 =?us-ascii?Q?bMlgnru1LXItTCcudfzrGMbbM/api7MWqxCCkBz9syaS2TboMJj5RI9qxZvf?=
 =?us-ascii?Q?Slc9EbOZ8iDVvRRrJRgYQNfMi/ZUg7fBjLYtqrKMc7Xxm50OaX5EuOgHetJe?=
 =?us-ascii?Q?q8uBoJjTsPVdVEnYI4z4sbhcIktzCyojBeu2NvCxLnCHSGCmoYdrdInVEFMp?=
 =?us-ascii?Q?s6S/oO6M/1cnquvuS/st9jhROP06UahSlmtFm8OdslUk6fDZ3BKB+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:47.3311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8034342-825f-49d5-e433-08dd82cc0200
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7113

From: Manikandan K Pillai <mpillai@cadence.com>

Document the compatible property for HPA (High Performance Architecture)
PCIe controller EP configuration.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 98651ab22103..a7e404e4f690 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe EP Controller
 
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
 
 allOf:
   - $ref: cdns-pcie-ep.yaml#
 
 properties:
   compatible:
-    const: cdns,cdns-pcie-ep
+    enum:
+      - cdns,cdns-pcie-ep
+      - cdns,cdns-pcie-hpa-ep
 
   reg:
     maxItems: 2
-- 
2.47.1


