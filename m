Return-Path: <linux-pci+bounces-16931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37D9CF576
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 21:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7192830FC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63A1E202D;
	Fri, 15 Nov 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dkrHCt8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9F17E010;
	Fri, 15 Nov 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701076; cv=fail; b=l8H1Cz7bnBdN5sedaucmqRIYAqWtlBViQJ+ma5+vJK/KiSCLYRR4S/RcqvXcGfobJCiRem2fxkW+FiIuu7DwJUHJBq1p7ete9cYKmLUnYvsrjqwvK/XcS1nDsqS7ad+jEP2Obi3I4DClnxaXT2EIEY8aUasHtvVNHA2d4wtkzgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701076; c=relaxed/simple;
	bh=850Z6WR/cxWkT32l5IgbQi3y+ebxCkPjQnOXf5i29tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEMAbs01LjcVa/iicfWGPHL4r0MV9hdO5QRyUnNnSsBYPocYR4ytLjGoRfR6ONhvgmEW2RvK7aZQHNxGe+qtrPgB+SL0PgQ670pc5gpZohkirTtE9ql3ll9ME7fHVO9QsT4c8YLA9BB7/dNf6vzsFVvYAdyhQk05XCTVDQX2sSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dkrHCt8c; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUwJeFX2Tf9GkhSlXq9Fg6dsBFWXBO+aQ83g8jKGFyYk4yiK71jA22IMl53qj8Rg1/XEYedyx6yu4YmnV7my/v5XVt6FsQVjUOW/7RAmpIZT1xmD6hqbGdPFs+KKtv8joK6Y0h2GvXwt48XLXHyhGHSrLTbwokDAjOJI/HIyrMmQhL9c4QoYLH6ujfRun59J+MwftywlEy9nc5VuE2NpSozJp9tEQMiEdnKVaSAViJGsN5S0/cm+ebLz6B2CXVUccWOen16xS7KLuG93pCxXPBExzaYh/Pq20zOdgUaNozh5V4TJVsnhmw4YW1inX89KPnAIKnkyUIhCgDa4m82JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3lh1fzkUnjQGj6PvFP/FghUbICCgwwYVI0ZThxOf1k=;
 b=hnqbwWeXfv/R9XGGd6IXbePhMEffJI3b4dXLrhroy4bpRjY6C05P3YSFNpVm/lUXQLl+uNaOlr3orJ+IP+3iwccMPySi2cHED/gpSHezMKE+X89GNu0G0UkPrG/sdLBv8VKhoUw2EJj8IprYC8UhVADpfq8YYprtHWx4N3lBe/B76gqhZDRoF58bGiqy9gK8Y3AzNxaSHT4iYC4BmiWiqjbz9363g6P2e0XdL0iOkKz0aKomFm6dViNXIhSiWp22mKlAFj291K+KVhYX0cYA1kEfPilUi8EJtkVPDsi8A7y1RlGhk6kMq9HXN4lVFBnDUoq8BljC3nCDaODxfWd1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3lh1fzkUnjQGj6PvFP/FghUbICCgwwYVI0ZThxOf1k=;
 b=dkrHCt8c5Gx9MaPNCLNCsScqqR/XZT4EYZFnPHsmSNh8MiyNJLeUJ3c+w6jWo1FPDfLnL1W6h4bY39sHaSbUnu/BXvzroHk0uMGbFRxWGZo7pMcKD4tlvcKugc8cJgzSn6846JdAyF7Chs0M4bzRNmc0C5Z5OR33B/kgozZILzQ=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 20:04:31 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::6b) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 20:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 20:04:30 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 14:04:29 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <helgaas@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <asml.silence@gmail.com>,
	<almasrymina@google.com>, <gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <wei.huang2@amd.com>, <bhelgaas@google.com>
