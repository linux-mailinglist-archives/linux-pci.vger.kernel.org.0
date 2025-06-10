Return-Path: <linux-pci+bounces-29347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A295AD3F1F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4577A879E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881312397B0;
	Tue, 10 Jun 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L79KbN4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57223D281;
	Tue, 10 Jun 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573441; cv=none; b=S4QHywv++0Qt9uWYkRI5c5pRgy+phKIzt5uomDlT2uqEQWyuAyZ3HxdZz1x/wAzdMnWhqsNxJh3Ue61WATPM5MiZyGCi9aFhAyupFZd3ApWTvNThqNSAnDUMEXhH3r6sorov/VFtBFzNMYPxryiwrc+d+7vNXJIafSXQEr8k1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573441; c=relaxed/simple;
	bh=8kEZBnV6Gg0YL6iqB2crT0RuhYZLdUOgPZ2gA0nvtu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvAqL9+/Em16CVJMBdDkIvdiv6+ua3OvGQXjQYFvBSIR6IpVG7Bg8P65Exdmwx5H2BxIML9XvbAIFUK2BFtuMn3SiaXe2t3KrFNDteamAOZb/blqKHOepNe8t9PSdSxggAABi0kwgw6SJ6sCQfX37c0C00UjU9DJOY+iyJnW7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L79KbN4o; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d09a17d2f7so465578285a.1;
        Tue, 10 Jun 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573438; x=1750178238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vek3l8Nm6PYSR+a+p5WH1tFEh9m7ZoSbhoGF7zP/muM=;
        b=L79KbN4o6J7x9HxnnVYwNHL7PThwZzECWFhO2qYASIUJ6wOQQmxwYh2K9Rv4q/8uNp
         cZUimSdARj6GVG2ZkiPbkWWlf30xdgMO0A3cuNHDAxxm21VKE2vPJMe8H/0KaV5KXuaT
         DxvDYqRoOaYjRUW8/Dg2WI7A1/PJR8GqGEfg4dcLz+Y2ojkVWByyb6aMX5N4amnUMty8
         vMddXPm6cHgXGwZy9ZUwMmWnyVcXjLs1ZjG9BhpIakkBKTYUZlReIvJpG1e5HKU9AjUZ
         KzZIDVrqiAQCv6YTptzp/UAXdb1b3o/zxp+wyvnOwX9xFDw91g0BiVO3f1JcurRiQG2U
         fjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573438; x=1750178238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vek3l8Nm6PYSR+a+p5WH1tFEh9m7ZoSbhoGF7zP/muM=;
        b=bdK/jNg3xFoQoCDdrhe5T0zTrcQfOpxTLZPXT0+miNCBu9qkddBlrgzVGE7unXxFPa
         ndorD026UxtT1JXFaYFCozIcQSateRZR4ksZO4yUAh+QXo1DTdAZHEzQcQlStKqi3n/f
         0lVGva2kY6XlflgSmG4Wp/JLAUPuXLlLX5BCRYbwCxgK118US2isQNw0sTchc/BHaph4
         lNgS57OyKH4PMbF3OqThgr+EIIx9ngVI95BbzKbC7iMuXjJZBeVBS9bHtB4EFlo/tCiT
         ywxNmHP0/p6sDfyHoMJqXOIoQR3oohCJ+ZIXAJVcIDedTbvPex0G0smQJ9exeWOc6J5E
         ZIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnjm5kXBQbY+atW8CIvSTFmHgmEhnf+M33qZxnVTwKBiAMrs1KlUAVtcRCfBXHsjfyDtJaOsj3XP3oEy8=@vger.kernel.org, AJvYcCVqrAZ1lJz7ASlsimG+1EBKr0oV2q14nvJeg4kPOoDOJ2X2fKscJ2elf/mroWLn3qUWbU68aYbUD8Ym@vger.kernel.org
X-Gm-Message-State: AOJu0YxhHies6YJt7B8n8J9wUYE1kypkvPxvOVRH30dU8MvzrzaxDKrj
	fZ0ceplbcphq6DYnJwb6cxyLKZ1MUolUbv0iBHHWAwYa8jjkf4yNNOlE
X-Gm-Gg: ASbGncssz6rm0+mYZoTvx60X4LtPC1FYO4FvphdZKqxDZ3ZelNvJ6WUsPnAUYtsxVQu
	fwAn87C1eEzQs3o1uwb1il3tdXhGuLwpVscnutXuZIQW1BoZ9bKxTg10ROTWuo7DEobVkP02JbG
	Mw47JzlZQoIw7V8WSQEMb5zHjPnZZ59Rrhq7dgKqh2byw0oY2BqVT3KUbaRam84RC77hnBVFY4+
	B5tfV1UpMIUMtt8IkbgAkDgTK9XLcub/5r7+bX0ZZg1Vy3vrS9aZlcUk89Ud3yhyanleFCQ3bxK
	LoDUv6injlSmFtT4mbM5K4h4TRmCjXaDPJQ97B7zwqQ3dpmLRA==
X-Google-Smtp-Source: AGHT+IHGaxxovrv2vFOeyWwXKXC8AtzwIvEB5fpx3Rxey4/mgeB4i4LmRr6mNTejwPat0j2MR0ppkg==
X-Received: by 2002:a05:620a:4513:b0:7d2:2833:6dff with SMTP id af79cd13be357-7d3a888df03mr7490585a.26.1749573438459;
        Tue, 10 Jun 2025 09:37:18 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf97af8sm1488235241.33.2025.06.10.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:37:18 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:37:12 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <810f533e9e8f6844df2f9f2eda28fdbeb11db05e.1749572238.git.geraldogabriel@gmail.com>
References: <cover.1749572238.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749572238.git.geraldogabriel@gmail.com>

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
here - PERST# is not toggled during retry.

For retry to work, flow must be exactly as handled by present patch,
that is, we must cut 3.3V power, disable the clocks, then re-enable
both clocks and power regulator and go through initialization
without touching PERST#. Then quirky devices are able to sucessfully
enumerate.

No functional change for already working devices.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 141 ++++++++++++--------
 1 file changed, 87 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..67b3b379d277 100644
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


