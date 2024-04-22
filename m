Return-Path: <linux-pci+bounces-6516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007FA8ACBD2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F8F285B60
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0A146595;
	Mon, 22 Apr 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evV8XRPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841A146588
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784504; cv=fail; b=pkdStdU+9dBOJCAXalrZ/QcPlNxvPpXU4iMD0+x2Wyv+7t6DPO6boKndQiiYlBAd/R0DGxPY+ruQa/q/Yof9txWePEoIXp+0I6pJFTkk2p6WaydkMaBsjSaGYFSC+Z27p4VjWl4BCx1uvI6oxarG2csr1ot9B+jozupJRhCFxz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784504; c=relaxed/simple;
	bh=ai0jT2EttbS2hIq8t9sxuttCSMvC2UdCY+x+SIYtTUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDLnks+cSeZvKAdHvE9YI8GOIBTt9MWSduU10r1eIPw1jkIA7ozRfez6aGGxUMOQRE/YTc2miOyy2jlqekuH6G0RgDhqmNk3KAL4vpLaSwwdM9/aQiZHC5sZHDlv7GPCsCeGCRlGLrz62j/FuMhzVZ97howTGZDZtJZGDRcDbvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evV8XRPs; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFlm9ZlZGxdL5i8cnu5Qm6Iae6auox3yA3DRJXscMZN9ApjdSnNkTpv+4AF8D755NoCQBjH23D0YTWLKCEghSr+D5Yv0P1QjsjBWnaoIvF4Orl/X6I66LVZapIPkZjfAM9us3TT13ZkNxepTx9YawAWG5XmoEbb6iA9nooKAwnLrHXnZ+zEH+CaJaXQIyHX6r0ZgMjRYNv3/MtILzGDNR3rplalXtRHE3MHbLqQcW0joNrczhF73fEabl1W692WrTx4pgHeWvDVEsbJQiVDV4l1TR08G5WZw+Y2NI9+qAqKLA+wMPIf86F4LGpLwLF8DkVW+gfc0051KJRYq+zgUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN5nY7kn+hW+iz/iLhp1OHrye1mu/VpiIUCh1GqlDUE=;
 b=PFA8+f8gZgiQU3dChEXqCGfj0GrqakcXd0GDnlq/zsAyI0MSUFD4Jg2+JpFqYwWrRHscd9wh1lNeKN9pv/8lhd8PIz7+ZTjxUPp+UGjIiRSEtQRvPDZHPx9TjED9XIf2hnQuuLRvzpYBeFuSEpKGRa7esaqUK2WgjP6LJ736EPcD9E3KDGqSOHy3XM/dVOMz8NdmjhJTxCFVBqeh7ALOD1WIdclgF/dFz+t40zKwHe01Ufi+wosf8+z25DV+Om1RU+9JerAcBdurCMSjUEwFBYVbbzBqOMai0/mvs24HV7SvUut90Fj1+NxV/r6YQx2t51MlY7RuCDYT6iqevmmKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN5nY7kn+hW+iz/iLhp1OHrye1mu/VpiIUCh1GqlDUE=;
 b=evV8XRPs1IbE7zvPnbKAOGkPFg0UcCqCNZJpQmAPLAwZQazGw0SXOK+wYRMON7//zMgR0XjizvCRoPpujqlmVubuwQCKqzjWNaQ2AUSGux88L2+6orxK6Lrl23wqHWHZfFs+jTbeoXa2xANYc9O7JGRze0rXgFjpO8z2kla9rQM=
