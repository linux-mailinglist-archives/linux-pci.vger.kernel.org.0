Return-Path: <linux-pci+bounces-1567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9A820615
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 13:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62A22820E6
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C596D6E6;
	Sat, 30 Dec 2023 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6KgGxid"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F68487
	for <linux-pci@vger.kernel.org>; Sat, 30 Dec 2023 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGOEH0meDstv9lEfIgbqANb9UNfhTiGr5ICpVQvKrW0zzwh/t/aDzAMFw26eJacbhFtW3WKyUXBU8iHrO7ZTq38sH8rj2o/SywYQ3ZNVloUztckI9MRIfa8bfcva20xswDjx1AdFjvqpiOKXDHuESYR7rA1UtZYkx/MZigb/PvcSNbnoRZBFxih04WdzYRDp/2vCzWXPbYBJpgyeblz9HjBNDufEEgqxOz2Qr73Rgpyn5t3LEjOZD4lc2VfMSzL5sOZwPHNzPAA9NlPPWDiL1F9KDJBpj46NLxklV9MQzRBJTm20cwl8y+BQLjD0DEpsLCa3DY5JgpJAsxin5MXj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cccppMB/In1xPzfA7SkxWCZVhhUKAqXpBHfQqTCT3TY=;
 b=dC5yQteozdUobj97NiMkZxeWuBwvoiNMr/lh2xQtGnrVDDpCYK2FdIBvl26WCOT6+u91s8tXDOacHEFjMswrR1xlUDqdz68djMKNnqvYD0biSvXhZPPK4uo2TSzL5lQpLjiRWMuCZ10MoJGm3/cfEb6RIEwCWt5TDizTrGCIOmOWgS3IWVnIIyvX+pTN+FM8bQYKJhAEOqxv/2ycypPmDuuqxL8IFWMJ/238KqzO9jV0gtmFIfXLycsMc5yvZtXeibEPwC0WRO/fYVx9d672jQ3EAwU7wDifv/kQsaRZmrqyWprHWTTApBAT4V74/rPgQmIROAY9XEcnWhRYaacPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cccppMB/In1xPzfA7SkxWCZVhhUKAqXpBHfQqTCT3TY=;
 b=z6KgGxidBXHKAEg3FxVaCDmEzGRlopF4s5co+Kh4Yba1RIOuO9qvYtWmqZsb0fhHo8LaSQ1s51E3UwvNQ5Bzf5yHgaApxzULOPWcFLq9hs7ws/TZ74qMXRQcfmlxtZAFio9YT1C/6yu1DNWqUMyA+lLGDR8koNrJ/Pw+7eLuJHA=
Received: from DS7PR05CA0066.namprd05.prod.outlook.com (2603:10b6:8:57::11) by
 SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 12:43:34 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::2d) by DS7PR05CA0066.outlook.office365.com
 (2603:10b6:8:57::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.8 via Frontend
 Transport; Sat, 30 Dec 2023 12:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Sat, 30 Dec 2023 12:43:34 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 30 Dec
 2023 06:43:31 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <linux-pci@vger.kernel.org>, =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH pciutils 2/2] pciutils: Add decode support for IDE Extended Capability
