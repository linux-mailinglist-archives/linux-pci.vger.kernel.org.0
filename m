Return-Path: <linux-pci+bounces-38527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBEBEC1BA
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 02:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4046E1AA8483
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B51C8606;
	Sat, 18 Oct 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2oa+Ok0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357A1ADC93
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746060; cv=none; b=bI4K34dEhzy0oUThSdIx4tkgAR9YgglXT9Ax20ER0oRsMZu/Id7Q5v9SrNHvKs0NcCDitxjuQPcl0jxIgJttlv4VzosMeIccRu35jC2ifXCcXKJIU/INlA4vBnfATltgChM1kK8ob7LV+afCR9ZBetRrIMilRGC+Gx6sAeMuLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746060; c=relaxed/simple;
	bh=5Tvh5T5jgvY1ILBJN58+80uZX1/0HkAVQpK1u+wobjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/aX2s57QAkdIBuc0HPGuPgmpAKCgNPeeCR4qrcUAf7MVNcBEHmLOgPyjttdPcJDDsdxueDoUZUIIWovidMjDoJ/h11F+zrXX+6vyLyGdkw4sXDJj2CxZzRdkBcj7daHhPOTCY0HDxD/hR9QMX+yfaCB5MAHtWh+6aK/O7kxZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2oa+Ok0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-332560b7171so3204785a91.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746057; x=1761350857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvhaOW8wRH/YY3gXapCStWhtrT1s7EfXHsuUhL9CnVU=;
        b=q2oa+Ok0n6FK/5Q/NrhbtNSlRpaybu1FmnWWJG5xwMWvEHfaMkBoQTEPwa1AlHZYqs
         cWiennp336Cv1nwGX1uKsyvUWlRlehg7Mc3ytvYU2jNVMlvX5DKCoZIyYEIjpH6+GaxN
         dCm+8PfMgnii/Yacak9i+x5A3HyobcVvbVebK5yjYVk5zJdX225dOm4qULs/uvULJtU9
         GNW0OYhoUJSQSeZ0gedrKN6byn/T20mPE5iPxXLtHBRhhA5MJL7zm4gA9y0qDzrs0zog
         Eknx3w6MssRYFyjJAUYMIHNA6fYeYmCRN1GEGvjVR4B7YbYyVesey+1KkVBaIJVCXsb8
         tq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746057; x=1761350857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvhaOW8wRH/YY3gXapCStWhtrT1s7EfXHsuUhL9CnVU=;
        b=tPvlJ0rxC7sN/t+yGEnq/PZhpNr3oVFp5Ew+uVv2t5DI7RN3SUEM4GKSA16kCM5QHw
         bsnNP4v8ziqjnyWruNGs+NJWfcQAvSVhiimHjgMFNXVEhpuvqN9LY9RGMkQnSoXPTGR/
         iLAQzOCQjbphTJ3pKQR7P1K4DX/vwqSULGR//8xPj6ubu13kq0tDJhqtmVd9RBoSGlah
         0JyYjRh5qPCJlGy0KfvM+AsSQbWZ+hZ2dbGLduRmlnrE9YZT7ELASfqCvvIAaAmo8v0R
         HUsMD/YkvDPAHq+M22N84I0klPI5NE8noJuJb5KoFnssrw5mXtQv/QBBwFEpK/YhZJpx
         vo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgIK3XDLJdArX7sCvuDppOFXwrMDJmFKgIf/bJSTmZoJrFgnvmeV3hJycwBjtSO6s+UhqoDQYx+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBETaVZTdSiXNTKIbBfy/fPV3gKNRmW/wGDghQgUTJQBbCY5Z0
	PNTnUTogAfK3ep3VR2yadSvEKa322uCQveafpPBrF63MNVsq9cY5LFCXYa6RZ9X7JxObWZIG3L0
	KQevYpeLwrg==
X-Google-Smtp-Source: AGHT+IEajdXrHklRoghqoCMeB0s0/wpRhkS0+hlDw6WmAOENbeivy0YrxeuPlRkhdT/oRdtLhvut8dPK/58W
X-Received: from pjbtd12.prod.google.com ([2002:a17:90b:544c:b0:330:b9e9:7acc])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ecb:b0:32e:72bd:6d5a
 with SMTP id 98e67ed59e1d1-33bc9b77679mr6907875a91.1.1760746057054; Fri, 17
 Oct 2025 17:07:37 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:00 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-9-vipinsh@google.com>
