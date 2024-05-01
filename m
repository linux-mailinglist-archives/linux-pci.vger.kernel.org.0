Return-Path: <linux-pci+bounces-6941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0198B89B2
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D8C1F225F1
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555385275;
	Wed,  1 May 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dQMgDEvd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B985C44
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565924; cv=none; b=eoXz8P67MRe1LB8DvM6NuYuJjRgBq+aKGF8M2b/O259/u3DEYYzqICenDF5rRr86gPLzOjLlnCHn5axhX/8tSJweKfzgHaKyMpUKVy1AHV7BU6LcWheCi8DFyV7dipJM380xk0KS7qHcJK6tShTxlf8tvzMZjpAMyot8SkyvKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565924; c=relaxed/simple;
	bh=8Sfu8Z9vX1s+/fsrTVCUwOEPkW2bmWazbW7JyHI1Yzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKwTZyFKqhuV/u6H2i7BLNtArYz5FwUC/ISZ5DFRhJM0okdM+AvvYv23j9wW/Wd5sEcus1F5UKARUUEDwVm8/aF4qwENuMsux4qeCjepUmewfsY/lsiI1io/7PawBdyiUa7BnpuF9Vj6y9w4XQeCgpSzW4ajIpqLjRJrlYi7jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dQMgDEvd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso12447205ad.0
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565923; x=1715170723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=dQMgDEvdGDpkqffEqE0YIpbluC9isPcjHb1zOy6hv2Np2N/8nAVqGcGJRlwqvpUDY8
         bnsB7zH723riXC83pII+dlLuSOPW1eOBGt++KkIbN5xvAmSq0UiDCO0zuz2vs4SKGWZy
         Tncrx+1FWLtyHRKzanmiqamw27DPSxEa84g15k0zJZDrK8muzvpaV+LfJ5bLoGJiSs/E
         ZGegZy9o7fQMonMn0YViScl3RPkZX1J5hry8+vrvxFb2zjqZWgbRjmY/jcv1yT4NslZg
         rtetA5YEBa6NGScgTCw+fArrKFiCSxWIxI11V5q8He7YHksYonh6/ciZed/jNjP4Nhmt
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565923; x=1715170723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=UvqfvQOkX8i6q7DBrQU/LYvfKcaCSG7Iqq0M1Az7GX/81FiuaWyKOVPi7vChheKjDd
         JlnOqTlTnBoQC/VPcI26v2RrBo7NobrQJZy+jdl1u9rVhW2epU/4WHDyKogEdmxBZa/o
         gwTa1Zvyq2CZG4DpuUfUfSBVqesRVQIBxN/4WlVWeZ94aWKrkGmaX1mSnvx+NjGtty0c
         O3POqV/ocebCOqvUVKZ+YqfcH2HqtbZ1oZz7J0XE2Il+zb2afHrtuqab6XhmZHGrUC8p
         m49iSpBcWY7g7C61bKyAA8HG1tcNY4RNrkr/BvMVFmZTGGaLT/SIOFsCYn1h8Goggql6
         V5qA==
X-Forwarded-Encrypted: i=1; AJvYcCVVtdaU9bVPurW7V/wuueP/ss7qcSfOTsc8k1/54iNsDF94iLSvjSovPLugiH2CzjO4/0FIqx7syiQhajtxaL9lbK72I4hdqJDn
X-Gm-Message-State: AOJu0YxwDLuk0QVEFkDUTDt278+sbAMJCQjBIfiPqx2RXvHQ9Tz2hzr4
	0PE2jhDaUzmPBvpbaVjdoSBjBzAB6mDIa3dBRKHHadwkq8XE2czljvvEMKnO6kk=
X-Google-Smtp-Source: AGHT+IGI5pV9TYR10/cfbIQ9JMek+r7tBzzTGhtdRl1CfIULDyfaZRTCxXSzFPv/bTagC0SBwcv3pQ==
X-Received: by 2002:a17:902:db09:b0:1ea:cc:e123 with SMTP id m9-20020a170902db0900b001ea00cce123mr2687556plx.46.1714565922763;
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Wed,  1 May 2024 17:47:30 +0530
Message-Id: <20240501121742.1215792-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e3320ddb3da..beded069cb0a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


