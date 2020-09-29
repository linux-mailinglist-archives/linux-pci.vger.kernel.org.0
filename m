Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE327BFDB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgI2Ipo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:45:44 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:63639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2Ipo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO3RDyEbH1uukuYmv7HdCCWKrAfQbCXq8N6TmXIQhRzojrs4LmCjW8emm0Ja4RixypzQM2202dC/sjWA3u1X+rrElzwemKFtDGzG0l1xZR8jd+9e37Y0ebQSHhlJF9dMx3ahsTMIKvNDHG9BTHT/HYQiKQKASGDNws61NKsmA5lqU3ZgVKNo2sgajlLRqAKMRx85qZkPNvqw4U1OWAEZZPrbfOq8XJLKj5Cq/DcN9yvNIG6lsH+p1B8IU1/8LX5G0NnZ0W0uaXLP83SpNjIwinstjIDIG36cT0EKbQZtbcnWO/bZmRjzgF2uU1VmXUobNvewTfUk6UsG3ksNWpw0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcIGY0L5bof0mptzFBczwM5n3r1bMauz6UAgC2IlNmw=;
 b=FvOrU1wc8ZN+7B+yJuNHtUC0rxy27BIgvBersSoBbsLK73H6uTrafnNBck5Cy6+HLOwJ+dRnKagz3Ru/+7RAWMRwIlriKXtUnTngNtN+NAfgVKKYlXH6IIYghlLmVPpqnduCl6deU6UB4SiEo39bTUgASMehphS4SK7BnKSO1Gg7Ypui6ZqM9/VKfceUUptWvq0eJZ2OLgaUQ5slUQKCVi+7flhptSVVRHzVSQm8PYUJ2usFP7tMWaMvWzvuRMc8425mZz197vdvmzjaNShYas9ZVndjZyY+C0u+jZ5cB2Ti2LpuPHf69PartKhVO0iOPA38gGOc3NF9nll+Wxd3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcIGY0L5bof0mptzFBczwM5n3r1bMauz6UAgC2IlNmw=;
 b=J42rGRj0sIlBeJEp4U3DaXoCJJ5U6qbAxtjcZHKmQxjVMTKs/iT11Yqw1deGJhv3GHdo1zxhEG9wY12DXnUHvIlR0KtbbL2Tij7TWfmTcxMcARzDcOAJ67Rvp6gZGkeASmk9kMfGIusJOh6q7IzflHis7oq2t+XJMAZ2FPpDP/g=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:45:41 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:45:41 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 1/4] misc: vop: change the way of allocating vring
Date:   Tue, 29 Sep 2020 16:44:22 +0800
Message-Id: <20200929084425.24052-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929084425.24052-1-sherry.sun@nxp.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM4PR0302CA0032.eurprd03.prod.outlook.com (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:45:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35520a73-58e7-48c7-f18f-08d864540b7e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB691047E8687419F21D2B5AF292320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxJ4YCJSdIxpIioYf6ZeJF2NpLxQRcav5AaB8r28aRPSdfzLfny+P/4qpyJiz4Mk7n7aHkbVCqWbyewPC7ZgNoX8B//ZbIkSEV8NVQxIGhv56aWSA+b87RMrIDO5VLH3D3yNwzkHvgJx1fhd7ptgJfMamv7FexhTsx93SaCmX6rEOgc4DmiUWxVP5XULQMFvCTtzRXWlyJ+FZPv6LCmR6G1qytS1H99WHozVe/ba3uheByURT9b2laMzKU2TPsSzw2ZPzuDCTct6cnZtc3mZxGLd2ubdXImB/9S4ZaNVvDXXIigQrChYxQ3/TO9oayqpup4e4BRrlpBKrNZ+EvqZZ/KTlUEH7ErKzVaTBs8xb5IiaU0BHLIa1d508p0CZavY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tLK81tQ/LVqNWPlWgLQfKORkKO8ZX81f3qJNRyts5DKs0LQtgg02Wj3sECY7GjY8w6aZwC/1HY55ssexVpfxbf3t99KX4ilXZgfW9Dexspt634/qt6Xb/diNW7Q3ENw3ePaexEK656yk5Id6LOMCvHwUB1ZxMfnt/Papmj1J4Ha0rL2eHSSi+K2uOvIbILp1g0fAJ0jUiHqRrxhjSmA15MHXb4y2n5Fcu+M1iwYBRfCZpt+se1vWGbCo7hTJlWlMnrlmrbYGr2TXk07ehXiPEzwAJCrNy0m6Z2hL7g5P6q3PDeDG7TtIVw5EnHIU+XYjR3bFFSK0vC2lGEita48kRg4YdQWasALLcjzrHmbfPwBn0/2g1H1J5AikH8c2DwVGWxQ4siJJll1ELA2Ll7MiAzTFP58w5ROuHF+WMu0+64MSW/XYSfqyhL3w2Do5jCp74az3rzPx6Mhs3UxZIEf9BbCGa867Sj9OCYjZjN3d68kKncI+dW8ZNQdwDM1U3+0nb7zIxvpfAizJrpqUeVWRDyW8HUQd5k4xm1iYnP1Kw/AwYD8wzICzJO/cJJZ9X12IB15lhIxEdJ14PcvZx+yRwzMPcD1dBjZy3WXPveDF0nBd5v18oXvn3ceJREYc7cabavIsvbYx8ofKoRPx+Z5kQg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35520a73-58e7-48c7-f18f-08d864540b7e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:45:41.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqMduY4kpmgKpiLNlhcspl5mdl5rIN0LO8FeL/48L74CVdI04aev047PIMSWGe6FXEpxgwQFIHScIsltUO9Eew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocate vrings use dma_alloc_coherent is a common way in kernel. As the
memory interacted between two systems should use consistent memory to
avoid caching effects.

The orginal way use __get_free_pages and dma_map_single to allocate and
map vring, but not use dma_sync_single_for_cpu/device api to sync the
changes of vring between EP and RC, which will cause memory
synchronization problem for  those devices which don't support hardware
dma coherent.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 39 +++++++------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 7014ffe88632..08e63c81c5b2 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -298,9 +298,7 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		mutex_init(&vvr->vr_mutex);
 		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
 			sizeof(struct _mic_vring_info));
-		vr->va = (void *)
-			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					 get_order(vr_size));
+		vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size, &vr_addr, GFP_KERNEL);
 		if (!vr->va) {
 			ret = -ENOMEM;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -310,15 +308,6 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
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
@@ -339,11 +328,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
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
@@ -382,10 +368,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
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
@@ -433,17 +417,12 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
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
-- 
2.17.1

