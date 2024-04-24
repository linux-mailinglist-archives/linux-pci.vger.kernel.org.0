Return-Path: <linux-pci+bounces-6613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8B8B0725
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 12:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3314DB213D3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFE158D9A;
	Wed, 24 Apr 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k7qZjpBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCE159592
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954045; cv=fail; b=KjorArdlU3cfB8yhiAFLgZ8Ys5VPeI36uxC2j4TKMdtv1xx9fwdlnRpztVTXlLbZHVdzLHdoHCQIOzvRsV4TiVMAcVCyFQgcb8toHiIu5lxWteN0ByFRXe5wJTsg9WyoKbNxdeoGl8gv6Gei0f+7Em95YrKjXJVqdPcVC7ACB28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954045; c=relaxed/simple;
	bh=XJj0hTky3zt9EccBK+vrD2anRRy4tuHexKC8QkoOhi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HzjohX0/thRaIr8nlIaqNo8DSgv+n6R5NG2BNWE2Cdi+Z54aCioTxvCS9EmniaT1GZYokgbHi71tMzX5KX/Koi1nL2F/UT5gFLEiuhIIKv1iiqa4k322bgd9igY34GXcmyqt54f79eblFQI/+l6WW/5vbMTxZiwhx2erg1VjUKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k7qZjpBo; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpJX4pMiMV3kEp3MXCjWtXNZPZCYUSS1i/sXd7XCJREpjXKwcYvx160XLfM0orEwNJGktNZZeBY9XzSgbH26DBR/4UBfTd8FV9AC9/Aia2c+y+5RF7HnLUjuoXkQoRKuwUOx1PHKihM8uzTj9BZkqRRsKg0o/Z4gI9/y5VeEyVcebKaA902jV7uMQaGgQw454GGz4FejuAgqiu59Pzmdrf7U/zYS+3pVoHvpkLJX3rRVMBviZs43CHdar5Xh3Y4dI2ZZ2RxZXIbPbNaSiljoXwi9ejLCCuL2sVDQZU4mBvAQKv2RkXkagrPo1blvj1v3H4zOba1WB2H/Z1nqCzF4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DMooJliNxAiIw4hfMPXmQrtIWDl96H6nIsXDSvB644=;
 b=U63kEXSwiqGp9S+bWgBxbivQ/YjKXaZNJpc6r0PrsoTXY+wTXgSE22FOQJJM0CH43AjDfZB11ABM3fT8RXNeQZ2UmcRpwFywoMu0wFQni2i5FhM30vzC+7A+i8KO22XgXpv+e05VMbIDvi+O+2qCyX23WzDA3yh2QNp5ST1alD45mQNPItXtXeMnrg+xDvp/yRtf23JIqR4FD1VPCapdqgsopT6A32CkzsTU2lnQ5jW7WFZbPlF6tj3bN7IBT8OvhtPmjB6PikU0FELRiPOA16eNjITGuBRWSPCMfZ0xQuvul9wLx5oHsjaI4OySordmtKht7Y3qSoibXZdlPXzNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DMooJliNxAiIw4hfMPXmQrtIWDl96H6nIsXDSvB644=;
 b=k7qZjpBorq6/mnJgClVFsakMZ2vuR67mB9INDmcjry0tk51RRvj3PLq6nWu0XRBbmV3PNYVJ//nxpXmRMCvsw9LWPX2CTEmuUgEMspEFylMNSPIlqp06i5x2YV/v3Hf1lE6u3TsXG0BTBQISBrr78me3nCN7+nxhoztK4roAz1o=
Received: from CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 10:20:41 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::94) by CH2PR18CA0048.outlook.office365.com
 (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 10:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 10:20:41 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:20:39 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH pciutils v3] ls-ecaps: Correct the link state reporting
