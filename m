Return-Path: <linux-pci+bounces-7304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AA8C12F8
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D74281669
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F68171E5A;
	Thu,  9 May 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kc8M/8KD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427414B097;
	Thu,  9 May 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272176; cv=fail; b=e6zyrIrM9pFcfvfHtzJ6O6pR/QmOm96z3SPC8Lv9qAtPtJWak1cbi7bEGN/Ekg0FWYsFXjRlnTj6AjM6AYoPDV1HgKClFbbQGUFktYbRutlKFpNCuSIWbwt8DURWgni4JjIn/QTX0AuS6nDHsObLnd9gVudSdb3PK3bui1s0sTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272176; c=relaxed/simple;
	bh=Ha514QROtKdlMtS0+TefLRII82zy23bFfJakZLMVS+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn4JwKXFO5mqUHx28LP0AtJL6RQsW2ZA1GMu0LYGuZQse749SD+3WnCcmPzHgcb6IbT/w31f0GABhpDt0OWe2k33hJ6EXTpAMcZOsLRu/aPixstw0un+E4ygI7sxAGCHTWV5QnCUkxUKUlnh0QpWNw/CjDOFy42a9g1Jiw/DPcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kc8M/8KD; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg0LYIzlrkncKNC+wg/PdM51eWEGIty9A4Z5CVF9+efX6k9/9s/dnOyBVt54GS6aB3gwdYI6nS5FWcwdNKjPW9B+JtKXzk7+6dSE+CteLNVCP94jIxnW9sjQDe7Bj/1TjiPWdahd8XdJWmlXp7BPz+1TR/LBzkn+NHURXHV0ZiIfiWzBf96kvBh4QiLLd3agiIaPWFQplMHg8rbEYSlHYKDkBGlwmBS1OJdN6znadFKOyhPOsC4bGQGud8OwOVZ5PmTUUSDppEfsdVd/vbnKCUI+JGZQM7wMnHS9hNVf7fCQ1xAultoZLpZz7MV1lnKSWq9pqXw9oU/xvQpUsXIFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoeapxQV/SXRV8ErW6IRaRhOI6nkWb2RIxsMSWcdyFw=;
 b=TU7MwISbmTB8KMq4CmNSMWjmNIrTGEicXMhhfZSwCzMR0bBLhL3u2InrjhO8hICG0tGH29W5JyEkbrY2CE0uwFeyU3Djaqww62zCq7sDUFCO4Czc0fQNatdiWg08lhadpmUAUL826BqxQu0MFHliZbsuXyUNk6h74QvSMwlw0mBC1pGRfGYY233xg9eT1/Sz0lwK1N1lBJONu+QRAzytY521s/oz3HBpfn0SK/7VWKDMzbAl2lWUihwQZYNunxVOGX0mggnw45IhEfnGJhmNUOkc+R3uRv5cakaGoB4Q3TifoWwJnFgNwy7X3e+NzOaarEKRICpp2dlzxJQEuUVLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoeapxQV/SXRV8ErW6IRaRhOI6nkWb2RIxsMSWcdyFw=;
 b=Kc8M/8KDYM5Hg2JZ3zYCMlhWAW82LysV66Lobp/lhiD9u6sFvqJNKkUmTp7gPqSC/lLu+FwGzc+XL0uxe3VnTbuLr75Brrd0KlgMrYx3tsUJRVlQyFSXGofqY2WhFPcyOlzg3X6yjjnBY4iC/BTX2M+/vD/1Sn85hPyO2LRadqk=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 16:29:29 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::d5) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.13 via Frontend
 Transport; Thu, 9 May 2024 16:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:29:25 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:29:24 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
