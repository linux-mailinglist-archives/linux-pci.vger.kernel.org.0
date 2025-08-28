Return-Path: <linux-pci+bounces-34959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDDB39193
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF38A4E2660
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF623AE95;
	Thu, 28 Aug 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ASwa8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037C199931;
	Thu, 28 Aug 2025 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347447; cv=none; b=UUUTop5DnWU5EMmBhOOkDxESS2OrtkGY8Y3VQJvwLT60V6XWxJvw7jo2J6yYuDsef5uUHs8DKz8yUATY33J4c3N1SfZU/MbaiThjvp0RgGxdmMPpUbtlHvOtvAgy2D++KQ/645Ejfw4+KfiuE7IzJmBApl/3y2ydaJnrk3h+ZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347447; c=relaxed/simple;
	bh=5f2mmt9u33RfwW27TpFBKhySW3NJY0la1B1vEYqwVz8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNXZom3I8f3FIcGeack0GMJbkbf9/wf8oG/19VBisy2blz8Ad2/48aSHdsJEcu1vcSxetaRbf0Anxw5ShI4rHBAmXY2iyK78buuVsgVl6z9T67eX/YKU/YQcbzRZ1ccfu/dBim72xMZx7o0pGPkgme5/upHcGB+inh3v+c+6xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0ASwa8x; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381e2079fso427572a34.0;
        Wed, 27 Aug 2025 19:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347445; x=1756952245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cMD9oVw7wzB9jTZgK3seO4aPiDIfpeTKPhUfVzD+DA=;
        b=N0ASwa8xkJAE+y/0y8ljLU3iqxycL0s5NLM+p7BTx1owmFcpjJzRORCK9+tT3egQ3w
         bod3t+HvTUrNApD/HJHCnaoE16vatWLIOyqHzUMBKtqTQp9VD/Nl64UM+mBwe4DJupot
         La2XrRgBrB84Hrx+BhamAdNr4ztlNsc3ZpZP+9gCXidObTouJt4qu4fMKlywTbuHnCiW
         Yt5g95gC0h53R038LZYwdLakub3Q7y10U3OK6NOR84H8AdT4sausCfAbyJgpCFHxJl/d
         1KemKq9yM6jZCtkjSljUvx2e5CegBQ+10XlHC8sG6ZsJoLsszVo+xFeGxockD6qtwKBz
         f6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347445; x=1756952245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cMD9oVw7wzB9jTZgK3seO4aPiDIfpeTKPhUfVzD+DA=;
        b=fy1mQYjVL/Zp4lAv8hDHhP/5iELzrVipDvI8nwn8Erp0+N3fQxUCQzo2oSiOAr/oRl
         uRDdxP9Vi7o3gaRvdTJmQYjvC8gbjdqayTatl8oZR48yNo0i/2WSreoG8B9glS+tP5cY
         3NMY7fA352RxILLxm1l+rydHBZbzElV2MuvokJAn5nDLxyL9awNLgVOREuxzXIfqRR9p
         i6tLjb4JjENxiwmBGyo4j0aeXIhwiFPprKMlJ5+OD9x20EZ9oMUPkbhtv5w/Sr90VpuJ
         14z5A0IXv5WWS9DDxtvNHVXc3XjjLLcw6ESGEdkf9x78ttS43xnaEadGDN7jbmuiwB+f
         7Sxg==
X-Forwarded-Encrypted: i=1; AJvYcCXDnIjjqWTKcChvF40GKoHsnJq8wMR0X+7YKp9oZdgJFDKMuh3diDAWwqzSeM/B/EG1Sr8TqG5ToIoF@vger.kernel.org, AJvYcCXNKecu9XduCsYDY4XKIJe8s3wP2woYfvV+fByOIz4PdofYHm61j7RjUUBuP9ifG5aW7/Zb3re5u452Tn5P@vger.kernel.org, AJvYcCXPZdL0tcEK7mo+5VgSi9VMP50h2ifQbYE9b10rBDPw6cOSSfGebYjJSWAg/sSA4ud2xbTNncDJNr8i@vger.kernel.org
X-Gm-Message-State: AOJu0YwC79AOj5wlvDbm2bFRmeoNQlpccdoWTYTLWY8RNrqCSJAxuQqK
	cpx2yTdvZbppV/3V56ndVkfKjMpYhTfAkgLuJn2SgVJGBbMOc2rPnReI
X-Gm-Gg: ASbGncsR7JHyzekq9CaMkD8dYjHaaTHOUnTjsWfnDwsKTgzWEiUmkhy1ezTOHJhFsDT
	onyUp6BwMAIjYbRFpvwkWZOGNDOaAVOfk7dptMGPMBtovSPHfnqDif4D+wzxbAwOR+rc3Y56fLr
	ORXkTGjB8n6Cfh6IMGcHlCaTzIm95tLFGAl/bZdYoC808YYZnFt3odIGo8/kEFjPcBeoq7DCsTU
	f9/dvOyliVvF26p5q+xs8wHAdAP237QjFjMD/DOsKPsd8eZ6xpPx/72dcZy8AXZYcok+OGLoy7T
	mVywSUrLliyqy4XRzJd3YwSpuTwvjp10pWqAz1vx6FriYtpk9yANZXs1u7I0fCI62R7a26KUoO2
	V76RB3ZY44lPLK/p7WlUk6qCodAUtq9yVaUcMIcRmFA8=
X-Google-Smtp-Source: AGHT+IFUMTBN0ewK0J12WWwmbqPZ20vlkC0r+3NLs/KDPeS4FrNivKz6PhTVcy1KC85aKvA34B7Fow==
X-Received: by 2002:a05:6830:6b06:b0:73e:9857:9839 with SMTP id 46e09a7af769-7450048644amr11399123a34.0.1756347445072;
        Wed, 27 Aug 2025 19:17:25 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7454eb2816csm63490a34.26.2025.08.27.19.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:17:24 -0700 (PDT)
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
Subject: [PATCH 2/5] PCI: cadence: Fix NULL pointer error for ops
Date: Thu, 28 Aug 2025 10:17:17 +0800
Message-Id: <fca633eb6d667a90f875cdf1263fcea2bcc2c969.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756344464.git.unicorn_wang@outlook.com>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
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


