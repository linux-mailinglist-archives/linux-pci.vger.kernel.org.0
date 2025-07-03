Return-Path: <linux-pci+bounces-31341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958FAF6E92
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776861898F41
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75A2D7807;
	Thu,  3 Jul 2025 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYmvmR1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3842D77E8
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534795; cv=none; b=ANvY+uuHQPfSLLV3K60XKLzmwE+AmJTytqCLvPzO02DcPxW9VHoFcs8BcctNgUzkiqiWaAauQnmPl9kz2KRt+NrIzXzHhTKxSG6TvQ90tplFPurB/HZruLbhuaYXO1UWRrJyZgYieEhNebp0tKUgniSpH7isb3xo4rme3d0xqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534795; c=relaxed/simple;
	bh=iltIWFybhY5jS6gtEpq39rDX9ZwmJ62wzSNTjBqR7K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn6z/CcgA+7VBeW/n2YVOXqJM3o/v7IN1hAJKMUMhGWtwJ0ES6ZkjNxdyI+JPosQnZ2ouvAUVZz8pJQuolPCbOauaduWSmiAbYYyVAFo5WiXXGqA/1uoDw9xcoVhinFMSGT+cT8wlt5M8WJKOZct5NShDqPHa+mw9vJk+zc78fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYmvmR1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gmPV116twb9Z/nZT/xaKI7fsE44yiiTxfBwVEer8aB8=;
	b=IYmvmR1q3WyuFEoR0iYPSkAG9fvniwZKxBCVOIWHghjbVSqHk+kL6cVpHBGJvOK9aS52hX
	q0zFxk2WY0Sth37ZdJnUB9/uK0xMArtdrNIBzJQZGIpzVpsUEVTAUxJH/8pJDhANz2qnxr
	8ePljYDlo00f50K2Eq/VYdQ22z0EDzY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-LApI2YkYOEWWqo62v_XzUQ-1; Thu, 03 Jul 2025 05:26:31 -0400
X-MC-Unique: LApI2YkYOEWWqo62v_XzUQ-1
X-Mimecast-MFC-AGG-ID: LApI2YkYOEWWqo62v_XzUQ_1751534790
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so3920760f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 02:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534790; x=1752139590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmPV116twb9Z/nZT/xaKI7fsE44yiiTxfBwVEer8aB8=;
        b=XVy9OFGellGJ7eVdIuSY65/CDIAP2Tr2m8u+oh3QbZItc6f4JNO0fMHdydyvPX5c6z
         TGhQdQxAmDXrMsIMerJ1BzUwtxlC57cyTnw+89TIVOc8VuyPOCyx1iwsuKtlACfO9Vvv
         2N7aTcYaGsfxV6nWDteuqZ6SbOwbLdyVwuX/HMWWBhf/6NaMeEQaiXxpwv9dxnSVsZNf
         dhV3ZhmKCC3VIrvYUck9Fw9mTntT3CJlz6yl1BOfunb4i9uRUKRHb7OGvzsWSmRCjQV9
         voTzGU3UhE6ngawpSA4ZhWZf0EW0PEzQ/ORD54q1ncYxlNjTsoWlAvUDqQuWgKMrJj33
         ++4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd5N44G+0IcOdpMO2yAuB/tNF6gA53yjOLUvS06t6zyejeXsiiaqjQV0ve6zX9q/+0cRIawKuzdro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaJWZFIR7DVJcCaxDqMqduuB7B9gQvqODoV6Js4WdSmMy2BwV
	fG49/1pX0pTl3rhc/VSFmfrQ/E4clThaiD7J+4VuP9Z5UDYw3UrE3oeGeUDJgoVo4qOpzPC8A1t
	aaclnpsSQu7x07KD3+U0ZZIODDy/gfvRmjj/DbJrM4V079SRF90MGmQJtfOnA27AsMYpeDA==
X-Gm-Gg: ASbGncsMQlX0uLlP7yNQY8ihv/HwKz+O2Q1Cn1G/UydPk5tnwPtYxaeoJ4KByg31II9
	484BgcJE2ra29p4UCELHpYLh/LBG6an97+zLytyUB2HTP5/5vuZ6bJslOLftz2D1uScuZUw8gKX
	mE6X00txwMbxz6Xdm8wbUilXzKq3nsD3xfgTYKgyJ3JurhOSMRvl4ZkYIBbI6OUUWio2CujU0os
	O81PUM+eE/bjE7stwMWvWDe1Qz6U7Kxli2cfxEuKtTRBOiLNlSCV7XEgLPUhUiObls54ak3t1G7
	xHRWLmYfK5LUc8YZ
X-Received: by 2002:a05:6000:2f85:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3b1fe6b72c6mr5556994f8f.18.1751534789654;
        Thu, 03 Jul 2025 02:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMW+7SNj2wAPKclz3m66/sgSUats1gZ/kW9YtYL5R1Qqdu66ZwcRX5icVo4fMXovRSJLS0VA==
X-Received: by 2002:a05:6000:2f85:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3b1fe6b72c6mr5556975f8f.18.1751534789159;
        Thu, 03 Jul 2025 02:26:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8b6sm18462327f8f.91.2025.07.03.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:28 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: [PATCH RFC v4 1/5] pci: report surprise removal event
Message-ID: <9a2fc64af1d7187c55bfdc710cb3d585cd38cd11.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
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
 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
index 51e2bd6405cd..7fbc377de08a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -550,6 +550,10 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */
@@ -2657,6 +2661,47 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	u8 enable = 0x1;
+	u8 disable = 0x0;
+	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+
+	/* check the device did not go away meanwhile. */
+	mb();
+
+	if (!pci_device_is_present(pdev))
+		schedule_work(&pdev->disconnect_work);
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


