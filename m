Return-Path: <linux-pci+bounces-8730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC76906CEF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A5B23FB0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9E14A09A;
	Thu, 13 Jun 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZihnRTZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7922149DE2
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279465; cv=none; b=UaN743e61hBEhwGSAs2MOhTEshHekqdIO+6lf/ssA4Q4R4iRQGv4bKvWyVHwUI3GXc/H53t0V8a8VTwbU8EfoQVi3HWIL04Bt1sJwQk7ngKdFENA/2s9l14XLWZS+05EDU8pH/euxrXcbt+zD3zjSVFSkbXGdLAMngX2gxV7AVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279465; c=relaxed/simple;
	bh=XM+HU7hb6QVEb253YkrStrtEiG/dnPO/pYNia1HjcLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDIxEz6rtLJ3Ft4ufFUGFbpJqeMBAd3kvNj37r5HsT7K/Gfuh9/n+BhnOo3c9RnyW7vlnhcs2N5mQL0r1bn2sH0s3JRiAckaE9R+NbkcxRWurud6RnmSNRSICXyb5ofFTI5GD3heXtdRwvt2JIoUqGHyf/2Bl/CK3kDE4gJBcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZihnRTZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=000KYz6ID2QoUMG52/WJvZNJGOa8UH1A+/S3718oumg=;
	b=ZihnRTZPY65ze0b+emRIlOq2jlzp3VyKFonjy89gCooNZFyQ3cCHuXGopj8xNS33P8hAwW
	A+/h2LoBWRa9oCF2ksRiiVmylpL6FBgq0J7NJu8EOmo+5ywJgUH654o4dxshDVFonj7h9k
	CuyrKwmHG1hfDCFqb252aFeCOj8CGvY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-xIKUkm9iN7-c_F5oHzwrVA-1; Thu, 13 Jun 2024 07:51:01 -0400
X-MC-Unique: xIKUkm9iN7-c_F5oHzwrVA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebe771d008so1447601fa.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279460; x=1718884260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=000KYz6ID2QoUMG52/WJvZNJGOa8UH1A+/S3718oumg=;
        b=ZhKcDig2JhYcdHCgLRQZ4b27YQTUoYANNwhkq4hgylJkDzJhqhGdsA+oOJZqfxyyhy
         0I/r2h2ndBGF2hOtMMBjWLK/io/bNo9R68LOR0GaJhe5E1LXf0EpAhkRgth+4veFr1O5
         bl6SUIzNm95z/fTVc7UaRWaW9uVRPxbMd1Y4d3fa49iBFfVPgl+DHQmb9QD+JSyLQA1s
         a4GrDzw1VX3kS8CIJkQG7mqY6n6cDLbXO+W0c7ZNmrrUkE+Wnj1Y9TAO2jw1BFyMJpae
         k6xxEBc5EjIYMC97cSdpbfoOy65cFpsKqjdzKygV8aQdQAjr6oygOMGy3lFfvL7mQKOF
         wPog==
X-Forwarded-Encrypted: i=1; AJvYcCVN5p4fbxnMrCQkPiNl8xGobTwUrFOmA0ju5QiNYe+KxYyiMtSsSSqtc/POiKLZm41QolQqcIeTsY9h3bJVOIlmZSW+quY7McE+
X-Gm-Message-State: AOJu0Yyy3YhjKKIsKmwTOPR5eZhCDIHPGr6C79LDCNeh6kSXjOpVEjKF
	VH3wgTIPSJZqHHXnvo6Gjk2cDAvB6pVyYY0StoNrRDlm8Or6G6TfFss+y8IfqoCOMguU4YWtOrw
	14WC6OCjJCn7S94/RqGSuDR9OhwrruSyKrpbbEMSdEo2ZoilpehZfg5CR4Q==
X-Received: by 2002:a05:6512:ac3:b0:52c:9e80:387a with SMTP id 2adb3069b0e04-52ca59e9d11mr72416e87.0.1718279459265;
        Thu, 13 Jun 2024 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnhuJuSAKliDxcFbokg6egscMNv+7jsPTJ86B+AWP/UZU7fL3bpTZJKANl4Bt8/kMHQDmyzw==
X-Received: by 2002:a05:6512:ac3:b0:52c:9e80:387a with SMTP id 2adb3069b0e04-52ca59e9d11mr72313e87.0.1718279457545;
        Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
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
Subject: [PATCH v9 12/13] PCI: Add pcim_iomap_range()
Date: Thu, 13 Jun 2024 13:50:25 +0200
Message-ID: <20240613115032.29098-13-pstanner@redhat.com>
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
index 37ac8fd37291..2f0379a4e58f 100644
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
index 0c19f0717899..98893a89bb5b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2303,6 +2303,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0


