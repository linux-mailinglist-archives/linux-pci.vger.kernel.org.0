Return-Path: <linux-pci+bounces-44410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AFD0C872
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 00:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4070A3012757
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE8A11CA0;
	Fri,  9 Jan 2026 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxmTfrVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973726E71E
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768000836; cv=none; b=SgASzoN/xbQwEkuBD2ieIXYX5IibqjoDZMql1nyD6T9QGSVGvfHpoDnOH9cRoJmudK8XvMQAEUzVxr6FnT+hha+YwJf22EtLDsg2BygwwrH3IOAzj/HArs/mTD26ItpM/j6Kj/W/0ZoVNH3dmoqrTSRhEw/HmzWEHxfptb9BoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768000836; c=relaxed/simple;
	bh=uauslJDPya+Mi7zN1byIbUwAtUSQdr/JY6BhQOY2c/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SffEnNmm5Cl7QqCfpFEVKWwZyEdN9bDjfaJ0OiXF3aKAP7LxF74lKRExl9/ReggEquv84umRnAPeMCksabFtTrvS6/vxYhrmEys0/czJcbrlSgGkMTLytx6Q0cD/4Kwaeavsqt+gX838D6yUCeHg0JGVdyXuZLuQ2zqrZpi8hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WxmTfrVq; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae53df0be7so7162920eec.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 15:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768000834; x=1768605634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjc69Ug76udGWAJNdjlmNMgaDAb0OMq4cVdQ7MxrqJE=;
        b=WxmTfrVq11ByfBHVN74w7QNTdLS+i2Lc3CzpU74iuNRX/9AcZg4CPwTmgnWLEvS8p4
         DXj0GfNuPQZuFWLQp9BLiCZgqzTlWmaCicbr9/8cV+66eBO84vlwHd+5s4lLhSraKc4r
         ZWXyFuFkC7SsS/20TG3ZEgPcm10LJEQWEsfeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768000834; x=1768605634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjc69Ug76udGWAJNdjlmNMgaDAb0OMq4cVdQ7MxrqJE=;
        b=NrF/DDvOYPNy/N1wTQSy9lHvDlDvSZC9yWVwLD/gT8ywrsRFl2rMaub1WIbqp0R1jr
         yqtGWTz+uybUk6RE7KUJSI6xXHKqgx8bIBU2EP0Leqw6nx0M/5WlzHb+va6Mva1cJI8I
         aaKuZfWWM10Xp8oBVEd6fq3SsOJBWRBo6fPGIqNozLZxz4Tioo7F/uG7Bn1+3IMlXoI/
         JrlgrcdC/jcyYxhCGA4VpQG2/0tT5Sr5+Ab9oaWmpOVfXIemtkaLb2L28o1lIMPg/Qr8
         b8h7tpAE1FKudOh1MuJi3N7/juAcd38fqAwMZZbVCPYC72ucFs+0ou4dV7GNOfjDablE
         m5qw==
X-Forwarded-Encrypted: i=1; AJvYcCWr4FNRSpJGYhPjRSm+VaS69op36ai2a5V/beTtDhgPUW32LO/eyL66zfXNFRbcKc8KD2uZItZAAGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFm/Zet14euH/NeJ8VaZ2w0Oug9d6UKuWDW8RPrzy5yoJCcCuo
	i7We2HpnS6o2ecXBP9k1PPbO5gQbTXatvgryh9r4nNxN79zdnedyiMjcvLtvHzO+1w==
X-Gm-Gg: AY/fxX4uzZtYaDG4usX4QRDFBmXOfUeVMuu5BP7El+77txPrBPZiF1MnlR/vCEcFQim
	KvpjPlJdCqzuFcXK2TdvSaeck/EY5ZfJhaFPN3CIUcxcapCExBgHOuSYN7ngv4ec67d0u7JSkpM
	N2LATBCNK5nBoICAj9q0YNi0+4ukErfJbbydk+xuY03hFZ7TipXgbvUes+iXg4dFAC2QDsc6w7B
	IjvJhVOxdVcN/hrtuSo0v2YBX39X+nuwNc0FYrgMzNMXvBIDYVmLj0rZd5iyfB8LWCWrtze/SjQ
	6gS3OKDpn+VKD7mRY5p9lRFITHl9EPhXqC1F3e7C3PLUXSzZSxYj7u+BC7qLRQBaZoQIi6NOKpE
	XGljQPl+3I+wEExrAf9lzQhw8c0dGTJx2XQRzwXlDGRioLYoUwlgQIk31zFXNUOCQNx3yLYUYBO
	9thRIGY6GnzVL3d1xN+vuYZFVEmygi7Pk97WgchN4Pqx7CiM/eTA==
X-Google-Smtp-Source: AGHT+IENuKRYZp3sFnXek7nzyZvUtio8CAjc9bIG5jdIyZX3kNkVI7th7ggrqtKv/AAwDJa2fnZXLw==
X-Received: by 2002:a05:693c:3101:b0:2b0:5b8f:1c5a with SMTP id 5a478bee46e88-2b17d30f8f8mr11744254eec.31.1768000834204;
        Fri, 09 Jan 2026 15:20:34 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:b4c7:3d26:a6c4:9c0e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b1707b16e4sm11779989eec.26.2026.01.09.15.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 15:20:33 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/portdrv: Allow probing even without child services
Date: Fri,  9 Jan 2026 15:20:13 -0800
Message-ID: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe port driver fails to probe if it finds no child services,
presumably under the assumption that the driver is not useful in that
case. However, the driver *can* still be useful for power management
support -- namely, it still configures the port for runtime PM / D3,
which may be important for allowing a bridge to enter low power modes.

Thus, we allow probe to succeed even if no IRQs and no child services
are available. This also mirrors existing behavior for ports that have
no PCIe capabilities, where we'd also probe successfully.

This change is a bit more important after commit f5cd8a929c82 ("PCI:
dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
controller"), because it's common for some DWC-based systems to:

1. have only have the "aer" and "pcie_pme" port services available and
2. not define legacy INTx interrupts properly in their device tree.

After commit f5cd8a929c82, such systems may fail
pcie_init_service_irqs() and so exit with -ENODEV.

Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pcie/portdrv.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..e47901a3e880 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  */
 static int pcie_port_device_register(struct pci_dev *dev)
 {
-	int status, capabilities, i, nr_service;
+	int status, capabilities, i;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
 
 	/* Enable PCI Express port device */
@@ -355,29 +355,18 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
-			goto error_disable;
+			return 0;
 	}
 
 	/* Allocate child services if any */
-	status = -ENODEV;
-	nr_service = 0;
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		int service = 1 << i;
 		if (!(capabilities & service))
 			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
+		pcie_device_init(dev, service, irqs[i]);
 	}
-	if (!nr_service)
-		goto error_cleanup_irqs;
 
 	return 0;
-
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
-- 
2.52.0.457.g6b5491de43-goog


