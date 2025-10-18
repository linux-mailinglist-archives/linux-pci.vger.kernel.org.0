Return-Path: <linux-pci+bounces-38535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DDBEC202
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B06E35606D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E7239E88;
	Sat, 18 Oct 2025 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3ieYWUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954083597B
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746074; cv=none; b=YzQTopKYK7EpFLj0lwkQZBUVaVmVsJBpHOEYdOi5VlbrTGBGRuxxwebQERU4u4ZYEtFWyaNHcsl9OH1tyD62ZHFFaBO/OoUs4pcczrhOwgjsTPfdx5AzqPlinQ7GmmMaEtBwiS0htILch6Ooat7DEHKQDCHVMH6Nhg7IrkWfd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746074; c=relaxed/simple;
	bh=y0+6jsiefYgVNtwktGfAYBPXPBYUey5C8nH+I/Fgc2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B569jvDtaGflLk/AmaoJfQg7FIxoyGJsVa4Hv2tmpJmnZC+DaK9QeEIgFv+hKT8RHln64Ji6SPepT/E1BmgTulk5dwhT+Y9c9Mt2ytcECOJJH8Mlz9fly6FadsPrX2icl5NL6aIKT5ge68a6UMzkcQEq1EEQy1nSpoldpQH8j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3ieYWUf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so4146438a91.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746071; x=1761350871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CbwykVnnO5WGgcAhFzYYL9mNJY9ZB8LleHTuq5Utvo=;
        b=N3ieYWUfLZN3inej6Ctduj465w91ws+70Ru5mnbpluBW++m/wrXyvIx4Txt9KzsyhV
         YGYuxsKL6wVB8LuOGThs/yrQWoYtZl8cvLAvr5Y34LFcgKWdyE7IjBmv8BSs6EBkh3ii
         RVycEG3pfDWgUOF/1FFe5x13Aw4ezIBPfysOC5qkvkKAgTEeXC3Z+skYD4XLJ2kuiwmS
         d5OjnYTZLdUJ5Q0M4yypKweCr0IY781UG2dC4N0hu0nxVg5r/NkQc/sIBolMYqkbw8pg
         aeZOkdGsD1NWoN6MreT6UYYrDgd0Y+T2D6QsQFdkt7iIbJKwVhs2dLBYF6DtQc+FvKBi
         90yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746071; x=1761350871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CbwykVnnO5WGgcAhFzYYL9mNJY9ZB8LleHTuq5Utvo=;
        b=Y2dGWj8cLZAZRv4zHEFYAcgfcCA/+LQm/FvG6jtTFmaJaoWU2xeYu4C8hMKvwoVg6O
         O4+16ZjTIxi/o1Kjo4HpguF/mXodqjwbWKASFgCBYhlVFX1KOv6zCSLOLD5jgXeKGGmw
         FhpdR1/dsRT05ExG1ovl+w0WO3x2zhWM6b56d2C61Yy5A0HeXl/octC0BwEOSGdki9tC
         UaDaKc9B469BSKKGsE9N6nuJ+cmHevh4EofRAVjSjmHgeaaA3Hd9ZgmYS8b8k0/OzzUh
         ErAYBVY8S44yTC/b3g1cSswVxv3+MTz2s5b24LZbd4E4B2FEiLcXKZ3ezqYJHvSH9zFo
         fICw==
X-Forwarded-Encrypted: i=1; AJvYcCUwguzNYOrw17SSOM8PX7KLqur90H1WbgmMLsxtHDkczlG8hPufuK1zWaqWyY7JQSFR8lt0RJBrH68=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEhPOiHo/zdmZnUQMs5rTUhq0z2UZxzZQ6DpKI9JmU1heIgbP
	FMkD53ruK8JRPq74jD71GL8xm4drNn8pf6PsUW4cdQiZn3UnEGkFYz6RevM7rJZylyriy01QrPQ
	yO603WA8fkg==
X-Google-Smtp-Source: AGHT+IFMgZVeb9mt8dds2cE993nNkSHGV/KAwWVuJR54LKVkodlfrIYg7s5lP+pcO3rzGvu6Y5VBl5u6GxQm
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:32d:e4c6:7410])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:44:b0:32b:623d:ee91
 with SMTP id 98e67ed59e1d1-33bcf8fd82dmr6257978a91.27.1760746070877; Fri, 17
 Oct 2025 17:07:50 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:08 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-17-vipinsh@google.com>
Subject: [RFC PATCH 16/21] vfio/pci: Save and restore the PCI state of the
 VFIO device
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

Save and restore the PCI state of the VFIO device which in the normal
flow is recorded by VFIO when the device FD is opened for the first time
and then reapplied to PCI device when the last opened device FD is
closed.

