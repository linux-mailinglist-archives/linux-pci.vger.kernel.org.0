Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2357529D552
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgJ1V74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:59:56 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:20064
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729294AbgJ1V73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:29 -0400
Received: from VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 28 Oct
 2020 17:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5aE+JMLuTunxmestHONNGm8xGdmAke40m9Y4IcUA8661kXhX2evqm82/VeV743OuhUljJKqfFkx5NOhECGaMk+PN/w4XDyDupL0G9FcrJM14GfIhMKqAh5jgEhp+dsX2l4TFN+qBTHH+SvaiaFGdMoRjZbQ05EUJ+/wlvC8TMqnzvpdsFI0wGwfemlsqHdwd9YCqyqkNthrRfVKGdszvH7U1qKwYnB7QAUrUv1DkrXDuR7N5NuiEi0MCfP0/MoEnVatG87FjrLRh+9egk68cC7+H4XHN6KFzThC5ydorouvTHY+grPwbLQKj6WTHIfhdXG68gVbGORzoU+bbXYpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTTojEIJ3RKW8tiGv/lzoo48v5+aFDdUT++5n7QzBOM=;
 b=RnZhGXhy+M1G5ebf72ZRV02A9Fw8kEnnwRMwqBNyVDrR6+cPIS/NkT1XMdRyr6/PK2zu9KVMGJ+6hkZSIDrcQVcaSbK9LwANSR19YtjI/d6WZ6vhKbybb0ti1jtya0lwMIHIx+NxlqNjrfa8ilJY438+0pmURxQF6j7Bi2ofuOhGn/+ZFYDwNE420xQHOX70SxBCgxYPY83u7DV/MCiHnobzdAfdK5znZl26+IWlGe/KkMbOxJbQVxvpX8WkowfESTtIrIfX9cR94eXge/ZCAUXBTyXpgxBVio1tRTOE6IQhtE58YiaRhGaTzjSE3aPXM9u5idtN3Au/btH7zap4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTTojEIJ3RKW8tiGv/lzoo48v5+aFDdUT++5n7QzBOM=;
 b=Ob2nzo14bzdeylbh0JIHWJk7OsHZ5TiE5uRnZN3RqwyVelLkLXoS5lFkjSr5X87mP/1czEHwVoeXsdlhzCduZ1TUEYVb3G4oV8MdQEvJ0hwxk/YQI+oP8XAjNuTGOetfmK8JxIS7P/BsmHEnaSztvrTcmpBAX9DFmpQruhCPDbs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 28 Oct
 2020 02:04:18 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:04:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        vincent.whitchurch@axis.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, arnd@arndb.de, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V5 1/2] misc: vop: change the way of allocating vrings and device page
Date:   Wed, 28 Oct 2020 10:03:04 +0800
Message-Id: <20201028020305.10593-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028020305.10593-1-sherry.sun@nxp.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR03CA0088.eurprd03.prod.outlook.com
 (2603:10a6:208:69::29) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR03CA0088.eurprd03.prod.outlook.com (2603:10a6:208:69::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 02:04:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 944d90e6-522b-4735-ab00-08d87ae5c737
X-MS-TrafficTypeDiagnostic: VI1PR04MB3229:|VI1PR04MB6928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3229F7A7207A71F7EFA1641A92170@VI1PR04MB3229.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6F9TIUtHpFUTOgJ+NmzyMtK9omOOkW2NEJx3/AZxqXJwngqdCblhuGW3twfS7b9PidLYIT17dqsx8J6IsGG+h3OqbBr0s1Rd3/tivnu9NTp21GyL+L8ReRExy0fGLBLnYDQPmAyoLhh5h8P45ruRf2doF+cSuGmNl3eLNbCJfr4tpa0nuBHB0y5WsGsSODOPr7DoM4Uyx8xaVgZVSG19Bf+tqrP0sgUV4/n1ytuU8B6iCM+Zxbgy/98UQ8o7DEYX4Eu5qIMDMTyGkhUjMwAwqXKX+U33XwwFEd+wPeODGQhaVbKzY7um1bGkRhWDNwdC2aY/YnlsLWingU6gejbuJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(36756003)(2616005)(1076003)(44832011)(52116002)(2906002)(26005)(6506007)(30864003)(478600001)(956004)(8936002)(83380400001)(16526019)(86362001)(8676002)(4326008)(316002)(5660300002)(186003)(7416002)(6512007)(66476007)(6666004)(66556008)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RmaLK1bnmONfjTC6uPK5on/CWdgRn9Y8uCgqygxrrCZsEWHhzkX2qDDK57a24PugGlfHqFNoHBXLxU8hSo8JhrxCcv0k+sLjkXwXthiBHK1wTlAfx+csI4VvT31eALOaF06+zZKAFRo7xDq/93x72r2ymYW4/9HSB29eiT84ba4/F2bVGQp4DecbBXUfvSrh7cGrOawieXxXpaLPuk3hxafSc/m85KgWRki7360yOu5jNwoumSGJZ8TWXAkSEILOPVaXD1sVsWM8lwEurykoTQHIpJ2Q3LOgQ4mM9wERojT3V4mIjBquKp0imeoU+L1oi8LZ/myz+NnZSPTYmOS4zNc+uwgHp9XKqm3+ocU7essuwXjjEf8t4XB8esmIeVDClGkrITQduovmMHn+Zv1ITijx3Xz9LchVCsB1igB2bL7h0GGR3iA1xlHoCdTaFQziRqF6YEEZ3AkN8fTC9rAXNMtacXPwrS+nDBgJReOWACmwyXEhH/LBEUraZZCLMaQFeC5NeEHHVoehc2vK3BiNgsZwE5DIjY0h8IDutdACq8M2aw8BWw4Sa2bbV0wMWwmaObpr4iDdHyUpWSzqmOLiQcq3K6iHlrftmhV7vXSbWzJKITb3zPBp4KHL7xpe1s0De1O9nafnO7LyI9Jn/Wg2sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 944d90e6-522b-4735-ab00-08d87ae5c737
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 02:04:18.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNoM1sUdemNGj+U1eYCgYim22LcEd+X6jDaRlb/7HDcbpNikhizEgbAWIR+BH0ZVIjeo8IbsejjmJHMpeMJRVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
X-OriginatorOrg: nxp.com
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

Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/bus/vop_bus.h    |   2 +
 drivers/misc/mic/host/mic_boot.c  |   9 ++
 drivers/misc/mic/host/mic_main.c  |  43 +++-------
 drivers/misc/mic/vop/vop_vringh.c | 135 ++++++++++++------------------
 4 files changed, 77 insertions(+), 112 deletions(-)

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
index 7014ffe88632..39d34b164ede 100644
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
@@ -1042,13 +1023,27 @@ static __poll_t vop_poll(struct file *f, poll_table *wait)
 	return mask;
 }
 