Date: Sat, 30 Dec 2023 23:42:39 +1100
Message-ID: <20231230124239.310927-3-aik@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231230124239.310927-1-aik@amd.com>
References: <20231230124239.310927-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7083e4-c226-4993-fc9d-08dc0934efd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gGphfNJ1DbwNoHQYtDtorTg/loLIoEGp68SSPEmTNitZ6UIW/fZbtd4kdTjhNkIAh2ebUoJicAjVtyu5R3IN0PourxL+4MgkQHXEiY7BB/NcgBsYfAvwlDtbXm+Ak82LMJsOratEljwqOHIQg0QD2EwVk0P+2LIr3BCFE/V3hcnOaXKquDuoOEosjXCyvS29ke+M8Ush2zfZUkUI4m0I5ilPTqHQGP0YlKX1lH1YqjxFccM0oehjMHjWRTyF/3REnDwzzCHlCdGLPf51ad5xEiO2aZi+Gy+KcOhDAwLNK24P7xZYqgBWGLTKsedOaRE7A93JOmIEt8ELo58sB6Y4vrlhyBWegiJu7v1fR6xGN9e/8v1tKz+gW62WtDLmF/zID89sY0U4Mo25latqgDeTbaeWblI+fCluQ7SSQOk39aChDCXyPfygBUC6wopDvSECJb3hFaM74o3pDPxzJBpmuY3OdeVHy0xFR7VrcsjtLIc92xh4ZlDJBACgrS+d/EuXbHpZTvWPRmsr9jumoNkW9OEO6qlaCLgvQ2FPj2p3l0AOk1IPb9o3sK4HOjE0gEUL0ziXgc8eXYLYS/+MlQj4ufmD+fDEceG8LWYLMFDOznPQE4Pp4AVQC0lb/O/knQafW42hYCY4DIRVNb32aJhoZBq7k19ejgmDw5WWD1lkiCl2eMEEdz5iSMQnV++Q8i+3BDTRjJqJmUvvNFj+To6XMir0tJQMfIIoba5gmLnY8L0vewQHX8ibmvK8AEZOIUV1XCTbYrYZGWky5nbQfyhGnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(316002)(6200100001)(30864003)(5660300002)(40480700001)(7049001)(6862004)(8936002)(83380400001)(36860700001)(336012)(8676002)(426003)(16526019)(26005)(2616005)(1076003)(81166007)(356005)(4326008)(47076005)(19627235002)(41300700001)(82740400003)(54906003)(37006003)(36756003)(478600001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 12:43:34.5779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7083e4-c226-4993-fc9d-08dc0934efd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613

IDE (Integrity & Data Encryption) Extended Capability defined in [1]
implements control of the PCI link encryption.

The example output is:

Capabilities: [830 v1] IDE
	IDECap: Lnk=1 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+
	IDECtl: IntEn-
	LinkIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM 256 key size, 96b MAC' TC0 ID0
	LinkIDE#0 Sta: Status=secure RecvChkFail-
	SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM 256 key size, 96b MAC' TC0 ID0
	SelectiveIDE#0 Sta: insecure RecvChkFail-
	SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0

[1] PCIe r6.0.1, sections 6.33, 7.9.26

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 lib/header.h |  61 ++++++++
 ls-ecaps.c   | 162 ++++++++++++++++++++
 2 files changed, 223 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 47ee8a6..5df2f57 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -256,6 +256,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_32GT	0x2a	/* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2e	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_IDE	0x30	/* IDE */
 
 /*** Definitions of capabilities ***/
 
@@ -1416,6 +1417,66 @@
 #define  PCI_DOE_STS_ERROR		0x4	/* DOE Error */
 #define  PCI_DOE_STS_OBJECT_READY	0x80000000 /* Data Object Ready */
 
+/* IDE Extended Capability */
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
index 2d7d827..9f6c3f8 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1468,6 +1468,165 @@ cap_doe(struct device *d, int where)
 	 FLAG(l, PCI_DOE_STS_OBJECT_READY));
 }
 
