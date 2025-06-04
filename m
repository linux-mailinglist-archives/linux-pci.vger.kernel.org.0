Return-Path: <linux-pci+bounces-28947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33560ACDAB4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E989D167305
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289128C843;
	Wed,  4 Jun 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNo7eyc5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2428C5DA;
	Wed,  4 Jun 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028503; cv=none; b=cGgz0O9U9P9zXiA1FKKJbnyChnJxymoqsrhNE2oVlqIs7e3j4VHWwHSu/0759eQC334RQiifDBT5cAleEe1DxvhOc9dvHN7/3LyLze0NkWzBzJ3v/uTN8iFyJJzdJ7hVhl5XdtsF1tGyosqwcUE+UPo/AJeAbAd+RH/8mpojE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028503; c=relaxed/simple;
	bh=a2orjQgpwIVrSbmo8TyGeBeS8WVo+nKKnBihpx1g/94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jQjFEkp4gmq2cWfT+RLBeSekJoWP0Tjm7gkq7192jZer7+Hp07nPLLjjf+hPr7aFvtJYqRQGi9yLWa1rtuZUfNU8gUG5CYbpuQlpBF9r017NdVq2wa++inI91xrZnwBRNfl5B9fqnT9T+NVVErMsWl36QngCvpQkwYCg/cEXQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNo7eyc5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2351227b098so46015315ad.2;
        Wed, 04 Jun 2025 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749028500; x=1749633300; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXKUp0jLGdtp7D5Cr5HTNVyQxHB2C0Ds7jpfGQp1h+c=;
        b=aNo7eyc5R1Rabdp3drKV1TZ9K/ZDiYMyDIKNdVOyBsxOGHnwqbeo5PiiAYQYJm/wnQ
         1GmasSzmUm+wJOSy9OY4ow8ex+KhtIHkYZWVNjg06uzh0XrnuNuQ0oIUo1zXbm3XUebW
         kUTNXDkyIYDmMHzp6tAp4To+3PHQEkkv9731N2KLe+2wgMzgK5E1JTBaDRE0Dyv/5uHK
         SM6xX/8s2hyjVCb7hBr+o53WPRP1qY0hZiuKxTk9Nk+PZIkpt6KF7hxmGe29ZeALCFmY
         Ph5yUuMf1vqma/KTEL069R9RWwoujBwN35XG8OImgrJ/a0fLC7K6FBdhKO2o9Hg5fFA5
         aSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028501; x=1749633301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXKUp0jLGdtp7D5Cr5HTNVyQxHB2C0Ds7jpfGQp1h+c=;
        b=B6Q+iOvqVYhB6hVrgZ0vk7rXjCL9TQY4gEj+glpwSbaV44w3bafJQHAIbAzFFl7DqM
         tdVa4+fvmf9uD5aQ5Zj389Z2d55F3rEU6+Nc/DAUAim7MvmsubcVPbP9eWBG5QtdKtRT
         5fDJNGlyVlEKouIblmxJ2paPNvcxmbDfPr0PGxOEqxISpy+hYAETwag+4OWoWRu1zx7z
         /kwS1RX3BPesMFfliI36JjrafuRylsc3WbLHKXxWXBCdHmhCUQtbvvtkFu3j7KvojcLt
         sUEGivBs0OXHlOgA5f/nV4ROLiA5wo670CqVjoJqLfpPQELIjESbmy67H/UQ2eb8ypOL
         dILg==
X-Forwarded-Encrypted: i=1; AJvYcCUMTlmiLO9YcRu4y2x6RqfEA0tQHUFA73CFT4+JlQ73mqi3aWjjbztetgeatZSVodsP6EyVZ6Y/cagS@vger.kernel.org, AJvYcCXnwY7E5ENtvEmvxL3N04cyxrShrIoiGAaVDyIUtsp4CyhHOHVchy3JgLbChJXSCvg/IKc5CrVrVDIFakw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCOU5ThYR++bSWPSPMDxHnXNElfNSbq2R5zppzsoJFf787HV8
	WCvEtDDQ6OuW0lneWmX6ERYjJskLBg8+AWN6frMiOdDY243CzVqyMFDt
X-Gm-Gg: ASbGnctfxtQXw6TomewsLh/YAJXDUut7FOvu981n1NAxp8ZLYWIo5bzwfW3me/0opj9
	Py/qLllmjOikw9sZXDHmykN/jwWBk6YZGB7YSvNLK4fZBfXwfFhBLigWfmR0GKwwrtgEI1JB3GL
	XHGNP1Ty2cofAmzWRpj+vRw0mR074NahgBYS1/fHSeeMzExDnQe1CTzjNnzIPJxTOjDtEh35aHy
	zB6TpsnFQH8zGb+yr0eqlVOC3SPs8ZShdwutM2g7cbn68oIgxeFn9F4uNNQk4hF9UwRsP8OUm2Z
	HAZnk6kyduk0t+rvJ843VzW0nSFXkNYWis4Nlg==
X-Google-Smtp-Source: AGHT+IGrWh8jmJojKSu+BSXj2AcIBuAIpGQv28Yb3WscoCmm5H1KpgPvyci17orjrFIZ1IdDZFdaZA==
X-Received: by 2002:a17:902:dad0:b0:234:e655:a618 with SMTP id d9443c01a7336-235e11cb8f1mr29637965ad.25.1749028500499;
        Wed, 04 Jun 2025 02:15:00 -0700 (PDT)
