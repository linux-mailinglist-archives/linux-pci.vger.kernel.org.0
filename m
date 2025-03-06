Return-Path: <linux-pci+bounces-23042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48150A543FC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0864818931C6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FB18DB34;
	Thu,  6 Mar 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="MyMQ6Jyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u7vJp1lF"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDF199935;
	Thu,  6 Mar 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247566; cv=none; b=ljeQMivHELvYI5OV3TwDaqLC2lfFf/OoU16NfdIfAKHo8hUMiA1k5rfPys8SkXQGExYp1B6pKdj8XaV4S4w28ZdNhUdiMlglsNDqXeZiXeiJbaV3xC2iaZCOC4OlCSd5H2BPToguLJNlMKyD2v3ItysqC3qp6Y4jQFnvEWjalmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247566; c=relaxed/simple;
	bh=noQ3BKIZrFXKwAgwJiVH3B0Rtw3u587FK4RjtoUkKmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayC6XLdr3YXIYdoOcYmOts9VR7ykcoq0LkhR9r5ziVDQNljTpuA0fIm+qGM/dqx0K1IOuvVPgps6PAZo2N4fza+K5cnhoJ6t5z4KagSpybCgOihL1v4k1Jh679oD6tfN8CJUX4GYn4T2sv0/MSN2ApADIv6cj60leG4oHDn5mUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=MyMQ6Jyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u7vJp1lF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 241EA25400F5;
	Thu,  6 Mar 2025 02:52:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Mar 2025 02:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741247561; x=
	1741333961; bh=UzZ4zd7SvEIK2OzcdPL49gywmrbPC2FTtUAh+Wc3iMk=; b=M
	yMQ6JylomWBd9fhjr5KbMubQIlr+m9ZJYMiNmIf2ygeXLvqAw/CAC1ucI2oV4Hpt
	JjtwXSqcLgoInhmFcw3WIhEKQuLsay3bjMW76PsggU1bkCdrbxAcmCAHZGDTODps
	vLl7tZ9N3tN7XofjmP8tp6q0FVzhV+KCf9nWO7YskGs6Hsw3z613fA2TNmvXcxnU
	l5h7flXPPb2UUf77TqA4meYwAgqV8x4yGU8KZzfX7hlSp9oBrU4SvayTdx8LcAo5
	2B0RuTo6qsb/U9Sfmpm526OWxM53o3gR5S/1ret7gC78EYK3jt/tjT61Jq+zcCRm
	NbNFSho4amZZOylubAGwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741247561; x=1741333961; bh=U
	zZ4zd7SvEIK2OzcdPL49gywmrbPC2FTtUAh+Wc3iMk=; b=u7vJp1lFbGo+J/9Z0
	t3li2xSkWV+iUDno/plTHuhgsOMgVu0nv4WnCjkMk3ZVGNUEVdZkkcjJliaXVtM7
	fXy5K1a1WFm/pL0L3+MsX/iiwFfo0Ct35JEA6qGIYClebupCIcHheK+ee4Xo5CbJ
	kAm4yT1bv3x5Fz27p+/DB9upOtB8PuZhxFjM+eNXcUbyOvDGyEvbMo2OYCKVgs7o
	6qaLF3SME5jxhD/C8STQJmN75LFjCyyMGtpECuRR4SdSC22hrRL3ShwXRWJuTRsV
	DViiQXoSMy+L0z/HVIlXb22+hkUnFdTJlA6NQSYHVsXaUsemfHsGeWexA0xqT82X
	NVDkg==
X-ME-Sender: <xms:SVTJZ7FQocfRUyMJY_kakfJ04l9vQtN6sOhifW97m3Xn3fFBaeOPRg>
    <xme:SVTJZ4V9UBdbaEHJ4Vzf6YH77oSfRtYH-NzRbpyzRuIU_onlNwlLlANoVGOL7I-fB
    UZWskxMXtTd5zetoQU>
X-ME-Received: <xmr:SVTJZ9JHB0Lk_nPUzyQPEQslOhg9JGyx_z_k3kuzmaswZ5LRewjMCXMG4G0PRvQ_fQq_Ln7JaYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhr
    rghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepgeeiudfgvdehieffgfegteejuddthfeutdffueekgefgvdefteelvedv
    iedvuefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhi
    shhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhm
    pdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopegrlhgvgi
    drfihilhhlihgrmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhrihhs
    thhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehktghhsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihho
    nhdrohhrghdprhgtphhtthhopehlohhgrghnghesuggvlhhtrghtvggvrdgtohhm
