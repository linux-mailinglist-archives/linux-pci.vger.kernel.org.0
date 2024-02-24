Return-Path: <linux-pci+bounces-3977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F98627B1
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10BCB216F3
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35654C63F;
	Sat, 24 Feb 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/tiOUxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C64D58A;
	Sat, 24 Feb 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808734; cv=none; b=TmNy6Pg9Qb70uB4b5RNK0SxLp1hD6D4Bbss+CQE63pBCQ9i27rT+BktjzWwe/p+7XZ5ittuBZs+DjUwgcP97VY3Kr1KAynkuaayFOk/TRmyHaONRnCw8bTnfeipFQ5EZQnCZhGOMiPVW0e3nskSfwk5YmDndL6BGQdv1XsMIceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808734; c=relaxed/simple;
	bh=lRttZmQNTw21BgVWakImlughb13KBHC+Qci0MXF9GOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUj6mGlpkPG1eq1elxq9Wt7veSA2WxpkKRaHN8Iou0GRBqKTEBPzs3/g+L5Kr3RAeQKCofAZOmPr9AQp2Gt3BAglE8wvi+GcVOgd3MTP/4nkY1iGuxl16Dl9jVJCgQqaUv4toNCFu9xGEwCZYL5yvmkg/HhYv9eQNiGxSgymYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/tiOUxH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso217069866b.0;
        Sat, 24 Feb 2024 13:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708808729; x=1709413529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN49lQzjtE6+iXJdiQKLN7wqUf9e+d5Lk3YvA/DpZdE=;
        b=D/tiOUxHDAQmE+u1Tn54yoApvUaGrQ8jEDQeeLmdnKtOOmBUg9q4FIPs3xBrXD4iqb
         OPSHJnrtCAePrAHagcRi7KXf5eK8Wdj/56I5LbYHTD8x4zX7Y0Tm74aJX6Ql0FO0ZltM
         LwHmGauwML8ZhlBa2LdQN1s20z5eiwqzxpguADxx94iuPrWc8HBS7cDIJpwZ4kHFL+KL
         cyYch6bgVm7f6FmM8zs8Cb2f+PC/sCfT7mZlBgwRoO8DZNC3IDYLdtgxmA1+jQ7DjwuU
         ivh62KdydErkHZq04zhpX2AMqHbb7d2JFaJX3ZC2rV9G76QwDFXojjCHBCfh1v9oit3z
         SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808729; x=1709413529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN49lQzjtE6+iXJdiQKLN7wqUf9e+d5Lk3YvA/DpZdE=;
        b=O8BVCcExF8qfVhhfnQFFz5wjL09CVRRzLFLj+5HxcO6Rt54G8LUFsN0Ak6Eymq7lWi
         9gakz3Uqh0srA2qiuiu2yoY+OVrm4IQReFZuMrlJy1SXZFzreVzEE+6vxMzvYlfCJ+nk
         Wi9JamckEsJoqkAWX3qvcccxI/+bu+z0uFWQgFp4ZOnC7z2Ja8DVZbtoZm4vcVrvCA6+
         CWLgeyVByvQflYDWGXxE8+nzK/E84OXaoFkmWMHN36YEsVrxEa02Lk/DGkhjStnbXY8D
         iaM/Fq3Z5PoSM077fe8DjIidr8VnmdoVVEoDniEqCHzZC6K03pKjqQEYu4W+b7eDyBX7
         DfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqcmRdg6HOqK5kNX9Dfv0Wy5glI3KkUPH21NYZ/UDG9ld3ikEbC2x/GpMDHNZUZ+qNmeUe1P7KbwaLOQzzSseTEH7TFt5dXEAMpiAZGE1c8iIWmhe4T5euIjwKWeP0XPfkacerJU8sSXd5UD/J/t9joYD9WtPUoTiMwEgSSK88/hqbEwBUHg/gqGHhCGlKS4fVktsRgZc7um+7+pOctg=
X-Gm-Message-State: AOJu0YwCIsIVoDN4YwvSmCoA+sH23JDLdQgD5FDk3aReZ0su3CHTy15w
	0m8g/Sw6+TCo40qVNrVWIS0a+ee80qrNCmebh44xzbQzCze1ga7Q
X-Google-Smtp-Source: AGHT+IGP+j3lBCMnqf/VcQCAhUGatauaLS1slnx02H+ejbhJaSsxOkw13gpyVPwfD3uxWtT/x7v+QA==
X-Received: by 2002:a17:906:7196:b0:a43:1403:5c75 with SMTP id h22-20020a170906719600b00a4314035c75mr313029ejk.37.1708808728762;
        Sat, 24 Feb 2024 13:05:28 -0800 (PST)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0:2bc0:19d3:9979:8e10])
        by smtp.googlemail.com with ESMTPSA id c22-20020a170906171600b00a3e4efbfdacsm891148eje.225.2024.02.24.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:05:28 -0800 (PST)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shunsuke Mie <mie@igel.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] PCI: Add PCI driver for a PCI EP remote Blockdevice
Date: Sat, 24 Feb 2024 22:04:01 +0100
Message-Id: <20240224210409.112333-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224210409.112333-1-wafgo01@gmail.com>
References: <20240224210409.112333-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI Remote Disk Driver for the PCI Endpoint Block Passthrough
function driver. This driver allows you to access the block devices
from a remote PCI Endpoint driver (pci-epf-block-passthru) as local block devices.

This driver is the complement of the Endpoint
function driver (configured through the
CONFIG_PCI_EPF_BLOCK_PASSTHROUGH option on the EP device which exposes
its Block Devices).

After the endpoint driver has configured which Block devices it
wants to export, this driver is responsible to configure (again
through ConfigFS) on the Host
side to which of the exported devices the Host (RC) wants to attach
to.

