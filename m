Return-Path: <linux-pci+bounces-31809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A00AFF344
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61D35A30BE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26123AE87;
	Wed,  9 Jul 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fte7i4p3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA023A9AA
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094534; cv=none; b=Ptp6+mbmmat1nhcUi2FOtUxvR0+s/U5WjIYIkcJilCnmt5cIy4Opx+jqBzARJmgWF3NVIVUk3whIP54m+B3NkoTxtz60QGDx5UQt5bUbaziq6O0nOgafbKeMDPhLduIxsnV+N70iLjHXE3S6I2fBz/ZSsnhODXCNjtK8GbpV9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094534; c=relaxed/simple;
	bh=/lA1LK7ZnNLfv04veBIb9q69E0+yXfc1RvkXI5Te3eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM7CXeyBLgVL2+LreK/73NfRULJd7+8syxO1xMp1EG6aqFTD4dIBSdj5fQHPLAnVGydjlOG30pMONS3naKmQ1iAdpfDWUSwVhid08UwDisixyZzMx++x45YUn0jZ0gRptYnb2r9sNuTCz+aZgaasmNYKyrdL2njaqZYB06gP1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fte7i4p3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+8HiDmuIb1V4xNcjsZubuM5A9uuKBpDTrFrPT0qP+4=;
	b=fte7i4p3l1W7DUXkzbd2MItTxn3SdSrwynlag+fjuU2ZdgUOwNanU3ZYPKfruAXOAIPkTx
	Qizazb8t9SPic04OTfgnxOzrm72xxUZIAgleFZ2H3u6s9WcIoPnoch4PdmNa5DnLJAInqe
	0I2YeMMlClggwZ6OtbibOjdXAaP/6Mk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-4z46gNW7NZeSlaJxl8M8jg-1; Wed, 09 Jul 2025 16:55:30 -0400
X-MC-Unique: 4z46gNW7NZeSlaJxl8M8jg-1
X-Mimecast-MFC-AGG-ID: 4z46gNW7NZeSlaJxl8M8jg_1752094529
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so1291025e9.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 13:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094529; x=1752699329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+8HiDmuIb1V4xNcjsZubuM5A9uuKBpDTrFrPT0qP+4=;
        b=ml2UiIC93yNRBi7zu7YkuhVaQHgswh45bXB6XlJnDwGup4dr1gYvplN7fGTdziEO3k
         EC9W0nCCDFO6DK+EKiiptMy3crwGmwTlwnPxFFp6kY6jAKU3sTz8PFsWz/bLZxzliMKB
         Fx/wDaZ5st3cfOX83fK+p5bpi1Lmi0H/WwqcCSEAkFKAAygSL6MsfbT+AJ+bbv7mQU5y
         GQ+Yv21xH1UkPgThGdfaxhhkHHdyUmMkJ+J26uMwNLxeR70wlFi3eTUYte7PnHrobYK2
         3Z/4Rl7p90I4e2ahvOy1QrP8/Xz5ExDD+kLQy18TaK2gVYFjLf/VVnasTM/QPcxvqFYW
         H3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq1ANPF0r+e2gMvMfaLESUhoJ5zzC3rjN1fVRhvF2twGD1vSRTPj/Z0zxXzW2AishiiaUC8UfROLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IUc4dZFxc2O/4aFcPLTvqzn45/+PAtFPa3+wWYjwdiByXQaS
	zwoCUnL7NJC6GmTaKDh9ctRb6Tni8yfNCfbfaYmp/UaWkfj8TXWNu4kN8TW5yheUCL62+A9jHxn
	GF8Q9AYKQYsH7V0sgUkc+CY9JdWSRAoPpQZVOjMUA5KEKvXeymw9J82glye2aIA==
X-Gm-Gg: ASbGnctmDJruM3NpvN1jY0J/q3Q9YlHYA+2d5kq96CuE02IcVakyn9+to5khh9+1btE
	Qq2nHzMxpFziMWGsfcFvZpYm7eewsxkM94ACXLoqe4lwULa+tORBz69NHTDHXaUH777B4qxYZIY
	8DUawmP1aQv6o/CxeEjohQitlUpMw6epmrtbS6i4FbYbaMUXJQCMT0b38GHiP+29VoJV5G3cvjN
	Wta3vSd1z2jsAwMceAmk1lIOfhsf0lJdwH0VLY9mFyyK2ZQL+kJC4r1ToGsuTY2pEUgcpGPLGZJ
	QAa7I8w9rsWitGg=
X-Received: by 2002:a05:600c:4f55:b0:453:9317:8aa0 with SMTP id 5b1f17b1804b1-454dbd82ee3mr6024845e9.32.1752094528978;
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErXLt//6ePHOG7+onYgqo8lbrjY4/WxLy3ge58RAx7s9NzBFIJkuYjIjs37Zgj4r08N1hruA==
X-Received: by 2002:a05:600c:4f55:b0:453:9317:8aa0 with SMTP id 5b1f17b1804b1-454dbd82ee3mr6024675e9.32.1752094528475;
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5062119sm39984855e9.18.2025.07.09.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
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
index 12215ee72afb..3ca4ebfd46be 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index 05e68f35f392..723b17145b62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -548,6 +548,10 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */
@@ -1993,6 +1997,47 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
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
 #else /* CONFIG_PCI is not enabled */
 
 static inline void pci_set_flags(int flags) { }
-- 
MST


