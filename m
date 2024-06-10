Return-Path: <linux-pci+bounces-8523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B832A901E58
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC872842B4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0607F7F7;
	Mon, 10 Jun 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+iKzw64"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F857D41D
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011937; cv=none; b=FxD6HcfR30rnV85pk1RBlG7N1eR0nQ/c/hP0B/kppbLoVMTx1xWvsyG2TdSX6kxyKOCJwDqN18XJ1TQ7tR9/upyTUqcL3PE5ZcNTjeLBUcc7NaKKFIv1Qc8GR6W3hq9ujIeHlsH0srBhyG4xhbYhK4i2ME/m1Gu9JwXEzjvSy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011937; c=relaxed/simple;
	bh=39N7dQNsh6HdaHQrF4jqoIMCjCm9/18LRI3vr0xgqik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOXbKGeRg7Z5/P9O2O44uBSjlj+23YMkL6iwOxvCTIMntEwuBRG8suo0AAtpkIvOw6AbpYJ2pZMbuoRIKxaAUHB3fpRjup8vhKpheyoG71KXzgrKoeD6IypZPxO+I8AXJDBgWxjxwP/M5JNrqpMcDOiVmgmV9cIu7VQ8WwuAwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+iKzw64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYyS0MFkgb40Rf9CNRl6khW3DB/TwdBG9c2B8GVIp3I=;
	b=H+iKzw64zQZE+amnC154GtNsxhsWoRqXmcPId5ynQOciNuoQlnqDtZAeEUVBdyIFDcDDFX
	CR3Kups+IZDpa2IDYVpXgalWBB1Rla8JzLC4ialhspZVFEmIsc1NdpsXVKOceHEhP7/09e
	170mMCicJIcmsOMQeZ+4EFpgrpXO7oM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-EUpwu1BZNHKheEpLk-p5Wg-1; Mon, 10 Jun 2024 05:32:13 -0400
X-MC-Unique: EUpwu1BZNHKheEpLk-p5Wg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42180ddc0b9so1692065e9.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011932; x=1718616732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYyS0MFkgb40Rf9CNRl6khW3DB/TwdBG9c2B8GVIp3I=;
        b=dUUtaKOi82inMbq684PU8Ug/WgmEx4VxAgbsiu2NKQh+cTRAd2TPnZGk60QNbYMWcE
         y5RAc0VoVZ2XN3LDPGtWWzBB7Is41aa4GQ0eeXSmoAmV3foxXLD2jO96XYURfRqJGiCb
         lNPhd8V7ghIqTD+/Qg1aGacNr7MYU//9uBpBUs/ixd1EqcU3e6ihzOH6n0yGvQZHgayc
         iPdTDR4Rpyw1wMZiKjIXS3t6T/6HzJcIMUMjJyVAcjoU9fcmq50quum1dTnoptDZzVU0
         6UsVPaCckQrAgp9lcRgOC9AC0WD44FdVglgfdCNPW3AxLFHk3uKkZIS7Fkr5fOWM34SS
         aq6A==
X-Forwarded-Encrypted: i=1; AJvYcCUtfHNGObG+2tM+DSaWY7NYnTOkTeiaKOpgUQgyE5AHnNTJj3vGKfqS8G3sJCdJSrprGAeEthYDFqE9zcZHCpTVEccmAGUJ04/y
X-Gm-Message-State: AOJu0YybXhphp2jEsIeg3LPfO4ywarXuftP7NDZdN57TUn4Uezmow8wM
	qzralwOLLNOTvCJAr1DLGrWSxSpK/DxwQx5cQGvkSWoLaxXmVdx8I8Fu6xrFXKXaOT5ZoaKLSg/
	lOdQaU6TKy+n37IhiE6PwNDjyHPOP1eufi8oZBTtMfU4RcvmrpX1Cpld+JA==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr3111494f8f.1.1718011932115;
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa4v7/IL4a5fGSrL47j3kH3zCfktetXms9w5+CrxpIYCETGQiN/XQkBtYRt2zSMtVQVzGA1A==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr3111472f8f.1.1718011931796;
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
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
Subject: [PATCH v8 12/13] PCI: Add pcim_iomap_range()
Date: Mon, 10 Jun 2024 11:31:34 +0200
Message-ID: <20240610093149.20640-13-pstanner@redhat.com>
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

The only managed mapping function currently is pcim_iomap() which
doesn't allow for mapping an area starting at a certain offset, which
many drivers want.

Add pcim_iomap_range() as an exported function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e92a8802832f..96f18243742b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1015,3 +1015,47 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
+
+/**
+ * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of the BAR
+ * @offset: Offset from the begin of the BAR
+ * @len: Length in bytes for the mapping
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Creates a new IO-Mapping within the specified @bar, ranging from @offset to
+ * @offset + @len.
+ *
+ * The mapping will automatically get unmapped on driver detach. If desired,
+ * release manually only with pcim_iounmap().
+ */
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long len)
+{
+	void __iomem *mapping;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	mapping = pci_iomap_range(pdev, bar, offset, len);
+	if (!mapping) {
+		pcim_addr_devres_free(res);
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+	res->baseaddr = mapping;
+
+	/*
+	 * Ranged mappings don't get added to the legacy-table, since the table
+	 * only ever keeps track of whole BARs.
+	 */
+
+	devres_add(&pdev->dev, res);
+	return mapping;
+}
+EXPORT_SYMBOL(pcim_iomap_range);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cc9247f78158..bee1b2754219 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2304,6 +2304,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0


