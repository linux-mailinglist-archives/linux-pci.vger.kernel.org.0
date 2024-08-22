Return-Path: <linux-pci+bounces-12041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155D95BFB3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C64B1C233D0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB1C1D1727;
	Thu, 22 Aug 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jTOgui4x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA21CDFD5;
	Thu, 22 Aug 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359317; cv=fail; b=dTQarfbSbC9jZfR/YhC5GLbyXpMn33kNArgs5fU0q5v53QXWhc1NtaFXlBJkNeIwBaH9cjwLVlGRhdsF7LrFJ7GweFRn4VGiMGofZepUabTkp3JjWjcIxd0sshb3F1N7VASXqu2S+2I3BE7PrM0zyqpSKJfGOXA1On6xgzIcwas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359317; c=relaxed/simple;
	bh=S35hk/rdfSR1NPuPYLyQNC7IrLMHcjqYr8QEzSD8rhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDrcflnSLHtAiDRaFby2/cqp8HVQF17tnSTmClLqppmz+CD0IY9Oy+lQW7H7sLV469Gy1wKgfChpDt2vXCfJjDHippxJFLl1EUluuFPb9P1dVi+Cc07hmTtrGCl+MOSiM+W2CeqFCESmLydcutujvi0vRj80/hywvzSV1XLlVj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jTOgui4x; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFlP3DUVn1n2MtPj9VFU93uraWzIqNwNrGZf1z7X5JLlzk7PxedDAJOV0dcH3lZivbVZ3hLesN5F03M8nYNIp2D8X8pdgAixFQju4BOfdJqbd3+NB8DoqVwzhDg/Cs/qmBYGEdEjrjlmmKBJ6TzT208C5ImmdlgfYMLdp6FYSEy2TuTbctNRg6Dr+b/loCKKXj9Yll2p8GsSYtOyD43QPabq/MsxC76uj06A7PHyilEAdoAFR1WLP3ikM7W+0dK7dYyFNDnPIlXqeL57iDXmKACBAegxbmGHSZmpUtSiGYt22DBdu/9sXV+Y3Tn3OdOmcq/X0tuy9S8A0gJUrcO9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdkfrOITbDPcGCMYR+Si1dB6AxPG2TBTrGAuw9H5XAo=;
 b=QcR4fz7gzRk62iEzbSvf65Q21Nw3zXWqeh/uxHSUunrzEAzs3rSR1KMOMptu9VIfWnvGq32QwYCIcUpFvWi4HMPVOvUhij8NnWSJjbU6ba2gLvAfZ6yUb7WxhQ1eQlwYz6uPRne41utPcotepiBKOlBPdDM6HR4QFg/c/p9+2D7meugoqzK5IyNFSi705UW7dTUu8pPvVuHQ/S+EFBTKFx4qJ/CjuGoBWOSmk9t/QMguPAMYzc5+hnHisJd5t3xRnnTK5thzPdYjbDdWXy5ugfu5vjnKt1qwTXlIjpPLITJjRFfUmg0ubTB9Wf6TjHLBvbYO51hCcWONqVCTNw7R0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdkfrOITbDPcGCMYR+Si1dB6AxPG2TBTrGAuw9H5XAo=;
 b=jTOgui4xynuymzGLPsVBQj67sDwuSW+h6eLIQLZpZ5YJbrpo9SpKYl0wkx8dCBQc6Wb3N/Yw8pg6SIJ9w8EbtITBGRtWWu/u8itJnh12B57ELXCqR8QHHatvM0t/kvFlk2CB6DBhw52N47D3fN7gGaXkru5JZRnSSsih1h3EGi4=
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 20:41:51 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::24) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:41:50 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:41:49 -0500
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
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 02/12] PCI: Add TPH related register definition
Date: Thu, 22 Aug 2024 15:41:10 -0500
Message-ID: <20240822204120.3634-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c00691-f0b6-4249-1167-08dcc2ead9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dHSZsjEce+iUe9Y9QTycodvaJSFvYeeDrycaGhsF+pft1R1GT9/VIUA71GZ?=
 =?us-ascii?Q?V+CryFAVTbGxnazP529m14exFsj6H37RrSy0gO424oVpV5XqKlqibvgScbWs?=
 =?us-ascii?Q?ynkyNWwdwPMSk9WtqVHaCBM23kHvyHi32fJ1jZepW/DcQ7v+AZF2/rrrszUe?=
 =?us-ascii?Q?koxNjlcSnEOlPeRzLo9JQj/XsyicSdPo4qhrGfXZTqBZ1+pT0/ymAtNa6Wye?=
 =?us-ascii?Q?ctbs5v8hz2Mbwa2/fFPVqsI3+NHLk1kXCcN4x2oaqmOv/PKACXC95/M9yRPt?=
 =?us-ascii?Q?6YDCdp/Jlwca7eHgEQZ9P8CqDFOe2W9MAKGeE8j9paC6lp15z44Ipfshj0pw?=
 =?us-ascii?Q?kl2lT0F9dsdWLXNvkyjl1aOYl+nNAM1/s/OhHXSDqnZwv8D36j8ai4ParRlS?=
 =?us-ascii?Q?o677qSGXy0uDeoJ1gcihRLLTcCV/m7HQFk9+5qHO5LBSMdAwujpd+Hw/z6hZ?=
 =?us-ascii?Q?JuDK1e5oAK/2O4+jfKkG5/h+pLZv3vbfuYjIU7cbfL8eIyAGt6f4mstucqDS?=
 =?us-ascii?Q?0DEiYRpJSGcWSKDJy0LwKF8mwt8vdMHezlQWM0rV0Aq4JNxbiRxP5bscQBIR?=
 =?us-ascii?Q?I6swiRx65sQbrZ9CEYDoyGDWr+N6XbtdpclWirFh5Wz8oMScb7qx2565Omyq?=
 =?us-ascii?Q?y1EoUeKqtYAud0hUS2pI7KffiVeJza5TiRKlqNpwykz5QwgRTx7miktJ3LRv?=
 =?us-ascii?Q?P2IfsV0WGWEmqySMsb18+Q7YHCTuimNga8ZQ3KfX86gfHYOb10L9HnhnMvRZ?=
 =?us-ascii?Q?ThWenhNzVOfcQrUbAorK4urv2k4SIwlPMjLYMaeVj5gjp3JHE/GoPG7APe0B?=
 =?us-ascii?Q?X96cdJIKkqY9UawuM46XvuvdRv1q/gvLXm910uzt/F9WxGRdkpmRfF+8nwaL?=
 =?us-ascii?Q?ioCreGgkta6UUzCUXtsyNTxUJBNA/6nWozwaAmXp4xSCjiTTDxpFao5825cN?=
 =?us-ascii?Q?NRPV+NL/PyP+DPZQzdmZy5ZFbYqLUAypZvlGt/WpWa7Q5cATXwf4soyMX1qP?=
 =?us-ascii?Q?eAoKXkR9UH4N0fKwmoezGSpST2vEOSPRrgGCL1XiQjTdrY5f0PsRWf7Kl2bJ?=
 =?us-ascii?Q?/b6bA7TKQZaM4nm4YNOZGxV3HofcTeX3mKe1Dj39ofaiG4+PVGFQd98Wl/qp?=
 =?us-ascii?Q?GTrJ/q9pi88KHyYLb+RM/PZCqxz/CgGhTG7oxz3gymIF0CTGYeEMk/9RSN5Q?=
 =?us-ascii?Q?aKz0rPtfnD5FlHVd57HbtX+cpu4zsUfUCvYz6QGbo9Y8WOQOhwa/E1lrM9xv?=
 =?us-ascii?Q?twZ34bvBFANruE3LU2LYEAN4Jhspo5CUeq52LMCEH9UlgqWRs1A6lnJ+EnnM?=
 =?us-ascii?Q?0qdHFdriz+BA9xu3dlI9GshgQ7kqCaLmndvnemC5zFZQustrNeanPx4KcDD0?=
 =?us-ascii?Q?OJGStJa03an1gltOtPbd95bEm3Vak38khGKDUO25GaJ6yzo9YQJkgsM+pVSR?=
 =?us-ascii?Q?J9/wEOe+5OY5Zgyz2E4NBM23ygaIb2YX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:41:50.7551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c00691-f0b6-4249-1167-08dcc2ead9a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

