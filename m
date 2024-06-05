Return-Path: <linux-pci+bounces-8301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B98FC5F0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607E0B215E7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67490193098;
	Wed,  5 Jun 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqAh+kbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B8191491
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575394; cv=none; b=DZn2mCKJfgfiegU+pgOTivtX6OlDMOQYNNTE3b6g/paOTmLGylPUoKuuZXeCpdFVUCYbA3Ps4nGpOS4bIVv7VlY5YtWQR/AK5pC8nC0UUO2u+QW4nTNfCWZKsYWYoyW/EYCdVLjDQvvIIvskFk5s0cvWtk+1uoQzZFbQiZd1uJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575394; c=relaxed/simple;
	bh=JMFvIAK97CVO0WYF9x4f5zI6n4vzeleom/TOQDaGhvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJI7EGBDLI1rcA4Gqan6P8VDGnWt9gfujZVvY77z4ayug1yjkiM5JclTi7GTCfDDctrKDCyE2pkS66v+WlF/KtajB1YRzUjGKrQoLitG6pgzB57pKf7bipE932NRRsXWt4EsNBSpSpwffM/6J4jeq6jwIiVxbnqVu5e7FQXwAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqAh+kbd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEuAQpiyFkRTWU9yECucUjg03zi15bHltjbT7Mp+Diw=;
	b=JqAh+kbd2mRqMVSSEDylIENeWpKxtoeF1frMvtjPru0J0LfUxOqvrHQM0deCn0xeg8dy5q
	QD78NKr3uSFG+WxvEmK1+pPhPH2umv0bzJRCS893AYVC7+gLhsBOqyLsNpuM0Ty9I7LwRn
	DZvJ0lrR5bSP9PQNFeJwIXe/WCfyPZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-3apcepXPPyO75wE-oR2YRg-1; Wed, 05 Jun 2024 04:16:30 -0400
X-MC-Unique: 3apcepXPPyO75wE-oR2YRg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so5392645e9.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575389; x=1718180189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEuAQpiyFkRTWU9yECucUjg03zi15bHltjbT7Mp+Diw=;
        b=WL3WP31KPMulD6/tf4ODqoBDJjRFzDWHHM+Nh0IHLUD9555/LiXkBRtFM9Lh4MzqgC
         B36UPl5UuxTn/KgX+1DwwUtGfSfXfA6eW5lbHOVPUh4ZSXvT0U9TaPq8dF3+f3Ys6XHx
         2VSxz+eViG/pQi7ip/PCsY9mfnEK5gVtlzA/pXKil2A1DxZkufk+L9K6vT4nmaWEEbdT
         vDOIdWUrj4C180aTzS6veF9ElCjPJeNCpWgMJeTqP60jLAzFcRqc6mRxwyMVWRlOXCVi
         PMborstLoxcDJyHLzCjD+05pejAu7Cggh3kyLbAE/WbSCW8yVmlwBuVYuNvQ+oDzM+uI
         SnZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9xISu0uj97IGJAricCXrkYGuvqYvyZ/XzM1DEzsNxm2l5RDsHTNj/Ss/P1tG4xSQoEMjwAie9xYqJGf5smi15UAmD0nUC2lll
X-Gm-Message-State: AOJu0YxHjbISTOPCbaySxJ3Vy9NkiyD9wsypqFsf/rGXojTQjso6HeD6
	IZYrmogT/Cv6OCAcinAMVb6PgVh1VmBZqjsmBOb5QRUp5usTDHsgmM8f9KYH+oznE2DPe9/oKWd
	RrvguljYKG/ud6wHv/hAp/4lTEd3AeGXecK8FH0Gh3s47fjnQZSBywyaSbg==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107291f8f.4.1717575388870;
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnjANmPeJW2fIkqitgTnO6d1I0TF2FhQLz3U4Vz0ir5jlCvF+wcPqPTc7AeKCFcFuNtzjdvA==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107276f8f.4.1717575388585;
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
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
Subject: [PATCH v7 12/13] PCI: Add pcim_iomap_range()
Date: Wed,  5 Jun 2024 10:16:04 +0200
Message-ID: <20240605081605.18769-14-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
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
index 271ffd1aaf47..5ddcfe001d08 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1007,3 +1007,47 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
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
index 3104c0238a42..f6918e49ea5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2329,6 +2329,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0


