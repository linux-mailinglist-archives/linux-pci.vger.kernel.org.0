Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2819777E58
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjHJQeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHJQeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 12:34:06 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133249C;
        Thu, 10 Aug 2023 09:34:06 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4872b26b352so488347e0c.0;
        Thu, 10 Aug 2023 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685245; x=1692290045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riB0q8WOMUWTGJga3tun2ObTZ+JHiO3GjoCQY3OWRpo=;
        b=EjlA1UYdwma2dg+eH2qlJbzECFkOdcYCdi/n/vLZZMXLQHzlGp9xh2HeYxvsYmxXRE
         lT1dUGkxrymZoRpotnmYvIfiChC5HKzZz4wON9fjJR3SPGrsmUzMWxanAaVt+hZ7g+v9
         /j31AjkTnl9eTVH0eZ0o2ge4ZMwtAv35ZLkD9MdoBbE5E2iLLY7n6TD84Z0RTi68M8Yf
         e22nHgboklXgAiWKjlyaWV5lmRFB4TISfrVoN90DmhUQjcXMa6dQnVAq3/HIPj63Ix7m
         NZ6RaZwyhHbPJ3BmikLBT+eO8ZlJaTYYXwq5rxuiS52lPLoKgCkGNz19TcrkAKqxfu2Y
         zyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685245; x=1692290045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riB0q8WOMUWTGJga3tun2ObTZ+JHiO3GjoCQY3OWRpo=;
        b=LKap64dC2VLegjHswEVyxjN/gjKSuHp584VuhxwN/hqC46+5CH3lwZ9VAO0BB3UfUe
         bUH5nohHJib3fbwkQO/BYWR4XkkGD+xnuwDZZfUVnJVhpGau36Tt312uYI0O5UevPfPt
         3KjRSkdR4LP4Y3TgfPqVoTp1mLPmIKaYnd4R+fEyzDEPmqwfgR/yzFHOP6pFFxcbbt/i
         SKUt1pqUYLw4CsSTaYe6OQjKFRaklNKx8qSbrngk+iVi4nS/hTC0tTsl2j3E97ZldE73
         gfTVFGmnjtzjKbO0zH1uekQbT+KizSmz7kzJ15opWygUI7OFBq2BNaXiT0x6ZSSGx1Hl
         QqgA==
X-Gm-Message-State: AOJu0Yw1kgiHpOWRGzCirj9Shzz2+h7mPI3RlfRQ4SGHAiRf+5uAu4m+
        tlyPYg1TtQ6CKDeIwemsREE=
X-Google-Smtp-Source: AGHT+IHE/ZVPbKWeqHTLt87A6V09Z+02S63Qwf8I1zsLlwsAIB4HDT0xfu+o85YTUODYLw656Rv8vA==
X-Received: by 2002:a67:cd01:0:b0:443:70a8:8ced with SMTP id u1-20020a67cd01000000b0044370a88cedmr2129326vsl.3.1691685245101;
        Thu, 10 Aug 2023 09:34:05 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id o11-20020a67e14b000000b00440978082a6sm301230vsl.8.2023.08.10.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:34:04 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Date:   Thu, 10 Aug 2023 12:33:42 -0400
Message-ID: <20230810163342.1059509-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe 6 specification added support for the Data Object Exchange (DOE).
When DOE is supported the Discovery Data Object Protocol must be
implemented. The protocol allows a requester to obtain information about
the other DOE protocols supported by the device.

The kernel is already querying the DOE protocols supported and cacheing
the values. This patch exposes the values via sysfs. This will allow
userspace to determine which DOE protocols are supported by the PCIe
device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported protocols we can
allow userspace to parse and support the list, which might include
vendor specific protocols as well as yet to be supported protocols.

Each DOE feature is exposed as a single file. The files are empty and
the information is contained in the file name.

This uses pci_sysfs_init() instead of the ->is_visible() function as
is_visible only applies to the attributes under the group. Which
means that every PCIe device will see a `doe_protos` directory, no
matter if DOE is supported at all on the device.

