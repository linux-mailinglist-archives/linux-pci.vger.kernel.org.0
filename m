Return-Path: <linux-pci+bounces-8144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279828D6BBC
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B673B25A54
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD478C9C;
	Fri, 31 May 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ul4xMccU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB37FBA3;
	Fri, 31 May 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191566; cv=fail; b=cgkbl5DgK7/iNgKO47qybSSK7WZ2LPlp0eU5FSp40Ye4L8TAwplHQ2Ius4r63oxZyauT4Q4oqcM8wCjdy4GjDcPrs/6WFhWAMWM4t+GZoiZZpG7pODbNNpjOLP1JNlPuv+Q07agadV2r8W9lAifgOX/WXtQanEA4cx90EHCTgFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191566; c=relaxed/simple;
	bh=peZkMUNMc7CZ8IhQMFMcjFi9mhA+RU7+T60cSPEDw7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poG9YeptOIiSzIRJ1RyQ2VFcN3P8pjED2yJnLr6siQFCz1J870r4kFLrWMNDE6VBLPlj3BzKy+fRjuedOoQx2c+raeaAPwy7tiVr80kFAWJuyWeaik16w4WLxcOCqdJuYSybovrGU8x+TivUG2bihAZE+JgdlwmjW0gfzL17+4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ul4xMccU; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APYaqn9rPf1VeL/rtYh5p1xi3Zs+1ITUidv5obOlmX01vnlU07siGrSr5pccoTMOUuDvyhiByyVuu77ZO8abPmzQLuayZNH5rZUep1obZlSehVPuwPcw5OGMnuLLCLYd/f6jWb2fgU3ycstPCVcgsdAtiMAD+ljSU4EEJTezEOCS27O4JaYOv3sSdWEa2XyCe9plwMHMuk9IE9fmHCpo18AxV/f75aTqAZryA65WaM2fiSCDPqmMdke6qPsg47xcPYu14a4L5cGZRBY5h0Ch5JriedrvUJZQsS0xcJdcInOcuDDkQntCNtDK+sZ/kXN/5j7e8eyEfv3iH5C/0q8Umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6gRbxu50tgqllwlngZrnZIaLKZPG/fwRTXHfOd8cbA=;
 b=g7hTTfVtuIDsF9b25JIrvt9mT+Mac+g7D+8NlQLR+keigc2xyctxjjUDLGeFPtY1LdMQUsIy1i55yUIqqG99UWx8bKdIidjhb+Oxw/j9wA0RimjOl1RNykhGb1RfqIAEUH2RitwGJGz8hI1wkudpQaFACxjIE7fpAjZGEGYHtpvYGV33v8kp4PLTRl5YRVVwo55ugWm6MOlYecJtpUYK1QCQkKKR1jAAz3DovA4A6jC3PnmariXZ8NZt24E82iCOsjc5PoRM7lnVTfpzBDpU0mVYhqIaDgGfOWTDiQrvg/CmjoZ+1WHu2odwrBIZL2fSk9w+ijUkeZvyQ1W/cbrUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6gRbxu50tgqllwlngZrnZIaLKZPG/fwRTXHfOd8cbA=;
 b=Ul4xMccUNY641M7BbTfrpD4qvp3NVXKZKsCSo0gscO+ZQgMOE5M06K83ze67HcBtKe8niUcSSme7G8hHt9Jz2gSZU8aJ4v+klLDT0uDWIrQn9NhdVL+sz3pJIQXUGxVuF5nM/tNwWh8WDd77mZg1+Mo7jEovpHJXQapAT7h8N1k=
Received: from PH8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:510:2d2::20)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 21:39:21 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::a7) by PH8PR15CA0020.outlook.office365.com
 (2603:10b6:510:2d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 21:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:39:20 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:39:19 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 2/9] PCI: Add TPH related register definition
