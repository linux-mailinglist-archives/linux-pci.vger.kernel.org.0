Return-Path: <linux-pci+bounces-34748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D248B35E6F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1691E463E84
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B622221D3C0;
	Tue, 26 Aug 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3SAfYka"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A13393DD1;
	Tue, 26 Aug 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208579; cv=none; b=ZXyYMfVWQQC3Yt72no1jY6oNG2+GQxQTwm2uVC6neR1rXuKw/EjOXXCpQvgauY0wCUFiex6MhXPO9vgfRfkfBcmPlKyBMDo/DBeFluD6QLQVTT3FcHicPjzPXLBNILJgGKM5wyvO/I180E09XcTxK8JuwVHWCTIq3oSMSCrvltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208579; c=relaxed/simple;
	bh=585ZRqkf/Ch1gjrNgaGbkuiIscE/6LJQIZQZ5U7D20I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgP8ZP8s6Z6io2j3NukmDsF6q4jVgYtZ7KQzXJQgCKtK8PNXsaJodSxTeIWGA3Fw34FZpnmov1nwRTXDphXkGMD+VGmwdAXm7UcpDyAVdIyatMeVo5xtyGF5nQ+lz8IAY+d7cJboicMiO6YzusOAtECJEEKfuyMRyq74oHFKkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3SAfYka; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771e4378263so1725065b3a.0;
        Tue, 26 Aug 2025 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756208577; x=1756813377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7NU0unIhUcUPGeauqBoYnA2UAaXNOgHt2ycVcK26ng=;
        b=K3SAfYkauJJ8jX3x6EIBTAoamGyGnqujUtfM5iaYTEwbVGI5gtEXTbXEOI8v8MS0sG
         ACmnurRkEVhVIfC4xchu3HCk7kn4Ox3TKRxOVhwWV4C+mYfAztlraDzsp4prufGqBTRD
         fJisjGp7Qgb+KKhPnNikPD290tT5/ofNPucCToJ7qDJNPCwuj0IT9Ui3Gl+bLRD27huc
         dWPPyZXOJPazc6AWHl6vf2pCAbEQIF0SSK9nXODBOUPYrSDSrP2w3R4SZhKOT63q1ter
         OoVzS3EJsV9aJ2L8Zn3NXnYj39yJb4Ndunz1c1mkOHsbe3agKQW6F45uk9B1LTe/8UcF
         2T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756208577; x=1756813377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7NU0unIhUcUPGeauqBoYnA2UAaXNOgHt2ycVcK26ng=;
        b=kO4V7IUGiXK35R8/k9ibv7m5l0UuemUUedladkSuWHLgNVlk7Un1k+0s4itzdVnWXj
         1u/Dxc1ixGBx7Xy5eDRaEGIwvFrZ5zbMXl39z+nxATH9PlvxrWUh6WWXeXUwLreFSFPq
         435Q6GNBWM9OEGJoon25mhstenkVfuyCTZPSGmkwGp9bN5cK4XBwMixHlKBNLN65Qrhz
         IwoM8yznnq+lUQ56DCsazfjai8U6BV9/lq0CLigbPMIhcpCwcbHzdvuB0YNl6ZyO/XMj
         xg3+7A1esnxQRhsXW/9VAEZhjFEgvMUQdwg4P4/KkT81lcQaUt5oM2p34tqOjQjDxVqI
         44gw==
X-Forwarded-Encrypted: i=1; AJvYcCVGysq1EpkMuogLyY75nLWTkIYDXNNCKtaZjI47NQogxcmXQKGpZDL4zGVWEKr6dwxqDTLX8O7uhyDv@vger.kernel.org, AJvYcCX8SOPjFgvPTDm4bJRSQvxeppSxrV9OD1PFYDN1gAGnNoYwrYEyqQl6WDH/B9D+lT2F5XVBWZzR0v5516Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuuOKxIrYE/PnDZjrA0js/mzH1gzMMGgtOPn9yaDaYt3XbcK3
	pPvAoGzyVkVimFEhf+h+2aqojdXNLG2bKm0BSfArqAWT70Fri8hwcMRf
X-Gm-Gg: ASbGncsb0IF0rBEOMvPTf7+qZSmePjPSdmQwpP6r/xX6WRqd1RIduKRInJ7HNgWCGW2
	klmCkzfd2O9Lg04ppPmyNQPix/2Y59iDFD9bjWn/6CZ7cliAnewffwuWamoRFKwo4LFRBxmtgW+
	VkTSQcOj75ZQ72ybNYQf2yl6cGm2HpFWaOPPT8IHeZ+kIRCgllZ970gTKMt3ewkY4lUqL5YsSwP
	Vbi4px8Td5BkmTn66hkj1YNnFMVKN5ZpAJ/cRrNTqCsTdDxyIbpzh2rJ36I35tTUnlAZ1V8L0vq
	HbH2SL2KBowIgtq8ZPy9SdpwSPnP5ZOqScCFyUGZ+9X4GxwSLFx2VDd9tNPG+x+bMJ4JilLYPQW
	H36kpFdU/HDg/u5x11z6THCP5YslCqrI=
