Return-Path: <linux-pci+bounces-28593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD3AC7C29
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807F47A93EC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FF28FA98;
	Thu, 29 May 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NicgD0hc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271328F502
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515696; cv=none; b=dZ0kkW53IrcIeACepG7lKycNGHHZzzDkl1PaKP6qaA46/qpOTqMBr/o1qguif7iTUdJvsQ4qu9HXMArJwn+J7v1UVmgKib9BNDV09RWlMY1Rbn6/5MRVKtMkIptXrYzL+otdhb1rkqbvqqEqlynX4slLXzKbdgROmMHy9DXUnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515696; c=relaxed/simple;
	bh=tcS1OdtYYeMI7g/XHAbOHs513PqKnIFqXgFxXuW43MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxIxf2tx+LlmhKdbYGhnlAVrqlbdyOODUvgzLz1YswpZ3ZvWNo/fkB/bJqhXLKbtZzRQRVyKXPQsIsTvUejGQ0U1rriDfW3hZHfqDA5QJfX7sn/EsgO2GHZ1bIogd6fUdw+19whN0REc8qeqyLsxNVGGGq51+RGR0DPT7k0Y1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NicgD0hc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so1197617a12.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748515692; x=1749120492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=NicgD0hcLgy6HhP4OZp0J0IkRCXImymRLlH2QGUeKC0+SkJtpwN60jgVSpWKp060vD
         6hoTDaU6VBFNWiAihQJFfpwVumzupQpN32vH7wXyqByzcN3wGkRRIy4IilRL9thniVMz
         JfU1yONPVIrCOTdJvveopWTUIjskKZFnoZsS38pya+5ZFg3KPQOrAb+mKB12XDcuC6sa
         ujUcFUmkMVBgWs+PthQ1BUU8iwqlZP9YjFE3fO4o1oZQ3Cyq0lD/eJ5Z7fP1wlfih8KW
         JPb0UMXTTS8ORaCHlQinep31n//VxOvpe3ka5IHPx/fskzgTk35+GmKH3h5SXf7r60fB
         b73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515692; x=1749120492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLh4eS1a0IWerdW1Bha9yJdjwbF94WZ0emKgMLeoZKQ=;
        b=P2EWxMc0XhiYqMBnVCHjvp0QbDuejt1N8neIfyR3M/UD8aibBu/SRMWhXAMKcnBkBe
         3xACOoegcHEkIJJbBvrWWs+xPi/f1/qjYRZNm2/4QgGO1hM3UVQRdYul3LrpDRUtOBr5
         6SgnzS/rMY45cpUTl0nsnBsoYQ/BQG2KEMJnpCXbOrukxUayd/bn9kEK5mKJNhmjO4pu
         kdIlll52xPUNMHVj44RQm/o2B8e7dut6TGVAToyL1KBvwTqEF70iyfSazv9WBXDhPTKf
         9JiVs8i4L6Xlb7ulWtRB7b4mwpvBRWru+CYTSNbZL/OFAhtOYZ5zVxZoXZh/fUM5J0G2
         xPOA==
X-Forwarded-Encrypted: i=1; AJvYcCXEHRPy/43n1snVe0YBwaEUWO85bDo2DTO9HMdgtMYacZoHIJ3/336dC9868XcPJda+EeFX8OLqzv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVKFyl/ry7rR5nQ0OwiryhANP5EWkvGJdkQAjWjNaluEm6N7y
	YqurLKmN/+q+vxbkR7et3bm2CVuu3WHrNXbkU3npnHJjp8HDixHTK+HM+L+UCLROyP8=
X-Gm-Gg: ASbGnctdepZAB5Jd/eCaq8mVUaKQqAyHog7uVxTzUy+qUYW6UZd5hyFNtuyQj3DhsJj
	8TJO42LBcwqnvFCVn3LPNmmXm06jcjVOkVFR33d0WGWeyEbyBhrYVQLYkTKOfSCRXyCrQNI9bzZ
	5QMGrN6P7+D9PcRlfkiK62luTcLBRgMSsVofKUkIkkfCTqD+T2CR/WFR+Y9Yy1fRq72QMgpD4Yg
	w42oPTFTfIGU63kNm08Ooy1fxmt/USuAwGIspnj4CteLqWNMB7GVjVdfIexUIwdxi1KA1FO597A
	nd86+UVM0vLrshUBRuijqOaz/LRBZ31zKVR8hxL2ZI+syUSHrFJaafQiB9A1/YPWQcoR6OETgWS
	PqzDD5gIat3A2q8+0pkY9ZQ==
X-Google-Smtp-Source: AGHT+IEOw5cpXlLDmXIJhM8OBLcgF8g3GUa1YjbEQIaeSF9CfzHeg4v+PZD6a/l5I2bu7UALxAndOg==
X-Received: by 2002:a17:906:2809:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-ad89997ab7amr545955266b.37.1748515691621;
        Thu, 29 May 2025 03:48:11 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3acf4sm118421066b.150.2025.05.29.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:48:11 -0700 (PDT)
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
Subject: [PATCH v10 11/12] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Thu, 29 May 2025 12:49:28 +0200
Message-ID: <20250529104940.23053-6-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748514765.git.andrea.porta@suse.com>
References: <cover.1748514765.git.andrea.porta@suse.com>
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


