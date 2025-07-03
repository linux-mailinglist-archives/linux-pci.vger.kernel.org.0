Return-Path: <linux-pci+bounces-31466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E47AF82E6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5483A6E3156
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613D2C033C;
	Thu,  3 Jul 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ETbzGj0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADA23BF9F
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579609; cv=none; b=KqdPcUxKuXarbTNpe4iBjiLOYmi4HNxZHkGmf3kSlY9PB/NbuEl4A5+kFxN1loQxmkx4anGFwW3d+q7GEhucHB4ULhcQ2KT72rYZqqf369nT+1d7fVoygbjiymDomgtR+ZmtWw1Y2hQz9hRUIivgATh1OaMRkmNxNxaOAmfjiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579609; c=relaxed/simple;
	bh=+4mWhPKns0RSEJTdCXraQDLnv9KiyINud1kAAW+E3Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvTY9IRQmP/vrhUxMyNi68EGGK7rk4Vj1tygfgU/f/cL/8Ymi1Eg3lu8847J9UX2VlMEN7Cpz6gZLr0cjqoT8k9orGvtLJTvfR1eQa/l4n8j+/GLLkWFWvMhY6jRGXCJ3lUPeN3pcFx9EEx4drKz+5LOBNqG6ULe+dtIgq8sEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ETbzGj0E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo5456905ad.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751579606; x=1752184406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibqJ1qfXyj8EfT7QyMpwHVnExe5FA06OoPBrLNd9L70=;
        b=ETbzGj0EresgGiS8eBVPdmc3lEN4nQVDw/e9lnYTKCjIiCxss3HWtAJ7aBapejgTwW
         NmV/ODZE+3FsUfQSGKPL2BG55FyCEL3VT/eaABnVqFg8eKFilv+/Mdkb321hgVP8OPWd
         9dKs8T8PIOn+0FAkRpU0x88VWrz15A5WpK8og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579606; x=1752184406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibqJ1qfXyj8EfT7QyMpwHVnExe5FA06OoPBrLNd9L70=;
        b=ryU9GVzHbCpPl5ANdQ0WrJZU1sT7bJtmw6iaCzhDYBZJrpyuv/yPRuDfDbkYYz8mbo
         rRCUl4scjc63eFU3QrbmzG0Y//zz+u0cq9bP7k+O2thMmhSiFdCgvWDQzhfpRyDSw7G8
         jHAAa2DfadEPZbWyZmI1lrgOqsYS6Avm1RqtyRrEOWb4jDcSKNIP8bMloPyK6UgNqjXF
         cBDP3kOQUvvz6bDmFZJacoCURyE09vWZrhSANbgewGJDMyRDgejOGiyeVjEao209PrVk
         mFuyb6PlupcHKCE2PNkJbfCFJt0cikHTZl0cPlk5ljjUoPz6Ff9EsdNRVpTeqgyu5SO9
         AmHQ==
X-Gm-Message-State: AOJu0Yz9fTK0r/+lcDF8BB184AGb7nSgoKg85yymb89mMMatuhnV7Uxk
	GweAFl6a8KKl+W5Vz7W+C7IWy+WMoikGuUwD4XgmuRHWt1r2DIIAy0WCh8Pffw/ooYuQjUoXAQe
	Zb2B3103lGXzq818xaZ++kCo7PyIB0R+hqkinbkeNq7/Yldb1VpxKBPptUVjpNxxUTMbTPQlFVy
	QCpK/fbnLyITvP/RAITIdhum9p/l55nonpDLiMyqEvxlQyQKTftQ==
X-Gm-Gg: ASbGncsfNni8DOdCcS1vmiyiWbaknGhZUt2qrtHqFNhiGlGYzAH2tc8MT8Zzlt6KUjo
	bxaMCsMwowF16UxIF7X9FEX2jjvpT/MOSHszlzNlXNUJzlBsZccupKLg/rmO0f/R7dKvnlWzdjC
	HkWiVmSTyZwCfmz253LGQmBM0J/CU+I2pahp7Bx+3dHjwSJ5Bq51CkYd9zPw0xXubR8elFG0ooh
	+l7BZkS/sWTDEj0fHcnbRkXDgq547P1LrHT+2tdKkcP6Enb0KEhXmOQjLoY5e53/qlx/iXsBvV6
	4mgyQuUfaJ37VjYr0nbtqCqsHOCx9m0vljiMnwj24PnyfvfFtEb7xoHaGIcF2NrrFwyQe7DkGGH
	fX/4H7k5X8RPG69XW8pKi5tSYRnPeAEKDVkDTYkDomRcG/4TE1QeF
