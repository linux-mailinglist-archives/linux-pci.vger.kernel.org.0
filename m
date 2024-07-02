Return-Path: <linux-pci+bounces-9554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC18A91EEBF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 08:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0B8B20F67
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736F5821A;
	Tue,  2 Jul 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyatEopa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA76F17;
	Tue,  2 Jul 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900305; cv=none; b=YqAUBv6817hfaCFd+Uxn1o0CJJfJvZ+c3qWm5fhYwE37bx7zFvPw72YUhrT27GqBXzC8aQ0TN7jYTuzVevqZr0RwZzw/eXprKQXBaNE4kU5SXqJaMuTAxU3qqfb4cYgfP703cQ3shSgHuUqeDupQAyL2QbThZfjd6ihhXD/5TKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900305; c=relaxed/simple;
	bh=7gLoiQaheyOASUObEPOweTpdS0YPBYzAdvY3uQH5E08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5Dz4A/D6NXXEHSm0PvP/mYWjXGS1j3+z0y99skZglVcwCiqntSVeKvmPJj4S0DbX1ZXCmY2hukWEUht1jvhrvJZPJ81wP98/NnpGyLxlE79jZcoCydJnEc4Q5ZE89PiWFyrQ0IvIFOTq4K0Xm+BTSQkGRxfMrOQbqZMKMWeyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyatEopa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so27058565ad.1;
        Mon, 01 Jul 2024 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719900303; x=1720505103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSf3rl2yEsfnEGBe3PL6PrYi1SxdyQnECve6feZibF0=;
        b=FyatEopaJllHZWEUjMbJ/wf5xvYFDa8tJRD/oJ4E8LzyYqbw3CkIU659qtdgoTQUBa
         ovwKb2Y73Ma858tp2bBPt+hwfetr05Xc0pR6qiQYcMbO3TgqmANI2PSh/Rupb5dTiIWK
         TEkUFWlUt1Cb6XJ7xPg9wUn77oDwuf+CdG24rveROkN8C3FaeqhXDYeJRfOk1Xf/HusO
         b8Yk9BaVF6ltsrW11W41vGOZZZH4EShRv6DGX16FHdGN+XnHIV1icZF1qtEQyGXGfQz3
         1d/mF39Qa9PGQ3A9E9G3izhbErOWxhdL9V3IqGAMAMXgmKjfSo58sg9u0857Dr6x/vVS
         LGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719900303; x=1720505103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSf3rl2yEsfnEGBe3PL6PrYi1SxdyQnECve6feZibF0=;
        b=V3h9uP1hgohQJs7pDK/pXLJ6sMkGPYIZO8aEjOWQ6pTybJ6Z/C2OXG2kq0cyJkLzKC
         hJQKenLXLlsDcNrWM41j1RuRubxLZANKqKwR+BIeOR43jXjB1Jtg2l/Hm7HWY2I3zWx4
         8P2NvbMS/WQw+Ms+ZZB8ZrfFESNVbR8EKrOFBK5H2MLfY85m8XnxmSfZIa0szXS1rR2z
         J+nB3cn6nWjIB00G/2N7GoUO3TW9H2Z0kOhKMWXbSxtftiHoFveEg7Tg+8SSuJWpYtpx
         vKBfQvcDIpB7EO4kXP7zGfOO1dEarWTz97SbL23qnUwWfRM812YlNVWx7l6yfyyWQVY9
         TNUA==
X-Forwarded-Encrypted: i=1; AJvYcCXp8du8kTmMsfAXtOP92M2SjnZAGpRFxgSIZi7r6wCOXQ4uzruYPat1cLD7lIReM/1FZR2LY6ePgAgJmlqW5GgOuuysrjXs0sHZaHlw41djyv13LNz3+ppyzjytq1cUr3TSXUBhfJW9
X-Gm-Message-State: AOJu0YxmvLKhOkO/eSU35M9snxRZQnKx9e4w2kfFGgTPHPd0jt19uT0R
	1+luWp4gECu80TJoEhBftXP792aoNwPQbGzLqbXi2BreGOfg/8JU
X-Google-Smtp-Source: AGHT+IFPTqBU3HOHLkC0a2mMJL+lxRZ+QCT1ipfUxnjKbha7eU8zSiZhVz1skKU3JbBGUxKRYu/I1A==
X-Received: by 2002:a17:902:ecc1:b0:1f9:d577:f532 with SMTP id d9443c01a7336-1fac7f1b463mr189828245ad.28.1719900302717;
        Mon, 01 Jul 2024 23:05:02 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d23edsm75484225ad.58.2024.07.01.23.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:05:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Date: Tue,  2 Jul 2024 16:04:17 +1000
Message-ID: <20240702060418.387500-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702060418.387500-1-alistair.francis@wdc.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
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
PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
information about the other DOE features supported by the device.

The kernel is already querying the DOE features supported and cacheing
the values. Expose the values in sysfs to allow user space to
determine which DOE features are supported by the PCIe device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported features we can
allow userspace to parse the list, which might include
vendor specific features as well as yet to be supported features.

After this patch is supported you can see something like this when
attaching a DOE device

$ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
0001:00        0001:01        0001:02

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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

 Documentation/ABI/testing/sysfs-bus-pci |  28 ++++++
 drivers/pci/doe.c                       | 109 +++++++++++++++++++++++-
 drivers/pci/pci-sysfs.c                 |   4 +
 drivers/pci/pci.h                       |   2 +
 4 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..e1b8f15e4a3a 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,31 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		July 2024
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The feature values are
+		the file name. The contents of each file is the raw vendor id and
+		data object feature values, the same as the name.
+
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower (RHS of the colon) is
+		the data object type in hex. The upper (LHS of the colon)
+		is the vendor ID.
+
+		As all DOE devices must support the DOE discovery protocol, if
+		DOE is supported you will at least see this file, with
+		this contents
+
+		# cat doe_features/0001:00
+		0001:00
+
+		If the device supports other protocols you will see other files
+		as well. For example is CMA/SPDM and secure CMA/SPDM are supported
+		the doe_features directory will look like this
+
+		# ls doe_features
+		0001:00        0001:01        0001:02
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index defc4be81bd4..e7b702afce88 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -14,6 +14,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -47,6 +48,8 @@
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
+ * @device_attrs: Array of device attributes, used in cleanup
+ * @sysfs_attrs: Array of sysfs attributes, used in cleanup
  */
 struct pci_doe_mb {
 	struct pci_dev *pdev;
@@ -56,6 +59,11 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+#ifdef CONFIG_SYSFS
+	struct device_attribute *device_attrs;
+	struct attribute **sysfs_attrs;
+#endif
 };
 
 struct pci_doe_feature {
@@ -92,6 +100,58 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		if (!xa_empty(&doe_mb->feats))
+			return true;
+	}
+
+	return false;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
+
+struct attribute_group pci_doe_sysfs_group = {
+	.name	    = "doe_features",
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
+	struct device_attribute *attrs = doe_mb->device_attrs;
+	struct attribute **sysfs_attrs = doe_mb->sysfs_attrs;
+	unsigned long i;
+	void *entry;
+
+	if (!attrs)
+		return;
+
+	doe_mb->device_attrs = NULL;
+	doe_mb->sysfs_attrs = NULL;
+
+	xa_for_each(&doe_mb->feats, i, entry) {
+		if (attrs[i].attr.name)
+			kfree(attrs[i].attr.name);
+	}
+
+	kfree(attrs);
+	kfree(sysfs_attrs);
+}
+#endif
+
 static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
 {
 	if (wait_event_timeout(doe_mb->wq,
@@ -687,6 +747,12 @@ void pci_doe_init(struct pci_dev *pdev)
 {
 	struct pci_doe_mb *doe_mb;
 	u16 offset = 0;
+	struct attribute **sysfs_attrs;
+	struct device_attribute *attrs;
+	unsigned long num_features = 0;
+	unsigned long i;
+	unsigned long vid, type;
+	void *entry;
 	int rc;
 
 	xa_init(&pdev->doe_mbs);
@@ -707,6 +773,45 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_doe_destroy_mb(doe_mb);
 		}
 	}
+
+	if (doe_mb) {
+		xa_for_each(&doe_mb->feats, i, entry)
+			num_features++;
+
+		sysfs_attrs = kcalloc(num_features + 1, sizeof(*sysfs_attrs), GFP_KERNEL);
+		if (!sysfs_attrs)
+			return;
+
+		attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
+		if (!attrs) {
+			kfree(sysfs_attrs);
+			return;
+		}
+
+		doe_mb->device_attrs = attrs;
+		doe_mb->sysfs_attrs = sysfs_attrs;
+
+		xa_for_each(&doe_mb->feats, i, entry) {
+			sysfs_attr_init(&attrs[i].attr);
+
+			vid = xa_to_value(entry) >> 8;
+			type = xa_to_value(entry) & 0xFF;
+
+			attrs[i].attr.name = kasprintf(GFP_KERNEL, "%04lx:%02lx", vid, type);
+			if (!attrs[i].attr.name) {
+				pci_doe_sysfs_feature_remove(pdev, doe_mb);
+				return;
+			}
+			attrs[i].attr.mode = 0444;
+			attrs[i].show = pci_doe_sysfs_feature_show;
+
+			sysfs_attrs[i] = &attrs[i].attr;
+		}
+
+		sysfs_attrs[num_features] = NULL;
+
+		pci_doe_sysfs_group.attrs = sysfs_attrs;
+	}
 }
 
 void pci_doe_destroy(struct pci_dev *pdev)
@@ -714,8 +819,10 @@ void pci_doe_destroy(struct pci_dev *pdev)
 	struct pci_doe_mb *doe_mb;
 	unsigned long index;
 
-	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		pci_doe_sysfs_feature_remove(pdev, doe_mb);
 		pci_doe_destroy_mb(doe_mb);
+	}
 
 	xa_destroy(&pdev->doe_mbs);
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..cd838b85d6ab 100644
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
@@ -1661,6 +1662,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
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
index fd44565c4756..a26c586cdeb4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -189,6 +189,7 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct attribute_group *pci_bus_groups[];
+extern struct attribute_group pci_doe_sysfs_group;
 #else
 static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
 static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
@@ -196,6 +197,7 @@ static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #define pci_dev_attr_groups NULL
 #define pcibus_groups NULL
 #define pci_bus_groups NULL
+#define pci_doe_sysfs_group NULL
 #endif
 
 extern unsigned long pci_hotplug_io_size;
-- 
2.45.2


