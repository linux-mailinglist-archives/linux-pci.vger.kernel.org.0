Return-Path: <linux-pci+bounces-3976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817278627AB
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3032D2821F1
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD32481C6;
	Sat, 24 Feb 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgWXzxwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFB47784;
	Sat, 24 Feb 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808725; cv=none; b=eUBuE99OaJXSVrUvJ0PVaMRx/4LHW19c0i/yhRh7aVbtaRVKyLGSspu/c0DVGSai7GgMWFvy27XmJ8a3bYNUI6+dJop34kzX2dNZwEhwzoTDPDdiTWH0hfaRd8vucBeakdkSczWpf0wbfAsGdUdMo77B2R0ahnvVwfi2bmz792s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808725; c=relaxed/simple;
	bh=NVXVINSo3aICbMX7B9nFjQ9hcMZx4Bbq4q67cO7a0YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOK1qa4hk6/wd5H3AI3Dv2uj41Mc1Vv2PE6IRZOULCDAuFQB4qoz14KywKtuNmT3tbURRRxiCfoofo0hN6P7aWSN83sEt2wd+etHOSBc8etJh1NSWZaZR/FbxIoWOuurKLyPpOrMzRyj26j8EdeGGrYoDJrBfa01tDca8fsb7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgWXzxwM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso186223166b.2;
        Sat, 24 Feb 2024 13:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708808720; x=1709413520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXpWCqsxicQKSGdeo73aRW7DyDjmdP++aOV6fWNpKaE=;
        b=FgWXzxwMMbzNKV9BCutSAX+MSCUdz4ws/DNprjSXBRAQdZF4gNuerPlWBxBN5M75fd
         9yrqKoAxwfFRzVWfr3850hxELXV1XHNPsagpTpuJ0mUS+QHP95u7DRy0hITXYZhCW8gN
         y7GJSUJmR4jSjcF7J4FbyVM/8oeG/hmF/fOIEQ6DdV4saxytdhmRw7AhElNxcpYN8OaL
         ElAc8781CU54CxKJTgfOrO2TEJewemfPV4O+QnOQHKlmwYieE1VkZhRJEA+52cT/7mVc
         Y0SgNY3V+6q1NF10eCtmIRmG+54iqmPot+n18218JKR1we3x22spMtDN2E8z9Fi2Uf+2
         +k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808720; x=1709413520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXpWCqsxicQKSGdeo73aRW7DyDjmdP++aOV6fWNpKaE=;
        b=YMut4lOxX4ViRdoWt4t5yk1VuIAWFFN8l/0xiGXRtQHIYSwXaNJTsGjwonTZk8lpi/
         15S8VyTgCBXpZXmKqwxDuWqvpewW4lHcG1RSHN51aAmfCnANQBSYq/LHQLxEVMaNmCOW
         nNWH5nxNzerMatc/wBuACHM0OngHF2F3lWdJplIVYPy2K0agF4bLFqu6Rz8ZXmIpV/10
         M0xsQHaZb6Rv3JJbJigc19HmiT6TlXZeqA3Rh6zWJi02EmAlZNqyysN0JxNmhkyEtNwD
         Xtl0fHHPa5gqiveJPhzAxRSM2uHbtD2+PUivb7BURPewLUnT50f9TA1BIpBvPYZfntef
         JaRg==
X-Forwarded-Encrypted: i=1; AJvYcCW4EUT5g/bcSzqK3eLFgnGFJ0QmacDWMATaaP0jtMc/JU23R20LuOKT3RRgh0vnIuJxbBU/4vlvNrkV/sykEE1DaB02poJqudaMWtWfOJ1EbRFNhtwBGPqezw+mZFABjdTwwppk6Sc/yJud2i+Lfytqr2YwxrpNstZcKrp7wuGbChHuzImyenOvfw9O+hs9CN/Q2YqQwaAwRtaB1RytR80=
X-Gm-Message-State: AOJu0YypeF4UwYmA4ChvvdFVZec23ad+7PCldcyetavo0A2ofRiA/m32
	y7uvC2AVoGRZ7QVzUJ2L7wWO/55Q1MQZ41GCezJN8IUUTyUEoGhh
X-Google-Smtp-Source: AGHT+IFVUxd51PmssQPxjo4mA2+1BkEuhijyN4wJ1WIzf9OEF7X3iGEEkkkElDaFd+oa5PXODH3JKA==
X-Received: by 2002:a17:906:af08:b0:a3f:6302:1e61 with SMTP id lx8-20020a170906af0800b00a3f63021e61mr1973178ejb.73.1708808719670;
        Sat, 24 Feb 2024 13:05:19 -0800 (PST)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0:2bc0:19d3:9979:8e10])
        by smtp.googlemail.com with ESMTPSA id c22-20020a170906171600b00a3e4efbfdacsm891148eje.225.2024.02.24.13.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:05:19 -0800 (PST)
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
Subject: [PATCH 1/3] PCI: Add PCI Endpoint function driver for Block-device passthrough
Date: Sat, 24 Feb 2024 22:04:00 +0100
Message-Id: <20240224210409.112333-2-wafgo01@gmail.com>
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

PCI Block Device Passthrough Endpoint function driver. This driver
implements the Block Device function over PCI(e) in the endpoint
device.

This driver implements a simple Register interface which is
configured by the Host (RC) to export a certain block device attached
to the Device acting as an Endpoint.

Which devices are exposed and can be attached to from the Host side is
configurable through ConfigFS. Exporting in Read-Only mode is also
possible as well as exporting only certain partitions of a Block Device.

It further is responsible for carrying out all PCI(e) related activities
like mapping the host memory, transferring the requested block sectors
to the host and triggering MSIs on completion.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/pci/endpoint/functions/Kconfig        |   12 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
 include/linux/pci-epf-block-passthru.h        |   77 +
 4 files changed, 1483 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
 create mode 100644 include/linux/pci-epf-block-passthru.h

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 0c9cea0698d7..3e7d1666642a 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -47,3 +47,15 @@ config PCI_EPF_MHI
 	   devices such as SDX55.
 
 	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
+
+config PCI_EPF_BLOCK_PASSTHROUGH
+	tristate "PCI Endpoint Block Passthrough driver"
+	depends on PCI_ENDPOINT
+	select CONFIGFS_FS
+	help
+	  Select this configuration option to enable the Block Device Passthrough functionality.
+	  This driver can pass through any Block device available on the Host on which this driver is loaded.
+	  The decision which device is provided as a PCI Endpoint function has to be configured through CONFIG_FS.
+
+	  If in doubt, say "N" to disable Endpoint Block Passhthrough driver.
+
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 696473fce50e..a2564d817762 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
 obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
