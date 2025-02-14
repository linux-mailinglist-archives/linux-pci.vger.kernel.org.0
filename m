Return-Path: <linux-pci+bounces-21502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316FDA364C7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EBE3AD78C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E32686B4;
	Fri, 14 Feb 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aBAPG59F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E12686AA
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554801; cv=none; b=s4K8tuxJXnWSQtsq75Yfoa84FXlyKCYBMYTfsRLDcfkKw1G9JHMoGWO3ail/vebIsVk8ozY5Hji0TbEVLIDoeFMzp50JbYvmHBDZzViRHVuPW2LDc4y9lwGpHCCjpJHCeJorN4zuSX/gE9bREUOK4IdwyjiHlKfmQVsd/kse5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554801; c=relaxed/simple;
	bh=XusFJlqd1Zppl59SKwtxO2YRR6ByM8N3PtB0xFQ1r28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtBcRmo9wR73OkKH1ivT8dd8coWbL7YD7iNH78wYnBI/SOkjLN55F4jBWihjPA8IKPEUN39wTplXI7yGRuzUrv3JmJdCTcizyynbGmW+K1DOWWLLLq/JdvmpMwMWEGZUKToXW8/Rd4nhL+2qYf7Kul6X82ejv8CW7trr5v0S5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aBAPG59F; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-726fe6dda74so1738406a34.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554799; x=1740159599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXbSVytevldhOW6yTI16BOZbfAnBjooyTrFkgreq94E=;
        b=aBAPG59FjBTI8KReZg3/NyNyh5Huh09xXsNN/x1FJUSy2SZmU4Yc3vpI0Ojht8BTfN
         ScELWebdlR6YLUrxEenS1m0TVIRRrPG6MUN6RpPygppYJ35ua4Vr6rbrGj8R9r3FWcQn
         WU1ih2XNqFK1HfNNGMuJZku5SyO6PRM2BTMwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554799; x=1740159599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXbSVytevldhOW6yTI16BOZbfAnBjooyTrFkgreq94E=;
        b=e7HZVHgzNSQbWQuqKqJMZ0x0SnxZ0oUUj1qNEo43IewXwon1hTHLLdqHnALJPZRhw2
         kAA/zry8epfVzaz5sUOaUvAMdbd3buzwZJEUZ6GqnKhbSWSVvQtekAx6VaLV+tv0lbha
         WAPVxBBD3yibKx3WD7PMIW884DFosGUjzWju9Cv1s4R+wUgMUFEvEhBgF90vq41TzFwy
         7XyMfU+Od/beYYHzCtZNZbco5Sv/1WgkldNd6rDXqxopbT2ZmEo+ycuFgKLWVAqLMhQ/
         VOvSo+5gt8+49R6cICuBXAj3m4qgmYkhpYHidbEQUT607QMmwaA3QcymGySciXibOe4C
         sIxw==
X-Gm-Message-State: AOJu0Yz+GEdbv+zHjT7e6dKcO9FLyHpVUQRzon1ml8Dk/kPAcZAL6Bep
	8F7v1ONEqSkoXT9jZTJpHEM1BYH/0ZsXhtnU1XUhwzOSge2oNCdvzFA4VRKK5KU7bCXNVJfq34k
	peAMa482/LUNXTivvPwNBIDJ0upHghg9iqr/NKld7as1NunxiM+skBEz44qdMwPH4+pWr0FT+cX
	E2dfQp0CYr5ko0yTo8++4duCUp1kHGblR126eEO5pF3DAbK9bv
X-Gm-Gg: ASbGncuoTh4b0BVetqhkQ0Hl3plTHq66S2iX9sBcvFaVTYmO4KH5I3C8w4EcOzIoO9h
	iHnHpJ5SkSCw6c3kGa6I7ii2qdkX0dGJIfzC8Lyti4yLQwisCO0jJj9pyE1hLUf8sAkgHtj4Z4h
	OsefqHMqwgXJq4i9nMMvxg4EJaXY/MOSyq2UT4FnqBtfP4EbRhYln6rBA3sQr/W+xQ4DaUu8/S2
	0a+gifKjPWVJYiTyY274Q0A7OqJ2QeHaj8V1b+OdW0xkUmKimyHHIUlasu0Dr0CnWgm56Gvh2hS
	M3PApaqzmjakRaSD+qfHzL9WBQ6FPPuVLLQGV3NbWS+vHO+S+J71KNUOHnwIhzFjGMOh9uw=
X-Google-Smtp-Source: AGHT+IHswiwCPm7v4tYhF6/KFpk1Gc9mqP45iu1cae5YdAzQ3o5pgDycSQ+Qw63bZd0jTXMIoI2SqQ==
X-Received: by 2002:a05:6830:6e9a:b0:727:ec1:73ad with SMTP id 46e09a7af769-72712043690mr27736a34.11.1739554798795;
        Fri, 14 Feb 2025 09:39:58 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:39:58 -0800 (PST)
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
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/8] PCI: brcmstb: Write to internal register to change link cap
Date: Fri, 14 Feb 2025 12:39:30 -0500
Message-ID: <20250214173944.47506-3-james.quinlan@broadcom.com>
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

The driver was mistakenly writing to a RO config-space register
(PCI_EXP_LNKCAP).  Although harmless in this case, the proper destination
is an internal RW register that is reflected by PCI_EXP_LNKCAP.

Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 64a7511e66a8..98542e74aa16 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -413,10 +413,10 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
-	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
-	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkctl2 = (lnkctl2 & ~0xf) | gen;
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
-- 
2.43.0


