Return-Path: <linux-pci+bounces-34005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5DB2578B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C87D3BC064
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F82FC884;
	Wed, 13 Aug 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZmRVSkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876303002AC;
	Wed, 13 Aug 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127782; cv=none; b=PDBZefmym5RW78I6Vo9K3EIrw5jEjfKcWh0M584UGz2EA1uv4tOGsXepuv20vqAKYzmkQ9pHE13WdGwgtL3pvCSoeuyNDtqfZWVXNVnB83I7h52iq0mvHq+x2MMr2Pu6mnmtygugFPC9aC8tFPTTe6Hr/FL8xxMNIQts12eQuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127782; c=relaxed/simple;
	bh=QxOx1Yj7EIirHJxr469BHjrZhOL0k5PImCUybXK3Gf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl0VH3fu5yxD0Ew7cfuj4gMHlXIozlS5tNVhZI+u/WJX0dNyT5xveU7W/s+RMZthjnbQDuV+7rprj+phGIxydNM6SlFhhNdimk89BvIB/d1/XQ3ef0aoRHDho446lDk27Z6k1RF+vUdPqcmu3F5xtCmE2urtSckmTeTEKmx/+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZmRVSkF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce520caf9so367297e87.1;
        Wed, 13 Aug 2025 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127778; x=1755732578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG3ABWLkkENo+g9FdI/B+3pI3P0EFLNuBCEXQJ6J+IU=;
        b=jZmRVSkFeVoNA1WFAveB/TVrPi0zlT2YPDm4pMjfIu/PcVB5z6j2Uz8XdyWDCE+iHd
         xU0/ELnRXYBKB9VARakhAaSUsEBI5y+UvF69wp9V/Fr7z2I7tOJfZzusCOL9oktpeeFs
         a6RIPqc+Ynwic9EEH9/prhZ4ZiQ8oB/qhwgGTyq+h7EOYiQdKHEnsUIemrcBkyX09nl1
         +LdTC+ZhR+7NWNMT6iC5senvHcgAPsgJNFagj5ndxWUMS0RmF+y+qx8mCY1j/FwS0OTv
         swrhv1o/8tTmjskRiRiDyFlSBPnIHIhPZkNH9aomHw4VcuvH+KOIcMXytnB6yslKfA7c
         KvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127778; x=1755732578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG3ABWLkkENo+g9FdI/B+3pI3P0EFLNuBCEXQJ6J+IU=;
        b=lBbCC8ZFXynydC9oFEtJkJ+XcQPNG8uH/vVzyjmwmVHZIm1yH+VcRsHbW/Rs+dMpr+
         Ad4Vls1DG03Nv2GIw0fNrfzSioT+0aymtc1ivn1BaEc+pBNQkywS/RDdMGtS9m5kJphP
         AsGEzkKEtdYis/U+YapVzJrBj4YT/97cFYMYp+v6Tc09keGboJ3iFDSU9wC5/x9vv2Hq
         D/mz33WoRfLMTp32rUkY8Tix1MuvZvv5VLFR1/+72CM919H0R1OLJphuLilzkwsvUBP3
         W9VL9w1I7l5ewxKHbFAisweyzyM+PqXClW67h5luSqsj0mQm/jID5jvSg43QVr+v38ei
         1ggg==
X-Forwarded-Encrypted: i=1; AJvYcCUMN3x6Axi3NPO96zSCVbk0bozqwh0lJsuJ8BCGxlIn28UVA3LqQUyh6S7AgTdyiFjwrk0pys6TyaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69zw0n4LsvkXc67dVKek2LRDeaLwDr4dEz6AYKlCFQeiZyOJL
	cPVTn0IAEdqFFqx3RWEdBJTKvBvP0mGm4MupUS05iJp/46ogyfZC8O1y
