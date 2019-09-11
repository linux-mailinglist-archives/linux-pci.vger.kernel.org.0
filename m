Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9EB0576
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfIKWS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 18:18:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37231 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfIKWS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 18:18:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so11836137pfo.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2019 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wJpUcmtI6YKhyLGtOcvDAWFwk949XlDAmv2MKsxWP1U=;
        b=DMkvTmwVBoZy7jqUIkAihodC8R4kqONrk3HGJetqqwTAcCDCcYKzpuoElpoaj8L4q3
         kKAmLx32GZAY0DgrK7yzscFGAZzHV24sY6eDNwE0lp4RqIGvHit4bu1Vuqcm2NlyyYRU
         L3qjQuPWAX9cZEUzgkadODxqhF3eBa2y0DhN1H4UCagnFBKVrEgpQjE9I1NtUyfZ02fZ
         z1RWSyAFtOaxIDNIeSoIaPHqKn0dXGifT5otHgWpv1Gdudbav2hq4d8vK8e6HO+QxMlR
         BI1FLqp0jLwQ5iKEuprVYqwH/Wvo4kSjvvG/gaOi/KA8BPaM8SDl2B0A+FXXzETgvYz3
         KgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wJpUcmtI6YKhyLGtOcvDAWFwk949XlDAmv2MKsxWP1U=;
        b=PAJqjUZdEZ3zCrGY/WieCE30Aea8XMfRBu+uCl9WYIfbTyZOxO00eLQEsAb9qKL8XA
         /8rhgBVcXNBGuzhVe73TiH4EurvWoK2+pVD3bF0s+cm+ebvSksJR6gbsDeLHlmM7/7GK
         4fg+p1ympSVzJwsupoMKfLc/uRoGuRfhnt/gAtqs3GWCfBV7d54PF2HNX13D6b486nEh
         FiiTCqBFWWfOmXJ73nxcDt8UAsAjK9dTObGYwBR7v++M4BjIn2bpyTDxlgyGSMrVpJdg
         DKtvrY464qBnNIsrB5CumNmtn8xvcYo6XcpEhJS7FySq4PdIsowNaU7JPkhOxyeRwu6U
         mX4g==
X-Gm-Message-State: APjAAAU3JQnuawRtwznxQOGIWOcR6HY8hNHMU2FzmP8sZW0wGFnsVo6m
        bhGKvfLi3UTWNGTUn0Ai8MbCjQ==
X-Google-Smtp-Source: APXvYqzP0/gBNZzG2CFRFIE/UkaEI5NjGZqMp4m4/H9NRm7GUMMLKzapx1Z7TocuBDHfZe6TC2ck1g==
X-Received: by 2002:a63:2807:: with SMTP id o7mr35679328pgo.131.1568240337895;
        Wed, 11 Sep 2019 15:18:57 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id r13sm2806843pgp.63.2019.09.11.15.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:18:57 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/4] arm64: Kconfig: Fix XGENE driver dependencies
Date:   Thu, 12 Sep 2019 03:48:45 +0530
Message-Id: <f6cefef2bf6b34ec6eb82d3614054734fa5e8dd1.1568239378.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Push various XGENE drivers behind ARCH_XGENE dependency so that it
doesn't get enabled by default on other platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/Kconfig.platforms   | 3 +++
 drivers/clk/Kconfig            | 2 +-
 drivers/gpio/Kconfig           | 1 +
 drivers/pci/controller/Kconfig | 1 +
 drivers/phy/Kconfig            | 1 +
 drivers/power/reset/Kconfig    | 2 +-
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c775de1b..cdf4e452e34c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -281,6 +281,9 @@ config ARCH_VULCAN
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select COMMON_CLK_XGENE
+	select PCI_XGENE
+	select GPIO_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd0321..9b2790d3f18a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -225,7 +225,7 @@ config CLK_QORIQ
 
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
-	default ARCH_XGENE
+	depends on ARCH_XGENE
 	depends on ARM64 || COMPILE_TEST
 	---help---
 	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bb13c266c329..072c749c5c1f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -580,6 +580,7 @@ config GPIO_VX855
 
 config GPIO_XGENE
 	bool "APM X-Gene GPIO controller support"
+	depends on ARCH_XGENE
 	depends on ARM64 && OF_GPIO
 	help
 	  This driver is to support the GPIO block within the APM X-Gene SoC
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f13ce11..44699f45784f 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -112,6 +112,7 @@ config PCIE_XILINX
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_XGENE
 	depends on OF || (ACPI && PCI_QUIRKS)
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 0263db2ac874..7c5eefecdabd 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -44,6 +44,7 @@ config PHY_PISTACHIO_USB
 
 config PHY_XGENE
 	tristate "APM X-Gene 15Gbps PHY support"
+	depends on ARCH_XGENE
 	depends on HAS_IOMEM && OF && (ARM64 || COMPILE_TEST)
 	select GENERIC_PHY
 	help
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a564237278ff..651b763f80cd 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -181,7 +181,7 @@ config POWER_RESET_VEXPRESS
 
 config POWER_RESET_XGENE
 	bool "APM SoC X-Gene reset driver"
-	depends on ARM64
+	depends on ARCH_XGENE && ARM64
 	help
 	  Reboot support for the APM SoC X-Gene Eval boards.
 
-- 
2.17.1

