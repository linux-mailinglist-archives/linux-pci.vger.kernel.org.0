Return-Path: <linux-pci+bounces-29359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3AAD4272
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255FC3A52BB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD325F996;
	Tue, 10 Jun 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPsUqLyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5825F993;
	Tue, 10 Jun 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582336; cv=none; b=X0oPhSnzf3vEMBTXI3u1zMwZLdd7RzNEfe9i4syyIfeHQc1VYQzSbzh3t26ouqUrMT8CDWLcyw/9eOluTEirBAQuWW8qFYectLE7dUcSS99aK/l0RXjp7UZmgvpJigiXo29siqEJCvV2Xb5OKvG1vYcyHIETiLPDSIneSz0w7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582336; c=relaxed/simple;
	bh=//nXbLD2pIuvtyrRVZcEXjq2xBxd7UhWVYykh8/Hv4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsZl4vtKUMGPDzfZeKE1bce0agTBjSHC+H0RldZdqxWjn91XuFg1VUHq1jKZhInkZg1K1/rEGBW6IWPGJHNm5rZosKcazup2+NqKr8FcHpVWmvNUtnAGw7kxdGw+FZUMYBNOJGEItN0tLk3mntYyShLyVDstoA5iDvBvTsDfk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPsUqLyd; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-530fd330f1bso1951796e0c.3;
        Tue, 10 Jun 2025 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582334; x=1750187134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soqipNezQwywsZZXzZxEBkeNsem3MKqc8B9xNxUP6fI=;
        b=jPsUqLyd3Hx2frZqPYJ07XT4+/RZMe/MfJnVi4FLPsjXNKpGdN4ndt9/dsmZwH703q
         TeGOCMBVSF9xK8Y0lhsqnkt3bav7vKHioj315AZgDmyvhQKsD1W2cPdr2y8OY6Me10Kx
         jo8VSQC88FqthkwEwhDAwPagNurb8liixxXa93SUvVLU+VZ4fqhpixANDkxv2CG2CNaF
         QykOVgZoN0OSmdyUQOZxWnVOPg1F0HFSKLy4s+T3maB1t4huUxmsbySuv6RPZv7MQKeh
         c2fSrXeiKbAF0/uu3YwQB/MsrbvZ16osWQBAEkXuM8MpQQCcD/E1ESl5An67PAJM1MJY
         VqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582334; x=1750187134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soqipNezQwywsZZXzZxEBkeNsem3MKqc8B9xNxUP6fI=;
        b=FXDHj8igvJhfZfiAhka6A73N6R3h2DRPIH6Sb1YMsizjGhYfytCYD7ACZckWMw5F6e
         vX0YZkPJFSqc6xJ2FE6N0dP7jJ5poHC6fTiogMfszuui23Js0HMSgt2aukBxpCIfp2d2
         klhjhIOYDh0Quzw888Jvr6tih6T32zvWOJf19x6EuSRuyG4Samsa92D863+3353mQyZi
         1ifCSB0nuRwSS6qHvSr9nR0P0w9Y0sMVM+bWI5b9JtiDL4vQym3ZwAD4tGdHX+qvLbWG
         eOJGjCpPBohEGWQQWeUSLPK/SUcScviBAvELhiPBucgM1oFQq5jQN3Gnco9RfsyXRuAG
         Bh/A==
X-Forwarded-Encrypted: i=1; AJvYcCWvJLa2HKGA4669OHjCw6rPZJmPpxJij5thCPGK19zjOPTmqmUMQgRSjzkwMhwITsJhecOozcDqgUS9D3A=@vger.kernel.org, AJvYcCXQANKDBy30P53n4kyVfJQRyQkzWndegUoCSpf6EcQp8wPzd5p7jPqjtdxWo57ci1AODa3ihUkksq6f@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVYaSksD39KVS92cmoaGfxMNwn8d8MbK2fwA4LCveWSx9wuNF
	FGs5XUtMmo8WxmMs4TWB/KKQ+rwfBgos8R+TctWsE64TJC6ubWCeElI1
X-Gm-Gg: ASbGnctNLMaXht/LNNQO3CxAiZKrnAC7hSeEGWtAxSJz0odWnMcH/ndUYOMyKytuQjx
	6fRsxhtYOo5PvLcDZfnm22Eivoxpt9EEnoXilguw1VdwDyCrHHzgIs/kN1BGX1048QWuYtfguVk
	q2/B8cT5AKxzFOs3a2QBtSLPnmL9ehJn2XWHFB4qyoVvA7iORJgXgdzTbOSawvjhCQlyxfpTiL2
	EJM4jhydCYkem0oG5ZOJdqUiyqLs3JdBAVjjawiFWElixpJdMaTW9eg37G1Z5hrsABHyQqK9JXf
	PeGR48Vwcw8cjBsVhxBBBWop/8+VN471u6WckVT7BQBZZbVV+nwX38xDBUEb
X-Google-Smtp-Source: AGHT+IEcI/mcsGgLUh+d/2//VapgDjFnlJXzSCse2dstT8suxfebV9YntzheIBzZcHTa8k/XMYDp4A==
X-Received: by 2002:a05:6122:1826:b0:530:5308:42ec with SMTP id 71dfb90a1353d-53122259816mr651950e0c.8.1749582333918;
        Tue, 10 Jun 2025 12:05:33 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-531224b91aesm192109e0c.8.2025.06.10.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:05:33 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:05:28 -0300
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
Subject: [RFC PATCH v3 1/3] PCI: rockchip-host: reorder
 rockchip_pcie_set_vpcie()
Message-ID: <55166f9fb72229f9cfd40b5334083b8837548a18.1749582046.git.geraldogabriel@gmail.com>
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

rockchip_pcie_set_vpcie() is needed for re-enabling power regulators
after disabling them, if link training fails. This permits quirky
endpoint devices to complete link training, enumerate sucessfully
on the PCI bus and generally work with RK3399 PCIe.

Reorder the function - no functional change intended.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 94 ++++++++++-----------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..2a1071cd3241 100644
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
@@ -613,53 +660,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
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


