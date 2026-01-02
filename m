Return-Path: <linux-pci+bounces-43937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8CCEEA8B
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 513973000927
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96142AB7;
	Fri,  2 Jan 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+70soIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6FEEB3
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767359911; cv=none; b=JLKEuk9Y87wvxndiCezHPL4ZJJkatwfMJ0TQxTYd0D18ZtBMW9d5E6KvN0BwURhA7u2C8SK6Cgy/0zL/QX5RGAyb0K9EzEAYwLOjX1GSTPFkj4ABhXPameDdzrZ1ovxTQr7bfV2mSvXLdpJRCRwKpAkZQp6UvUi7lBgdrKO+6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767359911; c=relaxed/simple;
	bh=2pBAKMDoxyGVLXL2/OqDyXk+Yp43kassroboK+ZlRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb1RQuGPEhJTzaWXEnwwWqXxDgIzrygxWRLImnuv20MJBV4WAil1lPVh+l55U6bF/aglp8z9MdGfzGVrpEXe49P9EJnBYpiiRAoOJC0Aiz/8Z7/XjIs27z1zW4T2CEpCM61VKXUq6A2xLeyEsvENGKdUwCr38I3GVEGbQ4+8Pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+70soIP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f651586be1so5754772b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767359910; x=1767964710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh0+1+chHjNEp1bDD22RGjxNzSGu6tfL89BVhbtvA6w=;
        b=E+70soIPC1fLRetM5ZM8SusCJrcnVbaoqWKQzorw1VrMh5AHSS8YOWBvzpeJA3FivG
         Jpq7WC6E2k4+VEzuVBHLnfG208QIcRMGX6ZN5/o+87fyvwct5ufgLZEukba493DAGhAY
         W3lwa9RK1wIEkfFZNBvdP3MuBlgVQsGqbQ994RcWGZ7vxDRITVGbYrX7BwwmGO/p77Jn
         w4TpQ/vj7J2Cws77+RTW/1odMYDiq1zM938rtqQGZDduZu77ErBjWjoOn97KYc58tHTB
         iy9Xc3jNOhHcUdGB132uxF5mvYC8KDD+W6AONz7l00uICH0OP0OFblszmT55DmyRyzg5
         ASLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767359910; x=1767964710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh0+1+chHjNEp1bDD22RGjxNzSGu6tfL89BVhbtvA6w=;
        b=NbXriL2RI90lSXiLCgYJea8CDfl4KdKfrFuKbE0BSZ191+EW/ZaVkM5PFm2M/5EDdh
         nxy8ydMuEcgAAX2HrdBMgcJE0Y8TH5HE05qZZf0ow3wGbrLBNXVvw8I1WtrwPAkfJqrA
         wZ9D41Qu7XXbCj/rn1cDZRNF0rmEx6MWzce9t25Zow9yDxSAv8HJqPMyt4TeL7JIc7sA
         HEvcuDd4ZwU6iApdnENTiIGgUtoUNlFKbblC987OEvd651ocIT8161NThBA3/tHCwS3a
         q9zjJnx5Vd89U2BRww5Wx0MYGctRY1ARYeDpTzWl9J724OXRl+sbRZUSGn4e5HUFt5gj
         YnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1+gAJ0xGY4PmaKjrSsuKFjgfO6Ujtyfjbx0fv80RT0Rh/Uv7TCUyEMBBlo4eTikumAjBwMZg2P8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzntrf1Au2rCzL3hrkKXdgduKWuY9q/MMvo6QnUr3XRFapxzCAA
	GAlZiYomVdvZLISAwRpN9FIjKxdgxZvlR1dKcIVH8Z08LZThdtJjL/Rh
X-Gm-Gg: AY/fxX5iZvMb6RPUHQN3jGjKlR0Zz4htAhOoIXtiF5fjJmQ3ayUI5wAXW+RwxAmYZBl
	o4JWd64eojjW9M2B0X+g7ZXWFNGb3gTfJjKAndVBb6oY/JqpuEJZLPMoO1UePw8JDHTVZgxSwcZ
	OG/XMit8avG+y8orPDUT3yf+4D5fIlnGghWZx9VN/hoMUCZFS5sK/5wJB5Cf15kUhrw1oayq0OU
	rVYe8af51lE9W4vagc9//Jv4FmDwN+KYw2ncsJqgJGO9pU0hc/iDfatvh/7LwX3lL07j17dB/2h
	vzqRRdKPQXYnr2aOf3AjxQuJfHo8EsvGIeujAgbzq8MsHpaY6iOjN9xCDiy5Z/ggpZrby51KtrJ
	og7Vh3Wp6y9L35T7Nsy44f6+VjazbEHS9WcC4Iwc7JoUBflFQ42LZLelaPg5LDWfstEgMwA9oTw
	vFA0p4sA==
X-Google-Smtp-Source: AGHT+IFOoSD4aT3DrhU3ikdyAs6DYGzFL5+ZFBK1G4TTasauTKe+kqxCEq8s+rYlew1jpVJY/wcLlw==
X-Received: by 2002:a05:6a20:3d07:b0:35d:8881:e69b with SMTP id adf61e73a8af0-3769f3352c8mr41132629637.18.1767359909649;
        Fri, 02 Jan 2026 05:18:29 -0800 (PST)
Received: from rockpi-5b ([45.112.0.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961e039sm35278770a12.7.2026.01.02.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 05:18:29 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2] PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe
Date: Fri,  2 Jan 2026 18:47:50 +0530
Message-ID: <20260102131819.123745-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime powwe manageement functionality into the Rockchip DesignWare
PCIe controller driver. Calling devm_pm_runtime_enable() during device
probing allows the controller to report its runtime PM status, enabling
power management controls to be applied consistently across the entire
connected PCIe hierarchy.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2:
   improve the commit message
   Drop the .remove patch
   Drop the disable_pm_runtime
v1:
 https://lore.kernel.org/all/20251027145602.199154-3-linux.amoon@gmail.com/
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f8605fe61a415..2498ff5146a5a 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -709,6 +710,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto deinit_phy;
 
+	ret = pm_runtime_set_suspended(dev);
+	if (ret)
+		goto deinit_clk;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		goto deinit_clk;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto deinit_clk;
+
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = rockchip_pcie_configure_rc(pdev, rockchip);
@@ -730,6 +745,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 deinit_clk:
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	pm_runtime_disable(dev);
+	pm_runtime_no_callbacks(dev);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
 

base-commit: b69053dd3ffbc0d2dedbbc86182cdef6f641fe1b
-- 
2.50.1