Date: Wed, 24 Apr 2024 20:20:11 +1000
Message-ID: <20240424102011.1706839-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f466953-27d2-45d7-ae97-08dc6448319f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sG+jPlEj54bIAHQ61ZM+BkNwBPgmf96borR51nFi7zEYA6ij60EAHBLVFRn?=
 =?us-ascii?Q?UXBklm+0C/VIX81sCh5pF87VQ54k02ZbUNxi6tVJrBla2e/3o/YLKlofpyph?=
 =?us-ascii?Q?HBAGSMSbH8eQ9H63LGlGTfCl9aXUknfDgyXR5HYiGLoqluPyHAtx85aIbUc/?=
 =?us-ascii?Q?jPYcaXBG0gOpP2/1nuJB7Ft9lWZOjZ+K5VHOnvDJOyQM9CA50DW+nwXQrhIF?=
 =?us-ascii?Q?wrJVZkJkOWWAK1GR1+BsCohgqXApCuqq+ilrMuPy/U+g5+oDL+jsyp5KvzCS?=
 =?us-ascii?Q?kzUPsqztmii2dyEOC6AELeNl8xC2y4Nf2ZZ266uI3+066OYgLltVE72kCHQ2?=
 =?us-ascii?Q?WKhzxmx3NHyhJcfh9hc+ipWzESr7aLodiECJIbF2HyXRNwuhxjrdiKhzVm8D?=
 =?us-ascii?Q?aOv2mHervugKJU5NmSVebL4iw0cMvxVU4L2MvhfyVdoc7ZDgOoRo07Ee7FX4?=
 =?us-ascii?Q?2EUFSuI9b1L0FAtqD+EW3IXjZBHhxlD/FGXSs1+4QSPaAZvEU6Grr5/iqu2B?=
 =?us-ascii?Q?NtremSowlaMqatHDcpQmU2uPirLOcXaWQyu3wyVS6BLuWb5WejKOA/XTQ18+?=
 =?us-ascii?Q?gGiaVtmPpmX6Vp6p308rDkE4w2NdQPFoR8nZ6j1LXhfATJKB3pNX9Qb0E5JD?=
 =?us-ascii?Q?Y/irHIErMu5pJWp1fld6VMuzbxkPNXG7zRxeAnAhXVQ7x8GMuaALDcn9RFuN?=
 =?us-ascii?Q?pqG2+MJs80o9125skeenqUNM1TE+3YVW02Q5D86y22mtg/GHXYXIlW9mv5LT?=
 =?us-ascii?Q?ocOJGBNnd3FVzYWIIs4cCpBU+EF7+AX3Ik/7WC0ORVIwUxyQA8hUUALVCog9?=
 =?us-ascii?Q?DwBwrEchxscWrxyLu7JFRMEPOafQp8mxJ65yshsR/Zf6vkqPGDapzxMTC/BD?=
 =?us-ascii?Q?9M64vtmHatZrhrtx96hhrbL09PH7ahVlOuwqYfAFPu6A3z40TQnOKz/4HBl3?=
 =?us-ascii?Q?MrXifYePCgJgm1NCGEyzXR2Y1tINt6CzjNnXNZJ7NfelBIWOWCEgDBX2oAPG?=
 =?us-ascii?Q?b2TVmIxJlhVbyU5+4MYo84GCJ2RAX1xT8vNatgZGfALByi0WlN1PpS5pWD6f?=
 =?us-ascii?Q?tvpuuspli1oAwBA+7Zw+Ym3BuyVDRqNz29WDW1Zn4NtgDNL5erYG32T74mEd?=
 =?us-ascii?Q?5bXxFMu+jOmStX5WQ7/XxchzSz3lVgrh+sJuposbioDDRcimo+cUs9WEJoeO?=
 =?us-ascii?Q?G8vMAexglIT+Pn4I2m+aEp/CpNgcM5w4O+lTwjCqsPUoJXaRxo4St2IyPx4F?=
 =?us-ascii?Q?NE/TXEAOlmdpcdz2lZaGMepgxUqrYNEQFIvzOqgzA+MBSV8lGSglOhlLMY93?=
 =?us-ascii?Q?2IaAnL5pnxQFdiYwPac2hfAoG2OGwJ4qWbibwi6Uf8g2L0V/h3PxOuGmwLGb?=
 =?us-ascii?Q?5aWycGVAfQOCdORFH9VUmKQkh7/u?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:20:41.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f466953-27d2-45d7-ae97-08dc6448319f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251

PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
the link state as:

0000b Insecure
0010b Secure

The same definition applies to selective streams as well.
The existing code wrongly assumes "secure" is 0001b, fix that for both
link and selective streams.

While at this, add missing "Selective IDE for Configuration Requests Enable".
Also fix the base and limit parsing for the memory and RID ranges.

Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
v3:
* added clause about memory/rid ranges

