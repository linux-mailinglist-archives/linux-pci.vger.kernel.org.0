Return-Path: <linux-pci+bounces-31221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165E1AF0C6D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDBC1C215E8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BD22A4EE;
	Wed,  2 Jul 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M40C0MvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8CC21C187
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440858; cv=none; b=fjJF3//EcPLkaK7E5r4jG1iLI6UoGdgUa09Vl9NaARpffzyL1Scw0dhBbpwFbmzHR6qdncofYBeAJsFQbAh+dLlMVRQisak5MnDOsaN3fafqvX0WPMZk512aQ5Scwdj605tPLbpGjZysOmv1QoHI5kz39CQybnmh0v5ovLaqW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440858; c=relaxed/simple;
	bh=rDdbRQ2GykeER2SnX1xkF1pAGy/+zzWxsZ+2SzCxzYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=USco6JaPDmfajVGEfuz4YaXx+TVk4uQ97IQlJkJCf2EaAY/yBlcdp7uHcOI5gYmukKDTMHMEiGy/uyhYwCOK/xw+AO2v/qKMpla+NUmapOX4hXsnVVG4gEstew02yn/ReqfBIxGtBCgqos3RSn2vE635eqxNG8WT6DxXINTBJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M40C0MvX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751440856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3UQYnC1Uj+FP/5u+XpjAfPehyEkGumzn9sTZOVjMEoY=;
	b=M40C0MvXDLQvnhRO4D4qcQzZOJu855Pkg7Qf+ZjgzRiWhFzN2xP0AWMmNllE0NKErgZN1C
	MNQd/Sy0cHBvAbIUJ7TQDM388Sm7OnwUI/Trhk8G55dz3RQ5Gn9yJd++SNQXCc6MCzQu4R
	Qg8xQEbJIaqUHZq5blchIsTQtLVeEGk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-Jk2GpDY-NoysXO7r7Ib2RA-1; Wed, 02 Jul 2025 03:20:54 -0400
X-MC-Unique: Jk2GpDY-NoysXO7r7Ib2RA-1
X-Mimecast-MFC-AGG-ID: Jk2GpDY-NoysXO7r7Ib2RA_1751440853
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so41959785e9.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 00:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440853; x=1752045653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UQYnC1Uj+FP/5u+XpjAfPehyEkGumzn9sTZOVjMEoY=;
        b=TB4QcqmVbLuCFBnQIwbXrcjqcuwCJcO7baPwnsjd5rVqBoWrHIuOIZrvxW6Jyb4DPf
         5wBnGD6g0vHYKlYdGPp20ViWXEMcAFceDkXaKAkxOuB2dpxCn0Ki9bgfiYad3S5gCTxb
         Fr0hi9IxrFivmVUW0p2KpzPclEaYz/0vlxKGZXDOCUjrW4pmnWeVxI/m+UpDTbwytDGI
         iqM1GaNPWwg0C00ayi2YdrKClSfsmTru5KyM/8Rp8ZRscLnDsGiMdkRr7rxPhT5N8sBO
         fXFkLBO4bZ1WTGnHK4IRS2dSce4kTMSuI85T0z7MBfs/nr+y2K6h2ZcyPAD7F7sUCVly
         e4CA==
X-Forwarded-Encrypted: i=1; AJvYcCXym3tsZ/HTC98i6n5bNipTF1bqRhYSgUYcwaHqbmYJR4v9jU1t5qshUcrSt8PW4geDHmWN3iKULpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/nkjmFh/j+iuqxRGY/DIcgfNTHvhh1+TG8kRzFW4v+hLVdaP
	eKhyv2KBmzFJO3NGrxG4UXR584uHlKQKFiN6lfoMecNziPBXWiHq410LWVS3p8zDyjcJRZnNECS
	HWm5usihKpPo/ODHucIFOva+TOeZBEZMrwvdQWesF3gfo4pOgYlVendW/0VF9Kg==
X-Gm-Gg: ASbGnctbEPpWIIxjLBbQihBsz4k8IPwoXsChFG9jNVScHk2YIKVyHNjHSV0t9qxdqAr
	89WvwVPJw/fB3/Im+5eXmtHIHuDl0S+GAK4EBbmDc5YHkgk7Y1gHAGVqzAUmDD7Ri2sh7jLoDK/
	q/nPLlUOwPamwKe0QDPdCbESM2abTGqPzy44wEZHexuOwrb/ek1rK4yJJMAiaqYp9WgzqTF867v
	A4hkT4t5bY9fV/U+wWd1+yo3gbxtt3SIhuhpjYcYgbQHA/Wr3NeB/8JA2vS//WbQ6Iivw40s+ox
	IvKBlf+LAP6UYYme
X-Received: by 2002:a05:600c:4686:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454a373566emr14889285e9.32.1751440852801;
        Wed, 02 Jul 2025 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU12Z8ggQ0R6Z0B/hxd+EmZh3IQvavd5AT/0Ts/FptyhpCk8URLdlTDVsIsvjAtWLz35dAzQ==
X-Received: by 2002:a05:600c:4686:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454a373566emr14889055e9.32.1751440852301;
        Wed, 02 Jul 2025 00:20:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm220359205e9.22.2025.07.02.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:20:51 -0700 (PDT)
Date: Wed, 2 Jul 2025 03:20:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
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

changes from v2
	v2 was corrupted, fat fingers :(

changes from v1:
        switched to a WQ, with APIs to enable/disable
        added motivation


 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 51e2bd6405cd..b2168c5d0679 100644
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
@@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
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