+static void
+cap_ide(struct device *d, int where)
+{
+    const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
+    const char *algo[] = { "AES-GCM 256 key size, 96b MAC" };
+    const char *stream_state[] = { "insecure", "secure" };
+    const char *aggr[] = { "-", "=2", "=4", "=8" };
+    u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
+    char buf1[16], buf2[16];
+
+    printf("IDE\n");
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
+    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c\n",
+      linknum,
+      selnum,
+      FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
+      FLAG(l, PCI_IDE_CAP_PARTIAL_HEADER_ENC_SUPP),
+      FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
+      FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
+      FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP));
+
+    l = get_conf_long(d, where + PCI_IDE_CTL);
+    printf("\t\tIDECtl: IntEn%c\n",
+      FLAG(l, PCI_IDE_CTL_FLOWTHROUGH_IDE));
+
+    // The rest of the capability is variable length arrays
+    off = where + PCI_IDE_CAP + PCI_IDE_LINK_STREAM;
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
+            off += 4;
+            printf("\t\tLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
+              i,
+              FLAG(l, PCI_IDE_LINK_CTL_EN),
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
+              aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
+              FLAG(l, PCI_IDE_LINK_CTL_EN),
+              TABLE(hdr_enc_mode, PCI_IDE_LINK_CTL_PART_ENC(l), buf1),
+              TABLE(algo, PCI_IDE_LINK_CTL_ALG(l), buf2),
+              PCI_IDE_LINK_CTL_TC(l),
+              PCI_IDE_LINK_CTL_ID(l)
+              );
+
+            /* Link IDE Stream Status Register */
+            l = get_conf_long(d, off);
+            off += 4;
+            printf("\t\tLinkIDE#%d Sta: Status=%s RecvChkFail%c\n",
+              i,
+              TABLE(stream_state, PCI_IDE_LINK_STS_STATUS(l), buf1),
+              FLAG(l, PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK));
+          }
+      }
+
+    for (i = 0; i < linknum; ++i)
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
+        off += 4;
+        addrnum = PCI_IDE_SEL_CAP_BLOCKS_NUM(l);
+
+        // Selective IDE Stream Control Register
+        l = get_conf_long(d, off);
+        off += 4;
+
+        printf("\t\tSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
+          i,
+          FLAG(l, PCI_IDE_SEL_CTL_EN),
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
+          aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
+          FLAG(l, PCI_IDE_SEL_CTL_PCRC_EN),
+          TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
+          TABLE(algo, PCI_IDE_SEL_CTL_ALG(l), buf2),
+          PCI_IDE_SEL_CTL_TC(l),
+          PCI_IDE_SEL_CTL_ID(l),
+          (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
+          );
+
+        // Selective IDE Stream Status Register
+        l = get_conf_long(d, off);
+        off += 4;
+
+        printf("\t\tSelectiveIDE#%d Sta: %s RecvChkFail%c\n",
+          i,
+          TABLE(stream_state, PCI_IDE_SEL_STS_STATUS(l), buf1),
+          FLAG(l, PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK));
+
+        // IDE RID Association Registers
+        l = get_conf_long(d, off);
+        off += 4;
+        l2 = get_conf_long(d, off);
+        off += 4;
+
+        printf("\t\tSelectiveIDE#%d RID: Valid%c Base=%x Limit=%x SegBase=%x\n",
+          i,
+          FLAG(l2, PCI_IDE_SEL_RID_2_VALID),
+          PCI_IDE_SEL_RID_2_BASE(l2),
+          PCI_IDE_SEL_RID_1_LIMIT(l),
+          PCI_IDE_SEL_RID_2_SEG_BASE(l2));
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
+            off += 4;
+            limit = get_conf_long(d, off);
+            off += 4;
+            base = get_conf_long(d, off);
+            off += 4;
+            printf("\t\tSelectiveIDE#%d RID: Valid%c Base=%lx Limit=%lx\n",
+              i,
+              FLAG(l, PCI_IDE_SEL_ADDR_1_VALID),
+              (base << 32) | PCI_IDE_SEL_ADDR_1_BASE_LOW(l),
+              (limit << 32) | PCI_IDE_SEL_ADDR_1_LIMIT_LOW(l));
+          }
+      }
+}
+
 void
 show_ext_caps(struct device *d, int type)
 {
@@ -1621,6 +1780,9 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_DOE:
 	    cap_doe(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_IDE:
+	    cap_ide(d, where);
+	    break;
 	  default:
 	    printf("Extended Capability ID %#02x\n", id);
 	    break;
-- 
2.41.0


