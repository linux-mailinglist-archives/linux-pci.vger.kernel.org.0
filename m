Return-Path: <linux-pci+bounces-10959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78FC93F80C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37401B22268
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91FE15E5CF;
	Mon, 29 Jul 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TXHKdDQ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ECC19066C
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263016; cv=none; b=MLRZ8HpvrY9ohZIZpM70A2p702++foWxOLLv4xPQYM9jNerKPVsxjh71wvrnj8KU7Tpt+4iOW3XAYySved/SxHt5ZvKtWIAEwaheR7pWBsDMH2rerltSi+MjlIqxp9lPDvoW5Kb5jrGo2hmBF3IjgF02Syz7VNbGCujc/Yav0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263016; c=relaxed/simple;
	bh=qJRebCqrm7pwIO+IpT+0VoIBqHNcWGYUdekFfnvXGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbqCTUbbvLnqkZNhNuUDq9VeIs8rdIYVOwt4VClWrRfIXvEqP620wzGkbKHAytIAVjgXUAA3n+lHV2J3F/+b8W8iGkNb+3EwgKZ9K3Qmy3ioPWFXDB9T8KmcmJ7dfFNj/svWKn4evOu+QyKMKTYayonEUKveyTQNc2DnRi9Z5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TXHKdDQ4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc587361b6so19397285ad.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263015; x=1722867815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6K3rvuzx+kcxCA/RkAijYB8PiaVxGHgknWl7+W2h8I=;
        b=TXHKdDQ4xIAxUmFpLGgGpg6RiblaD4O+4pxC6YxCVCqCBZSjyQAJHBO+Mn1Y0Ug2lR
         lOCvFgDJ/SKX/IizXJkfW9Pt3lstAwvxjGsZ/Fd+gNw2WQhFqRN4XNPTeQSTmvs2dUT+
         2aK9IFObYKe2Vg/Stk57hfWoop6m/ScE/3OPjjUDbMdrQRybEFTuTUNxQmqRXf8+UjD8
         xeNJQvhyidWRZqbZk+1B655x+RZZCbs75EZpCiEvZnqSkUZz+qmQ8ipiVYr0gGz428aq
         Fw8HDIK/2nVJbtp9nrXrbBYbs2VrK3KVAljS+j+Je5A9pSMIpiuaqqPcA2oGVV4vHYuW
         JUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263015; x=1722867815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6K3rvuzx+kcxCA/RkAijYB8PiaVxGHgknWl7+W2h8I=;
        b=HdDqRa81mTOh3WLCRnHck+udX9NVH5ZyK3DWLOER16xTFqVd0feAL0kTzLXC5xuPUP
         DtOzynckuq0sK4uZsmlXBPRo8zjxsNM64WUPzTYJYosseRxLSiIEE0Fumzy0bTN0RIJ6
         UPHkSUVyQjpjG9/a91ys2AoAjXtJ/b7RO8+RnXWVExLSvBLDaIaxYaa8k5QOfVWqLcHa
         xQGT3hrtylQA5Njif07N44JFdxkq4tZsukE8OZkijbnJmiDd+5zZQKESLk5AevlfPCE4
         09OH1pXO92/75Mh8ui78EJW2gAybupeMzDN0oLkImnbbc5SryqBk+3iuITPjmCYuzp9f
         YJPg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXWMEUmjMYKxS0sID11l5GSsEL1NWqp47t267Vu05Yo3zY2JfPsswdy18JlUIv0dX8lMWt8aMEAzhZHiWKrpRnJn0lY5dIqlv
X-Gm-Message-State: AOJu0Yx0zxwyts8PeN7LK0oaof+c21z+8ZH/hEOnBJMzOV3+5VUIuLiW
	W4fgs1TCT7Lp1vPPT7BS07s5cspEqLUA0/u2CnKYcEl4i0K99IiL4rgE1zbZ4vY=
X-Google-Smtp-Source: AGHT+IHuqnyr1wGz5leAhutHIAJO97R4WBnGGYBJopHkXMNgwgilRpOmng0OCq0p9dkCz8Wkxaglow==
X-Received: by 2002:a17:903:8d0:b0:1fd:9105:7dd3 with SMTP id d9443c01a7336-1ff049711f5mr56820415ad.64.1722263014706;
        Mon, 29 Jul 2024 07:23:34 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:34 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 29 Jul 2024 19:52:29 +0530
Message-ID: <20240729142241.733357-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
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
index 48d277657203..16917dc3ad60 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1203,6 +1203,9 @@ static int __init acpi_bus_init_irq(void)
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
index 892025d873f0..3a21f1cf126f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.43.0


