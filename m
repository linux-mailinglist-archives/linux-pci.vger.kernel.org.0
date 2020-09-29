Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428F27BFDD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgI2IqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:46:02 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:47425
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2IqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/E/+8AV0UBzndvhX9P9CGk6B8kJFmfogGJ70PwZd4Sq/4qehLrkywPVO/VQ/S1PohwYHj5C2fL2eEiwOZsmRympbKozqgxC9lzWUkqqIcPYUroYPnr0fkzEmC738fKuy5tYMkC9qZ7tKvr4u1GcaEJEy2V6oH3lhRnG1LilDAJe+fgOOiWpZ5e/5/yYuX75Z4jFUdWZfZbUDMa4vdGljMcf0zfHLcuveq0O+J1wCeMUdDscVgirrv6NPyw1v4LOjOFpxQyUVUjV5ZP+aWlSvIlKS+YEu+ndrQ4qXrnxdGkLFNXQ9HOunhW+2uVCJe/6+W8l6CFT6olKCXWvYEh4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdzmgbLksmLhPlBw/nyzhxRIhg44RZUc82l/5ZIFSXk=;
 b=VDT4A8O8cEQDacKf8JKluHt5jvQp9PppI1H9Jda2h3QcdyvkYmgykAeLQdtb2KvzXfIuC86b7Cfm8fXqybpeVKFRip2NY5rlLIeOGT9IY0Nrstsk6Yr31gaJeZV4oC+2ufcjqPr1CUwojo5BaaymCKUFE5k/mbXulL5TXrsBVwD1K7eRpu0Y+5iMDfaFomSwAU2Y9An+ExngBcKpwI+/E57HvOiEn/CZ0uTmgNwmPVLsQempSnmDZiOiKI5RKtv4Efl/AtFvWmZlAorrpJCWFCGJD8m2aq7a224S+U4rQyY1H25F3QNfYqqaMWyTPeLUQx1JMnmI7wL3IgsSi63wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdzmgbLksmLhPlBw/nyzhxRIhg44RZUc82l/5ZIFSXk=;
 b=aZn5dZpiM6h1PUy8GgiSG7dFPxYpelKP69ZVI01Mca1tzubVmloooI7/NViMAvhy4Vm4pOIwJlfURCDyaMtw1Sbgz4DMPugLIHzndoK1nDrw3I3PwRFw4fSEqLfIRfnTpZUBRfB4WC2C4nCenDtlRN86hkIoX1fvuiX73xIZmII=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:45:57 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:45:57 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used ring
