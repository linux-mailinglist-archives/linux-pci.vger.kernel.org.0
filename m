Return-Path: <linux-pci+bounces-29730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616CAD901D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8701C3B81C2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06131A5BBD;
	Fri, 13 Jun 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImMntGFO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242215573F;
	Fri, 13 Jun 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826283; cv=none; b=pAN88jvItacbwHgda8fWGfXDYI1p3QjcxzraSMztI4OFRJNzqJnrra7ZY8O/f7CymRDS6+aEYw2h3lvB0YjpWfSB4ZkdR+7EMTR6dqLLnkC6xvKMbmsWQt/sPzI86qaWH1MFl8LsUxzX+WC18Y5OI/+w8kJsxc35S5GO50bouB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826283; c=relaxed/simple;
	bh=HCHxyL0K42wwQ/tfkDZFm1mre6kRDwGlqurOi7MIwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJhsJuiuTmoUOPTjBTsbnzlKZ5dznVLZ9PsWieoX9ev2X7dovTuOlvFO1Qkhh/JTIiBP5Yf9fGIYYCXjbvTf6CRU7NApRm1SnFiwCtn9y4io12kZtMwsEzK96rbBGzbo/gov6I3PSYtpa54jX7fdqXLihyaNr7sdRevojliCg/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImMntGFO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so1815955a91.0;
        Fri, 13 Jun 2025 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826281; x=1750431081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzNQkY2OXtljp7yt/i/tI+v/gWIw5D47TujWJasE/B0=;
        b=ImMntGFOTg55j073t3mLFc2TswMBSaoFGqc8SF+uM3BjHfRpcnyxc+IiTrixFChe+v
         uFSMkReykdvKgd5gMQYGZacwrVDUQ4fd71TmuVuB417jhdNouBP6ICGEiHCjaHkJsFi1
         sjEgaKsKq1lgRzGy45EwtiUkOpM54zj8ksVe1Pc8T33/Jdtf2h8jcXhX/B8JUSviNWwo
         O0doSag08ZApbStXvIAz6+JNFOW7UtDMRMFMQh1+N66nS45i8EJ17yQNWQSVriIamtXx
         Vg4FWrmZICb58AE29/Kr8Hkds967gGkbtOrr1kyZ40jxAGCdgeEkK3KQICJ0hROVufNc
         bAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826281; x=1750431081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzNQkY2OXtljp7yt/i/tI+v/gWIw5D47TujWJasE/B0=;
        b=RBrRXV8TrNEAkfpd/bfXbXULggpScSTsbOm/GZmXSjmC/1YCr1HYzTzS/28gbljZgD
         000QN8J2V13uADJWqbvq1kqfhchI8FSbWNNppR5djyV5t/kvTq/NHDVDU1N8f9HUWIpa
         4YqDcyyEazuCU52E6EBKPpcWJBrA6RUk0XsXsRwUYPM8/DRGsyIoAyk/0jnLcYcf18bZ
         YLDVhkvQBER+gtzvrW95ObfyT4rM9oLa18XJzYW07hkUZM3Yskc+aV72kWyIpPQ0SwuF
         YU6BQ1agaIwIZB2aIQE+Jwp3DpR15DK9MHxAQuomzcZy//65roq+WQhRUgjVXdd/5f4l
         kAdg==
X-Forwarded-Encrypted: i=1; AJvYcCUjfJV8ItBXwPur2uXh7S5Clag8+ahRi5b4ihxNMFtC4gXdK0uJEcu6TdKN69GRGEGJR06qa1K0lQSD@vger.kernel.org, AJvYcCUp5PfU91c57B0LAbeXXBRTnjBnWrYgdKaYkdAn99+EGwg4adzN+6QOn5DAbj/QjcaS7ghGpcdSK/wOBew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyort84pDsF7teZmppfxmuVy9VFHO1yTTVSFgurgYPo2vX0r47k
	dVkNJOozk6tq86FRVZMWEj0o6wpmgZmwXyBs+ZHgER7q31r+XAlyfUsN
X-Gm-Gg: ASbGncv10Ph0u9EBrbNlaoVPxnB71y2qvdGe6G4Pt6B/yFILHiywbQ2XIHHdwz+W85O
	pRM/I5dtYqfEWDSrn/2mtnemUyeMjT8vlhSKiDCy2EzljSfz9aqptybHmfiC2bsSiFSN2tYzEj9
	6tYyXUJbRfhGeH3yt9RvKjbUevnMFOeqfAtX1aDNR+/QuJGAAV4MUsNLVaQ/R7OlAajCO58mHO8
	Dx6Me513RAmLBU83dj8vRqFeFa+0x7Yjp6qMsNjVRxBgU/+rQV7Fup0Tvnvf+UoIcb0aQRWzeFu
	Z6HfhuM185RE71BcQRxs8VWqTw2cNdKXYH9gMzXYK/psVbBMDQ==
X-Google-Smtp-Source: AGHT+IEU1euNi7vVAr/Eva34gPyHAVXAx6uKoAkzHEKswgDcWh+Lz9KRkR7xgmskZ5u1W9LnCJ8nuQ==
X-Received: by 2002:a17:90b:4c09:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-313e90b17a4mr1463779a91.11.1749826281041;
        Fri, 13 Jun 2025 07:51:21 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d2ea0sm3463812a91.20.2025.06.13.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:51:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:51:14 -0300
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
Subject: [RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe defines
Message-ID: <992ab6278af59b8f2f82521bf4611f69a916bbe1.1749826250.git.geraldogabriel@gmail.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749826250.git.geraldogabriel@gmail.com>

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