X-ME-Proxy: <xmx:SVTJZ5GsGz7wL1_8ze9pfPI-kc2kJyYH_Jebj7BXCnXv0DrzaYvJ2w>
    <xmx:SVTJZxWEwl7r-VTjWrTQOzKNvhz1v4_jURSkzHiM1NrAz7tX2yj5SA>
    <xmx:SVTJZ0O3v5W0n2LrzTQQ1CnW-Q8ODoNyel9Tb6mDfh7XT6JaST6ROg>
    <xmx:SVTJZw3LqH-I2Fndec-AnOLYiBzVFTpw9EfYw7FbmOQjmXJiBpjtHw>
    <xmx:SVTJZyvAyF7AyI4x6HSXRLf4wk0dllNvKWXgOnQk0J1RhCNuWufX-Ry5>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 02:52:37 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
Date: Thu,  6 Mar 2025 17:52:10 +1000
Message-ID: <20250306075211.1855177-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306075211.1855177-1-alistair@alistair23.me>
References: <20250306075211.1855177-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe 6 specification added support for the Data Object
Exchange (DOE).
When DOE is supported the DOE Discovery Feature must be implemented per
PCIe r6.1 sec 6.30.1.1. DOE allows a requester to obtain
information about the other DOE features supported by the device.

The kernel is already querying the DOE features supported and cacheing
the values. Expose the values in sysfs to allow user space to
determine which DOE features are supported by the PCIe device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported features we can
allow userspace to parse the list, which might include
vendor specific features as well as yet to be supported features.

As the DOE Discovery feature must always be supported we treat it as a
special named attribute case. This allows the usual PCI attribute_group
handling to correctly create the doe_features directory when registering
pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
will seg fault).

After this patch is supported you can see something like this when
attaching a DOE device

$ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
0001:01        0001:02        doe_discovery

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Using dev->groups and device_add() path as discussed earlier [1]
doesn't work nicley as the pci_doe_sysfs_group is global.

We end up needing to create a per device instance of dev->groups
that is dynamically modified at init and appended to pci_dev_attr_groups.

Something similar to:
https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L2029
except in this case groups is already assigned.

It's complex and doesn't provide any advantages compared to the approach
in this patch, where we can just use sysfs_add_file_to_group() to add
the sysfs attributes. This aligns with other PCIe DOE related sysfs
patches, such as [2]

1: https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
2: https://lore.kernel.org/all/77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de/

v17:
 - Replace protocol with feature
 - Use pci_warn() at failure places instead of checking pci_doe_sysfs_init()
   return value
v16:
 - Rebase
v15:
 - Move init/teardown from pci_{create,remove}_resource_files()
 - Remove `if (IS_ENABLED(CONFIG_PCI_DOE))` checks
v14:
 - Revert back to v12 with extra pci_remove_resource_files() call
v13:
 - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
     - As discussed in https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
       we can just modify pci_doe_sysfs_group at the DOE init and let
       device_add() handle the sysfs attributes.
v12:
 - Drop pci_doe_features_sysfs_attr_visible()
v11:
 - Gracefully handle multiple entried of same feature
 - Minor fixes and code cleanups
v10:
 - Rebase to use DEFINE_SYSFS_GROUP_VISIBLE and remove
   special setup function
v9:
 - Add a teardown function
 - Rename functions to be clearer
 - Tidy up the commit message
 - Remove #ifdef from header
v8:
 - Inlucde an example in the docs
 - Fixup removing a file that wasn't added
 - Remove a blank line
v7:
 - Fixup the #ifdefs to keep the test robot happy
v6:
 - Use "feature" instead of protocol
 - Don't use any devm_* functions
 - Add two more patches to the series
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

 Documentation/ABI/testing/sysfs-bus-pci |  28 +++++
 drivers/pci/doe.c                       | 148 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   3 +
 drivers/pci/pci.h                       |   9 ++
 drivers/pci/probe.c                     |   2 +
 drivers/pci/remove.c                    |   1 +
 6 files changed, 191 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..874de7325d2b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -583,3 +583,31 @@ Description:
 		enclosure-specific indications "specific0" to "specific7",
 		hence the corresponding led class devices are unavailable if
 		the DSM interface is used.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		March 2025
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The features are
+		the file name. The contents of each file is the raw vendor id and
+		data object feature values.
+
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower (RHS of the colon) is
+		the data object type in hex. The upper (LHS of the colon)
+		is the vendor ID.
+
+		As all DOE devices must support the DOE discovery feature, if
+		DOE is supported you will at least see the doe_discovery file, with
+		this contents
+
+		# cat doe_features/doe_discovery
+		0001:00
+
+		If the device supports other features you will see other files
+		as well. For example is CMA/SPDM and secure CMA/SPDM are supported
+		the doe_features directory will look like this
+
+		# ls doe_features
+		0001:01        0001:02        doe_discovery
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index f4508d75ce69..5e55eb40160c 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -14,10 +14,12 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/sysfs.h>
 #include <linux/workqueue.h>
 
 #include "pci.h"
