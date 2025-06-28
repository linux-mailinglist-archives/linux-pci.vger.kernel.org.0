Return-Path: <linux-pci+bounces-31018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D7AEC9CD
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D1517D72E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A1D24A063;
	Sat, 28 Jun 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV+6rp6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23734220689
	for <linux-pci@vger.kernel.org>; Sat, 28 Jun 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751137139; cv=none; b=jljYNpdNJLKQwRMwmIqo6YbPpA2BkEQwTdpMZvySpjbSUp5fJ0zoP9NCu73MHsX0ZqBgSNx4hSIRxXnMYYKMk/jUx/mM8yOv8+urjIqGHiNuG+Fsb0THrBwn8qLZFe/uyGEkxAd7+lNQmpQC7ANQ1j6um6jMzYKlwmDurHh7Wjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751137139; c=relaxed/simple;
	bh=ztg5EsMbdjxvKumjrsUF9Vbhn9ZJVkNBuY302Z6WDro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aD0YlX5yEC+fChTu27uo3IpqEsOzgYgKZGE4D9cAjqquWsUMODiTVbKuQ+KTB+5fXE09N3mDbKlKcrXmjCFv/sYd95mX0arc631N1RdFKK2Cqw/oi4vBDUBM1edpyjwNWxO59U1ogvy8q4KmJdw0WHs4P6Fhk7LIKw0CrFb6zw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AV+6rp6S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751137137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=D2jr+MLExuQlTYBzZJpvrbRyvQXC+JLX+EMkY/N8xKM=;
	b=AV+6rp6S3nQUAVvA4t7v4lW6Cmc2GiL8sZ3vrFAReFNw5TQA10F/VADvBnnSPaBZslpL40
	/N4hIBOzk0lHcNTN5oQi+R1hDpSZpgfeVyRohy4gkrhNlQw/K0i8HELz51ncpGFdTMAQtp
	KRdUjCzYS7P9b5p7tJucfqg1Ii2zuKM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-jWrqc9TfP7a15bHVJEmkWQ-1; Sat, 28 Jun 2025 14:58:53 -0400
X-MC-Unique: jWrqc9TfP7a15bHVJEmkWQ-1
X-Mimecast-MFC-AGG-ID: jWrqc9TfP7a15bHVJEmkWQ_1751137132
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a503f28b09so1610248f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 28 Jun 2025 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751137132; x=1751741932;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2jr+MLExuQlTYBzZJpvrbRyvQXC+JLX+EMkY/N8xKM=;
        b=t6WVfm2Y0cu7JokKaDz0v98Xy1xnf4uQMwNNICbrnUSAm2QfClBLQwvcINYcha0Ie6
         kDMC0sQdHGtkLIigpjRmC1J6BD2j8QDi+9cM9Ss1dSpzhai7aS7K2QOiE4XeKdvqvlP3
         9yK/jbam8xofEOLj+AwVB0lEJsbB0L9MdYgHcUL7AP9bFRi/d/zjhr4NiN6jckeT6B+a
         jQeK0GEsTLqE2CBEqLRv0KFnzOPyoEk0T5QJ+p+apDHrSXa/GmM0ZDpty+VkUjE2un1j
         BRyVhsHFkGZ92mKZ5ehSEsLLx+HvdXTsyWzgF7ApNRw07bUHKoA/mtaaHZLayaTW0qsm
         XZeg==
X-Forwarded-Encrypted: i=1; AJvYcCUYRbSoJDyk67/xVxwPXolSCK/KWs8n/FBOYRW+ALbB/qjdvGy62FFfrQPCMSX6i8t0N3pm9Ja7v6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpf1dzECKFcl2CRUA1ZINPetMmQ+vUDlZB0kvdfDHH3Ex/KgJ1
	rj26ZudWcYjl2O99WClFh+MsDtcyOtujSccmrEe2EJShcAMHREenykmDuYHOEV8io12rwoGCgF1
	7Z2iEygO8MjOGhlgjmH5VZYocW0g8CN/X4b0glWnkNrESDprjvDzyC/cAyvR3ag==
X-Gm-Gg: ASbGncvJd/j/OhadqGSY14GWVzLxWKrUg7PK8YyPRd9mrFSxFd0jh0HGvzmLojGmav+
	sZ82hn9n5ALMT+hqdn3dMishipKZYiYLKJ6clEUYjCzTT4YIH1rAWRJA695X2sXYNE1CtjXt/hW
	rkl6RLGcglK3YaWHWy03hXzUp7DjKt7MUrXKlBdI/p3rjXD0oYk/A8lBjCderPIKFHgOqWSsucu
	sH2mswsy+GkAd4twoOVj4da8Wtz0pU37rDzU+qoS3pwP+a4fOHbnKkrkavKwkFN2cVUUJuU25na
	CP7sjLHYdJlT3x2J
X-Received: by 2002:a05:6000:2d82:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a6f312dca2mr7141641f8f.16.1751137132103;
        Sat, 28 Jun 2025 11:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBJMUvsuhSV4mrdNlnlvt4UgUb//QS8f+KlaM7+aGDdwZ8OM/DCTqh3V0G1zt1cycebQnDQg==
X-Received: by 2002:a05:6000:2d82:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a6f312dca2mr7141634f8f.16.1751137131628;
        Sat, 28 Jun 2025 11:58:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm118646395e9.28.2025.06.28.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:58:51 -0700 (PDT)
Date: Sat, 28 Jun 2025 14:58:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: [PATCH RFC] pci: report surprise removal events
Message-ID: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
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

At the moment, in case of a surprise removal, the regular
remove callback is invoked, exclusively.
This works well, because mostly, the cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup and
is now waiting for an interrupt from the device. If the device is now
surprise-removed, that never arrives and the remove callback hangs
forever.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that the
device is inactive.

Given this is by design kind of asynchronous with normal probe/remove
callbacks, I added it in the pci_error_handlers callback.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Warning: build-tested only at this point.

Posting for early flames/feedback.

Cc a bunch of people who discussed this problem specifically in the
virtio blk driver.

 drivers/pci/pci.h   | 9 +++++++++
 include/linux/pci.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..78b064be10d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -549,6 +549,15 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	/* Notify driver of surprise removal */
+	device_lock(&dev->dev);
+
+	if (dev->driver && dev->driver->err_handler &&
+	    dev->driver->err_handler->disconnect)
+		dev->driver->err_handler->disconnect(dev);
+
+	device_unlock(&dev->dev);
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..30a8c7ee09f6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -878,6 +878,9 @@ struct pci_error_handlers {
 	/* PCI slot has been reset */
 	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
 
+	/* PCI slot has been disconnected */
+        void (*disconnect)(struct pci_dev *dev);
+
 	/* PCI function reset prepare or completed */
 	void (*reset_prepare)(struct pci_dev *dev);
 	void (*reset_done)(struct pci_dev *dev);
-- 
MST


