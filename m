Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB42957A2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502640AbgJVFIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 01:08:09 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:10407
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502529AbgJVFIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 01:08:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6UGUGemeVNp48wO2WdRskZpHE016YqZI8xskRunsuDnnUCYLUuYgudjSIYWsWQ+fySMmhskFLYEhkni9wKdz/6XCVp5c5X555bAzWkSGKt1kL0esMN1in4noICom2BCOHRnRFpKCc8p1jmTKLI8x7GUgj982bd8tQW4WgHY1gW5MahlG2oxPb8FcZrD7m/j1DiFvoWsTZgl09mhd3qB68wYYRyXd7kC0rHp5fFhcuSx0zdtuaZOH4D/1Lnw0AP+wavKLkbbDdw7vXviCRyHx0P9rsy0aT8+SnJGOIdObqae3wHjUV5FuadOkrjDL0Wu6ewPMr+5Ot8F2P6VTgCN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nMx8Zdww8fwn/eXCYbFyfk1A01h51l3Akc+EPt97us=;
 b=k50egQKOXyBCK3rDnVxZPQ7grMcRISYUwwAtmeS2COyZjj+p7OH1OR6eUcRY5501v/ScuE6xtvugU4AhYQUo3W8MWalORaiZeS6KlWObeL84GSZoqiFUq61SG0j/53PSPwOOPb+WPAIBsrN3eZWlkV8GKk5Q9Y0uUXfxtUun7HP8ZkcOIr1jzyeR1KIbJsrzDVTDGkuKT1BP9SsH0nQUAowgK4DSHtheR7Pv5B6BAE22SX+VKvZ+5rpuZZrXtjtGaaG+Knp7f/9jlNdsEXw+9x+IdhGBBes0CH1y2uUbZkcpZ9Elkgs88mEDxjtj+V988A1FwIt7lLQR4nqXLGJUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nMx8Zdww8fwn/eXCYbFyfk1A01h51l3Akc+EPt97us=;
 b=fYRez9lDUBoLNLdTgvNI04a9egIy3cMwlkmVE+FCGPniC7od4CTkqsobnZpeXoFABc5DTJK3BXL8Rz11gqCpL7+kZOblpUojlK13ZM5QoIfwXkq/tGzrbMvggYiHnyBEmS87RW5UTG/KQ7XHY28kMacsg/8YoYANkUK/nmapLzM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3358.eurprd04.prod.outlook.com (2603:10a6:803:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 05:08:04 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:08:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
Date:   Thu, 22 Oct 2020 13:06:36 +0800
Message-Id: <20201022050638.29641-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022050638.29641-1-sherry.sun@nxp.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22)
 To VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:08:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a7de088-5096-46e5-1201-08d876487493
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33584D4700FE0646BD24F224921D0@VI1PR0402MB3358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58Q7xLW13RNCyqfuPkTg3VMrPae4Pt0vBCar7iHrAx4MyM7t5l8dVQKUxuEj8U1ykc60syjdCCvBDNmBzWmzd7lLMfMHPWNfVyL+vhK20fWW3zsJFt4lb1hgri5NEs0rytfKfxvYzTEtcndWAL5A2wShUMGBFS51WZMgxfBk1naqz9mP41vdfLRJ1IvZdSWQjebEQ8QHTTi/x78JebtC7FA0BtqpTzqmcFyVMBThmsQTshupfKGGxTViDaFBMCxC4CUsXVVM5gemAz/VSKZuXyXBADj/HUyxoZ0vkZdYPFCfeMP+skGA4jv4Q4SFvCXuW5eUZ6uCtW39proigXttsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6506007)(44832011)(2906002)(66476007)(66946007)(4326008)(83380400001)(86362001)(6512007)(316002)(2616005)(66556008)(956004)(1076003)(186003)(26005)(16526019)(478600001)(6666004)(8676002)(36756003)(52116002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IUfnBWcVQ3EoeZvnfcaga34aAf1yyHX6N5v81YqbYdQXOkxfHaifa87IMTh0SJY2lu7b6N7djRS4SDLQScAvcQSxmsepwxLoQCPH69KcMnZl9udl+68IRJyNiZ+WLBq3druHERjoNk86GFEpDMmKPGdIJOtzm2FhoUivZi4byosUUsGhITYx1cHmX6HangIvs+WQMUH0bm8WWPejQ4HJNQqWWw8i5MFGfvu5OkQsI435Euf3ccmDTwLEOYVI/nejnSXcw0019sOjlV4LG6atH7OGN0q2FXKS9DVZCQghPhL4/vcJO3ix6FmEOqo40qBKUYo00XMaeLlbLhkplNF9/v0oPeuBk4FdZDEp18maMDQ44nrQT2uEMuTVVAzBkn1lwWjRWk95Fy1S5XzjSeGmx7imgn7f/59AWgOdrltKT2Ss7T8lBzFkXgu0T6sDFdJrzcWuy5AS3FYXZC+tnu+xPh1+vtwutVLHlbhrtlLCwH1O10kVkCbymskGQ+oA3XCJI8D7Gmk7lDhMtnWG3LW8o+EDOq2TGlANF3n93ptPZGLFh5juXHRjzi11IuiLHXHSpWvEP6hx8s2gfjnyeNRMJj3+o/TmSWwF/CGM1TqKK+GPWwSUrIwobF0P4zX738E1t40IPFx9/KVoO+YEKpe3vA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7de088-5096-46e5-1201-08d876487493
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:08:04.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnE4FDi1InIYKDohN91x/cxsqahyeRoAX3ZDEttPvWQfYXblK7FKjqL3ewpzR7W5TgdMnEWgOrpErjeNk5YEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3358
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
 include/uapi/linux/mic_common.h    |  5 ++--
 4 files changed, 8 insertions(+), 78 deletions(-)

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
index 2cc3c22482b5..cc928d45af5a 100644
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

