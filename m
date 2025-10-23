Return-Path: <linux-pci+bounces-39085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81CBFF778
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60D84EAF1B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700BD26F29B;
	Thu, 23 Oct 2025 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZlYkD0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51126E146
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203490; cv=fail; b=T7mgEFtpIRAYK/4KgGAf3ecJjbDyQKt9iPWZ5r3c79CazgEhoI8UH4Y9Hp/VvE+AgkJwAn7+/qm8u8kaXRTMpug/OuiOWr6BBf9/w9/DB+112jHKH/5iucxJFZKeZSHSAICWeOHlBxY5GnxFJ0rnjnhMKpB20sVykwStilax6SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203490; c=relaxed/simple;
	bh=FcwZVP9tTrNvUChBA5tKa2vNxgUS2Gtd64ALVmZGlds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YmS3ZiZylNplZ5CQUUEtLjys4DB43k/AKNohN6EAajoNCvwWLFdmD3Pvysb6x/7md4Tu4NjV/YKtjyaOXuL8pGQ5gciUh9ncPiLgkjaQFeUKON3r5G7rYgMfiOrqwhSG5FamK79GxvxQW9RLfpiJi15jCvABGcPowxBo8X4WUiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZlYkD0R; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9PhQkqtmIbiTzrKIyv4fyH6EQA9HTnWoLrJ0yvPbLF5po5zC/nwqEIDjNwre4j8U/qdogciUVS1ji9yUhuhpnVFQ2qSY4iFnu25y+7tUrjWPwXo8qTNxdavmbcODwHDqYXbLsTKlLscnpH/3xpQt4ilvukXk2QKXaRWKrqyNdjPaqSTCk7BOJuWRGLKTczOea3ubuewwSeGWgWht3aPzp+yhhUs0DIOTSKQBj+VgRLfagjgZN3lqG0VeHOtHVaO7NG2JhiR3Y32UQemMNJFUvUH8KWWTv8LRh1uMZWt0Yvb1Yfz07J5CWzkcdoS1voMfyuwZ25UuvdYF4IY8qf5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS/ax26KSCbEGPuA11n3jWFwnRa/l7LagRF+CqExfAY=;
 b=uWXQ3y3wlK/Wn5kHNaJvScXwaYoYQ1dFdMGgvHinIoNBpWkjUpny3epRbjtP2EmO54N5bbBnVbfO3wqRI8vwGdf+6rWKr0u93MZkXXdOCplSAHMOWpe420Dwpr6I7mukL17EFpl4leK17ZXCc7cISgQqpENIXVWgL+Qc7w9MyFO1HtNWhGtKwYyleDJHiEa7OaCAgFifiHUNqFVvTUzWo2VeSBsLUfY3+SYbIdufdbgU8oTcTqa/eyvNdBdxwdncRWUiVr/wr7tQG0++PlGMrqa2pHz60oppoykG9ME8Uc2379wxaB/L/EHjcDVc7lTeD6ldRySbaott+jgZ3qeeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS/ax26KSCbEGPuA11n3jWFwnRa/l7LagRF+CqExfAY=;
 b=qZlYkD0RNM4GIFEXeOC1L+ozMXC5uy8DjnbR63SCAdZGUbPiiWLGrJD5xXJYNRzeqb8OZ/yj+kt4vuBZDSj0uGG0ySLtt+VoOpY8ZY/80ZxGO6YcjaE6A5EQGYZqx8MSDHbKtO0e8ecK+/D6QSk+UGGR1n1OU1UboVwQBlXnC98=