Date: Thu, 9 May 2024 11:27:40 -0500
Message-ID: <20240509162741.1937586-9-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 167b7c77-fa97-47d5-73d8-08dc70453117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dShViuThvXNzdOQEHpjPiL0yIX9TbvxCAZgtlaaiUMLf7cfelZIjU4Pgpn0n?=
 =?us-ascii?Q?7CAmy4orOOwfxSaULPuuHlrlC5cbCRcXY6Sd8njA7ol1hNShT6JgoCX+yGCp?=
 =?us-ascii?Q?tS2SArtyjnr2pcm7LrkwBTORwB3UcmKp4dYn/x0/uMSD3++E009iZJJnOH+o?=
 =?us-ascii?Q?n6FQtgG/Dg+N73uOU8Wxcs/ExnFzJw+xkaphB6YZTiIQqKJjTxfhL5NMQvj5?=
 =?us-ascii?Q?MgeDAEb2XkqJZBhCCrVzHlvuX+cGGjVmrYW3sNLI1sa/ridQJi7pdsfNpLbK?=
 =?us-ascii?Q?S0l/9bIBclyKHsj9ykVOWv0+nAT/gzbMRtWJLnMmR3Nr2VMggzZ+QALLS8Eh?=
 =?us-ascii?Q?7B4k/+93O5aWNZoP0Vs+Nw89N/6WgozTrEmcsF/yaxBAzIORBPwRqhTBKtDc?=
 =?us-ascii?Q?gvAyn0yp295SxIzgke11QuMIddgRlDlEQQC43JHw1WD2xit1cPd1Wi2f72fO?=
 =?us-ascii?Q?GL4zBs+NiQhjue0BBHYB4FYCOrigf9+BCRNojs4eMAr3jRj5a+iVGWdWZt0S?=
 =?us-ascii?Q?zCn80V8lOQ9uboRiR1j1qBIfGiatfxg5lVwrJpfrMYLoBT26lbYkLhnTm428?=
 =?us-ascii?Q?TNKtIVfx6WGe2oW6F3SOFfrsvwFibdAUdKLxeZ5kL10oOt5qytqcmEj66CT2?=
 =?us-ascii?Q?MDtvLtjfzvdquIGG2hXRl5NK0LRGNjPBtd1N2Sl9l1tanQnqWDbX7Q5wE6jE?=
 =?us-ascii?Q?YkANJcTNI4JY+cj79GC2RAUMLHUA1spsouQJQhRwPv4hEGMpokweqWP5Fgyw?=
 =?us-ascii?Q?R8Ow3VygkDZnGxbBKRjkV8AblpbQ+E5s1beGL6a01mDY5I9svnreA+eF9bx4?=
 =?us-ascii?Q?x/27PqBLSlzyJJbyUyuRcxwIi9Nmi3ph/bAc0gPCWLq9p2qk+p77BhzpX/kl?=
 =?us-ascii?Q?hfQsv5Enf1rFPsoUgQWX0ZO2SIcKWKQ8pBPjkl7J9u/NfDWM9YRnf32ZZ6O4?=
 =?us-ascii?Q?sctEA/awTwIKtYC4/wAPmmWugx7x0ya6/MZVg9rilQU26llQv9Ph2z7x86Xa?=
 =?us-ascii?Q?NaGmoA9XoE9NaAmr2X5WM4F0Yyq1o6Qz5LGE+UAm4GEPhkc6qDV3uQCt7UAV?=
 =?us-ascii?Q?PYVfCT/uSbVWzwXBwSl8kglypINZTC/7sMeE1pDGO45hotLK4Qhuaa2Kc+1u?=
 =?us-ascii?Q?pJ5xM91rTjVckCcvVXf82Bt/Vfyo7b86Hqhxm2JjFi6/jbK41EONQmlkdmuE?=
 =?us-ascii?Q?Pw7KtrBJttaQ7OwwhjsbOSVz9lhsPrOZyQqnckVG9+gANfWFf3+nZlhs5ZmB?=
 =?us-ascii?Q?nbysHacFADojzU4UfNW0Z/+5ETVHqqrptzqug/kaQPEeCs/q0wvE+3g7GjZD?=
 =?us-ascii?Q?PWtmCqr7N8FQ1kzoYONJjB5mFztY0e/qDceNu2im4MHC03G7/Zmni+I0mXFs?=
 =?us-ascii?Q?X650ScmgRsJgLUc3geQ1A5xhwB3T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:29:25.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b7c77-fa97-47d5-73d8-08dc70453117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

From: Manoj Panicker <manoj.panicker2@amd.com>

As a usage example, this patch implements TPH support in Broadcom BNXT
device driver by invoking pcie_tph_set_st() function when interrupt
affinity is changed.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2c2ee79c4d77..be9c17566fb4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <linux/pci-tph.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
+			irq_set_affinity_notifier(irq->vector, NULL);
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
@@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
 	}
 }
 
+static void bnxt_rtnl_lock_sp(struct bnxt *bp);
+static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
+static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
+				     const cpumask_t *mask)
+{
+	struct bnxt_irq *irq;
+
+	irq = container_of(notify, struct bnxt_irq, affinity_notify);
+	cpumask_copy(irq->cpu_mask, mask);
+
+	if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
+			     cpumask_first(irq->cpu_mask),
+			     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
+		pr_err("error in configuring steering tag\n");
+
+	if (netif_running(irq->bp->dev)) {
+		rtnl_lock();
+		bnxt_close_nic(irq->bp, false, false);
+		bnxt_open_nic(irq->bp, false, false);
+		rtnl_unlock();
+	}
+}
+
+static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
+{
+}
+
+static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *irq)
+{
+	struct irq_affinity_notify *notify;
+
+	notify = &irq->affinity_notify;
+	notify->irq = irq->vector;
+	notify->notify = bnxt_irq_affinity_notify;
+	notify->release = bnxt_irq_affinity_release;
+
+	irq_set_affinity_notifier(irq->vector, notify);
+}
+
 static int bnxt_request_irq(struct bnxt *bp)
 {
 	int i, j, rc = 0;
@@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 			int numa_node = dev_to_node(&bp->pdev->dev);
 
 			irq->have_cpumask = 1;
+			irq->msix_nr = map_idx;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
 			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
@@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
 					    irq->vector);
 				break;
 			}
+
+			if (!pcie_tph_set_st(bp->pdev, i,
+					     cpumask_first(irq->cpu_mask),
+					     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY)) {
+				netdev_err(bp->dev, "error in setting steering tag\n");
+			} else {
+				irq->bp = bp;
+				__bnxt_register_notify_irqchanges(irq);
+			}
 		}
 	}
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dd849e715c9b..0d3442590bb4 100644
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
2.44.0


