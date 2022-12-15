Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6764D962
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 11:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLOKRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 05:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLOKQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 05:16:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329BE49;
        Thu, 15 Dec 2022 02:16:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz12so28462018ejc.9;
        Thu, 15 Dec 2022 02:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA/7khQ2+Kdd7B5BwckeWPlm4BuKyCyk2Db9rfcWYlY=;
        b=DWi77J9FBp2VCsKdifXN4b3eFSlR5g9vSiAeGJukzZfKOvKykp1KOr+oNlswa8mUAM
         g2RKmEvjeeyzxckVeHMI6QFcjM4n0l2YGEwUNCk4Y/dOon6KCq64YWLyfx8eyVVjQ638
         9Q/BObbVafAgLT5QG2LMMXUCjpppuqVYbuM3icSIHrw2LhFM+1hmNbodJlDe7tnASjdk
         KdO9DNS4YRUa8/Ij0NVrS9kayAVfsTmnG38PFwkw3XN+oE7ZiA5TauKV1+ieW+SGPz8/
         vqMcXAWm9PDKb18Sh65oYv8KIWKbCcbGcDyKI0MA58MRL9GNOnqZmlx784x0dd1a1mTi
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA/7khQ2+Kdd7B5BwckeWPlm4BuKyCyk2Db9rfcWYlY=;
        b=M860OOlZsRLwueV/7mDx2VOpoWzLvXeu6tsTKLttA3+KVu/pxt0JcAEmLSQYxJRbDQ
         Uk8+XFY9hhQI8pRymmFFUULKy+fN8BJhhYpclwJiQuRFieO4H3d4nl/FGTOTeQmay7d0
         9gDQzYR1sJR4dA75p+iUjBNVu1WcT01oobfUNXIM6UqbnVEy/0FhbGuNxDK4mm63GTnS
         +BX6chqszFTylRRotZiuPoyoLAdTeLySs2W6N48GJZlu3N77SRgvVXvevCL1hCC0iODk
         iOkL0SLubb9cHIFtyi2sEq/hb1MX19ctOsAgOk2cpfJsdI8Ax7t3WtyiHIAEGpi4ox9Z
         WVaQ==
X-Gm-Message-State: ANoB5pmxDKiSBlny33GE9jdWl+QlBNuxkFL852naApOJ9Ua2uPt9s+H1
        WgA+k0mxM/SfstKtXIyEYuo=
X-Google-Smtp-Source: AA0mqf4lmse1kKK/Q5APz3a/gFfizwyYisCLauByKyceMs51gqEOgmktFN+14CSKjKilnLu2Jm6EGQ==
X-Received: by 2002:a17:907:2b12:b0:7c1:1c7:3bad with SMTP id gc18-20020a1709072b1200b007c101c73badmr20273207ejc.36.1671099372882;
        Thu, 15 Dec 2022 02:16:12 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5504493ejt.96.2022.12.15.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:16:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] PCI/MSI: clean up duplicate dependency in config PCI_HYPERV_INTERFACE
Date:   Thu, 15 Dec 2022 11:13:10 +0100
Message-Id: <20221215101310.9135-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN") removes the
config PCI_MSI_IRQ_DOMAIN and makes all previous references to that config
then refer to PCI_MSI instead.

In the refactoring of config PCI_HYPERV_INTERFACE, it creates a duplicate
dependency on PCI_MSI. Remove this needless duplicate dependency.

No functional change. Just a stylistic clean-up.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 1569d9a3ada0..c2261da85f7b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -285,7 +285,7 @@ config PCIE_BRCMSTB
 
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
-- 
2.17.1

