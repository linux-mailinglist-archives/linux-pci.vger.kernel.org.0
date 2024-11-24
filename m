Return-Path: <linux-pci+bounces-17259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F79D6DF6
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 11:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0105BB21280
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE9199FD3;
	Sun, 24 Nov 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XBrJQIO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04521917E4
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445498; cv=none; b=l9Aek89x/XlcQQDhfl2fk8ZqswDb4aGaZRVTogjuYvHPaOXS9Seef21pKNgaL4tuR8j8Gr7V0SydejL0G8apyT+bVtIdDljjWzhnW7utE293o+I7K20Anu+rqqp/60zD03/kvXPgTTZFKuaPoFqNHc8U9yQ29IM546DZJnh4CEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445498; c=relaxed/simple;
	bh=t5mH22vOPTQPTUILy+w//FEAgDrx/+HJYbcUWeq1WtE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNJ71ZhTQHYtIpG5UlC28RRZfj+agvSYQ9STA6FNm5kzq64acjrYMP24xjQM/bya6eNuVhOLQAX467yEGDNfWYv0OB1uf8bJreXbNYXTAWX5guZaW/dztxN/Q70ieRWLh7i0O75DHFtKmRNLBBFd9r3EHFiHmSNu5U6Bf6TXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XBrJQIO6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so41186566b.3
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732445494; x=1733050294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFDhd9Wyt3Hlc0wulj/fO0SlrgobJnK/8PJIrWrttTM=;
        b=XBrJQIO6TFOrhqJqChpvemq8eyuRlb8SF7xLzm22CQ3h7+Jnz8CPYYDHLjx26DX1RW
         6ApASgXuIFEm6DhHhkDUQAWTWqIAA1LDrcR1mdihtdczKBjTLNr7t4efGzMNI2+aUSoX
         US9+FrcX0s0VZkQl7ejfBesJfrPTi5WbmmAYVxRH83iQTdoN/3xu2LVVKs9V677A7BFy
         J43V9f6jGw3CbZgb3Em5S7gjohYs9BqQdBiPXl/z/I7MalBvmBQzxTDtJismy7qYlC4e
         nSdqrISk9U7hkSe69WmLgs2RGuV2F0wTXR0l2150pilqyVfkbQ1wLm5UC7GyBjndB5ED
         YtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732445494; x=1733050294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFDhd9Wyt3Hlc0wulj/fO0SlrgobJnK/8PJIrWrttTM=;
        b=f2GJEomxtwGi06ooXp6qRn+9sTGuuHbVlojutQN8BZuiq/OcGbTYl1BX21WxxcqAUk
         Km7ZhGDR+4Zc1LkfI3OBX8VDAQ8a4jy7JUazsX/tI5YtDB/9YrVf2ZFxEJi7OOwSZgXx
         F5ZOiQucy9nfFx3GXgBTKhGIhubNS+Z8rkQ6En/1AYTObMwAKGiRpgZk9dauCzJsr7ZJ
         20Exx6mD0KqGHrL55MRHbYQBD36RlKw3qSyYcn58AP0jU+VfA5Yp91whbaP2ovmrJM0t
         aLGA3p1yaREjrcA/7rsYq5vIjcY7TuvjII32eWsGlcw2gjp7DCXV7qN0nhyhZdcZ2wef
         uRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwX9M6evEUCiIKhmUlpTDr8TcjkONP3JJumS2tZJ/Lal2bF3GMDBxqn0wbVtO+bShekNwVB7kONaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/ayauiC8bp94tmQsekyVuVtO/3WtuYG/iSLCEmi6s2UFf5HW
	YOMMej3qKA+S3V8FFY/9OgZXKEFK8yGzRGjklfd94XNz2/P5DY8g41K1+ufQ+10=
X-Gm-Gg: ASbGnctaxjRGcIxBLkMcxveziKdolFBu7D7NToeLytEKn6AKVpveINrIOdb4oxD8iMX
	Xz9oIyABIGzCBRN4OgD0Ots1/altKFgHp9k0W/9k7tbzIrsUivX97Sh4rgI3BIw0m0/4v2KJAuh
	7ZfLDNSYR5/Vp+6yraooQUQOm3DQzr4J1qpEOxy1v7QJZxEOrX9Se9LKW0xX5qrfpL937/R7x3r
	L0burl5bmpPc4SMunC2jcO3xMVW9goBmc/vI0EYj0egRy0oxg4tCIRwv2Vqfma4zQtGzrZAixvB
	fYqgCHFPNEczjaHSBQP4
X-Google-Smtp-Source: AGHT+IGkXmpO8F4Dhl0EGpNxs7dSonbb3C4mmRh0iCiEPq5mTBcYlRE2EkQKpKCjp2nit8IeufV0YA==
X-Received: by 2002:a17:906:18aa:b0:aa5:4cdf:4a29 with SMTP id a640c23a62f3a-aa54cdf4a4emr66028666b.31.1732445493808;
        Sun, 24 Nov 2024 02:51:33 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f9e25sm328892766b.78.2024.11.24.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:51:33 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 10/10] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Sun, 24 Nov 2024 11:51:47 +0100
Message-ID: <2292350a8bcf583129f93996c8a6ad5572813d9a.1732444746.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732444746.git.andrea.porta@suse.com>
References: <cover.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..7c3254b043b3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -609,6 +609,7 @@ CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -689,6 +690,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1270,6 +1272,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


