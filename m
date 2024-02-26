Return-Path: <linux-pci+bounces-3991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138B8669CF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7591F22202
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8631B964;
	Mon, 26 Feb 2024 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVe6PO9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDA1B966
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927328; cv=fail; b=it57PPkMm6uNpqFR2Vzse6+hRhzz4Qbqu+UbMwrj2eWCa4CMVKsNix0sxxS2HM0F0ebKxh57+uvqrOH6LLb9D1gXEcDf80Ij/JgIlyhdzR5k0VlRnaGJM8C7kaX7vjx2NbM61ataWHFbTrk2Se77G0loIBpd1vvEfqn/Wk9nm2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927328; c=relaxed/simple;
	bh=dD4J2R3SW0ZaVdrn2umiRVKvXKap3YFyLKPC292nSIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRvMo38E9s2Q/D6JuRNfozC6os9prtBeJ6B61b2jxCjqJzvuUQAoquNYH2kt4sDOGaqm3yC2MIg5p/bbaJKYxt34m4iAuT4CavQClqONNkScq9Mer/onAm5SJdDRDDIeeqW8AySij8prZDHH/pgtoSd0vOy+rhK5nu9DB69MGSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVe6PO9I; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyOx9A+8M/PTImDG0EbfxPH/miVAlxki6jZWERUaraSUzB4eFBdwqmOWR/SHWjG0NiABiEiXOIJztknhZaL6nWZCBxPZ/myV47AWjJdE+CP/0wAgsKu0VKpwDEsnRUDxhGUm9tVHecM8bM0gl98E9Dpmw7CQMegVinjHpkYxadGuPAnRxqyHtAobwdC6LgcLAjo7bHXMUsE01ZsFeMs8BhlSPynaBnSxRBMHM87ia4drtFt3H365jZvj9XoUk5KPylvYi3X3suA7rFmuH4fLbyA53FmgjARI/yMq/hoG3vKqgE0Qcd+l4D3X9tAkLJm8i4EJxAivv6xhII8YNJHN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD7DxrLYrOwy4QTV3vKudGlwY6a7MpfZREX0uW4frL0=;
 b=jB17JM6lM8PkQTZLmW6qDuhJnPr1Lbw/OyhOTH7bP9qLmz9YcPGyn52w9UEIObRbFbzBkr+W1azb6K8/65pcQmxNI+l66mhj8essg7ZnThRoA9UpB1I0mE6ZV3q2G94Ty7gFviS0p6qOvV3/i/yNNvo4NzlmQEurDPlNTc+2up7aKCgRv/nPawilZxUe59J0a9Np7wf5kuZ+p0QWsChX9iim355V0DinFEpRsfZHTVtugoyWe2QgD9q9qsvUp+OenqE3Vs1J+fp6oY+WAmWc7pK1BNTW9uKm2W8WuuYmB5f9W7DNJJJdncUyMaQ32/HD75yVlg2w069C63qIeIMBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD7DxrLYrOwy4QTV3vKudGlwY6a7MpfZREX0uW4frL0=;
 b=gVe6PO9IKNpgC0P+iOGy3oE8X/HSp/DlZVJH76WUmx4Fiuibc0Ad1CTBHpW8NJNwyR6XwubQXU23zjajDxr16e6uN/YmYjmMd7IqFiLrdCneFaDe74r/9SECQdzFwQCeuGur5la1xVcR0EwLEklARsElOFqLnDoWX8CeTApYW0g=
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 06:02:01 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::42) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 06:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 06:02:00 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 00:01:58 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH pciutils v2 1/2] ls-ecaps: Add decode support for IDE Extended Capability
Date: Mon, 26 Feb 2024 17:01:34 +1100
Message-ID: <20240226060135.3252162-2-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226060135.3252162-1-aik@amd.com>
References: <20240226060135.3252162-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: d18e4ed6-a606-44ec-1790-08dc369072e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3rn9c5jfxiwxne7R75y+U/5L6pLhdWmLgLo9SBoSYlE+5qMSzuggE1Fo+WR1ZdrJtG8HNDgv9O9aw7xIhVsLLflwC+adJsbx39nx15SThtAwc2PGWhkSjgDkMP/UvrcE0uLDEDXVBIMo42FPRyit5uTCbciRe2HDELibo1r1UyMTqGAuhdP/olBpbVd0+LxzpG5Y/dkEaktRXYZzySb2K8wCySzodbjqaAP7JFH6Je3rm96gscXySvag69DGv9eIjLUVgmF4v6y4bQe60z8HvZu8OrDDr7KOrGcU3v3R8PuC09vPuBnp8sKZ9FV120llzNtJGwmpYyN/O5FYhSJr8Z+jnBgEtxQ7iC7H/4pzC7brjTP39JKU8QH9jVsdepeXQTPicpym1VNOAm3k9Qq6WHvM3/tQid6kT+SsTTahIJb//yMTTtCMsNGuuCb3uNkEK6E/2hXvn8iFZ4d9mHUAwR836klO7jyAx3gtrLvgeM5obM1B9+70smkz7Ps969mggRZhRt7caB7oNWjy4gWen5pLSln6fTGp0yJ9w34wYtKPdhVfx7dK/BoBrP6o1OHkGYLYL29fhpBRjN7vED0I72vHs7uOyDlsAWcdVdk/m1fdH6IOWnSxLp4qe7/W74+rRi6PfdKutvsotzJLOxbUbPTsEwG9bOJTlyTlU4oEzizfLPszV3D36OCuMa9YykcvDpfDimhDQb857l7xwiZ37zDDAcs6zwuDT9iz0pUIVCO1MiW70Jiwfr/o6fU99tz7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:02:00.9637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18e4ed6-a606-44ec-1790-08dc369072e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

