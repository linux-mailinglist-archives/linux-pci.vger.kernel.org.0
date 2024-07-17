Return-Path: <linux-pci+bounces-10471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51E93438A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A261C2139D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4A186292;
	Wed, 17 Jul 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+hGig8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BB184129;
	Wed, 17 Jul 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249839; cv=fail; b=nG8QfDscEqAoEKvMou3fBIw2037rPR9Ym5UUU2Hs0pfpypU+mxrZnpStMfXgvjJkok6TxaH78ihOPlSO2fmL7fbjDgdb41Vl8BMXHd40+jO8+J1NMLxLfY76I+rTGajDHe2OKNhttQdNoosNudjtVA/+WqehDGux3eOvsXc7FxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249839; c=relaxed/simple;
	bh=91K8Ki5gknc7wsEBluy5XLwTnuJCe3Fv/24jydKc+mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLRTm/Fm1RhzoTXEKRJfUuUrhl/zoyMEVyRhDKyQuqRhMrHh6xy8FXcPE5ECit1eOMcRAz29eJ+rEU9+HD6BSfGSHZQ35pCJw/umFDIzbE9J4WKTaBaLtCGMwxB4yKiaVs8r2xdSs6Qwu2X7JNs3Nc6MebKFEavF6cBeIwJJkLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+hGig8i; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd9hNbl/b9SvSKvf8TbHAj42b1zkyMSFqR3kEo9IZk50Ks11MdA8t6JatjD2Advrn4tqWmi793QnZNT3am8BFwXJWyPydfkTAKFNe4VLk+tant0Km++x6yZxbN/DAUhgw4ZkBjQChM+db0XVUT4L2WnkkTbMEfuM40fi0f5N1ZPnsIdkLJ8V+qKfad41/kx6XXAZ25EUVK6JbVroYS3yeOZ3IUdd7CEaaliWwuU38xTQhYMTCzG1fOZIou591GaArmWA2fvpUq08O8aZwzvkmDqJR75YmjwEBbBqqBGFdAcl9w27NhPzq2jbtlKxUphCVTtm+925zsPJvbEvvOcO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmz2hRY0WCeXagYBrm6vgh1XjaUDH0ZX+U5xtQDWz5g=;
 b=nFQCM3RjeqFEV8AFFFn58Rs6sDJzxfs7OObhAs+YI59qV4d97LgMLPrZFTtga/i5ZEO6Srcu1u0paHTnYtEc4Xf+gjCFZxd+Rsai/ho0ZIRxtuQhrE3cotCI+P/088H2JorBy+MXi6FB6/7CvVp9OGOPPy/n8qCy7zXQTMYZB0dTbN47HYC5AdMToNBh4xkzqHhrAVh1GmuYcb4p73lby1FTzBH5QZYPBK0SLjsRXm1mzytopXns34VaF0UMIwCTU2rSxSXb9PpSEEmDAgaariWiFEpLdQMdvKV7Ig+9FXrOTYS3QiLc6Fqux9fVotzL47RXXePLAWJ/pi2gYW9aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmz2hRY0WCeXagYBrm6vgh1XjaUDH0ZX+U5xtQDWz5g=;
 b=M+hGig8iCtxLBL8mf9rLEv+xm0p9+SSTFZbAiejs2VdkYAAzVFt/4vGNlJX9Qp6x+VH6OOxrNlRAoQZrPNhmUDrteGbGMg6yn2Io77Zt/aB8S9neFdtpqyQsedzrDVDXjFVt6kikYz1kAdJFrIQEz+c7yQdWnKboU3K+Wms/PJo=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:57:14 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::60) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Wed, 17 Jul 2024 20:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:57:13 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:57:10 -0500
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
Subject: [PATCH V3 09/10] bnxt_en: Add TPH support in BNXT driver
Date: Wed, 17 Jul 2024 15:55:10 -0500
Message-ID: <20240717205511.2541693-10-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: a023e7f3-9b44-40a5-f9eb-08dca6a308bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWVO59VtT03H6h3mdAdljzz4aihGSPx1RuspcCbTRmUaPY+m3bvYO5jBywcl?=
 =?us-ascii?Q?f4mTyoP1Zor24sABMqIrSuf1TO1MN86AkYfzrczI10ixhRfwd5uJRywjns4O?=
 =?us-ascii?Q?nBxkP5IqNGIsPJitccMShT7Jsm9qVWs8JhXaPblp/giNcesHJXnO7gzAVbJC?=
 =?us-ascii?Q?qrPowRdNLAe8pUVvAt3pAf4TcisGJqflpf0xfvtEP0aa+2RdGM0DRS/E0nO7?=
 =?us-ascii?Q?PB/1CLEhO0+KIHlDn70koeERdx8zIi/p2SzXTOPWvfRgI3HryJHZKx3GzO7i?=
 =?us-ascii?Q?1iQxBs0ftPDDRinwB4rRA/oBhaHM9xMC2ZaAiiJYmElH5bwOEW8up2aYKj6K?=
 =?us-ascii?Q?/TeHGOx/KxDqO+SlHRDvPJt63xCz6jstpSQ2E6bTe5nbxR7Rlt9pTmHl7fXB?=
 =?us-ascii?Q?/D4pUmeDYQcpqXoH0RNt6R8WujCQ5M2EMHE8fgE0R4PMDdE1mu4TtJP7etJN?=
 =?us-ascii?Q?yZv9bJjqoNfjEzL2QNyxGs20/PvlbSnoPTU81nKLNufo/x+mL7TKVJkfqyO8?=
 =?us-ascii?Q?vk8Fpc2vqXMJyeQdEqufdov8tXcFKu34wp3gai0plpG43yEjiZNDq3rWDSth?=
 =?us-ascii?Q?NEEMVMhT1gXb8cl/d+bOzJMi5BFBGejeptTdjMAp/a89MDM8f03GPITp/p4c?=
 =?us-ascii?Q?7DQ94Y/1DbJJT2EyKZrKGp86jejqeovnIxjAwddyHIMGMQkdlJJb/mu9Ve+N?=
 =?us-ascii?Q?5PNn1cXS5bC0Ks5VeXDAidE2cIg71IQeXCI4/E4l/T9BM+uUwHUJ3qalggIx?=
 =?us-ascii?Q?IlNzS/iuO/jbnUnTCNp7vY7STkgWbNvKupelaKFkMirFbHS/MjTbJh2svffd?=
 =?us-ascii?Q?cZFnlRkz1Kgu6C33XK9ScyXovmgtJKOQZ78GDSl9jNUErXb8/DD4DjKyuyjw?=
 =?us-ascii?Q?Q/1vIEsb4tEAFXkOISLNmgQS/Yg4ep9NSOC291kV3tLoaQYhctfzKIIbmPxy?=
 =?us-ascii?Q?kVc1YXEl/Qq/tpduDKCBFnEjTr/tPgX1c68HKu1+yVJhL3RJliujzMRiM7QL?=
 =?us-ascii?Q?JE1iLVtbED1n5IzXmp55AZNt66kZTt2RNYbRqZ1XxflRVQ1SZNXqXpcHvGxx?=
 =?us-ascii?Q?n3L64toX8Ttr9Vn7fqXtnt22h4QE4WWjAoYKP2gr7jybDKd2RyFMkH0NVUGu?=
 =?us-ascii?Q?z7/q8dqjiX99tCJahcx/4rRSO0KhiMwccUZjutyeaMYDnNfK4CVjeUWPSmsz?=
 =?us-ascii?Q?ULytW79W3lrlvG9kAhCzxtUlAzkv0KEMAMHURgngu1UfOtHtKhoFtXhO669t?=
 =?us-ascii?Q?7ZWRmNUe2B7QpNnrkSHo/K9YAqQDUwsfLZzItIdxBZ+HNCeL164XlCV/Ey00?=
 =?us-ascii?Q?na1lkC5/N1zv+9w1JKhdLr+bknjCgJcqJEvXArsV79rIgVhjn5wCSSZ7pPeU?=
 =?us-ascii?Q?ffMkb6Q5TtbKkEZQ1o6HUvPyTXG0jpTnQouk8TH0mrWZ+2qVf3ASf6kx9diK?=
 =?us-ascii?Q?uGDmxwnCt0ITv8RZ1mcxyHAd3i9OyglQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:57:13.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a023e7f3-9b44-40a5-f9eb-08dca6a308bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