Received: from geday ([2804:7f2:800b:6be::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdd0e9sm99762975ad.74.2025.06.04.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:14:59 -0700 (PDT)
Date: Wed, 4 Jun 2025 06:14:48 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] PCI: rockchip-host: Retry link training on failure
 without PERST#
Message-ID: <aEAOiO_YIqWH9frQ@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
N10 through trial-and-error debugging, I finally got positive results
with enumeration on the PCI bus for both a Realtek 8111E NIC and a
Samsung PM981a SSD.

The NIC was connected to a M.2->PCIe x4 riser card and it would get
stuck on Polling.Compliance, without breaking electrical idle on the
Host RX side. The Samsung PM981a SSD is directly connected to M.2
connector and that SSD is known to be quirky (OEM... no support)
and non-functional on the RK3399 platform.

The Samsung SSD was even worse than the NIC - it would get stuck on
Detect.Active like a bricked card, even though it was fully functional
via USB adapter.

It seems both devices benefit from retrying Link Training if - big if
here - PERST# is not toggled during retry. This patch does exactly that.
I find the patch to be ugly as hell but it works - every time.

I added Hugh Cole-Baker and Christian Hewitt to Cc: as both are
experienced on RK3399 and hopefully at least one of them has faced
the non-working SSD experience on RK3399 and will be able to test this.

---
 drivers/pci/controller/pcie-rockchip-host.c | 141 ++++++++++++--------
 1 file changed, 87 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be17aa91..6a465f45a09c 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -284,6 +284,53 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
 }
 
+static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+	int err;
+
+	if (!IS_ERR(rockchip->vpcie12v)) {
+		err = regulator_enable(rockchip->vpcie12v);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie12v regulator\n");
+			goto err_out;
+		}
+	}
+
+	if (!IS_ERR(rockchip->vpcie3v3)) {
+		err = regulator_enable(rockchip->vpcie3v3);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
+			goto err_disable_12v;
+		}
+	}
+
+	err = regulator_enable(rockchip->vpcie1v8);
+	if (err) {
+		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
+		goto err_disable_3v3;
+	}
+
+	err = regulator_enable(rockchip->vpcie0v9);
+	if (err) {
+		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
+		goto err_disable_1v8;
+	}
+
+	return 0;
+
+err_disable_1v8:
+	regulator_disable(rockchip->vpcie1v8);
+err_disable_3v3:
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+err_disable_12v:
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
+err_out:
+	return err;
+}
+
 /**
  * rockchip_pcie_host_init_port - Initialize hardware
  * @rockchip: PCIe port information
@@ -291,11 +338,14 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
-	int err, i = MAX_LANE_NUM;
+	int err, i = MAX_LANE_NUM, is_reinit = 0;
 	u32 status;
 
-	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
+	if (!is_reinit) {
+		gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
+	}
 
+reinit:
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
 		return err;
@@ -322,16 +372,46 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
-	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
-
-	msleep(PCIE_T_RRS_READY_MS);
+	if (!is_reinit) {
+		msleep(PCIE_T_PVPERL_MS);
+		gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
+		msleep(PCIE_T_RRS_READY_MS);
+	}
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
 				 status, PCIE_LINK_UP(status), 20,
 				 500 * USEC_PER_MSEC);
-	if (err) {
+
+	if (err && !is_reinit) {
+		while (i--)
+			phy_power_off(rockchip->phys[i]);
+		i = MAX_LANE_NUM;
+		while (i--)
+			phy_exit(rockchip->phys[i]);
+		i = MAX_LANE_NUM;
+		is_reinit = 1;
+		dev_dbg(dev, "Will reinit PCIe without toggling PERST#");
+		if (!IS_ERR(rockchip->vpcie12v))
+			regulator_disable(rockchip->vpcie12v);
+		if (!IS_ERR(rockchip->vpcie3v3))
+			regulator_disable(rockchip->vpcie3v3);
+		regulator_disable(rockchip->vpcie1v8);
+		regulator_disable(rockchip->vpcie0v9);
+		rockchip_pcie_disable_clocks(rockchip);
+		err = rockchip_pcie_enable_clocks(rockchip);
+		if (err)
+			return err;
+		err = rockchip_pcie_set_vpcie(rockchip);
+		if (err) {
+			dev_err(dev, "failed to set vpcie regulator\n");
+			rockchip_pcie_disable_clocks(rockchip);
+			return err;
+		}
+		goto reinit;
+	}
+
+	else if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
 		goto err_power_off_phy;
 	}
@@ -613,53 +693,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
-{
-	struct device *dev = rockchip->dev;
-	int err;
-
-	if (!IS_ERR(rockchip->vpcie12v)) {
-		err = regulator_enable(rockchip->vpcie12v);
-		if (err) {
-			dev_err(dev, "fail to enable vpcie12v regulator\n");
-			goto err_out;
-		}
-	}
-
-	if (!IS_ERR(rockchip->vpcie3v3)) {
-		err = regulator_enable(rockchip->vpcie3v3);
-		if (err) {
-			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
-			goto err_disable_12v;
-		}
-	}
-
-	err = regulator_enable(rockchip->vpcie1v8);
-	if (err) {
-		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
-		goto err_disable_3v3;
-	}
-
-	err = regulator_enable(rockchip->vpcie0v9);
-	if (err) {
-		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
-		goto err_disable_1v8;
-	}
-
-	return 0;
-
-err_disable_1v8:
-	regulator_disable(rockchip->vpcie1v8);
-err_disable_3v3:
-	if (!IS_ERR(rockchip->vpcie3v3))
-		regulator_disable(rockchip->vpcie3v3);
-err_disable_12v:
-	if (!IS_ERR(rockchip->vpcie12v))
-		regulator_disable(rockchip->vpcie12v);
-err_out:
-	return err;
-}
-
 static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
-- 
2.49.0