Subject: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
Date: Fri, 15 Nov 2024 14:04:11 -0600
Message-ID: <20241115200412.1340286-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241115200412.1340286-1-wei.huang2@amd.com>
References: <20241115200412.1340286-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 055f1143-4f04-4fd4-b12f-08dd05b0b780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFZZf6JW0+5VryGxwUx4YpCm1suqSonflYpAqnmY4QX92i6v2t5zDhgRcuk3?=
 =?us-ascii?Q?NN1CGoWDnEitTXQyafY+bU6cRWlmkOez1IkjxZDmcNBCEzpuWTVMaRUY9FLa?=
 =?us-ascii?Q?f5S4lB7e2Vef0pLqyAX1jcjW/6sSYrS9OOjCWZLN1vpRWACw/reLMLCNx/EE?=
 =?us-ascii?Q?Qk7+raQR0TlTQFH3/W2T440Mnz0jeZ0djgwnkOak4T54Of9aE9XT4BsX9zOv?=
 =?us-ascii?Q?rG/fSazSPxn6+ZJQROKD/V1EsYfhRgN1X2p1xW6KbOH4ZzOALgL7gp6/+/VI?=
 =?us-ascii?Q?x6zDAf/SthuOr87ah74m6sEFfBhpC3KJVIlo4b982RriZb24FQb5ZDPBhgyc?=
 =?us-ascii?Q?qBPV1acKRlJK5emcRgQrdmB+wRZPwEuthlJuMnurqTYX2jkzo22C531qIaCs?=
 =?us-ascii?Q?Ds0zJh9KC1nOjiFnnx0NGQ5U+v+uyzoWJipu8I0rD2LLFnIZyWmBXFGtoV5p?=
 =?us-ascii?Q?pRQI+Lr7utjt2XFFhu24sANX0TBu7PtWJRqUDFi8CdOpjzjsitnGIF9jt/tb?=
 =?us-ascii?Q?i3PAnBorLtYkYdiO1yE0/7gBrnVH3ezbdrCs3j5ZiFaV+LGfRB77ETTA2YxQ?=
 =?us-ascii?Q?TPEdfCsRT2atR4B/ARBbTe6sWcgX3FW3hTEREeDBr2RNWwFskVO1JfE2fcmg?=
 =?us-ascii?Q?FwwFnx9JfOZGa9Bo+VFFwvUJyn+ZPe8sROys907JD5nBAul3jVN04MpXsj4K?=
 =?us-ascii?Q?Ag8ev/xCIcnHSFHoXuNPbKs9ENVT+oQYQR5h8k/lisu96T8maLELBzpYM+Pt?=
 =?us-ascii?Q?c4FmV/OCu6Gyis/P4UzKmvrkgnIRpxOtOZDu+IE7ZCpLOKDjnULmVrfoTFeh?=
 =?us-ascii?Q?tNxfUoQAG8ijwqmg/T81FxJsWCQmoxx8kNICnbOPG1XcjtEfbTguS4Hi8cev?=
 =?us-ascii?Q?U9Y4EBsN2mzXF/4CKeNKdYwIPZ4G4r07qlJsyUPNdCOSsCWQaiwEtaXM93HW?=
 =?us-ascii?Q?vS/ndtkXg0G8FiJwlRN5Up4Qckkmao6xpJYuc2cwc9IIUgnmSthL1lb4RiJ5?=
 =?us-ascii?Q?O4tQiaegtwELymVVlDv56wxyRdc5FFKZOR3cchDNnCv7gzy8O1vmiqLKC2ZT?=
 =?us-ascii?Q?jPRJmSzW5zun7GNthtRDshFV2TnQAVdpdtPSqNMTtXIy8Xrw1yRPphFtQG/Y?=
 =?us-ascii?Q?aAmW54rF6fnMJugAW98kbfOhaBnpX5GwlUxl78Z/cHvc3HStyhBlLhPJQIXI?=
 =?us-ascii?Q?MSvJeIaR2vtKQWTizLed+DX1sZH9YzN8I8W1nB40Jp2dtmklyVNrdgvoEvxJ?=
 =?us-ascii?Q?o8hxTrJseg+V5e6LIz6GW5qO8574M/0jSF+CCOMkEbkpDkAJ//a83EKSGKak?=
 =?us-ascii?Q?ID/ev1mcrI2PQamOKQ+gKbw3yomAZl/oZWVQjYxWyk+UzZPDU5BgkNmW6u9/?=
 =?us-ascii?Q?KO3fZ1nZfOLpQc9OyaUrQy3wdcZEMDB3ykZnEmvoN713SPnaIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:04:30.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055f1143-4f04-4fd4-b12f-08dd05b0b780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533

From: Manoj Panicker <manoj.panicker2@amd.com>

Add TPH support to the Broadcom BNXT device driver. This allows the
driver to utilize TPH functions for retrieving and configuring Steering
Tags when changing interrupt affinity. With compatible NIC firmware,
network traffic will be tagged correctly with Steering Tags, resulting
in significant memory bandwidth savings and other advantages as
demonstrated by real network benchmarks on TPH-capable platforms.

Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 103 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   7 ++
 net/core/netdev_rx_queue.c                |   1 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..beabc4b4a913 100644
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
@@ -10865,6 +10867,81 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	return 0;
 }
 
+static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				     const cpumask_t *mask)
+{
+	struct bnxt_irq *irq;
+	u16 tag;
+	int err;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+
+	if (!irq->bp->tph_mode)
+		return;
+
+	cpumask_copy(irq->cpu_mask, mask);
+
+	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+				cpumask_first(irq->cpu_mask), &tag))
+		return;
+
+	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
+		return;
+
+	rtnl_lock();
+	if (netif_running(irq->bp->dev)) {
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		if (err)
+			netdev_err(irq->bp->dev,
+				   "RX queue restart failed: err=%d\n", err);
+	}
+	rtnl_unlock();
+}
+
+static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
+{
+	struct irq_affinity_notify *notify =
+		(struct irq_affinity_notify *)
+		container_of(ref, struct irq_affinity_notify, kref);
+	struct bnxt_irq *irq;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+
+	if (!irq->bp->tph_mode)
+		return;
+
+	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {
+		netdev_err(irq->bp->dev,
+			   "Setting ST=0 for MSIX entry %d failed\n",
+			   irq->msix_nr);
+		return;
+	}
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
+	notify->notify = bnxt_irq_affinity_notify;
+	notify->release = bnxt_irq_affinity_release;
+
+	irq_set_affinity_notifier(irq->vector, notify);
+}
+
 static void bnxt_free_irq(struct bnxt *bp)
 {
 	struct bnxt_irq *irq;
@@ -10887,11 +10964,18 @@ static void bnxt_free_irq(struct bnxt *bp)
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
@@ -10911,6 +10995,12 @@ static int bnxt_request_irq(struct bnxt *bp)
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
@@ -10934,8 +11024,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
 			int numa_node = dev_to_node(&bp->pdev->dev);
+			u16 tag;
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
+			irq->ring_nr = i;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10945,6 +11038,16 @@ static int bnxt_request_irq(struct bnxt *bp)
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