X-Google-Smtp-Source: AGHT+IG43raFFh4Sga/+BHu1LSaZfdBpoQXF3HpuWwfM1okK6fDZ+ygvWWjun6fbVM2HU0P90x4sUg==
X-Received: by 2002:a17:903:1a03:b0:234:a139:11fa with SMTP id d9443c01a7336-23c85d9e22emr5623665ad.3.1751579606352;
        Thu, 03 Jul 2025 14:53:26 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8459b3a0sm4249645ad.219.2025.07.03.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:53:25 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] PCI: brcmstb: Acommodate newer SOCs with next-gen PCIe inbound mapping
Date: Thu,  3 Jul 2025 17:53:12 -0400
Message-Id: <20250703215314.3971473-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703215314.3971473-1-james.quinlan@broadcom.com>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New SoCs are coming that are not encumbered with a baroque internal memory
mapping scheme or power-of-two restrictions on the sizes of inbound
regsions.  Enable the driver to use these SoCs.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 61 ++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5c8aa5e36338..362ac083e112 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -152,6 +152,8 @@
 
 #define PCIE_MSI_INTR2_BASE		0x4500
 
+#define PCIE_MISC2_BAR1_CONFIG_SIZE				0x4700
+
 /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
 #define  MSI_INT_STATUS			0x0
 #define  MSI_INT_CLR			0x8
@@ -282,6 +284,15 @@ enum pcie_soc_base {
  */
 #define IS_CM_SOC(t) ((t) == BCM3162 || (t) == BCM33940 || (t) == BCM3392)
 
+/*
+ * Newer chips (NG is "Next Generation") have simplified the design of how
+ * inbound regions are mapped to system memory as compared to previous STB
+ * designs.  In addition, the inbound window size is not restricted to be a
+ * power of two.  Such systems may or may not have an IOMMU between the RC
+ * and memory.
+ */
+#define IS_NG_PCI_SOC(t) (0)
+
 struct inbound_win {
 	u64 size;
 	u64 pci_offset;
@@ -1008,7 +1019,8 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * memory.  That being said, each window's size must still
 		 * be a power of two.
 		 */
-		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base))
+		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base)
+		    || IS_NG_PCI_SOC(pcie->cfg->soc_base))
 			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
 
 		if (n > pcie->cfg->num_inbound_wins)
@@ -1020,6 +1032,22 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		return -EINVAL;
 	}
 
+	if (IS_NG_PCI_SOC(pcie->cfg->soc_base)) {
+		/*
+		 * STB NG SoCs may still be limited with three inbound
+		 * windows, and if so, the last one should be disabled.
+		 */
+		if (pcie->cfg->num_inbound_wins == 3) {
+			n = 2;
+			add_inbound_win(b++, &n, 0, 0, 0);
+		}
+		/*
+		 * NG SoCs do not have internal mapping system that enables
+		 * multiple memory controllers, so return now.
+		 */
+		return n;
+	}
+
 	/*
 	 * 7712, CM, and newer chips do not have an internal memory
 	 * mapping system that enables multiple memory controllers.  As
@@ -1120,6 +1148,17 @@ static u32 brcm_ubus_reg_offset(int bar)
 		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
 }
 
+/*
+ * NG SoCs have configurable inbound region size registers (as opposed to
+ * having to set them to a power of two).  There are multiple contiguous
+ * registers, one for each inbound window.  This function provides the
+ * register offset for a specific window.
+ */
+static unsigned int brcm_calc_config_size_reg_offset(int bar)
+{
+	return PCIE_MISC2_BAR1_CONFIG_SIZE + (bar - 1) * 4;
+}
+
 static void set_inbound_win_registers(struct brcm_pcie *pcie,
 				      const struct inbound_win *inbound_wins,
 				      u8 num_inbound_wins)
@@ -1134,6 +1173,24 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		u32 reg_offset = brcm_bar_reg_offset(i);
 		u32 tmp = lower_32_bits(pci_offset);
 
+		if (IS_NG_PCI_SOC(pcie->cfg->soc_base)) {
+			/* PCIe address */
+			writel(lower_32_bits(pci_offset), base + reg_offset);
+			writel(upper_32_bits(pci_offset), base + reg_offset + 4);
+
+			/* Size of region */
+			reg_offset = brcm_calc_config_size_reg_offset(i);
+			/* Register value has granularity of 4k units */
+			writel(size >> 12, base + reg_offset);
+
+			/* CPU address */
+			reg_offset = brcm_ubus_reg_offset(i);
+			writel(lower_32_bits(cpu_addr), base + reg_offset);
+			writel(upper_32_bits(cpu_addr), base + reg_offset + 4);
+
+			continue;
+		}
+
 		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
 				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
 
@@ -1264,6 +1321,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (IS_CM_SOC(pcie->cfg->soc_base))
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_FOR_CM;
+	else if (IS_NG_PCI_SOC(pcie->cfg->soc_base))
+		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
 	else if (inbound_wins[2].pci_offset >= SZ_4G ||
 		 (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
-- 
2.34.1


