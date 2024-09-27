Return-Path: <linux-pci+bounces-13609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F1988C20
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED99283D44
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884A19D8B7;
	Fri, 27 Sep 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvzmJz8y"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6C19AD89;
	Fri, 27 Sep 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474275; cv=fail; b=jpbYyloyotZUIfJL4uZ1Qt0nTpa0D/+AuqC/yuFYjnYqvXVybEhzKgkdg08EqDzAk/XWoRN1ON9tXuPQzK4gvrZJUaD2OHHSI3sgghXaOPiD4xdqlhHw8plfUPZeHPaCG9pXOTbvXHUuu+7P+xOnjUsMHMQkkX7UUoN+yt2JpBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474275; c=relaxed/simple;
	bh=OD4hw1oELqBj173sTg1gM1LDFRhBNbNd26Dq1PP7tdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4pBVPckIuE9ZTrsD0W2nNl5TiD1Vkv/knyWwp3qVNDYCLA9pE9jEq7Z9nuj7e5tLlFZO2ce/SY6yIXbRZwvR53WXu7URHJSyks6Noy4Ud1yzkg+Tx+t8mv2xixvjqyqnUarrSjCuW1i6v4UtYwUx75omjRl8PUGPBNXBg3FUjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvzmJz8y; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfeD1nMXiIfMoBl0cP5gszvGWgRG8jzwNQSNDa65wgxcb3dPy7MUgoEaDFNIYevna/KuvW+YnFX3XUsBfCpxyHWOMWH89BmPIQw9VsSYe6AaCLlf2v9GzPfBZp+uk+R5mlxTXJ4rJmfzlc3MGy08Vhk0f5WGC7PSYIKyPy4SSTUDt92BORtR3uciFes/0qc8QBIIEVq1ubZJKWJGqxs0TbfSwbI58q6NffSAlGEbGBUkYwTYB455vduXBuM8zJO8T2H2NYYO0IprySxJH2eemM62Jr2yyKIoYPoQGX2zi31SCJLd1iCuDaRg1zgJbGHG6IeWJmr0mGBavoUlBsyHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv9hmyLwONOOVbz66LApHx1jgr+wL9izoWOru17+q9M=;
 b=njefNU0Ersg4w4g293qWmQ6UeVkJ0Z/G4+lv4G9P0O2xDSYiR3Hdhzru8uaDxcR9CUW3+pR+CY5RVfhjKcaawX363Z3WLyKQgp/JJHIRxSZtOe3Ptj26QhcADxAIf7MbeKUNQskHv0qaPHcaQ9IF/8FZZ7oo2hi0GADMCtGe+VSp+dH6pyjEPOijm5CjZzEX2Sl7p6QPCsaLyyjgDjW7xJiKNM+caKofyOTdwlBnrVhM24DygHVrIZ+z4N3De1jjb3fc5iEb/xck7+APD8eKADMMt67tkZCspwXD9NwOrr/WnrgfAdgcqaJwjLuatJyYKgZVTkUngpKtQTefjjm8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv9hmyLwONOOVbz66LApHx1jgr+wL9izoWOru17+q9M=;
 b=kvzmJz8ySCbzagxjrrNUAvvls4WcdXeYqu6bBlQsY1CHpbMSkDsGTe6R3NA/6nhA79A0lZ0n2jkw6W1wspKE/rvepSMRNXH531pigEToDg6rt9buVjGYqSfqKtzVsdNGnkUq49XM09uAJAeH8jxlYLnutBxP7fr4GerrrxcfSII=
