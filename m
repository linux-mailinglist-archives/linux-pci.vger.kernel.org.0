Return-Path: <linux-pci+bounces-29050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BAACF4BB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EAE189C5E3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEA274FF5;
	Thu,  5 Jun 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHJQ6aWL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5922750F0;
	Thu,  5 Jun 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142246; cv=none; b=RCWpeELQ5QL4ipAySmYr8zU9MgmW8YzUBuVziMtvAxn1nH7AGoSYAD6vpNkKPt4kN4X7u2tv7ghpQRroaHaZlmqaM6hHHf7iTTkT0T2bMWl7FlNvRHYdxoCmOLRmjx9RSWSThi31AmDuOZKZS7z3mryXS5YQGbZwcW02Ij/zIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142246; c=relaxed/simple;
	bh=+GYdJToLXMjSHEzFB7UvagWwdjRYvd1Yv3REAIbAAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FtWU6AN/5V92HeDNrMAVI5f4ktGs56tPqfi/30CbsZLqs/CiNpNhaN0Bv5yfd3vUWxX1YhMH9g6WwlNeOZauDcXkxi6gzNNjdjRnFxkq5WibRwfalbToAlEkbjzGtcuXU6cfQmudxKVsJQgwPlV8f+ZJe6unwZQ9JqWxWalY7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHJQ6aWL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747e41d5469so1427808b3a.3;
        Thu, 05 Jun 2025 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142244; x=1749747044; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhW9QPrsGwu26NBYUsMExt8YOvu5jBbvy6pXm9zcT+s=;
        b=hHJQ6aWLcyMn7sYK4dBYb1IbPGWywgrB5IKpY7XYl2v+9uvTOSihth6VAAma6CPaYc
         de/87JkqIznK+xA/bLBvTyxZC1JaeH8IXxXW0kHmgqrri2Br6DCfaqqlnf+Tr5kx1JOd
         YMoBu20/SUuT5d5HsqdyjOq+ESO3M/zh+mTIfnVqps8unjzLaH2WCg9qr/6CiMfDNa+A
         o/ygYQHhEiB35L8T7gdfj4kOPvauTwigK34CkaCufy6/TffL7OcUYODyvEoGQpBIfKxJ
         fPjDBJzu6RivTMgA+KS0MYC3MAsQWReGWolcZHmvaYrzt3qCoss7xwH8rwbUTU7KANcv
         33mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142244; x=1749747044;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhW9QPrsGwu26NBYUsMExt8YOvu5jBbvy6pXm9zcT+s=;
        b=n1gKvu9kr9/fT8lG6sIrEAMrHu6tEFOchWF5+RX0rAB81pqftDhan976hiu3zhIUTa
         Vp6tnUK3MSKbtLZiMe3qd+y+tsKAYLHiG8wA5dw7GC0b1HNfSarEjg7giv+lFhUt6gGJ
         saa7YhvW25/9yRGX7a6lpAhA4C6cuS+eUal2Yl8VaxYMSR7Wb5+r7q5KhaMSe8+xteNU
         FTIep34UYeqpGGfnJPKVXgl3rX2beXpz2mJxAQgqu/wQRe6OeeIkT5SipesfvW+glik4
         FND/HlL1VJTY+3IxvwQSnPe7xbrLCF8tuBvGyWknlCsj7/R/82zUHS/w8f5U6Cm0RLUz
         T20g==
X-Forwarded-Encrypted: i=1; AJvYcCWbGPJntR6ZwSC30PkANA2b9o1b8gsed63wo1qUQXzZP7Fd/0IDomuq/i9FijkjQPS231uesaTgYPsi@vger.kernel.org, AJvYcCX5/37iYMI3LrIh4L/zZTlL2o69h8Ypv9mdcqw14xjpKjYLrsPQqAeiBSu9XfasPUF/FzTffSTQ06tHvdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6owPFjRddZSL1SRBqN+LBPJlfGVLruAYlgj7Cs+KNJzSUSlm
	hz12OTeGuWDv4BNDhcCBlsgwggRojGE7+44rV4Ghk3flILW/kv/c+XyY7Oo/MSfo
X-Gm-Gg: ASbGncsl8xQgAvA48b9LVDzdvFiF0d7MzaSSYDyBjxp72iJsOHTORon+A2TmruWcybl
	r99QolPk0VKYlt4OAS1wHsWC0ey57sxsL/G4Taakm0e1opAkGub0OWzOotp9mykfNr6gQDlCARs
	IRZoLrKYxOJeCIBoK+tpliubLzJZWMREb/OGcoYTamWv75Y/UU4L6kIH9dckZA+DFd5y6BXMkEc
	WRyD02GSWP2lYHckiT3yNX090PjPHwlF54DVC4hcK5IhNvPAW/TWSnHbcQEJXDt8AMXLZmzgHv6
	luoVFjM4+mlWjd9DhnAJ8rwS3sf+ccZRXeuAF8A=
X-Google-Smtp-Source: AGHT+IEf+vTfjvGNxCk/OGr6dye7BD0FG8xzE7ZPNv1iKzOBxRcTx9QpwvugHNOmR6rLZSeWU06b8w==
X-Received: by 2002:a17:903:46cb:b0:235:ea29:28e9 with SMTP id d9443c01a7336-23601dc0189mr1059835ad.38.1749142233132;
        Thu, 05 Jun 2025 09:50:33 -0700 (PDT)
Received: from geday ([2804:7f2:800b:110a::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235f64e05ffsm12463665ad.128.2025.06.05.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:50:32 -0700 (PDT)
Date: Thu, 5 Jun 2025 13:50:27 -0300
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
Subject: [RESEND RFC PATCH 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aEHK0yVfSVO84EZE@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

I added Hugh Cole-Baker to Cc: as he is experienced on RK3399 and
maybe has faced the non-working SSD experience on RK3399 and
will be able to test this.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
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