Date:   Tue, 29 Sep 2020 16:44:23 +0800
Message-Id: <20200929084425.24052-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929084425.24052-1-sherry.sun@nxp.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM4PR0302CA0032.eurprd03.prod.outlook.com (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:45:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17af787b-77be-4806-8ed0-08d864541522
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6910F33E725F95D36399105492320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0j3S/wz2ZuCOa2noGu7VvNTBYDSpWESGDbuIwIJhwfrzQjftwMH9bsGr3kh5C+pnN4Z0Sj412SvhQ4QIvbsEEd8ZaoZR2GTrF52IV/Cl8RarmFI0SxmZXCEuYW7UtYDs9tkV4xaTPxjPQ/4pQxtbrvlePb9O1MrELICAaO6ewqulFL7GeP1LhXCTxTzCyQ9oawAc+btBn6SL2v/69z2SeDgobCqu2/a2zHP0Xb7FTzFluTHYfjJs3cSOiM3P+tPa3BxAC20mHe9IOXSTHl/I7uo/cGwYqgyI3I0CtzNaC0EwynNCtmWyAFFe3cLlElG9PQBtWlWKYENNzFaU3dLfje3jfSm8UFvZT0wDbJpaGlj+mgdqmstR5/uSVI44uVIy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bwl3I8DRzexp4tQ9opNTuC+EKdtiNIsN9oXBydxULYxLPG1FC2ZoIGfAQwbNLBV7dGJOFUwAh69MkegJBr50KdzRNP/rivlXMT3eBVZ3mPYE+ZzB/DICCP9h8eMGJ5gnlfXDUaI7P5MKOwM8+ZdYTXV1Cz2Hfn76VHofGsSWRA+vnkbgJ/45LFoCrzHnZX756Z8g0fhvqMlUFZLGFjfEfmga4mRu46/Jl3SffV6xDzsRgcs9moebIdxHSqXL55NRWZpK2p3FsU6PhucIENg8fi+vQ3il6W/Uoh+0kaZ/FioW7kwfTqhRPWEr49tUmmHzsfwlb5VRm1+5aZkuRIBo7P4QYw391mgjlnG57NmK5VS95I/KX3xBDuftfgLuiGIC8/3Zec0peK8+dNvTA6YpulGgB1SmnNOxryJX5tKnHnnjM6FDMa/4hPPjMvXXWxsyR37ugSBAJJ86tvE57aHUE2LLt0pvc8wmeBlWWh9eTiOIfxAi3fUi5WVSy7K9g8QWOlHnlO8mXjQJV25ksAGf4bZYIclm3t3tLNfis0Nq9LUWrxQBp0JwgL1H6zH6WiQJattzKnWQWjcCdqmmbZjmXj/XCbcePtctKGIwwYG1tC6pFmEs6TafFjQs7xHJbZh/1HNzLu1bMwjCdCGiQR8Dmg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17af787b-77be-4806-8ed0-08d864541522
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:45:57.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsxvyUwfThrGEwJ+OHBhUWF1KdS68ET/ln9BfBFmylBb3hOhKrN5bUC6nIaMHW8+ShUGBvBmqGyejK93vh8qPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We don't need to allocate and reassign the used ring here and remove the
used_address_updated flag.Since RC has allocated the entire vring,
including the used ring. Simply add the corresponding offset can get the
used ring address.

If following the orginal way to reassign the used ring, will encounter a
problem. When host finished with descriptor, it will update the used
ring with putused_kern api, if reassign used ring at EP side, used
ring will be io device memory for RC, use memcpy in putused_kern will
cause kernel panic.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_debugfs.c |  2 --
 drivers/misc/mic/vop/vop_main.c    | 48 ++++--------------------------
 drivers/misc/mic/vop/vop_vringh.c  | 31 -------------------
 include/uapi/linux/mic_common.h    |  3 --
 4 files changed, 6 insertions(+), 78 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_debugfs.c b/drivers/misc/mic/vop/vop_debugfs.c
index 9d4f175f4dd1..05eca4a98585 100644
--- a/drivers/misc/mic/vop/vop_debugfs.c
+++ b/drivers/misc/mic/vop/vop_debugfs.c
@@ -79,8 +79,6 @@ static int vop_dp_show(struct seq_file *s, void *pos)
 		seq_printf(s, "Vdev reset %d\n", dc->vdev_reset);
 		seq_printf(s, "Guest Ack %d ", dc->guest_ack);
 		seq_printf(s, "Host ack %d\n", dc->host_ack);
-		seq_printf(s, "Used address updated %d ",
-			   dc->used_address_updated);
 		seq_printf(s, "Vdev 0x%llx\n", dc->vdev);
 		seq_printf(s, "c2h doorbell %d ", dc->c2h_vdev_db);
 		seq_printf(s, "h2c doorbell %d\n", dc->h2c_vdev_db);
diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 714b94f42d38..1ccc94dfd6ac 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -250,10 +250,6 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
 	struct vop_device *vpdev = vdev->vpdev;
 
-	dma_unmap_single(&vpdev->dev, vdev->used[n],
-			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vdev->used_virt[n],
-		   get_order(vdev->used_size[n]));
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -340,8 +336,8 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
 					     sizeof(struct vring_used_elem) *
 					     le16_to_cpu(config.num));
-	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(vdev->used_size[index]));
+	used = va + PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +
+			       sizeof(__u16) * (3 + le16_to_cpu(config.num)));
 	vdev->used_virt[index] = used;
 	if (!used) {
 		err = -ENOMEM;
@@ -355,27 +351,15 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 			       name, used);
 	if (!vq) {
 		err = -ENOMEM;
-		goto free_used;
+		goto unmap;
 	}
 
-	vdev->used[index] = dma_map_single(&vpdev->dev, used,
-					    vdev->used_size[index],
-					    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
-		err = -ENOMEM;
-		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto del_vq;
-	}
+	vdev->used[index] = config.address + PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +
+			    sizeof(__u16) * (3 + le16_to_cpu(config.num)));
 	writeq(vdev->used[index], &vqconfig->used_address);
 
 	vq->priv = vdev;
 	return vq;
