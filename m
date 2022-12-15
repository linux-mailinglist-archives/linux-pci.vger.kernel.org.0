Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE564D9A0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLOKhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 05:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLOKha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 05:37:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598632C10A;
        Thu, 15 Dec 2022 02:37:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so51173175ejb.13;
        Thu, 15 Dec 2022 02:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZnStEcJmw/vCnQPEoFz/U81Z/gFR8HaoVf+ewX8+W8=;
        b=YUWSo2BIxLaYYOUJ9vgnftsQJz7NxG2vBgVRcmkQq1HRkHG4eJ+YDBHT/WSEO1FUMC
         Ogr09dhZucid4t6Ylzmzq1x3hs8Dcouh9WVU+A4JXCSf0yR+Bya8xEljD+BzOsbcm4Oe
         uje8H2YePJ6Y/CD6G2+XHjisEQHw7YiVUNDswsifc0Dj96gOZ3fF2G9hlNXl//eiu1zP
         MiekjRe6DMZnxNn/qiIrx5lAk399FITvutcHfFYbqIpMtXethgbGj3gWCUhmC1RzkInh
         WMH2Q2MRUgPNkhc6LYMezUzmMX60M5+lxJQTgbcTAKzqRG56nJeIgesSevyRyCiQbsq/
         FYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZnStEcJmw/vCnQPEoFz/U81Z/gFR8HaoVf+ewX8+W8=;
        b=mCzn83VhuPYGH1BYrXSsd69MQQgLO+XjzvH6ZQuJt/JEXt+ogMj6E9skv/7sqcAviG
         Wn8tGqNYBQY63YF1izy1ozL7OUR1boqyR/G60Hl0X3v4coggbUQBI5AF1ZaAnyq5rZ1W
         z8+lz/EBA0zHR72oVDhQlLRTHPw9cjzyjcYFryiGqlP4yX+iC5svIOjA9wkuzMHEBeSF
         X3V+JWD7w+4U8j83LmqVnp88k2qpFBWKf3GHay5aaDEA6PAIC5HDGu8jTAi3IdZgtklf
         cWGp04rEjJP3pjQJZTXt5reI/KLGTPSblOB9iOkYb/3stNSFzHBly5sMUR+XgfYq0QHn
         q2Fg==
X-Gm-Message-State: ANoB5pkoJnOdbxvV+I9Vuu4TCbnZq0T582sGwod3nSgaQ3DZhoSc5n7S
        AyPznYIBf2TpnTPU0biyPrs=
X-Google-Smtp-Source: AA0mqf787wvPIKuw+89zRvMEFTBZH65JE0oxnu/nqS6Wj9FWG0xXqcR572hD+nRm74sI0Tx4RWCmqg==
X-Received: by 2002:a17:907:3e26:b0:7c1:9519:5cfa with SMTP id hp38-20020a1709073e2600b007c195195cfamr10547768ejc.77.1671100646765;
        Thu, 15 Dec 2022 02:37:26 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0078d76ee7543sm6889698eju.222.2022.12.15.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:37:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
Date:   Thu, 15 Dec 2022 11:34:52 +0100
Message-Id: <20221215103452.23131-1-lukas.bulwahn@gmail.com>
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

Commit ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
adds the config PCIE_BT1, which following the previous default pattern
depends on the config PCI_MSI_IRQ_DOMAIN.

As these two commits were submitted roughly at the same time, the
refactoring did not take of this occurrence and the addition did not yet
notice the refactoring.

Take care of the PCI_MSI config refactoring on this latest addition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index a0d2713f0e88..99ec91e2a5cf 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -225,7 +225,7 @@ config PCIE_ARTPEC6_EP
 config PCIE_BT1
 	tristate "Baikal-T1 PCIe controller"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
-- 
2.17.1

