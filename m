Return-Path: <linux-pci+bounces-22827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F80A4D604
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0252D172111
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780B1F9421;
	Tue,  4 Mar 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzEJMXG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DE1F4E49;
	Tue,  4 Mar 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076274; cv=none; b=NA+ThwkV1kV2Q+706nuVGln9ZIGjfze519zsSZTkFBchAb/ZDXykZyMAGK5YB6Ge6u/7+VzkflGhEeVibKZMxqJyliKST8IaGcUTQzO/XBuKzOmO3D+Xc7RPdlzQETruwmTK1BpZBrlpztIlKO8nfJ8aI2Y8PabYPdnAvNKq7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076274; c=relaxed/simple;
	bh=2gvZFK7B2/ygORWICSDGt1IIAH1Q/EJuv9x/GA3yxW4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tUGjD+qApK8CAU1nFTl3cUzavP5IljTq0m7BP8fT7A6RV6J5z+brm+SfcAFKw0FUDEzJlTctxblkJWlBkArW4pO5009q0EFkxcFtxSbW+mhyX8Lm6MKBxloxlmz/Nn7NCjNwuv7IpKEmo8PcY0pjF2+R0tBwp4OR8eLUHwKj/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzEJMXG9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3fca560f3so1392167b6e.2;
        Tue, 04 Mar 2025 00:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741076272; x=1741681072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJf71JyQpoB7ef3U1+KnZ33sVZVyCe8BDjmZzBJrNfo=;
        b=gzEJMXG96s0BczBnZZqnK1W53+N7h+j/9HetrZ/cGN2t1zhUkxtRFRL9KBMMIpixEz
         taMn4Q+1DOuXgWm0MVK00YTX9aeTep3xIqtdFuO2/MwGgcF2zEB6VTjIVH2Iz5agPP9X
         LAHBmXtKYx01ZUrjSLCAl5W80w9LLI1OQ2in/C0Xgr7q6hJj2ZJCvUi3gdsdE7+bQjGH
         2h0qT0a0sqWSI4fRF3LnCbAfc44P/IZ6golt5Wl6CWuYabhzHrwM3FPHsrUukDjUeF+Y
         XnCpXR+EBKGHq6/VRqi8UMVIq6+bxTc/7tB/zGNDunkbN6rU9qTSqG0pP0E8i4sH6N3T
         tI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076272; x=1741681072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJf71JyQpoB7ef3U1+KnZ33sVZVyCe8BDjmZzBJrNfo=;
        b=fRQ0Jkhd5Py5gNrmSpL8z1aADpnVdr1ZevFmLk58gCL+EtlPU2DSQQXuJQJCG7FATd
         F65aWo0UPMx/BnBg/pSD2rpMTZD/rEWAf6TYQZki6rxO8bSBUAXq5H3xEuOYNjVw96Bn
         Ky6NM3m24gDlEkvZJBO8yASxWYqNGejOWvKbhGOOImEI4lF6V2V/pxQwGsk4v9VtrQCS
         p/v8rQYOZ92baDd5VccCfvmIN3OgMI1+1YsmDEL6dwzK/ugHUuovHqHsX18ka6aF+QSN
         rPI383sFgIOMm3tKX0IxpAnVWHOF6dcBJ8y5UrqoDJJk3QjETF0eSoJFrEMFzM41Txj1
         anVg==
X-Forwarded-Encrypted: i=1; AJvYcCUum/tKSN0BA6OMIaucv/N5QHvpuSWgz9RX8CioKy1EkJtbZHt+9McCI2vxVbpMTtOmtr7ld4ZOvKFSLuo=@vger.kernel.org, AJvYcCVtBZYmJZsHuRr74EWkycdAL2J6U5ALkV1Ec0t2X3iLZtxTG9WJiwZgNAayEvj84D9wnRXeiRD2tsD0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6D8L0AaWghU8EetXBqwAucacqYFaXTqU1vY5VExqN/l0sClzq
	7jBcs4syYsErLoDx41H460VBzjO92DE1BOWIMCqxWQ7FwTknvL0T
X-Gm-Gg: ASbGnctFD8H9gepI+2SC+AU07CXgh5ZoI2t15ml4i2RUmipa2ddL1uxH6PDDrD4bVTW
	Se463J7kCjyO1glpsKwJnjcjo35z2ub+EmmINaqJMzlVWupz8J2wT/7kX3Qi33U72Zejs4QegJs
	k4ZzxF0OYe+sfMKO6yMCCIdliFjDW63d5QXK1fouMd4tfGlWmyMPM6OZWliyhI9WTXvdSk/iwYG
	ofSx7sHZ0+NsOQfiWJZluP6oFiurfARItES1Ko3jwEMIL1yLlT+RaHmILOFbi/tGTOY1Gd+Axqz
	38jWVCb1tLLQQ0lq/lEGZNWo1niwcSbhNRk+UDFSRK3B4m3bMQhSAj4=
X-Google-Smtp-Source: AGHT+IEzPzDeanddwsgQUTJLbFlFQskBte1JTGbzjSm17M9A3zitxeIjEZa1MG20CvbmO1rnKTczyw==
X-Received: by 2002:a05:6808:308c:b0:3f4:1912:1064 with SMTP id 5614622812f47-3f558601f19mr11817650b6e.34.1741076272226;
        Tue, 04 Mar 2025 00:17:52 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a0f80b6f5sm453009a34.38.2025.03.04.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:17:51 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	unicorn_wang@outlook.com,
	bwawrzyn@cisco.com,
	wojciech.jasko-EXT@continental-corporation.com,
	kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev
Subject: [PATCH] PCI: cadence: Fix NULL pointer error for ops
Date: Tue,  4 Mar 2025 16:17:42 +0800
Message-Id: <20250304081742.848985-1-unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add checking of pcie->ops before using it.

Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
 drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..9b9d7e722ead 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
 
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..56c3d6cdd70e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
@@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 	}
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..436630d18fe0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 
 static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->start_link)
+	if (pcie->ops && pcie->ops->start_link)
 		return pcie->ops->start_link(pcie);
 
 	return 0;
@@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 
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

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.34.1


