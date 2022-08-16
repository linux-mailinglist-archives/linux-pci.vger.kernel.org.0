Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089459634A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 21:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiHPTlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiHPTlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 15:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC17876BD
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iy9C67BR9Y8mzLSmrgLV3EkX5N4BTVdAX1TDUnMFU5U=;
        b=JS2MRAOHJywQWwCt9TOi4bovthqVRuuPDjqk+F8FBjRjD+pOtkY99m+A4kpoNhlkpoo9y/
        wX1pgFlUv/hveYnLj6MyN32Qcig0DDdpjmygjJzdBENXzK0SkN8PHO/jo8HhUkcqop7shL
        0S6MtIF08P4psjWFw01g85Jk1Z+MtTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-uHBhXavFMo26heGh2Sk8OQ-1; Tue, 16 Aug 2022 15:41:05 -0400
X-MC-Unique: uHBhXavFMo26heGh2Sk8OQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA0D3C0D19D;
        Tue, 16 Aug 2022 19:41:05 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD612026D4C;
        Tue, 16 Aug 2022 19:41:04 +0000 (UTC)
Subject: [RFC PATCH 3/3] PCI: Expose PCIe Resizable BAR support via sysfs
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 13:41:04 -0600
Message-ID: <166067883598.1885802.7663904087127986133.stgit@omen>
In-Reply-To: <166067824399.1885802.12557332818208187324.stgit@omen>
References: <166067824399.1885802.12557332818208187324.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This proposes a simple sysfs interface to Resizable BAR support,
largely for the purposes of assigning such devices to a VM through
VFIO.  Resizable BARs present a difficult feature to expose to a VM
through emulation, as resizing a BAR is done on the host.  It can
fail, and often does, but we have no means via emulation of a PCIe
REBAR capability to handle the error cases.

A vfio-pci specific ioctl interface is also cumbersome as there are
often multiple devices within the same bridge aperture and handling
them is a challenge.  In the interface proposed here, expanding a
BAR potentially requires such devices to be soft-removed during the
resize operation and rescanned after, in order for all the necessary
resources to be released.  A pci-sysfs interface is also more
universal than a vfio specific interface.

Please see the ABI documentation update for usage.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

NB, I realize the read value of the syfs attribute provides two values,
the bitmap of possible sizes and the current size.  There are a number
of ways to determine the current size, including stat(1) on the
resourceN file, but I found this output to be useful while developing
the interface and provides consistency with the store value to the
attribute.  Suggestions welcome for better semantics.

 Documentation/ABI/testing/sysfs-bus-pci |   27 +++++++
 drivers/pci/pci-sysfs.c                 |  118 +++++++++++++++++++++++++++++++
 include/linux/pci.h                     |    1 
 3 files changed, 146 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6fc2c2efe8ab..5eea5d89c9f2 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -457,3 +457,30 @@ Description:
 
 		The file is writable if the PF is bound to a driver that
 		implements ->sriov_set_msix_vec_count().
+
+What:		/sys/bus/pci/devices/.../resourceN_resize
+Date:		August 2022
+Contact:	Alex Williamson <alex.williamson@redhat.com>
+Description:
+		These files provide an interface to PCIe Resizable BAR support.
+		A file is created for each BAR resource (N) supported by the
+		PCIe Resizable BAR extended capability of the device.  Reading
+		each file exposes the capability and current setting for the
+		device, ex.
+
+		# cat resource1_resize
+		00000000000001c0:6
+
+		The first field provides the supported sizes bitmap, where
+		bit0 = 1MB, bit1 = 2MB, bit2 = 4MB, etc.  In the above example
+		the devices supports 64MB, 128MB, and 256MB BAR sizes.  The
+		second field provides the current setting, the value 6
+		indicates bit6 is set, which corresponds to 64MB.
+
+		When writing the file, only the latter is used, ex.
+
+		# echo 7 > resource1_resize
+
+		This indicates to set the size value corresponding to bit 7,
+		which is 128MB.  The resulting size is 2 ^ (bit# + 20).  This
+		definition matches the PCIe specification of this capability.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ac92e6a2397..aa59a2de508f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1143,6 +1143,7 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct bin_attribute *res_attr;
+		struct dev_ext_attribute *resize_attr;
 
 		res_attr = pdev->res_attr[i];
 		if (res_attr) {
@@ -1155,6 +1156,13 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
 		}
+
+		resize_attr = pdev->res_attr_resize[i];
+		if (resize_attr) {
+			sysfs_remove_file(&pdev->dev.kobj,
+					  &resize_attr->attr.attr);
+			kfree(resize_attr);
+		}
 	}
 }
 
