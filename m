Return-Path: <linux-pci+bounces-8719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2181906CD1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E9282ED1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321A1474B5;
	Thu, 13 Jun 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdNVIF+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EF1459E6
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279452; cv=none; b=EwZL59wA8UZBQL82hLcE6S3OeUm0P3dH3ppU/qMh73Px2q+YHTP5a3HRs7puWDHBp0wfEeZW8j9ld9nK7MbY3lIAwlupOYmLGhkWDR/4Ky7lRGFL4umO9SB83TnolZ+aT4RDPW9z/EU+AtNFiMKS8KHdqh7K5hSYHZ37hEa67ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279452; c=relaxed/simple;
	bh=TgkR4Nl7UsfcnDus5PAQ/eglmpUMQS/oRcoljkpQuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCQzTVxMUl90jPhAQT3gImeD6PNza2LvfnUrjbNm+px6vEgnViHojQgVXxIt5Oi3LF1kmYM3fNLES37quL4eihuEMz1ZgWsahO7MIoLYEolGqmpm+wTs8vyJPbz4y5qjf1YklZIWZg1Wt5DFB1sAy6TcbzhVXYkNCo4rvEnaY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdNVIF+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
	b=ZdNVIF+PjrWZ/q07uXOujXwgtW0eY7cw6hVfZIdnysC0EaqqYSIEoJedkVg7+fqW94ST4d
	5QmBPkrUcdVCIH6xRHgckUUJlQfjpJxSLNlUi7UWI6Z+x1gtJv+ACUh4UW5PqcCI98Uh2t
	0IbIBe5jMhO8FWogNOMkOPUWBMCz/2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4YoePO5JPauJ1_Ag6hDhpQ-1; Thu, 13 Jun 2024 07:50:48 -0400
X-MC-Unique: 4YoePO5JPauJ1_Ag6hDhpQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217aad795aso1583135e9.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279447; x=1718884247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
        b=JNFcVV08ZcUjUUBsHU2y3zhvZvZMj1Sp77luyfbAkYpXVLar1KyrVnZa82mLxGN494
         0IRc38JelGl/2MwZ6aeMbETnUCY3aWIZcHa3QrO0mhyqGwXVUJ9ZE4fpzdWTIINi+TDO
         CZ9DE6NLe+tJ6SMv7KVS3pF0B0jkISGPKxWwe/VywHtTLa7kioak0pXXgdwW21VvGnnI
         +8kO2+wkoRx1fBt+EuYuZDi9TzMxT4j40RtV01Utwom2ypaMp0R8hx4i3I3HCalfG93A
         B+8vHgcDXiUUtbO9VE4FSlTM0KqXsBYKNuNMoDDxU7oD/qE2U/HOOIfauTLpyG3v/4vs
         Xefg==
X-Forwarded-Encrypted: i=1; AJvYcCUiFAtiYJzmuFg7QAoef329cPHEmCQ229KGWcIEQ22fjSHf/QWGLkt7E3NIDDkD5MNH43qOJRiYKtU7qnWlN09NPUxyfpqJND0i
X-Gm-Message-State: AOJu0YxGrbbtbtWXXKdBAIDS0vHSfJiCGgN3arpTSMXkVzgo62EtquH1
	lS6ODEr+f6WermaPWv7UOTlIvjwzLsApxS1hn6L7D/wCJQrYtBVK3beAPk8589A0tcpWX0HkYPG
	xIENejvG/yBzQMfbpGs1jrh7PVR+RcWK8/U3oVWBjzItgcTS2Rvf7QScAIw==
X-Received: by 2002:a05:600c:350b:b0:421:74d4:f32c with SMTP id 5b1f17b1804b1-423041e1d4cmr1371035e9.1.1718279447048;
        Thu, 13 Jun 2024 04:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv8ZBvdV4IZRRiIgJbZsBfiAJdHKRwnxvdFK5xMqJJnZPKz428Y6zIL/fRH5SPX2HOkbTO0A==
X-Received: by 2002:a05:600c:350b:b0:421:74d4:f32c with SMTP id 5b1f17b1804b1-423041e1d4cmr1370945e9.1.1718279446627;
        Thu, 13 Jun 2024 04:50:46 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:46 -0700 (PDT)
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
Subject: [PATCH v9 02/13] PCI: Add devres helpers for iomap table
Date: Thu, 13 Jun 2024 13:50:15 +0200
Message-ID: <20240613115032.29098-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcim_iomap_devres.table administrated by pcim_iomap_table() has its
entries set and unset at several places throughout devres.c using manual
iterations which are effectively code duplications.

Add pcim_add_mapping_to_legacy_table() and
pcim_remove_mapping_from_legacy_table() helper functions and use them where
possible.

Link: https://lore.kernel.org/r/20240605081605.18769-4-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[bhelgaas: s/short bar/int bar/ for consistency]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f13edd4a3873..845d6fab0ce7 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_iomap_table);
 
+/*
+ * Fill the legacy mapping-table, so that drivers using the old API can
+ * still get a BAR's mapping address through pcim_iomap_table().
+ */
+static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
+					    void __iomem *mapping, int bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return -ENOMEM;
+
+	/* The legacy mechanism doesn't allow for duplicate mappings. */
+	WARN_ON(legacy_iomap_table[bar]);
+
+	legacy_iomap_table[bar] = mapping;
+
+	return 0;
+}
+
+/*
+ * Remove a mapping. The table only contains whole-BAR mappings, so this will
+ * never interfere with ranged mappings.
+ */
+static void pcim_remove_mapping_from_legacy_table(struct pci_dev *pdev,
+						  void __iomem *addr)
+{
+	int bar;
+	void __iomem **legacy_iomap_table;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (legacy_iomap_table[bar] == addr) {
+			legacy_iomap_table[bar] = NULL;
+			return;
+		}
+	}
+}
+
 /**
  * pcim_iomap - Managed pcim_iomap()
  * @pdev: PCI device to iomap for
@@ -308,16 +354,20 @@ EXPORT_SYMBOL(pcim_iomap_table);
  */
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 {
-	void __iomem **tbl;
+	void __iomem *mapping;
 
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+	mapping = pci_iomap(pdev, bar, maxlen);
+	if (!mapping)
 		return NULL;
 
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
+	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)
+		goto err_table;
+
+	return mapping;
+
+err_table:
+	pci_iounmap(pdev, mapping);
+	return NULL;
 }
 EXPORT_SYMBOL(pcim_iomap);
 
@@ -330,20 +380,9 @@ EXPORT_SYMBOL(pcim_iomap);
  */
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	void __iomem **tbl;
-	int i;
-
 	pci_iounmap(pdev, addr);
 
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
-	WARN_ON(1);
+	pcim_remove_mapping_from_legacy_table(pdev, addr);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
-- 
2.45.0


