Return-Path: <linux-pci+bounces-11087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E9E9438FF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545CCB2542E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4256183CD9;
	Wed, 31 Jul 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4Nt85ZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B0183CBA
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464936; cv=none; b=J2rIREDvnL7zs2xVlakRiFAOGo5bkUdvYhCl2ktow/S62nfzB83Yt0vdmTTSnwob3Ihq8k9tJs4fEE4a071MZmjSdmIh0uJznVqa1FOCG0RsmCDksTtYpBlP848BzYsU/hQooTkyhG9q89zkxIOVHUTsKoW3wSRygCGg5oO0W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464936; c=relaxed/simple;
	bh=vMmafbjGGptgOc928LWw3HzijtKQn7umoBI3Z8nrrhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kgmGweyjDiBWFM7h8EY6Hh3fHkVQCPTdtIDY1Z6yHVK7EC9xB4pPhemWv7cuArVSJkdUVoJ7/QCtxuQS34ftYHrRHIVw4UaOgUOeJH3e1ulRsDjWT/M0d6wxeyeyQQDLRhyrX2ydCfabbzSPJJ9aP6M92Wm3LotpfCoFG7wF6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P4Nt85ZW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70944dc8dc6so3221136a34.3
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464933; x=1723069733; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=48kNXVxTxIS1qqb8DRwWYkv7S1xxdo30DtPId8NrWW4=;
        b=P4Nt85ZWFaJw34g5bso1bpAimKBVe4hcNGUKvo/9+HYteosKysA5dquwMKR3TlFTzn
         BScVbS5K1Cs0rNo0iKKhvLlV8+AfeLGTsHzraNshYzlDOStnOw32ttJ7Xlj1AGQVTsyv
         oLf/odzRidX6mkfPmUDZL86/BOTqKTCPNcVjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464933; x=1723069733;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48kNXVxTxIS1qqb8DRwWYkv7S1xxdo30DtPId8NrWW4=;
        b=g8wgXDmPxMUyd1Q/1oS49LjEJVtGgC+ObaEmkxT4fEaR8io9Qg3Fffqbuf26sescjD
         kJUE5OBtkege5rL8ey9RC/NE5sFOUiU21OctrjXYdKwjWPKqTTts7sswpddpbNGZKnzg
         7FKRKkchql3MmI1JmfbN8xkBqzX7kwSV2VyAr527JR/hbOjzhYzyie0x9KfXRl7L+BuO
         Yt5oqYTnQSxk1eyzDUIKgA5Ae8aOJPTurZlqjDQQdlG85h9JtuKTymuZlfFZLmZyvuVz
         ue6Fc9m1M7ZRvsKuczxeYK4QDgpZD1+A+spR0DEWTi8UXzN2qYnF56qtIG7Gt+PhTe/M
         OkFw==
X-Gm-Message-State: AOJu0YxCciOzXuCfF7yc5Nc1e/ogqR2YcJ39a5lSP0AgElT78Br9p7sX
	R7E60ERm9fTbvrB1IYLANC60j8TnmygcYaeD5ZoNH7CXJguSPtNOc1MCz5Lsns042b7dwhxsKhR
	FuBqosk3psBa7OKyZ/qzVl+KEXgNW88/r9R2phxtptPr74bezTBOxwG5lyp5yCzT1PzAoCGOQIs
	PXhHB68yWqIn4aS9Uus7RwAdY2tD1oL5QqXnUEk5CEcN9hZw==
X-Google-Smtp-Source: AGHT+IG0HTaGPAQVkMi4hiaQmCdPYjlys/O4jVp+HDfUjEJVYYKtUw47a6LfeJvzWSfPWDUXJnJ9nw==
X-Received: by 2002:a05:6830:2a8d:b0:704:3fea:5354 with SMTP id 46e09a7af769-7096b80ab4fmr546436a34.10.1722464933013;
        Wed, 31 Jul 2024 15:28:53 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:52 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 12/12] PCI: brcmstb: Enable 7712 SOCs
Date: Wed, 31 Jul 2024 18:28:26 -0400
Message-Id: <20240731222831.14895-13-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
It has one PCIe controller with a single port, supports gen2
and one lane only.  The current revision of the chip is "C0"
or "C1".

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4623b70f9ad8..44b323a13357 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1202,6 +1202,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
+	/* 7712 does not have this (RGR1) timer */
+	if (pcie->soc_base == BCM7712)
+		return;
+
 	/* Each unit in timeout register is 1/216,000,000 seconds */
 	writel(216 * timeout_us, pcie->base + REG_OFFSET);
 }
@@ -1673,6 +1677,13 @@ static const int pcie_offsets_bmips_7425[] = {
 	[PCIE_INTR2_CPU_BASE] = 0x4300,
 };
 
+static const int pcie_offset_bcm7712[] = {
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4304,
+	[PCIE_INTR2_CPU_BASE] = 0x4400,
+};
+
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= GENERIC,
@@ -1738,6 +1749,14 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm7712_cfg = {
+	.offsets	= pcie_offset_bcm7712,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.soc_base	= BCM7712,
+	.num_inbound_wins = 10,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
@@ -1747,6 +1766,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
+	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
 	{},
 };
 
-- 
2.17.1