-static inline int
-vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
-		 unsigned long *size, unsigned long *pa)
+/*
+ * Maps the device page and virtio rings to user space for readonly access.
+ */
+static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 {
-	struct vop_device *vpdev = vdev->vpdev;
-	unsigned long start = MIC_DP_SIZE;
-	int i;
+	struct vop_vdev *vdev = f->private_data;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
+	unsigned long orig_start = vma->vm_start;
+	unsigned long orig_end = vma->vm_end;
+	int err, i;
+
+	if (!vdev->vpdev->hw_ops->dp_mmap)
+		return -EINVAL;
+	if (vma->vm_pgoff)
+		return -EINVAL;
+	if (vma->vm_flags & VM_WRITE)
+		return -EACCES;
+
+	err = vop_vdev_inited(vdev);
+	if (err)
+		return err;
 
 	/*
 	 * MMAP interface is as follows:
@@ -1057,58 +1052,38 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 	 * 0x1000				first vring
 	 * 0x1000 + size of 1st vring		second vring
 	 * ....
+	 *
+	 * We manipulate vm_start/vm_end to trick dma_mmap_coherent into
+	 * performing partial mappings, which is a bit of a hack, but safe
+	 * while we are under mmap_lock().  Eventually this needs to be
+	 * replaced by a proper DMA layer API.
 	 */
-	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
-		*size = MIC_DP_SIZE;
-		return 0;
-	}
+	vma->vm_end = vma->vm_start + MIC_DP_SIZE;
+	err = vdev->vpdev->hw_ops->dp_mmap(vdev->vpdev, vma);
+	if (err)
+		goto out;
 
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
-			*size = vvr->vring.len;
-			return 0;
-		}
-		start += vvr->vring.len;
-	}
-	return -1;
-}
+		vma->vm_start = vma->vm_end;
+		vma->vm_end += vvr->vring.len;
 
-/*
- * Maps the device page and virtio rings to user space for readonly access.
- */
-static int vop_mmap(struct file *f, struct vm_area_struct *vma)
-{
-	struct vop_vdev *vdev = f->private_data;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long pa, size = vma->vm_end - vma->vm_start, size_rem = size;
-	int i, err;
-
-	err = vop_vdev_inited(vdev);
-	if (err)
-		goto ret;
-	if (vma->vm_flags & VM_WRITE) {
-		err = -EACCES;
-		goto ret;
-	}
-	while (size_rem) {
-		i = vop_query_offset(vdev, offset, &size, &pa);
-		if (i < 0) {
-			err = -EINVAL;
-			goto ret;
-		}
-		err = remap_pfn_range(vma, vma->vm_start + offset,
-				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+		err = -EINVAL;
+		if (vma->vm_end > orig_end)
+			goto out;
+		err = dma_mmap_coherent(vop_dev(vdev), vma, vvr->vring.va,
+					le64_to_cpu(vqconfig[i].address),
+					vvr->vring.len);
 		if (err)
-			goto ret;
-		size_rem -= size;
-		offset += size;
+			goto out;
 	}
-ret:
+out:
+	/*
+	 * Restore the original vma parameters.
+	 */
+	vma->vm_start = orig_start;
+	vma->vm_end = orig_end;
 	return err;
 }
 
-- 
2.17.1

