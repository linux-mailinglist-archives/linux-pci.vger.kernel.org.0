Return-Path: <linux-pci+bounces-27531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B667AB1FEF
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B531DA05C7E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 22:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77826462A;
	Fri,  9 May 2025 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BOpGrQ9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AC264617
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829714; cv=none; b=tJ7K9khCiBg+tMro09X+Ht6FQF3nO3zrFI4GVVx/MZfhi8vcvMKE7Al+UlXMkjg0PswjIsXX/2fJiLmY7dAI5Ye+c6lXTRHJsqAfAJLHpMADhCQK4jC8wCjmAePX2WnGE3fM5HgtAnJ7kqQ8n1A9oz2VYacS36E2mzUaPsKpdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829714; c=relaxed/simple;
	bh=Kjsjk4e5aC82Vjk9dZ6KH431FG2D7hzfomRJ1yK6eTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfotonVo1nZpByknNXJqgsc1Efix3s237snrVaH4oc0A+m7HwYcTEzWJfn1WitbKTpWzI44ohAXTxTFNK0JnCa4DnuJU4o7nytDo9hkM6YyiGgtAkdr6ZII0N/cLWckfrccBHEwgeQf2T/H3zq5uFGKFJpArNbIbHz4s7ptoIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BOpGrQ9o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e45088d6eso35234615ad.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746829712; x=1747434512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r01UKsFQHMizWN+7NERjXgKGoiCMs947wub+Eu3dEZg=;
        b=BOpGrQ9oUGB0g6lY7odfU31mAkiI3UG9/Mn+YF+MkhGPP5Lg2pDsLjUu2YiV82OdOq
         idfLEaOhOXwzLvBQC6qwPTkkktbhp1g7Yyu4wf7vfQ8YO+Y57/vIP3D7R9R9tZ/CWC4Y
         9QuGpkWOOdzHJEhjf2N1pUyWyyaiqJlRRF8bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746829712; x=1747434512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r01UKsFQHMizWN+7NERjXgKGoiCMs947wub+Eu3dEZg=;
        b=IA1Qc0WcEu3p98CL52FSUBLQwdT7+g49WtPDIJnA6/DhmcyyRMEGMyHZDTeiKLb42V
         iEutaefuBLnxObRhd1Q7Tem1VgQFKrooVdn1nwz1cx13kAR6912f/VfqgejHXkXQ+J+r
         BXefbxpHtGwInjoJ7/jOCF3zZ+qYLo6jzt9VHftGVx+Zze/n4CL5SGOr/H201WQlRTVJ
         fjvpEqgYEXpGKkfYHyz2pCxbSfhGOkqtroDFlplfBfg7W0SvEvgWYEmyV0U3ClGB9adn
         ZRLndKkHb/I8fC1SccP7GgcOI5pRzrplYyRBIXrjS9L2GXg3WalZeNLAFpiqMbsczFeX
         PNiA==
X-Gm-Message-State: AOJu0YyGO9mYPwQQrbBKG+JFs2z3pm6xYEjsGKeyFjz9q3tZwV3qR7Yh
	4AlHLc6tPxBzXXWakVmrzG72/oOm6Z72aXtrrlkD2L0mJ8iuA4vNoTKwgDQPteOd/KQvdqTlbiN
	GbqqblHWzj8q4O6CRXudcNfxGS0LPTGHE5bdUJ+wnErm1X6VhR6/waqgO1nja4S9hunvFixDuDK
	O1wgwzAVMwjfWIjWeantQy/lgydnny1a5d3+k9Iq6qr98vEQ==
X-Gm-Gg: ASbGncspCAztZ/T6JiRP2iLOk/nAzzm/y6edERqo5daZcOF8vXDma+LQAUIuWsukNll
	aetohuusjGd4TmEKyRePPtNo1lAcVxKzv7MYeQ4kcxUgW8klSdpNLVsiqjZvYCWh+O+J2dSSrPA
	5rApxVJFFDvOEV6/5IvSRgIWLEQIFziht6aWgNl0It84GwX2P0b6BMmKqaADEeRVfsW44C6ThTy
	Evy8jOmPY+W1473gZn92U38U5G4n/Kg8KYhjXupTPecg9sFkQ0xT4t1cPmgPglT4VBF9MzhZwPo
	6tZO3PPGbhxd/ik4XWVJ3R89fz+74DknP2aFRm8qSaxsebFv9rKAp5L22ZzRgmVxfdPzdFYcg6K
	ohhbV5rhsskCMKaOYQDnIPA7anbcyd/O1DPA/RJ74uQ==
X-Google-Smtp-Source: AGHT+IFuDBZRbVYjG0G4X/dCVr4J6+/l3hVYk/ScgrrBw/Yp2Kx+9CCGefV6GRrHSuO5N3jNQSf5cA==
X-Received: by 2002:a17:903:986:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22fc8e995b4mr83439675ad.38.1746829711780;
        Fri, 09 May 2025 15:28:31 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fadsm22584465ad.24.2025.05.09.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 15:28:31 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
Date: Fri,  9 May 2025 18:28:13 -0400
Message-ID: <20250509222815.7082-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509222815.7082-1-james.quinlan@broadcom.com>
References: <20250509222815.7082-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, we use automatic HW negotiation to ascertain the number of
lanes of the PCIe connection.  If the "num-lanes" DT property is present,
assume that the chip's built-in capability information is incorrect or
undesired, and use the specified value instead.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e19628e13898..76fd4f515898 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -46,6 +46,7 @@
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
@@ -55,6 +56,9 @@
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_RC_PL_REG_PHY_CTL_1			0x1804
+#define  PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK	0x8
+
 #define PCIE_RC_PL_PHY_CTL_15				0x184c
 #define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
 #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
@@ -1072,7 +1076,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support;
+	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1180,6 +1184,26 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
+	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */
+	num_lanes_cap = u32_get_bits(tmp, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+	num_lanes = 0;
+	/*
+	 * Use automatic num-lanes HW negotiation by default.  If the
+	 * "num-lanes" DT property is present, assume that the chip's
+	 * built-in link width capability information is
+	 * incorrect/undesired and use the specified value instead.
+	 */
+	if (!of_property_read_u32(pcie->np, "num-lanes", &num_lanes) &&
+	    num_lanes && num_lanes_cap != num_lanes) {
+		u32p_replace_bits(&tmp, num_lanes,
+			PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+		writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+		tmp = readl(base + PCIE_RC_PL_REG_PHY_CTL_1);
+		u32p_replace_bits(&tmp, 1,
+			PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK);
+		writel(tmp, base + PCIE_RC_PL_REG_PHY_CTL_1);
+	}
+
 	/*
 	 * For config space accesses on the RC, show the right class for
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-- 
2.43.0


