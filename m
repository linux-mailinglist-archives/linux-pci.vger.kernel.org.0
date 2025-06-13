Return-Path: <linux-pci+bounces-29741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D472AD90BD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB23B9D37
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A729CEB;
	Fri, 13 Jun 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC64SEDH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F41ADC90;
	Fri, 13 Jun 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827139; cv=none; b=evtWtaycJCPtBHMoItT2zx5/0tcG/8Hv3W2GC1lz5n+Q9PaStE581uZaoHWBC6MZrVWFO4LoRPxJl/jWlmHXwGXzEoMgTXzYCV5JDrMdx6f450Z9gyFOHflmwSl1jD0KpaXtolT95wxhGiKs+dsDJjRZ/b27UCNxiGXVlB78YIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827139; c=relaxed/simple;
	bh=HCHxyL0K42wwQ/tfkDZFm1mre6kRDwGlqurOi7MIwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH4csN+IaRbe5KLliMs8PxQvRv54vwfPh8ynjY0pEDK7SQvVL+KXPK5yZmuAM01nRbnFnsAADWQjIerigNL9GtFaU6w21AmBeU4j1Gm4LI7vIlfxmXqhyJXvaF+Bcft/FT5r6v97I0A5AS/ouWUCqJD35/ZgQ5U4oFsB2Nd1h5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC64SEDH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23602481460so21934565ad.0;
        Fri, 13 Jun 2025 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827137; x=1750431937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzNQkY2OXtljp7yt/i/tI+v/gWIw5D47TujWJasE/B0=;
        b=MC64SEDHH5OOQp7CI76KLjrQmDs/2aAzLeNOP+Wwl3q9pZztj8uaeoA6rUjAhzvtbq
         GKh25+seOtXz1dWt6D7wFq6WCa3I/Aj+Gd3muXl1L30o9L/5l5qBTwwVz29yKVwHOUsU
         NUFE0WXwtHB96kUu4UvekXFfeFf2u1nmTruIxjNyDFH13zsiGWIvI3zGN/vCPYQqZH3G
         o3ipwhN+Rbb3z+i/nIIk7z+bI7Ha7qCOzUSJxZiAlcp8gtuDip5wDEM1Vz7YQ1OS7tfs
         DH4Q8RtGTL7bRXU1t3Yw9uORRBRvENkP+QoSHUkiLkEEiZ396CyiwyhNaX7b22y7pCi0
         PkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827137; x=1750431937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzNQkY2OXtljp7yt/i/tI+v/gWIw5D47TujWJasE/B0=;
        b=AO2ntKZdymbdyBQjlkDcKNtfIWjQHakYix2r6JiQgltM6goTZyemjbyrUxluRSG0iw
         xYYbQAIu1PII4A7n0Geocnv4JTQ7qphWuFTZwKfpRTphhgiDjQ7WH0FAsEnwXPkeLuw1
         aIViF9yw/4ldljBOqxRHk8RxOk8saZqHhgIVCwP0UGusisW2FYFE5hUSEx2XX8mthODD
         2uoSa3/64Tkgb4BBOH9nFD/PIBN+SyqMyUflYmlrA4w2kDBQwkcI2xotkUVrRJ8hOU4q
         kh1Y2tyo/6yjiVTX/Y7evNeFI3TdWBGhOA6HloDBFWAPHoQe7eV0YvBEALNhVIu+icSJ
         vUKA==
X-Forwarded-Encrypted: i=1; AJvYcCUQkW/i+lxSvZECEYA+EflA6DPOx4X22V1HQ94jHbNfuUxIaRZSJ2BkWzd/zZbFvBWrk4P4hdxTrbmu@vger.kernel.org, AJvYcCWnrCRWzg10zs018XQ9q8l7ndo5daano0ltjIhhjaPD76rf0O2hN7mT4yskuKlm3gv11djqmRzwaXC53kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7ovfY2CvZBJFso1YAVaBOWXs1dkwiM9zhDmuSRG6ZFpfX0Ix
	X+ngrsSxhkuVHvQRI2gAOF1g8hi7GsUVUYzTBOVawTly27XLEr18Zpq4
X-Gm-Gg: ASbGncvGcNqDQIF3odPSvIgERnCdhyL9kUIrCxTNjD5qDq9YBvwUXfUo2X5cOzKD6M0
	bNaiFVLVOZCnMh4wauJZxeBYAeZYBXwg8MKNdXRKmVfLfH4659EWPTbMlS7u6wwISpf8toMHROS
	PhfAfdFq3tOaup4IIihOSGMkPjzIvBGKgQdtILvi0baOIs4LKYkTemitsZNcBFfo/eq9qzIx3c6
	ZCMXzl+Qqz8KG6TNFvGnM6WZjlOe1mryEWSoU5ZKnAL97gI/5Tp3wvSBkFXmvpMeXbv0vz8ZRy6
	nX8i/Ne+edjKHN5a1ZI0xqBTdBBACobG2w26lNyrTd4ECsG/Ag==
X-Google-Smtp-Source: AGHT+IHUZiUNYYnkhNtOIXhUvFD1NyZ9GfAWtXm9pvCPpRR/XwK39oN7VLpPRBZkXkHNasnAU2L+zQ==
X-Received: by 2002:a17:903:1b6b:b0:223:65dc:4580 with SMTP id d9443c01a7336-2365de4ae41mr48856495ad.52.1749827137214;
        Fri, 13 Jun 2025 08:05:37 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb04a6sm15372025ad.178.2025.06.13.08.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:05:36 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:05:31 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe defines
Message-ID: <992ab6278af59b8f2f82521bf4611f69a916bbe1.1749827015.git.geraldogabriel@gmail.com>
References: <cover.1749827015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749827015.git.geraldogabriel@gmail.com>

Current code uses custom-defined register offsets
and bitfields for standard PCIe registers. Change
to using standard PCIe defines.

Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 44 ++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..65653218b9ab 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -40,18 +40,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -269,7 +269,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -278,10 +278,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
 /**
@@ -309,14 +309,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_set_power_limit(rockchip);
 
 	/* Set RC's clock architecture as common clock */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKSTA_SLC << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -341,9 +341,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
@@ -380,15 +380,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	/* Clear L0s from RC's link cap */
 	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
-		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
+		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
-	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
-	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
-- 
2.49.0


