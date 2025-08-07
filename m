Return-Path: <linux-pci+bounces-33544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA0B1D695
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D0580D7D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B88279791;
	Thu,  7 Aug 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPoLw/11"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADA279DAA;
	Thu,  7 Aug 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565869; cv=none; b=rpYVKK7PwYD5GcW1I6RWJllKcZwMVp+urHQLv/dYgPDM+Yyq+l4GnctSK242ULk4IYTjJhAh0rRsZkHcnpC1RB7vDyNB7oPmYBffBor+Q11RQ1C1yeRJ9QXRGUZl67HACcWqL6wnjykNeQ9IaUgV9umV+cuL5bN7MwtxO8btH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565869; c=relaxed/simple;
	bh=RiYfKFHlFIbY6ZH8bcjHiKQfbY2L5nwDmaLNAaFAm6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCYnFDn9vG0dWzcIctT5SgYjZ9aQBNeSTwdReXkwr02ul2WurpjQMyZ9nfdbAFBg69IBpjidct5Safnm6oC4MWqY86CELL9K4RMbIzLDHMFdhnXHOVJ6y1ZiQYukbIVL488wyOGATT4tMAjIv4t2yF4KgDQusfHK3iq4cykpkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPoLw/11; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-332426c78a2so6780271fa.2;
        Thu, 07 Aug 2025 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565866; x=1755170666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY7KZ0t1W4AQYd71VjoV8y0wfdEnnsgVlMhGyzkJcqc=;
        b=IPoLw/11fpnPwU1dnibLVnhcEdu1E6CoWckO9NG5Q1BMMBWXL0Ts2o5ROopvHfjb6a
         Iag+aiUxVPLUcbFihdg/D1NcepWPVHFjsHXtr9XTq+9J7UQj+83OwC2d2pbUs4dBX6gb
         sUs3zPE70BiQkCrMmr4KReug0BlEmwrT87y+zrY50jh+GDZ3ZHyq6fsdUHDlk0xtdu14
         GUf9bxgBGxpGGuqyGwYr/S+LdaYcdrqqLA58sSpmhmkoxPjmoVHkLQOTtGKqb65EfoXE
         gW901UNEj0NETa6xhGuCUc0/ox1YSrBeFma/MNrir79ujnyHbviIy6wa7fSRMgbHOFIJ
         LeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565866; x=1755170666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY7KZ0t1W4AQYd71VjoV8y0wfdEnnsgVlMhGyzkJcqc=;
        b=K/gXOtfN5CZ+aJwuwMvrahBI2RBTO3mZN7K7f5V8VHhpM/l1HPDG2d+hmRJxq/WW3i
         /XOCqImm8zWJjGAHtTL6G9vrlM4HjOIe5xD/6i/XCmoHSQYboN3cXgl3To5TUfToq1jU
         f2dtV+gE4JuuzNf7Qch6P3J03K9UrzktYhMBFrjmUUoUjkXFSURAxjh0nkhAph7UIfPf
         ZdopKaQ9Q2jzB+E5QacFVVcLOnEW220WZ8Ia3wXcmLQ/lp53HcBXNTH3jCOuyo/vAgRB
         BJQjwo51p5mKV1g4EVyDT2nYr28R397rhB6hefx91JdC4LzJrCSam3PHj7fsHQCVDtMC
         nLfw==
X-Forwarded-Encrypted: i=1; AJvYcCW15tEJ/3pjPSbUMui6W4lBd/ubcKfh2QPwEcM0jPBOlURMltzOvD8peFtc4Dv5hBGcOLdCssmoSac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsUGsegL9qkP/tAvjshIIjTXsb4R/HvAUAwjVcGcYAsJSTzWc
	T8iQdaPovoWDGfLxH0OxDbHmP29gmNyhXSGWtNwMWJyj//zOF7oJl8dM
X-Gm-Gg: ASbGncuS4FLDzNakypMqUZa3OA6h86dx++sV8v/MJ0PfBguWigEhvwgrKc2w2/Cogcx
	Z9nEfa8SPe8vxvCFDafVa9wEZT5Pw1TR8ac9r/PuS4tfAX+ZKksQri7pPIBuobFhPikMqekxTOX
	VUVZHW3jgxDn869QpCWz+wsFr1kcgxD57t4zdd8+t8emzYdW5q6LsoYc2cGC9WzZTpJ/S4rIWKe
	PyN9O+O0npKqfx0QbPbaiVk4Kjoa9iSNdNcJcZojEWxN7IavT9s0KSgTyKcUHNlbi+UrIQImJ+j
	Bm0kFl1PhKbGo/l0hNUQBsTwddZbsHu49y4UY2FMFbFBbeXPoBHLXAFmpjNozQOTRrzBxlGtWtf
	R5mU55YkF/GiOXWW90NhvIA==
X-Google-Smtp-Source: AGHT+IHyp7zXngRaEZvNVLWxNI2OK085TEbXUKnfzTuAzy/9h6oh1AZHewPemm8Ppet9Ho9OkEdHTg==
X-Received: by 2002:a05:651c:2220:b0:32b:8778:6f0f with SMTP id 38308e7fff4ca-3338142904emr19273301fa.34.1754565866036;
        Thu, 07 Aug 2025 04:24:26 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-33238272dd4sm25674011fa.17.2025.08.07.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:24:25 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH 3/4] irqchip/sg2042-msi: Fix broken affinity setting
Date: Thu,  7 Aug 2025 19:23:24 +0800
Message-ID: <20250807112326.748740-4-inochiama@gmail.com>
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

When using NVME on SG2044, the NVME always complains "I/O tag XXX
(XXX) QID XX timeout, completion polled", which is caused by the
broken handler of the sg2042-msi driver.

As PLIC driver can only setting affinity when enabling, the sg2042-msi
does not properly handled affinity setting previously and enable irq in
an unexpected executing path.

Since the PCI template domain supports irq_startup/irq_shutdown, set
irq_chip_[startup/shutdown]_parent for irq_startup/irq_shutdown. So
the irq can be started properly.

Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
Reported-by: Han Gao <rabenda.cn@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index bcfddc51bc6a..2b7ee17232ab 100644
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
@@ -186,7 +190,9 @@ static const struct irq_domain_ops sg204x_msi_middle_domain_ops = {
 };
 
 #define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
 #define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
 
@@ -201,7 +207,9 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 };
 
 #define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT |\
+				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
 #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				    MSI_FLAG_PCI_MSIX)
-- 
2.50.1


