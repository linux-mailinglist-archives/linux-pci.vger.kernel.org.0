Return-Path: <linux-pci+bounces-26432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B87A974E8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19DB16DFB3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5E29C32F;
	Tue, 22 Apr 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eSgnqTod"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB229B204
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347939; cv=none; b=kGlRtdqe5vxhquK+1m1qYTM2/59jaUSlxn32Eb92ynqcpj1OWa5k8vZeKRDfZ8BeKs7DXULjMiNSUY3rE7RSVR3EBB1mLPAgA7fCcuVm6R9AoucHkuHRpY78YgzxtGIgSt5vXV1QIA/i56/sZDEegan0C9iykxtbuBm/X7DIXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347939; c=relaxed/simple;
	bh=tljGp2ZGKwz5xKjRNtfJTi8eXf68cWZGNi4Xd9Pss8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMOgPyY2W7lNdEMzSBH3vBfAsBrUBiwWWeG2LD+hgXjhqTS4WgU9rTSSwFQdyTpNwelqaPHqTt6OhfiOCUVTp3NhVJGUnHnIKYebuSCUrasFagLv7mzA5XO9dlq9RiQS8b4uOeesesJA3zYnToLggUhYHjnex0EfWyrV5PfBewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eSgnqTod; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso65126635e9.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347935; x=1745952735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYOOl2kWPUOmT3lYpRPa0NBvw7HXmwvyakqo8gvrf7U=;
        b=eSgnqTodInpfl9trHXd+Ua1Dbb35Sgi71tHW0zp6JsG8x1omRxZOCc/yRljPKBMQdj
         rZODUSU42Ip7InsMn9V7swpgWOYCnbcgWtqyfKynXlBWecB0CLfayfvvuefyaxs5wS79
         WbsO6R5AIoDKYhXf76uYm4vPhMtfoSEqeoSZUegzQ4IgKG2V4UVpP89BLjylb4yiZ/Rn
         KIgSVweyKEqqlZOJb+7mBZtPSnhTGqMkZwiICHvdv4Zl2H7Z/KBr/B4cU9aee4EGB2xe
         fQc69KAtBA/emofCZPCvPZXqZ1jW8T0Y2d2+MCuq59SQiCGwZzbNp90VBko5w7MazvDz
         Wuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347935; x=1745952735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYOOl2kWPUOmT3lYpRPa0NBvw7HXmwvyakqo8gvrf7U=;
        b=GQvpCqiHYO1gMpjbiAbtgDw4pfWPtjs7VRC7q0/ySWlAUtayU/miQLX2gGOv3LqCYS
         /Tsijz9AV+valZrZ5QBbDbSKyMgOVFh+orIleUkS7Se3LhAlMyCxqahNmFbEiYwx9EPv
         tjisRt48bVt7hBT0MOS8h3dj7PnxgeD/VqdDZGXAD4jTyicHg3mcPn9UwATJvHIdwW35
         PUJPKJ+o2kGEa3jEdeuJIrah8cl2TbRgjTr9wsb/D80/6tOBte17c6TGc7dGYExR6dNm
         gyXpKTlhKErV+Mn/eL064jxbflv9mGqr72LXWQxCEPtLErHnKkwTPFmPk1RcVXQAIVU2
         rC9w==
X-Forwarded-Encrypted: i=1; AJvYcCXNNOMqUVpRcWvffE7oS46xkezHd6XMET4w6sGwDGBh0mqJVQKL62M5Qza3ES3u9H17wq3NxyJDFV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/sFyXggOPnH0GeMFYvSCzUNzbfUWJk54JIgBmZEQrJbh9p4t
	HXugUetKgrUsU7c1nthcC2KKpxlSUKfjLtJTZOHpitOFKDDYHKsE/jhHDHUUu9M=
X-Gm-Gg: ASbGncu+014KiwgNQkEMp7y4CJnvSvOaw6BWDfQggHcQKgKi3aO6TAhUNc7Kj0y7gsj
	R+4zmWP9e4qKoH7sPcoROI3esuNUUse2rNAy4D8tdBJMWkZgBoBqvz7mt71C7i//1amZnbhVoWV
	oqhBuEsCVTSj793wSlf0LVyA4KRZK7+lqIqgZLasrrLZsuO5HkRYstcLzj3aji68/d6zvNWMuQV
	MX+XbnOzHg7ZjrhExsVOkDoIWTLMzl6Ty9DAkJAqWhlZrk1Vb4C7Li/eN6y344DDrS1QeF6o7dP
	FfnYNqSQBdxwU1Og29rc2qgVa6ot3JiCRZ3LpiJLRb5T9FvZd308xPJgcrndEidWzPUSx9Y=
X-Google-Smtp-Source: AGHT+IFJkUzhohlFWFD4tnJxylRaHX8kyBRjPpJLd4zTyh/XarWYhUWFDm8KDecIRtmuP1EH+CI8eA==
X-Received: by 2002:a05:6000:2509:b0:39e:e75b:5cd with SMTP id ffacd0b85a97d-39efba2c98emr14139193f8f.3.1745347934622;
        Tue, 22 Apr 2025 11:52:14 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39f069df9fcsm10861464f8f.16.2025.04.22.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:14 -0700 (PDT)
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
Subject: [PATCH v9 -next 11/12] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Tue, 22 Apr 2025 20:53:20 +0200
Message-ID: <928679d1511a43b8dda150009eb023b4eaaff5a2.1745347417.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1745347417.git.andrea.porta@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com>
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
index 9e16b494ab0e..53748ea4a5cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -622,6 +622,7 @@ CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QCS8300=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -704,6 +705,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1301,6 +1303,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


