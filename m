Return-Path: <linux-pci+bounces-9894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F5929835
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEE1F21E3B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C024205;
	Sun,  7 Jul 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZaPcwIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7620DCB;
	Sun,  7 Jul 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360457; cv=none; b=oeeo2l8UIZ9B3JeG1SZFuLsn6m1DmxXB9DiN+yyMnqGso7KCRBIDDbm2AxhJWekLTfJUG202U1celf3OmJQiyCNvoe6enfGx9PRBpzQbjlLSWfbdCDyTGZfnKxNnX7WMclqfpkvcdERdWmBbD3TWdQNRskgaq8qQ9lMEA179D1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360457; c=relaxed/simple;
	bh=eQDbM9xq1bH8I6BZxS5zR7Bl1vw8JmOMg03ydij+cq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omQVOXmoYAtXcqZu3Dmj8ojVIlvwCO1lbMm1XJOfqmocATR4fmM6sJ5EmLn0PDPq0c9+VutYGv4hMIipDzKF/P2SFbkwmrqSc+MraEPhfguBuVmLlunGmDVMcMUoeJHUV7lr/lMBjHfcASkIGxSySeF7CDhlY5BDgx0xWWnOY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZaPcwIX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266381bc52so4460685e9.1;
        Sun, 07 Jul 2024 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720360454; x=1720965254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3CBfTwF4Gso6ZO73WUFSqLYs1ZwOIjS4EXepdiHeFc=;
        b=WZaPcwIXnmYHNAT5P06fFodeLrDNNb9ow0xqhLPsAf25AZNp51t+r1H/lcOO11PyjO
         6Kll/6ZPFmUNSWt3SYvhXBixJAqPzjFQxjk4QtmRnBvj8aGIzarW3liKZiJrC2RsC8Cx
         E9oOu3+a9Tk7M47D9D/n+IkNc2OR2dVvMa0plgDrg6tk1Knq+6pzo04a1BWZJczXEtjA
         NqM6evwGAqAHsz+N52YMlAoTkfTniZO8leU0/E6NuqOuoK+awy8pMz0aCuIGsaZjeb4g
         sihHv0PQpWDGyGOfcNzKxNTqbzjGYfYwT7YSh2LLVBW1T3kbWweuEWeYjiE7xCyUR49K
         4+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720360454; x=1720965254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3CBfTwF4Gso6ZO73WUFSqLYs1ZwOIjS4EXepdiHeFc=;
        b=gWqVTapBwZTbbJwbgisZE/8fVAlr3VsOCm5GSeuW0bXFBgswT8iYEp9M2BbFLeDY1H
         60Y4rxPSBRHoxlUjnUXkWSH+gh3/uOTgj26QFINo2Cgj75SIaoLj6PYbU7A+hH2u5ezY
         FAywrn+AlnusvlUswsZPg39EJhK+UEYmN8T2wWXuQAcd7FbnrzLhKBBEA6OUPONZESm6
         GL9ucKnaRRxwuzHmsArPzp/UBFz7Dex1rMR560tjcVdKPPd9v28W2TdU6qLlrQZUjrba
         /J6+3DWnFgXVpRIsNF6b3T9PHMoioy90OTwyeKNOw8DMTOinhZto7fbuLp77Zfeh0wh2
         SNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMttujEb2eWrXizMhI7hRaGsJHW9ehy9gBAtqX9Bkb8oTmibr2dJ0K3xY/9VA8sRRNmGRWz7c9kYA19xYbw+3P52fk5iJBHxQpMCyW
X-Gm-Message-State: AOJu0YzvJivWuRAd8gh64Hu0cHNBUvnpjzWV4UL7JAEjJ/pFuB1pzL8K
	hG17mOkQV2T7xrVG/KwL42BySe2FV+FgDy7sIrs6Y950zO76dEyE
X-Google-Smtp-Source: AGHT+IEy0g6iTXpd/PW3IYgCnkC7VGdpA3pKvcG10VD4+vbQYsUNnL7T47tPaAwFE7X7E0oNZ6WMjg==
X-Received: by 2002:a05:600c:3b94:b0:426:6945:75bc with SMTP id 5b1f17b1804b1-4266945778amr2401455e9.39.1720360453398;
        Sun, 07 Jul 2024 06:54:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-768b-c763-2748-445c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:768b:c763:2748:445c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm129684005e9.39.2024.07.07.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 06:54:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 07 Jul 2024 15:54:01 +0200
