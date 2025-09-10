Return-Path: <linux-pci+bounces-35782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C2CB50AC4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AD7A0477
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630B22FE18;
	Wed, 10 Sep 2025 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3FVxjbZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7122D7B6;
	Wed, 10 Sep 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470109; cv=none; b=r3EX4YBxYf/aLqc8G8iGsEsHBjN9UmsrEgKxhrqjPpliFG+gWbkFXMgXebIEQcV5aeJ4YqQjNAphpIYloy+uVzI1mPYxsdON7J0grzxGgv8j0+AJY1zcJ+6EiVG09TPbMt3Ik2FRbR8KKAxfjcyJ1NHNZ9j9Jb3WoUXNJkE+Gf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470109; c=relaxed/simple;
	bh=OS9j70HJBgJdnu++cmJduNYkDHIWHGvyM1VZ0y15w7w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OR6W5qQhUeMXecIwYcedIBPX/hoSOI8V2n3ltczoEfK3/l7aV+EOTe/GADkQ3zxhwo8E1LHeOoZ8T+tob9HNL6SaI/fn035QjHlQ6bpa3Se2zX4NvCIBjmUZfmElGOZW6rY94kA9QLyeo7O4HdR7vynzLtH/D4xtbz3GaGWjj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3FVxjbZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so49301761cf.0;
        Tue, 09 Sep 2025 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470107; x=1758074907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufI02VTMyX7sTfBD7Jn/jEH2YUmO7DVAO0QyMj+WG88=;
        b=C3FVxjbZ+uqYVvPg+nVOK/FkAU4haXt1V+n84/08HuLb9A7U94T2wM0nKxV25/J2oc
         Zh60gRktTlRxlykqhPyZwrUkzWathT+yrL0rUeWi3M1s8ZvolbougogpU4RYO7GMj8xs
         7QF7Ry6CNHFnvJnYu7VaY25OuQzWbAA9h2f3pigJyzyM+Gsmbdk52hAFaY3TENAFAcGe
         mC4yJPi8ehhEzPdfRz8DkISkamSFozm70Sw3pqjaNXk+8gDPM9l5RXV+D8+scUPXjeR5
         mXXIiZXZ6bcO2kZ/pnjqBo2FTX6JA2B+upO8Qu3QIwMscQmCxIheOLmH1zC0jkCWLihC
         Np+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470107; x=1758074907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufI02VTMyX7sTfBD7Jn/jEH2YUmO7DVAO0QyMj+WG88=;
        b=TeOvg/BxeGARcIZbuzTu9DoPYR3g6tKbVk5CWMD1tjO9+Fnp+VTVgmKy2EWp6BecGO
         gwVuoWOjRQ9HBZGZROsR6nK5cT5CTx8dVX87voQfU277s2sa8Aht3jUcwn2gAxnAyzph
         ZtRvESHG64bFCyy9SHq0aFr5/Be+x9ueedqqLav/qkLY9Wk5wduqHm27b+VdG5GpGjPy
         l01Rg0GMXihdxfdxQWliu1mC/9tg3bwP5uo0ay4xU1DzAyx2l7qgILsTKv6KOVb+wMDG
         flpy6zruiGPmWkl1L+1C1eiAdYq8p7w7hNmJmXdpNbUfhiRQmQswF/XDQh/Gd3C0yw/r
         MxKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7U//fHfxOcbEcyNPXmpRR01zkvOB4EOxVgXFuA6pZ/mNqCmoGDQ0p0nUDaoazf6hqF162q84mrzDq@vger.kernel.org, AJvYcCXNN8CHghOaN+Ag5M/Jj6i/oUdrRl3itrkPDX97Hav10vbvBPAHVj4cJTXWTMbrixHA4iLt0MkETGWs@vger.kernel.org, AJvYcCXNuTnL/psM/zlCd1N0F+wOX4KmxWa7wWOmGvlIGoduckjWlo5a3ddFJ3r+hSM8uXtOSuNanwkGuka9WNyS@vger.kernel.org
X-Gm-Message-State: AOJu0YyKP89l4NcUlZPUfZ79qPom+70avvugkYksPBKdKKvWaVLaJeKm
	l7aAT97lRK3XGBJylWNLGbBXo1+CDz2/+XEZjR3nWYYa3eMg15E+dgnT
X-Gm-Gg: ASbGncuC6NDJfOqjx2UuxgduEvXglt6+YkP/jeFfydxCCQ4mecvZxNw75Ocu2RdBESN
	J3c1ue05mN/iMxVcdCDy1zE932Z6fjWejYNl/f9U0ezDRQnlFVKwRhyKkgxCBkSbc/nYku7//qj
	hUGQtK+Nk707acbXFzYkHMxHDvsCG/0BUq8VaPSyxL+I9uKSCMRPHYvNQX0n90992kgEEUBkNpc
	/piy9BS78IraLY3IS5d5Jqu3NYCL3sQosUnJ4jdGkpkmzZD14sg7BEjnh/U9ZRxTLgGRdhp0Ij8
	fZAkxyZsa30kJO7palnmuqL0J0AeBVS5Tq5X4L98kRJs1TWweKqJF7x5++H33hxaIki142RgDNo
	9/TcTl1VVG9v1R46LOlbGqPubaaX/SyK2+v2vgV7oW3c=
X-Google-Smtp-Source: AGHT+IF9QL0BSm2MkcIQqxgCM1KsqBHMb+NHGINqAC5fWDSx6gqC8dNQv1p+5MAyDgt2C/yVUIW7Kw==
X-Received: by 2002:a05:622a:40cf:b0:4b3:709d:1f1f with SMTP id d75a77b69052e-4b5f8490899mr154710911cf.75.1757470106975;
        Tue, 09 Sep 2025 19:08:26 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba871e4sm17265451cf.14.2025.09.09.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:08:26 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v2 2/7] PCI: cadence: Check pcie-ops before using it.
Date: Wed, 10 Sep 2025 10:08:16 +0800
Message-Id: <18aba25b853d00caf10cc784093c0b91fdc1747d.1757467895.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757467895.git.unicorn_wang@outlook.com>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

ops of struct cdns_pcie may be NULL, direct use
will result in a null pointer error.

Add checking of pcie->ops before using it for new
driver that may not supply pcie->ops.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
 drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 59a4631de79f..fffd63d6665e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -531,7 +531,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
 
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..61806bbd8aa3 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -92,7 +92,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
@@ -123,7 +123,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 	}
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 1d81c4bf6c6d..2f07ba661bda 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -468,7 +468,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 
 static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->start_link)
+	if (pcie->ops && pcie->ops->start_link)
 		return pcie->ops->start_link(pcie);
 
 	return 0;
@@ -476,13 +476,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 
 static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->stop_link)
+	if (pcie->ops && pcie->ops->stop_link)
 		pcie->ops->stop_link(pcie);
 }
 
 static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->link_up)
+	if (pcie->ops && pcie->ops->link_up)
 		return pcie->ops->link_up(pcie);
 
 	return true;
-- 
2.34.1


