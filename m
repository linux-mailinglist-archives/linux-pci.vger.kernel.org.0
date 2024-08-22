Return-Path: <linux-pci+bounces-12050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA495BFDB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F2B1C236A9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE51D279E;
	Thu, 22 Aug 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZijJeHgm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD461D1726;
	Thu, 22 Aug 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359421; cv=fail; b=efpL27RGrVnJG9oKGi81hzKCVO12EwUOIJGWcyc/WzrhthYVIlXrY4CaFDLf/N8qTa2LSSzQW/DNytgUhbCmdeGzhLR1KxT4gTn6SSzgZwj7X+n59xYR3bkB9NLdi719AeB6DNueYrU0vbHC7GDvvrqMCq6DLmMv2UrkV1lJGDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359421; c=relaxed/simple;
	bh=ojiNqcbNmSLQVg/A8B/QPA1ivsPeQvkTyq/kWhj4esg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS6s8T8MZiKUKllsz0lffmcq8N4goAZjHSPX1u0U2lZbxqu0V9+3OpRjBPgy3twbgm2zT1jsUSC3tvXQ/MxuQ+L20XjAOaxq+JjHN7igKfc0R0W1lX6bkt3csvv0p0dKRHCb6XQrKfwl0ZJ+HnC6KvdQb3sfrJsu2rUiZiqECU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZijJeHgm; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTksz7qWMqY46cP8b99OMoW8wkhRgfU1MWcxkUEpgpreZ5A4sbjAdvg7o9KdYFrP9vCTnvQZ28CH+XmMJvsxunyWPGkL0hZfLjylITKXjRUnLcp4RSm2DNa3lQjXzjbXO90ZLL3Z2IV1Wn/Z3LKETpZ9Y9Sqwg+cqxiIfmpS+jBRrpfDNAAzKYlHcd4LNgDJL605lrW0yr1QOXyw7Rl4/aTajvc6+KaZKEBCPn6O430Kai1WAm2obFfkpXjgbfx1y4trP1sYynMYDOZqpe+HJerT1MUA+izysxcmKy3mgFGWVLRWl/+hsZZ2aFJe1L+weJN2+RNBeEJLynHKUwGnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+G3BWJJ1jj7LIMRbC9aMihk2XTyPQkizDvWAIfQ7Tw=;
 b=Y2gWNF3W2p1sIg+t0jiiRERy1bcIYcOJdTaLhAi//5lK4t0k4kwnd3JSgxX4i5XlPk8cF1yuAPVwhtxKXyZhuqkwcEbQLSpzQMDLNplFnfJgw5OGr1gGHSLfBZI6KhFvSjrMO6JfvdpeFG2rY4Be08vsdrENQqLgCTm4luccozBm3vi5Fuii7gqa9TDORs14eBSScAIvGu/Z2cYYb+WacLgvDtXPQMAH1Or3h/ceE0q4OKHqLYVSXqxqORKj4/AOAApi+Ut3yLEuCVjFK9T1qqX1RKzhU3w0wDV3Smj4be/q88GiLUammqDp2GRdB1vuq85ZaPcSjet7LnUIC5cbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+G3BWJJ1jj7LIMRbC9aMihk2XTyPQkizDvWAIfQ7Tw=;
 b=ZijJeHgmRWckpRBJ/vI/4WCJhqAiNdb0fl/9H86rOgKxQBUWA1jdKgpH3iE8Zc97BmVQDcLdg0ZF4xhgSP1qtoF3rRGTibETgrMiZD1AN7ee1UWugKqxaa5stbj+h9BAW+Jp0N1RMvawaceIDLrh7beahBTMmBx0MlMmkk0LWgM=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:43:35 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::a9) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:43:34 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:43:33 -0500
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
Subject: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Date: Thu, 22 Aug 2024 15:41:19 -0500
Message-ID: <20240822204120.3634-12-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c29be6-6341-495e-20fa-08dcc2eb17a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpM5mbQ4dbSg9AMn+VuU7viVaQF/9Y8rx6p3STrkV+V/mTVZJX6nLuO1Kwb2?=
 =?us-ascii?Q?7fxBcBEn3qkTJV8RqXsAPM0CE3mien31zqiepUM+ugKBH2OROztRo4hCdCLY?=
 =?us-ascii?Q?3v1WcRXbK/aaIwdLs4dJ2eKZFs7G17g/1x/o9b4HsHZ+UsQ7E2LXgY0Ascni?=
 =?us-ascii?Q?AjAceDaB68aiQMOn24GvImALVAVwAL/LquOski8zxQz77LT8lFsUHtJR9/PN?=
 =?us-ascii?Q?TE+BAedN+LjKEtWdNIO9Ldj7mdcP3uB7S0dpypYmjyHuqV4Fk+9mMsxK1VEW?=
 =?us-ascii?Q?opfYMiNciFQtZjkFlwbWcbJlxf4H4v05JxyEobY0QZ98ImdnEWXfdJ6w5xR+?=
 =?us-ascii?Q?+0DwjeO0XcRO40zymlh9fAHGsbVAkP7DLqmnr4TThsh0xDltz72y4BeJHIn7?=
 =?us-ascii?Q?lVX/C3rWvlMsndWLu0Nf3Y127ZjdY8ATzDMMvbQV3rkAaKmSoJ29zGwZdLK1?=
 =?us-ascii?Q?q3osZcewVHH783pYVOtQUhfF4QhKa4pyj+MxQnon0uONAYmWL968LaeUhL1B?=
 =?us-ascii?Q?bDh95nCgi2Vq/vGHH7OOpQ+6m2Q0XADO9ej363cu0GSomHvQYKQBWZRgMuTK?=
 =?us-ascii?Q?nVo0SSqJ0WFYqfulOdzOcrV5b+ZpdSNHUGMTGjp4D7XpcxrryzYUGcbyfZgC?=
 =?us-ascii?Q?JLFEVzViQjoJYmJMSefXOcwOZRroCMQd14Tqrue42RDWfPOCPm0bAImmGnDQ?=
 =?us-ascii?Q?DiDryGAX+6yetyEZ2+kt4cEFJqND78y+syxUTFLHgnARCOSVWILgu9YsH2Gf?=
 =?us-ascii?Q?wp24IP65ZSdzZyYOBRd/QRlkXXlxLiPz8V6n7gWQMmIyG1AacVEPOkm3mVdZ?=
 =?us-ascii?Q?K9xWesuVM1y5IR8v1KAaFWEMzXlJe7QzSOZl+BbeeC0fRLTueEYcKumLLOaF?=
 =?us-ascii?Q?ueX1tYqqY73vqEaaAT6tjCCbnmJz3qM0Ft77Y6DdtjmwjMtTUZuQpCSxebhN?=
 =?us-ascii?Q?7fIArzYDrO/QoVZScawEfDSd1yKYMcR4AlhaYo/SuVVxYePY5IexCVd/dYDW?=
 =?us-ascii?Q?xFnTSi/528Yz501SgJUzFRUZz0dK2a472jfcR4ThkX1oIWVtJD8CvdE8CdU2?=
 =?us-ascii?Q?6ML405Wwdgyr/eCHLRF0SxjdT3W6FVt5fy2O6QnSNMVxLwj7Qv3UHF9Pljp8?=
 =?us-ascii?Q?qhN68yCmJ3/1nJy17oV0t8zJi+bZbahZPtVWdCsF9GaUpuuBIE5HYNjbTpJ9?=
 =?us-ascii?Q?zVOSJjiFGZ+UxWebR1RHjyg/eWWMJzetvU93oT4lDxZ8CKp5H2atjizo2RoM?=
 =?us-ascii?Q?xLG3xFFv0E33E7hCChfQwzB/3HqyUqVCy6cVDTwlMvit0DA2plf5lj8HQPZD?=
 =?us-ascii?Q?Hzpfmz5kbTUoJuyipMOrPqEzInQbWxXffdcYj0GcT6S0XjZzqOCiNfWgYRji?=
 =?us-ascii?Q?J1kKfxTNXOdOQlisgY9In9SlzVPINIdBZLlFaoudO9EYeqWoerM6x+Evf6AA?=
 =?us-ascii?Q?sivQiF/lnVGrzScW82gZc/99SwiYHUlY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:43:34.7890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c29be6-6341-495e-20fa-08dcc2eb17a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