+obj-$(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)	+= pci-epf-block-passthru.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-block-passthru.c b/drivers/pci/endpoint/functions/pci-epf-block-passthru.c
new file mode 100644
index 000000000000..44c993530484
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-block-passthru.c
@@ -0,0 +1,1393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Block Device Passthrough as an Endpoint Function driver
+*
+* Author: Wadim Mueller <wafgo01@gmail.com>
+*
+* PCI Block Device Passthrough allows one Linux Device to expose its Block devices to the PCI(e) host.
+* The device can export either the full disk or just certain partitions.
+* The PCI Block Passthrough function driver is the part running on SoC2 from the diagram below.
+*
+*                                               +-------------+
+*                                               |             |
+*                                               |   SD Card   |
+*                                               |             |
+*                                               +------^------+
+*                                                      |
+*                                                      |
+*+---------------------+                +--------------v------------+       +---------+
+*|                     |                |                           |       |         |
+*|      SoC1 (RC)      |<-------------->|        SoC2 (EP)          |<----->|  eMMC   |
+*|  (pci-remote-disk)  |                | (pci-epf-block-passthru)  |       |         |
+*|                     |                |                           |       +---------+
+*+---------------------+                +--------------^------------+
+*                                                      |
+*                                                      |
+*                                               +------v------+
+*                                               |             |
+*                                               |    NVMe     |
+*                                               |             |
+*                                               +-------------+
+*
+*/
+
+#include "linux/dev_printk.h"
+#include "linux/jiffies.h"
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci_ids.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci_regs.h>
+#include <linux/bvec.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/blk-mq.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/hdreg.h>
+#include <linux/kthread.h>
+#include <linux/pci-epf-block-passthru.h>
+
+#define blockpt_readb(_x) readb(_x)
+#define blockpt_readw(_x) cpu_to_le16(readw(_x))
+#define blockpt_readl(_x) cpu_to_le32(readl(_x))
+#define blockpt_readq(_x) cpu_to_le64(readq(_x))
+
+#define blockpt_writeb(v, _x) writeb(v, _x)
+#define blockpt_writew(v, _x) writew(cpu_to_le16(v), _x)
+#define blockpt_writel(v, _x) writel(cpu_to_le32(v), _x)
+#define blockpt_writeq(v, _x) writeq(cpu_to_le64(v), _x)
+
+static struct workqueue_struct *kpciblockpt_wq;
+
+struct pci_blockpt_device_common;
+
+struct pci_epf_blockpt_queue {
+	struct pci_epf_blockpt_descr __iomem *descr;
+	dma_addr_t descr_addr;
+	u32 descr_size;
+	struct pci_blockpt_driver_ring __iomem *driver_ring;
+	struct pci_blockpt_device_ring __iomem *device_ring;
+	u32 drv_idx;
+	u32 dev_idx;
+	u32 num_desc;
+	struct task_struct *complete_thr;
+	struct task_struct *submit_thr;
+	struct list_head proc_list;
+	spinlock_t proc_lock;
+	int irq;
+	atomic_t raised_irqs;
+	struct dma_chan *dma_chan;
+	struct semaphore proc_sem;
+	struct pci_epf_blockpt_device *bpt_dev;
+};
+
+struct pci_epf_blockpt_device {
+	struct list_head node;
+	struct pci_blockpt_device_common *dcommon;
+	struct pci_epf_blockpt_queue __percpu *q;
+	struct config_group cfg_grp;
+	char *cfs_disk_name;
+        struct file *bdev_file;
+	struct block_device *bd;
+	int dev_tag;
+	int max_queue;
+	char *device_path;
+	char *dev_name;
+	bool read_only;
+	bool attached;
+	spinlock_t nm_lock;
+};
+
+struct pci_blockpt_device_common {
+	struct pci_epf_blockpt_reg __iomem *bpt_regs;
+	void __iomem *queue_base;
+	struct pci_epf *epf;
+	enum pci_barno blockpt_reg_bar;
+	size_t msix_table_offset;
+	struct delayed_work cmd_handler;
+	struct list_head devices;
+	const struct pci_epc_features *epc_features;
+	int next_disc_idx;
+	size_t queue_offset;
+	size_t queue_size;
+};
+
+static bool no_dma = false;
+static LIST_HEAD(exportable_bds);
+
+static struct pci_epf_header pci_blockpt_header = {
+	.vendorid = PCI_ANY_ID,
+	.deviceid = PCI_ANY_ID,
+	.baseclass_code = PCI_CLASS_OTHERS,
+};
+
+struct pci_epf_blockpt_info {
+	struct list_head node;
+	struct pci_epf_blockpt_queue *queue;
+	struct page *page;
+	size_t page_order;
+	size_t size;
+	struct bio *bio;
+	dma_addr_t dma_addr;
+	struct completion dma_transfer_complete;
+	struct pci_epf_blockpt_descr __iomem *descr;
+	int descr_idx;
+	void __iomem *addr;
+	phys_addr_t phys_addr;
+	enum dma_data_direction dma_dir;
+};
+
+#define blockpt_retry_delay() usleep_range(100, 500)
+#define blockpt_poll_delay() usleep_range(500, 1000)
+
+static int pci_blockpt_rq_completer(void *);
+static int pci_blockpt_rq_submitter(void *);
+
+static void
+pci_epf_blockpt_set_invalid_id_error(struct pci_blockpt_device_common *dcommon,
+				     struct pci_epf_blockpt_reg *reg)
+{
+	struct pci_epf *epf = dcommon->epf;
+	struct device *dev = &epf->dev;
+
+	dev_err(dev, "Could not find device with id: %i\n",
+		blockpt_readb(&reg->dev_idx));
+	blockpt_writel(BPT_STATUS_ERROR, &reg->status);
+}
+
+static struct pci_epf_blockpt_device *
+pci_epf_blockpt_get_device_by_id(struct pci_blockpt_device_common *dcom, u8 id)
+{
+	struct list_head *lh;
+	struct pci_epf_blockpt_device *bpt_dev;
+
+	list_for_each(lh, &exportable_bds) {
+		bpt_dev = list_entry(lh, struct pci_epf_blockpt_device, node);
+		if (bpt_dev->dev_tag == id)
+			return bpt_dev;
+	}
+
+	list_for_each(lh, &dcom->devices) {
+		bpt_dev = list_entry(lh, struct pci_epf_blockpt_device, node);
+		if (bpt_dev->dev_tag == id)
+			return bpt_dev;
+	}
+
+	return NULL;
+}
+
+static void
+move_bpt_device_to_active_list(struct pci_epf_blockpt_device *bpt_dev)
+{
+	spin_lock(&bpt_dev->nm_lock);
+	list_del(&bpt_dev->node);
+	INIT_LIST_HEAD(&bpt_dev->node);
+	list_add_tail(&bpt_dev->node, &bpt_dev->dcommon->devices);
+	spin_unlock(&bpt_dev->nm_lock);
+}
+
+static void
+move_bpt_device_to_exportable_list(struct pci_epf_blockpt_device *bpt_dev)
+{
+	spin_lock(&bpt_dev->nm_lock);
+	list_del(&bpt_dev->node);
+	INIT_LIST_HEAD(&bpt_dev->node);
+	list_add_tail(&bpt_dev->node, &exportable_bds);
+	spin_unlock(&bpt_dev->nm_lock);
+}
+
+static void free_pci_blockpt_info(struct pci_epf_blockpt_info *info)
+{
+	struct pci_blockpt_device_common *dcommon =
+		info->queue->bpt_dev->dcommon;
+	struct device *dev = &dcommon->epf->dev;
+	struct device *dma_dev = dcommon->epf->epc->dev.parent;
+	spinlock_t *lock = &info->queue->proc_lock;
+
+	dma_unmap_single(dma_dev, info->dma_addr, info->size, info->dma_dir);
+	if (info->bio->bi_opf == REQ_OP_READ) {
+		pci_epc_unmap_addr(dcommon->epf->epc, dcommon->epf->func_no,
+				   dcommon->epf->vfunc_no, info->phys_addr);
+		pci_epc_mem_free_addr(dcommon->epf->epc, info->phys_addr,
+				      info->addr, info->size);
+	}
+
+	__free_pages(info->page, info->page_order);
+
+	spin_lock_irq(lock);
+	list_del(&info->node);
+	spin_unlock_irq(lock);
+
+	bio_put(info->bio);
+	devm_kfree(dev, info);
+}
+
+static struct pci_epf_blockpt_info *
+alloc_pci_epf_blockpt_info(struct pci_epf_blockpt_queue *queue, size_t size,
+			   struct pci_epf_blockpt_descr __iomem *descr,
+			   int descr_idx, blk_opf_t opf)
+{
+	struct pci_epf_blockpt_info *binfo;
+	struct pci_blockpt_device_common *dcommon = queue->bpt_dev->dcommon;
+	struct bio *bio;
+	struct device *dev = &dcommon->epf->dev;
+	struct page *page;
+	struct device *dma_dev = dcommon->epf->epc->dev.parent;
+	dma_addr_t dma_addr;
+	struct block_device *bdev = queue->bpt_dev->bd;
+	enum dma_data_direction dma_dir =
+		(opf == REQ_OP_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	gfp_t alloc_flags = GFP_KERNEL;
+
+	binfo = devm_kzalloc(dev, sizeof(*binfo), alloc_flags);
+	if (unlikely(!binfo)) {
+		dev_err(dev, "Could not allocate bio info\n");
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&binfo->node);
+	bio = bio_alloc(bdev, 1, opf, alloc_flags);
+	if (unlikely(!bio)) {
+		dev_err(dev, "Could not allocate bio\n");
+		goto free_binfo;
+	}
+
+	binfo->size = size;
+	binfo->page_order = get_order(size);
+	page = alloc_pages(alloc_flags | GFP_DMA, binfo->page_order);
+	if (unlikely(!page)) {
+		dev_err(dev, "Could not allocate %i page(s) for bio\n",
+			1 << binfo->page_order);
+		goto put_bio;
+	}
+
+	binfo->addr = pci_epc_mem_alloc_addr(dcommon->epf->epc,
+					     &binfo->phys_addr, size);
+	if (!binfo->addr) {
+		dev_err(dev,
+			"Failed to allocate PCI address slot for transfer\n");
+		goto release_page;
+	}
+
+	dma_addr = dma_map_single(dma_dev, page_address(page), size, dma_dir);
+	if (dma_mapping_error(dma_dev, dma_addr)) {
+		dev_err(dev, "Failed to map buffer addr\n");
+		goto free_epc_mem;
+	}
+
+	init_completion(&binfo->dma_transfer_complete);
+	binfo->bio = bio;
+	binfo->dma_addr = dma_addr;
+	binfo->queue = queue;
+	binfo->page = page;
+	binfo->descr = descr;
+	binfo->descr_idx = descr_idx;
+	binfo->dma_dir = dma_dir;
+	return binfo;
+free_epc_mem:
+	pci_epc_mem_free_addr(dcommon->epf->epc, binfo->phys_addr, binfo->addr,
+			      size);
+release_page:
+	__free_pages(page, binfo->page_order);
+put_bio:
+	bio_put(bio);
+free_binfo:
+	devm_kfree(dev, binfo);
+	return NULL;
+}
+
+static void pci_epf_blockpt_transfer_complete(struct bio *bio)
+{
+	struct pci_epf_blockpt_info *binfo = bio->bi_private;
+	struct device *dev = &binfo->queue->bpt_dev->dcommon->epf->dev;
+	struct list_head *qlist = &binfo->queue->proc_list;
+	spinlock_t *lock = &binfo->queue->proc_lock;
+	struct semaphore *sem = &binfo->queue->proc_sem;
+
+	if (bio->bi_status != BLK_STS_OK)
+		dev_err_ratelimited(dev, "bio submit error %i\n",
+				    bio->bi_status);
+
+	spin_lock(lock);
+	list_add_tail(&binfo->node, qlist);
+	spin_unlock(lock);
+	up(sem);
+}
+
+static void destroy_all_worker_threads(struct pci_epf_blockpt_device *bpt_dev)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu) {
+		struct pci_epf_blockpt_queue *queue =
+			per_cpu_ptr(bpt_dev->q, cpu);
+		if (queue->submit_thr) {
+			up(&queue->proc_sem);
+			queue->submit_thr = NULL;
+		}
+
+		if (queue->complete_thr) {
+			kthread_stop(queue->complete_thr);
+			queue->complete_thr = NULL;
+		}
+	}
+}
+
+static int alloc_dma_channels(struct pci_epf_blockpt_device *bpt_dev)
+{
+	dma_cap_mask_t mask;
+	int cpu, ret = 0;
+	struct device *dev = &bpt_dev->dcommon->epf->dev;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	for_each_present_cpu(cpu) {
+		struct pci_epf_blockpt_queue *queue =
+			per_cpu_ptr(bpt_dev->q, cpu);
+		queue->dma_chan = dma_request_chan_by_mask(&mask);
+		if (IS_ERR(queue->dma_chan)) {
+			ret = PTR_ERR(queue->dma_chan);
+			dev_warn(
+				dev,
+				"Failed to get DMA channel %s for Queue %i: %i\n",
+				bpt_dev->dev_name, cpu, ret);
+			queue->dma_chan = NULL;
+		}
+		dev_info(dev, "Allocated DMA Channel for %s.%d\n",
+			 bpt_dev->dev_name, cpu);
+	}
+	return ret;
+}
+
+static int start_bpt_worker_threads(struct pci_epf_blockpt_device *bpt_dev)
+{
+	int cpu, ret = 0;
+
+	char tname[64];
+	struct device *dev = &bpt_dev->dcommon->epf->dev;
+
+	for_each_present_cpu(cpu) {
+		struct pci_epf_blockpt_queue *queue =
+			per_cpu_ptr(bpt_dev->q, cpu);
+		if (cpu >= bpt_dev->max_queue)
+			break;
+
+		snprintf(tname, sizeof(tname), "%s-q%d:complete-rq",
+			 bpt_dev->dev_name, cpu);
+		dev_dbg(dev, "creating thread %s\n", tname);
+		queue->complete_thr = kthread_create_on_cpu(
+			pci_blockpt_rq_completer, queue, cpu, tname);
+		if (IS_ERR(queue->complete_thr)) {
+			ret = PTR_ERR(queue->complete_thr);
+			dev_err(dev,
+				"%s Could not create digest kernel thread: %i\n",
+				bpt_dev->device_path, ret);
+			goto check_start_errors;
+		}
+		/* we can wake up the kthread here, because it will wait for its percpu samaphore  */
+		wake_up_process(queue->complete_thr);
+	}
+
+	for_each_present_cpu(cpu) {
+		struct pci_epf_blockpt_queue *queue =
+			per_cpu_ptr(bpt_dev->q, cpu);
+		if (cpu >= bpt_dev->max_queue)
+			break;
+		snprintf(tname, sizeof(tname), "%s-q%d:submit-rq",
+			 bpt_dev->dev_name, cpu);
+		dev_dbg(dev, "creating thread %s\n", tname);
+		queue->submit_thr = kthread_create_on_cpu(
+			pci_blockpt_rq_submitter, queue, cpu, tname);
+		if (IS_ERR(queue->submit_thr)) {
+			ret = PTR_ERR(queue->submit_thr);
+			dev_err(dev,
+				"%s Could not create bio submit kernel thread: %i\n",
+				bpt_dev->device_path, ret);
+			goto check_start_errors;
+		}
+		wake_up_process(queue->submit_thr);
+	}
+
+check_start_errors:
+	if (ret)
+		destroy_all_worker_threads(bpt_dev);
+	else
+		dev_info(dev, "%s started\n", bpt_dev->device_path);
+
+	return ret;
+}
+
+static void set_device_descriptor_queue(struct pci_epf_blockpt_queue *queue)
+{
+	struct device *dev = &queue->bpt_dev->dcommon->epf->dev;
+	struct pci_epf_blockpt_reg __iomem *bpt_regs =
+		queue->bpt_dev->dcommon->bpt_regs;
+
+	queue->num_desc = blockpt_readl(&bpt_regs->num_desc);
+	WARN_ON(queue->num_desc <= 16);
+
+	queue->descr_addr = (dma_addr_t)queue->bpt_dev->dcommon->queue_base +
+			    (dma_addr_t)blockpt_readl(&bpt_regs->queue_offset);
+	queue->descr_size = blockpt_readl(&bpt_regs->qsize);
+	queue->descr =
+		(struct pci_epf_blockpt_descr __iomem *)queue->descr_addr;
+	queue->driver_ring = (struct pci_blockpt_driver_ring
+				      *)((u64)queue->descr_addr +
+					 blockpt_readl(&bpt_regs->drv_offset));
+	queue->device_ring = (struct pci_blockpt_device_ring
+				      *)((u64)queue->descr_addr +
+					 blockpt_readl(&bpt_regs->dev_offset));
+	/* if the queue was (re)set, we need to reset the device and driver indices */
+	queue->dev_idx = queue->drv_idx = 0;
+
+	dev_dbg(dev,
+		"%s: mapping Queue to bus address: 0x%llX. Size = 0x%x. Driver Ring Addr: 0x%llX, Device Ring Addr: 0x%llX\n",
+		queue->bpt_dev->device_path, queue->descr_addr,
+		queue->descr_size, (u64)queue->driver_ring,
+		(u64)queue->device_ring);
+}
+
+static void pci_epf_blockpt_cmd_handler(struct work_struct *work)
+{
+	struct pci_blockpt_device_common *dcommon = container_of(
+		work, struct pci_blockpt_device_common, cmd_handler.work);
+	u32 command;
+	int ret;
+	struct pci_epf *epf = dcommon->epf;
+	struct pci_epf_blockpt_reg *reg = dcommon->bpt_regs;
+	struct pci_epf_blockpt_device *bpt_dev;
+	struct device *dev = &epf->dev;
+	struct list_head *lh;
+	struct pci_epf_blockpt_queue *queue;
+
+	command = blockpt_readl(&reg->command);
+
+	if (!command)
+		goto reset_handler;
+
+	blockpt_writel(0, &reg->command);
+	blockpt_writel(0, &reg->status);
+
+	if (command != 0 && list_empty(&exportable_bds) &&
+	    list_empty(&dcommon->devices)) {
+		WARN_ONCE(1,
+			  "Available Devices must be configured first through \
+                           ConfigFS, before remote partner can send any command\n");
+		goto reset_handler;
+	}
+
+	bpt_dev = pci_epf_blockpt_get_device_by_id(
+		dcommon, blockpt_readb(&reg->dev_idx));
+	if (!bpt_dev) {
+		pci_epf_blockpt_set_invalid_id_error(dcommon, reg);
+		goto reset_handler;
+	}
+
+	if (command & BPT_COMMAND_GET_DEVICES) {
+		int nidx = 0;
+		dev_dbg(dev, "Request for available devices received\n");
+		list_for_each(lh, &exportable_bds) {
+			struct pci_epf_blockpt_device *bpt_dev = list_entry(
+				lh, struct pci_epf_blockpt_device, node);
+			nidx += snprintf(&reg->dev_name[nidx], 64, "%s%s",
+					 (nidx == 0) ? "" : ";",
+					 bpt_dev->device_path);
+		}
+
+		sprintf(&reg->dev_name[nidx], "%s", ";");
+	}
+
+	if (command & BPT_COMMAND_SET_IRQ) {
+		dev_dbg(dev, "%s setting IRQ%d for Queue %i\n",
+			bpt_dev->device_path, blockpt_readl(&reg->irq),
+			blockpt_readb(&reg->qidx));
+		WARN_ON(blockpt_readb(&reg->qidx) >= num_present_cpus());
+		queue = per_cpu_ptr(bpt_dev->q, blockpt_readb(&reg->qidx));
+		queue->irq = blockpt_readl(&reg->irq);
+	}
+
+	if (command & BPT_COMMAND_GET_NUM_SECTORS) {
+		dev_dbg(dev, "%s: Request for number of sectors received\n",
+			bpt_dev->device_path);
+		blockpt_writeq(bdev_nr_sectors(bpt_dev->bd), &reg->num_sectors);
+	}
+
+	if (command & BPT_COMMAND_SET_QUEUE) {
+		dev_dbg(dev, "%s setting Queue %i\n", bpt_dev->device_path,
+			blockpt_readb(&reg->qidx));
+		if (WARN_ON_ONCE(blockpt_readb(&reg->qidx) >=
+				 num_present_cpus())) {
+			blockpt_writel(BPT_STATUS_ERROR, &reg->status);
+			goto reset_handler;
+		}
+
+		queue = per_cpu_ptr(bpt_dev->q, blockpt_readb(&reg->qidx));
+		set_device_descriptor_queue(queue);
+	}
+
+	if (command & BPT_COMMAND_GET_PERMISSION) {
+		blockpt_writeb(bpt_dev->read_only ? BPT_PERMISSION_RO : 0,
+			       &reg->perm);
+	}
+
+	if (command & BPT_COMMAND_START) {
+		if (!no_dma) {
+			ret = alloc_dma_channels(bpt_dev);
+			if (ret)
+				dev_warn(
+					dev,
+					"could not allocate dma channels. Using PIO\n");
+		}
+		ret = start_bpt_worker_threads(bpt_dev);
+		if (ret) {
+			blockpt_writel(BPT_STATUS_ERROR, &reg->status);
+			goto reset_handler;
+		}
+		/* move the device from the exportable_devices to the active ones */
+		move_bpt_device_to_active_list(bpt_dev);
+		bpt_dev->attached = true;
+	}
+
+	if (command & BPT_COMMAND_STOP) {
+		if (bpt_dev->attached) {
+			destroy_all_worker_threads(bpt_dev);
+			move_bpt_device_to_exportable_list(bpt_dev);
+			dev_info(dev, "%s stopped\n", bpt_dev->dev_name);
+			bpt_dev->attached = false;
+		} else {
+			dev_err(dev,
+				"%s try to stop a device which was not started.\n",
+				bpt_dev->dev_name);
+			blockpt_writel(BPT_STATUS_ERROR, &reg->status);
+			goto reset_handler;
+		}
+	}
+	blockpt_writel(BPT_STATUS_SUCCESS, &reg->status);
+
+reset_handler:
+	queue_delayed_work(kpciblockpt_wq, &dcommon->cmd_handler,
+			   msecs_to_jiffies(5));
+}
+
+static void pci_epf_blockpt_unbind(struct pci_epf *epf)
+{
+	struct pci_blockpt_device_common *bpt = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+
+	cancel_delayed_work(&bpt->cmd_handler);
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+			  &epf->bar[bpt->blockpt_reg_bar]);
+	pci_epf_free_space(epf, bpt->bpt_regs, bpt->blockpt_reg_bar,
+			   PRIMARY_INTERFACE);
+}
+
+static int pci_epf_blockpt_set_bars(struct pci_epf *epf)
+{
+	int ret;
+	struct pci_epf_bar *epf_reg_bar;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+
+	epc_features = dcommon->epc_features;
+
+	epf_reg_bar = &epf->bar[dcommon->blockpt_reg_bar];
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, epf_reg_bar);
+	if (ret) {
+		pci_epf_free_space(epf, dcommon->bpt_regs,
+				   dcommon->blockpt_reg_bar, PRIMARY_INTERFACE);
+		dev_err(dev, "Failed to set Register BAR%d\n",
+			dcommon->blockpt_reg_bar);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_blockpt_core_init(struct pci_epf *epf)
+{
+	struct pci_blockpt_device_common *bpt = epf_get_drvdata(epf);
+	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	bool msix_capable = false;
+	bool msi_capable = true;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (epc_features) {
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+	}
+
+	if (epf->vfunc_no <= 1) {
+		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no,
+					   header);
+		if (ret) {
+			dev_err(dev, "Configuration header write failed\n");
+			return ret;
+		}
+	}
+
+	ret = pci_epf_blockpt_set_bars(epf);
+	if (ret)
+		return ret;
+
+	/* MSIs and MSI-Xs are mutually exclusive; MSI-Xs will not work if the
+	 * configuration is done for both, simultaneously.
+	 */
+	if (msi_capable && !msix_capable) {
+		dev_info(dev, "Configuring MSIs\n");
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
+	}
+
+	if (msix_capable) {
+		dev_info(dev, "Configuring MSI-Xs\n");
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts,
+				       bpt->blockpt_reg_bar,
+				       bpt->msix_table_offset);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_blockpt_alloc_space(struct pci_epf *epf)
+{
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	struct device *dev = &epf->dev;
+	size_t msix_table_size = 0;
+	size_t bpt_bar_size;
+	size_t pba_size = 0;
+	bool msix_capable;
+	void *base;
+	enum pci_barno reg_bar = dcommon->blockpt_reg_bar;
+	const struct pci_epc_features *epc_features;
+	size_t bar_reg_size, desc_space;
+
+	epc_features = dcommon->epc_features;
+	bar_reg_size = ALIGN(sizeof(struct pci_epf_blockpt_reg), 128);
+	msix_capable = epc_features->msix_capable;
+	if (msix_capable) {
+		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
+		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+	}
+
+	/* some PCI(e) EP controllers have a very limited number of translation windows
+	   to avoid wasting a full translation window for the mapping of the descriptors,
+	   the descriptors will be part of the register bar. For this I choose that 128kiB
+	   must be available. Which is for now the bare minimum required to be supported
+	   by the EPC. Though this is an arbitrary size and can be reduced.
+	*/
+	bpt_bar_size = SZ_128K;
+	if (epc_features->bar[reg_bar].type == BAR_FIXED && epc_features->bar[reg_bar].fixed_size) {
+		if (bpt_bar_size > epc_features->bar[reg_bar].fixed_size)
+			return -ENOMEM;
+
+		bpt_bar_size = epc_features->bar[reg_bar].fixed_size;
+	}
+	desc_space = bpt_bar_size - bar_reg_size - msix_table_size - pba_size;
+	dcommon->msix_table_offset = bar_reg_size + desc_space;
+
+	base = pci_epf_alloc_space(epf, bpt_bar_size, reg_bar,
+				   epc_features, PRIMARY_INTERFACE);
+	if (!base) {
+		dev_err(dev, "Failed to allocated register space\n");
+		return -ENOMEM;
+	}
+
+	dcommon->queue_offset = bar_reg_size;
+	dcommon->queue_size = desc_space;
+	dcommon->bpt_regs = base;
+	dcommon->queue_base = (void *)((u64)base + bar_reg_size);
+	return 0;
+}
+
+static int pci_epf_blockpt_link_init_notifier(struct pci_epf *epf)
+{
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	queue_delayed_work(kpciblockpt_wq, &dcommon->cmd_handler,
+			   msecs_to_jiffies(1));
+	return 0;
+}
+
+static void
+pci_epf_blockpt_configure_bar(struct pci_epf *epf,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_barno bar_no)
+{
+	struct pci_epf_bar *epf_bar = &epf->bar[bar_no];
+	
+	if (!!(epc_features->bar[bar_no].only_64bit & (1 << bar_no)))
+		epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+}
+
+static const struct pci_epc_event_ops pci_epf_blockpt_event_ops = {
+	.core_init = pci_epf_blockpt_core_init,
+	.link_up = pci_epf_blockpt_link_init_notifier,
+};
+
+static int pci_epf_blockpt_bind(struct pci_epf *epf)
+{
+	int ret;
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+	enum pci_barno reg_bar = BAR_0;
+	struct pci_epc *epc = epf->epc;
+	bool linkup_notifier = false;
+	bool core_init_notifier = false;
+	struct pci_epf_blockpt_reg *breg;
+	struct device *dev = &epf->dev;
+
+	if (WARN_ON_ONCE(!epc))
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	linkup_notifier = epc_features->linkup_notifier;
+	core_init_notifier = epc_features->core_init_notifier;
+	reg_bar = pci_epc_get_first_free_bar(epc_features);
+	if (reg_bar < 0)
+		return -EINVAL;
+
+	dev_info(dev, "allocated BAR%d\n", reg_bar);
+	pci_epf_blockpt_configure_bar(epf, epc_features, reg_bar);
+	dcommon->blockpt_reg_bar = reg_bar;
+
+	dcommon->epc_features = epc_features;
+	ret = pci_epf_blockpt_alloc_space(epf);
+	if (ret)
+		return ret;
+
+	breg = (struct pci_epf_blockpt_reg *)dcommon->bpt_regs;
+	blockpt_writel(BLOCKPT_MAGIC, &breg->magic);
+	blockpt_writel(dcommon->queue_offset, &breg->queue_bar_offset);
+	blockpt_writel(dcommon->queue_size, &breg->available_qsize);
+	blockpt_writel(num_present_cpus(), &breg->num_queues);
+	blockpt_writel(MAX_BLOCK_DEVS, &breg->max_devs);
+	if (!core_init_notifier) {
+		ret = pci_epf_blockpt_core_init(epf);
+		if (ret)
+			return ret;
+	}
+
+	if (!linkup_notifier && !core_init_notifier)
+		queue_work(kpciblockpt_wq, &dcommon->cmd_handler.work);
+
+	return 0;
+}
+
+static const struct pci_epf_device_id pci_epf_blockpt_ids[] = {
+	{
+		.name = "pci_epf_blockpt",
+	},
+	{},
+};
+
+static void pci_epf_blockpt_dma_callback(void *param)
+{
+	struct pci_epf_blockpt_info *bio_info = param;
+	complete(&bio_info->dma_transfer_complete);
+}
+
+static int pci_blockpt_rq_submitter(void *__bpt_queue)
+{
+	struct pci_epf_blockpt_queue *queue = __bpt_queue;
+	struct device *dev = &queue->bpt_dev->dcommon->epf->dev;
+	struct pci_epf *epf = queue->bpt_dev->dcommon->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_blockpt_info *bio_info;
+	struct pci_epf_blockpt_descr loc_descr;
+	struct pci_epf_blockpt_descr __iomem *descr;
+	struct dma_async_tx_descriptor *dma_txd;
+	dma_cookie_t dma_cookie;
+	u16 de;
+	int ret = 0;
+	int err;
+
+	while (!kthread_should_stop()) {
+		while (queue->drv_idx !=
+		       blockpt_readw(&queue->driver_ring->idx)) {
+			de = blockpt_readw(
+				&queue->driver_ring->ring[queue->drv_idx]);
+			descr = &queue->descr[de];
+
+			memcpy_fromio(&loc_descr, descr, sizeof(loc_descr));
+
+			BUG_ON(!(loc_descr.si.flags & PBI_EPF_BLOCKPT_F_USED));
+
+			bio_info = alloc_pci_epf_blockpt_info(
+				queue, loc_descr.len, descr, de,
+				(loc_descr.si.opf == WRITE) ? REQ_OP_WRITE :
+							      REQ_OP_READ);
+			if (unlikely(!bio_info)) {
+				dev_err(dev, "Unable to allocate bio_info\n");
+				blockpt_retry_delay();
+				continue;
+			}
+
+			bio_set_dev(bio_info->bio, queue->bpt_dev->bd);
+			bio_info->bio->bi_iter.bi_sector = loc_descr.s_sector;
+			bio_info->bio->bi_opf = loc_descr.si.opf == WRITE ?
+							REQ_OP_WRITE :
+							REQ_OP_READ;
+			if (loc_descr.si.opf == WRITE) {
+				ret = pci_epc_map_addr(epc, epf->func_no,
+						       epf->vfunc_no,
+						       bio_info->phys_addr,
+						       loc_descr.addr,
+						       loc_descr.len);
+				if (ret) {
+					/* This is not an error. Some PCI
+					 * Controllers have very few translation
+					 * windows, and as we run this on all available
+					 * cores  it is not unusual that the translation
+					 * windows are all used for a short period of time.
+					 * Instead of giving up and panic here,
+					 * just wait and retry. It will usually
+					 * be available on the next few retries
+					 */
+					dev_info_ratelimited(
+						dev,
+						"Mapping descriptor failed with %i. Retry\n",
+						ret);
+					goto err_retry;
+				}
+
+				if (queue->dma_chan) {
+					dma_txd = dmaengine_prep_dma_memcpy(
+						queue->dma_chan,
+						bio_info->dma_addr,
+						bio_info->phys_addr,
+						loc_descr.len,
+						DMA_CTRL_ACK |
+							DMA_PREP_INTERRUPT);
+					if (!dma_txd) {
+						ret = -ENODEV;
+						dev_err(dev,
+							"Failed to prepare DMA memcpy\n");
+						goto err_retry;
+					}
+
+					dma_txd->callback =
+						pci_epf_blockpt_dma_callback;
+					dma_txd->callback_param = bio_info;
+					dma_cookie =
+						dma_txd->tx_submit(dma_txd);
+					ret = dma_submit_error(dma_cookie);
+					if (ret) {
+						dev_err_ratelimited(
+							dev,
+							"Failed to do DMA tx_submit %d\n",
+							dma_cookie);
+						goto err_retry;
+					}
+
+					dma_async_issue_pending(
+						queue->dma_chan);
+					ret = wait_for_completion_interruptible_timeout(
+						&bio_info->dma_transfer_complete,
+						msecs_to_jiffies(100));
+					if (ret <= 0) {
+						ret = -ETIMEDOUT;
+						dev_err_ratelimited(
+							dev,
+							"DMA wait_for_completion timeout\n");
+						dmaengine_terminate_sync(
+							queue->dma_chan);
+						goto err_retry;
+					}
+				} else {
+					memcpy_fromio(
+						page_address(bio_info->page),
+						bio_info->addr, loc_descr.len);
+				}
+			}
+
+			bio_info->bio->bi_end_io =
+				pci_epf_blockpt_transfer_complete;
+			bio_info->bio->bi_private = bio_info;
+			err = bio_add_page(bio_info->bio, bio_info->page,
+					   loc_descr.len, 0);
+			if (err != loc_descr.len) {
+				ret = -ENOMEM;
+				dev_err_ratelimited(
+					dev, "failed to add page to bio\n");
+				goto err_retry;
+			}
+
+			queue->drv_idx = (queue->drv_idx + 1) % queue->num_desc;
+			submit_bio(bio_info->bio);
+			continue;
+
+err_retry:
+			if (loc_descr.si.opf == WRITE) {
+				pci_epc_unmap_addr(epf->epc, epf->func_no,
+						   epf->vfunc_no,
+						   bio_info->phys_addr);
+				pci_epc_mem_free_addr(epf->epc,
+						      bio_info->phys_addr,
+						      bio_info->addr,
+						      bio_info->size);
+			}
+			free_pci_blockpt_info(bio_info);
+			blockpt_retry_delay();
+		}
+		blockpt_poll_delay();
+	}
+
+	return 0;
+}
+
+static int pci_blockpt_rq_completer(void *__queue)
+{
+	struct pci_epf_blockpt_queue *queue = __queue;
+	struct device *dev = &queue->bpt_dev->dcommon->epf->dev;
+	struct pci_epf *epf = queue->bpt_dev->dcommon->epf;
+	struct pci_epf_blockpt_info *bi;
+	struct pci_epf_blockpt_descr __iomem *descr;
+	int ret;
+	struct dma_async_tx_descriptor *dma_rxd;
+	dma_cookie_t dma_cookie;
+	char *buf;
+
+	while (!kthread_should_stop()) {
+		/* wait for a new bio to finish */
+		down(&queue->proc_sem);
+		bi = list_first_entry_or_null(
+			&queue->proc_list, struct pci_epf_blockpt_info, node);
+		if (bi == NULL) {
+			dev_info(dev, "%s: stopping digest task for queue %d\n",
+				 queue->bpt_dev->dev_name, smp_processor_id());
+			return 0;
+		}
+
+		descr = bi->descr;
+		BUG_ON(!(descr->si.flags & PBI_EPF_BLOCKPT_F_USED));
+
+		if (descr->si.opf == READ) {
+			ret = pci_epc_map_addr(epf->epc, epf->func_no,
+					       epf->vfunc_no, bi->phys_addr,
+					       descr->addr, descr->len);
+			if (ret) {
+				/* don't panic. simply retry.
+				 * A window will be available sooner or later */
+				dev_info(
+					dev,
+					"Could not map read descriptor. Retry\n");
+				blockpt_retry_delay();
+				up(&queue->proc_sem);
+				continue;
+			}
+
+			if (queue->dma_chan) {
+				dma_rxd = dmaengine_prep_dma_memcpy(
+					queue->dma_chan, bi->phys_addr,
+					bi->dma_addr, descr->len,
+					DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+				if (!dma_rxd) {
+					dev_err(dev,
+						"Failed to prepare DMA memcpy\n");
+					goto err_retry;
+				}
+
+				dma_rxd->callback =
+					pci_epf_blockpt_dma_callback;
+				dma_rxd->callback_param = bi;
+				dma_cookie = dma_rxd->tx_submit(dma_rxd);
+				ret = dma_submit_error(dma_cookie);
+				if (ret) {
+					dev_err(dev,
+						"Failed to do DMA rx_submit %d\n",
+						dma_cookie);
+					goto err_retry;
+				}
+
+				dma_async_issue_pending(queue->dma_chan);
+				ret = wait_for_completion_interruptible_timeout(
+					&bi->dma_transfer_complete,
+					msecs_to_jiffies(100));
+				if (ret <= 0) {
+					dev_err_ratelimited(
+						dev,
+						"DMA completion timed out\n");
+					dmaengine_terminate_sync(
+						queue->dma_chan);
+					goto err_retry;
+				}
+			} else {
+				buf = kmap_local_page(bi->page);
+				memcpy_toio(bi->addr, buf, bi->descr->len);
+				kunmap_local(buf);
+			}
+		}
+
+		blockpt_writew(bi->descr_idx,
+			       &queue->device_ring->ring[queue->dev_idx]);
+		queue->dev_idx = (queue->dev_idx + 1) % queue->num_desc;
+		blockpt_writew(queue->dev_idx, &queue->device_ring->idx);
+		do {
+			ret = pci_epc_raise_irq(epf->epc, epf->func_no,
+						epf->vfunc_no, PCI_IRQ_MSIX,
+						queue->irq);
+			if (ret < 0) {
+				dev_err_ratelimited(
+					dev, "could not send msix irq%d\n",
+					queue->irq);
+				blockpt_retry_delay();
+			}
+		} while (ret != 0);
+
+		atomic_inc(&queue->raised_irqs);
+		free_pci_blockpt_info(bi);
+		continue;
+err_retry:
+		pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no,
+				   bi->phys_addr);
+		blockpt_retry_delay();
+		up(&queue->proc_sem);
+	}
+
+	return 0;
+}
+
+static int pci_epf_blockpt_probe(struct pci_epf *epf,
+				 const struct pci_epf_device_id *id)
+{
+	struct pci_blockpt_device_common *dcommon;
+	struct device *dev = &epf->dev;
+
+	dcommon = devm_kzalloc(dev, sizeof(*dcommon), GFP_KERNEL);
+	if (!dcommon)
+		return -ENOMEM;
+
+	epf->header = &pci_blockpt_header;
+	dcommon->epf = epf;
+	INIT_LIST_HEAD(&dcommon->devices);
+	INIT_LIST_HEAD(&exportable_bds);
+	INIT_DELAYED_WORK(&dcommon->cmd_handler, pci_epf_blockpt_cmd_handler);
+	epf->event_ops = &pci_epf_blockpt_event_ops;
+	epf_set_drvdata(epf, dcommon);
+	return 0;
+}
+
+static void blockpt_free_per_cpu_data(struct pci_epf_blockpt_device *bpt_dev)
+{
+	if (bpt_dev->q) {
+		free_percpu(bpt_dev->q);
+		bpt_dev->q = NULL;
+	}
+}
+
+static void pci_epf_blockpt_remove(struct pci_epf *epf)
+{
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	struct pci_epf_blockpt_device *bpt_dev, *dntmp;
+	unsigned long flags;
+	struct pci_epf_blockpt_info *bio_info, *bntmp;
+	int cpu;
+	struct device *dev = &dcommon->epf->dev;
+
+	list_for_each_entry_safe(bpt_dev, dntmp, &dcommon->devices, node) {
+		destroy_all_worker_threads(bpt_dev);
+		fput(bpt_dev->bdev_file);
+		spin_lock_irqsave(&bpt_dev->nm_lock, flags);
+		list_del(&bpt_dev->node);
+		spin_unlock_irqrestore(&bpt_dev->nm_lock, flags);
+
+		for_each_present_cpu(cpu) {
+			list_for_each_entry_safe(
+				bio_info, bntmp,
+				&(per_cpu_ptr(bpt_dev->q, cpu)->proc_list),
+				node) {
+				free_pci_blockpt_info(bio_info);
+			}
+		}
+
+		blockpt_free_per_cpu_data(bpt_dev);
+		kfree(bpt_dev->cfs_disk_name);
+		kfree(bpt_dev->device_path);
+		devm_kfree(dev, bpt_dev);
+	}
+}
+
+static inline struct pci_epf_blockpt_device *
+to_blockpt_dev(struct config_item *item)
+{
+	return container_of(to_config_group(item),
+			    struct pci_epf_blockpt_device, cfg_grp);
+}
+
+static ssize_t pci_blockpt_disc_name_show(struct config_item *item, char *page)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	return sprintf(page, "%s\n",
+		       (bpt_dev->device_path != NULL) ? bpt_dev->device_path :
+							"");
+}
+
+static ssize_t pci_blockpt_disc_name_store(struct config_item *item,
+					   const char *page, size_t len)
+{
+	int ret;
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	struct device *dev = &bpt_dev->dcommon->epf->dev;
+	unsigned long flags;
+	
+	bpt_dev->bdev_file = bdev_file_open_by_path(
+		page,
+		bpt_dev->read_only ? BLK_OPEN_READ : (BLK_OPEN_READ | BLK_OPEN_WRITE),
+		NULL, NULL);
+
+
+	if (IS_ERR(bpt_dev->bdev_file)) {
+		ret = PTR_ERR(bpt_dev->bdev_file);
+		if (ret != -ENOTBLK) {
+			dev_err(dev, "Failed to get block device %s: (%d)\n",
+				page, ret);
+		}
+		return ret;
+	}
+
+	kfree(bpt_dev->device_path);
+	bpt_dev->bd = file_bdev(bpt_dev->bdev_file);;
+	bpt_dev->device_path = kasprintf(GFP_KERNEL, "%s", page);
+	if (unlikely(!bpt_dev->device_path)) {
+		dev_err(dev, "Unable to allocate memory for device path\n");
+		return 0;
+	}
+
+	bpt_dev->dev_name = strrchr(bpt_dev->device_path, '/');
+	if (unlikely(!bpt_dev->dev_name))
+		bpt_dev->dev_name = bpt_dev->device_path;
+	else
+		bpt_dev->dev_name++;
+
+	spin_lock_irqsave(&bpt_dev->nm_lock, flags);
+	list_add_tail(&bpt_dev->node, &exportable_bds);
+	spin_unlock_irqrestore(&bpt_dev->nm_lock, flags);
+	return len;
+}
+
+CONFIGFS_ATTR(pci_blockpt_, disc_name);
+
+static ssize_t pci_blockpt_attached_show(struct config_item *item, char *page)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	return sprintf(page, "%i\n", bpt_dev->attached);
+}
+
+CONFIGFS_ATTR_RO(pci_blockpt_, attached);
+
+static ssize_t pci_blockpt_irq_stats_show(struct config_item *item, char *page)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	int cpu, next_idx = 0;
+
+	for_each_present_cpu(cpu) {
+		struct pci_epf_blockpt_queue *q = per_cpu_ptr(bpt_dev->q, cpu);
+		next_idx += sprintf(&page[next_idx], "cpu%d: %d\n", cpu,
+				    atomic_read(&q->raised_irqs));
+	}
+
+	return next_idx;
+}
+
+CONFIGFS_ATTR_RO(pci_blockpt_, irq_stats);
+
+static ssize_t pci_blockpt_max_number_of_queues_show(struct config_item *item,
+						     char *page)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+
+	return sprintf(page, "%i\n", bpt_dev->max_queue);
+}
+
+static ssize_t pci_blockpt_max_number_of_queues_store(struct config_item *item,
+						      const char *page,
+						      size_t len)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	u32 mq;
+	int err;
+
+	err = kstrtou32(page, 10, &mq);
+	if (err || mq > num_present_cpus() || mq == 0)
+		return -EINVAL;
+
+	bpt_dev->max_queue = mq;
+	return len;
+}
+
+CONFIGFS_ATTR(pci_blockpt_, max_number_of_queues);
+
+static ssize_t pci_blockpt_read_only_show(struct config_item *item, char *page)
+{
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+
+	return sprintf(page, "%i\n", bpt_dev->read_only);
+}
+
+static ssize_t pci_blockpt_read_only_store(struct config_item *item,
+					   const char *page, size_t len)
+{
+	bool ro;
+	struct pci_epf_blockpt_device *bpt_dev = to_blockpt_dev(item);
+	int ret = kstrtobool(page, &ro);
+
+	if (ret)
+		return ret;
+
+	bpt_dev->read_only = ro;
+	return len;
+}
+
+CONFIGFS_ATTR(pci_blockpt_, read_only);
+
+static struct configfs_attribute *blockpt_attrs[] = {
+	&pci_blockpt_attr_disc_name,
+	&pci_blockpt_attr_read_only,
+	&pci_blockpt_attr_max_number_of_queues,
+	&pci_blockpt_attr_attached,
+	&pci_blockpt_attr_irq_stats,
+	NULL,
+};
+
+static const struct config_item_type blockpt_disk_type = {
+	.ct_attrs = blockpt_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+static int blockpt_alloc_per_cpu_data(struct pci_epf_blockpt_device *bpt_dev)
+{
+	int cpu;
+
+	bpt_dev->q = alloc_percpu_gfp(struct pci_epf_blockpt_queue,
+				      GFP_KERNEL | __GFP_ZERO);
+	if (bpt_dev->q != NULL) {
+		for_each_possible_cpu(cpu) {
+			struct pci_epf_blockpt_queue *q =
+				per_cpu_ptr(bpt_dev->q, cpu);
+			spin_lock_init(&q->proc_lock);
+			sema_init(&q->proc_sem, 0);
+			INIT_LIST_HEAD(&q->proc_list);
+			q->irq = -EINVAL;
+			q->bpt_dev = bpt_dev;
+		}
+		return 0;
+	} else {
+		return -ENOMEM;
+	}
+}
+
+static struct config_group *pci_epf_blockpt_add_cfs(struct pci_epf *epf,
+						    struct config_group *group)
+{
+	struct pci_epf_blockpt_device *bpt_dev;
+	struct pci_blockpt_device_common *dcommon = epf_get_drvdata(epf);
+	struct device *dev = &epf->dev;
+	int ret;
+
+	bpt_dev = devm_kzalloc(dev, sizeof(*bpt_dev), GFP_KERNEL);
+	if (!bpt_dev) {
+		dev_err(dev, "Could not alloc bpt device\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	bpt_dev->max_queue = num_present_cpus();
+	bpt_dev->cfs_disk_name =
+		kasprintf(GFP_KERNEL, "disc%i", dcommon->next_disc_idx);
+	if (bpt_dev->cfs_disk_name == NULL) {
+		dev_err(dev, "Could not alloc cfs disk name\n");
+		goto free_bpt_dev;
+	}
+
+	bpt_dev->dcommon = dcommon;
+	ret = blockpt_alloc_per_cpu_data(bpt_dev);
+	if (ret)
+		goto free_bpt_dev;
+
+	spin_lock_init(&bpt_dev->nm_lock);
+	INIT_LIST_HEAD(&bpt_dev->node);
+	config_group_init_type_name(&bpt_dev->cfg_grp, bpt_dev->cfs_disk_name,
+				    &blockpt_disk_type);
+	bpt_dev->dev_tag = dcommon->next_disc_idx++;
+	return &bpt_dev->cfg_grp;
+
+free_bpt_dev:
+	devm_kfree(dev, bpt_dev);
+	return NULL;
+}
+
+static struct pci_epf_ops blockpt_ops = {
+	.unbind = pci_epf_blockpt_unbind,
+	.bind = pci_epf_blockpt_bind,
+	.add_cfs = pci_epf_blockpt_add_cfs,
+};
+
+static struct pci_epf_driver blockpt_driver = {
+	.driver.name = "pci_epf_blockpt",
+	.probe = pci_epf_blockpt_probe,
+	.remove = pci_epf_blockpt_remove,
+	.id_table = pci_epf_blockpt_ids,
+	.ops = &blockpt_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init pci_epf_blockpt_init(void)
+{
+	int ret;
+
+	kpciblockpt_wq = alloc_workqueue("kpciblockpt_wq",
+					 WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (!kpciblockpt_wq) {
+		pr_err("Failed to allocate the kpciblockpt work queue\n");
+		return -ENOMEM;
+	}
+
+	ret = pci_epf_register_driver(&blockpt_driver);
+	if (ret) {
+		destroy_workqueue(kpciblockpt_wq);
+		pr_err("Failed to register pci epf blockpt driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+module_init(pci_epf_blockpt_init);
+
+static void __exit pci_epf_blockpt_exit(void)
+{
+	if (kpciblockpt_wq)
+		destroy_workqueue(kpciblockpt_wq);
+	pci_epf_unregister_driver(&blockpt_driver);
+}
+module_exit(pci_epf_blockpt_exit);
+
+module_param(no_dma, bool, 0444);
+MODULE_DESCRIPTION("PCI Endpoint Function Driver for Block Device Passthrough");
+MODULE_AUTHOR("Wadim Mueller <wafgo01@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-epf-block-passthru.h b/include/linux/pci-epf-block-passthru.h
new file mode 100644
index 000000000000..751f9c863901
--- /dev/null
+++ b/include/linux/pci-epf-block-passthru.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+* PCI Endpoint Function for Blockdevice passthrough header
+*
+* Author: Wadim Mueller <wafgo01@gmail.com>
+*/
+
+#ifndef __LINUX_PCI_EPF_BLOCKPT_H
+#define __LINUX_PCI_EPF_BLOCKPT_H
+
+#include <linux/types.h>
+
+#define MAX_BLOCK_DEVS (16UL)
+
+#define BLOCKPT_MAGIC 0x636f6e74
+
+#define PBI_EPF_BLOCKPT_F_USED BIT(1)
+
+#define BPT_COMMAND_SET_QUEUE BIT(6)
+#define BPT_COMMAND_GET_DEVICES BIT(7)
+#define BPT_COMMAND_START BIT(8)
+#define BPT_COMMAND_GET_NUM_SECTORS BIT(9)
+#define BPT_COMMAND_STOP BIT(10)
+#define BPT_COMMAND_SET_IRQ BIT(11)
+#define BPT_COMMAND_GET_PERMISSION BIT(12)
+
+#define BPT_STATUS_SUCCESS BIT(0)
+#define BPT_STATUS_ERROR BIT(8)
+#define BPT_STATUS_QUEUE_ADDR_INVALID BIT(9)
+
+#define BPT_PERMISSION_RO BIT(0)
+
+struct pci_epf_blockpt_reg {
+	u32 magic;
+	u32 command;
+	u32 status;
+	u32 queue_bar_offset;
+	u32 drv_offset;
+	u32 dev_offset;
+	u32 num_desc;
+	u32 max_devs;
+	u32 irq;
+	u32 qsize;
+	u32 num_queues;
+	u32 queue_offset;
+	u32 available_qsize;
+	u8 dev_idx;
+	u8 perm;
+	u8 qidx;
+	u8 bres0;
+	u64 num_sectors;
+	char dev_name[64 * MAX_BLOCK_DEVS + 1];
+} __packed;
+
+struct pci_epf_blockpt_descr {
+	u64 s_sector; /* start sector of the request */
+	u64 addr; /* where the data is  */
+	u32 len; /* bytes to pu at addr + s_offset*/
+	struct blockpt_si {
+		u8 opf;
+		u8 status;
+		u8 flags;
+		u8 res0;
+	} si;
+};
+
+struct pci_blockpt_driver_ring {
+	u16 idx;
+	u16 ring[]; /* queue size*/
+};
+
+struct pci_blockpt_device_ring {
+	u16 idx;
+	u16 ring[]; /* queue size*/
+};
+
+#endif /* __LINUX_PCI_EPF_BLOCKPT_H */
-- 
2.25.1


