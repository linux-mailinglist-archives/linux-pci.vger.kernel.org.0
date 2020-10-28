Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5533A29D568
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgJ1WAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:00:45 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:39397
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgJ1WAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:44 -0400
Received: from VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 28 Oct
 2020 17:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmVQrju8V2PpUYmDXrxNCq3frMxWE3VvVitbjc+88h/SKvh9NeZr86TkqBAiZ5URJwEjXKUJqcr9gErw+WxrewvScQgc/tJfgy8sPsRuXzXjkfjGNinVspeR+m6pF9MAuqx0XOjKBFRRDCtlAYDsgkoVkRimWGGZcRDEnNH+qyNOKUGWNMiREhi5+7kXt8nR8qKzxMIcpASRjH2dCQhwUUWvFVhZEUFYSqH1AiRXFn5M896RMMnejyZcm4cLDY+vXI+MRN0hwD+qw2ziI+a6xma85DQ9v8in7IcxYgHYVfn1NEGEZx2QaOjrijhm10HHmN0by11mS9+IFHk2hZwa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtP/+gOg4BoVV64Fqe4UwdSS4ZvCSt5UiODLbLZPf7E=;
 b=Mx+SAF6sOUBTW9qXku8Lm4iApXWRNhwNLIcxJJ/rxe9qRTAKvEC5+tHQUzHNajXffP4EG91vdLXzmI34dE0O1Qyue2AUrPCj+TnGxP2HexC5NZtzxAypd75hdGj22bhEb5q9OEfK0BB3bFBMpGbgTsHsb4FPmuIvZtN3qSbo2SUwYytetnUVNMFzi4T0zV1+/7woNgN+Tfc1ITODGcezt3cygrutxPCBQ4s4eWVAcLgB1ZpdrwhIBv5ny/ueyFP+dudLB9rSbczMWzLFELO2fNyD/f4Pp9G2JipeVO1HEDRVWQGUICFSC8wMndRN8FV8c9iT/n8ObbQ1ON6hyg14aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtP/+gOg4BoVV64Fqe4UwdSS4ZvCSt5UiODLbLZPf7E=;
 b=V0w+8LHF2Fxt9aZbtxk+UGSaiiOFAkF/7BNkgpYZ6TTaKeZOjeK+K5NUKMLfrDyzHGRFmm9tIGL4ue8pE8JEmgLsl4wbumI54u+/VihQCbftLP2zMgyTnGTsMCiCrpEZ+FVxPcglXJQjf7XVeCFZScrFjt+8ru6AlSaaZVCfkYM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 28 Oct
 2020 02:04:24 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:04:24 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        vincent.whitchurch@axis.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, arnd@arndb.de, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V5 2/2] misc: vop: do not allocate and reassign the used ring
