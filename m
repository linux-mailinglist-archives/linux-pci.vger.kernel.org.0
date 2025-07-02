Return-Path: <linux-pci+bounces-31219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A9AF0C5C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208D316D227
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B321C187;
	Wed,  2 Jul 2025 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3CYVokh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AC32C85
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440712; cv=none; b=Px5kKJvCl3oNcND7xJe5D2DcrtIw3wuh+8gcYYsqqQN7sgb/+t6hoZWcr9vamBp9Zq66OxkDty1Ac8ElyoSeda58vFVa6Uq5g120WV+B43KOp+VnxXoR3My2Ae/9K8ExXGOR1iL5S6mI2e/aYYGOM/P/lU6ZXl7TseZlOi+oJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440712; c=relaxed/simple;
	bh=k5Pd5/BIT83oP2t67VS64bMxvicsmjY5oVQ9b3JJ47U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TAzpfp1X+y9NJ/rLacNM5A1S02b63HQGal5rx5g/2Rl0AapGxk+P1p6FiftKy9dC2NfwHW2lyRCctEpQ6xFVKzOVsYJPvBp0XrQFo0Y2BUcQF6j1jdqG86/YbfnqINiiWAl0jQ1AumLPe56bDd0dJUgVctiH19jw3mhnk1qrb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3CYVokh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751440709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=inET1q5pbqhm6lRPNe+Ci3JjHAH+Px1CXV3xfjQhwa4=;
	b=H3CYVokhpL9VT0XEu5uuJn8Abi9cSKu+DwBaGmB8ecR4SDXtM5SlDbAh6kNlIZ+jiBltF9
	9jvLrwVCvKqhPbBj9py7D9fy9oKuEvP3RO06a/AfYD703GGVde47L06mNISGigQvsUaJts
	HzbwHCPUc6rYIOQi9R8jKNzant62bjI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86--48MGR8jMYud0sDIKbZFow-1; Wed, 02 Jul 2025 03:18:28 -0400
X-MC-Unique: -48MGR8jMYud0sDIKbZFow-1
X-Mimecast-MFC-AGG-ID: -48MGR8jMYud0sDIKbZFow_1751440707
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so33424095e9.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 00:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440706; x=1752045506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inET1q5pbqhm6lRPNe+Ci3JjHAH+Px1CXV3xfjQhwa4=;
        b=TdAyS2cUq9pzW3lw1E5PwizWj+8kN1H7CYtABcf8S+WXBqU09G+RL3LwQYvTsNC0+6
         KE+yt1BnZwZi7yIb3P8eW5GCT4oFID0l5sg3aAxj8cTDmDs8ePoVjkztn2AZ0xMiTeOv
         kB70hukRmF4vmvywWyU50l71rWR0hfCETQ3fW1G6mgsm0Xpc2gytmrOtN38bGFuHP2yF
         laR83bvObtA8FP7w0A0GnLvW8uKWXZCGeFrEt83Uhma4AScl29N+2PbcMctrk4j6h9zy
         3xNBC9wAUazbel6pL4BoN87B7s7kBCO2/NmPBhsP/ELysg9f36++ulA+ynZTuaE0VLiW
         HQHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmmCFpn+bo431USJ8kDTGPxJxJOxKat03pdq5zAcuvUKSrcdkAOXGHRJgM7alAKobxLGxE0CzqYG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJJFTz1cmSxnEON/qiC43JvYxRg7maOq1mCoygg49lwtro1E/
	Y07QVqVgXgAOUeCn/GvYwhq2oSbSpuhC22Rr5+UtnxWFKvS72Vk4fO7UobJvspFL/6VUmIRCDWo
	1UHWXLpqBpIvoaO4aw9hED+sDdiQv0pjcIkPGEcsWNAhQjW9FcJUf/WAmz0VYGyEOqlelVA==
X-Gm-Gg: ASbGncvHr4Cbpg2cZXO1Mb+qtnOD1QYMcA6V2g2pLpvY4y83qthl3mhnc0V0grJEmZy
	q8Kzdv+uWnT+D88wy7nbFa2pOt1XusPTJujdkSdryafD/mveh5oBzINVEF4ynj/rrlQQfcmtEZo
	8p9vGB3Mt+Jb6r6+qn0f/vOPV+lG95p4mtGnxuZCAjAYpQFv+C0v+Lg5G3CKKfIpvaryVW3NxZ3
	FrpITxCz0tjtr5HQvlp+8poIcAWwg3K7tn1BWfijBXyH4mXNufVfc1oTFDVgkBbUgJ1elQ+EEz4
	U5HaTHXXSE2925a9
X-Received: by 2002:a05:6000:4024:b0:3a6:c95c:36c5 with SMTP id ffacd0b85a97d-3b2000adbb6mr945490f8f.40.1751440706387;
        Wed, 02 Jul 2025 00:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtz/thPUHxhYk90GD/Wy++u6+yzW285TGChfF0pNKmL94IYhOgQu6evHruei6E5XylsiguYw==
X-Received: by 2002:a05:6000:4024:b0:3a6:c95c:36c5 with SMTP id ffacd0b85a97d-3b2000adbb6mr945455f8f.40.1751440705783;
        Wed, 02 Jul 2025 00:18:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a306a01sm198832195e9.0.2025.07.02.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:18:25 -0700 (PDT)
Date: Wed, 2 Jul 2025 03:18:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC v2] pci: report surprise removal event
Message-ID: <fde33b657c510970342905dfec62328d46036bb7.1751440544.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

At the moment, in case of a surprise removal, the regular remove
callback is invoked, exclusively.  This works well, because mostly, the
cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup and
is now waiting for an interrupt from the device. If the device is now
surprise-removed, that never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

	1. the graceful removal is ongoing in the remove() callback, where disk
	   deletion del_gendisk() is ongoing, which waits for the requests +to
	   complete,

	2. Now few requests are yet to complete, and surprise removal started.

	At this point, virtio block driver will not get notified by the driver
	core layer, because it is likely serializing remove() happening by
	+user/driver unload and PCI hotplug driver-initiated device removal.  So
	vblk driver doesn't know that device is removed, block layer is waiting
	for requests completions to arrive which it never gets.  So
	del_gendisk() gets stuck.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that the
device is inactive.

Since cleanups can take a long time, this takes an approach
of a work struct that the driver initiates and enables
on probe, and tears down on remove.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Compile tested only.

Note: this minimizes core code. I considered a more elaborate API
that would be easier to use, but decided to be conservative until
there are multiple users.

changes from v1:
	switched to a WQ, with APIs to enable/disable
	added motivation


 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..208b4cab534b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	if (READ_ONCE(dev->disconnect_work_enable)) {
+		/* Make sure work is up to date. */
+		smp_rmb();
+		schedule_work(&dev->disconnect_work);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..b308d2149bba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -550,6 +550,10 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	/* Report disconnect events */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */
@@ -2646,17 +2650,44 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 /* Helper functions for operation of device flag */
 static inline void pci_set_dev_assigned(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
 }
 static inline void pci_clear_dev_assigned(struct pci_dev *pdev)
 {
 	pdev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
 }
 static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 {
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
 
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * Caller also must check pci_device_is_present afterwards, since
+ * if device is already gone when this is called, work will not run.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
+
+	/* Make sure to stop using work from now on. */
+	smp_wmb();
+
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
-- 
MST