Introduce "_ser" version of the struct pci_saved_state{} and struct
pci_cap_saved_data{} to serialized saved PCI state for liveupdate. Store
PCI state in VFIO in a separate folio as the size is indeterministic at
build time to reserve space in struct vfio_pci_core_device_ser{}.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |   9 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 176 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |   8 +-
 3 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 186a669b68a4..44ea3ac8da16 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -487,7 +487,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_power;
 
 	if (vdev->liveupdate_restore) {
-		vfio_pci_liveupdate_restore_device(vdev);
+		ret = vfio_pci_liveupdate_restore_device(vdev);
+		if (ret)
+			goto out_disable_device;
 	} else {
 		/* If reset fails because of the device lock, fail this path entirely */
 		ret = pci_try_reset_function(pdev);
@@ -495,10 +497,11 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			goto out_disable_device;
 
 		vdev->reset_works = !ret;
+
+		pci_save_state(pdev);
+		vdev->pci_saved_state = pci_store_saved_state(pdev);
 	}
 
-	pci_save_state(pdev);
-	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
 		pci_dbg(pdev, "%s: Couldn't store saved state\n", __func__);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 82ff9f178fdc..caef023d007a 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -13,9 +13,22 @@
 #include <linux/anon_inodes.h>
 #include <linux/kexec_handover.h>
 #include <linux/file.h>
+#include <linux/pci.h>
 
 #include "vfio_pci_priv.h"
 
