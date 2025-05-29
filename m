Return-Path: <linux-pci+bounces-28665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C815BAC7F38
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285FD1BC5A0A
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEC2309BD;
	Thu, 29 May 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XZuInRcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8522DFAF
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526574; cv=none; b=jMGZv2YLKyKOYNSdzJfl2Z9LoDwcrQcNEUqhUegnKOkSOyk7SU/CoGN8C7TVqvOsvZVm+NKtdMs6pfL0XZ+R5aCygYVarCUCMYN/4KdcdEYhMQPLaxvMl5EXeOj0MkHGx8kc20aBHnUoqR9jKWALfD9AYgSXfPH6AjhMeWnAOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526574; c=relaxed/simple;
	bh=tcS1OdtYYeMI7g/XHAbOHs513PqKnIFqXgFxXuW43MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsIskuscIzpnKF9rFAjry6Y4MoGfhDR9vd5lnl01FlFwdlOYdikscOGDJ3iHrg7ZyAmPyDiXvHVRwOv6O9Tdn5OcAEaTfG05rhE0ksXRgiQ+eqFuUC1s3Ra1sUtJg1QJbKN5m+Ikeimqt6/ljThUbrS0nba+cNLfdi6uTrLXe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XZuInRcD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad572ba1347so137958566b.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748526569; x=1749131369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=XZuInRcDEzGWFNPYuYg71y3LUCbHB822XAXmtr3F0XXTI1wyeblNHFgyIMe8vqovL+
         UMapZzqHD9iqfdaebnqTu/NBleLBFKAk4GxNrXkhi7XHMb9kw0pi4wx3cDZGe/TzXozL
         CRYenAlQ9Yy7vf2kTKPZ6e3RykHIdgmhnljXPdQ9H6til0uJbO17mwL1wXvteJcuu2yV
         v2T0ywPJAJvN+CXFB7lyJyhCfKCCjNXHgYSfROQox04A1KRe0sXD3iuifVoE+8n/TE38
         Hfv6aHFGP8BGoNRS+dmWdqA3ImwUk8JNRHStWLhNFqCJJ9csFdzeiq+zL3k42uk2HIKv
         +rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748526569; x=1749131369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=uQcl31LDXoW8eQxMFaLipoZaVkJvxZslqt+qUeefiuv2fUjEihPPwsmx/rsuS/4Lf8
         xtoOqNM6v8WHjBJK5lMoAluuU3n+MWOsDzi5QldRBmOWBqL9rpgfAFhmt5Ou9JxXJsB0
         Th58cOPFpJsPO2oQhIrlvnPE6X+6fh/0M7FrF/fKVy6jKbDGJVy/Xur9x8Z/zYWDTy+u
         JFsOkfBPOLpXCKm8c+QQ3g87IV59KcxjKBMXoycxQ/FXwuGfypQ53nlUwGQTqvjWX8j2
         EdjVaQwGE3VS2BI0+NjHwqJYh3u68m99HO8YJrN0LHS91NAuzG10yp3IywVwn3r4Q+/f
         2vtw==
X-Forwarded-Encrypted: i=1; AJvYcCUKDpf5l0pvg91lXfpawjpG3Nf67fpnLl/ledD5BzRepmOtg52zu+QP2/wUYaMxWR4zsYW5OZKQGsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2uRkCn1l98a6YyFtFofLs88+jDtTYS1FWRsp9n47Hnmu1cvV
	H3WagcBF7TnNZaXjSeSQFIvj6jx4r6E3Dnf5hIa2767P2dOQ/8d8cvIgPrxixGnw6NY=
X-Gm-Gg: ASbGncthB3emLGRrSxMPqjoupx1MWJVHiWrgN8iVdyX5ZDoTcrf2vPtC1L7XWbn+stj
	f889c3794k5d1+XJREcA2tg3GsNB4VWoyVpWzoDqnS/Soz+2Hbus6Gbapd5cY3SDoN3xpwPUH+I
	K8aA9FFCr8vIGMpNvnaFnLOXI/AEri/b6LheeAIMwfvmktFCv/BgMiTPsLrLvI+0RnRXWD9YcP/
	mJdRNZJFS/gbtk1iw01iZ5ZKEWLWlClUVfBSJTDZ5Bn/epvSgkxeOdCc9hlXqW2i5uwreTBhtpe
	626gNdrfE7g1j97I0ZFRpL2I7bX8LNasXAMekrBrP5YHvnbOA507laSpbBSc/krVwqjmCwiJv5k
	bbDsn8K4i0KCtNzlr8U4KmQ==
X-Google-Smtp-Source: AGHT+IGVz4lZI380iOeZ0sAk76r1bOVlu9hZAX/4jbO1OiKLTkmzMHxAI8gYVfXoqODUDof6526HpQ==
X-Received: by 2002:a17:907:60d2:b0:ada:99ed:67a3 with SMTP id a640c23a62f3a-ada99ed7fd1mr251769666b.27.1748526568650;
        Thu, 29 May 2025 06:49:28 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm26619966b.109.2025.05.29.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:49:28 -0700 (PDT)
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
Subject: [PATCH v12 11/13] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Thu, 29 May 2025 15:50:48 +0200
Message-ID: <20250529135052.28398-11-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748526284.git.andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com>
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