@@ -47,6 +49,7 @@
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
+ * @sysfs_attrs: Array of sysfs device attributes
  */
 struct pci_doe_mb {
 	struct pci_dev *pdev;
@@ -56,6 +59,10 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+#ifdef CONFIG_SYSFS
+	struct device_attribute *sysfs_attrs;
+#endif
 };
 
 struct pci_doe_feature {
@@ -92,6 +99,147 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static ssize_t doe_discovery_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	return sysfs_emit(buf, "0001:00\n");
+}
+DEVICE_ATTR_RO(doe_discovery);
+
+static struct attribute *pci_doe_sysfs_feature_attrs[] = {
+	&dev_attr_doe_discovery.attr,
+	NULL
+};
+
+static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return !xa_empty(&pdev->doe_mbs);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
+
+const struct attribute_group pci_doe_sysfs_group = {
+	.name	    = "doe_features",
+	.attrs	    = pci_doe_sysfs_feature_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs),
+};
+
+static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attr->attr.name);
+}
+
+static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
+					 struct pci_doe_mb *doe_mb)
+{
+	struct device_attribute *attrs = doe_mb->sysfs_attrs;
+	struct device *dev = &pdev->dev;
+	unsigned long i;
+	void *entry;
+
+	if (!attrs)
+		return;
+
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->feats, i, entry) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
+						     pci_doe_sysfs_group.name);
+		kfree(attrs[i].attr.name);
+	}
+	kfree(attrs);
+}
+
+static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
+					  struct pci_doe_mb *doe_mb)
+{
+	struct device *dev = &pdev->dev;
+	struct device_attribute *attrs;
+	unsigned long num_features = 0;
+	unsigned long vid, type;
+	unsigned long i;
+	void *entry;
+	int ret;
+
+	xa_for_each(&doe_mb->feats, i, entry)
+		num_features++;
+
+	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs) {
+		pci_warn(pdev, "Failed allocating the device_attribute array\n");
+		return -ENOMEM;
+	}
+
+	doe_mb->sysfs_attrs = attrs;
+	xa_for_each(&doe_mb->feats, i, entry) {
+		sysfs_attr_init(&attrs[i].attr);
+		vid = xa_to_value(entry) >> 8;
+		type = xa_to_value(entry) & 0xFF;
+
+		if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_FEATURE_DISCOVERY) {
+			/* DOE Discovery, manually displayed by `dev_attr_doe_discovery` */
+			continue;
+		}
+
+		attrs[i].attr.name = kasprintf(GFP_KERNEL,
+					       "%04lx:%02lx", vid, type);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			pci_warn(pdev, "Failed allocating the attribute name\n");
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = pci_doe_sysfs_feature_show;
+
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
+					      pci_doe_sysfs_group.name);
+		if (ret) {
+			attrs[i].show = NULL;
+			if (ret != -EEXIST) {
+				pci_warn(pdev, "Failed adding %s to sysfs group\n",
+					 attrs[i].attr.name);
+				goto fail;
+			} else
+				kfree(attrs[i].attr.name);
+		}
+	}
+
+	return 0;
+
+fail:
+	pci_doe_sysfs_feature_remove(pdev, doe_mb);
+	return ret;
+}
+
+void pci_doe_sysfs_teardown(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+		pci_doe_sysfs_feature_remove(pdev, doe_mb);
+}
+
+void pci_doe_sysfs_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+	int ret;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		ret = pci_doe_sysfs_feature_populate(pdev, doe_mb);
+		if (ret)
+			return;
+	}
+}
+#endif
+
 static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
 {
 	if (wait_event_timeout(doe_mb->wq,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..5e3874eaa3c1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1804,6 +1804,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_DOE
+	&pci_doe_sysfs_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..476d33c82058 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -253,6 +253,7 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct attribute_group *pci_bus_groups[];
+extern const struct attribute_group pci_doe_sysfs_group;
 #else
 static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
 static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
@@ -456,6 +457,14 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
 static inline void pci_npem_remove(struct pci_dev *dev) { }
 #endif
 
+#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
+void pci_doe_sysfs_init(struct pci_dev *pci_dev);
+void pci_doe_sysfs_teardown(struct pci_dev *pdev);
+#else
+static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
+static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..9b21e9379dae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2662,6 +2662,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	WARN_ON(ret < 0);
 
 	pci_npem_create(dev);
+
+	pci_doe_sysfs_init(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..5813726214e6 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -53,6 +53,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (pci_dev_test_and_set_removed(dev))
 		return;
 
+	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
 	device_del(&dev->dev);
-- 
2.48.1


