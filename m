Return-Path: <linux-pci+bounces-1176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B13818E81
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8221C24A1B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BD31A61;
	Tue, 19 Dec 2023 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GpR0JG7y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA538F87
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3c394c1f4so13305125ad.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007958; x=1703612758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EebfT5RsMliPiqXCl62hkrmh6d2gQOm2GsmEL35aFBc=;
        b=GpR0JG7y32IcVQUyyiIWXRSCTAlrdXdwpA9H5PjWS3ZEympZMiooxVdQ9QYeygpkb7
         tobK/aLnf93JfNEAQ/lvhv4PI5+RyOL2XM/IBBCqoeTFK09FMY/9EUg19LVtYHkcWXx6
         9zlTCDmuF/SLTaZr/9oYB9ynAeGrRGiI1ByAkIgqtoWwGd8HHhboOU1IjnXZnfOGG7Q3
         30KUQ0QVK8SOcsNZzrs8HYNkW8hgcOXV1Vb+K+baNfYMUwWTKgTesubJ1IUTl5p9ehjI
         tMPXtSm/I/N2SjwnC2LXIt7j3nVZdsylSTGGSTAvhVr/Mdi+KofY3mND4Iz+znYlYXOz
         pRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007958; x=1703612758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EebfT5RsMliPiqXCl62hkrmh6d2gQOm2GsmEL35aFBc=;
        b=ecw1QHTqnLG54+3Th8v4N0YTJgfLT98ReIdBVQBXG92j919dsoRkH/T6P40NL1Z2Kc
         kAdz7ME3627soE/sUh/tApNY3g1keFtGut95RuKecnhLQNBvRk2BAZiXWW5KVeBrtOIb
         TPlqA43agu31N76tbE/zQQaHfWNyM/W4TRBozu4M08zRA82gseOJpwOkixM6OaqJWsUT
         NzPym0kif8F7VScapG7CfNbfrMnL5Xx5Z4R4y7txNMDoQKDwRqFjxIPsdDGfqRBa7Wem
         grPE/uzfod77z7vIgO27ZuOeWk/k2NOqTPg2LhO0Qna2tCvIoGghRMIP+i9Ww2hu0WXU
         wMHQ==
X-Gm-Message-State: AOJu0Yw3OtWbWeZj73Wx35qYyNsNTPD7v6gjk9B8y8p+oBRPycrQsMyX
	BPb5WBfjXU/wZKSpzX7pBcMpyQ==
X-Google-Smtp-Source: AGHT+IFzyQR9Vgnsqa5WmyfTr/Nm6o19oAodCnDVZm95vLyPUVPinYImx8yjTiAOib7HfgdqSjZW3g==
X-Received: by 2002:a17:902:7c8c:b0:1d2:ec9b:92e with SMTP id y12-20020a1709027c8c00b001d2ec9b092emr9877603pll.115.1703007957846;
        Tue, 19 Dec 2023 09:45:57 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:45:57 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 04/17] ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
Date: Tue, 19 Dec 2023 23:15:13 +0530
Message-Id: <20231219174526.2235150-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ACPI doesn't support fw_devlink infrastructure which helps in
ordering the driver probe in the order of dependencies. One of the
dependency between devices in ACPI is GSI interrupt source. This
interrupt source can be another device and mentioned as part of
ResourceSource in the ASL. Or it can be indirectly determined by the GSI
mapping. In either way, adding the link for this dependency avoids
modifying all drivers to handle EPROBE_DEFER. So, add this new interface
into ACPI's fwnode handlers.

Currently, this is necessary for RISC-V architecture. So, kept the
interface functional only for RISC-V. But in future other architectures
also can enable this functionality or can be made common.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/irq.c      | 18 ++++++++++++++++++
 drivers/acpi/property.c | 20 ++++++++++++++++++++
 include/linux/acpi.h    |  9 +++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1687483ff319..b3409e2e2041 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -354,3 +354,21 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					   host_data);
 }
 EXPORT_SYMBOL_GPL(acpi_irq_create_hierarchy);
+
+int acpi_get_gsi_parent_fwnode(acpi_handle handle,
+			       unsigned int index,
+			       struct fwnode_handle **parent)
+{
+	struct irq_fwspec fwspec;
+	unsigned long flags;
+	int rc;
+
+	fwspec.fwnode = NULL;
+	rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
+	if (rc || !fwspec.fwnode)
+		return 0;
+
+	*parent = fwspec.fwnode;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(acpi_get_gsi_parent_fwnode);
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf..88769acb13d4 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1572,6 +1572,25 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 	return res.start;
 }
 
+static int acpi_fwnode_add_links(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent_fwnode;
+	unsigned int i;
+
+	/* This is needed primarily for RISC-V. Other architectures can
+	 * be enabled or made this generic if required.
+	 */
+	if (!IS_ENABLED(CONFIG_RISCV))
+		return 0;
+
+	for (i = 0;
+		   acpi_get_gsi_parent_fwnode(ACPI_HANDLE_FWNODE(fwnode), i, &parent_fwnode);
+		   i++)
+		fwnode_link_add(fwnode, parent_fwnode);
+
+	return 0;
+}
+
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
@@ -1597,6 +1616,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 		.graph_get_port_parent = acpi_fwnode_get_parent,	\
 		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
 		.irq_get = acpi_fwnode_irq_get,				\
+		.add_links = acpi_fwnode_add_links,			\
 	};								\
 	EXPORT_SYMBOL_GPL(ops)
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..e9a9659314f2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1463,12 +1463,21 @@ static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 
 #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
+int acpi_get_gsi_parent_fwnode(acpi_handle handle, unsigned int index,
+			       struct fwnode_handle **parent);
 #else
 static inline
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
 {
 	return -EINVAL;
 }
+
+static inline
+int acpi_get_gsi_parent_fwnode(acpi_handle handle, unsigned int index,
+			       struct fwnode_handle **parent)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_ACPI_LPIT
-- 
2.39.2