IDE (Integrity & Data Encryption) Extended Capability defined in [1]
implements control of the PCI link encryption. The verbose level > 2 prints
offsets of the fields to make running setpci easier.

The example output is:

Capabilities: [830 v1] Integrity & Data Encryption
	IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
	IDECtl: FTEn-
	SelectiveIDE#0 Cap: RID#=1
	SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0
	SelectiveIDE#0 Sta: insecure RecvChkFail-
	SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0
	SelectiveIDE#0 RID#0: Valid- Base=0 Limit=0

[1] PCIe r6.0.1, sections 6.33, 7.9.26

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
v2:
* added 0x30 cap to setpci
* added/fixed some flags
* added a test
---
 lib/header.h  |  62 ++++
 ls-ecaps.c    | 192 +++++++++++
 setpci.c      |   1 +
 tests/cap-ide | 346 ++++++++++++++++++++
 4 files changed, 601 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 2cee94f..68cb3c1 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -256,6 +256,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_32GT	0x2a	/* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2e	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption */
 
 /*** Definitions of capabilities ***/
 
@@ -1422,6 +1423,67 @@
 #define PCI_LMR_PORT_STS_READY		0x1 /* Margining Ready */
 #define PCI_LMR_PORT_STS_SOFT_READY	0x2 /* Margining Software Ready */
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP		0x4
+#define  PCI_IDE_CAP_LINK_IDE_SUPP	0x1	/* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE_IDE_SUPP 0x2	/* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP 0x4	/* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC_SUPP 0x8 /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION_SUPP	0x10	/* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC_SUPP		0x20	/* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM_SUPP	0x40	/* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_ALG(x)	(((x) >> 8) & 0x1f) /* Supported Algorithms */
+#define  PCI_IDE_CAP_ALG_AES_GCM_256	0	/* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM(x)		(((x) >> 13) & 0x7) /* Number of TCs Supported for Link IDE */
+#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Number of Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_TEE_LIMITED_SUPP   0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL		0x8
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
+#define PCI_IDE_LINK_STREAM		0xC
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+/* Link IDE Stream Control Register */
+#define  PCI_IDE_LINK_CTL_EN		0x1	/* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x)(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x)(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100	/* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC(x)	(((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG(x)	(((x) >> 14) & 0x1f) /* Selected Algorithm */
+#define  PCI_IDE_LINK_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
+/* Link IDE Stream Status Register */
+#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Message */
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP_BLOCKS_NUM(x)	((x) & 0xf) /* Number of Address Association Register Blocks */
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL_EN		0x1	/* Selective IDE Stream Enable */
+#define  PCI_IDE_SEL_CTL_TX_AGGR_NPR(x)	(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
+#define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)	(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_SEL_CTL_PCRC_EN	0x100	/* PCRC Enable */
+#define  PCI_IDE_SEL_CTL_PART_ENC(x)	(((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
+#define  PCI_IDE_SEL_CTL_ALG(x)		(((x) >> 14) & 0x1f) /* Selected Algorithm */
+#define  PCI_IDE_SEL_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
+#define  PCI_IDE_SEL_CTL_DEFAULT	0x400000 /* Default Stream */
+#define  PCI_IDE_SEL_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
+#define  PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Message */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1_LIMIT(x)	(((x) >> 8) & 0xffff) /* RID Limit */
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2_VALID	0x1	/* Valid */
+#define  PCI_IDE_SEL_RID_2_BASE(x)	(((x) >> 8) & 0xffff) /* RID Base */
+#define  PCI_IDE_SEL_RID_2_SEG_BASE(x)	(((x) >> 24) & 0xff) /* Segmeng Base */
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_BLOCKS_NUM */
+#define  PCI_IDE_SEL_ADDR_1_VALID	0x1	/* Valid */
+#define  PCI_IDE_SEL_ADDR_1_BASE_LOW(x)	(((x) >> 8) & 0xfff) /* Memory Base Lower */
+#define  PCI_IDE_SEL_ADDR_1_LIMIT_LOW(x)(((x) >> 20) & 0xfff) /* Memory Limit Lower */
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-ecaps.c b/ls-ecaps.c
index e73eb14..b40ba72 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1488,6 +1488,195 @@ cap_doe(struct device *d, int where)
 	 FLAG(l, PCI_DOE_STS_OBJECT_READY));
 }
 
+static const char *offstr(char *buf, u32 off)
+{
+    if (verbose < 3)
+        return "";
+
+    sprintf(buf, "[%x]", off);
+    return buf;
+}
+
+static const char *ide_alg(char *buf, size_t len, u32 l)
+{
+    const char *algo[] = { "AES-GCM-256-96b" }; // AES-GCM 256 key size, 96b MAC
+
+    if (l == 0)
+        snprintf(buf, len, "%s", algo[l]);
+    else
+        snprintf(buf, len, "%s", "reserved");
+    return buf;
+}
+
+static void
+cap_ide(struct device *d, int where)
+{
+    const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
+    const char *stream_state[] = { "insecure", "secure" };
+    const char *aggr[] = { "-", "=2", "=4", "=8" };
+    u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
+    char buf1[16], buf2[16], offs[16];
+
+    printf("Integrity & Data Encryption\n");
+
+    if (verbose < 2)
+        return;
+
+    if (!config_fetch(d, where + PCI_IDE_CAP, 8))
+      {
+        printf("\t\t<unreadable>\n");
+        return;
+      }
+
+    l = get_conf_long(d, where + PCI_IDE_CAP);
+    if (l & PCI_IDE_CAP_LINK_IDE_SUPP)
+        linknum = PCI_IDE_CAP_LINK_TC_NUM(l) + 1;
+    if (l & PCI_IDE_CAP_SELECTIVE_IDE_SUPP)
+        selnum = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(l) + 1;
+
+    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c Alg='%s' TCs=%d TeeLim%c\n",
+      linknum,
+      selnum,
+      FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
+      FLAG(l, PCI_IDE_CAP_PARTIAL_HEADER_ENC_SUPP),
+      FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
+      FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
+      FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP),
+      ide_alg(buf2, sizeof(buf2), PCI_IDE_CAP_ALG(l)),
+      PCI_IDE_CAP_LINK_TC_NUM(l) + 1,
+      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP)
+      );
+
+    l = get_conf_long(d, where + PCI_IDE_CTL);
+    printf("\t\tIDECtl: FTEn%c\n",
+      FLAG(l, PCI_IDE_CTL_FLOWTHROUGH_IDE));
+
+    // The rest of the capability is variable length arrays
+    off = where + PCI_IDE_LINK_STREAM;
+
+    // Link IDE Register Block repeated 0 to 8 times
+    if (linknum)
+      {
+        if (!config_fetch(d, off, 8 * linknum))
+          {
+            printf("\t\t<unreadable>\n");
+            return;
+          }
+        for (i = 0; i < linknum; ++i)
+          {
+            // Link IDE Stream Control Register
+            l = get_conf_long(d, off);
+            printf("\t\t%sLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
+              offstr(offs, off),
+              i,
+              FLAG(l, PCI_IDE_LINK_CTL_EN),
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
+              FLAG(l, PCI_IDE_LINK_CTL_EN),
+              TABLE(hdr_enc_mode, PCI_IDE_LINK_CTL_PART_ENC(l), buf1),
+              ide_alg(buf2, sizeof(buf2), PCI_IDE_LINK_CTL_ALG(l)),
+              PCI_IDE_LINK_CTL_TC(l),
+              PCI_IDE_LINK_CTL_ID(l)
+              );
+            off += 4;
+
+            /* Link IDE Stream Status Register */
+            l = get_conf_long(d, off);
+            printf("\t\t%sLinkIDE#%d Sta: Status=%s RecvChkFail%c\n",
+              offstr(offs, off),
+              i,
+              TABLE(stream_state, PCI_IDE_LINK_STS_STATUS(l), buf1),
+              FLAG(l, PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK));
+            off += 4;
+          }
+      }
+
+    for (i = 0; i < selnum; ++i)
+      {
+        // Fetching Selective IDE Stream Capability/Control/Status/RID1/RID2
+        if (!config_fetch(d, off, 20))
+          {
+            printf("\t\t<unreadable>\n");
+            return;
+          }
+
+        // Selective IDE Stream Capability Register
+        l = get_conf_long(d, off);
+        printf("\t\t%sSelectiveIDE#%d Cap: RID#=%d\n",
+          offstr(offs, off),
+          i,
+          PCI_IDE_SEL_CAP_BLOCKS_NUM(l));
+        off += 4;
+        addrnum = PCI_IDE_SEL_CAP_BLOCKS_NUM(l);
+
+        // Selective IDE Stream Control Register
+        l = get_conf_long(d, off);
+
+        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
+          offstr(offs, off),
+          i,
+          FLAG(l, PCI_IDE_SEL_CTL_EN),
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
+          FLAG(l, PCI_IDE_SEL_CTL_PCRC_EN),
+          TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
+          ide_alg(buf2, sizeof(buf2), PCI_IDE_SEL_CTL_ALG(l)),
+          PCI_IDE_SEL_CTL_TC(l),
+          PCI_IDE_SEL_CTL_ID(l),
+          (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
+          );
+        off += 4;
+
+        // Selective IDE Stream Status Register
+        l = get_conf_long(d, off);
+        printf("\t\t%sSelectiveIDE#%d Sta: %s RecvChkFail%c\n",
+          offstr(offs, off),
+          i ,
+          TABLE(stream_state, PCI_IDE_SEL_STS_STATUS(l), buf1),
+          FLAG(l, PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK));
+        off += 4;
+
+        // IDE RID Association Registers
+        l = get_conf_long(d, off);
+        l2 = get_conf_long(d, off + 4);
+
+        printf("\t\t%sSelectiveIDE#%d RID: Valid%c Base=%x Limit=%x SegBase=%x\n",
+          offstr(offs, off),
+          i,
+          FLAG(l2, PCI_IDE_SEL_RID_2_VALID),
+          PCI_IDE_SEL_RID_2_BASE(l2),
+          PCI_IDE_SEL_RID_1_LIMIT(l),
+          PCI_IDE_SEL_RID_2_SEG_BASE(l2));
+        off += 8;
+
+        if (!config_fetch(d, off, addrnum * 12))
+          {
+            printf("\t\t<unreadable>\n");
+            return;
+          }
+
+        // IDE Address Association Registers
+        for (j = 0; j < addrnum; ++j)
+          {
+            u64 limit, base;
+
+            l = get_conf_long(d, off);
+            limit = get_conf_long(d, off + 4);
+            base = get_conf_long(d, off + 8);
+            printf("\t\t%sSelectiveIDE#%d RID#%d: Valid%c Base=%lx Limit=%lx\n",
+              offstr(offs, off),
+              i,
+              j,
+              FLAG(l, PCI_IDE_SEL_ADDR_1_VALID),
+              (base << 32) | PCI_IDE_SEL_ADDR_1_BASE_LOW(l),
+              (limit << 32) | PCI_IDE_SEL_ADDR_1_LIMIT_LOW(l));
+            off += 12;
+          }
+      }
+}
+
 void
 show_ext_caps(struct device *d, int type)
 {
@@ -1641,6 +1830,9 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_DOE:
 	    cap_doe(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_IDE:
+	    cap_ide(d, where);
+	    break;
 	  default:
 	    printf("Extended Capability ID %#02x\n", id);
 	    break;
diff --git a/setpci.c b/setpci.c
index d2df573..7b7baea 100644
--- a/setpci.c
+++ b/setpci.c
@@ -396,6 +396,7 @@ static const struct reg_name pci_reg_names[] = {
   { 0x20027,	0, 0, 0x0, "ECAP_LMR" },
   { 0x20028,	0, 0, 0x0, "ECAP_HIER_ID" },
   { 0x20029,	0, 0, 0x0, "ECAP_NPEM" },
+  { 0x20030,	0, 0, 0x0, "ECAP_IDE" },
   {       0,    0, 0, 0x0, NULL }
 };
 
diff --git a/tests/cap-ide b/tests/cap-ide
new file mode 100644
index 0000000..01a9e09
--- /dev/null
+++ b/tests/cap-ide
@@ -0,0 +1,346 @@
+e1:00.0 Class 0800: Device aaaa:bbbb
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Interrupt: pin ? routed to IRQ 255
+	Region 0: Memory at 20014000000 (64-bit, prefetchable) [disabled]
+	Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
+	Region 2: Memory at 20018013000 (64-bit, prefetchable) [disabled]
+	Region 3: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
+	Expansion ROM at dc2c0000 [disabled]
+	Capabilities: [40] Power Management version 3
+		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
+		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W TEE-IO+
+		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
+			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
+			MaxPayload 512 bytes, MaxReadReq 512 bytes
+		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
+		LnkCap:	Port #0, Speed 32GT/s, Width x16, ASPM not supported
+			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
+		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 32GT/s, Width x16
+			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
+			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS- TPHComp- ExtTPHComp-
+			 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS+
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
+			 AtomicOpsCtl: ReqEn-
+			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
+			 10BitTagReq+ OBFF Disabled, EETLPPrefixBlk-
+		LnkCap2: Supported Link Speeds: 2.5-32GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
+		LnkCtl2: Target Link Speed: 32GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
+			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
+			 Retimer- 2Retimers- CrosslinkRes: unsupported
+	Capabilities: [100 v2] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
+			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+		HeaderLog: 00000000 00000000 00000000 00000000
+	Capabilities: [148 v1] Single Root I/O Virtualization (SR-IOV)
+		IOVCap:	Migration- 10BitTagReq+ IntMsgNum 0
+		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+ 10BitTagReq-
+		IOVSta:	Migration-
+		Initial VFs: 4, Total VFs: 4, Number of VFs: 0, Function Dependency Link: 00
+		VF offset: 32, stride: 1, Device ID: 50a5
+		Supported Page Size: 00000553, System Page Size: 00000001
+		Region 0: Memory at 000001fff8000000 (64-bit, prefetchable)
+		Region 2: Memory at 000002001800c000 (64-bit, prefetchable)
+		VF Migration: offset: 00000000, BIR: 0
+	Capabilities: [188 v1] Alternative Routing-ID Interpretation (ARI)
+		ARICap:	MFVC- ACS-, Next Function: 1
+		ARICtl:	MFVC- ACS-, Function Group: 0
+	Capabilities: [1c0 v1] Secondary PCI Express
+		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
+		LaneErrStat: 0
+	Capabilities: [3b0 v1] Physical Layer 16.0 GT/s <?>
+	Capabilities: [400 v1] Lane Margining at the Receiver
+		PortCap: Uses Driver-
+		PortSta: MargReady+ MargSoftReady-
+	Capabilities: [450 v1] Access Control Services
+		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
+		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
+	Capabilities: [460 v1] Physical Layer 32.0 GT/s <?>
+	Capabilities: [5f0 v1] Process Address Space ID (PASID)
+		PASIDCap: Exec+ Priv+, Max PASID Width: 10
+		PASIDCtl: Enable+ Exec- Priv-
+	Capabilities: [830 v1] Integrity & Data Encryption
+		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
+		IDECtl: FTEn-
+		SelectiveIDE#0 Cap: RID#=1
+		SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0
+		SelectiveIDE#0 Sta: insecure RecvChkFail-
+		SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0
+		SelectiveIDE#0 RID#0: Valid- Base=0 Limit=0
+	Capabilities: [e00 v2] Data Object Exchange
+		DOECap: IntSup-
+		DOECtl: IntEn-
+		DOESta: Busy- IntSta- Error- ObjectReady-
+00: aa aa bb bb 00 00 10 00 00 00 00 08 10 00 80 00
+10: 0c 00 00 14 00 02 00 00 0c 30 01 18 00 02 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+30: 00 00 2c dc 40 00 00 00 00 00 00 00 ff 00 00 00
+40: 01 70 03 da 08 00 00 00 05 70 80 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 11 70 00 00 40 00 00 00 50 00 00 00 00 00 00 00
+70: 10 00 02 00 23 80 2c 51 57 29 09 00 05 f1 43 00
+80: 40 00 05 11 00 00 00 00 00 00 00 00 00 00 00 00
+90: 00 00 00 00 90 0b 73 00 00 14 00 00 3e 00 80 01
+a0: 05 00 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 01 00 82 14 00 00 00 00 00 00 00 00 30 60 47 10
+110: 00 20 00 00 00 20 00 00 00 00 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+140: 00 00 00 00 00 00 00 00 10 00 81 18 04 00 00 00
+150: 10 00 00 00 04 00 04 00 00 00 00 00 20 00 01 00
+160: 00 00 a5 50 53 05 00 00 01 00 00 00 0c 00 00 f8
+170: ff 01 00 00 0c c0 00 18 00 02 00 00 00 00 00 00
+180: 00 00 00 00 00 00 00 00 0e 00 01 1c 00 01 00 00
+190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1c0: 19 00 01 3b 00 00 00 00 00 00 00 00 00 75 00 79
+1d0: 00 79 00 79 00 79 00 79 00 79 00 76 00 74 00 79
+1e0: 00 79 00 79 00 79 00 79 00 79 00 79 00 00 00 00
+1f0: 02 00 01 3a 00 00 00 00 00 00 00 00 00 00 00 00
+200: 00 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
+210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3a0: 25 00 01 3b 01 00 00 80 01 00 00 80 00 00 00 00
+3b0: 26 00 01 40 00 00 00 00 00 00 00 00 0f 00 00 00
+3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3d0: 40 40 50 40 40 40 40 50 40 50 40 40 40 40 40 40
+3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+400: 27 00 01 45 00 00 01 00 38 9c 00 00 38 9c 00 00
+410: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00
+420: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00
+430: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00
+440: 38 9c 00 00 38 9c 00 00 00 00 00 00 00 00 00 00
+450: 0d 00 01 46 00 00 00 00 00 00 00 00 00 00 00 00
+460: 2a 00 01 5f 00 01 00 00 00 00 00 00 0f 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+480: 40 40 40 60 60 50 50 50 50 50 50 60 50 50 60 50
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5f0: 1b 00 01 83 06 10 01 00 00 00 00 00 00 00 00 00
+600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+830: 30 00 01 e0 42 e0 00 01 00 00 00 00 01 00 00 00
+840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e00: 2e 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
+e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
-- 
2.41.0