X-Google-Smtp-Source: AGHT+IGoD9XlX2riB1TZtELCiktiwvlaZNTCXRCN6+prHuC+mdHRseNwVTLGcCvYrnJytt3OboLkQw==
X-Received: by 2002:a05:6a21:339c:b0:237:b53b:64dd with SMTP id adf61e73a8af0-24340b8daa4mr20520056637.11.1756208577345;
        Tue, 26 Aug 2025 04:42:57 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm5612958a12.35.2025.08.26.04.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:42:56 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR HISILICON STB),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 1/2] PCI: dwc: histb: Simplify clock handling by using clk_bulk*() functions
Date: Tue, 26 Aug 2025 17:12:40 +0530
Message-ID: <20250826114245.112472-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826114245.112472-1-linux.amoon@gmail.com>
References: <20250826114245.112472-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires clocks and prepare/enable/disable/unprepare
the clocks individually thereby making the driver complex to read.

The driver can be simplified by using the clk_bulk*() APIs.

Use:
  - devm_clk_bulk_get_all() API to acquire all the clocks
  - clk_bulk_prepare_enable() to prepare/enable clocks
  - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 70 ++++---------------------
 1 file changed, 11 insertions(+), 59 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..4022349e85d2 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -51,10 +51,8 @@
 
 struct histb_pcie {
 	struct dw_pcie *pci;
-	struct clk *aux_clk;
-	struct clk *pipe_clk;
-	struct clk *sys_clk;
-	struct clk *bus_clk;
+	struct  clk_bulk_data *clks;
+	int     num_clks;
 	struct phy *phy;
 	struct reset_control *soft_reset;
 	struct reset_control *sys_reset;
@@ -204,10 +202,7 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 	reset_control_assert(hipcie->sys_reset);
 	reset_control_assert(hipcie->bus_reset);
 
-	clk_disable_unprepare(hipcie->aux_clk);
-	clk_disable_unprepare(hipcie->pipe_clk);
-	clk_disable_unprepare(hipcie->sys_clk);
-	clk_disable_unprepare(hipcie->bus_clk);
+	clk_bulk_disable_unprepare(hipcie->num_clks, hipcie->clks);
 
 	if (hipcie->reset_gpio)
 		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
@@ -235,28 +230,10 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
 	if (hipcie->reset_gpio)
 		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
 
-	ret = clk_prepare_enable(hipcie->bus_clk);
+	ret = clk_bulk_prepare_enable(hipcie->num_clks, hipcie->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable bus clk\n");
-		goto err_bus_clk;
-	}
-
-	ret = clk_prepare_enable(hipcie->sys_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable sys clk\n");
-		goto err_sys_clk;
-	}
-
-	ret = clk_prepare_enable(hipcie->pipe_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable pipe clk\n");
-		goto err_pipe_clk;
-	}
-
-	ret = clk_prepare_enable(hipcie->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clk\n");
-		goto err_aux_clk;
+		ret = dev_err_probe(dev, ret, "failed to enable clocks\n");
+		goto reg_dis;
 	}
 
 	reset_control_assert(hipcie->soft_reset);
@@ -270,13 +247,7 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
 
 	return 0;
 
-err_aux_clk:
-	clk_disable_unprepare(hipcie->pipe_clk);
-err_pipe_clk:
-	clk_disable_unprepare(hipcie->sys_clk);
-err_sys_clk:
-	clk_disable_unprepare(hipcie->bus_clk);
-err_bus_clk:
+reg_dis:
 	if (hipcie->vpcie)
 		regulator_disable(hipcie->vpcie);
 
@@ -345,29 +316,10 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	hipcie->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(hipcie->aux_clk)) {
-		dev_err(dev, "Failed to get PCIe aux clk\n");
-		return PTR_ERR(hipcie->aux_clk);
-	}
-
-	hipcie->pipe_clk = devm_clk_get(dev, "pipe");
-	if (IS_ERR(hipcie->pipe_clk)) {
-		dev_err(dev, "Failed to get PCIe pipe clk\n");
-		return PTR_ERR(hipcie->pipe_clk);
-	}
-
-	hipcie->sys_clk = devm_clk_get(dev, "sys");
-	if (IS_ERR(hipcie->sys_clk)) {
-		dev_err(dev, "Failed to get PCIEe sys clk\n");
-		return PTR_ERR(hipcie->sys_clk);
-	}
-
-	hipcie->bus_clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(hipcie->bus_clk)) {
-		dev_err(dev, "Failed to get PCIe bus clk\n");
-		return PTR_ERR(hipcie->bus_clk);
-	}
+	hipcie->num_clks = devm_clk_bulk_get_all(dev, &hipcie->clks);
+	if (hipcie->num_clks < 0)
+		return dev_err_probe(dev, hipcie->num_clks,
+				     "failed to get clocks\n");
 
 	hipcie->soft_reset = devm_reset_control_get(dev, "soft");
 	if (IS_ERR(hipcie->soft_reset)) {
-- 
2.50.1