Date:   Wed, 28 Oct 2020 10:03:05 +0800
Message-Id: <20201028020305.10593-3-sherry.sun@nxp.com>
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
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR03CA0088.eurprd03.prod.outlook.com (2603:10a6:208:69::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 02:04:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bf4c3c7-7a2b-487a-1633-08d87ae5caea
X-MS-TrafficTypeDiagnostic: VI1PR04MB3229:|VI1PR04MB6928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB32293B99866281D0B70A2EB692170@VI1PR04MB3229.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYOowfKjkIhskpTidSiqrwqmwxt1wjZxxsxR6tBo4XdbUI2ZHSNsZfE1FJcch++ju3iXsjMV4JsPoMZVLsJlGe4fvyj9YObCZ6rMMVfmdAp+ZMP1M8bED4r3Kfkj6C07+R4DznpSbZa5yTGP5i+QBkw367029ZR2G+IGJxcsRIhYYTKf1qjHdW9YYwoIxElv4U7fVUfHvFWqOtcdvWyi786q7+gLwLDYv00O4AWekqvCqqQdfNTlYyY0zph8RbFhvy9B0qcjYXypgGkMNZnyp3WJS6CaFxlJ/x2W1RQU8LQsfg+naHvyupI0AfRnJZ6dTrm/OI5/R6dN7EB/0nFL1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(36756003)(2616005)(1076003)(44832011)(52116002)(2906002)(26005)(6506007)(478600001)(956004)(8936002)(83380400001)(16526019)(86362001)(8676002)(4326008)(316002)(5660300002)(186003)(7416002)(6512007)(66476007)(6666004)(66556008)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i4LBYoPWfeMWjxnJulYW40D523L0UNyWGODZ+jINwAwwI5HzvYYIACemZZ2nskOse/fjIfuLVxdfaskeeXICpIfjy/ogV2emYohhkt3PNgMzH+Hjw8ZuQ/oWy0W6tIaMwhqh64ELDGa9RHTwWeaL37+oC/tU1Y6A5cGHrJyk+nLQrCDaAsy/9tAE8vuWf0djtuMXrXRrONenaVvwjQby3NugeSHfWGy/dAuGmE277xq8iA2H98HOso0fIjBTCkpkm+N9oBjruVMoCl36IN8W0FGRoBOkvGb2YzmX398dDNLju+cWVWxwo4kQCY4/E0BcCj6RrrzeBaoUpDJ9FRXWKLRIoK0WwTz0akDlwh9kyhz++yPKmzfN2+epxOTLGcxSBcOASaRTBLmLpPsRIsQ+eJaWs6uQYu1OgAdyikdY/2AGK3IYpKHtowDCh6k+M22XwTR9JrfIF7I2T//WIVHWRWZ9axfFycvh1/L7AiV8NWC35K6nnoOhYalwDXsVwYxTHzsAMHHCINxHTCH9Xxd0Sv6otrmlmbIwY1cNI8YbnQ6eE2qne9wocYO0xpf4Ktum6tEQgDJUbHRAkFeV7O+FgY2tNVvXQzXrHhhQUjFtgAfut3ZiyIVGJ6Le4jU4IPG1Rc8+aFJzC+jWoSPU//3Ndg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4c3c7-7a2b-487a-1633-08d87ae5caea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 02:04:24.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpUwfqMBtRXPEiRgP97qxYlbiDK0xdXECj+H1IgCuutKOLEvnNIEWeqJR9ESBzwwUuJVhDktzol4DZh2iyk3QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
X-OriginatorOrg: nxp.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We don't need to allocate and reassign the used ring here and remove the
used_address_updated flag. Since RC has allocated the entire vring,
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
 drivers/misc/mic/vop/vop_debugfs.c |  4 --
 drivers/misc/mic/vop/vop_main.c    | 70 ++----------------------------
 drivers/misc/mic/vop/vop_vringh.c  | 31 -------------
 include/uapi/linux/mic_common.h    |  9 ++--
 4 files changed, 8 insertions(+), 106 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_debugfs.c b/drivers/misc/mic/vop/vop_debugfs.c
index 9d4f175f4dd1..27373b6dcea2 100644
--- a/drivers/misc/mic/vop/vop_debugfs.c
+++ b/drivers/misc/mic/vop/vop_debugfs.c
@@ -62,8 +62,6 @@ static int vop_dp_show(struct seq_file *s, void *pos)
 			seq_printf(s, "address 0x%llx ",
 				   vqconfig->address);
 			seq_printf(s, "num %d ", vqconfig->num);
-			seq_printf(s, "used address 0x%llx\n",
-				   vqconfig->used_address);
 		}
 
 		features = (__u32 *)mic_vq_features(d);
@@ -79,8 +77,6 @@ static int vop_dp_show(struct seq_file *s, void *pos)
 		seq_printf(s, "Vdev reset %d\n", dc->vdev_reset);
 		seq_printf(s, "Guest Ack %d ", dc->guest_ack);
 		seq_printf(s, "Host ack %d\n", dc->host_ack);
-		seq_printf(s, "Used address updated %d ",
-			   dc->used_address_updated);
 		seq_printf(s, "Vdev 0x%llx\n", dc->vdev);
 		seq_printf(s, "c2h doorbell %d ", dc->c2h_vdev_db);
 		seq_printf(s, "h2c doorbell %d\n", dc->h2c_vdev_db);
diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 714b94f42d38..226f462ab6a9 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -32,9 +32,6 @@
  * @dc: Virtio device control
  * @vpdev: VOP device which is the parent for this virtio device
  * @vr: Buffer for accessing the VRING
- * @used_virt: Virtual address of used ring
- * @used: DMA address of used ring
- * @used_size: Size of the used buffer
  * @reset_done: Track whether VOP reset is complete
  * @virtio_cookie: Cookie returned upon requesting a interrupt
  * @c2h_vdev_db: The doorbell used by the guest to interrupt the host
@@ -47,9 +44,6 @@ struct _vop_vdev {
 	struct mic_device_ctrl __iomem *dc;
 	struct vop_device *vpdev;
 	void __iomem *vr[VOP_MAX_VRINGS];
-	void *used_virt[VOP_MAX_VRINGS];
-	dma_addr_t used[VOP_MAX_VRINGS];
-	int used_size[VOP_MAX_VRINGS];
 	struct completion reset_done;
 	struct mic_irq *virtio_cookie;
 	int c2h_vdev_db;
@@ -250,10 +244,6 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
 	struct vop_device *vpdev = vdev->vpdev;
 
-	dma_unmap_single(&vpdev->dev, vdev->used[n],
-			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vdev->used_virt[n],
-		   get_order(vdev->used_size[n]));
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -278,14 +268,12 @@ static struct virtqueue *vop_new_virtqueue(unsigned int index,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
-				      const char *name,
-				      void *used)
+				      const char *name)
 {
 	bool weak_barriers = false;
 	struct vring vring;
 
 	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
-	vring.used = used;
 
 	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				     notify, callback, name);
@@ -308,7 +296,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	struct virtqueue *vq;
 	void __iomem *va;
 	struct _mic_vring_info __iomem *info;
-	void *used;
 	int vr_size, _vr_size, err, magic;
 	u8 type = ioread8(&vdev->desc->type);
 
@@ -337,45 +324,16 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 		goto unmap;
 	}
 
-	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
-					     sizeof(struct vring_used_elem) *
-					     le16_to_cpu(config.num));
-	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(vdev->used_size[index]));
-	vdev->used_virt[index] = used;
-	if (!used) {
-		err = -ENOMEM;
-		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto unmap;
-	}
-
 	vq = vop_new_virtqueue(index, le16_to_cpu(config.num), dev, ctx,
 			       (void __force *)va, vop_notify, callback,
-			       name, used);
+			       name);
 	if (!vq) {
 		err = -ENOMEM;
-		goto free_used;
-	}
-
-	vdev->used[index] = dma_map_single(&vpdev->dev, used,
-					    vdev->used_size[index],
-					    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
-		err = -ENOMEM;
-		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto del_vq;
+		goto unmap;
 	}
-	writeq(vdev->used[index], &vqconfig->used_address);
 
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
@@ -388,9 +346,7 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 			struct irq_affinity *desc)
 {
 	struct _vop_vdev *vdev = to_vopvdev(dev);
-	struct vop_device *vpdev = vdev->vpdev;
-	struct mic_device_ctrl __iomem *dc = vdev->dc;
-	int i, err, retry, queue_idx = 0;
+	int i, err, queue_idx = 0;
 
 	/* We must have this many virtqueues. */
 	if (nvqs > ioread8(&vdev->desc->num_vq))
@@ -412,24 +368,6 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
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
index 39d34b164ede..fac46f3ca5fe 100644
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
index 504e523f702c..9560fb033a7f 100644
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
@@ -110,12 +109,12 @@ struct mic_device_page {
  *
  * @address: Guest/MIC physical address of the virtio ring
  * (avail and desc rings)
- * @used_address: Guest/MIC physical address of the used ring
+ * @must_be_zero: Reserved because this bit is no longer needed.
  * @num: The number of entries in the virtio_ring
  */
 struct mic_vqconfig {
 	__le64 address;
-	__le64 used_address;
+	__le64 must_be_zero;
 	__le16 num;
 } __attribute__ ((aligned(8)));
 
-- 
2.17.1