Subject: [RFC PATCH 08/21] vfio/pci: Retrieve preserved VFIO device for Live
 Update Orechestrator
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Retrieve VFIO device in the retrieve() callback of the LUO file handler.
Deserialize the KHO data and search in the VFIO cdev class for device
matching the BDF. Export needed functions from core VFIO module to
others.

Create anonymous inode and file struct for the device. This is similar
to how VFIO group returns VFIO device FD. This is different than VFIO
cdev where cdev device is connected to inode and file on devtempfs.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 67 +++++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 17 +++++++
 include/linux/vfio.h                   |  6 +++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 3eb4895ce475..cb3ff097afbf 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -10,7 +10,9 @@
 #include <linux/liveupdate.h>
 #include <linux/vfio.h>
 #include <linux/errno.h>
+#include <linux/anon_inodes.h>
 #include <linux/kexec_handover.h>
+#include <linux/file.h>
 
 #include "vfio_pci_priv.h"
 
@@ -70,10 +72,73 @@ static void vfio_pci_liveupdate_cancel(struct liveupdate_file_handler *handler,
 	folio_put(folio);
 }
 
+static int match_bdf(struct device *device, const void *bdf)
+{
+	struct vfio_device *core_vdev =
+		container_of(device, struct vfio_device, device);
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	return *(u16 *)bdf == pci_dev_id(vdev->pdev);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 					u64 data, struct file **file)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device_file *df;
+	struct vfio_device *device;
+	struct folio *folio;
+	struct file *filep;
+	int err;
+
+	folio = kho_restore_folio(data);
+	if (!folio)
+		return -ENOENT;
+
+	ser = folio_address(folio);
+	device = vfio_find_device_in_cdev_class(&ser->bdf, match_bdf);
+	if (!device)
+		return -ENODEV;
+
+	df = vfio_allocate_device_file(device);
+	if (IS_ERR(df)) {
+		err = PTR_ERR(df);
+		goto err_vfio_device_file;
+	}
+
+	filep = anon_inode_getfile_fmode("[vfio-cdev]", &vfio_device_fops, df,
+					 O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+	if (IS_ERR(filep)) {
+		err = PTR_ERR(filep);
+		goto err_anon_inode;
+	}
+
+	/* Paired with the put in vfio_device_fops_release() */
+	if (!vfio_device_try_get_registration(device)) {
+		err = -ENODEV;
+		goto err_get_registration;
+	}
+
+	put_device(&device->device);
+
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+	*file = filep;
+
+	return 0;
+
+err_get_registration:
+	fput(filep);
+err_anon_inode:
+	kfree(df);
+err_vfio_device_file:
+	put_device(&device->device);
+	return err;
 }
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 4cb47c1564f4..90ecb3544f79 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -177,6 +178,7 @@ bool vfio_device_try_get_registration(struct vfio_device *device)
 {
 	return refcount_inc_not_zero(&device->refcount);
 }
+EXPORT_SYMBOL_GPL(vfio_device_try_get_registration);
 
 /*
  * VFIO driver API
@@ -502,6 +504,7 @@ vfio_allocate_device_file(struct vfio_device *device)
 
 	return df;
 }
+EXPORT_SYMBOL_GPL(vfio_allocate_device_file);
 
 static int vfio_df_device_first_open(struct vfio_device_file *df)
 {
@@ -1385,6 +1388,7 @@ const struct file_operations vfio_device_fops = {
 	.show_fdinfo	= vfio_device_show_fdinfo,
 #endif
 };
+EXPORT_SYMBOL_GPL(vfio_device_fops);
 
 struct vfio_device *vfio_device_from_file(struct file *file)
 {
@@ -1716,6 +1720,19 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device *vfio_find_device_in_cdev_class(const void *data,
+						   device_match_t match)
+{
+	struct device *device = class_find_device(vfio.device_class, NULL, data,
+						  match);
+
+	if (!device)
+		return NULL;
+
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device_in_cdev_class);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 2443d24aa237..f98802facb24 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -386,5 +386,11 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 struct vfio_device *vfio_device_from_file(struct file *file);
+struct vfio_device *vfio_find_device_in_cdev_class(const void *data,
+						   device_match_t match);
+bool vfio_device_try_get_registration(struct vfio_device *device);
+struct vfio_device_file *vfio_allocate_device_file(struct vfio_device *device);
+
+extern const struct file_operations vfio_device_fops;
 
 #endif /* VFIO_H */
-- 
2.51.0.858.gf9c4a03a3a-goog


