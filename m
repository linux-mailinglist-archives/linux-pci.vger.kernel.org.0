Return-Path: <linux-pci+bounces-34006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6831B25792
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F0D1C851F0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45B2FC890;
	Wed, 13 Aug 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw2sBCr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852930E826;
	Wed, 13 Aug 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127788; cv=none; b=DpmspkVgq0NQ74eJQJMy5bnQly3E83gGE2oqPemDxf4GZo0jWY21m5XaNTylCGoI2ZTnJzCo36ePlEfQXCfl75srFvXg1BwzCvgYwdXrex209py9AdoNQi7p4+3crUrnc8hNVbVA9hHdtSeZbQ9kFwEwPlwVtsE1axOetkcng68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127788; c=relaxed/simple;
	bh=2LK5W+JZSZmPkHrP4b6a8f3jOPsZqtbjLW2yPXpAuN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYnHdNrkvXWwCRgP9hi5VpKDVgIuyi0CP6OGYoUVNFkWIEhcMAptK0/rhpxdUH3RFFbuXDGN4IG8GCNB9LiiozYxLc6lDyNwmKT3tWva831S/cil4eP6fSdvwf3IHrHxe4jx7g34gqLBCHtB4DBHrQgkTJg3/XYkVkp4EhdFy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw2sBCr7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce5253adcso333043e87.2;
        Wed, 13 Aug 2025 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127785; x=1755732585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Foq/OUZ4KFe7Zsy/GjghiiTzgbU+KXnHb7Hj/cCODdI=;
        b=Hw2sBCr73mctnHPJO331KsAesnuq6gxoIr6GNCmTY5lTYDZoliNBEzyyJ95sn3wdHB
         wc7F3rZrk2wNQpGXj5CDE0VNd9EgMf0ubEiHbqY/8Oi1vcABNYLnpdaOx7Lax9ZgD0Bp
         i6K8T/NGzcAoCWRoVUCMbUMhGVWD8es2S7huRv0w9eL8o5s55uHpQsZs0Bjt1QfyruOC
         YXFbduTWm/vESJq9BM1GOyzUnqC8m1z3wEkS9zAKacOPpvie3SzUQZglrRYc6L1pt7ul
         5iJj4ibia8PUeCM8E1+TnL2HZt72WoVV1M4AggHABLLJ8LuFL8IULglsackKmnhMFZZk
         VdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127785; x=1755732585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Foq/OUZ4KFe7Zsy/GjghiiTzgbU+KXnHb7Hj/cCODdI=;
        b=SzUtmgMMl8pvkR7SY28ggPGl+64aJGDmrRzKCp868gEg/61Te3P0n7dhIZG03Xr7VL
         JM8M260TzAEvbijdBQnCc9n7YWs2f50u/zJytkkcsAzikdnAJgHb5AmvnXcvT4wO2zkm
         l8Fe88opSLe73iQX4ATI3waKbSeceCAGTXz3p5ZbdCkJjSi0Cg3A+NUUQf9qU79FPNm+
         f56y3geIjI47RPEl0dRQ8d4QmebtoW75Aub7c0HjAhZaMXt1IaxfzUTSG8fK53I2v9wu
         g9yUpgoDNceCAceN19i5JcE6jGiifMM+RQaMcU7FrWJnyZtNXLoMy2aVTjv/bcPCdnFe
         8Khw==
X-Forwarded-Encrypted: i=1; AJvYcCVagKYIOuPrBuN5AQ0NcbE9K9A8z5Q00Md2YFYNNvU1nmQdx3fw6UG0tl7Bss7oTE+KyiyYDuEAFZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzD6+rNaubgSxwHUKI29iBRlmi0YV8+F8iDtjU49z7VOwxqhoH
	KX3/wIJKHB9BniSvs9r29FW8xJCOxA3STJJezIpXhckhXuDrzon5/Fdq
X-Gm-Gg: ASbGncsg1uxZB/5NF69Tru9jIrfv5Ruwq6kLxT3+5HRmRj9AYWwe4EzTptOWar3BqX5
	TyGPFISqhbNr5iqimo4PEEfLAomWx7zgurVV50HRGzehGnapNi6TifSw2XnlN5AV4XwYCSFAnnr
	eG/hPbg826D+S2lR4jQ013mHmd635/dKuObdrUYOnPEpzgjMIBEZB5pU64bmcC/e5Afxr/3XRrY
	3Gtg13V729NWftdjx9Xxpcq4CC4+XYQ5LUCNxTWkE933Gw7ii/u0rgUl0GzMzhBolegHmwYLbtk
	0c9lQvFokKbFO7wIhCvYh9gaMJbngyliAQlRC6yUGsMUd6HkZPaC3cr/zvaHDbY5zDw8UB9yWWt
	5BfZCWtvVreHjbW5v8sbr6A==
X-Google-Smtp-Source: AGHT+IEwedvQm4abSTCNAeN61p8SIiGsZtxfvvAm/wZPYZpEYGFLbijTSP2QjyT1iABcQdhZ5qS3ag==
X-Received: by 2002:a05:6512:3b2c:b0:55c:c971:2250 with SMTP id 2adb3069b0e04-55ce5072199mr302500e87.28.1755127784373;
        Wed, 13 Aug 2025 16:29:44 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88cb8d88sm5401345e87.173.2025.08.13.16.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:29:42 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH v2 3/4] irqchip/sg2042-msi: Fix broken affinity setting
Date: Thu, 14 Aug 2025 07:28:33 +0800
Message-ID: <20250813232835.43458-4-inochiama@gmail.com>
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

When using NVME on SG2044, the NVME always complains "I/O tag XXX
(XXX) QID XX timeout, completion polled", which is caused by the
broken handler of the sg2042-msi driver.

As PLIC driver can only set affinity when enabling, the sg2042-msi
does not properly handled affinity setting previously and enables
irq in an unexpected executing path.

Since the PCI template domain supports irq_startup()/irq_shutdown(),
set irq_chip_[startup/shutdown]_parent() for irq_startup() and
irq_shutdown(). So the irq can be started properly.

Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
Reported-by: Han Gao <rabenda.cn@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index bcfddc51bc6a..2fd4d94f9bd7 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -85,6 +85,8 @@ static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *m
 
 static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.name			= "SG2042 MSI",
+	.irq_startup		= irq_chip_startup_parent,
+	.irq_shutdown		= irq_chip_shutdown_parent,
 	.irq_ack		= sg2042_msi_irq_ack,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
@@ -114,6 +116,8 @@ static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *m
 
 static struct irq_chip sg2044_msi_middle_irq_chip = {
 	.name			= "SG2044 MSI",
+	.irq_startup		= irq_chip_startup_parent,
+	.irq_shutdown		= irq_chip_shutdown_parent,
 	.irq_ack		= sg2044_msi_irq_ack,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
@@ -185,8 +189,10 @@ static const struct irq_domain_ops sg204x_msi_middle_domain_ops = {
 	.select	= msi_lib_irq_domain_select,
 };
 
-#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
 #define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
 
@@ -200,10 +206,12 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				   MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |	\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
-#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
 				    MSI_FLAG_PCI_MSIX)
 
 static const struct msi_parent_ops sg2044_msi_parent_ops = {
-- 
2.50.1