Date: Fri, 31 May 2024 16:38:34 -0500
Message-ID: <20240531213841.3246055-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 821a0dc3-80fb-45fa-205d-08dc81ba21ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTgNKeQpQjlZQDLdMjJwV1qsUAV5U3PgDVIUqX5Ykpogb5A3IcqkJDphyQzK?=
 =?us-ascii?Q?MHO+HsQWhIyohgBJMEetZDiU736GU4ps3Vzns4wvLkJx6SjKIensvRi4Qn80?=
 =?us-ascii?Q?sfruhltetcVscjkOHJx+zJsnj29Ts6Nzh60jt9MwvVbWtRWW136920BEh2Z0?=
 =?us-ascii?Q?+W05GI2zo2sASXrEC6AD6U7qgzDyTm04FsyFt9UHW/i9z26mR1MPK3oLkRPd?=
 =?us-ascii?Q?LwCaJMwJhasUWAr7pCETgmMOxb+LU9tv9GItsF1LWtXurUVBSrEHmYsvSinX?=
 =?us-ascii?Q?piNfiIsCX0cV7M5V9sddv/htIxjVdu7cW+kMZ3AcT76xqpsnfMOohGemQIdr?=
 =?us-ascii?Q?srd7mUrD7iKrYP1IouSDiIWE4mGaoAfA4qyrIeiOwBYcRZiKKrq0MuQ7W7Jy?=
 =?us-ascii?Q?OL/iwn0yC+95jrSxWjYX38Ht+BhpHx2e5w1Rn7BmAqGowa+LdZvXRnB/eyzR?=
 =?us-ascii?Q?48ejGbA/QWNyToEWue93Y1kgdZFkPPslkmJ+cV0OgxyZUVDOYbu8xIG3V6qf?=
 =?us-ascii?Q?FH1Rn+Eu5POt7q9UFNsJhgvbghynIidzGk7jSnjIahpfOf10Irtf4bM8wjef?=
 =?us-ascii?Q?r7hNUbn6jrKeL/J0BDV/P+H2h7Iv6WQZx5zj6XxModJRReEI8lHYDyCoc2w0?=
 =?us-ascii?Q?6fd/IbTd5kaunUR6eHIUH9iaHPpspcVZ+f1SyGjSgt+wpB5QoglQbqMR6n0V?=
 =?us-ascii?Q?R4fZt8I4BGtDU76lmkK0ziQKcBlWEE0/hmnPPHBwRCn5tnrqo08SopzOwNd4?=
 =?us-ascii?Q?QTTXTnV/mE5awKbP17SDhPlmsQHMXe6g3Ov65bCdXbiy3wA4q7aE20DbXah0?=
 =?us-ascii?Q?bCpj/jYl+Q1XzqzpAlVctxzH6fv7ZrfObibEHY52fFdC7LKMj6/cDBMlD0eH?=
 =?us-ascii?Q?A0LJsJYnisqW1CI122gW796f+AW0igYUnTq1r5n0fBLACJxLR1HY/I14Uau1?=
 =?us-ascii?Q?RzleMOmftKENNMMDzqkVjI7EB5X2v2vYoKyul0oa0riH3add2ZsHvD84usoY?=
 =?us-ascii?Q?gtfAkpi0P+vx3NS7bo0r2QqXXIguwpWX4FP1zPovGcZRzWnCNGXzxq9KINkf?=
 =?us-ascii?Q?12nK9Gigvr9PK+DuLGoyIs4wSw0l1ehNNY3XJHEIvZLmBd49sYDb8QL/N/Rj?=
 =?us-ascii?Q?PSloSh/+OcJsyfUzPKlj05CiW9i8zZBJ7to5B2VfHCBlKN5JhUcLuVfaPYRH?=
 =?us-ascii?Q?r7ueZ4ss19TUXRYlk29+8gO4A7qFj/qil3qTL5lQFHfdO9XNKHyn/iBOel8m?=
 =?us-ascii?Q?XFbGSgpLg0eIdByrJZanxryrC25mYRz+J+HcrNCdIk7xJrlr9xMTqWTQPJlK?=
 =?us-ascii?Q?05n8y/OBW/qMsTuhrQRaVlwrgr5VA5ZKJOY3CYBiL2stIHW8TDrACWxxNdGu?=
 =?us-ascii?Q?8ep8W+Ti/qivKEcWfN0CHzfcqU+k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:39:20.9731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821a0dc3-80fb-45fa-205d-08dc81ba21ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137

