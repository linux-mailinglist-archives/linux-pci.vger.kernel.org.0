Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB0779C1A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 02:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHLApP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 20:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHLApN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 20:45:13 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042BE2686;
        Fri, 11 Aug 2023 17:45:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56d6dfa8b52so1976322eaf.3;
        Fri, 11 Aug 2023 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691801112; x=1692405912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8U2rb5bbZciiUVGhG6iW04W/aJ7xYLN22CGCHBT/DZA=;
        b=itBAOp9hHki7jXdU8QyopEy8993FP+dd5Sug33CBhmPjn35o7hI6DdhrOdZbRzCDyo
         e5JX0dPOJ6SESKbhWXgfF58GypzpnQ2pDnLRIoMon8uABRAaiwtJuFFmwf2orXYKOZC8
         pijfbkULrN2ElbRrugW/fyx4L5dAx3CNjv9KrYOQlXBZ+tDw/ZFFR8eO3W17tBzOcpEY
         Um1Fiv+aDAZXc5tUUKVWzSQZCSkaY60rYOfNoozdtWM/bNpzBiicEa0deeRQ/pMnlHNC
         BFKUjyI87rGO0dGzDn6zb2dQGtFA/cT6O85e7bsoFEJYAHPRHnjBQmnEgK6C4p5SQUdI
         h1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691801112; x=1692405912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U2rb5bbZciiUVGhG6iW04W/aJ7xYLN22CGCHBT/DZA=;
        b=QfGaIy/PG9Y6IzagMQNlZPU6WHzAG/WFG7QBpqvPHQyKhh4IB3/Im1zIugCtxDuR7p
         K3mNUb5szlK10MZjaYsV/QZOY1WPHGT4nwnBQVMiTfz9qCljtCLppqQAqz1e7rRW0X01
         UgFefRzXkqBdcB+fEPOJiHMUpwl3xoyDRguitRu0XtjHZEfMIG62pc62x+i/loZi4+QN
         fZ44P+e8v65qLkkFkfh/FANg3QaT/mzPwZxvOhCw0jo+DAiMiIFZrgcYl8tcixIiTGNG
         TwoXyIQ9DplcEEBU+hcqZozUeClf73okzzuEVTt4ULG/eL8mZsM1zo0KUH346Rpkxnde
         2foQ==
X-Gm-Message-State: AOJu0Yy7uNPQKoLItGksi/tGZ7EXsH4wLA/9u1ivX84znIiLDXBX76vS
        hO9P4IeIwUBhPtElz/dIj8I=
X-Google-Smtp-Source: AGHT+IFpXcndJNgooV6+QR7pDzPBFicA6z/JhhwV83cl29GBd8WZ+JBubglmi1ikglIWcuDJerxrwA==
X-Received: by 2002:a05:6358:4297:b0:139:e7db:3f3f with SMTP id s23-20020a056358429700b00139e7db3f3fmr3663316rwc.10.1691801112072;
        Fri, 11 Aug 2023 17:45:12 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id k24-20020ab05398000000b00796e08ed58dsm749254uaa.29.2023.08.11.17.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:45:11 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5] PCI/DOE: Expose the DOE protocols via sysfs
Date:   Fri, 11 Aug 2023 20:44:53 -0400
Message-ID: <20230812004453.1241736-1-alistair.francis@wdc.com>
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

Each DOE protocol is exposed as a single file. The files are empty and
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
v5:
 - Return the file name as the file contents
 - Code cleanups and simplifications
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

 Documentation/ABI/testing/sysfs-bus-pci |  11 +++
 drivers/pci/doe.c                       | 110 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   7 ++
 include/linux/pci-doe.h                 |   1 +
 4 files changed, 129 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..1002a276dac9 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,14 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_protocols
+Date:		August 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The feature values are in the
+		file name. The contents of each file is the same as the name.
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object
+		type and the next two bytes are the vendor ID.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..3eb3160c4ba7 100644
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
@@ -92,6 +94,114 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static struct attribute *pci_dev_doe_proto_attrs[] = {
+	NULL,
+};
+
+static const struct attribute_group pci_dev_doe_proto_group = {
+	.name	= "doe_protocols",
+	.attrs	= pci_dev_doe_proto_attrs,
+};
+
+static ssize_t pci_doe_sysfs_proto_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attr->attr.name);
+}
+
+static int pci_doe_sysfs_proto_supports(struct pci_dev *pdev,
+					struct pci_doe_mb *doe_mb)
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
+		attrs[i].attr.name = kasprintf(GFP_KERNEL,
+					       "0x%04lX:%02lX", vid, type);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = pci_doe_sysfs_proto_show;
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
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->prots, i, entry) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
+						     pci_dev_doe_proto_group.name);
+		kfree(attrs[i].attr.name);
+	}
+
+	kfree(attrs);
+
+	return ret;
+}
+
+int doe_sysfs_init(struct pci_dev *pdev)
+{
+	bool add_doe_group = false;
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	void *entry;
+	int ret;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->prots, j, entry) {
+			add_doe_group = true;
+			goto add_doe_group;
+		}
+	}
+
+	if (!add_doe_group)
+		return 0;
+
+add_doe_group:
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

