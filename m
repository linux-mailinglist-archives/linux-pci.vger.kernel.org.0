Return-Path: <linux-pci+bounces-20778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47683A299E4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C541516AE24
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6551FF1BA;
	Wed,  5 Feb 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HSv45CGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A4213E61
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782779; cv=none; b=g8/Rc6rY5B8BhzxdD7k9hTySp+6n68sRlkIemHTLJcNnOdNZNsfGCMR5rTMcpXPWdhQ90dNyrBZywCYu/cy+yHXvcANxJO8ANSAQhQRwIZ0nCfxqLgPs99Gb/1whVQrv8VNYmbGlLSKS0lPQgtv69UfNtI1ufs1DaWN7Lz+xwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782779; c=relaxed/simple;
	bh=emQr1WRfTCyFVdLp/d2GBD9ikd08vqQkCZbU50KHAFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb5PmV7vAD1NQShP3n0hGlCRDKD2Rv8f4svZey2XVr6kNWUx/SiGZMy6m6ojPke2eVrYFLK6kKqd0qhrH6psEurrR6MZhLrd9OfedhJhDSj97J9+hnJNk8K5WsBDcngAotWbO0xytfsTIcO5oaDAM+KmrwgQEnassDLJMN4ZQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HSv45CGI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f21cc7af5so2365235ad.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782777; x=1739387577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyxoQmP+DrPfyNDFU6zDEUm+WeVsHxsrhuRbOaUfCms=;
        b=HSv45CGI4Ea/sVTKiWPO4a1fFgb16sYlmeXa3im+0zas5xWxvtSsIpSzxB7MBVaf67
         LPOSeq14W5qHUVwsa1s9iM4Iin+3NCCmoqr//zfjNLs9tjbZskgxmplAMV/wMKFgRG/7
         1CkuMMK+foScvUgPApFlcgGxZ8wRQn82P4+bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782777; x=1739387577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyxoQmP+DrPfyNDFU6zDEUm+WeVsHxsrhuRbOaUfCms=;
        b=mhpN+mPIpq3ts+e4sLZElGAB7aJRl+TnUyTR6M72hJfx2CfDgeWYJCXLb7yfBFIsgN
         XdHD3vxDptB30lLF+wmemXSJZPcpGZxPf2f0EuKyDx0XLpBZTL48tUz2DqhRIwh88IVI
         Hs/X3Mp/hf0EH5hrZVsqDUEgAW0XwMcNjqmbkEWdo4P1h55H/RzeY5SHL9ORWIeVgnGG
         5kWIQ9INNDh1f9RTo360qdVEN2rJ1OdK0ighpsw37q5s51dxMA3Gp+7c8uHcT/2aUss3
         a6Hxhf+gUNDrWgwKdkRWVwmbOu4n7v3DACb6jG9iSUo2MqZ/txyz3rn6CWwK9kPFdgD6
         5KOQ==
X-Gm-Message-State: AOJu0YyfVknwRgK2ldtc9HMZiWcBeBt/FWm1WhcDvKm5JxJjQDrkNHy4
	AVptSD5FOq1qwsG8fY5RxPKI27ueptDMTpX9xX7pSfRNopvlWuu4WndghcSHACIgilUNHxPfXe7
	YPWaC86oU3HWLqi2XZHEhlimUYhHuL20NVoj6UtLxdxbtjhp6bD3EjCADAPuPywE3EEEuS6DA7c
	8/GKhxBNZa+4KDgOeBVQ+a4RctIIpceVx72Timp+URwaIDFC84
X-Gm-Gg: ASbGncvXKE2ctawN9ETr4nUptmFWjiGu/mkWJVsy5HOcKGDcilCMX90ouYVHYZFTU3W
	7k+NwYmlto1/hY/KcR8LavppvPFls4Q6OgC8bEsCdpS22f/3cg/KNwCobk8GNBm+x4usCeVKIno
	9tOR+F+dR2nF+16RYayfhMh1aUtNlsaXDsAViZv5/rZHLJOHAyn+cX+t3LFecCkDgtWVWEFuUm9
	bVcpeKAfSyeRnBnbk0mgbArBNT9RTA8kygs9p9tEmPEyGlKGPL7FsOw8OCRVWdZvPjTWjtTY44c
	CIDhDQ/LJw0NR2rk87qSjZouwXCpzRd5rqMIXh+Ta3G7xOODXmZMHplWCUzL+vWYluQ2wmQ=
X-Google-Smtp-Source: AGHT+IGu6hun4FwjJUr/ASi5VtU1r7KzOWGkU1swFqWYgTtfTk7Rzk7GNGUnU+ZBJXjxJW+oGt6ZSw==
X-Received: by 2002:a05:6a00:3002:b0:725:b201:2362 with SMTP id d2e1a72fcca58-7303511e562mr5701360b3a.11.1738782746930;
        Wed, 05 Feb 2025 11:12:26 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:26 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/6] PCI: brcmstb: Refactor max speed limit functionality
Date: Wed,  5 Feb 2025 14:12:01 -0500
Message-ID: <20250205191213.29202-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205191213.29202-1-james.quinlan@broadcom.com>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make changes to the code that limits the PCIe max speed.

(1) Do the changes before link-up, not after.  We do not want
    to temporarily rise to a higher speed than desired.
(2) Use constants from pci_reg.h when possible
(3) Use uXX_replace_bits(...) for setting a register field.
(4) Use the internal link capabilities register for writing
    the max speed, not the official config space register
    where the speed field is RO.  Updating this field is
    not necessary to limit the speed so this mistake was
    harmless.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 546056f7f0d3..f8fc3d620ee2 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -47,6 +47,7 @@
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_SPEED_MASK	0xf
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
 #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
@@ -413,12 +414,12 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
-	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
-	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	u32p_replace_bits(&lnkcap, gen, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_SPEED_MASK);
+	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkctl2 = (lnkctl2 & ~0xf) | gen;
+	u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
 }
 
@@ -1324,6 +1325,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	bool ssc_good = false;
 	int ret, i;
 
+	/* Limit the generation if specified */
+	if (pcie->gen)
+		brcm_pcie_set_gen(pcie, pcie->gen);
+
 	/* Unassert the fundamental reset */
 	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
@@ -1350,9 +1355,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 
 	brcm_config_clkreq(pcie);
 
-	if (pcie->gen)
-		brcm_pcie_set_gen(pcie, pcie->gen);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
-- 
2.43.0


