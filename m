Return-Path: <linux-pci+bounces-33543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11615B1D693
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15793580CEA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66B278E75;
	Thu,  7 Aug 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2D3NH+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCA2798E3;
	Thu,  7 Aug 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565864; cv=none; b=YGQyApCVDemV2f1dRVxkGypnORa8ALXZwOrzwRuC3icvYELjrR8ywzj5qW8UsXbnCwHIRy4dmKwZL0aGDM7XCL1yo6aMGzfqiSbWnmQH3/cSqZodoE0thMpoLAfa5ssui2bRvHyvBLxHjgu25LRI/WhWMMi6sRfB3DxNnJR/JgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565864; c=relaxed/simple;
	bh=mgFje9VCuxYaDkRn2eUEOdlrR0FNGsyIAb/QQlxEqHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYHQQoOirPnUB3gb7jCR0XOGlX51QSwqCCm7BOCn48xz1YB7q7UUq4Fm4y//9c5saXkqhgFi0Cm+Q+++eItJ2IkK00GdaBbJv3i5TIc56HiwnpdRWA3Jg8SkqBXjv0NCtbgPKbUKMHZcXRE8Dfn/lkQAg+AttFkrVD/C6nIa7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2D3NH+e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b733911b3so901125e87.2;
        Thu, 07 Aug 2025 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565861; x=1755170661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3f4osQEisk3+QJeWjzQRlVBLBMbhg0rfsjrRVkMO74=;
        b=J2D3NH+ePHyrfCqAevxr6WYDft30j2z7ImSjx4qu5sqQpCojO1NKEsMPna34TLCglS
         0z1BUU8ah42I+TxrzLNbUT0BquyNBSSIAII9Yu+x2gSBkpVLmMMhFATxZTn8YrapLjRx
         0vUjHtGPWC++sQbd1/8jzKsTFxy/EaQbZs67hoIsjbFRQgCdChHbkT8nNB1BfFyGfxof
         C4YrqGmEpTZ5zL7BHH7TnsGtMO+E/URuMEMQIJ+KpQ1CI94fFanKw7JytCynE5UnJJ1G
         n8q5eAJzHENOnjIT0NjA3UbjOf138Py1IBB1ltQBfL8YieoS1ctKXiK51NhWJCbcrE6X
         26/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565861; x=1755170661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3f4osQEisk3+QJeWjzQRlVBLBMbhg0rfsjrRVkMO74=;
        b=QEDSun32etaqybMAxM8xEbOfrznNGvpVWaLSHMk3fp+P/KnFoeZrTsdCD0RYNk7gnn
         3fIk1VFnpPuOiL5gnnu30842dVA1Oqj8u21qlNR9Yw46v5uPLkWhqoiKgmdCaZxnT+t/
         ZF7iEUkU+2rppx5K8U9q3mpP6WJqB5nwLi8SmtSNZDV5CpTWF5I24qM45BG5UiZF1j+C
         edbrXqY3gB5Y0dJy/0GN1cu5wTBlvkJvNHdJD9+5yjP5YIq457CKGEG5fG+rhykJsUAF
         3GJ1WXbclqZkC18xnCYMW1NlQIf4kjcGu9TsxtPJbLPDWyHnMPGo8l0PSfCb2/HAc1Rx
         QkXA==
X-Forwarded-Encrypted: i=1; AJvYcCVOc2s3fAmPfYtK7xBZoqW7ylbEGAYTZQExXan5lg867VkqdnaTMAQD0MEDt91id9bobr8JvNfitGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gsylar/HlOXZxjpwNWexAOAxGHFE5Dro237LPnt+Kj4VdVB0
	V6TfWezBP5qzmOsh4D5Tw020zkqtnZV11uglLqFZ2RLoEK3YtjwDNAjm
X-Gm-Gg: ASbGncv0sVrElTaZBP3DR/0U+Ai9+J/k8h/4RhHP6Ubhf+LyuDHcNlj5M6DMJEFCXL9
	jx0Hp8Eo9PMNCZdgIpke9brioBebo2bbfzSwwvfALzlTCoQyOjaNmfXJ1fmVNbpFpw8HCLSja/f
	CLY0KClJFIn08lb8ENFeLUSWuq1lbzHExMp0LrF7oOlX5Sv/azWS2IWOj1d7dA+7LMUvl30pwAA
	NM7hnLthfEJxl1CnDAVBIqU9JyRiZCpms59puKmmtkrdZKrmOSSrbxE2WqL6wZd6TR2b/F/Inc4
	BapRwplU9eW5M5cl9Dum+7PYPdz78r1yT59MqBO/feSk1oNxyC/fFFN1pCLdGF1B6ihDbEVIc4p
	T2bBlhKo0z/l0xkz5OK7GRg==
X-Google-Smtp-Source: AGHT+IEHEGWWBapd5qRUi81qUIbxwLu1rVlzPglHOhT0JGYGJsGtbv53vj7DsFRBacX6AYNI1mi03w==
X-Received: by 2002:a05:6512:1502:10b0:55a:2fb1:9d77 with SMTP id 2adb3069b0e04-55caf397650mr1274712e87.49.1754565860906;
        Thu, 07 Aug 2025 04:24:20 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-332382ae9besm25903471fa.29.2025.08.07.04.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:24:20 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/4] PCI/MSI: Add startup/shutdown support for per device MSI[X] domains
Date: Thu,  7 Aug 2025 19:23:23 +0800
Message-ID: <20250807112326.748740-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807112326.748740-1-inochiama@gmail.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As The RISC-V PLIC can not apply affinity setting without calling
irq_enable(), it will make the interrupt unavaible when using as
an underlying irq chip for MSI controller.

Introduce the irq_startup/irq_shutdown for PCI domain template with
new MSI domain flag. This allow the PLIC can be properly configurated
when calling irq_startup().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf..f0d18cadbe20 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
 	arg->hwirq = desc->msi_index;
 }
 
+static __always_inline void cond_shutdown_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		irq_chip_shutdown_parent(data);
+}
+
+static __always_inline unsigned int cond_startup_parent(struct irq_data *data)
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