Linux has some basic, but incomplete, definition for the TPH Requester
capability registers. Also the control registers of TPH Requester and
the TPH Completer are missing. This patch adds all required definitions
to support TPH enablement.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/vfio/pci/vfio_pci_config.c |  7 +++---
 include/uapi/linux/pci_regs.h      | 35 ++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 97422aafaa7b..de622cdfc2a4 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1434,14 +1434,15 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
 		if (ret)
 			return pcibios_err_to_errno(ret);
 
-		if ((dword & PCI_TPH_CAP_LOC_MASK) == PCI_TPH_LOC_CAP) {
+		if (((dword & PCI_TPH_CAP_LOC_MASK) >> PCI_TPH_CAP_LOC_SHIFT)
+			== PCI_TPH_LOC_CAP) {
 			int sts;
 
 			sts = dword & PCI_TPH_CAP_ST_MASK;
 			sts >>= PCI_TPH_CAP_ST_SHIFT;
-			return PCI_TPH_BASE_SIZEOF + (sts * 2) + 2;
+			return PCI_TPH_ST_TABLE + (sts * 2) + 2;
 		}
-		return PCI_TPH_BASE_SIZEOF;
+		return PCI_TPH_ST_TABLE;
 	case PCI_EXT_CAP_ID_DVSEC:
 		ret = pci_read_config_dword(pdev, epos + PCI_DVSEC_HEADER1, &dword);
 		if (ret)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..ae1cf048b04a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -657,6 +657,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1020,15 +1021,41 @@
 #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
 #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
 
+/* TPH Completer Support */
+#define PCI_EXP_DEVCAP2_TPH_COMP_SHIFT		12
+#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_AND_EXT	0x3 /* TPH and Extended TPH */
+
 /* TPH Requester */
 #define PCI_TPH_CAP		4	/* capability register */
+#define  PCI_TPH_CAP_NO_ST	0x1	/* no ST mode supported */
+#define  PCI_TPH_CAP_NO_ST_SHIFT	0x0	/* no ST mode supported shift */
+#define  PCI_TPH_CAP_INT_VEC	0x2	/* interrupt vector mode supported */
+#define  PCI_TPH_CAP_INT_VEC_SHIFT	0x1	/* interrupt vector mode supported shift */
+#define  PCI_TPH_CAP_DS		0x4	/* device specific mode supported */
+#define  PCI_TPH_CAP_DS_SHIFT	0x4	/* device specific mode supported shift */
 #define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
-#define   PCI_TPH_LOC_NONE	0x000	/* no location */
-#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
-#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
+#define  PCI_TPH_CAP_LOC_SHIFT	9	/* location shift */
+#define   PCI_TPH_LOC_NONE	0x0	/*  no ST Table */
+#define   PCI_TPH_LOC_CAP	0x1	/*  ST Table in extended capability */
+#define   PCI_TPH_LOC_MSIX	0x2	/*  ST table in MSI-X table */
 #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
 #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
-#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
+
+#define PCI_TPH_CTRL		0x8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x7	/* ST Model Select mask */
+#define  PCI_TPH_CTRL_MODE_SEL_SHIFT	0x0	/* ST Model Select shift */
+#define   PCI_TPH_NO_ST_MODE		0x0	/*  No ST Mode */
+#define   PCI_TPH_INT_VEC_MODE		0x1	/*  Interrupt Vector Mode */
+#define   PCI_TPH_DEV_SPEC_MODE		0x2	/*  Device Specific Mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x300	/* TPH Requester mask */
+#define  PCI_TPH_CTRL_REQ_EN_SHIFT	8	/* TPH Requester shift */
+#define   PCI_TPH_REQ_DISABLE		0x0	/*  No TPH request allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1	/*  8-bit TPH tags allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3	/*  16-bit TPH tags allowed */
+
+#define PCI_TPH_ST_TABLE	0xc	/* base of ST table */
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
-- 
2.44.0


