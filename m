Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7513F402AF9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhIGOqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhIGOqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 10:46:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E429DC061575;
        Tue,  7 Sep 2021 07:45:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u19so14304676edb.3;
        Tue, 07 Sep 2021 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PTxcliCih1pU+7pP04cZVW5J5+AGU6VqCn2jplaFbQ=;
        b=YIE1T7BiydkAvtH4wwiDaXgXEcgekCAKL3AW4GIODsz+TCtDMhC7FlmMAfBIxCAtJj
         sb6UPJ/kAC+1DYL+tVklzdPZ4GEWVD+p6G3n2/HZhvc96m1nx4sIfC9TwsPF3ebb/8HP
         +LRWyyvoyRtVDJgIZQNaTbm7ZvUn9YE8sP1fR7OSd+zmXr653d2Xz673zPzPybC3/7iO
         W02NYVjvfkBZmBGtYizXdKTy5yyC++z/J5/uYw+UfRc8BToFGyoxdk1NPKKf92ox991k
         vKZCGpRGvTGKEP3NHbP7vNM6oJq6wjAb1hv4WJ7WtPfsvVavSXKS7lM++5G2Ww2h4dt3
         pAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3PTxcliCih1pU+7pP04cZVW5J5+AGU6VqCn2jplaFbQ=;
        b=MPN/qsvNX2m33yGWWtm4nzV6vBxMUGIrkIY9mC0v57vpHIkXLoZNdUEqazC+fgJ53c
         UpHCdJip5ZR1aaIr4Kbs18whn8AxhpTCDSGFRldu/iAS7yjsfp89kT1WhRHFjeG5ktI4
         jz4pm+OmLPObrvO88hoJDF3UD8YtH9omObw9fo5WTGMF+dF+r6jsTnR34kmF9PhGp65M
         Y3AOy9Ke0KBtIrgd+gPzGMRT//HuvM0zFg6yYeRekkRx9T56fjZ52ZZlEepnTalD1XXt
         djyLhAwlB9bzXE85pbBEMMPUeL5u2q0U6IcErgozk9dhJAnCi0oiehKvcFX9SCe5QI6r
         rT7A==
X-Gm-Message-State: AOAM531gYVbeKwuGG084XLXXccidwAs3X8Ogn5d5uO5EIc3ZfV6SCbpr
        At6esyKSp+u3ZGhiKrYYataeRBa0b65auw==
X-Google-Smtp-Source: ABdhPJw5Iq+kpC7c/3uV6v8ykWDuVAGExEfJYGe/lll9bD29f7xTL12PEcx5Pm/uelqJgw09HAvV8g==
X-Received: by 2002:a50:99cc:: with SMTP id n12mr19375435edb.53.1631025932411;
        Tue, 07 Sep 2021 07:45:32 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id be5sm6647591edb.57.2021.09.07.07.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:45:31 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
Date:   Tue,  7 Sep 2021 16:45:12 +0200
Message-Id: <20210907144512.5238-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Add COMMON_CLK dependency, otherwise the following build error occurs:
  arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
  pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enabled'
This should be OK, since all platforms shipping this controller also
need COMMON_CLK enabled for their clock driver.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
+CC Stephen, please double-check whether this is the right approach or
    whether there is some better option
---
 drivers/pci/controller/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 326f7d13024f..ee6f5e525d3a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
@@ -74,6 +75,7 @@ config PCIE_RCAR_HOST
 config PCIE_RCAR_EP
 	bool "Renesas R-Car PCIe endpoint controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on PCI_ENDPOINT
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in
-- 
2.33.0