Subject: [PATCH v2 1/2] PCI: kirin: use dev_err_probe() in probe error
 paths
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240707-pcie-kirin-dev_err_probe-v2-1-2fa94951d84d@gmail.com>
References: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
In-Reply-To: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720360450; l=3872;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=eQDbM9xq1bH8I6BZxS5zR7Bl1vw8JmOMg03ydij+cq4=;
 b=yRNNR/Q4r9LJ1MpiWKBAUBy0bdRXehbMWOy7MNs6KqHg2Qbt8vLqXXmpo8ynhu8FMD1DvTM0I
 JDUw9OMY99hAj3jVeD2pOw3DXr+AN1EWEwdA5WgKLD+gkrkyFYxOJe0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

dev_err_probe() is used in some probe error paths, yet the
"dev_err() + return" pattern is used in some others.

Use dev_err_probe() in all error paths with that construction.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 44 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 0a29136491b8..e00152b1ee99 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -216,10 +216,8 @@ static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
 
 	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
 	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
-	if (reg_val & PIPE_CLK_STABLE) {
-		dev_err(dev, "PIPE clk is not stable\n");
-		return -EINVAL;
-	}
+	if (reg_val & PIPE_CLK_STABLE)
+		return dev_err_probe(dev, -EINVAL, "PIPE clk is not stable\n");
 
 	return 0;
 }
@@ -371,10 +369,9 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 	if (ret < 0)
 		return 0;
 
-	if (ret > MAX_PCI_SLOTS) {
-		dev_err(dev, "Too many GPIO clock requests!\n");
-		return -EINVAL;
-	}
+	if (ret > MAX_PCI_SLOTS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many GPIO clock requests!\n");
 
 	pcie->n_gpio_clkreq = ret;
 
@@ -384,7 +381,7 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 							GPIOD_OUT_LOW);
 		if (IS_ERR(pcie->id_clkreq_gpio[i]))
 			return dev_err_probe(dev, PTR_ERR(pcie->id_clkreq_gpio[i]),
-					     "unable to get a valid clken gpio\n");
+					     "Unable to get a valid clken gpio\n");
 
 		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
 						       "pcie_clkreq_%d", i);
@@ -417,20 +414,17 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 				if (PTR_ERR(pcie->id_reset_gpio[i]) == -ENOENT)
 					continue;
 				return dev_err_probe(dev, PTR_ERR(pcie->id_reset_gpio[i]),
-						     "unable to get a valid reset gpio\n");
+						     "Unable to get a valid reset gpio\n");
 			}
 
 			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
-				dev_err(dev, "Too many PCI slots!\n");
-				return -EINVAL;
-			}
+			if (pcie->num_slots > MAX_PCI_SLOTS)
+				return dev_err_probe(dev, -EINVAL,
+						     "Too many PCI slots!\n");
 
 			ret = of_pci_get_devfn(child);
-			if (ret < 0) {
-				dev_err(dev, "failed to parse devfn: %d\n", ret);
-				return ret;
-			}
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to parse devfn\n");
 
 			slot = PCI_SLOT(ret);
 
@@ -469,7 +463,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	kirin_pcie->id_dwc_perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(kirin_pcie->id_dwc_perst_gpio))
 		return dev_err_probe(dev, PTR_ERR(kirin_pcie->id_dwc_perst_gpio),
-				     "unable to get a valid gpio pin\n");
+				     "Unable to get a valid gpio pin\n");
 	gpiod_set_consumer_name(kirin_pcie->id_dwc_perst_gpio, "pcie_perst_bridge");
 
 	ret = kirin_pcie_get_gpio_enable(kirin_pcie, pdev);
@@ -729,16 +723,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	int ret;
 
-	if (!dev->of_node) {
-		dev_err(dev, "NULL node\n");
-		return -EINVAL;
-	}
+	if (!dev->of_node)
+		return dev_err_probe(dev, -ENODEV, "OF node not found\n");
 
 	data = of_device_get_match_data(dev);
-	if (!data) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)

-- 
2.40.1