v2:
* fixed memory and RID base/limit values parsing
* added missing "IDE for Configuration Requests Enable"
* fixed the example
---
 lib/header.h  |  1 +
 ls-ecaps.c    | 13 +++++++++----
 tests/cap-ide | 12 ++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 0b0ed9a..031912f 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1464,6 +1464,7 @@
 #define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
 #define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)	(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
 #define  PCI_IDE_SEL_CTL_PCRC_EN	0x100	/* PCRC Enable */
+#define  PCI_IDE_SEL_CTL_CFG_EN         0x200   /* Selective IDE for Configuration Requests Enable */
 #define  PCI_IDE_SEL_CTL_PART_ENC(x)	(((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
 #define  PCI_IDE_SEL_CTL_ALG(x)		(((x) >> 14) & 0x1f) /* Selected Algorithm */
 #define  PCI_IDE_SEL_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index b40ba72..2340084 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1512,7 +1512,7 @@ static void
 cap_ide(struct device *d, int where)
 {
     const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
-    const char *stream_state[] = { "insecure", "secure" };
+    const char *stream_state[] = { "insecure", "reserved", "secure" };
     const char *aggr[] = { "-", "=2", "=4", "=8" };
     u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
     char buf1[16], buf2[16], offs[16];
@@ -1613,7 +1613,7 @@ cap_ide(struct device *d, int where)
         // Selective IDE Stream Control Register
         l = get_conf_long(d, off);
 
-        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
+        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
           offstr(offs, off),
           i,
           FLAG(l, PCI_IDE_SEL_CTL_EN),
@@ -1621,6 +1621,7 @@ cap_ide(struct device *d, int where)
           aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
           aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
           FLAG(l, PCI_IDE_SEL_CTL_PCRC_EN),
+          FLAG(l, PCI_IDE_SEL_CTL_CFG_EN),
           TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
           ide_alg(buf2, sizeof(buf2), PCI_IDE_SEL_CTL_ALG(l)),
           PCI_IDE_SEL_CTL_TC(l),
@@ -1664,14 +1665,18 @@ cap_ide(struct device *d, int where)
 
             l = get_conf_long(d, off);
             limit = get_conf_long(d, off + 4);
+            limit <<= 32;
+            limit |= (PCI_IDE_SEL_ADDR_1_LIMIT_LOW(l) << 20) | 0xFFFFF;
             base = get_conf_long(d, off + 8);
+            base <<= 32;
+            base |= PCI_IDE_SEL_ADDR_1_BASE_LOW(l) << 20;
             printf("\t\t%sSelectiveIDE#%d RID#%d: Valid%c Base=%lx Limit=%lx\n",
               offstr(offs, off),
               i,
               j,
               FLAG(l, PCI_IDE_SEL_ADDR_1_VALID),
-              (base << 32) | PCI_IDE_SEL_ADDR_1_BASE_LOW(l),
-              (limit << 32) | PCI_IDE_SEL_ADDR_1_LIMIT_LOW(l));
+              base,
+              limit);
             off += 12;
           }
       }
diff --git a/tests/cap-ide b/tests/cap-ide
index 01a9e09..edae551 100644
--- a/tests/cap-ide
+++ b/tests/cap-ide
@@ -79,10 +79,10 @@ e1:00.0 Class 0800: Device aaaa:bbbb
 		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
 		IDECtl: FTEn-
 		SelectiveIDE#0 Cap: RID#=1
-		SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0
-		SelectiveIDE#0 Sta: insecure RecvChkFail-
-		SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0
-		SelectiveIDE#0 RID#0: Valid- Base=0 Limit=0
+		SelectiveIDE#0 Ctl: En+ NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0 Default
+		SelectiveIDE#0 Sta: secure RecvChkFail-
+		SelectiveIDE#0 RID: Valid+ Base=0 Limit=ffff SegBase=0
+		SelectiveIDE#0 RID#0: Valid+ Base=0 Limit=ffffffffffffffff
 	Capabilities: [e00 v2] Data Object Exchange
 		DOECap: IntSup-
 		DOECtl: IntEn-
@@ -219,8 +219,8 @@ f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 830: 30 00 01 e0 42 e0 00 01 00 00 00 00 01 00 00 00
-840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+840: 01 00 40 00 02 00 00 00 00 ff ff 00 01 00 00 00
+850: 01 00 f0 ff ff ff ff ff 00 00 00 00 00 00 00 00
 860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-- 
2.41.0