From: Manoj Panicker <manoj.panicker2@amd.com>

Implement TPH support in Broadcom BNXT device driver by invoking
pcie_tph_set_st() function when interrupt affinity is changed.

Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
Reviewed-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 54 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c437ca1c0fd3..2207dac8ce18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <linux/pci-tph.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -10683,6 +10684,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
+			if (pcie_tph_intr_vec_supported(bp->pdev))
+				irq_set_affinity_notifier(irq->vector, NULL);
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
@@ -10690,6 +10693,45 @@ static void bnxt_free_irq(struct bnxt *bp)
 	}
 }
 
+static void bnxt_rtnl_lock_sp(struct bnxt *bp);
+static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
+static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				       const cpumask_t *mask)
+{
+	struct bnxt_irq *irq;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+	cpumask_copy(irq->cpu_mask, mask);
+
+	if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
+			     cpumask_first(irq->cpu_mask),
+			     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
+		netdev_dbg(irq->bp->dev, "error in setting steering tag\n");
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
+static inline void bnxt_register_affinity_notifier(struct bnxt_irq *irq)
+{
+	struct irq_affinity_notify *notify;
+
+	notify = &irq->affinity_notify;
+	notify->irq = irq->vector;
+	notify->notify = __bnxt_irq_affinity_notify;
+	notify->release = __bnxt_irq_affinity_release;
+
+	irq_set_affinity_notifier(irq->vector, notify);
+}
+
 static int bnxt_request_irq(struct bnxt *bp)
 {
 	int i, j, rc = 0;
@@ -10735,6 +10777,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 			int numa_node = dev_to_node(&bp->pdev->dev);
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10744,6 +10787,17 @@ static int bnxt_request_irq(struct bnxt *bp)
 					    irq->vector);
 				break;
 			}
+
+			if (pcie_tph_intr_vec_supported(bp->pdev)) {
+				irq->bp = bp;
+				bnxt_register_affinity_notifier(irq);
+
+				/* first setup */
+				if (!pcie_tph_set_st(bp->pdev, i,
+						     cpumask_first(irq->cpu_mask),
+						     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
+					netdev_dbg(bp->dev, "error in setting steering tag\n");
+			}
 		}
 	}
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 656ab81c0272..4a841e8ccfb7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1195,6 +1195,10 @@ struct bnxt_irq {
 	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + 2];
 	cpumask_var_t	cpu_mask;
+
+	int		msix_nr;
+	struct bnxt	*bp;
+	struct irq_affinity_notify affinity_notify;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
-- 
2.45.1