+struct pci_cap_saved_data_ser {
+	u16		cap_nr;
+	bool		cap_extended;
+	unsigned int	size;
+	u32		data[];
+} __packed;
+
+struct pci_saved_state_ser {
+	u32 config_space[16];
+	struct pci_cap_saved_data_ser cap[];
+} __packed;
+
 struct vfio_pci_core_device_ser {
 	u16 bdf;
 	u32 cfg_size;
@@ -23,6 +36,7 @@ struct vfio_pci_core_device_ser {
 	u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
 	u32 rbar[7];
 	u8 reset_works;
+	u64 pci_saved_state_phys;
 } __packed;
 
 static int vfio_pci_liveupdate_deserialize_config(struct vfio_pci_core_device *vdev,
@@ -51,12 +65,150 @@ static void vfio_pci_liveupdate_serialize_config(struct vfio_pci_core_device *vd
 	memcpy(ser->rbar, vdev->rbar, sizeof(vdev->rbar));
 }
 
+static size_t pci_saved_state_size(struct pci_saved_state *state)
+{
+	struct pci_cap_saved_data *cap;
+	size_t size;
+
+	/* One empty cap to denote end. */
+	size = sizeof(struct pci_saved_state) + sizeof(struct pci_cap_saved_data);
+
+	cap = state->cap;
+	while (cap->size) {
+		size_t len = sizeof(struct pci_cap_saved_data) + cap->size;
+
+		size += len;
+		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
+	}
+
+	return size;
+}
+
+static size_t pci_saved_state_size_from_ser(struct pci_saved_state_ser *state)
+{
+	struct pci_cap_saved_data_ser *cap;
+	size_t size;
+
+	/* One empty cap to denote end. */
+	size = sizeof(struct pci_saved_state) + sizeof(struct pci_cap_saved_data);
+
+	cap = state->cap;
+	while (cap->size) {
+		size_t len = sizeof(struct pci_cap_saved_data) + cap->size;
+
+		size += len;
+		cap = (struct pci_cap_saved_data_ser *)((u8 *)cap + len);
+	}
+
+	return size;
+}
+
+static void serialize_pci_cap_saved_data(struct pci_saved_state *state,
+					 struct pci_saved_state_ser *state_ser)
+{
+	struct pci_cap_saved_data_ser *cap_ser = state_ser->cap;
+	struct pci_cap_saved_data *cap = state->cap;
+
+	while (cap->size) {
+		cap_ser->cap_nr = cap->cap_nr;
+		cap_ser->cap_extended = cap->cap_extended;
+		cap_ser->size = cap->size;
+		memcpy(cap_ser->data, cap->data, cap_ser->size);
+
+		cap = (void *)cap + sizeof(*cap) + cap->size;
+		cap_ser = (void *)cap_ser + sizeof(*cap_ser) + cap_ser->size;
+	}
+}
+
+static void deserialize_pci_cap_saved_data(struct pci_saved_state *state,
+					   struct pci_saved_state_ser *state_ser)
+{
+	struct pci_cap_saved_data_ser *cap_ser = state_ser->cap;
+	struct pci_cap_saved_data *cap = state->cap;
+
+	while (cap_ser->size) {
+		cap->cap_nr = cap_ser->cap_nr;
+		cap->cap_extended = cap_ser->cap_extended;
+		cap->size = cap_ser->size;
+		memcpy(cap->data, cap_ser->data, cap_ser->size);
+
+		cap = (void *)cap + sizeof(*cap) + cap->size;
+		cap_ser = (void *)cap_ser + sizeof(*cap_ser) + cap_ser->size;
+	}
+}
+
+static int serialize_pci_saved_state(struct vfio_pci_core_device *vdev,
+				     struct vfio_pci_core_device_ser *ser)
+{
+	struct pci_saved_state *state = vdev->pci_saved_state;
+	struct pci_saved_state_ser *state_ser;
+	struct folio *folio;
+	size_t size;
+	int ret;
+
+	if (!state)
+		return 0;
+
+	size = pci_saved_state_size(state);
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(size));
+	if (!folio)
+		return -ENOMEM;
+
+	state_ser = folio_address(folio);
+
+	memcpy(state_ser->config_space, state->config_space,
+	       sizeof(state_ser->config_space));
+
+	serialize_pci_cap_saved_data(state, state_ser);
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		folio_put(folio);
+		return ret;
+	}
+
+	ser->pci_saved_state_phys = virt_to_phys(state_ser);
+
+	return 0;
+}
+
+static int deserialize_pci_saved_state(struct vfio_pci_core_device *vdev,
+				       struct vfio_pci_core_device_ser *ser)
+{
+	struct pci_saved_state_ser *state_ser;
+	struct pci_saved_state *state;
+	size_t size;
+
+	if (!ser->pci_saved_state_phys)
+		return 0;
+
+	state_ser = phys_to_virt(ser->pci_saved_state_phys);
+	size = pci_saved_state_size_from_ser(state_ser);
+	state = kzalloc(size, GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	memcpy(state->config_space, state_ser->config_space,
+	       sizeof(state_ser->config_space));
+
+	deserialize_pci_cap_saved_data(state, state_ser);
+	vdev->pci_saved_state = state;
+	return 0;
+}
+
 static int vfio_pci_lu_serialize(struct vfio_pci_core_device *vdev,
 				 struct vfio_pci_core_device_ser *ser)
 {
+	int err;
+
 	ser->bdf = pci_dev_id(vdev->pdev);
 	vfio_pci_liveupdate_serialize_config(vdev, ser);
 	ser->reset_works = vdev->reset_works;
+	err = serialize_pci_saved_state(vdev, ser);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -101,12 +253,18 @@ static void vfio_pci_liveupdate_cancel(struct liveupdate_file_handler *handler,
 {
 	struct vfio_pci_core_device_ser *ser = phys_to_virt(data);
 	struct folio *folio = virt_to_folio(ser);
+	struct folio *pci_saved_state_folio;
 	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 
 	device = vfio_device_from_file(file);
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	vdev->pdev->skip_kexec_clear_master = false;
+	if (ser->pci_saved_state_phys) {
+		pci_saved_state_folio = virt_to_folio(phys_to_virt(ser->pci_saved_state_phys));
+		WARN_ON_ONCE(kho_unpreserve_folio(pci_saved_state_folio));
+		folio_put(pci_saved_state_folio);
+	}
 	WARN_ON_ONCE(kho_unpreserve_folio(folio));
 	folio_put(folio);
 }
@@ -139,6 +297,9 @@ static void vfio_pci_liveupdate_finish(struct liveupdate_file_handler *handler,
 
 	ser = folio_address(folio);
 
+	if (!reclaimed && ser->pci_saved_state_phys)
+		kho_restore_folio(ser->pci_saved_state_phys);
+
 	device = vfio_find_device_in_cdev_class(&ser->bdf, match_bdf);
 	if (!device)
 		goto out_folio_put;
@@ -155,6 +316,8 @@ static void vfio_pci_liveupdate_finish(struct liveupdate_file_handler *handler,
 	put_device(&device->device);
 
 out_folio_put:
+	if (ser->pci_saved_state_phys)
+		folio_put(virt_to_folio(phys_to_virt(ser->pci_saved_state_phys)));
 	folio_put(folio);
 }
 
@@ -174,6 +337,11 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 		return -ENOENT;
 
 	ser = folio_address(folio);
+	if (ser->pci_saved_state_phys) {
+		if (!kho_restore_folio(ser->pci_saved_state_phys))
+			return -ENOENT;
+	}
+
 	device = vfio_find_device_in_cdev_class(&ser->bdf, match_bdf);
 	if (!device)
 		return -ENODEV;
@@ -262,9 +430,15 @@ int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
 	return vfio_pci_liveupdate_deserialize_config(vdev, ser);
 }
 
-void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
+int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_pci_core_device_ser *ser = vdev->liveupdate_restore;
+	int err;
+
+	err = deserialize_pci_saved_state(vdev, ser);
+	if (err)
+		return err;
 
 	vdev->reset_works = ser->reset_works;
+	return 0;
 }
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index ee1c7c229020..9d692e4d0cf7 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -110,14 +110,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 #ifdef CONFIG_LIVEUPDATE
 void vfio_pci_liveupdate_init(void);
 int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
-void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
+int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
 #else
 static inline void vfio_pci_liveupdate_init(void) { }
 int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
 {
 	return -EINVAL;
 }
-void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev) { }
+int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 
 #endif
-- 
2.51.0.858.gf9c4a03a3a-goog


