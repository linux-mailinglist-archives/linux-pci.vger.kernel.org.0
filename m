Return-Path: <linux-pci+bounces-7298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B28C12DE
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EC81F21D77
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BB16F8F7;
	Thu,  9 May 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LL0mH+xf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26C170828;
	Thu,  9 May 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272104; cv=fail; b=Xz8YZ+en7r6y/AkDbQ+z3KQit8yDmlkhYVLvrU7hy0pnrTIBHpWqKkKx8bWjokjfm7AbZq3MUOwNMoE0liOBycCCdUwuFqMnkJ89RdtyFiC8IG+ZRqwSssN7i5n4swKio2Mc6qt1AvIhY7VfOSBpzsXVDwaHnLnBlb7y+n0oPuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272104; c=relaxed/simple;
	bh=0IRW7MS63foHzy/5weCuwS45+nd4WR7SRlvtpV5sYKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb3mrmlHanZGd87l7Qm+3gufW3GaTiFfe/zQu3JvqhZxQupV9yuJTSE6X6+OT98aCDMl9PBM03FY8X9+lQiyftS/mmPOY4NNc9J8DxsYepf7NmQjSY9VQ9hwthOySDP+PKEZhh5j999moU3f44q7MUuBHy75r2bE4kUy2GblIfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LL0mH+xf; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4Qb/nroaHon2vzakWMAL0uYm7eBtqlE+kiygGMkYESfyO81z/8NKz/uapicD900+StLaZYScuQUHDkoY/M8MC3DygZr/c9QrxF0UYz4Kepyvy975w0euMhli9O1By2/PwfZQv0SbTtN2vELqB6+JMEjZQ51TmJ28D3Q+afwBOEYBYQTlQYEWsnk0LJad5ltmkHTMZG1OIfPEVlqbRHBpH01n675G2i6TjhYz0VpXCvsVL3eP0Pyc3bGVBVER760Poum9jPwiaIKJFogQ4E1ojYlYYddjlafi5yoYrRfmiOsSipPDTyNT7KuGWbVRsHdFUfELzgXtVGqdOztKR5Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5lxnhYrRUJ0S96/4P+aM6HMIVh/w7lH7FXNjXEi73g=;
 b=AxoOi8r2vgUPHcbb0BE2Er7bteTsjos3zhUQMIbvBFYgpXmSf8q4yCSDcQB6h6xmDx48D0K58GegttNMLdxTICqs+UdJq7FUe/Rt2MhYGqIeQH6qIt07mGY5ahLEvCOHrx0EdXNlZF9RHW/qOEC59DCyNce+sONqN3fJUGToGNtWRvnzXRz+nw1MmeHao8T8hmEM730val4XM6g+p/OsvmfzYkaf44G6CKwvxcJqbCA2RIgiCU1zAJjge2sMjfpwxjUfu4/8Gs8/GQJqE7lzIp/ZMLdlA3yC4olC+mdDaq1Uezi/oSINF9bX5E+lNMrjYKYU9/eKonxX8YjHIXjFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5lxnhYrRUJ0S96/4P+aM6HMIVh/w7lH7FXNjXEi73g=;
 b=LL0mH+xf37wRno+tPdUo/ZfgJM1S9DDi8F14rJANkBIo0sTJhhPne4liMMei5uVhpoo2j7WafFnvVq6Ub0mX8cI8K0OdAtNGWG25K9X99Tl5uKh5SjjtqK/IZmCtbmo3DKAALANw+Iy5sBvOZ7H+JDrXH10CylVpI6DcUl0oYxI=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:28:11 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::a0) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:28:10 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:28:09 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 2/9] PCI: Add TPH related register definition