Received: from MW2PR2101CA0026.namprd21.prod.outlook.com (2603:10b6:302:1::39)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 21:57:48 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::d) by MW2PR2101CA0026.outlook.office365.com
 (2603:10b6:302:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Fri, 27 Sep 2024 21:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:57:48 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:57:46 -0500
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
Subject: [PATCH V6 4/5] bnxt_en: Add TPH support in BNXT driver
Date: Fri, 27 Sep 2024 16:56:52 -0500
Message-ID: <20240927215653.1552411-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5be738-b6b6-4560-f35e-08dcdf3f6ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EI4+2HYJoj5rnkRJEc6/CFtsqISRedOJg7BVkHMUAjWkM4Js6KSIOb4hvhKW?=
 =?us-ascii?Q?fERznU/w3+gXVWc9oo8xAez2QYl1Im6MOu+gEU3kc8SVH5vQJEdYzEvtUGXI?=
 =?us-ascii?Q?jR06AlUEC643CcQ/nVB+AfHntvayxmqCh3djvItaW5Drt01Id9KfrXWRRNBI?=
 =?us-ascii?Q?CLXeX+M05FwJZqDca3pagG1ulF1UTqBPi/ZjmkXN7g7tE3d3CHAxtAV6cVl/?=
 =?us-ascii?Q?MlEkCMK3mRMUbFQAhOrNJT3WCO09i3/wJa6HEmkOrCN+X31ythsW0O7P+mdS?=
 =?us-ascii?Q?npcCDwjUmpvyGdybb5UiluEKxJO9yYtZvgztNXcex+ggLHGmemdJ9wR4Ewbp?=
 =?us-ascii?Q?/g7QzBhPap1nuU5XZ6Dv0hLHIRRAuGxkvMvc/VGMWch5MuAkqtnrwydxRo86?=
 =?us-ascii?Q?Pjk2zXk6nW6V1fJZydMbClRw2COD8gw2K0eN1Oc8mjB+QR4Ir8KbnNKEWoX+?=
 =?us-ascii?Q?SpCFPIZOo7g+7udcNSuaoXnlyLwTizSXznQnBwpPO4KZTENFf0kIYcAOpUd4?=
 =?us-ascii?Q?9vyC8Pz35jwUOMK4z0NdJZrgzF9fj0JxvGJvw/iwVSSy9GXgrTuCWjNHfW1H?=
 =?us-ascii?Q?jKQr010atBQOJ4gKDGqHiKkn1N/H0su+kpZDnOMkiRmeg4kE2hunwZGJqkBN?=
 =?us-ascii?Q?2ttmYT5wCjicykEliOW9orrc9mY7HVQngZADbMnJmSUaJCnBLZZxsAVspN+5?=
 =?us-ascii?Q?RZuSr7GiXSatd2Q9DemLl4Pj5AHQ5iqJONKEalNzFZZiAOIMKBnkckzWXT3e?=
 =?us-ascii?Q?DUiuNvy6ItWW/1hk0nBtEvOqwscf/bsz7he8ojiL3j8r0q/c6A1q74zF2o6n?=
 =?us-ascii?Q?rqmDEsYl2Yp8cN7OyYoSQOpgzaIyBPiFOtPMHx12PAXXHwilIbBUVjIGROKy?=
 =?us-ascii?Q?m8DRIw277H20VHMnEHYfSFN+yul1bnFbInH8mxWL9XdMJ1XxvDSlXrLQe2vT?=
 =?us-ascii?Q?MME33l3ENZcqTbvqhB/Z6yNSZ2PQYbYwDLuRZk0VhECXfHHDEQJdcD1MkYYa?=
 =?us-ascii?Q?WT1I4EtoWjpHPJNhzAxWkOvtHmpCG5u1mk7FfzINfOM2ssXmoYk1OxHfFe9F?=
 =?us-ascii?Q?ghDLqdJADz9Gf04lhcAIP5BHpBI3E6hCdcgGBjYKYrJ2nO7wJ2SO/X+fZmYX?=
 =?us-ascii?Q?K1X1Cd9CDknnqBR/dAFH/gSYXki9hZ8O4ja29PWfUo1jeq7pf8PB6AOYzOi3?=
 =?us-ascii?Q?/JePOeZbF/flEryj2sj9Q6WmqzIgR0v+N1wOxAtxEado4+5/W3LpEWFVKHbC?=
 =?us-ascii?Q?Ow+zxGnt72vcsmm3uyvH37i2aBoLMEAM/wD2jZs7X/sZg8c2/poDXGTujwyv?=
 =?us-ascii?Q?PSM8Vo3gNV7ridJ9QeBQkjuhrWGUlhmx25qkaFnNTMPkGksGp8meqPZeuDtf?=
 =?us-ascii?Q?UHXs44Z+wyFwoiAvCr5SaMBtXT7KxhGoF4awcs2TtNN1C6UiBxrXp+oizAhj?=
 =?us-ascii?Q?SlKiEzw3pYgo8hbpjVbw15jbjV6pd6rh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:57:48.1304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5be738-b6b6-4560-f35e-08dcdf3f6ce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 83 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  7 ++
 net/core/netdev_rx_queue.c                |  1 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..23ad2b6e70c7 100644
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
@@ -10865,6 +10867,61 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	return 0;
 }
 
+static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				       const cpumask_t *mask)
+{
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
+	irq->bp = bp;
+
+	/* Nothing to do if TPH is not enabled */
+	if (!bp->tph_mode)
+		return;
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
@@ -10887,11 +10944,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -10911,6 +10975,12 @@ static int bnxt_request_irq(struct bnxt *bp)
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
@@ -10934,8 +11004,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10945,6 +11018,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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
2.46.0


