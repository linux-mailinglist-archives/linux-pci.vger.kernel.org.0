Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDE2988E8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 09:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772398AbgJZI6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 04:58:18 -0400
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:2305
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1772318AbgJZI6R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 04:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcqBHqdmx61mh4RlyP6xrM5PF2FYzU1xwqwOOGjxtAMIfR7Qh4SpI3EKTByqZonvsuoPx9P6Zy4QNJLAY9hEfu7uQf4UY+jaOBw7OS0NmrgeALn6hnwxl3C3WzDRV+KEDx8HDX7iEXsb7rnHs2xBeg4I0EFOcfAcvr+g0EjSN6MKEToR7fNX5De2LKfhlGZ+cchOUVRux7j8bOC+SbGP/7R2XPWxqf4auwCw4yuBx/YuArpDcrf5NGod30gxhAJ9Lp/Y+Ac3ASG08+i3yJa3oHPlNl3ZlGdwWP5EN61zpk6SULCc2tYep5Yn1oEHwIaHOIL9Wo7rsi3KV24qWi/v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epXagXigPH1paH+CGn4/CrEOYtWWFRQR4gjNiGCY7Qg=;
 b=QQIOYPrCZl3JtOIHsuieiWI0MqSWePk3ZRXg3Y2bRULGGUqVLG01a45WsisTNlrnJHOXy7wOuUTjkFzoP+qsAUYD9bR5INgBcvb83q+JIyicT0KiJ839BByyY0KaOt7C35XjoPZKHtm9xKxPlf8H8Sy+XbSE25E4IcJh7xlot5eV3fKpSHJV9zM5zFBfwJo9bHCkiNiba2pQPBP1PiO4DlQukpZDocWIJlC3kQj4tJvk6EeDm1qpPyPR1e5ECI6OE8DKLThsQVCbkF0G1RRgvH49DtUw3hx7zS/cF05LVVnQ+Pvg2QPM5hVCedelJUmepnp1gl6NZhHIXqxdPfyKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epXagXigPH1paH+CGn4/CrEOYtWWFRQR4gjNiGCY7Qg=;
 b=PpSBC4Z4aPoJwop8WN2R2tAo0+6Ch9tU6lgVB/cUaEbdYJpe6Pl5dA1qyMV+j3KKIBuXqSIBrHSngMuiqfOJ2bc5cSgXLaQOFDV+nUH+QprXt591TqgoeUso3JS/Ev6xnHmIjgKzRy77JtRe6IfYrsrw0OT4rMZ62M/WtWVoPBo=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5758.eurprd04.prod.outlook.com (2603:10a6:803:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 08:55:37 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 08:55:37 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V4 2/2] misc: vop: do not allocate and reassign the used ring
