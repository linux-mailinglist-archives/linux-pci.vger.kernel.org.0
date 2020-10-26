Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF92988D1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 09:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772320AbgJZIzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 04:55:38 -0400
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:2305
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1772299AbgJZIzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 04:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtQqth3YadX652eP3M0dreCrCJ+oVhs7dAJEU1SMPeKruIn9VeR+eUBZccx5Oo7ustKyymElhMay+lX06S8n2Jn4cQztVtGsgSsfZJi9gMaPgSPiAFfHV4K3wqMZ4B0sqWY11bGTjrZ6unDrDzPur5EZLGIk+8/Llg8vBYNSIabuUeBGUd3NP0ePjsFbxXLBuAjLIBNSu0gwRN8gU1Xyqg6J8oL+IsuP+ug2gLKBYQUMACx61YX42tpGlpemXbIb5ARqH8fhTXLX6F9jzni+84T18JHeVbOXFpofJz5ixfbUVFPWvGstQN/ci1nNRyOp/3Es1u5kLQcCAyIE+4La4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCoXnrrJkJppmeGuObwzrHxnbbvY1U2r5QcFMn9JZk=;
 b=b68Lb0lvT2wG9r2YRMZjCK+LtkZin+SxP4oPwFxCS4kfQ4I11XmfFYglYrnwnCpJhpr9xlDBqRRqbBUkhC4z6tdBdPx2RF+A0QCl9Vf4W0Rpk1C6QnppW6g4pARj+Q9DdwzDwJlLItpsJROoz8wsJfFZtCVwtiaewhveU1L0A2qZXSf+iMHpieXsvjOj+5/aAKCoWexPMxdUVU7XJcQ9arzQFEzusXv4abje6xwcEfHQHvPUxnv2dfOhwm5kxurteZo3D8V46zJ4oC6ijQmDd8iaJD7EPBxWKJ0StBAA+wGRW9VQdhdtGxCDt0GwqahxaPXoPwqrP97HOh2SODit1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWCoXnrrJkJppmeGuObwzrHxnbbvY1U2r5QcFMn9JZk=;
 b=GInoFV7LBNFCNAaIwC1Qgca7SW6jqS9c2RXm4A5kBswVE1YJSUrx+c2MidTtEc06efOU2KvPSc/iFDfAPfGIMm3RV9Z66hTcCsmNQGz14H6s0dpP/3Xgo8EURB5zFIVkAl/z4JS4Dzp7XgczpbGcebD8r8ZQJfz2ABKWFSDHqTM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5758.eurprd04.prod.outlook.com (2603:10a6:803:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 08:55:31 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 08:55:31 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V4 1/2] misc: vop: change the way of allocating vring and device page
