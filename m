Return-Path: <linux-pci+bounces-8171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D48D70BE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0832A1F25842
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545615530A;
	Sat,  1 Jun 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jKNoXoGS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEB15380E
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254363; cv=none; b=JUwMfPxXhMjAMErrdVdjRi5gUaRNaHFWa/AgP+rPffC9TFbpWIcXZi7TheAr7Fy9F4m4JwDPt2mIauNJ8HzTn1xZbvCvsO4DSJmfJnu4rJ7gAO/ytresvKZBiffqktWduYwJziQx36P+70UaeUKLPrm+CEduMCSqV+i7QvaJ528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254363; c=relaxed/simple;
	bh=zHxNtk7uwy5NYFihtfjCelt/wBqKO9jFTZ2VaVmdf38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teJ7w8p7n8T7Icskwkkt2GjV7p+0fbbvgpqxOrRPhjhbmVv49pqrwUb5NkXx6JxQmCQTA6KJ3OT55paZ7BZ/r4/eKUFvbQLrbCxe5VxJPZniJyZcK9X+/azclCBRpUbKMxrhf4CRHm09yOR14/WqrDHfsrsbPFUoeFivOfulaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jKNoXoGS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-702621d8725so62682b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254360; x=1717859160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PWsEZjmDFCls294wVt5rkIwO83PA99zSOvcBamPy6U=;
        b=jKNoXoGS+WFDyCK6NlUqapQEi+8dh+SCoMTuJu8gxPVd4+oUTHoxNRu/G3u0Dd7jEe
         AIafqwcy6EUO/o80eiAed+3PrjcTlvxVfV3FpHCbAwVlhWUZg0B0x8yyb+7tKOpAMoA9
         8RTjNAVrA/P2hBTWrEsASeySM0zWMKz/zpdB77qcDwpb+H/VBdSCvUK4aFOjglBjP4JY
         BmVYWMl65YIxo1q9+cKZ6JTNrk0C4Nquthjh4hnlsaCC6jan6yRFVD+f+4OnyLvfhXoc
         RWZERVzq6mWF8uE/G2bEpKmketskQiUWAWqftO3/k7BFY/w8HtByIexz7JlnN7iLsvUI
         yzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254360; x=1717859160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PWsEZjmDFCls294wVt5rkIwO83PA99zSOvcBamPy6U=;
        b=YJgpCrJrhU/sMMk8mPjBkOudtBmMnNqNGPQGBRgChs1qsNJIqFpWx7l3MeXC0mGqHE
         fp9sc8gWzWsTDt1s24KWZsf5OTpqQJSF3+TN6NZBJedCJzN/GRlfWFP0i5VxTOmDLLXj
         3I4t0h4x5HTd+wNC/6xE5y/v/yRTtJ0Md1HKCMQtNtUCU/otTJ1HBSRVXrVUJdFZZX/3
         5v0ZBrsIWd4kjXJ2bKrYTEsqFH/38RFUUMEJWeJAAmE4LXtbW1rXWvHabzGwbrIkgUUH
         MO+97xXEvzHuLhq6lWlJNh03o6e7S257CoSXiko90rBiBdkemdeJFLihgb+4KIGbXVjv
         +4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWD2Zv3ZivbIi0oNhoHH7FDeqyQ2Nunkl2uq50AZggeQ3WlEN+6V9l4C2NQJqi1Lqa2l3O3sTHFRxhGr/l6xCo9whYMmyb2OWIZ
X-Gm-Message-State: AOJu0Yzr/WiyK/Q/nxfZrYF97JPsl7+CnuHvaBBC7r7klMc86F5RrLHo
	Oy7IARdE02HEgymdhzoTOS6SNRTY1YeJC6+ZYoWdowy6vZax8gYzFdAmKKQu0kw=
X-Google-Smtp-Source: AGHT+IFCMwJXYdknheI4VS/aPP1tbqbAGPqO3DadWwdo/Evl6cETwOaxePiXpISSwiqztkqdIn5wYA==
X-Received: by 2002:a05:6a20:a115:b0:1b1:e7de:4d36 with SMTP id adf61e73a8af0-1b26f0f1b28mr5381872637.2.1717254360532;
        Sat, 01 Jun 2024 08:06:00 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:06:00 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 14/17] irqchip/riscv-imsic-state: Create separate function for DT
Date: Sat,  1 Jun 2024 20:34:08 +0530
Message-Id: <20240601150411.1929783-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While populating IMSIC global structure, many fields are initialized
using DT properties. Make the code which uses DT properties as separate
function so that it is easier to add ACPI support later. No
functionality added/changed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 97 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 5479f872e62b..f9e70832863a 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -510,6 +510,60 @@ static int __init imsic_matrix_init(void)
 	return 0;
 }
 
+static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
+					   struct imsic_global_config *global,
+					   u32 *nr_parent_irqs)
+{
+	int rc;
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids = global->nr_ids;
+
+	return 0;
+}
+
 static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 					  u32 index, unsigned long *hartid)
 {
@@ -578,50 +632,9 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	/* Find number of guest index bits in MSI address */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
-				  &global->guest_index_bits);
+	rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
 	if (rc)
-		global->guest_index_bits = 0;
-
-	/* Find number of HART index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
-				  &global->hart_index_bits);
-	if (rc) {
-		/* Assume default value */
-		global->hart_index_bits = __fls(*nr_parent_irqs);
-		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
-			global->hart_index_bits++;
-	}
-
-	/* Find number of group index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
-				  &global->group_index_bits);
-	if (rc)
-		global->group_index_bits = 0;
-
-	/*
-	 * Find first bit position of group index.
-	 * If not specified assumed the default APLIC-IMSIC configuration.
-	 */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
-				  &global->group_index_shift);
-	if (rc)
-		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
-
-	/* Find number of interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
-				  &global->nr_ids);
-	if (rc) {
-		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
 		return rc;
-	}
-
-	/* Find number of guest interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
-				  &global->nr_guest_ids);
-	if (rc)
-		global->nr_guest_ids = global->nr_ids;
 
 	/* Sanity check guest index bits */
 	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
-- 
2.40.1


