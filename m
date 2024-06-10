Return-Path: <linux-pci+bounces-8512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA34901E38
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DED11C214C7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E651757F5;
	Mon, 10 Jun 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBgve4Ha"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAC74404
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011927; cv=none; b=hgT10SFTqh3z5P6GP8QyoGtRymiSQcEPoP1h3+77CBpDSMoVMmKASIWldbTXhaT6A8R53oYhsdNFWM21LAcf3JIZBsKyvIUMNYYcrSJodlh9lh4r1SP9ymubxhdOPLPR0CQxzsJFTm5AVR83ogF66WtPzJBHIXmmgsdhINgYmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011927; c=relaxed/simple;
	bh=TgkR4Nl7UsfcnDus5PAQ/eglmpUMQS/oRcoljkpQuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c77usezXdVN9HxNCvPpYDbQBzBhfWjvAnQ3RkboonifDRZp2E7IX2uik/b4HE0i5G6yIxdFh9OE/dIUJzlj1d8QqFOSjWR2qOs/sj2/OBTvBt1tZ3fb8IwVIFpL06SK6dZZEGwkZL9D6RUdpcqzw6JAwrCod49Ke5JgUZrJDM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBgve4Ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
	b=fBgve4HaBONMdXGPyAQqmE5QnrszPXafnzxJMgaG57Nb1v+u2uJoZtqPIT+2gVkuqGq3H3
	57+Sd4atkSQd8sYS0Xwl4ak9sRBO1j26yjGdlEVOZC/D8O0tY6ghDl9Ahon6zNRWM8ZZ6T
	BdyszpxeymKlf9HOxjZIasRkJDWERGc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-FwSPV1NkNQuvmA09yCQPXQ-1; Mon, 10 Jun 2024 05:32:03 -0400
X-MC-Unique: FwSPV1NkNQuvmA09yCQPXQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354dfd4971dso132912f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011922; x=1718616722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
        b=nvdr0IjJoSSOqefIH3ZqP08xBcg1Zpa+98cXqAvWII6DcJVCQ4LrCXqiJJywYcA5xs
         6Q6f/QBQdoo4dwdeYkFYi5cLBNlvcYHOuj+TbYzczJrFvHc6vHfDdHD/DySqgdp2Pyrc
         hQM4ILIblDIP55Yt1M6h2samVizvDeIreNVAMyjv23W48lAYBz7zZML994Y6N4bQM5Xy
         LqfMW9+e0XdwdrQ3Vhcg4I3K9poWsLMJy1cHuRd2DE7EKossZCxiJiotIg5Avie7rPjP
         2goxWD2FhTVNr/nu2xnxebE7088Y9f+YFwUOvVCxI1kJ075b9vO9TZ6ezrW0XTnJWYqj
         fKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHY5WuQRYHbhA3oxJJ7ggJkQEDIIKCzuODPDZ5fhgCvstRZ7UwOFJCbt8dZhCz2wkVHwvjt0DstR3bKFfdwxmojYolBqfbmFF
X-Gm-Message-State: AOJu0YwjZbWNCRIBLS/eVc79EtccxQVljJoXFdl8py804KmGKfJSMcWI
	xxMG9EnUkYP2x1vu2h+5JMP1CBXoOrXl5AZeRFIV6BNeAnh4dTHkDA6ijAQPGFLTNFAZQzYfdlR
	yTAEyXkBeWJYVVYV8xXxdOR7/nWbvv1kEqaIPHaG3pKm90WseWPaR2ZFN1g==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr6479219f8f.4.1718011921895;
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ34RIrsm60vplmSUHSp8HATp7AS7kEdOir9ms2KbhbicgUfnK/HnyWUyl28CP1kKuZ42sMA==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr6479204f8f.4.1718011921628;
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
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
Subject: [PATCH v8 02/13] PCI: Add devres helpers for iomap table
Date: Mon, 10 Jun 2024 11:31:24 +0200
Message-ID: <20240610093149.20640-3-pstanner@redhat.com>
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


