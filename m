Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CA776CD3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHIX3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHIX3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 19:29:09 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575ECE74;
        Wed,  9 Aug 2023 16:29:08 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-447576e24e1so136025137.1;
        Wed, 09 Aug 2023 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623747; x=1692228547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SKa1BDxxfI6RmfmY0KxKdPTiiuKtpbmCO+yG/HHjIw=;
        b=hR2w/mN7jQYOq0M81hMKha1MW+Hy8YGwyeL01CBHRi47bw1xoFFHCd4ARB6Qf9ytQC
         yyJKv0eZOVkvjiZ6F5dXMYxL0xY5M9z2DDbIOt74EsLEHagErjCbQmRQ6zqQya92N6Ww
         x6BH6ohB2IcfufVClXRj8SozbOtxLjg+WdPpR3sCgNdM7240ireMbRMhf/vVHay5+Ium
         ieUvU6lw45HbT44QcGU8xp6PeWOJ1fpatHfgBj68+zuqSjMIRHOKsWUsH9fu3whQQ4Zh
         92SuCkorsYwwn92gckwzz8gIIN6UcRHD2B8HM0zK6nbwz7HJWVCXWLv+IwlMpJ/hBv+K
         JZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623747; x=1692228547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SKa1BDxxfI6RmfmY0KxKdPTiiuKtpbmCO+yG/HHjIw=;
        b=EcUCqmfOsRBBYKokdCZ7Vrbd9n/sV9xpK0+7vSKwOUOMKBLf/NtPQ/9ZRd6qmxK+Eh
         z7+kKlQxt/m0glWcUW41s++OZzLTHTJcu+n75sr0X+khVDnURJ4ux30RtkwAjx8wrjxa
         2Wd0bn0y80YpfWJBgTbfPh/g4ZcI1WtHD4Bhz1yjv35Yg5midjjHGndfbJ++Z5zBpJ3V
         FBNbLOK1Hfi9MyA+wUDjHOOBoRyxvZ4A0SPJcHbi+DqB4ybN4y6kFC74aYxTGWYEAbsU
         qIcaAzFmDUjZoXk00GVDnxVYNeqoPoxZrXoSxg9eeq2pGR+2QwzQMsvIt312SFGj30H+
         EETw==
X-Gm-Message-State: AOJu0Yz3F3ZX3juyK/ebJDWxuBkRX/1x4B3UAkl6bU++42uif2rPACD2
        bwtBbY0aR488jlEtpQf0HA4=
X-Google-Smtp-Source: AGHT+IF9ObvOJtkykjEI/sb8W5VHiZL8Fe18xlKKyRyEwXXuumGGJPjUajjhn/j0MAhub8YWfiMujg==
X-Received: by 2002:a05:6102:497:b0:447:ba75:9c81 with SMTP id n23-20020a056102049700b00447ba759c81mr282925vsa.28.1691623747255;
        Wed, 09 Aug 2023 16:29:07 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id c20-20020a67e014000000b004475623a680sm24871vsl.27.2023.08.09.16.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:29:06 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Date:   Wed,  9 Aug 2023 19:28:51 -0400
Message-ID: <20230809232851.1004023-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - Expose each DOE feature as a separate file

 Documentation/ABI/testing/sysfs-bus-pci |  10 +++
 drivers/pci/doe.c                       | 107 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   7 ++
 include/linux/pci-doe.h                 |   1 +
 4 files changed, 125 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..e754b8efdb69 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,13 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_proto
+Date:		July 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This diectory contains a list of the supported Data Object Exchange (DOE)
+		features. Each feature is a single file.
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object type and the next
+		two bytes are the vendor ID.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..d5cbcb6a457a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -56,6 +56,10 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+#ifdef CONFIG_SYSFS
+	struct device_attribute *sysfs_attrs;
+#endif
 };
 
 struct pci_doe_protocol {
@@ -92,6 +96,109 @@ struct pci_doe_task {
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
+	if (!attrs)
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
+	struct device_attribute *attrs;
+	struct device *dev = &pdev->dev;
+	unsigned long i;
+	int ret;
+	unsigned long num_protos = 0;
+	unsigned long vid, type;
+	void *entry;
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
+		attrs[i].show = NULL;
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
+	unsigned long index, j;
+	int ret;
+	struct pci_doe_mb *doe_mb;
+	unsigned long total_protos = 0;
+	void *entry;
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
index ab32a91f287b..cb25aba081bc 100644
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
 
+#ifdef CONFIG_PCI_DOE
+	retval = doe_sysfs_init(pdev);
+	if (retval)
+		return retval;
+#endif
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

