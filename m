Return-Path: <linux-pci+bounces-29360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62413AD4279
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72C27ABF5B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20E25FA09;
	Tue, 10 Jun 2025 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbqYcyE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4F25F995;
	Tue, 10 Jun 2025 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582349; cv=none; b=PAwk8ypMwEjRf3U2ixwWGQnRXMq0UUGHy56EexAkYB1babV6Nv+ALFt0iO2A0lt2l3MuTKfLzku5+dPSk6AoSzRNJhrc/3BnqGVS0azU/1rS3vad5O3gfCHiMsUJ5off0F+bodbFMKOjzbP/EXgrj5KJkG5rfUc9IAKk+frJ+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582349; c=relaxed/simple;
	bh=2Qs1fU3+xvZZot36O+io5py24xlf7X4jk/QVomnQjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyCPNz0h2kEYTsBtAp/YGwT7SkvChnsrhy/w/4VYNAkAQQ8MB+bsriMb0+TFvxR8MKYpZ1qkbOB2hTcSj0RIcd9HpHsjDbG9gugwm6I82OHVPqB0rbwbacT4yuuF/6p+h2N7KsXAx1g6JW3HNdXMH+dOkpGsVQUwqcH0akVuduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbqYcyE0; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53090b347dfso1924002e0c.0;
        Tue, 10 Jun 2025 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582346; x=1750187146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fo8YOHT6CATeMOT+gVauR/XbmIAIPn7RfL7rxhobz98=;
        b=TbqYcyE0Bl6qXRda5Ji3RUbQNRk8fPOVvRYrbHGIFKkgu6mAEBuPB6IiP7sGYTDsHE
         C8VJaoUBgzJRmnCGJEOP84KA+SwbM/BYFEnVELdWxBw0MokYGJU60hL6PblxMqV5538I
         jxvQpj2JqJGwPqSO6Du/Pv4qI7pIBL4SdrRLOco3rA7eSV0SFb7doEMnNUCgCXmINPSW
         lTwK/UqjWKCzkh4ByM91Ro6+Ra6NgIYfFrOg2i/zDEW0ILr+HR8Y3/oZcaE2/yXBM6+u
         ZIlKFJgpbtLEawoWXHVC9Fqd+/lxB/1WqsNYFuRs2j9GOTXn7rapa2qQGqH9sQb0Zi5V
         KbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582346; x=1750187146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo8YOHT6CATeMOT+gVauR/XbmIAIPn7RfL7rxhobz98=;
        b=JxDcpDs5z/X2OwJoclN9havYRVXSY9AY8E9O4oti2hlB7zfJJR15Xn4B7RD20FmDsA
         AcpYcQ/0o5eSPP99pNJSYGTYKtz2FMiat8MfmYhJfCiXPuzzLwg/sb0pG6SY/Tg7z0oJ
         TlT7h1cjeoWRDwwm3MwVVAXWnPYL9ojh4Ids9344CsqioqLHaHbe1a5i1rwNvgNCndgt
         Wuh9tScKlBOIbU08TFIoH14G4lUay2Hvos283sKctWd5s3J5VJsHVKMrQUKZBpKdv4A+
         0KLQ687h1pNVsRr1KKhhsx8T4NMClfSNSJdNpKGqtRsjEYSx/tjgcrVHatQCBoV2uq8r
         Op8w==
X-Forwarded-Encrypted: i=1; AJvYcCUcee14cWYur9mmmRujdSFi0n7KtI6i5BveJGePNaoZooREfzWUj12bmQZKCLJPFLPakvmyV8ingmEriRA=@vger.kernel.org, AJvYcCVfvMKunhXnn460dfSH6L9AzbYaJ9pjIrpnGaG8N3YVjstUzw9yaQNGF7MVG749KtgrYGUo4zcxAXOQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28SeBBO2epbM5fmH2yi+N5ef7hr7XQXYFyljWbrtacw5kzIW3
	ufApjIP51XIYNWsVL4uZMOszVJ2GHgCw6enYM0lJc1y8CVBW2k0ZoRfo
X-Gm-Gg: ASbGnctQxRJI4LyePpjmFWrb2KSuKfjyF+T1nQmM4kbdGN8H3Horu/Vxi6o8IGIDCTw
	8hXGSj484poraUsnGL0chKbvnpHdo3oXTD099jDsEHL4lHlk0/D2ikorXszv7kJAgZL+EjhYcIt
	uw6E/Ua12VcvQmTMqX9JVU7Gn0r2bBAlsge6fhAalJP7c0K6tmuqPxxCPR9frvd28CTT1Yi9oNg
	IvFDMKLiMmAT0crL1P0W85/GFbY93d0h2OpW1dJCxfeV9QCOFdpjLOu3Ld7kOxguMfmyjqJTja6
	vm1ggXgLL7Qbr57QANSUEFnOPBgUj6rQaulfVrqxaFgZddVHicuEkb4xyvxS
X-Google-Smtp-Source: AGHT+IHsOECopwO8cvIVwhaTWu/i5+K9/yJofeA0iRJIWglC9WKZLtorpawxREPgref4SCUi7MF5xA==
X-Received: by 2002:a05:6102:3f8e:b0:4e5:babd:310b with SMTP id ada2fe7eead31-4e7baed7a27mr701927137.10.1749582346185;
        Tue, 10 Jun 2025 12:05:46 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7bb060aaasm150155137.24.2025.06.10.12.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:05:45 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:05:40 -0300
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
Subject: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749582046.git.geraldogabriel@gmail.com>

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
that is, we must cut power, disable the clocks, then re-enable
both clocks and power regulators and go through initialization
without touching PERST#. Then quirky devices are able to sucessfully
enumerate.

No functional change intended for already working devices.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 47 ++++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 2a1071cd3241..67b3b379d277 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -338,11 +338,14 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
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
@@ -369,16 +372,46 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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
-- 
2.49.0


