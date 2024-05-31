Return-Path: <linux-pci+bounces-8150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A746B8D6BD7
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DF0B253E8
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494F7EF10;
	Fri, 31 May 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrBrVAeo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE6132103;
	Fri, 31 May 2024 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191661; cv=fail; b=TeevGTNTpvFxIHlw7eSyKkl/VirfuBqNXkXM7efpxNlUHwAwjIJHoA+CBudBNgLrW8c4O7zGFcYFqZHNlyQmtpjruk71VTt3oCG1AkP1qOJM/a95hD41vBLb7CNrgjYB0djfu5tcc4+7JzDpRwHjOIQe67gJHLve572Ey6nQ7m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191661; c=relaxed/simple;
	bh=gVAPO8A9qbDZ3d3KKdX8upTYxJ7EQYzYoBu8myehXHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Ff1/NZsHs08FiKEWFY1rVTCDYBkcJ6tnZV0K5n/a2BRjbKg7q6ybdRDHwVM/siV7x6c/fXZfHKupwS5Hmw0AFbDgzMeeWoi6bmQioqbXgg+DrQ9pBgPjd5anPheSonnLF5vCTkcArluItSFJ3XQ7tt7Klw878ZXxPLCrJ23pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrBrVAeo; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIM7k8qzwkswhMxD6aYaewq7+1GF9t0o8ln4vpLw6ZGkwRNFOw8wCrYWp/HN2H0ye6S7m4ZtwMudQuQNmloqvodXKx3PZ/R12cTn0ey+Rr43v/hcI4t/iR4j/zL+R8CWGU23xhq+sMYyqgfsayYXlcdgFouw0jfno0SyTjMkjpyjWhrZp8ci8K7KI3yux1vdEZeE629CVem7WmRSUiq8iRQs9M7wBhCUvAg8L/x2D/15rQTmw1U0ySM8ipW6qIhmsBp7zL3dqMs1GtVHDfpyS0q5w5EFDBjq1wwBDEookq5jyI2y2zMUts2RRki61FtdIpIeeWc7Vzp/CuZmmosp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFreZlJ6kEVOKJTpADeeDAOTkBq0d7DEUnWEIsazckk=;
 b=MTVTHDlwHZJNJfS0b7dpFTsLbnWqrRvVWlnApAjevIusUarsr5FvpCoPstUDT++McXgQFYcLRZ5aGtWkKn2qa5Kc5EH8HrUYztxYrlOrHS/77MvSogJXNhfGN76Pnx9paWz9z4Uq96yVRpWFDNWIjPpGG4Lt9g43ntu3mQ8t6XBQTGIVJyC+wTcTwvKsImQbKmbP1rQ6yJTNoAwXXWDwjd6cvxD3qx8KsXNhCK2yL+usIso/j5D/gE6RR8QW5lBbxRpY+PAGttZrLYFl16XW1/EY8ViTDFkv2DBUgCG4pw/zYqNwJq9Nz4mOxkzMCP7wJy8qAzCvXmKwMHbDJ5k5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFreZlJ6kEVOKJTpADeeDAOTkBq0d7DEUnWEIsazckk=;
 b=QrBrVAeoZvkEhsFQF4oddW2fHnHSmuXdXaj59QgTbgwG7DH8+TqgNFKG0DH3XNpvnyOKJdTwSmNd6xsHdFakmfTY3BwU8ljnPEkfcSjEWt/bLz2ecOkxLwwTq0HbVez4Pdhw+lIRRVDAbpQ6tWpSjC37o/0aSlKlGiZtmWn5VqQ=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 21:40:57 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::62) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 21:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:40:56 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:40:55 -0500
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
Subject: [PATCH V2 8/9] bnxt_en: Add TPH support in BNXT driver
Date: Fri, 31 May 2024 16:38:40 -0500
Message-ID: <20240531213841.3246055-9-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 031bbb94-7464-43e2-d3b9-08dc81ba5aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gyP2XUUPs0SsYrbFVR8FPdi4SQuysLyEP3ysDDZ015zC6dXHK0joaALxXggx?=
 =?us-ascii?Q?TwTTz3Ri9+sIvPwXC8OqTfOKtWK5k4m/F3YBumsqqTwmrbqcMkkpEjIu8bv4?=
 =?us-ascii?Q?W3ti+9VzzpaD6UwyPGg0D9F2xwUC5dgD3wU00lqevj1oXs7DdfPhOMp1MsmL?=
 =?us-ascii?Q?jfRH/Etm/Mt9VT1Az71GEeaf7r6zue8w4TSqyMjo3vBFNbFC6Hpal8lTGWHC?=
 =?us-ascii?Q?cCsTBCJfyx99TbqP8zos0JmJjqihOPVKG7CnUKXluGg6NGg6GUgnvWqOcDr5?=
 =?us-ascii?Q?yM4KnULVgV53AXqjtMcXmVhoydcFNXcKMW2z6gSxl9gmO1Y5CR28KVWfxj8P?=
 =?us-ascii?Q?mXkR+aoQAEH1LKcw6h3kwynygGBo3q+7u3BTbxGPSS7Q/l99DPH0uRNCI1Ni?=
 =?us-ascii?Q?viQHXjS3mD2dic8RPcCxJstB1uXS/DYy1TrA+RdXnewH7kTp1nzCYU27JGtJ?=
 =?us-ascii?Q?LjJpfd9hdfBQk1IDh08crLTAnhcmr7pkUD6P/TM8PneQ8w2OFt1idqpmEfWM?=
 =?us-ascii?Q?yAq42h1zkAcLWLL703s8iQzA20ffI3PGM8F3CEcu99wzhJCWep8j23LDytWJ?=
 =?us-ascii?Q?kvNHdg3GXAHzJgE3WaMt6jVEvKPxfBJb3Ol5LFofAfl7ZxYPxwQ5PGpxCmhE?=
 =?us-ascii?Q?XJ5L5dcZr+MTGPzLb6GsQYutfydkvQYUoBa6csBEE2T7gZhnNnXeVGc48Mso?=
 =?us-ascii?Q?RCq8up5bRChZQx3oi6i+BwnEgHhdR2x9mPdvADJAPmboy/beZwiyqN2mHfXH?=
 =?us-ascii?Q?nJgoJJa9ODkL9zyoOqQif5y+MZqZe5L+F0T2fjuVoXUPNGzAb4vH8Kr5DG0r?=
 =?us-ascii?Q?PCQ0zG0mRQUo7RCmyKOYUXvaj0xdmDeJKjntvqHrNOrHdo/9nVQ/4jidw/iq?=
 =?us-ascii?Q?Hw+XIGCVa5U5DR4aEOYEN5+1Itvi9HWQyqVuJBTwqhX6BbWx66De4ngNYxo8?=
 =?us-ascii?Q?4xkHkeK/kq/ep1sBNE0Ssa8plhnilXq8UMa4x1eTtg6qiHJnrOx6B7FwyJBv?=
 =?us-ascii?Q?JlLmQAjDjeBq6AMOCRmxBeoJv/g7P3B3t4ec8hnzZInzTjzNGzVf1IfmyqU6?=
 =?us-ascii?Q?APbEY00onaa5A/MRjSKmkAm/dBsPzu/6ZQUj3rNG2nXj8aJkpaXF379HMHYM?=
 =?us-ascii?Q?VxP5ahLbA7530IT8zPRoninEfpc79MgkwdXTqQXr3tiNAywjgffkVn8SaAAb?=
 =?us-ascii?Q?eG3Y/Te6DM6YXZvq/KBJq9YHHyi6UjWbGFCiZCPRPx5tXafif4TkSNbabDsc?=
 =?us-ascii?Q?kILzjQ5N2j3zsrY2GljemEoVFfAEAFediPI5plus/DaB6sy+ej5fHWOKBvMM?=
 =?us-ascii?Q?1dyYqT/gjZzzqH5M/NMeI559Yr7iN74+2qX6E5GrMjOcW74ymiSFGHp7s6iX?=
 =?us-ascii?Q?YvCJHf8iNYgx0pNKvmSDu26lI3Cs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:40:56.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031bbb94-7464-43e2-d3b9-08dc81ba5aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

From: Manoj Panicker <manoj.panicker2@amd.com>

As a usage example, this patch implements TPH support in Broadcom BNXT
device driver by invoking pcie_tph_set_st() function when interrupt
affinity is changed.

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
2.44.0


