Return-Path: <linux-pci+bounces-42105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25863C89456
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EE10350118
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE658305943;
	Wed, 26 Nov 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BLFWS1m9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1263019AA
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152736; cv=none; b=Kt5cdbxis+29GMW0oaF5HPFYKmXrGgtVTuNiNin273z+hxThleE/v1iPLIkMHGIpiEfvGH+EgnTcFWWSDLSoFPd/JSbugsOB4f07/8LvWdBwe/eiukBaNUbSEBB9qo57Epo2qpcLQJ/l/Iap2DjeoHOIBQKWfQUo6iSTjk+p2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152736; c=relaxed/simple;
	bh=wpO4YdRzl4FXS5XnFrVgqIY4azUJGaBFIP1/PRq/FeM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E5h9BqV68Sl+XxWwl5HxgKhHUiDG/06fFxNfGVSd+s4W+bDPknLnv3QZezamLTeb+jyKemb5mAd+QLZYGZ2y1W5+ioSkXuXdQoBGAUdF0TGf4m1GEL6LZ5IEszahjrnnZjaDGHDBJrh2Vl74XxpEae5RowkjO9UjCH+VGNGMy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BLFWS1m9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7380f66a8bso980528966b.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 02:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764152731; x=1764757531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y54oaxG0Dj1pL4cbl3uoWikMGpPnsgNQgNPzUQlYkvg=;
        b=BLFWS1m9KLOtTqC+FjUqWtCoqZKj1WmrwKVLZqPYfTabZ8wYUNvCLghozJPPkgG+IU
         vpEMC5XuwgmfxHWvw/lutJ7Na8ecW8KOeRe2uJfLC+jf/pZGOnI+GQDUViEu5KQ+d8o7
         R/Sebw7gpxDLEFW4+dHagyJQLAI/9cq5puhA3/PUxzmL6mAehcVemIYKgh4uCRsy74jx
         XZ2rWR58/pj37CA+A8JXSiKN6S+BK5zyNBUK98ZLxS3XW/N9l8wPXSrn5EJa7JiNnqsS
         WzcEkb9xV3tkC4yisq5G1OWCXWmwpE3ddCh9f5Ei3p/2Y9DU8FAiKHb9c3GmjBLaMpkE
         4D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152731; x=1764757531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y54oaxG0Dj1pL4cbl3uoWikMGpPnsgNQgNPzUQlYkvg=;
        b=R36jcds8PbJI3Gg0UFt4S3nzcadRctJXvROO7a4wOX8ZYKG9UcXSNIrxiI/RbvV0PD
         YGDH0CSI6S0hsuxinQQnL4YuUC9QWX3gfgVx94uUvP8JIPUY2X+nSgx6DO0vK3AQyDw3
         0SBE2NiyYm6aYnar8jri+0uciFbUeqIcDBtLXYkoD6BvhwFR0wocgoL3U4iBov06QUQm
         UzYT+ZMZAz8/SARMGVC8NqoRCTRc0WmDNVkJlg7LWpEmo34z2rweGcrXpxIAZpoO9bHq
         3J9+VVNVAtrl0M32DhPbbFoDcpqcFTtqJCKLpwB+tkh/BYlIN78zZBLMgjSrfMCSYNd/
         imHw==
X-Forwarded-Encrypted: i=1; AJvYcCU82Xh+KQe8f9iCwyTCPRRL7tgFIs5BuaF0Hqk+/6TP9nGUTblCGWI9JwjF1o58AwoEX3oJ+I8uwcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSUW0+kgNP4GcxDNtNHeZxQIqde+lQIFYLO6AuLCrNyAZT1Ay
	J1QdcrAT7nisQojNClIvaWAdO3WyXBGYM6KhLb0QGnyGIKalXDmspw7NKzz0Edm86/8=
X-Gm-Gg: ASbGncsqFoM4pOuSCiMqBhiQLeiJkXfeImZycfqDDb2qWAiY9seo4li25JKFwd19Dsa
	qA/TbYsmmr1PoqgLBkVEOBvJr2Rz02DVr//W8Zxo+N5ONI5zygI5Lmy0hfXKcBkJS0YTRQ+eSnC
	Gq2h1CHORT0laCXbaGjWVuxZmG46MBbjsFgbdD+x5wdUkeFFzcfeKkcYl8AFS2kRVpiC3oTMuRm
	DylD9WgKDGD7NGrV1vCL2GakwVZGqsWRC3lxBbfLRfapqbWJMPPpF9oSd/miyaSzZB4F7c8xGWt
	t1OdCrcWqX/Ds2bZmt9pMYohcKvXYJuTRUoMU+bpkHz1fn6AL26m8KX8oRVPhH1y1Ue7d7sXdE9
	v+9mVR4brVsXgPiRdWrS4y3RcBLjMvdPgtMpmkyCgpumDTFRGI8VaZIPCt8oQoABiDufOvkrQRM
	YGZw==