On top of that ->is_visible() is only called
(fs/sysfs/group.c:create_files()) if there are sub attrs, which we
don't necessary have. There are no static attrs, instead they are
all generated dynamically.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - Fixup typos in the documentation
 - Make it clear that the file names contain the information
 - Small code cleanups
 - Remove most #ifdefs
 - Remove extra NULL assignment
v3:
 - Expose each DOE feature as a separate file
v2:
 - Add documentation
 - Code cleanups

We did talk about exposing DOE types under DOE vendor IDs, but I couldn't
figure out a simple way to do that

 Documentation/ABI/testing/sysfs-bus-pci |  10 +++
 drivers/pci/doe.c                       | 104 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   7 ++
 include/linux/pci-doe.h                 |   1 +
 4 files changed, 122 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..e09c51449284 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,13 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_protos
+Date:		August 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported Data Object Exchange (DOE)
+		features. The feature values are in the file name; the files have no contents.
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object type and the next
+		two bytes are the vendor ID.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..918872152fb6 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -56,6 +56,8 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+	struct device_attribute *sysfs_attrs;
 };
 
 struct pci_doe_protocol {
@@ -92,6 +94,108 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static struct attribute *pci_dev_doe_proto_attrs[] = {
+	NULL,
+};
+
+static const struct attribute_group pci_dev_doe_proto_group = {
+	.name	= "doe_protos",
+	.attrs	= pci_dev_doe_proto_attrs,
+};
+
+static void pci_doe_sysfs_remove_desc(struct pci_doe_mb *doe_mb)
+{
+	struct device_attribute *attrs = doe_mb->sysfs_attrs;
+	unsigned long i;
+	void *entry;
+
+	if (!doe_mb->sysfs_attrs)
+		return;
+
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->prots, i, entry)
+		kfree(attrs[i].attr.name);
+
+	kfree(attrs);
+}
+
+static int pci_doe_sysfs_proto_supports(struct pci_dev *pdev, struct pci_doe_mb *doe_mb)
+{
+	struct device *dev = &pdev->dev;
+	struct device_attribute *attrs;
+	unsigned long num_protos = 0;
+	unsigned long vid, type;
+	unsigned long i;
+	void *entry;
+	int ret;
+
+	xa_for_each(&doe_mb->prots, i, entry)
+		num_protos++;
+
+	attrs = kcalloc(num_protos, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	doe_mb->sysfs_attrs = attrs;
+	xa_for_each(&doe_mb->prots, i, entry) {
+		sysfs_attr_init(&attrs[i].attr);
+		vid = xa_to_value(entry) >> 8;
+		type = xa_to_value(entry) & 0xFF;
+		attrs[i].attr.name = kasprintf(GFP_KERNEL, "0x%04lX:%02lX", vid, type);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
+					      pci_dev_doe_proto_group.name);
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	pci_doe_sysfs_remove_desc(doe_mb);
+	return ret;
+}
+
+int doe_sysfs_init(struct pci_dev *pdev)
+{
+	unsigned long total_protos = 0;
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	void *entry;
+	int ret;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->prots, j, entry)
+			total_protos++;
+	}
+
+	if (total_protos == 0)
+		return 0;
+
+	ret = devm_device_add_group(&pdev->dev, &pci_dev_doe_proto_group);
+	if (ret) {
+		pci_err(pdev, "can't create DOE goup: %d\n", ret);
+		return ret;
+	}
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		ret = pci_doe_sysfs_proto_supports(pdev, doe_mb);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
 static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
 {
 	if (wait_event_timeout(doe_mb->wq,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..ad621850a3e2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/stat.h>
 #include <linux/export.h>
 #include <linux/topology.h>
@@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	int i;
 	int retval;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE)) {
+		retval = doe_sysfs_init(pdev);
+		if (retval)
+			return retval;
+	}
+
 	/* Expose the PCI resources from this device as files */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..4cc13d9ccb50 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -22,4 +22,5 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
 	    void *response, size_t response_sz);
 
+int doe_sysfs_init(struct pci_dev *pci_dev);
 #endif
-- 
2.41.0

