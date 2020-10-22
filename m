Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842A22957A1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 07:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502587AbgJVFIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 01:08:05 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:41486
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502529AbgJVFIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 01:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBp1Sm49RqujXr5KL8bBfY+SwqQ3CpSjS/vdrrS1CC/VcN3MDrOzguxo1ndT/pZ1TjIy7gqcFjVS9I2O8ffYfrQdlGydwd+CFPV1R9hZNkPfT8feGz/nKe4pCEGysnj/MsnM/rHRU74uPkUNNQHPesHuFrTvn+UzWv+JJUqfIWHew/RRtbfHO4IfquR5WxqAt/X84PpNrbt6IihA0PnVeeqALwHpMvp1taS3UDPnF41sK/2e1QkdEMk/e+1r4JtLe0bZWeJfb/jpeP8OKbOI9NWroWxj/IhchqHt903n7bQZYkOoi9I0IcY0PGM5tl6ilejDAVhDVdqWMlTcpVuoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItwS+BxMmgoYkYMTxDKt1OBtlmWmkb+mojKxyuRWK/w=;
 b=LaHXS7oDH2kK4k3wPDVjOXYB1egATfXm7PC1InoPaOqgdcvj0XbgjCJMUkPeWfcSx0Pv25QkNS9ProQx450g+OfIIex6E+Yh6FqF3TDb0dpqwse/kqR8q6in+XgQ++KoVomswHfHYf/f8chBJVQwm14iRPSXLRP1oWRw1qoAK3UkprhgEjNKgkXmbo7+maaNAC+UkzTyIQLYfpx4eNA3V6zf0Nv9CpWgyNQhL/FWb0wito2sNl+F5SZ8tFEs71LM11aQ5gnvgkdZBj6ECPhwyVLQYyVww7H/Pd7ZRCKNlex7F+weJAjgO518hRQtTwKkY2CkejfdSAQCENoz0nBslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItwS+BxMmgoYkYMTxDKt1OBtlmWmkb+mojKxyuRWK/w=;
 b=GnFAY/DZPR9wGtP4EHaDLMzdeNVH81qkgUtAFRAODl34gj6nrmg/kJccMmYw2n6yt4G0RyFBZJ/aChS+NWiZ+QrX2YKgV+vBgas5zm3xiMpHJZJ46NMRAb6BLIXGXRuv+wVfb6ZN6TnPpeKaODvp6CKGvJVhW6mYAcHs9cQilog=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3358.eurprd04.prod.outlook.com (2603:10a6:803:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 05:07:58 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:07:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3 1/4] misc: vop: change the way of allocating vring and device page
