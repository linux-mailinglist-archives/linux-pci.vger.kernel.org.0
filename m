Return-Path: <linux-pci+bounces-33542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA1B1D691
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168A77A25F4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D87238140;
	Thu,  7 Aug 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2NHMlxU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF043164;
	Thu,  7 Aug 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565859; cv=none; b=BN+lsaQ/0Lh/ZKNx0OAyYw95G9ObNl8gf3Wo+RlVBdOlVoCGc+k2HA5t3/9P0T6Tz/tgbkbWwBh5Dh4CCWrohpriiDLvo4gs3E+OXoThR0wliQSRfEbzdkDUVCmOHPxRgJ5iqrBFWqswi8r+BghSJ6F7Ss7SmOcmmdKGnIyH2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565859; c=relaxed/simple;
	bh=jKN51hrz9ZZ1Kr2M0YEgs3BXi2j041tUpvlNhGpSpdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f59n2lYAbs0bfMHkncUoAQgDYEZKSJYzb0jSh4hhMLxnyxU7k8l4JENU20y3M9zvar0qyk5i2KJfZyLDp5LAVTuVjq0YTCz+/3aNGbcN5fXdzC4+RlRNkMt2zuxPZ63qmeseLedlfrYzVPZ9IkSrsmMSVPZrrzSQGl+/jXaA9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2NHMlxU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32f1df58f21so8412921fa.3;
        Thu, 07 Aug 2025 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565856; x=1755170656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYuIAa2LQBy1EvUyRKp5PWfOMq9/BckScIoKDvyzVOc=;
        b=T2NHMlxU8Ty4NpEB2RcS2REmSrA6XoiS9qnuPvdudu+a58BN0cgRJBzOnpmVQzn1Hf
         AsBKWsWoR3vPk4DNxyJuTh53BDcyqS1pBPI/FV/9xyZakNQTUs40WTOc28TkgelbVJ5g
         HKdesXkb1qNpbadMV3v62Gl676FrHv4bbCd1FW6i1F/rSTjNJd62A+Kxnjzx4JIl2zP1
         cD2as6ocps07OybVhH9jS/RD0mh2qB0BSqS11w9LSUnLUvMcrY/CtkVNzwkq/GmjfKsG
         uZMsVkFOfg2UpUZ4oSyhHUHF7LH64T6r5bhokUoufSV+c0FE6fmqSG4NP8T7vnOo8Wc1
         RB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565856; x=1755170656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYuIAa2LQBy1EvUyRKp5PWfOMq9/BckScIoKDvyzVOc=;
        b=HsGX3EbbsttVn2FOuOOyZEVR9xYMx83sdx93d0EfVGcvxHIszDU4+DhCMIWxFaHdWK
         N9K/f8iWI0rKV7l6tf/Adqjs7zbi9RMtiCXmosco5T7aIS+KcFZnZQU/Vnv2DB+6DLMS
         MHIywKSUXN1QKFKxl8S7DKeBaKrsRYp47atZxtAdymtls9yu8gfJ5EfSD6+zfamJD3Fx
         rvNZOglztf0lyk2yH+FtmRKezTNX/wQScQyXNnD04YEnsaouPqcVWzVdNFPwdL0lqhG9
         3yOvVBJKjecTozz7sD5agxkxq73tj7eKxrdKNmmEt0ySnBC4dIjup8kVEde9MhchJ/G9
         sJvA==
X-Forwarded-Encrypted: i=1; AJvYcCWyfinmhENFJEJ0BduUNLFvDb+AjwNL/zI3A6aM35MTqmCIuUWhiOJTo6cGoqtra6TfPT5ZAJ7Dcwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBrilrXac9Jx6caMR4OhhjiSosMvmhB3p8nWmsU4ThvNuWXQj
	0w1DfUrSFftr2J886dTrgAd9BgH5YTu0Y/pd6cM+KLbNHR7i9ZaPBnM+
X-Gm-Gg: ASbGncuXY2GpdxE0NAdJa9qcmATl7XHrUo5A7qVjOPY2V2nn5U4raF7ZAILDnea82ZZ
	Jlk6Afu4/ZEJ/8tePhERaWunJvWnibNd77GJ9o+9KzyrXz0xFTun0Dqwpb2DZ5KY+tb4qnoaI4T
	kzUi0zrcJ/AAJUks3PsyY48QPK9LPYRi5R1Cn6bNVlaAk3ahnUrVvfQS4BPmoaAiUQAsapT2Ako
	3FzdSOQkcE3ncDdV+UyLs9BVipTg7OSpCDgADdDqpeIWPHbEYQUIkZRzUzs9n496Z3ccqeE1JQE
	G1MP29cxRkUVOOl5216oecdmjOtwchTqUKvLkIwV/2OnquDzTywOnRlosypffeS+mrL8ayomZfk
	YeF6usvzg8BP860qRyhsV2Q==
X-Google-Smtp-Source: AGHT+IHNceHWQpboPrO12Qm66j1Kufw8HCPZzSRR8Hd44hags0nsY4NX/7sCdcE7PQM50Vl15yRIkw==
X-Received: by 2002:a05:651c:1cc:b0:30b:ba06:b6f9 with SMTP id 38308e7fff4ca-333813bfeebmr14950101fa.26.1754565855965;
        Thu, 07 Aug 2025 04:24:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3323827290bsm25907371fa.8.2025.08.07.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:24:15 -0700 (PDT)
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
Subject: [PATCH 1/4] genirq: Add irq_chip_(startup/shutdown)_parent
Date: Thu,  7 Aug 2025 19:23:22 +0800
Message-ID: <20250807112326.748740-2-inochiama@gmail.com>
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

Add helper irq_chip_startup_parent and irq_chip_shutdown_parent. The
helper implement the default behavior in case irq_startup or irq_shutdown
is not implemented for the parent interrupt chip, which will fallback
to irq_chip_enable_parent or irq_chip_disable_parent if not available.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606a81ef..890e1371f5d4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -669,6 +669,8 @@ extern int irq_chip_set_parent_state(struct irq_data *data,
 extern int irq_chip_get_parent_state(struct irq_data *data,
 				     enum irqchip_irq_state which,
 				     bool *state);
+extern void irq_chip_shutdown_parent(struct irq_data *data);
+extern unsigned int irq_chip_startup_parent(struct irq_data *data);
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0d0276378c70..3ffa0d80ddd1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1259,6 +1259,43 @@ int irq_chip_get_parent_state(struct irq_data *data,
 }
 EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
 
+/**
+ * irq_chip_shutdown_parent - Shutdown the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_shutdown() callback of the parent if available or falls
+ * back to irq_chip_disable_parent().
+ */
+void irq_chip_shutdown_parent(struct irq_data *data)
+{
+	struct irq_data *parent = data->parent_data;
+
+	if (parent->chip->irq_shutdown)
+		parent->chip->irq_shutdown(parent);
+	else
+		irq_chip_disable_parent(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_shutdown_parent);
+
+/**
+ * irq_chip_startup_parent - Startup the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_startup() callback of the parent if available or falls
+ * back to irq_chip_enable_parent().
+ */
+unsigned int irq_chip_startup_parent(struct irq_data *data)
+{
+	struct irq_data *parent = data->parent_data;
+
+	if (parent->chip->irq_startup)
+		return parent->chip->irq_startup(parent);
+
+	irq_chip_enable_parent(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_chip_startup_parent);
+
 /**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
  * NULL)
-- 
2.50.1


