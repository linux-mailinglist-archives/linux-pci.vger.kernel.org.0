Return-Path: <linux-pci+bounces-13248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE897A880
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354BE1C21668
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33AA16132E;
	Mon, 16 Sep 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mjK7qYZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00C13A86A;
	Mon, 16 Sep 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519928; cv=fail; b=keU6EzwYyR5Qfv+oDjEFi7c9yN4bXcnSxF+AOR1a0OPSp8GkHBKFoDP0ht3Rjv5DmQOLD6M7TSh2kk+AbBP3FXsRInQROFMhlBLa+JbpkMzXIqnOFL+jC0kvb+qBsC22V9oe6PFYe3ZZ+mkdgpsJfKzrXJSXXfKibMMWZNrNB30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519928; c=relaxed/simple;
	bh=x1POr8P8O7rnaDonW0oa0APOJhygk/Ug5mg2BLSX1kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG1IhUMHZhPeDTM3mXqcPkZlcmIxwQfJZZmPPnbR4s207Wg0umMAAV59XUL9aV1+rPRfUSOqCe3zAlgEuqeHDq8+3AqZqbBAWHDmE9G5hgUEe7rxoNpXUOCX+jmiYSet2mK70D5QtKYSAHoxsOGPlac7KHfqisunTxQolXoWWV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mjK7qYZH; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1w2wJEyE7rckmWRFFFh0pr8wZKePRwsGfkRc0K10CN022LByrPnZc+ePpDHSWXDgHnlz1UOP0DM0mtx/Iby0QdQpnzwVZBvPHGLGhyE4dZPkjDLi9zf22YiRXr3V+czwsyENzMmDtBNmS+BH+O85myttADTqk8RX1L5eS6AQcl80Cnyd3V/BHs06N7M+uWuhomRXm0qKrbxaXyR8rcHVgv2Rz3YckHfoCZvkqZOIxfHU+YsjtH/1PvSe7p7etcmcDNtz/9Px06exI3GH39/xoHaM/8qthzyYx1XmgC27qZEFbEOMaqGWyMAqQAHnWAZBJmWfnkbQMBeJ/rwBvMOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14zAmmF0QoSasvl09XlLz1Xxt7N+OU4FvXFchR/f1co=;
 b=vgQY6cIIaUM4snYZazMZ5m1uFo7sK1GWr8VrNSLPhhin+GivyVXz7aGJaf8Cb/Jws+knq9iDgQlVuAHH+EIk1b8ZvVsjMW77zgh5mGkLPl4NEQddVsBHECBG6e6dZ3jxjB3iUeYMHLMe2WwPGSMdbbkb/rOCocEO2tSpi8VmGx2l9B78tzEY9eUnOS3ENjpNH9riIAO46oRQrZK6QjXT7R9+sBSv6hQY4FoeCV/Qm5EYx9MbEEMNmpemrycu6yIfZdxrXP8l1ljlKkGfOSbRq61WIfOCaqqXFpOwhRsIw91993leKt4mF6zZpkuosOtFHUX3TKSj0zc2hvUGxOHtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14zAmmF0QoSasvl09XlLz1Xxt7N+OU4FvXFchR/f1co=;
 b=mjK7qYZHiJVXEkwCLZ3l+LagXTVv3O0wpGH2DrI9uXX+bZthr5rw8DW5ccRbpRm023ktNGowbVRtwVY66lRHtUieO/gCvpD1dwbduH1B6OlNz7x5WNBNXCZiCrvq2mIBxdpLIpgnZkUiIOkB/W0gGCAAdbCIZw31Jfs/d6poGQ8=
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:52:02 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::6a) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Mon, 16 Sep 2024 20:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:52:01 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:51:59 -0500
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
Subject: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
Date: Mon, 16 Sep 2024 15:51:02 -0500
Message-ID: <20240916205103.3882081-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916205103.3882081-1-wei.huang2@amd.com>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ef7829-5dfd-482d-9572-08dcd6916a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTgi9VvPE2UIIuA9f3Xkx62U9c0QWxiWCHCyaU/JtwSNZVb+PqH2fF7Z5p5j?=
 =?us-ascii?Q?fqrnlxCFmmWuN6senCSZpQbnFgw1WsCoaMzTYxSIvHxakqqD+W2+PDqxYx9l?=
 =?us-ascii?Q?LKvAP8+rE4ayjBy+rp/3IfWN4bypys7KWrBYWGyvTg1PA5n/tozIZq2D88C5?=
 =?us-ascii?Q?0miv+vdCraMJ76zYRBZhcVtFRGN0qb7ZaqH9Ci5h9KbTuwcaYZ1FAJOV5R9F?=
 =?us-ascii?Q?XSCfLBy19Ewez1LMQr3j91M5Y7sdlaTUw0Mb0LRnBccOMzDMZZi0PiMJYUQ7?=
 =?us-ascii?Q?OeCfybAlI6uIr5lI5vK7uKmygRMmhUbWg5M8he622NxcOvA5opEkpsgev5c4?=
 =?us-ascii?Q?I75l1vUOoJ4oBUF91JrdSvxrEAyxFRfRQ8SrxUiXC51ldXP/R2nUjbXeWhC1?=
 =?us-ascii?Q?oEBQxM63bXGFE7RTFp8fAvXrLANpteO5fEeVkhkPVsPVr0m4Q7f4aKk2PCVP?=
 =?us-ascii?Q?Bfb8FGE8yNCiQJBvsuC43BbKxvez1VUzLSnySvexBGPvPgKEODeXSA3aafiv?=
 =?us-ascii?Q?YGIg7vEo1TwE+8Wu4urGEGtGFsZBdMvVVPf8bc5VIhRP9ebW6I1XNZYMNRvV?=
 =?us-ascii?Q?ZoxPPs81R0PhxctUJt9AWmBMOqzE3r3GGK3hX8Nu5LSfBf5UALK6J1T81WkA?=
 =?us-ascii?Q?6GfhByzlewgnFJ63fc4Bfm0txZ2G6PDX6v9duKEXB6GFYhpso/XguimmkkRt?=
 =?us-ascii?Q?oXRnmetEVYCKMz9uMzJL8j6meQ4n+CJqhMU1Er78yn7/++qEnHtO4MOmNI0i?=
 =?us-ascii?Q?E46tqm0+4SW5P54LMKA4L0/DYS/uN+myVZaUmMMhs9oQe6tV73ca6EMniUyf?=
 =?us-ascii?Q?XwixuicpoFb/MMQC/euTQ5X3BjymejjF75+v1x5MIp5qTioGSim/NMU0Gcbo?=
 =?us-ascii?Q?XpL2EfrfV//UfvRylHCwmSmv2gypGzDnDCsRDyYoM+b6nZC3WDfvOTHMIJE+?=
 =?us-ascii?Q?gN5GH0eLGfPhD+2o0TLyvQn6GK5hLYx6X6LybuwhS4K6kMZvdqe02ExAqUoU?=
 =?us-ascii?Q?B2sactakfqNy4Um9zPimKMb7REEbk/c41p8o+9tKhf0uSCB1yRbn/5vqhnFc?=
 =?us-ascii?Q?zMS0lqhNaCm2CbOcdbjO/N9lJ08nUH94oAmCjbXxJoEM/bZMpX20bejL8DU5?=
 =?us-ascii?Q?mgvnrUX5lT7jYcfIAfWSHreRwWsC2xCZxpKEVIhtlJRQVqptQIl8x8Eu6RQP?=
 =?us-ascii?Q?IL8e9ExoMR5pPG6DLVncjeax829adhRUazd+XJqLxPqy5muYbvuYjJK2rlTf?=
 =?us-ascii?Q?RGEQQ4oSfU7+t/9wcI6Lgx8cYNHO6ITLWq8HdNMI02x2iSr4QLrCv31v48GL?=
 =?us-ascii?Q?LMqrOdNKNag0u8a+DiUVbalN7D+xpMbjKlXIp6elyIefooVT7JYzF/GPRvno?=
 =?us-ascii?Q?OyCdTN8uoc3lvklxOHbDHImBCuSdpXJ/G/hV9xCa+feLYCaVByb++CLITLsS?=
 =?us-ascii?Q?FHIx3Mh5ZsGIj9wrirErgY3z5Bwbqhhk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:52:01.4751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef7829-5dfd-482d-9572-08dcd6916a07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

