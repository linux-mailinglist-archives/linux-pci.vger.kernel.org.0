Return-Path: <linux-pci+bounces-1178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A681D818E87
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB60B1C248E2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C55837898;
	Tue, 19 Dec 2023 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IVkfP62W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390939ACF
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3e6c86868so4412645ad.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007969; x=1703612769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LBkXmYKNUx+bSYPP6p7CLC2p/4CszGfBGCJeSRJvdc=;
        b=IVkfP62WI+qGPDHiQNflIsShzQ0QzHA4Q6atD5bgBaFLqE9/Bep0FLhLg9kmkF3ej5
         S2/ZXXXNuwvsjBE5wa9G87UzGrN6olr6AifbNiaIIJE7hxSOmLVMowG8iWUPn1l3tcPD
         4PWfx+GjMtyGxMqAivoX4jVBdhzurZwB0o+yLDLyLTcUw4FWG03+V+FC6o6GHt+zi8ya
         CLontBxmsHcpUAx18wa/Ev6lS0nvwLQ5w5vClVsXrY9s038d7mOtqH164fzy6BNSYmCn
         UcjrWZsqMROHvQGIC84agyGZ1iBXyLJbjby9gO9kVSyWU0UtJuq1VmKIcMx/76ftRlk3
         7+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007969; x=1703612769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LBkXmYKNUx+bSYPP6p7CLC2p/4CszGfBGCJeSRJvdc=;
        b=FTMclDGO7kzfIbCAmhbOxIbYZNlM2MFBZRdFOigGk/BXZvCChNaOPIW8akZoG6+Mh0
         NTUIHAtwTY2aDIuwNjphyBlBQ9sfLlGqpzsUDTY2PnR8TJML8YRhih+z42Won/C9fOT+
         c+OnZYTNQhc8phXS7nSrNECnHscfeQahDPohmesClbEMg+YtQvUCQSuNBhRQ6Bc/usFP
         Ph/fhR7PwWCeSSLZmEBO/pZifOqWrE3PyomyfdYXDQLXMHC3OCSm3IL16lht3KmZ2fzb
         JXObX27VE7bb28u076ukorW7WaCINVUb255T0HsjCIMgtNXO1FWJslTAYdYWPfyuo34q
         q/0g==
X-Gm-Message-State: AOJu0Ywbv/viCPMGrRK3HPPEEFwIENZ6i8O9vQKTWbfpZB9s4yASyDwy
	gerZI23+vCAoHJ47ILtdegXImQ==
X-Google-Smtp-Source: AGHT+IEMvSYcrKMxqjyd3ACjSYFZyEXnOTwUkKyhJepg7AXslIP9xhn3TON8/gf45hSmF7UFc175LA==
X-Received: by 2002:a17:903:1206:b0:1d0:7d9a:3bca with SMTP id l6-20020a170903120600b001d07d9a3bcamr23158609plh.52.1703007968947;
        Tue, 19 Dec 2023 09:46:08 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:08 -0800 (PST)
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
Subject: [RFC PATCH v3 06/17] pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
Date: Tue, 19 Dec 2023 23:15:15 +0530
Message-Id: <20231219174526.2235150-7-sunilvl@ventanamicro.com>
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

PNP devices add the IRQ resources to PNP data structure early during
boot from ACPI resource structure. As part of this, the Interrupt
resource (GSI) are registered and appropriate linux IRQ is saved
directly in PNP data structure while creating PNP devices. But at this
time, the interrupt controller for the GSI (either via GSI vector
mapping or via ResourceSource in Interrupt()) may not be probed and
initialized. Hence, the IRQ number in PNP data structure may not be the
linux IRQ number. When the actual driver for the PNP device get probed,
it will get incorrect linux IRQ number.

Fix this issue similar to how platform devices handle this. Basically,
while creating PNP devices, the hwirq number is saved in PNP device and
marked as disabled since acpi_register_gsi() would have failed. When the
actual driver calls pnp_irq(), get the linux IRQ number again if the IRQ
is disabled.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pnp/pnpacpi/core.c |  7 +++++++
 include/linux/pnp.h        | 14 ++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 6ab272c84b7b..239355977d4c 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -326,3 +326,10 @@ static int __init pnpacpi_setup(char *str)
 }
 
 __setup("pnpacpi=", pnpacpi_setup);
+
+void pnpacpi_reconfigure_irq(struct pnp_dev *dev, unsigned int index, struct resource *res)
+{
+	if (has_acpi_companion(&dev->dev))
+		acpi_irq_get(ACPI_HANDLE(&dev->dev), index, res);
+}
+EXPORT_SYMBOL(pnpacpi_reconfigure_irq);
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index c2a7cfbca713..8753eb4275b0 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -26,6 +26,7 @@ struct pnp_dev;
 #ifdef CONFIG_PNP
 struct resource *pnp_get_resource(struct pnp_dev *dev, unsigned long type,
 				unsigned int num);
+
 #else
 static inline struct resource *pnp_get_resource(struct pnp_dev *dev,
 			unsigned long type, unsigned int num)
@@ -146,13 +147,22 @@ static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
 	return 0;
 }
 
+#ifdef CONFIG_PNPACPI
+void pnpacpi_reconfigure_irq(struct pnp_dev *dev, unsigned int index, struct resource *res);
+#endif
 
-static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
+static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
 {
 	struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
 
-	if (pnp_resource_valid(res))
+	if (pnp_resource_valid(res)) {
+#ifdef CONFIG_PNPACPI
+		if (!pnp_resource_enabled(res))
+			pnpacpi_reconfigure_irq(dev, bar, res);
+#endif
 		return res->start;
+	}
+
 	return -1;
 }
 
-- 
2.39.2