Linux has some basic, but incomplete, definition for the TPH Requester
capability registers. Also the definitions of TPH Requester control
register and TPH Completer capability, as well as the ST fields of
MSI-X entry, are missing. Add all required definitions to support TPH
without changing the existing Linux UAPI.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 include/uapi/linux/pci_regs.h | 38 +++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..643236f43f4d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -340,7 +340,9 @@
 #define PCI_MSIX_ENTRY_UPPER_ADDR	0x4  /* Message Upper Address */
 #define PCI_MSIX_ENTRY_DATA		0x8  /* Message Data */
 #define PCI_MSIX_ENTRY_VECTOR_CTRL	0xc  /* Vector Control */
-#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001  /* Mask Bit */
+#define  PCI_MSIX_ENTRY_CTRL_ST_LOWER	0x00ff0000  /* ST Lower */
+#define  PCI_MSIX_ENTRY_CTRL_ST_UPPER	0xff000000  /* ST Upper */
 
 /* CompactPCI Hotswap Register */
 
@@ -657,6 +659,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1020,15 +1023,34 @@
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
-#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
-#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
-#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
+#define  PCI_TPH_CAP_NO_ST	0x00000001 /* No ST Mode Supported */
+#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* Interrupt Vector Mode Supported */
+#define  PCI_TPH_CAP_DEV_SPEC	0x00000004 /* Device Specific Mode Supported */
+#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
+#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
+#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
+#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
+#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
+#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
+#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
+
+#define PCI_TPH_CTRL		8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
+#define   PCI_TPH_NO_ST_MODE		0x0 /* No ST Mode */
+#define   PCI_TPH_INT_VEC_MODE		0x1 /* Interrupt Vector Mode */
+#define   PCI_TPH_DEV_SPEC_MODE		0x2 /* Device Specific Mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH Requester Enable */
+#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
-- 
2.45.1


