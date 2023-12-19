Return-Path: <linux-pci+bounces-1185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8847818EB1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41D1285D21
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E118381AD;
	Tue, 19 Dec 2023 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="otrcrHRU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988B405F1
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3d0faf262so14936675ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008008; x=1703612808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP5qUoiFDc31MnkvQviOGvw0IT7UG54DgquaP3mAr+M=;
        b=otrcrHRUm9i1fCUkWomPlZqVh49wsH48P/vxeKmchXV38vQQFb39AnQA9jqkicdaYx
         AWOD6Yz4p2MHlJTYgL8Wy4n28t25Beb3Z/IMTfH8WB4bBD2OS9QEiQTrnLsQkZOWEI+2
         r8MVVfF9kvG843l2+1r2SBBEaB+NsyoX1D/i+e/NOCoTISikBWhW5kUPptE7KtGkdQ5Q
         luaxBstIilprDCAGwUiQ/FCSIhrCTrYmznKD7FDL+lgwH+M0Irpor9IzVj1iYvzJJuW1
         /kkwOnsyvBK1sik5iLPvHKVDgoRgaxyZFDI9uXjb/KTNoQ1GgXnrJgcq36toiIsTb4NT
         65Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008008; x=1703612808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP5qUoiFDc31MnkvQviOGvw0IT7UG54DgquaP3mAr+M=;
        b=bAxL0TyOpWUOqGHhm3jvys48ZKAIEfZao8u4VI8s6Yo7kM60X9DFolpivoIfOgyqJ0
         wsUlR/vdxjNxShEXO1faHAVn+PBFPTm/fZANlzQLCXmCyp7T/BIUJJEC5uCAcVorGHpf
         SZlySwCfCP+lhPc3spxCiRxRr3PD2UemMYxCL05Vn9030hycaJ4aPRpW5c5/w7hXbLSD
         2JqpWVmTiMDU7+aLtF2pJIwxNdQFNPCxiRj0VP3H7HLOGakeUeyMOlKxyv0+kKEl75/c
         XK42goVGp702REvBSbEXD3TJZvfi7Qo181O72ryTJ+1fKvd5ZCvUeupilCDBdS7OMKll
         gFDg==
X-Gm-Message-State: AOJu0YygQa89L1kw2430+ki8K+pYKysgWd+IUbnTjg9CXzELqN//kLWM
	IYTg/TPQj2leGPEFhsaNNlBds4jpIEhTjD1Wi7o=
X-Google-Smtp-Source: AGHT+IEOQXmfDQVD1vBA63SzA+9hg3WHejFnv5r3sp4cTvGZBg1eOJzxTsxyyXCko2PiShNLOVwBww==
X-Received: by 2002:a17:902:a3c7:b0:1d3:9d55:3d67 with SMTP id q7-20020a170902a3c700b001d39d553d67mr5367594plb.101.1703008008246;
        Tue, 19 Dec 2023 09:46:48 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:47 -0800 (PST)
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
Subject: [RFC PATCH v3 13/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Tue, 19 Dec 2023 23:15:22 +0530
Message-Id: <20231219174526.2235150-14-sunilvl@ventanamicro.com>
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

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4aa53b7e2bb..9eace6c7042e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1158,6 +1158,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ae045e14126b..b6766bded765 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -95,6 +95,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.39.2