Received: from CH2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:610:38::47)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Mon, 22 Apr
 2024 11:15:00 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::b0) by CH2PR05CA0070.outlook.office365.com
 (2603:10b6:610:38::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Mon, 22 Apr 2024 11:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 11:14:59 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 06:14:57 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Alexey Kardashevskiy
	<aik@amd.com>
Subject: [PATCH pciutils v2] ls-ecaps: Correct the link state reporting
Date: Mon, 22 Apr 2024 21:14:47 +1000
Message-ID: <20240422111447.143973-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ecebd1-6fa1-47a0-5464-08dc62bd72e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twZDJQy+3Ol8UvqvG4c74tQoVAfaDpOxGwEKIaMojUAq0dh6jQicShEELnE3?=
 =?us-ascii?Q?/gkXuoOLzEpYybPoJo4ml/8o4trlqb8FtOrKRmq0fKMyVVEBYPLNjwCeqFoE?=
 =?us-ascii?Q?Dg/5KDJ+HKvkLM95FCIR3rXcDtWohGg3h2SCYOxU8ICqmVpTAFX4gk7WgiZ9?=
 =?us-ascii?Q?6yEA0p7CCaPq7jVDfqcOqplj6j/eLpMvhNADUPU3bQVhkqezQJ1qAtxMBBOR?=
 =?us-ascii?Q?lHn4ScS//eoQIHcrH+T8it4av972i1BYiSKaEEm7WmtEzb8kR2t+B1CpgSTB?=
 =?us-ascii?Q?nfJA3ShD7n2i7UN5h41WSZy76dvSGZnTBtO9JTmYjOzvBWpOkbx1SRUg2KKh?=
 =?us-ascii?Q?AwFNZLK8X6NOzMnYgHVNv609WMM/BBamQx73Gv3s9cXC2CxTx/I3c9x6Lufq?=
 =?us-ascii?Q?YVvX+1413FXC0fHV2YwKF7pHrRW7YUe4aN1eT4LWKLCw9ymOw8VVbxr/lJe8?=
 =?us-ascii?Q?fkbODKrSh9WQhDzgLE1zilYOd9aHnFu6BL/Rk9fCLH3FFEND8uS5Osu0i3FV?=
 =?us-ascii?Q?GAizaq+Q8x8XHQG+BMDuQFark3qbMeQfezUlRZ7UYYXykICeKUJVJxkARcKc?=
 =?us-ascii?Q?PD+Mw4iQ1mlMudurxlcOSpGB1794y8DKkYpYrIWfSkkR6CyJUAycRV7VxHvP?=
 =?us-ascii?Q?zzpPmy+VPeCACG6niaxPXge1YU5ckOtL8T7LnBAeuF1YDDRC2f/wgQjSTiMo?=
 =?us-ascii?Q?xi9L0Xmf+KX4KKHnKY0cyr2V9uWXfiY/8MSA3z23jJNkOgkWul8rYBpOlAKr?=
 =?us-ascii?Q?uBWbwCo3DQZxlOWezro/Tb19Eytpg3rU7MU3Yu23/VvFYENPg/DZLlbgekhH?=
 =?us-ascii?Q?ClYWRct6z6oYtbhaw0Eiovx94rhPzrq5pn6QIP3m38H6M7Aywbh6kVpMwKAR?=
 =?us-ascii?Q?LxPpoGxENzo3u4zBg3vQn/psKbnBJqRdflchqqXVJ+0Vkdlj0A/sK/+yqytN?=
 =?us-ascii?Q?mGks8qPzwSmVInM0SoiNvToaO16yvGCxl/p8wkTWAejpV+v039UL2QMPvkyG?=
 =?us-ascii?Q?ueB8bo9gbzN4tk9mCZoHK7n9a6jNMvn6h1ehnxR6Hu8eKan9vQdYpaufcndp?=
 =?us-ascii?Q?E+qEej7EAAiOG1DKHOoOLsHLCViT0nflkbv7MP4wBr2DZe7A1hpcjxP2Uhct?=
 =?us-ascii?Q?Y4KgsPVZDjiLrnZq5L4YA1zB3RGZDUxwMmPx0arRcePls8wjkVr6XNcY8IAI?=
 =?us-ascii?Q?hEQimk/nZp8Fy1sj22KYi/rVUFAFJGm8ewW3N8y77BQXyjO1j+hd66F5xc8m?=
 =?us-ascii?Q?+zj0GN7Hg7gMRWqz5pnpZqdiIenLf1Q7r8E0KtT0K0XAhTPQ6yS6AOtkPdCn?=
 =?us-ascii?Q?AtZcTliaQriZp8QMFccmopgTYj/9zj0RWhcuXonsPqsx+uxVGLlR+WpWUvgw?=
 =?us-ascii?Q?Pbd6prvZ4ZCcDsNR4VB9ujEzFcJn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:14:59.4697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ecebd1-6fa1-47a0-5464-08dc62bd72e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
the link state as:

0000b Insecure
0010b Secure

The same definition applies to selective streams as well.
The existing code wrongly assumes "secure" is 0001b, fix that for both
link and selective streams.

While at this, add missing "Selective IDE for Configuration Requests Enable".

Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
Changes:
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