Date: Thu, 9 May 2024 11:27:34 -0500
Message-ID: <20240509162741.1937586-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 06675467-6fce-4faa-1eac-08dc70450431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzEYGOrlydym+iX0Pe3PlNWk1APlbl7+LBZz23qKc2HSwwMrL/DQNMkJqUYT?=
 =?us-ascii?Q?0wXF0SM+xtB/kDZH9/U6e0L30/rTs7dPcVBdL+6fa5UfPSa6EiQSXaQKixUy?=
 =?us-ascii?Q?NiLEmIpsWq/iDuWTu3t719jmzWkTe301CqxxLu0AwdTyI68zEDgo/LPUQS+I?=
 =?us-ascii?Q?8UKkoY5/mz2GtIkC4WhaIs15GuHu6Y72fb2UWl/H/t12rvntbDyOg9kpdTyC?=
 =?us-ascii?Q?8iwZpqa2XnVOznDTewRs0Qts84gxhNDIa9zr3wAcru0U4GEkX2xpPREFBdx/?=
 =?us-ascii?Q?y5XBgjCVV3keU7flEx3GMHNRp6ZCePjbsMnenPwZSMI4uQMGtJDw/dQBaRtt?=
 =?us-ascii?Q?C6WuJdKdbjpgv6TS7Gu2tnbBfQHp1WcupbeXiQGE2uSxRukb44J385LS8+N2?=
 =?us-ascii?Q?SxMiKBhDzakXPVFXQ7BOthFSIH5HbG+COe2vtdiQp0tCzma6jDgoftNB/BqA?=
 =?us-ascii?Q?3IYTN+zVctpuF5TmVfvIF9vCIarhMtvt4MmCUpKL/JIvH3wxJ2wzmHYKPRYP?=
 =?us-ascii?Q?IvVHX3tiE36i5WI6e0YHjZ4H5Acm2fKbYs6J2Zu3kHP1RfdyAks7jltCAF+z?=
 =?us-ascii?Q?+Bsz735l6Bh/+nN1diDdB2NUysEcQEuGUIEemygOgpygSo+5ag8T5ShybWYe?=
 =?us-ascii?Q?hLqKtSg4JFoDHc7cp/4fwcSQm3qvFDCJn0++3dXVDKRH2sCp8K8RBC0sEzbB?=
 =?us-ascii?Q?p8pWeg52BuZ406818rClBt6TJIjKG58n7I+t5rLtG8ENwCtetnzPg4ItIbLX?=
 =?us-ascii?Q?kjhDEbh3AEbZhLSQ/Miac7KJ2WG1ay7f5gRHRTCR7UiP4ELe59umJg5Jv3DK?=
 =?us-ascii?Q?V/l+FO8mBFzievw/tZX4X5cszhyfIEF92hKpaejhUuMrBbsisY2t7YeVB73w?=
 =?us-ascii?Q?zs0bh/I38uouI2G6yZzENDcJ7A3L+VV4zkTaCV4VhZB2Z+chgm0U6qIZJJT+?=
 =?us-ascii?Q?cE+MQdsr5SCbSjBCEuWZ7tFUZeXc+pz5whxRnVPByAywvdhnpkSOpbGU5QVo?=
 =?us-ascii?Q?lM4jpsVqnbPtNm+nLDIa1Sz23cbutzID5VXeGLOW3KSsIXJ82U7srpm/yp8k?=
 =?us-ascii?Q?C3ymOxdDCqLF9TCrJPJckMZjLwdQW3yV5biGu/Ra7qLiwrz3ahvovmoz0fyb?=
 =?us-ascii?Q?Hb4WIx7/qBlc/2awfp+mWhoyceZwroZ0AE4hba63Qiiagf1jSlObwtnb0ys5?=
 =?us-ascii?Q?S0o7Cyqkdua7XioZsvPRBZ1Jrfuux3qsQzRmldgUsVeghPT31f+8inB+slZ9?=
 =?us-ascii?Q?hzGgNFnPHiP3YzQ6xg7IdN7LJgytix9L0kz4Y4E/hsEmu6yCDZ9DCd+UJjwv?=
 =?us-ascii?Q?J6C7MBE0AhxCgH9XZqV/lNIS6uDAxxhxNTMm9uN+Ghs5pf2/rE/LJnutIFa6?=
 =?us-ascii?Q?wMGeBaWakwXmAqyB547zrOjL25eR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:28:10.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06675467-6fce-4faa-1eac-08dc70450431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Linux has some basic, but incomplete, definition for the TPH Requester
capability registers. Also the control registers of TPH Requester and
the TPH Completer are missing. This patch adds all required definitions
to support TPH enablement.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
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
index a39193213ff2..bf5dcd626613 100644
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


