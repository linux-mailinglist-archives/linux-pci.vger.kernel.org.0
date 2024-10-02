Return-Path: <linux-pci+bounces-13722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4098E161
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B049E281994
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D01D172C;
	Wed,  2 Oct 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGSHyZyv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595501D0F7A;
	Wed,  2 Oct 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888456; cv=fail; b=hpGpg62Vj0icCJz5S8YvXzWjMEXmPPMfhpSumSiqXIEf0nzj8g1jBLSfojz8eVvSa3+Zs88h5OoM/CRwFeW6BzF35fSvdevISr7vVM7H90M7nA2MMMh3g7H3tEP9WUO3n8OcEGnsTiMaVVlk0OYRJXLDBC8+VoRbR35K8r3vge4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888456; c=relaxed/simple;
	bh=ZJGssY2oGWwJP0wcRvNnHd+4b2k3mjLwmhKdNFZ4CSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHk+TId43ih2R8eBdZ1JNjU8HtF4Ayo4guRufHq/ThPeDY+lZQhm4ERRHCq4HyT3hqxweiYJ0ygOnQnQ5Ho78ekotKlm6a8aINrmPN8TD+1nyRPrs+I+UrLBanFXBXM1l9R/t2hru/ikF1FosaqISUCGMGLc1eTk+Ia7A6OU4Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGSHyZyv; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETZQRZaFpZAy26OHFeeXsKpedfPSc6Em5YpdaKcZ65h9AGg+7+bMqZDB2k52XRA/GGVrZlHopqJAtmrcux3yr4woJj59cocgl4jB838TUKE9n9FTpm6+g+eOmNzdNp0BQhsA5agt1ib1ulX/t3mRZhqWTLSN9yzK8Hu+KcZEjWXp9Fq/NtLEjpO9Mklf6PQ4K7J7vikn6HRiPWDwOio3Oe2jB0TC6KiIrAfLQgHtvpG69MgvTJOAjw1c1oWrBIQJneQYC4OFDoCPRPE8WGc09fVIBDV45BqmcyBViZs7viU7uPWOAtZEW2jWwFbBFRX28AOxAVulp2EUAiBE62GZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9ToyhpSl9wVHpET5ZvTlp/uavVyYBFOFmaKWTkzXRQ=;
 b=SZXydXUp+OCvIXBSCG634hLovorxWCm9Izjo5ottZe8z31rUNma3Y54gu2G7SU5tXrDZnwqIfin67sgTY/u4Lfi6Ls6oXttWXN24jFojx8ZIdd+wb9+JeqvgE3+HD08CMQwlh3a4Cjdu4Pf6KITXrP9/n9gnnjjES78k4pIHUZvfhy7W6k+DEvZtZUPnBDjsbfKtb42PF7ujNEpgu8rsRoGgKS5+MOIoP9W3wP8/4zExjodeiElYWDchnMhxQqt3oq434SyU3DWo3VrsuywJ4pc6m/pF7KM00lIAwvx53sOTPosGoTsulM73HqSMWK58xE9x5m84bg2mR6f/Sp2JZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9ToyhpSl9wVHpET5ZvTlp/uavVyYBFOFmaKWTkzXRQ=;
 b=CGSHyZyvKbn0E3+vV/PDCgvqE3fK60g/VQXxUUGm6MLPWuB+S4wPq064Jik/YTed/CTohpcGaS4DL8Sa8CiVS9G553uunh/remQb/xADlaQseWz7NHY39utHe+qXyNIjt6Cg65hW+gbhp4hyJNfbsUKm+/7HU29ElwVKj53wXFA=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:00:49 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::9) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Wed, 2 Oct 2024 17:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:00:48 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 12:00:46 -0500
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
Subject: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
Date: Wed, 2 Oct 2024 11:59:53 -0500
Message-ID: <20241002165954.128085-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002165954.128085-1-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 597d8223-0002-423e-fe28-08dce303c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R7hyqvxH3p60GfGh73KAM3FMXn8Mw/K6flun5JSWu8f30u/HLmVrmPEL+3IT?=
 =?us-ascii?Q?IlXt3unyzwMMzJtkiGas8jEMzGybB720LMC4d+tFaQrHGXhVKRH9ExeHejqd?=
 =?us-ascii?Q?TpK3pZ8GbtX7L2htKd5g8Oa2Q+Ko/Y/UwEAxQ9ctmA+Wy55n7GKZAhFQo9bN?=
 =?us-ascii?Q?0yOQcnQKNFDCh4F73jbyO/N0iOWlrziJ26gbnY+uMcZrjfiUyJ0/6jPMqmsw?=
 =?us-ascii?Q?OW8qPGK9iAB4ZA7mOVVv2PLvZqMtYiLFAthUAxi39FlsMe2LQZIe++Ii7QN8?=
 =?us-ascii?Q?khibasLZZDbXWtjRKUzwWHhIYmCCjwrI/T89rOfZjKOpETQ45nsiWuwgezcO?=
 =?us-ascii?Q?4ImeELxNIDi0QedLaTvo5eJmUHMS8sJ0fjVgnmKnP2gLBh1+6mjqHHww08G+?=
 =?us-ascii?Q?z0Eh6FqEhZzhsUi3BiP86/y6mcwOArxSK2qv7zBtARyWgR1rXs3+olDY69CZ?=
 =?us-ascii?Q?dmBH8JBp6H8SZ1Piv4//pYCNxqzMgBqF2LE+hJITI/rI223UyIyTJ+aWSg24?=
 =?us-ascii?Q?XmcCPrFmsaDnSkn9stFZQ4Wfn5L/1zcB2GCAm6fJ5hCEWh6DaJPzaJRtkdir?=
 =?us-ascii?Q?Z7kRRHKXb/hUG3lch5AGIS4wMrb31SMSCHjL5jRpZfFf0somWYcDoLCuavQp?=
 =?us-ascii?Q?gh/ZsWrek0JoTyYKfVP1Iy7DO6WCn6VLrWce8HH8nATNCKjYRDlvjT3tQpta?=
 =?us-ascii?Q?AiOZjoYbmJNMRk7qMw2fUrIt4pH+wB3YutOHoBDXb6Kjxeio7VH1f9Ly0Nvw?=
 =?us-ascii?Q?rLecuNjQSScF5IMFgk40USopf1gm2OYvbqQIzPZTl4U5prIClQYQNHWSzR7o?=
 =?us-ascii?Q?RbORDs9jQOgcu/ql4HpMALx1Uvf1WAmQVEPGLUku3uTXMzSp7frnCamPAKho?=
 =?us-ascii?Q?CpPWpmuSuBYttMK5vaEACRNBKHU2D4vIiqvvujwGzlO+fJkoWoVlhjf53T9D?=
 =?us-ascii?Q?IVgvKjusERk6p5TpvIk7dtt2UCybnCPx9lkFHvIFI4MGKv/LYNu78cpoM/CI?=
 =?us-ascii?Q?e+wMMMKCGVxgLlQfRLwe3Y97NHi0dpVZRy7i4oBin1c5kxrFXGxbMmfwZJwp?=
 =?us-ascii?Q?sfd/rjOj1d85Kkac4zdBQSqkHXhuIPN4Eh53qAf8c241U6j47/HqDt+4ABEQ?=
 =?us-ascii?Q?U2kneLNh8D+i8K5llkmbqi0XF5fNHz5HiwoMY6qH3VWdOefm3CS76WizVq7J?=
 =?us-ascii?Q?OwRXPzGJlfon3TgzkP4EHXgMh4OGfHobo4cWgUMXliddKig8o08DCJ6lbaZE?=
 =?us-ascii?Q?7rScBMLSCg3F7Z5cW1hbxWh6JLMDx2Qna+2NsKRhIIDHUJcngVU212jeY5N1?=
 =?us-ascii?Q?wfopY81EDt5ivns4KmviG9A2ud5tJVPlcJZwFjaWdtVRC6Gli5NjpFMbcnZs?=
 =?us-ascii?Q?sI3UVvff6iAby7CnCl/TI6LT4xFd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:00:48.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d8223-0002-423e-fe28-08dce303c3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

From: Manoj Panicker <manoj.panicker2@amd.com>

Add TPH support to the Broadcom BNXT device driver. This allows the
driver to utilize TPH functions for retrieving and configuring Steering
Tags when changing interrupt affinity. With compatible NIC firmware,
network traffic will be tagged correctly with Steering Tags, leading to
significant memory bandwidth savings and other benefits as demonstrated
by real network benchmarks on TPH-capable platforms.

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