From: Manoj Panicker <manoj.panicker2@amd.com>

Implement TPH support in Broadcom BNXT device driver. The driver uses
TPH functions to retrieve and configure the device's Steering Tags when
its interrupt affinity is being changed.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
 2 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ffa74c26ee53..5903cd36b54d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <linux/pci-tph.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -10821,6 +10822,58 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	return 0;
 }
 
+static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				       const cpumask_t *mask)
+{
+	struct bnxt_irq *irq;
+	u16 tag;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+	cpumask_copy(irq->cpu_mask, mask);
+
+	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+				cpumask_first(irq->cpu_mask), &tag))
+		return;
+
+	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
+		return;
+
+	if (netif_running(irq->bp->dev)) {
+		rtnl_lock();
+		bnxt_close_nic(irq->bp, false, false);
+		bnxt_open_nic(irq->bp, false, false);
+		rtnl_unlock();
+	}
+}
+
+static void __bnxt_irq_affinity_release(struct kref __always_unused *ref)
+{
+}
+
+static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
+{
+	irq_set_affinity_notifier(irq->vector, NULL);
+}
+
+static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
+{
+	struct irq_affinity_notify *notify;
+
+	/* Nothing to do if TPH is not enabled */
+	if (!pcie_tph_enabled(bp->pdev))
+		return;
+
+	irq->bp = bp;
+
+	/* Register IRQ affinility notifier */
+	notify = &irq->affinity_notify;
+	notify->irq = irq->vector;
+	notify->notify = __bnxt_irq_affinity_notify;
+	notify->release = __bnxt_irq_affinity_release;
+
+	irq_set_affinity_notifier(irq->vector, notify);
+}
+
 static void bnxt_free_irq(struct bnxt *bp)
 {
 	struct bnxt_irq *irq;
@@ -10843,11 +10896,17 @@ static void bnxt_free_irq(struct bnxt *bp)
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
+
+			bnxt_release_irq_notifier(irq);
+
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
 		irq->requested = 0;
 	}
+
+	/* Disable TPH support */
+	pcie_disable_tph(bp->pdev);
 }
 
 static int bnxt_request_irq(struct bnxt *bp)
@@ -10870,6 +10929,13 @@ static int bnxt_request_irq(struct bnxt *bp)
 	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
 		flags = IRQF_SHARED;
 
+	/* Enable TPH support as part of IRQ request */
+	if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC) {
+		rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
+		if (rc)
+			netdev_warn(bp->dev, "failed enabling TPH support\n");
+	}
+
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -10893,8 +10959,10 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10904,6 +10972,16 @@ static int bnxt_request_irq(struct bnxt *bp)
 					    irq->vector);
 				break;
 			}
+
+			bnxt_register_irq_notifier(bp, irq);
+
+			/* Init ST table entry */
+			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+						cpumask_first(irq->cpu_mask),
+						&tag))
+				break;
+
+			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
 		}
 	}
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6bbdc718c3a7..ae1abcc1bddf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1224,6 +1224,10 @@ struct bnxt_irq {
 	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + 2];
 	cpumask_var_t	cpu_mask;
+
+	struct bnxt	*bp;
+	int		msix_nr;
+	struct irq_affinity_notify affinity_notify;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
-- 
2.45.1


