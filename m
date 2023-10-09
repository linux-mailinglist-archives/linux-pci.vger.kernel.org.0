Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADF7BE739
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbjJIQ6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377884AbjJIQ6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 12:58:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A4188
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 09:58:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405497850dbso44567025e9.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Oct 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870687; x=1697475487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22Ou7Kmf9cNKCIWXUI7bhNPHKqi+qktoDIUHvbRcMX8=;
        b=JECFaq1mexHaZ4hDpKa1/Tny3Uu5Q6DByCMj10zWwN9mIhUTg8q3EYK1ns5+PFO3ji
         uVM8d2wwFHlt7gNoe5PkAHQztk+vk5uCHNx+ro8/sM53Bl/NftGk5W8KH+w+E9WEy49d
         RCIwzZJITdYOfjidnPssSAcXD5O4zUDI9IhUz9e3SXU8N/X3R4hKpq7dKhMcVbr/htHz
         CVGfUpU73+2g719IAIUMU3rUeBjvVrDp/Y+osFFZY9Ckbp2/5qj+ju4OQg52tuDhJtXp
         F7n1C2vohleBiL7DSOSr2dlsOu2mtNIRSOWtrV2v3J6eC5xn0qYmMRVliGYRegNF0rH9
         yh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870687; x=1697475487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22Ou7Kmf9cNKCIWXUI7bhNPHKqi+qktoDIUHvbRcMX8=;
        b=q67hYQkIAMbioEpMknne6sVPa1plWZUfVFHLGMPx4wuYCn8phwiAjzK5u1qwe3CF6u
         zfV2WlNZEt6b/KiZuIJ9D1/Zzb02DoKxKaf8FFtSPeObKBC248+fN9U6V43P+OdFc16I
         plBEm5/69vvIPg3QypGE31S0JrraD3JI8mEZENyGBYgfgiEx5hBLQb4VBZ4UBpKp7U3M
         yJQ4TgALCbJ8ct6d7uRXyz+9G2GXt06FWOCOS5S4VjZBdAVBuKan0+mO3Ew+c4+bsC1D
         T2I+8+pDVsX+enQU7Eq2j0n0sry9Bz2+ESG4WR8dCxc/PTLil+JATth8l8dw2/z7UGeK
         INFA==
X-Gm-Message-State: AOJu0YwXhYyl0ZApyTr26OjQZDTiJ/CxAhCJqf98X4TN+AJVzd0lW4tp
        893ZuDAf4iuPweq7FAa5lJlK7w==
X-Google-Smtp-Source: AGHT+IEkjxwlJNx9CSlyUJB/bsQpGGVGcu+zwoPXh95ENE4OC6neorbO4PotZkVoYUc9gbZn3wbqCw==
X-Received: by 2002:a7b:c8d7:0:b0:405:3b92:2fed with SMTP id f23-20020a7bc8d7000000b004053b922fedmr13656996wml.26.1696870687296;
        Mon, 09 Oct 2023 09:58:07 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:58:06 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH 7/7] block, drivers: make lots of attribute_group globals const
