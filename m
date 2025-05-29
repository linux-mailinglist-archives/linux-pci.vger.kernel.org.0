Return-Path: <linux-pci+bounces-28620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64142AC7CD3
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12DFA40553
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4E28F527;
	Thu, 29 May 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hF+sCsj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63C28FAA3
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517753; cv=none; b=ItoeGM0UoX5UICaFG+1kIbzeSgknhhCkCKzX/yPTbW32ablKvLWWxMIMNC/JoF/z8iIC3PotDyyg+eIV5MflfRdTu5OcaiwiFpsFzv10d9rfKD0rqi7eASRDgTdZESQRiLY+/GlP4qEksMPCe3Cr1N3W6IY1O2Cb5T8wdF40ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517753; c=relaxed/simple;
	bh=tcS1OdtYYeMI7g/XHAbOHs513PqKnIFqXgFxXuW43MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Byd3Y/cy5RXkaVtikn8FW72Y3qxwdD+D7rgZWDmuEC0wBJSbeR9RRNficxaEfy7BMr13tvfsh8O0vcGvLkPsoukJLAAqEZ0GqVX0Rq5FRruhywIWEdwWFHC8CJX5cakgaL7+z7Tpx7Jm+gc51kIdsa0UJCuug4Bfohe/xW5kOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hF+sCsj1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad1b94382b8so131148766b.0
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748517748; x=1749122548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=hF+sCsj1flHN9nBuUis3qV5S4myi/hCxOSx/IYooPSziMv7dhu+nvT/YDqxYpoYhiH
         AsypeXh/3eOkih/YIk1AoWFfoxBC05RQo46ON/VSK+EyGBEmbkysrEhGkQA0B1r+x8A3
         WoAzCopOrkeU2NNmccD79tjRsdBGpYzGfLs7PPFRD1IXe0w9JEQOa3oZJ76lPsPuM9dv
         HhaCo/Yx41rKr8oev5yZupxjQcT9cC9+cZ6+yd3vpJ5zGh8z2SteRcOKgEA464WBYYHD
         ynEIqXHCT170Pv5B+bHAEk1eqvUuoNGL9kYlDgaZgQ7NUk0rSCVThLQfbohVlq2DnL/M
         /49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748517748; x=1749122548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=gNfroV3TzEbfj5duSj1WXD7wc9IoKD34inPM4Etl7Mz+qCoWegugZOx6vDMwUxoT1u
         kanQEirNdYbzvLV4FhZUjmPLmYhShiTbTU9VynAf70L4y30L9BSCao1Ij60ODicqjcJM
         sdVOEl8jkaQby70/DpekOsPAcrrn1nu0gqiPe6sLRYg+GmsWvaPsTME22ume7B1yUI5v
         On4C9eKjpq1LzN6qF54Mk/IShTgn9iT18OIgrHT8T/JMqK2EGNF4RcyvneTU53wnnTze
         JOfYWJr8y9F7PrjDToLCpPg3GTobPxM4D3HOCKrYJoFr9vUiHXtk1To2LaFlj36wwG3v
         CZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbTS3M3JR127WqZmXwiZrZXL7swPIMfy/Iqfbl3zVd9ls982zxAbeOazTPg06xvZTwDpWQkAwkyus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHmwKSHGFJnzg+kIMG4KNz4vZXaI5NCJKjqMbSSMpSJncXjKF
	GvH9zwyi+alo8d6LtrNYEgTVd/fsiFFiU1kdooof7ph6qJ3Xm+xpD1N7xBhUjXmJSZw=
X-Gm-Gg: ASbGncseDwlpAWYy+U8/SXZoppyEUAH783WQ/TIucgiuIRRF4kH/zT0yWK0ioKMr+dg
	X/kSLhw4mV5jh4qLvXg/QJKMUIgFTCQRVNGT4zHbtg46E+pzZY4yw65fEiGQuicvof7AM3QWeSu
	KDpqLwse49ZqcUIoKQPIJ/TU8IV5mztShWOVTtQ30Pb0xZ+LQ1iIZQUlb6iJbSErxDZ1T/cZ7iF
	dwZiq8bdfjfjRGYpudR3MLnL3dQcjLMdrr1yh85DDo5Ia2JXlTxpAa6faPjO1/06cyGc+h1HRYX
	RPIsDqNzDLjtrPclj3C3Z4Jt+3r1osHhpmXasUHjxk5UmH9LMIKWp9QQFFL1TangLct7ePuKgVN
	GyG1toDvFmxJKsX6nLoNELw==
X-Google-Smtp-Source: AGHT+IEJVaL78WGUYXXOjvm6W0GxbUpCLixhBH4c/y3R/OI7jUleYio+vMA2WVkvn9YFZoalSxDrog==
X-Received: by 2002:a17:907:7ea0:b0:ad5:b2aa:847c with SMTP id a640c23a62f3a-adadf2a13e1mr175465966b.54.1748517748298;
        Thu, 29 May 2025 04:22:28 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d850d88sm123925166b.77.2025.05.29.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:22:27 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v10 11/13] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Thu, 29 May 2025 13:23:46 +0200
Message-ID: <20250529112357.24182-6-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748516814.git.andrea.porta@suse.com>
References: <cover.1748516814.git.andrea.porta@suse.com>
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
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..f6e9bb2a3578 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -620,6 +620,7 @@ CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QCS8300=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -702,6 +703,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1299,6 +1301,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