Date:   Mon, 26 Oct 2020 16:53:34 +0800
Message-Id: <20201026085335.30048-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026085335.30048-1-sherry.sun@nxp.com>
References: <20201026085335.30048-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:3:1::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 26 Oct 2020 08:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b7488a1-6ec5-4515-90c5-08d8798ce44f
X-MS-TrafficTypeDiagnostic: VI1PR04MB5758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB575800A9B4FEEB5749934D0C92190@VI1PR04MB5758.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feXYrWnc6XZWhBzIA0iPYa5ZjYMcOBrAHsH1HQMSPSgb+HpIKvzrmf5+HkcGiE+4TVKgxnvroVxjH4XiJMKbl/Wuujt2AoKqgwZ39j7onrDbvbqlqJ4yRMzjiAYNmp03AHiwVaA6aS2WF0mFjdqCtPxHXIamFXcBCO99rxSqBONIk+5M2D0o+mpAuX1sWYLtpHJa2/UYrIv2/D0i9irLaD/37EfpukWPddbiH456n3IMTcLxdx+LOUeaCLR80pe2jguiTi0vyN2jOEsXbEQa8W4uuSs7VbJwKGRJCKQCgxHS4qqRrQGr6FMyCYjkrnSR35QcXUJFBruD0/E2OCfvtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66476007)(8936002)(316002)(86362001)(956004)(66946007)(36756003)(66556008)(6512007)(83380400001)(4326008)(2616005)(1076003)(6506007)(6666004)(2906002)(186003)(26005)(8676002)(6486002)(16526019)(5660300002)(52116002)(478600001)(30864003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IEArs2nUNow/Izo681JyDtcAL0fiwkcGQIcsB9YfEhoNjIdbO0CHGKK75sNdzCAxmQXSK7SrvV+MpljTjkuE3MCOeFwyTdfOwQJ0BDwl1y3g0gsCiNaUSEK/z+pn6tByWTxa00ZU8/+lMVBv7RMc1PuIFUe4o9pGoWKoRlJYfMMo2sH9gnXDSz2XBwEU1/+3IdXYq1AvkdWTmrkaTuVBuRjUkYQgjYaSZ0yr9qjh5YOn6myFQ7domlMVCNWl/FIw3f0Mrk/Lk/gyx9kUJUJf+SbQP6f+6aHbo7Aw6r92IsUjvd1nr5s/9ZEHvostRWETpgslK3QKkgeTm6RNyuP53fFgoIELsz5DmivGy2/OfKPfUVAk9nScHQAymvWuEZTmg97IciFbykfwb1jHoD/q0ZHX5jrg5HnpdTxBvl2U13/nhKDO+e0qGOXlFFdxxJrnwmf9tGV4raj60zLdsoz73yueZrNCh2LRZT+t8Rmrn0uCHQo5tejZUm0PC7aSVCHQlpAjMPL9OUi4PnmFdyD01pKv3pXLoe1AWdRKhDcovKycN2mR2gIgRDH1fUdpdbYtDGdkZjdzlWBm1GG/VXuXfjFgrm721CauMLPIUHFPypQeI0sywLZ9i4gVe5sB/u/hYFGHPvf0bbNQDZvfFJoM+g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7488a1-6ec5-4515-90c5-08d8798ce44f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 08:55:30.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8OmU9WWFJSlemJ7+6rbQdJKj0ipft3uJNXDNxeUuvnDm927V9tFj7rSTXMddXyTNkeg1vr9J6zeBWZy3Lyz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5758
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocate vrings use dma_alloc_coherent is a common way in kernel. As the
memory interacted between two systems should use consistent memory to
avoid caching effects, same as device page memory.

The orginal way use __get_free_pages and dma_map_single to allocate and
map vring, but not use dma_sync_single_for_cpu/device api to sync the
changes of vring between EP and RC, which will cause memory
synchronization problem for those devices which don't support hardware
dma coherent.

Also change to use dma_mmap_coherent for mmap callback to map the device
page and vring memory to userspace.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/bus/vop_bus.h    |  2 +
 drivers/misc/mic/host/mic_boot.c  |  9 ++++
 drivers/misc/mic/host/mic_main.c  | 43 +++++------------
 drivers/misc/mic/vop/vop_vringh.c | 79 +++++++++++++------------------
 4 files changed, 55 insertions(+), 78 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index 4fa02808c1e2..e21c06aeda7a 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -75,6 +75,7 @@ struct vop_driver {
  *                 node to add/remove/configure virtio devices.
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
+ * @dp_mmap: Map the virtio device page to userspace.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
  * @remap: Map a buffer with the specified DMA address and length.
  * @unmap: Unmap a buffer previously mapped.
@@ -92,6 +93,7 @@ struct vop_hw_ops {
 	void (*ack_interrupt)(struct vop_device *vpdev, int num);
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
+	int (*dp_mmap)(struct vop_device *vpdev, struct vm_area_struct *vma);
 	void (*send_intr)(struct vop_device *vpdev, int db);
 	void __iomem * (*remap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 8cb85b8b3e19..44ed918b49b4 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -89,6 +89,14 @@ static void *__mic_get_dp(struct vop_device *vpdev)
 	return mdev->dp;
 }
 
+static int __mic_dp_mmap(struct vop_device *vpdev, struct vm_area_struct *vma)
+{
+	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
+
+	return dma_mmap_coherent(&mdev->pdev->dev, vma, mdev->dp,
+				 mdev->dp_dma_addr, MIC_DP_SIZE);
+}
+
 static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
 {
 	return NULL;
@@ -120,6 +128,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.dp_mmap = __mic_dp_mmap,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.remap = __mic_ioremap,
diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
index ea4608527ea0..fab87a72a9a4 100644
--- a/drivers/misc/mic/host/mic_main.c
+++ b/drivers/misc/mic/host/mic_main.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/mic_common.h>
 #include "../common/mic_dev.h"
@@ -45,33 +46,6 @@ MODULE_DEVICE_TABLE(pci, mic_pci_tbl);
 /* ID allocator for MIC devices */
 static struct ida g_mic_ida;
 
-/* Initialize the device page */
-static int mic_dp_init(struct mic_device *mdev)
-{
-	mdev->dp = kzalloc(MIC_DP_SIZE, GFP_KERNEL);
-	if (!mdev->dp)
-		return -ENOMEM;
-
-	mdev->dp_dma_addr = mic_map_single(mdev,
-		mdev->dp, MIC_DP_SIZE);
-	if (mic_map_error(mdev->dp_dma_addr)) {
-		kfree(mdev->dp);
-		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
-			__func__, __LINE__, -ENOMEM);
-		return -ENOMEM;
-	}
-	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
-	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
-	return 0;
-}
-
-/* Uninitialize the device page */
-static void mic_dp_uninit(struct mic_device *mdev)
-{
-	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
-	kfree(mdev->dp);
-}
-
 /**
  * mic_ops_init: Initialize HW specific operation tables.
  *
@@ -227,11 +201,16 @@ static int mic_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mdev);
 
-	rc = mic_dp_init(mdev);
-	if (rc) {
-		dev_err(&pdev->dev, "mic_dp_init failed rc %d\n", rc);
+	mdev->dp = dma_alloc_coherent(&pdev->dev, MIC_DP_SIZE,
+				      &mdev->dp_dma_addr, GFP_KERNEL);
+	if (!mdev->dp) {
+		dev_err(&pdev->dev, "failed to allocate device page\n");
 		goto smpt_uninit;
 	}
+
+	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
+	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
+
 	mic_bootparam_init(mdev);
 	mic_create_debug_dir(mdev);
 
@@ -244,7 +223,7 @@ static int mic_probe(struct pci_dev *pdev,
 	return 0;
 cleanup_debug_dir:
 	mic_delete_debug_dir(mdev);
-	mic_dp_uninit(mdev);
+	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
 smpt_uninit:
 	mic_smpt_uninit(mdev);
 free_interrupts:
@@ -283,7 +262,7 @@ static void mic_remove(struct pci_dev *pdev)
 
 	cosm_unregister_device(mdev->cosm_dev);
 	mic_delete_debug_dir(mdev);
-	mic_dp_uninit(mdev);
+	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
 	mic_smpt_uninit(mdev);
 	mic_free_interrupts(mdev, pdev);
 	iounmap(mdev->aper.va);
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 7014ffe88632..df77681c97e6 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -298,9 +298,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		mutex_init(&vvr->vr_mutex);
 		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
 			sizeof(struct _mic_vring_info));
-		vr->va = (void *)
-			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					 get_order(vr_size));
+		vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size, &vr_addr,
+					    GFP_KERNEL);
 		if (!vr->va) {
 			ret = -ENOMEM;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -310,15 +309,6 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		vr->len = vr_size;
 		vr->info = vr->va + round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
-		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
-					 DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
-			free_pages((unsigned long)vr->va, get_order(vr_size));
-			ret = -ENOMEM;
-			dev_err(vop_dev(vdev), "%s %d err %d\n",
-				__func__, __LINE__, ret);
-			goto err;
-		}
 		vqconfig[i].address = cpu_to_le64(vr_addr);
 
 		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
@@ -339,11 +329,9 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		dev_dbg(&vpdev->dev,
 			"%s %d index %d va %p info %p vr_size 0x%x\n",
 			__func__, __LINE__, i, vr->va, vr->info, vr_size);
-		vvr->buf = (void *)__get_free_pages(GFP_KERNEL,
-					get_order(VOP_INT_DMA_BUF_SIZE));
-		vvr->buf_da = dma_map_single(&vpdev->dev,
-					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
-					  DMA_BIDIRECTIONAL);
+		vvr->buf = dma_alloc_coherent(vop_dev(vdev),
+					      VOP_INT_DMA_BUF_SIZE,
+					      &vvr->buf_da, GFP_KERNEL);
 	}
 
 	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
@@ -382,10 +370,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 	for (j = 0; j < i; j++) {
 		struct vop_vringh *vvr = &vdev->vvr[j];
 
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[j].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+				  le64_to_cpu(vqconfig[j].address));
 	}
 	return ret;
 }
@@ -433,17 +419,12 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		dma_unmap_single(&vpdev->dev,
-				 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->buf,
-			   get_order(VOP_INT_DMA_BUF_SIZE));
+		dma_free_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
+				  vvr->buf, vvr->buf_da);
 		vringh_kiov_cleanup(&vvr->riov);
 		vringh_kiov_cleanup(&vvr->wiov);
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[i].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+				  le64_to_cpu(vqconfig[i].address));
 	}
 	/*
 	 * Order the type update with previous stores. This write barrier
@@ -1044,31 +1025,25 @@ static __poll_t vop_poll(struct file *f, poll_table *wait)
 
 static inline int
 vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
-		 unsigned long *size, unsigned long *pa)
+		 unsigned long *size, unsigned long *pa, void **va)
 {
-	struct vop_device *vpdev = vdev->vpdev;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
 	unsigned long start = MIC_DP_SIZE;
 	int i;
 
 	/*
 	 * MMAP interface is as follows:
 	 * offset				region
-	 * 0x0					virtio device_page
 	 * 0x1000				first vring
 	 * 0x1000 + size of 1st vring		second vring
 	 * ....
 	 */
-	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
-		*size = MIC_DP_SIZE;
-		return 0;
-	}
-
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
 		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
+			*pa = le64_to_cpu(vqconfig[i].address);
+			*va = vvr->vring.va;
 			*size = vvr->vring.len;
 			return 0;
 		}
@@ -1083,8 +1058,11 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 {
 	struct vop_vdev *vdev = f->private_data;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long pa, size = vma->vm_end - vma->vm_start, size_rem = size;
+	unsigned long offset = (vma->vm_pgoff << PAGE_SHIFT) + MIC_DP_SIZE;
+	unsigned long pa, size = vma->vm_end - vma->vm_start;
+	unsigned long size_rem = size - MIC_DP_SIZE;
+	unsigned long base = vma->vm_start;
+	void *va;
 	int i, err;
 
 	err = vop_vdev_inited(vdev);
@@ -1095,19 +1073,28 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 		goto ret;
 	}
 	while (size_rem) {
-		i = vop_query_offset(vdev, offset, &size, &pa);
+		i = vop_query_offset(vdev, offset, &size, &pa, &va);
 		if (i < 0) {
 			err = -EINVAL;
 			goto ret;
 		}
-		err = remap_pfn_range(vma, vma->vm_start + offset,
-				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+		vma->vm_start = base + offset;
+		vma->vm_end = vma->vm_start + size;
+		err = dma_mmap_coherent(vop_dev(vdev), vma, va, pa, size);
 		if (err)
 			goto ret;
 		size_rem -= size;
 		offset += size;
 	}
+
+	if (vdev->vpdev->hw_ops->dp_mmap) {
+		vma->vm_start = base;
+		vma->vm_end = vma->vm_start + MIC_DP_SIZE;
+		err = vdev->vpdev->hw_ops->dp_mmap(vdev->vpdev, vma);
+		if (err)
+			goto ret;
+	}
+
 ret:
 	return err;
 }
-- 
2.17.1