Date:   Thu, 22 Oct 2020 13:06:35 +0800
Message-Id: <20201022050638.29641-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022050638.29641-1-sherry.sun@nxp.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22)
 To VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e60c6278-9e5c-4586-f63d-08d876487185
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3358E2EFD061641CD5E1B49F921D0@VI1PR0402MB3358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMjE0b1994/6fZouCmKKgV9e7MI8f0IgocQhS1sf/E2Om8IE849IB8jLiboBCz+a22rCFvUoJJrHE8uQ684PC5bO7UXl9BulahBDcYcXX56JiUEqwVs3j+rt71S9ZPt7ntAeGrWoz/CT57VMXbM+NTqGpv7aYkqmD9aqQdkoPiAjCkGBIGc0RfOze4t1pJaZIGxQeXl7KMLwIpxQPLf+GYPKswhfBkOnK0AlmXnpwGAeMuIESfyvFJdSZuY2RHLlPxUYbshT15Y6YRSZVv7GSxMjttvU08cTjvfHeDbhFxmcoks/DvUJbetG8FlmYuaOHsL0nbN0yQtomMzd0CapkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6506007)(44832011)(2906002)(66476007)(66946007)(4326008)(83380400001)(86362001)(6512007)(316002)(2616005)(66556008)(956004)(1076003)(186003)(26005)(16526019)(478600001)(6666004)(8676002)(36756003)(52116002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v1qeX9x7VOh9DKeq/ivXHLNqLbwzfhGS+99TwAArr8nlVFeY2bd6KDHsHwmA++m1d8yGkvrucrvGH/hgeerYe3bk3+K80oM2BCIobyjyDrZDp7Xc+v0ibHPoF+EvWyRn6Sy4AA0AbMhFHD4c6rvU7o3ENDLIEQl3P3vMljGaG/2nFd0SYitxdX/06Xd9en2AleRDTkFFZva4lFhbJZnxk63V1QKI1kXaGK47N3afyZlKDv+qGE8pzIEHxLGf5twtKJi9TjSKEC76a8v0Fowa6qrWovuLeKVBtce8eYolRg2wQAwwWWOBhypUXS1WSo+dpgYAcGCby6gm/SVsKBv6JCKuP5eE5+OOtCOflj28rVMLbykQGQTrgKv+ZZ70bsnUVtLGN2r/w+S+C2cmZbOdLNu7vJlSc08OUYQ4IaDWKqyhqshxvvHqlO5dPjSSdohp39ptdFS1KbIBJR8teGc522ngL/dacwWO3N17r6OF9L5O2JWIgp1tcfLQkNA8fx8mBoXNEU7HPmYeI4M41v6UuAZ0VENzIWaeLHWMSpx1TvjGYAW0e1gTtSIhdkN/z86WKJyeRcqKjosACmb/9LBi9ksjK/mGLno29y1RY8niMcpvO1iUZN+IDt3oXUUQZrYqojrdmWNRhy8oumDEeTFHNw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60c6278-9e5c-4586-f63d-08d876487185
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:07:58.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r30FZWaCwSt7VlS3BFS5avr2kna6nH2OGO0ZQarGgVJXHVHYJxoHb9f0O8XLze2jm9lXWhqlE6wfu0/ediwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3358
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

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/host/mic_main.c  | 15 +++--------
 drivers/misc/mic/vop/vop_vringh.c | 43 +++++++++----------------------
 2 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
index ea4608527ea0..ebacaa35cb47 100644
--- a/drivers/misc/mic/host/mic_main.c
+++ b/drivers/misc/mic/host/mic_main.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/mic_common.h>
 #include "../common/mic_dev.h"
@@ -48,18 +49,11 @@ static struct ida g_mic_ida;
 /* Initialize the device page */
 static int mic_dp_init(struct mic_device *mdev)
 {
-	mdev->dp = kzalloc(MIC_DP_SIZE, GFP_KERNEL);
+	mdev->dp = dma_alloc_coherent(&mdev->pdev->dev, MIC_DP_SIZE,
+				      &mdev->dp_dma_addr, GFP_KERNEL);
 	if (!mdev->dp)
 		return -ENOMEM;
 
-	mdev->dp_dma_addr = mic_map_single(mdev,
-		mdev->dp, MIC_DP_SIZE);
-	if (mic_map_error(mdev->dp_dma_addr)) {
-		kfree(mdev->dp);
-		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
-			__func__, __LINE__, -ENOMEM);
-		return -ENOMEM;
-	}
 	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
 	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
 	return 0;
@@ -68,8 +62,7 @@ static int mic_dp_init(struct mic_device *mdev)
 /* Uninitialize the device page */
 static void mic_dp_uninit(struct mic_device *mdev)
 {
-	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
-	kfree(mdev->dp);
+	dma_free_coherent(&mdev->pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
 }
 
 /**
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 7014ffe88632..2cc3c22482b5 100644
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
@@ -339,11 +329,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		dev_dbg(&vpdev->dev,
 			"%s %d index %d va %p info %p vr_size 0x%x\n",
 			__func__, __LINE__, i, vr->va, vr->info, vr_size);
-		vvr->buf = (void *)__get_free_pages(GFP_KERNEL,
-					get_order(VOP_INT_DMA_BUF_SIZE));
-		vvr->buf_da = dma_map_single(&vpdev->dev,
-					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
-					  DMA_BIDIRECTIONAL);
+		vvr->buf = dma_alloc_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
+					      &vvr->buf_da, GFP_KERNEL);
 	}
 
 	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
@@ -382,10 +369,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
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
@@ -433,17 +418,12 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
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
@@ -1047,6 +1027,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		 unsigned long *size, unsigned long *pa)
 {
 	struct vop_device *vpdev = vdev->vpdev;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
 	unsigned long start = MIC_DP_SIZE;
 	int i;
 
@@ -1068,7 +1049,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
 		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
+			*pa = vqconfig[i].address;
 			*size = vvr->vring.len;
 			return 0;
 		}
-- 
2.17.1