@@ -1208,6 +1216,108 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	return retval;
 }
 
+static ssize_t pci_bar_resize_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dev_ext_attribute *resize_attr =
+			container_of(attr, struct dev_ext_attribute, attr);
+	int bar = (int)(long)resize_attr->var;
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
+
+	/*
+	 * pci_rebar_get_possible_sizes() only currently reads supported sizes
+	 * from the capability register and therefore returns a u32.  The spec
+	 * allows additional supported bits in the control register, which
+	 * then exceeds 32bit.  Expose a u64 to userspace for future compat.
+	 */
+	ret = sysfs_emit(buf, "%016llx:%d\n",
+			(u64)pci_rebar_get_possible_sizes(pdev, bar),
+			pci_rebar_get_current_size(pdev, bar));
+
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
+}
+
+static ssize_t pci_bar_resize_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dev_ext_attribute *resize_attr =
+			container_of(attr, struct dev_ext_attribute, attr);
+	int ret, i, bar = (int)(long)resize_attr->var;
+	unsigned long size, flags;
+	u16 cmd;
+
+	if (kstrtoul(buf, 0, &size) < 0)
+		return -EINVAL;
+
+	device_lock(dev);
+	if (dev->driver) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	pci_config_pm_runtime_get(pdev);
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd & ~PCI_COMMAND_MEMORY);
+
+	flags = pci_resource_flags(pdev, bar);
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pdev, i) &&
+		    pci_resource_flags(pdev, i) == flags)
+			pci_release_resource(pdev, i);
+	}
+
+	ret = pci_resize_resource(pdev, bar, size);
+
+	pci_assign_unassigned_bus_resources(pdev->bus);
+
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	pci_config_pm_runtime_put(pdev);
+unlock:
+	device_unlock(dev);
+
+	return ret ? ret : count;
+}
+
+static int pci_create_resize_attr(struct pci_dev *pdev, int num)
+{
+	struct dev_ext_attribute *resize_attr;
+	char *resize_attr_name;
+	int retval;
+
+	resize_attr = kzalloc(sizeof(*resize_attr) + 17, GFP_ATOMIC);
+	if (!resize_attr)
+		return -ENOMEM;
+
+	resize_attr_name = (char *)(resize_attr + 1);
+
+	sysfs_attr_init(&resize_attr->attr.attr);
+	sprintf(resize_attr_name, "resource%d_resize", num);
+	resize_attr->attr.attr.name = resize_attr_name;
+	resize_attr->attr.attr.mode = 0600;
+	resize_attr->attr.show = pci_bar_resize_show;
+	resize_attr->attr.store = pci_bar_resize_store;
+	resize_attr->var = (void *)(long)num;
+
+	retval = sysfs_create_file(&pdev->dev.kobj, &resize_attr->attr.attr);
+	if (retval) {
+		kfree(resize_attr);
+		return retval;
+	}
+
+	pdev->res_attr_resize[num] = resize_attr;
+	return 0;
+}
+
 /**
  * pci_create_resource_files - create resource files in sysfs for @dev
  * @pdev: dev in question
@@ -1235,6 +1345,14 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 			pci_remove_resource_files(pdev);
 			return retval;
 		}
+
+		if (pci_rebar_get_current_size(pdev, i) >= 0) {
+			retval = pci_create_resize_attr(pdev, i);
+			if (retval) {
+				pci_remove_resource_files(pdev);
+				return retval;
+			}
+		}
 	}
 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..9c4db0c5f215 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -470,6 +470,7 @@ struct pci_dev {
 	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+	struct dev_ext_attribute *res_attr_resize[DEVICE_COUNT_RESOURCE]; /* sysfs file for resizing BAR resources */
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */


