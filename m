Return-Path: <linux-pci+bounces-17520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB609E0079
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C95282FBC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA94204089;
	Mon,  2 Dec 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TRUClMXb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248061FDE2C
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138361; cv=none; b=Ik4NYihoIa20W+3F8xXyXGRAEzgyR4qb1AXFuA4JZJFyDzFiTZHygVOlVKBESRxzHBDmi91YTun335+VmIFI5z1sQHn6fpkuACSxsHxm6IlK1kukf4yD2KBGzDdr+iP7h2g8V87HwI7bVBpsyezXcTnMA1hPMDSdvIq/lhKz79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138361; c=relaxed/simple;
	bh=QMBFXNqBpFgYP2yitTOgzdsfZItshvzAST6FqjQRjNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq1Mgqg/g5T520U0vrUXygfHHsYEURkNcvDpaMNqgHhs0Ndpj/tl+YNTueSYMazSr/m0hZVU513lMBB+1k6vFv3fMiSt145swaayg70XDd1GBveVBOMZ5iSmfc+02W/vKyY3E+gFLdEYm9aEgQX8Kdw/jwpos4cBW5QYddCuIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TRUClMXb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0d3dd3097so2583223a12.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733138355; x=1733743155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dNlxUlq/zQec54ENuov38IuayLoY+NtEDaFnmM1inQ=;
        b=TRUClMXbT/BkEMucbnwqj8OcamE/lxRppa4P432szv42fzZY4uemRAU6iOZ7lsvAc/
         fwPFwx1PMfCtYKXQ8kfySDfXiki98a6L7hP2mDvg6NYBTSK92eHCHTkM5/dxnsxhnDVh
         9czhw0Zfjc9gR7ITOO3D8PJRVXyqkCwRu6VBq3gKr4fkkTBa4pc7n1W7bWHGio2Gco/l
         4cnH37V3kw8znEEAlmF3wv2i8gTG06ijbVp8lk3WHkawjM7ibZTM3dLei6KNr/FlPGx5
         jlA7CO0nA7UDUIr87WQu1nuM5wSUEZQ828yYv958AZPjqFj8pdzljNItiO9x4OfVCUgK
         fHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138355; x=1733743155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dNlxUlq/zQec54ENuov38IuayLoY+NtEDaFnmM1inQ=;
        b=YFYMZrU9G6zKNpHY24sAMSqjvVasPj7KwsxQtAScgQ49F6XSRZdmo0s71NErtwhUb/
         ASJN7nxKEnQjw5FhHxN86/yE10T3nAd2hcVmk65mw5jLCqZPtBCRAhYkUZK8LSqV2CwU
         Jw7ukJNQjnbFyKp+KZ7gUA8fkFMybvWe+jFxtt7uuXcym8dMhQf//FZLCQ1jFUWeyMvl
         zay3w3ZHatgaG6zA2eHC4poHa9WvxMvjVsqpT7evurnAAWJehlefqw9HDoPdlFtWxpCU
         PLUfL5PoVjv48jrO7+3DT36yyElNUQ4yKNFmE5Jj6TUnBQqLkTJl2+JXsaNWdEvcF2tY
         FfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWQMyc8cxudVVTKXyVnyEPIt7BbauGv4FFX2Fi1ByWHidTdP1FyaaOHR90cjRpVlEmaCloMt0kEdbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyhUW22dhmd3a2zYnWKbZSGyGSQzu/d4rSVzdM1azuUv1icN+
	vhMNcTomHUyGhMEzGWiOxnz3bspYLSC5SNU4/kizS91fWpVZBhHz0MoDa59S8zE=
X-Gm-Gg: ASbGnctIyDhiJc2V9Xke4epRjFPw/zHJaFbxDThcf+kaiJ1qwDyvS5qp1r1kVeVbIfB
	JmaEa57PkclKbubkiIVO4rbmyNA/e3ZDKTbwBRl2GzFSDzYa4KDZXDdvkWPc2CxjzjLUpGNDf56
	vGn8qWkl6dlInRmQxQJmCRkPtzhUepsUNB2TYsbj/zWza6kL/UFW6Cpv6oxlNnVbdx68oRK4eUS
	F0jLdPafilt/xVAJUPMFVNMTn5SUxrBU8tFpncCGwVElLV59XjQNzb4VxrMQeNOcf7eQq/Lf6S1
	GXn1a53a33m6KLP4mwC0
X-Google-Smtp-Source: AGHT+IEh8VAXDJC3bTBBrwDpqq8+bh66QBF8HuQqB3DA5Y6Ne4IKysOOgMjNIKrVqzCRG1epx5t5JQ==
X-Received: by 2002:a05:6402:3484:b0:5d0:904f:710b with SMTP id 4fb4d7f45d1cf-5d0904f726amr20592659a12.34.1733138354832;
        Mon, 02 Dec 2024 03:19:14 -0800 (PST)
Received: from localhost (host-87-20-211-251.retail.telecomitalia.it. [87.20.211.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0d2f0652bsm2371980a12.25.2024.12.02.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:19:14 -0800 (PST)
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
Subject: [PATCH v5 10/10] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Mon,  2 Dec 2024 12:19:34 +0100
Message-ID: <2dc27b08d82e5257a831026c963ac148d11cb6e8.1733136811.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1733136811.git.andrea.porta@suse.com>
References: <cover.1733136811.git.andrea.porta@suse.com>
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
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..91b39026dc56 100644
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
@@ -690,6 +691,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1272,6 +1274,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


