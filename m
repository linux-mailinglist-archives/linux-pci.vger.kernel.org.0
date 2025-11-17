Return-Path: <linux-pci+bounces-41445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E0C65AB5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D86AD241B5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D430DEDE;
	Mon, 17 Nov 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpckg3XJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA830314B6E
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403062; cv=none; b=kcXnDyLdGhVhkE/uPeiSuF75iU6EaLvlstdkWbj6P3R73bnH/fGioUeWz0g0E2XlQh6u2ZUY4y8EawDbd9uU6EDCBypWY9DnYWPAuSUfFwU42tHYnzMBIlig89MSLrsicT7JjZZwKSY0OEVzfxl4n/rLf1TGrCuZE28hTfOcACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403062; c=relaxed/simple;
	bh=dtx1yHWHEbSK/c8GNo1HpXQJQvD4eT8Atord9bhcDCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWSTxj9sX6a5y6AikOpy9YK0Q8ZhxJcoJlcKlS6c1QtHoI2ixBQSThWBMPqlIY1CcwT//ZyTBZwF1cFFGVMz7gVix468GXF40WIpb8vY929MH8TT8j+RdlEI0Ot/mYDrs4xYY4BBcZgNAW87JJzxmYT4SQo6BWcx4C38oalFaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpckg3XJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29806bd47b5so29666335ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403060; x=1764007860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gazcyDKCqVDM4NaE88dT10YpQkqHH5/XsZTj015pVas=;
        b=fpckg3XJpcCOD+UP4Qoai2osjLmgpeAdSvZaRSjB3+rwqdK922TXKdI8X++t0cdmyq
         +vWiJ+/Xg1qT4SXuBMx/6pxTtUU0BOudjQ7/V3AfIYLkI2kA8AmuPBgcus+llWGXuzZ5
         SWYz8WS1FCmQDb+o+bTw8HOzUwub9mSCcEEkrBwuK8QhA4ecAh+LRgz2B73jo1jNTiOB
         emzBAx0tKajnD0ByulekXMRtSB0wL+xQJYWylaHCo1FSfU5br9ZujrNfdyPrwgKWRCzd
         gwT1y0tFZcUB8T2TLlQLLbsD5eVznW5gHGTgZKBbOX71PBzNW4lR1Vp1dHBCXahYy1h4
         EOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403060; x=1764007860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gazcyDKCqVDM4NaE88dT10YpQkqHH5/XsZTj015pVas=;
        b=g4LARBGXGjvJceuFfHkv13z9JDPVECLa5FkEp4ZbQlUXpIYl4wilH0IeU907IdVT8b
         jRkObMYuBrTVCk8NMlEzAy6nRBWdmNRgxia3N21M+ojNMR2m+cN6ZxOmwE4ng0qoRJzm
         KEp/p75IZpnWaWuF0Qbob/QJyWCK36bnQqoWZFGfp6UHormkg7IuxMfCCjcE+X4bpSxM
         k0Rxy4g3uB8iKTx6BMvrmNXpZFjecn5AA9PT8jJtrcq4hbbuiwRXr5n5erfp60AdedXF
         acqs8C+67G/NyxzabU10OK7Xa9C7YTlG/kSDAPN7GG9U1S67asE6/FwzK0MEFyV1ahW1
         U7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCX3KE6kfcaGRpimyW7goFc4nK97f5vFgQFyCXXqdCtk9kXFySec3+XmL0isROHDZAuLspPjDABd9/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsud3S16jybjakavqQad/YE4wVv1k5q1R30Gyyihk0XaMxd925
	iBlNpXrbqJK8yHpupG4eusDe6k/QAPRPy25fifMEfc5WgQxAJX7CjiTF
X-Gm-Gg: ASbGncux7QOqO0/VWwvG2HhKbSXV4oAkBtdfLpqSTI7OrjoLv5lPSaMbjxy8YcdTFgp
	NK7JZjmGf3YtVr5bU1yZlQORW/3H+SGLIiI+F1gHtcWyYSRhXQjl2cnyvpR/xydcZwVPgizmXJ3
	Nk7vKw/CllNPmANISJRQzEiRQyN3nVcHKXTdfaJJHesxNaARUn7RUVpxXgPPn1IZ0iIEBWBHpG0
	uS5EtqzokVuPNKR+8HlL/YdnhebtWErQaOjctRD8OGIKLAoM2PWv7r/YlvV1StGxfUnieeThyF7
	r+dmB+pxPwYPTbhb9xfbgeqsi+2X0Yx485ccwJWxSuGunLz0UsxHY42Bv7kuZ21YSJOoURqgR+G
	dNXWRQw3EMuH2cGdnhXmmNAEv94o4tip5bAQpFU0gnxgoG85Q7fAF8qAfYNLpYmFbjDuVghVuOx
	1yetmX/7AOkMD6VRqz4vM=
X-Google-Smtp-Source: AGHT+IEH430mBOahI/CtVHCqRSIqCGq9hYMzLu8e8nwRDN0slBe2X4NbiY309RgQgf9w07IlP9p0SA==
X-Received: by 2002:a17:903:ac7:b0:295:557e:746a with SMTP id d9443c01a7336-2986a6d04femr131798225ad.13.1763403059763;
        Mon, 17 Nov 2025 10:10:59 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:59 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 5/5] PCI: rockchip: Fix Linkwidth Control Register offset for Retrain Link
Date: Mon, 17 Nov 2025 23:40:13 +0530
Message-ID: <20251117181023.482138-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117181023.482138-1-linux.amoon@gmail.com>
References: <20251117181023.482138-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per 17.6.7.1.21 Linkwidth Control Register (PCIE_RC_CONFIG_LWC) reside
at offset 0x50 within the Root Complex (RC) configuration space, not at
the offset of the PCI Express Capability List (0xc0). Following changes
corrects the register offset to use PCIE_RC_CONFIG_LWC (0x50) to configure
Retrain link.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 drivers/pci/controller/pcie-rockchip.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b3c9b9cbeb8d..aae3def64bf0 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -338,9 +338,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		status &= ~PCI_EXP_LNKCTL2_TLS;
 		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKCTL2);
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LWC + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LWC + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index a83ce7787466..5bcaef7bba4c 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -160,6 +160,7 @@
 #define PCIE_RC_CONFIG_DC		(PCIE_RC_CONFIG_BASE + 0xc8)
 #define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_SR		(PCIE_RC_CONFIG_BASE + 0xd4)
+#define PCIE_RC_CONFIG_LWC		(PCIE_RC_CONFIG_BASE + 0x50)
 #define PCIE_RC_CONFIG_LC2		(PCIE_RC_CONFIG_BASE + 0xf0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
-- 
2.50.1


