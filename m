Return-Path: <linux-pci+bounces-10464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A2593436E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC1B1C2157D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E064187561;
	Wed, 17 Jul 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g30DrpEP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22718733B;
	Wed, 17 Jul 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249752; cv=fail; b=s4MfP2qpug5f5refVkw+bHo6Vt9x5TV//KFhMHOn8/5lxgiNtnO2oDY6pTgG48vPOanWD2TGSBqPYgjTVkqFryQvx76gFSMEdgAxqlYGYc2Ef/Xm5be/dmbfyn5c/4F8HrZ3m5RCf8k1tqTRxmhXTbOKFYmClfyzf2b37a8ctFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249752; c=relaxed/simple;
	bh=tWRsfyHJDwiUOcDGjXlQ79CQ4GNyiwuaCwvaflTKutY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAf1/zCCQMziPUncx2jKoUkiydXg0CEJ4P8gAep45ei/46tlHsWyCJVryVNIt/KAgw1UhhGps08YCWx7/EFotMBHCtYpmDEBoXJB2///5hfdxlyI/ccaQjIHPsNqhYn4mtB5pbnP9WXPLkesTLpQfA8pKY4w6L6Kv8oBRerVqXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g30DrpEP; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuOpI4j4c/j7RM1iom0HWPVOh6P8yPynjEdw8D9+2GgEI8Di1SvBb5DTK1PR0wb6p9sxV60u/EcRRorvnonP1QBQxKmkcBdb6MzslWZbT5A4sB+nSeGTJmi/e29TlFFUPlpC4oPeBpELli9CByFpqrsdoPYvUoMYHTMxzez7aNI+s18+5Y1rHQGdM+QIunEFm4NXh7fAoQewBECh2/FiasiSwxYVv3JMaBkjs8a9IyanE13SkGhLhD4/PXBWQUdDmy8EXbohGbnU1rZ+ZyRyeieybqPy/HlAzacfnQHCj2eBEdGYyjhGyv3OJmNvpDBdBHtU2xGeBbP1ttHZi4Bd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8//LUcBN7pS45ZBF95W8fHws8AmF6PPpujcoEf15L4=;
 b=bAENjkGfaWUHWAgJzQFbXmOuAPL744rY5bqErOJfi0zmDCWs60SQvgIPf7fgizxgvjiu6mS/WpiBhYoin2isAubCg8j8EoGJMs+Fd+oVgJDeN7WRsP9Jl+mFGmSb0uu4svIsYuou3S1ym9WBe56i6UE6ESRJQz1/FrIps2OZPiJOfI/5JGqwwCALBgxCneniSOc/TR+DSspG/OUDVoW2WGtTcvzwMEIflR0H9LMgFlU/I0GfZuPHFAvNvDYiczi/8gAA8/wB4PI0d/W/fmeM5kaYX+2dOdTyupcUDTe/wRwGgVujZJgYjb75latnuktME92YYvR7xgeBFKxwZCk6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8//LUcBN7pS45ZBF95W8fHws8AmF6PPpujcoEf15L4=;
 b=g30DrpEPEnXeVmictTc+YrORkE3vmhw4r+DUVha+1S+364vHikVfxib1TxHexqVfvk+ETUMjI2gvLYTOHpiJ+oKQ2LnlN2dDC+VzO73G0Kt5gzz0i+31H8uZFxL0qDgvwrDVeEnOlaTW2nJntpFvsC36UBi1wIaIsGOIzyZ6UwE=
