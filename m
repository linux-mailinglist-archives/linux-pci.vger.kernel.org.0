Return-Path: <linux-pci+bounces-21503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6FA364D0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB09171BB1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E64268C54;
	Fri, 14 Feb 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="exceKfgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7D2690E6
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554805; cv=none; b=eqKs0IFg6LlA09Wsq6fe6O8K2H5mqlOr+hGN2IbRyirTykYkC3g+vALf0saApx/aMedXIjhi2duUZtkOxkFcdFGADrnkvzQGW/n0sfninC9rngxadAqyu40DZFY/WEs1dikFUE3wTM5DP+se1VN5vq5UX+EbqgQ56nTiKFfYopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554805; c=relaxed/simple;
	bh=lsg4Fcw8VcMaHZ6PHXq4ByEugOSBshba/6E5rrl25tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTLho7B5SA/wRTKSEGrJPipzsWscpikWFM+XrZRfGXZaYGnjsBxuizEOaQYRfxM4mi43XEBpmMB/+QR52OTuB/EZ8BR6+InbfFCo7xp/bizUPx26k7a6h68yxqamKtyMytgLBhAGaD4VC3bwIe9ACxC65O4tZA6S3VlHzFWIdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=exceKfgg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f4d935084aso990546eaf.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554803; x=1740159603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucKiOpBc+S4NSSHbPlsmk0SXtuaeNxQ7iIuZM167kvY=;
        b=exceKfggvwVwPwKg7SYRopQVAV81v171osSSePbwsLvvaqGiEN2O74Ta5eWgPJIJb6
         ydBKbeI06ppsIZAD1Ki0UkNB8MWNh637z5QpZpvj/dfxu+YGJj1o8D5krc7KX/YvbYwD
         pEbVv+548KVJSjgO+jDHFvaBsQ5z48EveIyHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554803; x=1740159603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucKiOpBc+S4NSSHbPlsmk0SXtuaeNxQ7iIuZM167kvY=;
        b=FCzHJC48oyaLdHNKg/fbDIjJ5aSGG4AIGY0LBKIBG/WBUjbiSfpT+qpDfRmIKHWcdD
         bDJxWBX9qFfzZcltOjnRRou1ysUGRztSbTEsH5zW0kAmNKXxAbAOwI9uDc1IeSXU0sRj
         JwCeCqZZKJmztohkH4rTWOkeMNFUmzX1qj0D1fqf9wNphheONXzUCNOro4tjCDDy2++r
         eoDJIAbFj4FulbJV10fWucoGG1fLyNctGYogFulsSshzUkd4pkaRa4PJntZDMUDU7r+x
         WLPsiOKvYVazz/12xTYNRuDVadCzpiOukO6scuU3UxONVMKGiVwejv6xfTILaZ2WDvbb
         uvhQ==
X-Gm-Message-State: AOJu0Yxhw9ZokE534swyDTBpc1K43uK5Q76I42PEcB5koi9GRTUcaPCQ
	g6Pp5qudDcnpsA8cGdi/0CFIf78eCCv8Y91bhDd43JRK+BiV/jLggfEmNRihBsdQGFNKeu3gEiC
	tuo3xf4lQNQHX0apD3oX4H9RkFOZhTcpBPtIRaBuBeZC+dVhRs9/b/q2d1R3cst8X8XIW8jPnNF
	HGx9jsRiTUuPPtPdbmPkn4PsSkVIuCgqwhdfZI0ZIYFRhpfXg7
X-Gm-Gg: ASbGncsOR18uQMcORNZf52WmSESKmVpUzABNTTMC5wAU1R71rFz15HyYqxOa7K/lSIe
	60pskUyPr/iGeLJrZANizqW106FTRJvvI+tjTnKdMwtRMgALi+PSWa09h4j66odmQi24iPmuDbA
	y0XaE0dNdV8bNqAaljKb+G6QvJGvckQSHIckGYVd89gtJhlN9uAE9BAJj80Mna29dKV5jyIeJqD
	3jSJ4p8SfXIXnXKo+/uZskWypuXwVp8S4wZEuIJVN8hxKx/3ECJpMZ3pWlQWXLHEYkDIQ9XUzWq
	Xrmay7kjjqGcPUIJn557q+ZVUtEzCP/BF6SpSAgvUAopoG6MrTMoh5795G0rV9olYzfiilc=
X-Google-Smtp-Source: AGHT+IEHCQouVhYnVU0zbdmV9+4+4+6gGSYlzxuVdn+GGhOSlftYZsrzvcgZIZVnH8WQyajm4LLIQQ==
X-Received: by 2002:a05:6820:220d:b0:5fc:ba35:d704 with SMTP id 006d021491bc7-5fcba35d7fcmr2395959eaf.5.1739554803022;
        Fri, 14 Feb 2025 09:40:03 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:01 -0800 (PST)
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
Subject: [PATCH v2 3/8] PCI: brcmstb: Do not assume that reg field starts at LSB
Date: Fri, 14 Feb 2025 12:39:31 -0500
Message-ID: <20250214173944.47506-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting a register field it was assumed that the field started at the
lsb of the register.  Although the masks do indeed start at the lsb, and
this will probably not change, it is prudent to use a method that makes no
assumption about the mask's placement in the register.

The uXXp_replace_bits() calls are used since they are already prevalent
in this driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 98542e74aa16..e0b20f58c604 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -415,10 +415,10 @@ static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
 	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
+	u32p_replace_bits(&lnkcap, gen, PCI_EXP_LNKCAP_SLS);
 	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkctl2 = (lnkctl2 & ~0xf) | gen;
+	u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
 }
 
-- 
2.43.0


