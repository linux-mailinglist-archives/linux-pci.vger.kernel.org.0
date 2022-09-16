Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6F5BB3A4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIPUo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIPUoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 16:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B253C8DE
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663361092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y/XvrfP+pTeDCxzR/xWcKMELylwPENiPm0YnxC8VazM=;
        b=Syyp7MrzhsoVxuBhuR+cYQqw3lllO1kTZt72oRAgpgglAdtykii31gC1M9EQciWZeyUNYj
        Qa7lqv7Jgc7aMV+K3XnYYruTilwqETUTF/ErZ8aASHU+NLRUnB58GHBFPHwp+fRZ4BztZB
        LV5T/5vm7C9MYqqPkgVef0TfYeavX5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-i4ZdB-brNsmBWM8zwFkeog-1; Fri, 16 Sep 2022 16:44:49 -0400
X-MC-Unique: i4ZdB-brNsmBWM8zwFkeog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BB2811E67;
        Fri, 16 Sep 2022 20:44:48 +0000 (UTC)
Received: from [172.30.42.193] (unknown [10.22.8.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74EB6492B04;
        Fri, 16 Sep 2022 20:44:48 +0000 (UTC)
Subject: [PATCH v2] PCI: Expose PCIe Resizable BAR support via sysfs
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        bhelgaas@google.com
Date:   Fri, 16 Sep 2022 14:44:48 -0600
Message-ID: <166336088796.3597940.14973499936692558556.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

v2:
 - Convert to static attributes with is_visible callback
 - Include aperture driver removal for console drivers
 - Remove and recreate resourceN attributes
 - Expand ABI description
 - Drop 2nd field in show attribute

 Documentation/ABI/testing/sysfs-bus-pci |   33 +++++++++
 drivers/pci/pci-sysfs.c                 |  108 +++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6fc2c2efe8ab..ba9a5482436f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -457,3 +457,36 @@ Description:
 
 		The file is writable if the PF is bound to a driver that
 		implements ->sriov_set_msix_vec_count().
+
+What:		/sys/bus/pci/devices/.../resourceN_resize
+Date:		September 2022
+Contact:	Alex Williamson <alex.williamson@redhat.com>
+Description:
+		These files provide an interface to PCIe Resizable BAR support.
+		A file is created for each BAR resource (N) supported by the
+		PCIe Resizable BAR extended capability of the device.  Reading
+		each file exposes the bitmap of available resources sizes:
+
+		# cat resource1_resize
+		00000000000001c0
+
+		The bitmap represents supported resources sizes for the BAR,
+		where bit0 = 1MB, bit1 = 2MB, bit2 = 4MB, etc.  In the above
+		example the devices supports 64MB, 128MB, and 256MB BAR sizes.
+
+		When writing the file, the user provides the bit position of
+		the desired resource size, for example:
+
+		# echo 7 > resource1_resize
+
+		This indicates to set the size value corresponding to bit 7,
+		128MB.  The resulting size is 2 ^ (bit# + 20).  This definition
+		matches the PCIe specification of this capability.
+
+		In order to make use of resouce resizing, all PCI drivers must
+		be unbound from the device and peer devices under the same
+		parent bridge may need to be soft removed.  In the case of
+		VGA devices, writing a resize value will remove low level
+		console drivers from the device.  Raw users of pci-sysfs
+		resourceN attributes must be terminated prior to resizing.
+		Success of the resizing operation is not a guaranteed.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ac92e6a2397..f0298a8b08d9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/aperture.h>
 #include "pci.h"
 
 static int sysfs_initialized;	/* = 0 */
@@ -1379,6 +1380,112 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#define pci_dev_resource_resize_attr(n)					\
+static ssize_t resource##n##_resize_show(struct device *dev,		\
+					 struct device_attribute *attr,	\
+					 char * buf)			\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	ssize_t ret;							\
+									\
+	pci_config_pm_runtime_get(pdev);				\
+									\
+	ret = sysfs_emit(buf, "%016llx\n",				\
+			 (u64)pci_rebar_get_possible_sizes(pdev, n));	\
+									\
+	pci_config_pm_runtime_put(pdev);				\
+									\
+	return ret;							\
+}									\
+									\
+static ssize_t resource##n##_resize_store(struct device *dev,		\
+					  struct device_attribute *attr,\
+					  const char *buf, size_t count)\
+{									\
+	struct pci_dev *pdev = to_pci_dev(dev);				\
+	unsigned long size, flags;					\
+	int ret, i;							\
+	u16 cmd;							\
+									\
+	if (kstrtoul(buf, 0, &size) < 0)				\
+		return -EINVAL;						\
+									\
+	device_lock(dev);						\
+	if (dev->driver) {						\
+		ret = -EBUSY;						\
+		goto unlock;						\
+	}								\
+									\
+	pci_config_pm_runtime_get(pdev);				\
+									\
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {		\
+		ret = aperture_remove_conflicting_pci_devices(pdev,	\
+						"resourceN_resize");	\
+		if (ret)						\
+			goto pm_put;					\
+	}								\
+									\
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);			\
+	pci_write_config_word(pdev, PCI_COMMAND,			\
+			      cmd & ~PCI_COMMAND_MEMORY);		\
+									\
+	flags = pci_resource_flags(pdev, n);				\
+									\
+	pci_remove_resource_files(pdev);				\
+									\
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {			\
+		if (pci_resource_len(pdev, i) &&			\
+		    pci_resource_flags(pdev, i) == flags)		\
+			pci_release_resource(pdev, i);			\
+	}								\
+									\
+	ret = pci_resize_resource(pdev, n, size);			\
+									\
+	pci_assign_unassigned_bus_resources(pdev->bus);			\
+									\
+	if (pci_create_resource_files(pdev))				\
+		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");\
+									\
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);			\
+pm_put:									\
+	pci_config_pm_runtime_put(pdev);				\
+unlock:									\
+	device_unlock(dev);						\
+									\
+	return ret ? ret : count;					\
+}									\
+static DEVICE_ATTR_RW(resource##n##_resize)
+
+pci_dev_resource_resize_attr(0);
+pci_dev_resource_resize_attr(1);
+pci_dev_resource_resize_attr(2);
+pci_dev_resource_resize_attr(3);
+pci_dev_resource_resize_attr(4);
+pci_dev_resource_resize_attr(5);
+
+static struct attribute *resource_resize_attrs[] = {
+	&dev_attr_resource0_resize.attr,
+	&dev_attr_resource1_resize.attr,
+	&dev_attr_resource2_resize.attr,
+	&dev_attr_resource3_resize.attr,
+	&dev_attr_resource4_resize.attr,
+	&dev_attr_resource5_resize.attr,
+	NULL,
+};
+
+static umode_t resource_resize_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
+}
+
+static const struct attribute_group pci_dev_resource_resize_group = {
+	.attrs = resource_resize_attrs,
+	.is_visible = resource_resize_is_visible,
+};
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1500,6 +1607,7 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
+	&pci_dev_resource_resize_group,
 	NULL,
 };
 