Received: from BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::13)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:11:24 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2f) by BL1P222CA0008.outlook.office365.com
 (2603:10b6:208:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 07:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 07:11:23 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 00:11:19 -0700
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH pciutils] ls-ecaps: Add XT and TEE-Limited support reporting
Date: Thu, 23 Oct 2025 18:11:01 +1100
Message-ID: <20251023071101.578312-1-aik@amd.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c62948f-50b3-412a-c238-08de12035f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDGQY7ZQjPt8B+V+lnVQDntlKBQogObGvatQi8Vw1eALA6h73h3pzbXk0vL7?=
 =?us-ascii?Q?GLvdozUZTXwcnd/tnBLthxwRF6YJzwCobb1CfIT2jq3UJS8z13L/mSLzPgjS?=
 =?us-ascii?Q?5+XizYFlrUnzmkyp5d9Vft5c+QbHufeeu0SfTmZjH1zZfnFB4G02w6wy9Nem?=
 =?us-ascii?Q?ihKvqGMOKl7TDiT4dohKNfyF+TII2CaRuUOSPPEjwMxzKTp/MWWrfOgkqqGT?=
 =?us-ascii?Q?74zUyDdaHgN9yLF70DOc8LatBM/2u1gNlmw6qdh2Iurre71GaRTmqIFDMSkF?=
 =?us-ascii?Q?BCH4OYGQnaT9qZiVVk/gZwmMJzFEqr1XsgIRNrWGr3T8Ifyf7cngd+Slf5JU?=
 =?us-ascii?Q?plAHXhfwj7MKbYQIowvnzqsmHOzQ0k1o1lriCZd7VmCbakj8ZooLfV7nZTlV?=
 =?us-ascii?Q?ops2qvIOl7eDrtTs2nbOPNzKFQW2931/Vi24ZvxvtDF7z449yZgsF4p55E3X?=
 =?us-ascii?Q?30XzuvWnZg7Vib93+PvcnSc6mevhoktprsVXBo4C5/Z+t6zIeyJ6GAdATj/k?=
 =?us-ascii?Q?J6L03Chgs7+LQspnHn7VyY/ZXpRiP8uUD5DvOgTA6QUQuQZqasoWOUi7JqnA?=
 =?us-ascii?Q?DEl6kVICiPy/HVSHpxoU4DeU+CNDl92DIfNOScTmc3ka9S6YsYqRhfoypAOr?=
 =?us-ascii?Q?je16OAywYT8WFwkspi73G5BRO+WlybUzqiFjroTp7DezvyVZ9yI31fpAaK4u?=
 =?us-ascii?Q?Mko/4sO44rN2ovX8Vsy0WCCBocV0CebSvmA355d9aDQ0lURgy7Rk7UfaaoMb?=
 =?us-ascii?Q?IXu2yqyUigCEGACoVLa/ixAAIe2rvzaRGi3kmuoBOgTDrRptE2PgJlYMyrhW?=
 =?us-ascii?Q?2TtvP43dFvj1frD64+GlVzTel1vqbohX64wHGyql+/1LvizF3V406aP0fj2p?=
 =?us-ascii?Q?Ny3w2SHrC/xlK+T19CeXbZAofhqyUKGztCNNLOqSBs6JSdTe3R702tyHw7qx?=
 =?us-ascii?Q?f2T7z1TbjWVQSSYuEcNVP04vobJ82Rpv7a2ZvWCLeMgEhJ+/BdmRZz08acDl?=
 =?us-ascii?Q?iqFb/RM26uM/Yt1va4tNISQ5WCSAmqa1/S2v4io/407idht2FxQ5DbLZaH59?=
 =?us-ascii?Q?DW8v7WxuC9HqkNi0973UdtqDTYWYcXP6BajmRJYSygnfT0184Po3l7OGjLy9?=
 =?us-ascii?Q?OVYC51L/Mh6kwrAyIODXPh1dB21+0HCVbpEDnlbl8S5kY8k6bNWJ2JwJ1erA?=
 =?us-ascii?Q?6N4jE341M0I9JY39X9Xwh+se2DOGps6DFuTnnQgboC0G4f8StB2AFQDYMRju?=
 =?us-ascii?Q?+/1VsPJbqmwLh8fQep2TKA3NqCW+Ij8Z67XkYPXizyMH5maBbuMXCzbgDKmh?=
 =?us-ascii?Q?hTS3tk1VLxORLqn/FnfeJ5trtUTeDjfZobNS68i0dxFm0ZPCFtOHT5IWnpTv?=
 =?us-ascii?Q?4dfq/an0IrysYrruu1YwMNByFJ/J0SiNy+c2ha6Za5ZdvH12EGDdOpl9TTXz?=
 =?us-ascii?Q?rrcb2Bn3yiypT4Zrxsl/jW1sGHFX6cQp6d/mW5CdRmqENTRUnUAA7DaBBGTQ?=
 =?us-ascii?Q?L91KMekeyor8kLZ0lTqsX0MXfUIsKzjTk/edQR4kOw66QbzYh1EsjgdDzpnY?=
 =?us-ascii?Q?loaP+ggmO5POV8S/RbA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:11:23.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c62948f-50b3-412a-c238-08de12035f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549

PCIe r6.1 added TDISP with TEE Limited bits.
PCIe r7.0 added XT mode for IDE TLPs.

Define new bits and update the test.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 lib/header.h  |  5 +++++
 ls-ecaps.c    | 13 +++++++++----
 tests/cap-ide |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index b68f2a0..c84b7a8 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1540,17 +1540,20 @@
 #define  PCI_IDE_CAP_AGGREGATION_SUPP	0x10	/* Aggregation Supported */
 #define  PCI_IDE_CAP_PCRC_SUPP		0x20	/* PCRC Supported */
 #define  PCI_IDE_CAP_IDE_KM_SUPP	0x40	/* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_SEL_CFG_SUPP	0x80    /* Selective IDE for Config Request Support */
 #define  PCI_IDE_CAP_ALG(x)	(((x) >> 8) & 0x1f) /* Supported Algorithms */
 #define  PCI_IDE_CAP_ALG_AES_GCM_256	0	/* AES-GCM 256 key size, 96b MAC */
 #define  PCI_IDE_CAP_LINK_TC_NUM(x)		(((x) >> 13) & 0x7) /* Number of TCs Supported for Link IDE */
 #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Number of Selective IDE Streams Supported */
 #define  PCI_IDE_CAP_TEE_LIMITED_SUPP   0x1000000 /* TEE-Limited Stream Supported */
+#define  PCI_IDE_CAP_XT_SUPP		0x2000000 /* XT Supported */
 #define PCI_IDE_CTL		0x8
 #define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
 #define PCI_IDE_LINK_STREAM		0xC
 /* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
 /* Link IDE Stream Control Register */
 #define  PCI_IDE_LINK_CTL_EN		0x1	/* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_XT		0x2	/* Link IDE Stream XT Enable */
 #define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x)(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
 #define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
 #define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x)(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
@@ -1567,6 +1570,7 @@
 #define  PCI_IDE_SEL_CAP_BLOCKS_NUM(x)	((x) & 0xf) /* Number of Address Association Register Blocks */
 /* Selective IDE Stream Control Register */
 #define  PCI_IDE_SEL_CTL_EN		0x1	/* Selective IDE Stream Enable */
+#define  PCI_IDE_SEL_CTL_XT		0x2	/* Selective IDE Stream XT Enable */
 #define  PCI_IDE_SEL_CTL_TX_AGGR_NPR(x)	(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
 #define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
 #define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)	(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
@@ -1576,6 +1580,7 @@
 #define  PCI_IDE_SEL_CTL_ALG(x)		(((x) >> 14) & 0x1f) /* Selected Algorithm */
 #define  PCI_IDE_SEL_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
 #define  PCI_IDE_SEL_CTL_DEFAULT	0x400000 /* Default Stream */
+#define  PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000 /* TEE-Limited Stream */
 #define  PCI_IDE_SEL_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
 /* Selective IDE Stream Status Register */
 #define  PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 0bb7412..ceeefd7 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1665,7 +1665,7 @@ cap_ide(struct device *d, int where)
     if (l & PCI_IDE_CAP_SELECTIVE_IDE_SUPP)
         selnum = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(l) + 1;
 
-    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c Alg='%s' TCs=%d TeeLim%c\n",
+    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c SelCfg%c Alg='%s' TCs=%d TeeLim%c XT%c\n",
       linknum,
       selnum,
       FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
@@ -1673,9 +1673,11 @@ cap_ide(struct device *d, int where)
       FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
       FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
       FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP),
+      FLAG(l, PCI_IDE_CAP_SEL_CFG_SUPP),
       ide_alg(buf2, sizeof(buf2), PCI_IDE_CAP_ALG(l)),
       PCI_IDE_CAP_LINK_TC_NUM(l) + 1,
-      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP)
+      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP),
+      FLAG(l, PCI_IDE_CAP_XT_SUPP)
       );
 
     l = get_conf_long(d, where + PCI_IDE_CTL);
@@ -1697,10 +1699,11 @@ cap_ide(struct device *d, int where)
           {
             // Link IDE Stream Control Register
             l = get_conf_long(d, off);
-            printf("\t\t%sLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
+            printf("\t\t%sLinkIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
               offstr(offs, off),
               i,
               FLAG(l, PCI_IDE_LINK_CTL_EN),
+              FLAG(l, PCI_IDE_LINK_CTL_XT),
               aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
               aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
               aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
@@ -1744,10 +1747,11 @@ cap_ide(struct device *d, int where)
         // Selective IDE Stream Control Register
         l = get_conf_long(d, off);
 
-        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
+        printf("\t\t%sSelectiveIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d TeeLim%c ID%d%s\n",
           offstr(offs, off),
           i,
           FLAG(l, PCI_IDE_SEL_CTL_EN),
+          FLAG(l, PCI_IDE_SEL_CTL_XT),
           aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
           aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
           aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
@@ -1756,6 +1760,7 @@ cap_ide(struct device *d, int where)
           TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
           ide_alg(buf2, sizeof(buf2), PCI_IDE_SEL_CTL_ALG(l)),
           PCI_IDE_SEL_CTL_TC(l),
+          FLAG(l, PCI_IDE_SEL_CTL_TEE_LIMITED),
           PCI_IDE_SEL_CTL_ID(l),
           (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
           );
diff --git a/tests/cap-ide b/tests/cap-ide
index edae551..eabf5ea 100644
--- a/tests/cap-ide
+++ b/tests/cap-ide
@@ -76,10 +76,10 @@ e1:00.0 Class 0800: Device aaaa:bbbb
 		PASIDCap: Exec+ Priv+, Max PASID Width: 10
 		PASIDCtl: Enable+ Exec- Priv-
 	Capabilities: [830 v1] Integrity & Data Encryption
-		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
+		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ SelCfg- Alg='AES-GCM-256-96b' TCs=8 TeeLim+ XT-
 		IDECtl: FTEn-
 		SelectiveIDE#0 Cap: RID#=1
-		SelectiveIDE#0 Ctl: En+ NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0 Default
+		SelectiveIDE#0 Ctl: En- XT- NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 TeeLim- ID0
 		SelectiveIDE#0 Sta: secure RecvChkFail-
 		SelectiveIDE#0 RID: Valid+ Base=0 Limit=ffff SegBase=0
 		SelectiveIDE#0 RID#0: Valid+ Base=0 Limit=ffffffffffffffff
-- 
2.51.0