X-Google-Smtp-Source: AGHT+IH+Tw/e/NsQ5tjclqAJzxon5hUBLjMdlLg1odb1p60MbJfONiAuRIRtQjCQMyiYBCR2FpRrmw==
X-Received: by 2002:a17:907:3e13:b0:b2a:10a3:7113 with SMTP id a640c23a62f3a-b767170c818mr2091782666b.29.1764152731449;
        Wed, 26 Nov 2025 02:25:31 -0800 (PST)
Received: from localhost ([151.37.182.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765503a990sm1838380866b.63.2025.11.26.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:25:31 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mayank Rana <mayank.rana@oss.qualcomm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: controller: tegra194: remove dependency on Tegra194 SoC
Date: Wed, 26 Nov 2025 11:25:30 +0100
Message-Id: <20251126102530.4110067-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3032; i=flavra@baylibre.com; h=from:subject; bh=wpO4YdRzl4FXS5XnFrVgqIY4azUJGaBFIP1/PRq/FeM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJtWQjku9thK/0GEfkJGpcqcOpj9Pa024q9mwK tlRMr7H8hiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSbVkAAKCRDt8TtzzpQ2 X+x8C/96t42X3zruOCOhc+rSnFiMTOSL78hPotW1mw3mhN1zEgwr867XaN2BkMnYPQmyPtlWqRX czN3XDX0FMW7Z0REomWa2KBmPxDU1HDTcGS/ZEmYZZh0azvWb6snd3mDsFLdh8h5hbRtYT38fJz sn4WvDXkf+eZb0QSGyxHvo/XjYmbOydEEWM1ZrJZnMTL8ayEGmpUVuQxqxvAh7FZbPFzSCzVuMt Olwmkf780ZxIFFw112shz/psWSqaRaLIP0qS7tipygivIqZvLOqImzUjINdgQ0bcJ7u5WbAb0tU hFBT3xEyy+GqKjpKEGItRzLWmHEd3BKGddqfV4l/28rmvxvv/48J0ZCwHht/bab+Tqdw+VQju4F +ZJJpSxK8VxaPJJxnPGaxjSY3kDoNdxOc1qlj0FW5TyuI2EtG25emFgg1iUeL6xalLcZQtZiXu0 ZXW+d/w4wUnxBZAViiCd+CFL63y3ZAFo5yRvraeSnY2R9FHL0FW9QVynCUFFX83Tyiqnc=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This driver runs (for both host and endpoint operation) also on other Tegra
SoCs (e.g. Tegra234).
Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
reflect the fact that this driver is no longer exclusive to Tegra194.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/pci/controller/dwc/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ec..1123752e43ef 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -227,33 +227,33 @@ config PCIE_TEGRA194
 
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
 	select PCIE_TEGRA194
 	help
-	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
-	  work in host mode. There are two instances of PCIe controllers in
-	  Tegra194. This controller can work either as EP or RC. In order to
-	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
-	  in order to enable device-specific features PCIE_TEGRA194_EP must be
-	  selected. This uses the DesignWare core.
+	  Enables support for the PCIe controller in the NVIDIA Tegra194 and
+	  later SoCs to work in host mode. This controller can work either as
+	  EP or RC. In order to enable host-specific features
+	  PCIE_TEGRA194_HOST must be selected and in order to enable
+	  device-specific features PCIE_TEGRA194_EP must be selected. This uses
+	  the DesignWare core.
 
 config PCIE_TEGRA194_EP
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PHY_TEGRA194_P2U
 	select PCIE_TEGRA194
 	help
-	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
-	  work in endpoint mode. There are two instances of PCIe controllers in
-	  Tegra194. This controller can work either as EP or RC. In order to
-	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
-	  in order to enable device-specific features PCIE_TEGRA194_EP must be
-	  selected. This uses the DesignWare core.
+	  Enables support for the PCIe controller in the NVIDIA Tegra194 and
+	  later SoCs to work in endpoint mode. This controller can work either
+	  as EP or RC. In order to enable host-specific features
+	  PCIE_TEGRA194_HOST must be selected and in order to enable
+	  device-specific features PCIE_TEGRA194_EP must be selected. This uses
+	  the DesignWare core.
 
 config PCIE_DW_PLAT
 	bool
-- 
2.39.5


