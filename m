Return-Path: <linux-pci+bounces-8516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B287901E4B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6360B257DF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA87407D;
	Mon, 10 Jun 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVqkiSpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292E770FD
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011932; cv=none; b=MVYXL4IyszI+2Fx1jc3cca8J9dez6BZ16/nN8IgImNa6v623E/sIZCFBvHr1Pdf4vHp5P1ybyYgh/RvHJY6wAvag3qjroF0UPf7032DavkeSx7Td3hJU85Ozna9HbBp8d9+a82PBfW3sJWIx0vKtNzXDNZl0T6BC5HKKa1Bg/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011932; c=relaxed/simple;
	bh=i/wwwpIUQNPto8+tty9E05yTd9y0taZqALuDGbqx1SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddogRReKkYfmufaU8SE+Z54Cd8S7vH4F4pN6MT0+b04xIvbRxA26olRV0My/xStLg2DZbVAQL9q2NkOkd0Mhoss+o6D4RTBwxxX3CQCWZ2ApvvON8/ITJKu+gZ541KC7J+8WMQpxCq8B/PXZOy7h2H8slYUomcOb8aEGIUaDvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVqkiSpH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8U3rxW1s1YIVMSUu9ZuPsxLMiEiJVd/mP29b/0kZtc=;
	b=cVqkiSpH3AghjZkuWssN/RhXHQaFQgku5swbzO34OtcNGRDsrS60ITKP3yJcM5JnMCRkLH
	RrxVb8yCFO1vxwRutBYrrCBNddZuMHjteIHlYuClWO4AtTeRIKgC0Ylyc9CIm67hlLiEdU
	Jw+ggabYXWBXfhWoZYrGPO2lApqiWpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-5ElNFyV6Prqsksaajee0kQ-1; Mon, 10 Jun 2024 05:32:08 -0400
X-MC-Unique: 5ElNFyV6Prqsksaajee0kQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42180d2a0d6so1950335e9.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011927; x=1718616727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8U3rxW1s1YIVMSUu9ZuPsxLMiEiJVd/mP29b/0kZtc=;
        b=U+t2jKOeBS1MKxCKsMcfqmcs++g9JTqJUqHJ6S0st6Atnw1kvrBhKvfU3DVXlxB14Z
         y+kL6aS6rx9+RJR7eDHiSmkbkkssOpoUiMfrMkDTxMrUGC9uutb1/BpL3va1HJIYHhsE
         SVQAF/DOrghQxGiHl64V41d2eaeMDzJ8HKlOBZAtbZ597+a3p2AfAZWjyU40aFscY1uE
         jE1b2I7VNO3MizkFisyr82oAZiORSyuJxVOd3veLpDFWvscIzTTmrq4ZnNdPx/k/6dqw
         nT3URDTCY4hUxHGkNbRnP/8YPDqmqGl3dTJPaDSlPTpPmzFbRpDL8LPDIt4RcJlQwZTn
         swbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSaYZkbjd/svIOYjqxEuTOF9k3/fjl8AZFGwPiKVZZx9pNJSEywCqYe2qlgZlEp1UJHt4lPfwAUl1RQwbJRN9ipJMLdUyF/gYa
X-Gm-Message-State: AOJu0YxpQKcOCJbYlmww+DH32w76f2xS4Yf4ghuXAeMNKaAHRg+heYpo
	PWt3HoZnkc0PdFWUvq8U+VTxNkd7OyZ0jnYuBYg3NsGYGptUUCF8R1R4sG/Sl0gO7NTAPO4Bls4
	Si24u3TbgqnwY/cREuW3fzw2pMmCXx+sQN00AXlAsO1JdEyB1QIKptMMHzA==
X-Received: by 2002:a5d:5988:0:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-35f1b2f890amr3471334f8f.1.1718011927088;
        Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqdCkgAR+1q+z4vuNJAhn568KdHv5oS6P7/Q9rNnLG+Le3g8tuihyGLjdodx7ImjfadRMULg==
X-Received: by 2002:a5d:5988:0:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-35f1b2f890amr3471320f8f.1.1718011926842;
        Mon, 10 Jun 2024 02:32:06 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:06 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 07/13] PCI: Remove enabled status bit from pci_devres
Date: Mon, 10 Jun 2024 11:31:29 +0200
Message-ID: <20240610093149.20640-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI devres implementation has a separate boolean to track whether a
device is enabled. However, that can easily be tracked through the
function pci_is_enabled() which is agnostic.

Using it allows for simplifying the PCI devres implementation.

Replace the separate 'enabled' status bit from struct pci_devres with
calls to pci_is_enabled() at the appropriate places.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    |  6 ------
 drivers/pci/pci.h    |  1 -
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f2a1250c0679..9d25940ce260 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (pci_is_enabled(dev) && !this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -446,14 +446,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -471,7 +468,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pci_is_enabled(pdev));
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e4f377411ec..db2cc48f3d63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,12 +2218,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2403c5a0ff7a..d7f00b43b098 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -821,7 +821,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-- 
2.45.0