Received: from PH3PEPF000040AB.namprd05.prod.outlook.com (2603:10b6:518:1::4d)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:55:47 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2a01:111:f403:f913::) by PH3PEPF000040AB.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Wed, 17 Jul 2024 20:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:55:47 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:55:45 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH V3 02/10] PCI: Add TPH related register definition
Date: Wed, 17 Jul 2024 15:55:03 -0500
Message-ID: <20240717205511.2541693-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4d2603-76ff-492c-aded-08dca6a2d534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hB9Z8+O4OzlVOLdFg2Aa7UP96iNG/zMY6fDz+bPrybCwQOaIH0YjA1zG8KPx?=
 =?us-ascii?Q?l76pMtaibPn4tKAd1xeEV9tKQYuRxfXOef2FX8v7WhF5KVE0eh8oftkKoT1k?=
 =?us-ascii?Q?XEIcDKnceZO7Y7kVBk+44UssFHVYHWcMEbL8O35fi0MM032MQ76tZj5P6JWW?=
 =?us-ascii?Q?ob1AJeCec0CYMBDptOd21uTZBoJNvzIn919My+1Rd4cVgDp0lrlt5NyjbY5k?=
 =?us-ascii?Q?gvbO39rNhPAHbE5jdYqdVim1OdEBr6/d0nsWrZ9Gjjzh5ACdLvAQYMnCcPKA?=
 =?us-ascii?Q?SbbbO+Bs1DWgwdx4HZB7fdiF/RrpTwuhUoES1q6pSUKLDdjOjOmQy6YqMcoO?=
 =?us-ascii?Q?dLLSnI5dxfkQFLwDzkxJwTdCVllGfhI8eP16rP7woCRGgX1K0Oh6sVZrkEJS?=
 =?us-ascii?Q?7QUJhajStwiLlKUihRL1u9b/X3fgQivvEFpKRf8MauY5cYNi8Js1Y5vwS6WD?=
 =?us-ascii?Q?gd8cCVfnQ6PAzTQXLsqrAqOZlBIJ7Xs8T+aoZXepOpq3hfzn/c255Bhp9yBf?=
 =?us-ascii?Q?0uLescn3aF4E/3ZaqKJZeAP2B/EuB+WB5ZWXctLzzO8fmwSIFBrcv/wZe5vk?=
 =?us-ascii?Q?j2Ljqt0dQROqaRbv0lQ+AjUqdtjxMIFRlpUZYxoNO1GFjxgWXeyDKcgdbhwy?=
 =?us-ascii?Q?YZFZe2BrPx8osAj14JFJOMmPhZ4hiqb7kwWC1/8SKy15E3Xu0ZHea3YEdY6r?=
 =?us-ascii?Q?hOh0gheDIIOKAllD+QjsUYn8kwVSs7AVzPmLrviZhwxdDrsB0cpBfZaZVqkB?=
 =?us-ascii?Q?inxjLBvslYNoIAdnzC3FHNCBwg0OS9cDSVDWnBTsNFEij8jeNB+vRkwWRi7e?=
 =?us-ascii?Q?lwLGQl1lPk+wmNL/1lWp3wrlQV5ZD96pm8e+Q2JJRjQYpfCCPGAyxFISJGG+?=
 =?us-ascii?Q?o7YQRCm2ZTmflOfsUpSfIDJ5DpiD7g63gCtnlNaBHRiQWGQ4WdcGURuUixZi?=
 =?us-ascii?Q?/zb0VUXJTxoXbbQ20HQ17Uerm3dUgcyfNLyCaeOVrE85ujzDMeM99UK2TLZt?=
 =?us-ascii?Q?it3ovLP4LYMLK649yS5EHmrrZnezuLM6IJyeKoi89ZT9N+us87aU6jGVOEiZ?=
 =?us-ascii?Q?wjOhMyGRAl65iQ/I9BxBQdRiBK9FbFEZcVfj5yU+AhyUHBofLYRe2iEKWxRc?=
 =?us-ascii?Q?dvWy00ljj59ZqrFFiO7bYS/xal2wiGvx5z5W/CxczzOXGi1sq7hPEHO8y0V7?=
 =?us-ascii?Q?iRWieAsq7Lb6C8V4GYecBwPUsuQV+XAQrP197XYJZzG7rNsmdd5q6JE8DtUP?=
 =?us-ascii?Q?7aPcnDi6t21sDTFgIHyOaGtvFvjn9xABoKy2ZS9l9E4jeru+zzkw0JqSEU65?=
 =?us-ascii?Q?bI615dtepQD+VJom0wqr3t43xte/HQQ42WuHTydFt7jwZgIbIrTGMlEE0ecv?=
 =?us-ascii?Q?9icFqQOkIi7xzBuZwKG5dJKJ5f4ixihU2kXNMa+FAeCDgHKAi4ju0x2+UIQk?=
 =?us-ascii?Q?VaS/fRzA9qSmndCcAXC1QW3likByNOdE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:55:47.0273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d2603-76ff-492c-aded-08dca6a2d534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

Linux has some basic, but incomplete, definition for the TPH Requester
capability registers. Also the control registers of TPH Requester and
the TPH Completer are missing. Add all required definitions to support
TPH without changing the existing uapi.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 include/uapi/linux/pci_regs.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..0fb61af6097a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -657,6 +657,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1020,16 +1021,35 @@
 #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
 #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
 
+/* TPH Completer Support */
+#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_AND_EXT	0x3 /* TPH and Extended TPH */
+
 /* TPH Requester */
 #define PCI_TPH_CAP		4	/* capability register */
-#define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
-#define   PCI_TPH_LOC_NONE	0x000	/* no location */
-#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
-#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
+#define  PCI_TPH_CAP_NO_ST	0x00000001 /* no ST mode supported */
+#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* interrupt vector mode supported */
+#define  PCI_TPH_CAP_DS		0x00000004 /* device specific mode supported */
+#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* extended TPH requestor supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* location mask */
+#define   PCI_TPH_LOC_NONE	0x00000000 /* no location */
+#define   PCI_TPH_LOC_CAP	0x00000200 /* in capability */
+#define   PCI_TPH_LOC_MSIX	0x00000400 /* in MSI-X */
 #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
 #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
 #define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
 
+#define PCI_TPH_CTRL		8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST mode select mask */
+#define   PCI_TPH_NO_ST_MODE		0x0 /*  no ST mode */
+#define   PCI_TPH_INT_VEC_MODE		0x1 /*  interrupt vector mode */
+#define   PCI_TPH_DEV_SPEC_MODE		0x2 /*  device specific mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH requester mask */
+#define   PCI_TPH_REQ_DISABLE		0x0 /*  no TPH request allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1 /*  8-bit TPH tags allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3 /*  16-bit TPH tags allowed */
+
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
 #define PCI_EXP_DPC_IRQ			0x001F	/* Interrupt Message Number */
-- 
2.45.1


