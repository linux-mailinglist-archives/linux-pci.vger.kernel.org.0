Return-Path: <linux-pci+bounces-35973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9492EB5406B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EE0A05FE2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8B1D54E2;
	Fri, 12 Sep 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0fDsEYz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8481DDC2A
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644574; cv=none; b=OIA/xIsyLeyU3rcZfMCgoL50xioiCrJ8hLvCE49Ho5thvz6WOMpQqzve/3HlDTkyA+5WB/feND3T2frb9AO26EyDD6umbMMp19IdN0efG6ll0awdUTTVoZ+7lItvClDUKvguv7QauuiF6G3+yHrG42vSa41dimacyI26TQEWiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644574; c=relaxed/simple;
	bh=OS9j70HJBgJdnu++cmJduNYkDHIWHGvyM1VZ0y15w7w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZ0EXrc+1rRU/kBuoG4mzjktapoLSB8rD+DElalGESvFpFDk4PJByYA7YTaLV4Vsus2vjOCddetf8ho8HuUTd0Qu77ISj3R8t47uee00KVJJaYOSc9NLHVsEVtzj2yIHkAIdZwBoq1DgpZdOiFNT61i1EKv2cs/qYT/E9q5G6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0fDsEYz; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74572fb94b3so1380985a34.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644572; x=1758249372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufI02VTMyX7sTfBD7Jn/jEH2YUmO7DVAO0QyMj+WG88=;
        b=a0fDsEYzjupumHzUEZX7w3gdCKWt69cQyHCAPnru5K36PjhBZYq21FVU5NGRA1sgUG
         OsOIZXy15FtaOfp/KaFkCFSgFeolS2LjSjpUXIInxa882LRS720yjZKMtEjUA8bhrv0f
         uRsvz560d57iBFzvELShVo6NR7fZ8dk8Cd0PqnRE9OpU2tdo5Mrv7b5vU2FXxw6kfYJi
         Jb0Hn2lUNPoSZGg5lzA4AyYI+Hu8RokejcfBYj/o7+X0E7sLJ4wGOvXvLsL+c2IiUNTK
         N+rk9LKYdK7Dd1lfvMaL6ftCzol3qh7cRt4EoFDcXx7nnrmaQRNqzh1K6c6g0zt+h6XS
         25JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644572; x=1758249372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufI02VTMyX7sTfBD7Jn/jEH2YUmO7DVAO0QyMj+WG88=;
        b=Oi7nVMUj4xCAhsTChDzJikQGvsL0KGbGSnlQ+BQcKDNa5W/fvkHD7YCvCQbxp+sHP9
         TWntqsSD7fjySp33gb17tXttUzobLMV7ndpSQUrruKmh5q43t3+Ca0Xgn2MSJoowjrG3
         C6mBjLyZHc1oSPL9Iczwh1IHAxjLXGIP8fUODQhE/Gq1fMumDnlSIsRnW0gvlZefYxDS
         iLzHHoQt/ikVnYih6i9/3TdxXqStN8utVpvAadDajY5RAmoAOwsJLLMYLs1pE6SHkSXE
         vOdM6yOBs/zV1+aU5IIXYY4yoDgbMOY79XxtybrXXi2f7bfbCdvz6i9u770o49IJdnyB
         LEnw==
X-Forwarded-Encrypted: i=1; AJvYcCWn6WN2ueUQ4XhEoGpA7hzZ9/Ta5Wx7yy0GmHNjtEN03D7z1h5YmPuJ6fADgqymiboOEVOoFJbeBMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwWeAKzOqmpDZlK4ND5ZoV1jW5ZL09WMgEfBjIE3xuRCwr3AE
	xTZEdEFR9r7Pty1a3PJK5qBtSnnV8qwBqwbYpdcmNgVtNdpZ+X86tDXa
X-Gm-Gg: ASbGnctbQCGR4yRqzOUNppFMBkc9cxiBCwz+aQnUem0G2eP8xnn3iRu5XHllhh4YpkE
	5sSKtJ4u0Ebk858HPtDD4u6/p8puhix1Mff6UVXpXysGcrWA+/EdH3PdzMIlq00/STxiIrtUv2d
	6sLFNZAY84wgMpAq0XIOulASvkfmm7HfjBnyiUHwa6cnCiqWXsMoz+/bSvkNdO4o0lPRVI+nCiw
	ilvAs6bB9Eg1yePI3czOAGtezUiSZpf23HmdARJwlCUC97KysRaqx1vDbavb2qGfeXe/zYSLn0E
	I1FM2Iaf8qRLvwchMnbj9Zdmt96qw9fXxIpsXe8q9L75EqpgP7UomPdjU+Z+bhOSn0n0mHADBhm
	nFlfsKSNP9yK7W6r5HBlWYfV+fd31I2M7
X-Google-Smtp-Source: AGHT+IHP2whgLxUbkCPCNG1W78sKOKWUGbVdpP/qwDmDJygd12n8LXTyx57fCwWzBECssKtsoYm6OA==
X-Received: by 2002:a05:6830:d10:b0:745:3cea:c705 with SMTP id 46e09a7af769-75353875ddamr997804a34.14.1757644571861;
        Thu, 11 Sep 2025 19:36:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7cesm752506a34.11.2025.09.11.19.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:36:11 -0700 (PDT)
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
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 2/7] PCI: cadence: Check pcie-ops before using it
Date: Fri, 12 Sep 2025 10:36:01 +0800
Message-Id: <35182ee1d972dfcd093a964e11205efcebbdc044.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
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