From: Manoj Panicker <manoj.panicker2@amd.com>

Implement TPH support in Broadcom BNXT device driver. The driver uses TPH
functions to retrieve and configure the device's Steering Tags when its
interrupt affinity is being changed. With appropriate firmware, we see
sustancial memory bandwidth savings and other benefits using real network
benchmarks.

Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 85 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  7 ++
 net/core/netdev_rx_queue.c                |  1 +
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..ea0bd25d1efb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,8 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <linux/pci-tph.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -10865,6 +10867,63 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	return 0;
 }
 
+static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				       const cpumask_t *mask)
+{
+	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_irq *irq;
+	u16 tag;
+	int err;
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
+		rxr = &irq->bp->rx_ring[irq->ring_nr];
+		rtnl_lock();
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		if (err)
+			netdev_err(irq->bp->dev,
+				   "rx queue restart failed: err=%d\n", err);
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
+	if (!bp->tph_mode)
+		return;
+
+	irq->bp = bp;
+
+	/* Register IRQ affinity notifier */
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
@@ -10887,11 +10946,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
+	bp->tph_mode = 0;
 }
 
 static int bnxt_request_irq(struct bnxt *bp)
@@ -10911,6 +10977,12 @@ static int bnxt_request_irq(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	rmap = bp->dev->rx_cpu_rmap;
 #endif
+
+	/* Enable TPH support as part of IRQ request */
+	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
+	if (!rc)
+		bp->tph_mode = PCI_TPH_ST_IV_MODE;
+
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -10934,8 +11006,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10945,6 +11020,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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
+				continue;
+
+			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
 		}
 	}
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 69231e85140b..641d25646367 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1227,6 +1227,11 @@ struct bnxt_irq {
 	u8		have_cpumask:1;
 	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
 	cpumask_var_t	cpu_mask;
+
+	struct bnxt	*bp;
+	int		msix_nr;
+	int		ring_nr;
+	struct irq_affinity_notify affinity_notify;
 };
 
 #define HWRM_RING_ALLOC_TX	0x1
@@ -2183,6 +2188,8 @@ struct bnxt {
 	struct net_device	*dev;
 	struct pci_dev		*pdev;
 
+	u8			tph_mode;
+
 	atomic_t		intr_sem;
 
 	u32			flags;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index e217a5838c87..10e95d7b6892 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -79,3 +79,4 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);
-- 
2.45.1