After the devices are attached to the Host, it can access those
devices as local block devices.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/block/Kconfig           |   14 +
 drivers/block/Makefile          |    1 +
 drivers/block/pci-remote-disk.c | 1047 +++++++++++++++++++++++++++++++
 3 files changed, 1062 insertions(+)
 create mode 100644 drivers/block/pci-remote-disk.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..f01ae15f4a5e 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -402,6 +402,20 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 	  suggested to enable N if your application(ublk server) switches to
 	  ioctl command encoding.
 
+config PCI_REMOTE_DISK
+	tristate "PCI Remote Disk"
+	depends on BLOCK && PCI
+	select CONFIGFS_FS
+	help
+	  Say Y here if you want include the PCI remote disk, which allows you to map the blockdevices
+	  from a remote PCI Endpoint driver as local block devices. This can be useful if you
+	  have multiple SoCs in your system where the block devices are connected to one SoC and you want to access
+	  those from the other SoC. The decision to which remote disk you want to attach is done through CONFIG_FS.
+	  This option is the complement to the CONFIG_PCI_EPF_BLOCK_PASSTHROUGH options which must
+	  be set on the Endpoint device which exposes its Block Devices.
+
+	  If unsure, say N.
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..94a10c87b97e 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SUNVDC)		+= sunvdc.o
 
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
+obj-$(CONFIG_PCI_REMOTE_DISK)   += pci-remote-disk.o
 
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= xen-blkback/
diff --git a/drivers/block/pci-remote-disk.c b/drivers/block/pci-remote-disk.c
new file mode 100644
index 000000000000..ed258e41997a
--- /dev/null
+++ b/drivers/block/pci-remote-disk.c
@@ -0,0 +1,1047 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCI Remote Disk Device Driver
+ *
+ * Wadim Mueller <wafgo01@gmail.com>
+ */
+
+#include <linux/major.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/random.h>
+#include <linux/uaccess.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/pci_regs.h>
+#include <linux/hdreg.h>
+#include <linux/kthread.h>
+#include <linux/configfs.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-epf-block-passthru.h>
+
+#define NUM_DESRIPTORS 256
+
+/*
+* Queue Size calculation is based on the following layout
+*
+* +------------------------+
+* |      1. Descriptor     |
+* +------------------------+
+* |      2. Descriptor     |
+* +------------------------+
+* |            :           |
+* +------------------------+
+* |            :           |
+* +------------------------+
+* |     Last Descriptor    |
+* +------------------------+
+* +------------------------+
+* |     Driver Ring        |
+* |           :            |
+* |           :            |
+* +------------------------+
+* +------------------------+
+* |     Device Ring        |
+* |           :            |
+* |           :            |
+* +------------------------+
+*/
+
+#define QSIZE                                                         \
+	(ALIGN(NUM_DESRIPTORS * sizeof(struct pci_epf_blockpt_descr), \
+	       sizeof(u64)) +                                         \
+	 ALIGN(sizeof(struct pci_blockpt_driver_ring) +               \
+		       (NUM_DESRIPTORS * sizeof(u16)),                \
+	       sizeof(u64)) +                                         \
+	 ALIGN(sizeof(struct pci_blockpt_device_ring) +               \
+		       (NUM_DESRIPTORS * sizeof(u16)),                \
+	       sizeof(u64)))
+
+#define RD_STATUS_TIMEOUT_COUNT (100)
+
+#define DRV_MODULE_NAME "pci-remote-disk"
+
+#define rd_readb(_x) readb(_x)
+#define rd_readw(_x) cpu_to_le16(readw(_x))
+#define rd_readl(_x) cpu_to_le32(readl(_x))
+#define rd_readq(_x) cpu_to_le64(readq(_x))
+
+#define rd_writeb(v, _x) writeb(v, _x)
+#define rd_writew(v, _x) writew(cpu_to_le16(v), _x)
+#define rd_writel(v, _x) writel(cpu_to_le32(v), _x)
+#define rd_writeq(v, _x) writeq(cpu_to_le64(v), _x)
+
+struct pci_remote_disk_common;
+struct pci_remote_disk_device;
+
+struct pci_remote_disk_queue {
+	struct pci_epf_blockpt_descr __iomem *descr_ring;
+	struct pci_blockpt_driver_ring __iomem *drv_ring;
+	struct pci_blockpt_device_ring __iomem *dev_ring;
+	u64 *descr_tags;
+	u32 descr_size;
+	u32 qbar_offset;
+	u32 drv_offset;
+	u32 dev_offset;
+	u16 drv_idx;
+	u16 dev_idx;
+	int irq;
+	u16 ns_idx;
+	struct task_struct *dp_thr;
+	char irq_name[32];
+	struct semaphore dig_sem;
+	spinlock_t lock;
+	struct task_struct *digest_task;
+	struct pci_remote_disk_device *rdd;
+	u8 idx;
+};
+
+struct pci_remote_disk_device {
+	struct list_head node;
+	struct pci_remote_disk_common *rcom;
+	struct blk_mq_tag_set tag_set;
+	struct config_group cfs_group;
+	struct gendisk *gd;
+	struct pci_remote_disk_queue *queue;
+	u32 num_queues;
+	sector_t capacity;
+	char *r_name;
+	char *npr_name;
+	char *l_name;
+	u8 id;
+	bool attached;
+	bool read_only;
+	size_t queue_space_residue;
+	const struct blk_mq_queue_data *bd;
+};
+
+struct pci_remote_disk_common {
+	struct list_head bd_list;
+	struct pci_dev *pdev;
+	struct pci_epf_blockpt_reg __iomem *base;
+	void __iomem *qbase;
+	void __iomem *qbase_next;
+	void __iomem *bar[PCI_STD_NUM_BARS];
+	int num_irqs;
+	u32 num_queues;
+	size_t qsize;
+};
+
+struct pci_remote_disk_request {
+	struct pci_remote_disk_queue *queue;
+	struct bio *bio;
+	blk_status_t status;
+	struct page *pg;
+	int order;
+	int num_bios;
+	int descr_idx;
+	struct pci_epf_blockpt_descr *descr;
+};
+
+static LIST_HEAD(available_remote_disks);
+
+static irqreturn_t pci_rd_irqhandler(int irq, void *dev_id);
+static blk_status_t pci_rd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *bd);
+static void pci_rd_end_rq(struct request *rq);
+static enum blk_eh_timer_return pci_rd_timeout_rq(struct request *rq);
+
+static const struct blk_mq_ops pci_rd_mq_ops = { .queue_rq = pci_rd_queue_rq,
+						 .complete = pci_rd_end_rq,
+						 .timeout = pci_rd_timeout_rq };
+
+static int pci_rd_open(struct gendisk *bd_disk, fmode_t mode);
+static void pci_rd_release(struct gendisk *disk);
+static int pci_rd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+static int pci_rd_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned int cmd, unsigned long arg);
+static int pci_rd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg);
+
+static int pci_remote_disk_dispatch(void *cookie);
+
+static const struct block_device_operations pci_rd_ops = {
+	.open = pci_rd_open,
+	.release = pci_rd_release,
+	.getgeo = pci_rd_getgeo,
+	.owner = THIS_MODULE,
+	.ioctl = pci_rd_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = pci_rd_compat_ioctl,
+#endif
+};
+
+static int pci_remote_disk_send_command(struct pci_remote_disk_common *rcom,
+					u32 cmd)
+{
+	int timeout = 0;
+
+	smp_wmb();
+	rd_writel(cmd, &rcom->base->command);
+	while (++timeout < RD_STATUS_TIMEOUT_COUNT &&
+	       rd_readl(&rcom->base->status) != BPT_STATUS_SUCCESS) {
+		usleep_range(100, 200);
+	}
+
+	if (rd_readl(&rcom->base->status) != BPT_STATUS_SUCCESS) {
+		return -ENODEV;
+	}
+
+	rd_writel(0, &rcom->base->status);
+	return 0;
+}
+
+static inline struct pci_remote_disk_device *
+to_remote_disk_dev(struct config_item *item)
+{
+	return container_of(to_config_group(item),
+			    struct pci_remote_disk_device, cfs_group);
+}
+
+static ssize_t pci_remote_disk_group_remote_name_show(struct config_item *item,
+						      char *page)
+{
+	struct pci_remote_disk_device *rdd = to_remote_disk_dev(item);
+	return sprintf(page, "%s", rdd->r_name);
+}
+
+CONFIGFS_ATTR_RO(pci_remote_disk_group_, remote_name);
+
+static ssize_t pci_remote_disk_group_local_name_show(struct config_item *item,
+						     char *page)
+{
+	struct pci_remote_disk_device *rdd = to_remote_disk_dev(item);
+	return sprintf(page, "%s", rdd->l_name);
+}
+
+static ssize_t pci_remote_disk_group_local_name_store(struct config_item *item,
+						      const char *page,
+						      size_t len)
+{
+	struct pci_remote_disk_device *rdd = to_remote_disk_dev(item);
+	if (rdd->l_name)
+		kfree(rdd->l_name);
+	rdd->l_name = kasprintf(GFP_KERNEL, "%s", page);
+	return len;
+}
+
+CONFIGFS_ATTR(pci_remote_disk_group_, local_name);
+
+static ssize_t pci_remote_disk_group_attach_show(struct config_item *item,
+						 char *page)
+{
+	struct pci_remote_disk_device *rdd = to_remote_disk_dev(item);
+	return sprintf(page, "%d\n", rdd->attached);
+}
+
+static int pci_remote_disk_attach(struct pci_remote_disk_device *rdd)
+{
+	int ret, i;
+	struct device *dev = &rdd->rcom->pdev->dev;
+	struct pci_epf_blockpt_reg __iomem *base = rdd->rcom->base;
+
+	rd_writeb(rdd->id, &base->dev_idx);
+
+	ret = pci_remote_disk_send_command(rdd->rcom,
+					   BPT_COMMAND_GET_NUM_SECTORS);
+	if (ret) {
+		dev_err(dev, "%s: cannot get number of sectors\n",
+			rdd->npr_name);
+		return -ENODEV;
+	}
+
+	rdd->capacity = rd_readq(&base->num_sectors);
+	dev_dbg(dev, "%s capacity 0x%llx\n", rdd->r_name, rdd->capacity);
+	ret = pci_remote_disk_send_command(rdd->rcom,
+					   BPT_COMMAND_GET_PERMISSION);
+	if (ret) {
+		dev_err(dev, "%s: cannot get permission, assume RO\n",
+			rdd->npr_name);
+		rdd->read_only = true;
+	} else {
+		rdd->read_only = rd_readb(&base->perm) & BPT_PERMISSION_RO;
+		dev_dbg(dev, "%s: map in RW mode\n", rdd->npr_name);
+	}
+
+	for (i = 0; i < rdd->num_queues; ++i) {
+		struct pci_remote_disk_queue *queue = &rdd->queue[i];
+		int irq = (rdd->id * rdd->num_queues) + i;
+
+		if (rdd->rcom->qsize < QSIZE) {
+			dev_err(dev,
+				"%s: cannot allocate queue %d, no space left\n",
+				rdd->l_name, i);
+			goto err_free_irq;
+		}
+
+		queue->descr_size = QSIZE;
+		queue->descr_ring = (struct pci_epf_blockpt_descr
+					     *)((u64)rdd->rcom->qbase_next +
+						(u64)(queue->descr_size));
+		rdd->rcom->qbase_next = (void __iomem *)queue->descr_ring;
+		queue->qbar_offset =
+			((u64)rdd->rcom->qbase_next - (u64)rdd->rcom->qbase);
+		memset_io(queue->descr_ring, 0, queue->descr_size);
+		queue->drv_offset =
+			ALIGN(NUM_DESRIPTORS * sizeof(*queue->descr_ring),
+			      sizeof(u64));
+		queue->dev_offset =
+			queue->drv_offset +
+			ALIGN(sizeof(struct pci_blockpt_driver_ring) +
+				      (NUM_DESRIPTORS * sizeof(u16)),
+			      sizeof(u64));
+		queue->drv_ring =
+			(struct pci_blockpt_driver_ring
+				 *)((u64)queue->descr_ring + queue->drv_offset);
+		queue->dev_ring =
+			(struct pci_blockpt_device_ring
+				 *)((u64)queue->descr_ring + queue->dev_offset);
+		sema_init(&queue->dig_sem, 0);
+		queue->dev_idx = queue->drv_idx = queue->ns_idx = 0;
+		dev_dbg(dev,
+			"%s: Setting queue %d addr. #Descriptors %i (%i Bytes). Queue Offset %d\n",
+			rdd->npr_name, i, NUM_DESRIPTORS, queue->descr_size,
+			queue->qbar_offset);
+		snprintf(queue->irq_name, sizeof(queue->irq_name), "rdd-%s-q%d",
+			 rdd->npr_name, i);
+		queue->irq = pci_irq_vector(rdd->rcom->pdev, irq);
+		ret = devm_request_irq(dev, queue->irq, pci_rd_irqhandler,
+				       IRQF_SHARED, queue->irq_name, queue);
+		if (ret) {
+			dev_err(dev, "Can't register %s IRQ. Id %i.\n",
+				queue->irq_name, queue->irq);
+			goto err_free_irq;
+		}
+
+		rd_writeb((u8)i, &base->qidx);
+		rd_writel(queue->drv_offset, &base->drv_offset);
+		rd_writel(queue->dev_offset, &base->dev_offset);
+		rd_writel(NUM_DESRIPTORS, &base->num_desc);
+		rd_writel(queue->descr_size, &base->qsize);
+
+		rd_writel(queue->qbar_offset, &base->queue_offset);
+		ret = pci_remote_disk_send_command(rdd->rcom,
+						   BPT_COMMAND_SET_QUEUE);
+		if (ret) {
+			dev_err(dev, "%s: cannot set queue %d\n", rdd->npr_name,
+				i);
+			goto err_free_irq;
+		}
+
+		rd_writel(irq + 1, &base->irq);
+		ret = pci_remote_disk_send_command(rdd->rcom,
+						   BPT_COMMAND_SET_IRQ);
+		if (ret) {
+			dev_err(dev, "%s: cannot set irq for queue %d\n",
+				rdd->npr_name, i);
+			goto err_free_irq;
+		}
+		queue->digest_task = kthread_create(pci_remote_disk_dispatch,
+						    queue, "rdt-%s.q%d",
+						    rdd->npr_name, i);
+		if (IS_ERR(queue->digest_task)) {
+			dev_err(dev,
+				"%s: Cannot create kernel digest thread for queue %d\n",
+				rdd->npr_name, i);
+			ret = PTR_ERR(queue->digest_task);
+			goto err_free_irq;
+		}
+		rdd->rcom->qsize -= QSIZE;
+		wake_up_process(queue->digest_task);
+	}
+
+	ret = pci_remote_disk_send_command(rdd->rcom, BPT_COMMAND_START);
+	if (ret) {
+		dev_err(dev, "%s: cannot start device\n", rdd->npr_name);
+		goto err_free_irq;
+	}
+
+	rdd->tag_set.ops = &pci_rd_mq_ops;
+	rdd->tag_set.queue_depth = 32;
+	rdd->tag_set.numa_node = NUMA_NO_NODE;
+	rdd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	rdd->tag_set.nr_hw_queues = num_present_cpus();
+	rdd->tag_set.timeout = 5 * HZ;
+	rdd->tag_set.cmd_size = sizeof(struct pci_remote_disk_request);
+	rdd->tag_set.driver_data = rdd;
+	ret = blk_mq_alloc_tag_set(&rdd->tag_set);
+	if (ret) {
+		dev_err(dev, "%s: Could not allocate tag set\n", rdd->npr_name);
+		goto err_free_irq;
+	}
+
+	rdd->gd = blk_mq_alloc_disk(&rdd->tag_set, NULL, rdd);
+	if (IS_ERR(rdd->gd)) {
+		ret = -ENODEV;
+		goto err_blk_mq_free;
+	}
+
+	rdd->gd->fops = &pci_rd_ops;
+	rdd->gd->private_data = rdd->gd->queue->queuedata = rdd;
+	snprintf(rdd->gd->disk_name, sizeof(rdd->gd->disk_name), "%s",
+		 rdd->l_name);
+	set_capacity(rdd->gd, rdd->capacity);
+
+	if (rdd->read_only)
+		dev_dbg(dev, "%s attached in RO mode\n", rdd->npr_name);
+
+	rdd->attached = true;
+	set_disk_ro(rdd->gd, rdd->read_only);
+	return device_add_disk(dev, rdd->gd, NULL);
+
+err_blk_mq_free:
+	blk_mq_free_tag_set(&rdd->tag_set);
+err_free_irq:
+	for (i = 0; i < rdd->num_queues; ++i) {
+		struct pci_remote_disk_queue *queue = &rdd->queue[i];
+		if (queue && queue->irq != -EINVAL)
+			devm_free_irq(dev, queue->irq, queue);
+	}
+
+	return ret;
+}
+
+static int pci_remote_disk_detach(struct pci_remote_disk_device *rdd)
+{
+	struct device *dev = &rdd->rcom->pdev->dev;
+	struct pci_epf_blockpt_reg __iomem *base = rdd->rcom->base;
+	int ret, i;
+
+	rd_writeb(rdd->id, &base->dev_idx);
+	ret = pci_remote_disk_send_command(rdd->rcom, BPT_COMMAND_STOP);
+	if (ret) {
+		dev_err(dev, "%s: cannot stop device\n", rdd->npr_name);
+		return ret;
+	}
+
+	for (i = 0; i < rdd->num_queues; ++i) {
+		struct pci_remote_disk_queue *queue = &rdd->queue[i];
+		kthread_stop(queue->digest_task);
+	}
+
+	del_gendisk(rdd->gd);
+	blk_mq_free_tag_set(&rdd->tag_set);
+	for (i = 0; i < rdd->num_queues; ++i) {
+		struct pci_remote_disk_queue *queue = &rdd->queue[i];
+		if (queue->irq != -EINVAL) {
+			devm_free_irq(dev, queue->irq, queue);
+			queue->irq = -EINVAL;
+		}
+	}
+
+	put_disk(rdd->gd);
+	rdd->attached = false;
+	return 0;
+}
+
+static ssize_t pci_remote_disk_group_attach_store(struct config_item *item,
+						  const char *page, size_t len)
+{
+	bool attach;
+	struct pci_remote_disk_device *rdd = to_remote_disk_dev(item);
+
+	int ret = kstrtobool(page, &attach);
+
+	if (ret)
+		return ret;
+
+	if (!rdd->attached && attach)
+		ret = pci_remote_disk_attach(rdd);
+	else if (rdd->attached && !attach)
+		ret = pci_remote_disk_detach(rdd);
+	else
+		ret = -EINVAL;
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+CONFIGFS_ATTR(pci_remote_disk_group_, attach);
+
+static struct configfs_attribute *pci_remote_disk_group_attrs[] = {
+	&pci_remote_disk_group_attr_remote_name,
+	&pci_remote_disk_group_attr_local_name,
+	&pci_remote_disk_group_attr_attach,
+	NULL,
+};
+
+static const struct config_item_type pci_remote_disk_group_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = pci_remote_disk_group_attrs,
+};
+
+static const struct config_item_type pci_remote_disk_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct configfs_subsystem pci_remote_disk_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "pci_remote_disk",
+			.ci_type = &pci_remote_disk_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(pci_remote_disk_subsys.su_mutex),
+};
+
+static const struct pci_device_id pci_remote_disk_tbl[] = {
+	{
+		PCI_DEVICE(0x0, 0xc402),
+	},
+	{ 0 }
+};
+
+static int pci_rd_alloc_descriptor(struct pci_remote_disk_queue *queue)
+{
+	int i;
+	int ret = -ENOSPC;
+	struct device *dev = &queue->rdd->rcom->pdev->dev;
+	spin_lock(&queue->lock);
+	for (i = 0; i < NUM_DESRIPTORS; ++i) {
+		struct pci_epf_blockpt_descr __iomem *de =
+			&queue->descr_ring[queue->ns_idx];
+		u32 flags = READ_ONCE(de->si.flags);
+		if (!(flags & PBI_EPF_BLOCKPT_F_USED)) {
+			dev_dbg(dev, "Found free descriptor at idx %i\n",
+				queue->ns_idx);
+			WRITE_ONCE(de->si.flags,
+				   flags | PBI_EPF_BLOCKPT_F_USED);
+			ret = queue->ns_idx;
+			queue->ns_idx = (queue->ns_idx + 1) % NUM_DESRIPTORS;
+			goto unlock_return;
+		}
+		queue->ns_idx = (queue->ns_idx + 1) % NUM_DESRIPTORS;
+	}
+unlock_return:
+	spin_unlock(&queue->lock);
+	if (ret == -ENOSPC)
+		dev_err_ratelimited(dev, "No free descriptor for Queue %d\n",
+				    queue->idx);
+	return ret;
+}
+
+static bool is_valid_request(unsigned int op)
+{
+	return (op == REQ_OP_READ) || (op == REQ_OP_WRITE);
+}
+
+static blk_status_t pci_rd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *bd)
+{
+	struct req_iterator iter;
+	struct bio_vec bv;
+	int descr_idx;
+	struct pci_remote_disk_device *rdd = hctx->queue->queuedata;
+	struct pci_remote_disk_request *rb_req = blk_mq_rq_to_pdu(bd->rq);
+	struct device *dev = &rdd->rcom->pdev->dev;
+	struct pci_epf_blockpt_descr __iomem *dtu;
+	struct pci_blockpt_driver_ring __iomem *drv_ring;
+	dma_addr_t dma_addr;
+	char *buf;
+	int err;
+	/* this method works well to
+	 * distribute the load across the available queues */
+	struct pci_remote_disk_queue *queue =
+		&rdd->queue[smp_processor_id() % rdd->num_queues];
+
+	drv_ring = queue->drv_ring;
+	rb_req->queue = queue;
+	if (!is_valid_request(req_op(bd->rq))) {
+		dev_err(dev, "Unsupported Request: %i\n", req_op(bd->rq));
+		return BLK_STS_NOTSUPP;
+	}
+
+	descr_idx = pci_rd_alloc_descriptor(queue);
+	if (unlikely(descr_idx < 0))
+		return BLK_STS_AGAIN;
+
+	dtu = &queue->descr_ring[descr_idx];
+	rb_req->order = get_order(blk_rq_bytes(bd->rq));
+	rb_req->pg = alloc_pages(GFP_ATOMIC | GFP_DMA, rb_req->order);
+	if (unlikely(!rb_req->pg)) {
+		dev_err(dev, "cannot alloc %i page(s)\n", (1 << rb_req->order));
+		err = BLK_STS_AGAIN;
+		goto free_descr;
+	}
+
+	rb_req->descr = dtu;
+	rb_req->descr_idx = descr_idx;
+	buf = page_address(rb_req->pg);
+	dma_addr = dma_map_single(dev, buf, blk_rq_bytes(bd->rq),
+				  rq_dma_dir(bd->rq));
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(dev, "failed to map page for descriptor\n");
+		err = BLK_STS_AGAIN;
+		goto free_pages;
+	}
+
+	dtu->addr = dma_addr;
+	dtu->len = blk_rq_bytes(bd->rq);
+	dtu->si.opf = rq_data_dir(bd->rq);
+	if (dtu->si.opf == WRITE) {
+		rq_for_each_segment(bv, bd->rq, iter) {
+			memcpy_from_bvec(buf, &bv);
+			buf += bv.bv_len;
+		}
+	}
+
+	dtu->s_sector = blk_rq_pos(bd->rq);
+	queue->descr_tags[descr_idx] = (u64)rb_req;
+	spin_lock(&queue->lock);
+	rd_writew(descr_idx, &drv_ring->ring[queue->drv_idx]);
+	queue->drv_idx = (queue->drv_idx + 1) % NUM_DESRIPTORS;
+	rd_writew(queue->drv_idx, &drv_ring->idx);
+	spin_unlock(&queue->lock);
+	dev_dbg(dev,
+		"(DIR: %s): Adding desc %i (%i). sector: 0x%llX, len: 0x%x\n",
+		(rq_data_dir(bd->rq) == WRITE) ? "WRITE" : "READ", descr_idx,
+		queue->drv_idx, dtu->s_sector, dtu->len);
+	blk_mq_start_request(bd->rq);
+	return BLK_STS_OK;
+free_pages:
+	__free_pages(rb_req->pg, rb_req->order);
+free_descr:
+	memset(dtu, 0, sizeof(*dtu));
+	return err;
+}
+
+static void pci_rd_end_rq(struct request *rq)
+{
+	struct pci_remote_disk_request *rb_req = blk_mq_rq_to_pdu(rq);
+	blk_mq_end_request(rq, rb_req->status);
+}
+
+static enum blk_eh_timer_return pci_rd_timeout_rq(struct request *rq)
+{
+	struct pci_remote_disk_request *rb_req = blk_mq_rq_to_pdu(rq);
+	struct device *dev = &rb_req->queue->rdd->rcom->pdev->dev;
+	dev_err(dev, "%s : Timeout on queue%d: Descriptor %d\n",
+		rb_req->queue->rdd->l_name, rb_req->queue->idx,
+		rb_req->descr_idx);
+	return BLK_EH_DONE;
+}
+
+static int pci_rd_open(struct gendisk *bd_disk, fmode_t mode)
+{
+	struct pci_remote_disk_common *rcom = bd_disk->private_data;
+	dev_dbg(&rcom->pdev->dev, "%s called\n", __func__);
+	return 0;
+}
+
+static void pci_rd_release(struct gendisk *disk)
+{
+	struct pci_remote_disk_common *rcom = disk->private_data;
+	dev_dbg(&rcom->pdev->dev, "%s called\n", __func__);
+}
+
+static int pci_rd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct pci_remote_disk_common *rcom = bdev->bd_disk->private_data;
+	dev_dbg(&rcom->pdev->dev, "%s called\n", __func__);
+	geo->heads = 4;
+	geo->sectors = 16;
+	geo->cylinders =
+		get_capacity(bdev->bd_disk) / (geo->heads * geo->sectors);
+	return 0;
+}
+
+static int pci_rd_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+#ifdef CONFIG_COMPAT
+static int pci_rd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg)
+{
+	return pci_rd_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+static irqreturn_t pci_rd_irqhandler(int irq, void *dev_id)
+{
+	struct pci_remote_disk_queue *queue = dev_id;
+	struct device *dev = &queue->rdd->rcom->pdev->dev;
+
+	BUG_ON(!queue->rdd->attached);
+	dev_dbg(dev, "IRQ%d from %s.%d\n", irq, queue->rdd->l_name, queue->idx);
+	/* wakeup the process to digest the processed request*/
+	up(&queue->dig_sem);
+	return IRQ_HANDLED;
+}
+
+static void pci_rd_clear_descriptor(struct pci_remote_disk_queue *queue,
+				    struct pci_epf_blockpt_descr *descr,
+				    u16 descr_idx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	queue->descr_tags[descr_idx] = 0;
+	memset(descr, 0, sizeof(*descr));
+	spin_unlock_irqrestore(&queue->lock, flags);
+}
+
+static int pci_remote_disk_dispatch(void *cookie)
+{
+	struct pci_remote_disk_queue *queue = cookie;
+	struct device *dev = &queue->rdd->rcom->pdev->dev;
+	struct pci_blockpt_device_ring __iomem *dev_ring = queue->dev_ring;
+	struct req_iterator iter;
+	struct bio_vec bv;
+	int ret;
+	u16 descr_idx;
+	struct pci_epf_blockpt_descr *desc;
+	struct pci_remote_disk_request *rb_req;
+	struct request *rq;
+	void *buf;
+	unsigned long tmo = msecs_to_jiffies(250);
+
+	while (!kthread_should_stop()) {
+		ret = down_timeout(&queue->dig_sem, tmo);
+
+		if (rd_readw(&dev_ring->idx) == queue->dev_idx)
+			continue;
+
+		while (rd_readw(&dev_ring->idx) != queue->dev_idx) {
+			descr_idx = rd_readw(&dev_ring->ring[queue->dev_idx]);
+			desc = &queue->descr_ring[descr_idx];
+
+			BUG_ON(!(READ_ONCE(desc->si.flags) &
+				 PBI_EPF_BLOCKPT_F_USED));
+
+			rb_req = (struct pci_remote_disk_request *)
+					 queue->descr_tags[descr_idx];
+			BUG_ON(rb_req == NULL);
+
+			rq = blk_mq_rq_from_pdu(rb_req);
+
+			if (rq_data_dir(rq) == READ) {
+				buf = kmap_local_page(rb_req->pg);
+				rq_for_each_segment(bv, rq, iter) {
+					memcpy_to_bvec(&bv, buf);
+					buf += bv.bv_len;
+				}
+				kunmap_local(buf);
+			}
+
+			dma_unmap_single(dev, desc->addr, desc->len,
+					 rq_dma_dir(rq));
+			rb_req->status =
+				(blk_status_t)rd_readb(&desc->si.status);
+
+			pci_rd_clear_descriptor(queue, desc, descr_idx);
+			__free_pages(rb_req->pg, rb_req->order);
+			WRITE_ONCE(queue->dev_idx,
+				   (queue->dev_idx + 1) % NUM_DESRIPTORS);
+			blk_mq_complete_request(rq);
+		}
+	}
+
+	return 0;
+}
+
+static int pci_remote_disk_parse(struct pci_remote_disk_common *rcom)
+{
+	struct pci_remote_disk_device *rdd;
+	struct list_head *lh, *lhtmp;
+	char *sbd, *ebd;
+	int count = 0;
+	int err, i;
+	char *loc_st;
+	struct device *dev = &rcom->pdev->dev;
+
+	loc_st = kasprintf(GFP_KERNEL, "%s", rcom->base->dev_name);
+	sbd = ebd = loc_st;
+
+	while ((ebd = strchr(sbd, ';')) != NULL) {
+		rdd = kzalloc(sizeof(*rdd), GFP_KERNEL);
+		if (!rdd) {
+			dev_err(dev, "Could not allocate rd struct\n");
+			err = -ENOMEM;
+			goto err_free;
+		}
+
+		rdd->num_queues = rcom->num_queues;
+		rdd->queue = kcalloc(rdd->num_queues, sizeof(*rdd->queue),
+				     GFP_KERNEL | __GFP_ZERO);
+		if (rdd->queue == NULL) {
+			dev_err(dev, "unable to alloc queues for device %d\n",
+				count);
+			goto err_free;
+		}
+
+		for (i = 0; i < rdd->num_queues; ++i) {
+			struct pci_remote_disk_queue *queue = &rdd->queue[i];
+			queue->irq = -EINVAL;
+			queue->rdd = rdd;
+			queue->idx = i;
+			spin_lock_init(&queue->lock);
+			queue->descr_tags =
+				kzalloc((sizeof(u64) * NUM_DESRIPTORS),
+					GFP_KERNEL | __GFP_ZERO);
+			if (!queue->descr_tags) {
+				dev_err(dev,
+					"Could not allocate queue descriptor tags\n");
+				err = -ENOMEM;
+				goto err_free;
+			}
+		}
+
+		INIT_LIST_HEAD(&rdd->node);
+		list_add_tail(&rdd->node, &available_remote_disks);
+		rdd->r_name = kmemdup_nul(sbd, ebd - sbd, GFP_KERNEL);
+		if (!rdd->r_name) {
+			dev_err(dev,
+				"Could not allocate memory for remote device name\n");
+			err = -ENOMEM;
+			goto err_free;
+		}
+
+		rdd->rcom = rcom;
+		rdd->id = count;
+		/* get rid of all path seperators  */
+		rdd->npr_name = strrchr(rdd->r_name, '/');
+		rdd->npr_name = (rdd->npr_name == NULL) ? rdd->r_name :
+							  (rdd->npr_name + 1);
+		rdd->l_name = kasprintf(GFP_KERNEL, "pci-rd-%s", rdd->npr_name);
+		if (!rdd->l_name) {
+			dev_err(dev,
+				"Could not allocate memory for local device name\n");
+			err = -ENOMEM;
+			goto err_free;
+		}
+
+		config_group_init_type_name(&rdd->cfs_group, rdd->npr_name,
+					    &pci_remote_disk_group_type);
+		err = configfs_register_group(&pci_remote_disk_subsys.su_group,
+					      &rdd->cfs_group);
+		if (err) {
+			dev_err(dev, "Cannot register configfs group for %s\n",
+				rdd->npr_name);
+			err = -ENODEV;
+			goto err_free;
+		}
+
+		dev_info(dev, "Found %s\n", rdd->r_name);
+		sbd = ebd + 1;
+		count++;
+	}
+
+	kfree(loc_st);
+	return count;
+
+err_free:
+	kfree(loc_st);
+	list_for_each_safe(lh, lhtmp, &available_remote_disks) {
+		rdd = list_entry(lh, struct pci_remote_disk_device, node);
+		if (rdd->r_name) {
+			kfree(rdd->r_name);
+			configfs_unregister_group(&rdd->cfs_group);
+		}
+		kfree(rdd->l_name);
+		list_del(lh);
+		for (i = 0; i < rdd->num_queues; ++i) {
+			struct pci_remote_disk_queue *queue = &rdd->queue[i];
+			if (queue && queue->descr_tags) {
+				kfree(queue->descr_tags);
+				queue = NULL;
+			}
+		}
+		kfree(rdd->queue);
+		kfree(rdd);
+	}
+	return err;
+}
+
+static int pci_remote_disk_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	int err, num, num_irqs;
+	enum pci_barno bar;
+	enum pci_barno def_reg_bar = NO_BAR;
+	void __iomem *base;
+	struct pci_remote_disk_common *rcom =
+		devm_kzalloc(dev, sizeof(*rcom), GFP_KERNEL);
+	if (!rcom)
+		return -ENOMEM;
+
+	rcom->pdev = pdev;
+	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
+		err = -ENODEV;
+		dev_err(dev, "Cannot set DMA mask\n");
+		goto out_free_dev;
+	}
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device\n");
+		goto out_free_dev;
+	}
+
+	err = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (err) {
+		dev_err(dev, "Cannot obtain PCI resources\n");
+		goto err_disable_pdev;
+	}
+
+	pci_set_master(pdev);
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
+			base = pci_ioremap_bar(pdev, bar);
+			if (!base) {
+				dev_err(dev, "Failed to read BAR%d\n", bar);
+				WARN_ON(bar == def_reg_bar);
+			}
+			rcom->bar[bar] = base;
+			if (rd_readl(base) == BLOCKPT_MAGIC) {
+				def_reg_bar = bar;
+				dev_dbg(dev, "valid magic found at BAR%d", bar);
+				break;
+			}
+		}
+	}
+
+	if (def_reg_bar == NO_BAR) {
+		err = -ENODEV;
+		dev_err(dev, "Unable to find valid BAR\n");
+		goto err_iounmap;
+	}
+
+	rcom->base = rcom->bar[def_reg_bar];
+	if (!rcom->base) {
+		err = -ENOMEM;
+		dev_err(dev, "Cannot perform PCI communictaion without BAR%d\n",
+			def_reg_bar);
+		goto err_iounmap;
+	}
+
+	rcom->qbase = rcom->qbase_next =
+		(void *)(u64)rcom->base +
+		rd_readl(&rcom->base->queue_bar_offset);
+	rcom->qsize = rd_readl(&rcom->base->available_qsize);
+	rcom->num_queues = rd_readb(&rcom->base->num_queues);
+	dev_dbg(dev, "%d queues per device available\n", rcom->num_queues);
+
+	err = pci_remote_disk_send_command(rcom, BPT_COMMAND_GET_DEVICES);
+	if (err) {
+		dev_err(dev, "Cannot get devices\n");
+		goto err_iounmap;
+	}
+
+	dev_dbg(dev, "%s available", rcom->base->dev_name);
+	config_group_init(&pci_remote_disk_subsys.su_group);
+	err = configfs_register_subsystem(&pci_remote_disk_subsys);
+	if (err) {
+		dev_err(dev, "Error %d while registering subsystem %s\n", err,
+			pci_remote_disk_subsys.su_group.cg_item.ci_namebuf);
+		goto err_iounmap;
+	}
+
+	INIT_LIST_HEAD(&available_remote_disks);
+	num = pci_remote_disk_parse(rcom);
+	if (num <= 0) {
+		dev_err(dev, "Unable to parse any valid disk\n");
+		err = -ENODEV;
+		goto err_iounmap;
+	}
+
+	num_irqs = num * rcom->num_queues;
+	/* alloc one vector per queue */
+	rcom->num_irqs = pci_alloc_irq_vectors(pdev, 1, num_irqs,
+					       PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rcom->num_irqs < num_irqs)
+		dev_err(dev, "Failed to get %i MSI-X interrupts: Returned %i\n",
+			num_irqs, rcom->num_irqs);
+
+	dev_dbg(dev, "Allocated %i IRQ Vectors\n", rcom->num_irqs);
+	pci_set_drvdata(pdev, rcom);
+	return 0;
+
+err_iounmap:
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (rcom->bar[bar]) {
+			pci_iounmap(pdev, rcom->bar[bar]);
+			rcom->bar[bar] = NULL;
+		}
+	}
+
+	pci_free_irq_vectors(pdev);
+	pci_release_regions(pdev);
+err_disable_pdev:
+	pci_disable_device(pdev);
+out_free_dev:
+	devm_kfree(dev, rcom);
+	return err;
+}
+
+static void pci_remote_disk_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_remote_disk_common *rcom = pci_get_drvdata(pdev);
+	struct pci_remote_disk_device *rdd, *tmp_rdd;
+	int i;
+
+	list_for_each_entry_safe(rdd, tmp_rdd, &available_remote_disks, node) {
+		if (rdd->attached)
+			pci_remote_disk_detach(rdd);
+
+		kfree(rdd->r_name);
+		kfree(rdd->l_name);
+		configfs_unregister_group(&rdd->cfs_group);
+		for (i = 0; i < rdd->num_queues; ++i) {
+			struct pci_remote_disk_queue *queue = &rdd->queue[i];
+			kfree(queue->descr_tags);
+		}
+		kfree(rdd->queue);
+		list_del(&rdd->node);
+		kfree(rdd);
+	}
+
+	configfs_unregister_subsystem(&pci_remote_disk_subsys);
+	rcom->num_irqs = 0;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (rcom->bar[i]) {
+			pci_iounmap(pdev, rcom->bar[i]);
+			rcom->bar[i] = NULL;
+		}
+	}
+
+	pci_free_irq_vectors(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	devm_kfree(dev, rcom);
+}
+
+MODULE_DEVICE_TABLE(pci, pci_remote_disk_tbl);
+
+static struct pci_driver pci_remote_disk_driver = {
+	.name = DRV_MODULE_NAME,
+	.id_table = pci_remote_disk_tbl,
+	.probe = pci_remote_disk_probe,
+	.remove = pci_remote_disk_remove,
+	.sriov_configure = pci_sriov_configure_simple,
+};
+
+module_pci_driver(pci_remote_disk_driver);
+
+MODULE_AUTHOR("Wadim Mueller <wafgo01@gmail.com>");
+MODULE_DESCRIPTION("Remote PCI Endpoint Disk driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