Date:   Mon,  9 Oct 2023 18:57:40 +0200
Message-Id: <20231009165741.746184-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This moves those variables to the ".rodata" section which reduces the
kernel size a bit and protects the variables by putting them on
read-only pages at runtime.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 block/blk-sysfs.c                   | 6 +++---
 block/genhd.c                       | 4 ++--
 block/partitions/core.c             | 2 +-
 drivers/base/cacheinfo.c            | 2 +-
 drivers/block/loop.c                | 2 +-
 drivers/block/rbd.c                 | 4 ++--
 drivers/input/input.c               | 2 +-
 drivers/input/serio/serio.c         | 2 +-
 drivers/pci/pci-sysfs.c             | 8 ++++----
 drivers/pci/pci.h                   | 6 +++---
 drivers/pps/sysfs.c                 | 2 +-
 drivers/rtc/sysfs.c                 | 2 +-
 drivers/tty/serial/8250/8250_port.c | 2 +-
 fs/ocfs2/cluster/sys.c              | 2 +-
 include/linux/khugepaged.h          | 2 +-
 include/linux/pps_kernel.h          | 2 +-
 mm/khugepaged.c                     | 2 +-
 17 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..feea5d68b5a1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -699,12 +699,12 @@ static umode_t blk_mq_queue_attr_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group queue_attr_group = {
+static const struct attribute_group queue_attr_group = {
 	.attrs = queue_attrs,
 	.is_visible = queue_attr_visible,
 };
 
-static struct attribute_group blk_mq_queue_attr_group = {
+static const struct attribute_group blk_mq_queue_attr_group = {
 	.attrs = blk_mq_queue_attrs,
 	.is_visible = blk_mq_queue_attr_visible,
 };
@@ -750,7 +750,7 @@ static const struct sysfs_ops queue_sysfs_ops = {
 	.store	= queue_attr_store,
 };
 
-static const struct attribute_group *blk_queue_attr_groups[] = {
+static const struct attribute_group *const blk_queue_attr_groups[] = {
 	&queue_attr_group,
 	&blk_mq_queue_attr_group,
 	NULL
diff --git a/block/genhd.c b/block/genhd.c
index d82560a79b04..9fa16e5de6d2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1115,12 +1115,12 @@ static umode_t disk_visible(struct kobject *kobj, struct attribute *a, int n)
 	return a->mode;
 }
 
-static struct attribute_group disk_attr_group = {
+static const struct attribute_group disk_attr_group = {
 	.attrs = disk_attrs,
 	.is_visible = disk_visible,
 };
 
-static const struct attribute_group *disk_attr_groups[] = {
+static const struct attribute_group *const disk_attr_groups[] = {
 	&disk_attr_group,
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	&blk_trace_attr_group,
diff --git a/block/partitions/core.c b/block/partitions/core.c
index e137a87f4db0..463298e26757 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -232,7 +232,7 @@ static const struct attribute_group part_attr_group = {
 	.attrs = part_attrs,
 };
 
-static const struct attribute_group *part_attr_groups[] = {
+static const struct attribute_group *const part_attr_groups[] = {
 	&part_attr_group,
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	&blk_trace_attr_group,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index b91c31c2a393..3642eed8ef74 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -786,7 +786,7 @@ static const struct attribute_group cache_default_group = {
 	.is_visible = cache_default_attrs_is_visible,
 };
 
-static const struct attribute_group *cache_default_groups[] = {
+static const struct attribute_group *const cache_default_groups[] = {
 	&cache_default_group,
 	NULL,
 };
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..c1718b17b5ef 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -736,7 +736,7 @@ static struct attribute *loop_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group loop_attribute_group = {
+static const struct attribute_group loop_attribute_group = {
 	.name = "loop",
 	.attrs= loop_attrs,
 };
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a999b698b131..73e616453c34 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5246,11 +5246,11 @@ static struct attribute *rbd_attrs[] = {
 	NULL
 };
 
-static struct attribute_group rbd_attr_group = {
+static const struct attribute_group rbd_attr_group = {
 	.attrs = rbd_attrs,
 };
 
-static const struct attribute_group *rbd_attr_groups[] = {
+static const struct attribute_group *const rbd_attr_groups[] = {
 	&rbd_attr_group,
 	NULL
 };
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8c5fdb0f858a..d97126d54947 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1597,7 +1597,7 @@ static const struct attribute_group input_dev_caps_attr_group = {
 	.attrs	= input_dev_caps_attrs,
 };
 
-static const struct attribute_group *input_dev_attr_groups[] = {
+static const struct attribute_group *const input_dev_attr_groups[] = {
 	&input_dev_attr_group,
 	&input_dev_id_attr_group,
 	&input_dev_caps_attr_group,
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 767fc9efb4a8..ef82d20572b0 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -474,7 +474,7 @@ static const struct attribute_group serio_device_attr_group = {
 	.attrs	= serio_device_attrs,
 };
 
-static const struct attribute_group *serio_device_attr_groups[] = {
+static const struct attribute_group *const serio_device_attr_groups[] = {
 	&serio_id_attr_group,
 	&serio_device_attr_group,
 	NULL
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9eede2dbc0e..f2147da6e4a5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -455,7 +455,7 @@ static const struct attribute_group pci_bus_group = {
 	.attrs = pci_bus_attrs,
 };
 
-const struct attribute_group *pci_bus_groups[] = {
+const struct attribute_group *const pci_bus_groups[] = {
 	&pci_bus_group,
 	NULL,
 };
@@ -647,7 +647,7 @@ static const struct attribute_group pcibus_group = {
 	.attrs = pcibus_attrs,
 };
 
-const struct attribute_group *pcibus_groups[] = {
+const struct attribute_group *const pcibus_groups[] = {
 	&pcibus_group,
 	NULL,
 };
@@ -1604,7 +1604,7 @@ static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
 };
 
-const struct attribute_group *pci_dev_groups[] = {
+const struct attribute_group *const pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
@@ -1641,7 +1641,7 @@ static const struct attribute_group pcie_dev_attr_group = {
 	.is_visible = pcie_dev_attrs_are_visible,
 };
 
-static const struct attribute_group *pci_dev_attr_groups[] = {
+static const struct attribute_group *const pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
 	&pci_dev_hp_attr_group,
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39a8932dc340..046d6c9944cd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -182,10 +182,10 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 	return (dev->no_d1d2 || parent_dstates);
 
 }
-extern const struct attribute_group *pci_dev_groups[];
-extern const struct attribute_group *pcibus_groups[];
+extern const struct attribute_group *const pci_dev_groups[];
+extern const struct attribute_group *const pcibus_groups[];
 extern const struct device_type pci_dev_type;
-extern const struct attribute_group *pci_bus_groups[];
+extern const struct attribute_group *const pci_bus_groups[];
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
index 134bc33f6ad0..355ce20b6e53 100644
--- a/drivers/pps/sysfs.c
+++ b/drivers/pps/sysfs.c
@@ -93,7 +93,7 @@ static const struct attribute_group pps_group = {
 	.attrs = pps_attrs,
 };
 
-const struct attribute_group *pps_groups[] = {
+const struct attribute_group *const pps_groups[] = {
 	&pps_group,
 	NULL,
 };
diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index 9c45c2557e28..c126cb706b27 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -303,7 +303,7 @@ static struct attribute_group rtc_attr_group = {
 	.attrs		= rtc_attrs,
 };
 
-static const struct attribute_group *rtc_attr_groups[] = {
+static const struct attribute_group *const rtc_attr_groups[] = {
 	&rtc_attr_group,
 	NULL
 };
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 141627370aab..7af8f196e00f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3187,7 +3187,7 @@ static struct attribute *serial8250_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group serial8250_dev_attr_group = {
+static const struct attribute_group serial8250_dev_attr_group = {
 	.attrs = serial8250_dev_attrs,
 };
 
diff --git a/fs/ocfs2/cluster/sys.c b/fs/ocfs2/cluster/sys.c
index 022f716c74ff..63e14ef53610 100644
--- a/fs/ocfs2/cluster/sys.c
+++ b/fs/ocfs2/cluster/sys.c
@@ -31,7 +31,7 @@ static struct attribute *o2cb_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group o2cb_attr_group = {
+static const struct attribute_group o2cb_attr_group = {
 	.attrs = o2cb_attrs,
 };
 
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f68865e19b0b..85b442e9e638 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -5,7 +5,7 @@
 #include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern struct attribute_group khugepaged_attr_group;
+extern const struct attribute_group khugepaged_attr_group;
 
 extern int khugepaged_init(void);
 extern void khugepaged_destroy(void);
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..996db99f983f 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -66,7 +66,7 @@ struct pps_device {
  * Global variables
  */
 
-extern const struct attribute_group *pps_groups[];
+extern const struct attribute_group *const pps_groups[];
 
 /*
  * Internal functions.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..cd1b26075d1b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -339,7 +339,7 @@ static struct attribute *khugepaged_attr[] = {
 	NULL,
 };
 
-struct attribute_group khugepaged_attr_group = {
+const struct attribute_group khugepaged_attr_group = {
 	.attrs = khugepaged_attr,
 	.name = "khugepaged",
 };
-- 
2.39.2