X-Gm-Gg: ASbGncvYfNXQHmw9CSGbW3/1xlGGDhrRk8IxQcmX/1tYpNYT6nGCmMlFSsnow3I4H8P
	+JfxvHz8yDvhO2bk8Xmfg4lkSOQ5xNUG2PFUZ0j/35WR/UX761MKN5qYvShdtw1FcKqeLdPq8uB
	aTBeWbAfscDvx4LUbC3tMDuEVbzwDwbh2lu7SqeAcAbuBpylc7nO/cyDbSuQHDGsbBksrYf8x5a
	FPHbsQdGBWbuhUTV1sR+y97+6TOr5KTwfIMnNy635ptYrAK12QGk20h2XvFAcbJjjc4P4X94UpZ
	OIH0wPrHe9NQKH4INeECEs3Sm+NRFUmfSHPwinZTWj6iZrXNToUkgGIZHntE2ofLa/suuStuRZ6
	2ht+vq7G2qUYGgutXN58vfQ==
X-Google-Smtp-Source: AGHT+IFVa8pbnHkBrcxct1lDX+5o6OQzqExhZjCZtuCEPwRQYpgKMUIcY2Mkizddz6tiZ4R83jSrPQ==
X-Received: by 2002:a05:6512:3d29:b0:55b:8f02:c9d0 with SMTP id 2adb3069b0e04-55ce4fe3984mr346044e87.0.1755127778157;
        Wed, 13 Aug 2025 16:29:38 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88db2214sm5328882e87.177.2025.08.13.16.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:29:37 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device domains
Date: Thu, 14 Aug 2025 07:28:32 +0800
Message-ID: <20250813232835.43458-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813232835.43458-1-inochiama@gmail.com>
References: <20250813232835.43458-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the RISC-V PLIC can not apply affinity setting without calling
irq_enable(), it will make the interrupt unavailble when using as
an underlying IRQ chip for MSI controller.

Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
these startup and shutdown the parent as well, which allows the
irq on the parent chip to be enabled if the irq is not enabled
when allocating. This is necessary for the MSI controllers which
use PLIC as underlying IRQ chip.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf..e0a800f918e8 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
 	arg->hwirq = desc->msi_index;
 }
 
+static void cond_shutdown_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		irq_chip_shutdown_parent(data);
+}
+
+static unsigned int cond_startup_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		return irq_chip_startup_parent(data);
+	return 0;
+}
+
 static __always_inline void cond_mask_parent(struct irq_data *data)
 {
 	struct msi_domain_info *info = data->domain->host_data;
@@ -164,6 +181,23 @@ static __always_inline void cond_unmask_parent(struct irq_data *data)
 		irq_chip_unmask_parent(data);
 }
 
+static void pci_irq_shutdown_msi(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msi(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	unsigned int ret = cond_startup_parent(data);
+
+	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
+	return ret;
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
@@ -194,6 +228,8 @@ static void pci_irq_unmask_msi(struct irq_data *data)
 static const struct msi_domain_template pci_msi_template = {
 	.chip = {
 		.name			= "PCI-MSI",
+		.irq_startup		= pci_irq_startup_msi,
+		.irq_shutdown		= pci_irq_shutdown_msi,
 		.irq_mask		= pci_irq_mask_msi,
 		.irq_unmask		= pci_irq_unmask_msi,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
@@ -210,6 +246,20 @@ static const struct msi_domain_template pci_msi_template = {
 	},
 };
 
+static void pci_irq_shutdown_msix(struct irq_data *data)
+{
+	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msix(struct irq_data *data)
+{
+	unsigned int ret = cond_startup_parent(data);
+
+	pci_msix_unmask(irq_data_get_msi_desc(data));
+	return ret;
+}
+
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
@@ -234,6 +284,8 @@ EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
+		.irq_startup		= pci_irq_startup_msix,
+		.irq_shutdown		= pci_irq_shutdown_msix,
 		.irq_mask		= pci_irq_mask_msix,
 		.irq_unmask		= pci_irq_unmask_msix,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5e86a8529fb..3111ba95fbde 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -568,6 +568,8 @@ enum {
 	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
 	/* Support for parent mask/unmask */
 	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
+	/* Support for parent startup/shutdown */
+	MSI_FLAG_PCI_MSI_STARTUP_PARENT	= (1 << 10),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
-- 
2.50.1