-del_vq:
-	vring_del_virtqueue(vq);
-free_used:
-	free_pages((unsigned long)used,
-		   get_order(vdev->used_size[index]));
 unmap:
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
 	return ERR_PTR(err);
@@ -388,9 +372,7 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			struct irq_affinity *desc)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
-	struct vop_device *vpdev = vdev->vpdev;
-	struct mic_device_ctrl __iomem *dc = vdev->dc;
-	int i, err, retry, queue_idx = 0;
+	int i, err, queue_idx = 0;
 
 	/* We must have this many virtqueues. */
 	if (nvqs > ioread8(&vdev->desc->num_vq))
@@ -412,24 +394,6 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 		}
 	}
 
-	iowrite8(1, &dc->used_address_updated);
-	/*
-	 * Send an interrupt to the host to inform it that used
-	 * rings have been re-assigned.
-	 */
-	vpdev->hw_ops->send_intr(vpdev, vdev->c2h_vdev_db);
-	for (retry = 100; --retry;) {
-		if (!ioread8(&dc->used_address_updated))
-			break;
-		msleep(100);
-	}
-
-	dev_dbg(_vop_dev(vdev), "%s: retry: %d\n", __func__, retry);
-	if (!retry) {
-		err = -ENODEV;
-		goto error;
-	}
-
 	return 0;
 error:
 	vop_del_vqs(dev);
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 08e63c81c5b2..422a28c1bb7a 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -53,33 +53,6 @@ static void _vop_notify(struct vringh *vrh)
 		vpdev->hw_ops->send_intr(vpdev, db);
 }
 
-static void vop_virtio_init_post(struct vop_vdev *vdev)
-{
-	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
-	struct vop_device *vpdev = vdev->vpdev;
-	int i, used_size;
-
-	for (i = 0; i < vdev->dd->num_vq; i++) {
-		used_size = PAGE_ALIGN(sizeof(u16) * 3 +
-				sizeof(struct vring_used_elem) *
-				le16_to_cpu(vqconfig->num));
-		if (!le64_to_cpu(vqconfig[i].used_address)) {
-			dev_warn(vop_dev(vdev), "used_address zero??\n");
-			continue;
-		}
-		vdev->vvr[i].vrh.vring.used =
-			(void __force *)vpdev->hw_ops->remap(
-			vpdev,
-			le64_to_cpu(vqconfig[i].used_address),
-			used_size);
-	}
-
-	vdev->dc->used_address_updated = 0;
-
-	dev_info(vop_dev(vdev), "%s: device type %d LINKUP\n",
-		 __func__, vdev->virtio_id);
-}
-
 static inline void vop_virtio_device_reset(struct vop_vdev *vdev)
 {
 	int i;
@@ -130,9 +103,6 @@ static void vop_bh_handler(struct work_struct *work)
 	struct vop_vdev *vdev = container_of(work, struct vop_vdev,
 			virtio_bh_work);
 
-	if (vdev->dc->used_address_updated)
-		vop_virtio_init_post(vdev);
-
 	if (vdev->dc->vdev_reset)
 		vop_virtio_device_reset(vdev);
 
@@ -250,7 +220,6 @@ static void vop_init_device_ctrl(struct vop_vdev *vdev,
 	dc->guest_ack = 0;
 	dc->vdev_reset = 0;
 	dc->host_ack = 0;
-	dc->used_address_updated = 0;
 	dc->c2h_vdev_db = -1;
 	dc->h2c_vdev_db = -1;
 	vdev->dc = dc;
diff --git a/include/uapi/linux/mic_common.h b/include/uapi/linux/mic_common.h
index 504e523f702c..e680fe27af69 100644
--- a/include/uapi/linux/mic_common.h
+++ b/include/uapi/linux/mic_common.h
@@ -56,8 +56,6 @@ struct mic_device_desc {
  * @vdev_reset: Set to 1 by guest to indicate virtio device has been reset.
  * @guest_ack: Set to 1 by guest to ack a command.
  * @host_ack: Set to 1 by host to ack a command.
- * @used_address_updated: Set to 1 by guest when the used address should be
- * updated.
  * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
  * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
  */
@@ -67,7 +65,6 @@ struct mic_device_ctrl {
 	__u8 vdev_reset;
 	__u8 guest_ack;
 	__u8 host_ack;
-	__u8 used_address_updated;
 	__s8 c2h_vdev_db;
 	__s8 h2c_vdev_db;
 } __attribute__ ((aligned(8)));
-- 
2.17.1