Date:   Mon, 26 Oct 2020 16:53:35 +0800
Message-Id: <20201026085335.30048-3-sherry.sun@nxp.com>
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
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 26 Oct 2020 08:55:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c05fe0f-01b6-408d-96cd-08d8798ce814
X-MS-TrafficTypeDiagnostic: VI1PR04MB5758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB57589ED56AE75F25A645357492190@VI1PR04MB5758.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rbHdGv0nj2hHSYnqYc6vWoD+TkeCLUFVSAu65AnU6cPgWb7c76S7CjR+jY+zlpFP7ORlFTm2yVNem2IrHEbtcx8apJ5DApgqilovsQNi0atZvO08zLD//bXnsFRJS5FEkMGrvqXxVcjiqscjiYJQD0LfeemfoqnIFSxaCp7rfJQFbhY+YWNv77CWtCPQxQ0zVMDj4/kL/6TjxkUcZzKRED98T3jiOYW5SfPwtmT1vH/Bv1QHxUCl7Vg86OXLYvTwRRRAdCL8+VBmzlXm+AMZ4mp76O90Pd/mPi/OYJ1Fspx+THNyqmB99G9L2+c3KJFqeQeEj+wfNmzFA7Bljiebg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66476007)(8936002)(316002)(86362001)(956004)(66946007)(36756003)(66556008)(6512007)(83380400001)(4326008)(2616005)(1076003)(6506007)(2906002)(186003)(26005)(8676002)(6486002)(16526019)(5660300002)(52116002)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WKNqwEjxsvyUeUukp765z6+tdGQnfVEjoYI9FTf9lwVZKCUMBJlxxCbYMMpFsakPDBnStUnTgPyYnMAPswj51kJcqlXsQmiTyVxl1xqVM2ug6YskZvMcGbyeOo+xUQvi10fslbIyx4vAvNAr+Xn6LS/0Asgq4+fWqPIH0GdabV6YJ1tulpktXAbXb/UbvtLv/WsL04i1nseZSIRb+uhKatb5GsCZjEcJMlBeA09BIZ8wU2orjt/1SeVQPsUanQ3qj96N6PVHw+KPfmvYIwJfZxHqCQZGHxK5phdooExAcyCE+WukwNxAx4QRJclHkU4g6aXSXPqokzY8rYsKXHk0Tiv3CRQT5Skp18l+XXq7faUoyHDI6k80rv0YiJWNbB5Vh0ltLCauK7QrloiQOdluG7XCwng/IGVw8gK+u8qbBkRJoJmpZqt0JCWM2DQ5EQX4KWoFTTKsV+eKboDqsPoiWIiTDWDeW8WKqcUZhVch7GEPGTCvSAZcr7eEv0+MtqXdQ1mJFIg+YA3IQbXYa2m9ENxpLUZQXkzpk8HwYoDsyGDAyXVEzJH63FaD3tpWMjE4haO4X+QJ3IqD8yAINlFTzWgQlIm6jYCDZxVgGwrPrYRgkitLqomr9PVyshBNP0ORSBKGVqjnsbRojKU27hz2Dg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c05fe0f-01b6-408d-96cd-08d8798ce814
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 08:55:37.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GXbj+bukHriO/rNQQck83QnGRZRJ2j8WsjHZsCs/UoAwS8Cr8aOpiOm/QbNThlUTzPzsYdEDQ3IItwUmR1i9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5758
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
 drivers/misc/mic/vop/vop_main.c    | 51 ++++++------------------------
 drivers/misc/mic/vop/vop_vringh.c  | 31 ------------------
 include/uapi/linux/mic_common.h    |  5 ++-
 4 files changed, 11 insertions(+), 78 deletions(-)

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
index 714b94f42d38..07e2732b24bb 100644
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
@@ -340,8 +336,9 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
 					     sizeof(struct vring_used_elem) *
 					     le16_to_cpu(config.num));
-	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(vdev->used_size[index]));
+	used = (void *)va + PAGE_ALIGN(sizeof(struct vring_desc) *
+				       le16_to_cpu(config.num) + sizeof(__u16) *
+				       (3 + le16_to_cpu(config.num)));
 	vdev->used_virt[index] = used;
 	if (!used) {
 		err = -ENOMEM;
@@ -355,27 +352,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
+	vdev->used[index] = le64_to_cpu(config.address) +
+			    PAGE_ALIGN(sizeof(struct vring_desc) *
+				       le16_to_cpu(config.num) + sizeof(__u16) *
+				       (3 + le16_to_cpu(config.num)));
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
@@ -388,9 +375,7 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			struct irq_affinity *desc)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
-	struct vop_device *vpdev = vdev->vpdev;
-	struct mic_device_ctrl __iomem *dc = vdev->dc;
-	int i, err, retry, queue_idx = 0;
+	int i, err, queue_idx = 0;
 
 	/* We must have this many virtqueues. */
 	if (nvqs > ioread8(&vdev->desc->num_vq))
@@ -412,24 +397,6 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
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
index df77681c97e6..15dd3405789c 100644
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
index 504e523f702c..fe660d486b20 100644
--- a/include/uapi/linux/mic_common.h
+++ b/include/uapi/linux/mic_common.h
@@ -56,8 +56,7 @@ struct mic_device_desc {
  * @vdev_reset: Set to 1 by guest to indicate virtio device has been reset.
  * @guest_ack: Set to 1 by guest to ack a command.
  * @host_ack: Set to 1 by host to ack a command.
- * @used_address_updated: Set to 1 by guest when the used address should be
- * updated.
+ * @must_be_zero: Reserved because this bit is no longer needed.
  * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
  * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
  */
@@ -67,7 +66,7 @@ struct mic_device_ctrl {
 	__u8 vdev_reset;
 	__u8 guest_ack;
 	__u8 host_ack;
-	__u8 used_address_updated;
+	__u8 must_be_zero;
 	__s8 c2h_vdev_db;
 	__s8 h2c_vdev_db;
 } __attribute__ ((aligned(8)));
-- 
2.17.1

