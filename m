Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE54042C38B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhJMOlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235971AbhJMOlW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 10:41:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86B54610FB;
        Wed, 13 Oct 2021 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634135959;
        bh=9WB5lF54mgm3wn8vIZ5HCjqWjYU/IqSZYcUKAxAyLcI=;
        h=From:To:Cc:Subject:Date:From;
        b=vDTPhA7stpqi/xYjk7VcyRPb6eCn0RHgaQUX1vdeUxKJ822zzPar4YwDIPE7leHG5
         o1BGiGm9c1AbT64AdLwTv/gai8RixbjHFjkEEqImWpV2k1kJpOG8eOb5+S1Kn5hGZJ
         gSMGw5VOMcKO4fWCMoQ05donAnQ01Nw+ns9aw9lEXcRrf1SZxlAe/HzoU+Q6pJEdtb
         iw/yxtKADU5f4OieYFefuDheyofTCSHlEIrFkXtggvbwFfonwnGa/Fvznf/O48R77h
         oPQmj66nuUs66jvYZapRJMdkfEyEgkaRZJZvHfXmz+SBnxq4GxAxaRHjiPrvJ0yUpd
         OwdaomnxgCrYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: apple: select CONFIG_PCI_HOST_COMMON
Date:   Wed, 13 Oct 2021 16:38:50 +0200
Message-Id: <20211013143914.2133428-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

If this symbol is not already selected by another driver, pci-apple.o
fails to link:

aarch64-linux-ld: drivers/pci/controller/pcie-apple.o: in function `apple_pcie_probe':
pcie-apple.c:(.text+0xd28): undefined reference to `pci_host_common_probe'

Add another 'select' statement here, the same that is used for the
other drivers.

Fixes: a8bbe0366a3e ("PCI: apple: Add initial hardware bring-up")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index cc1fcc89c58f..5af99701e1f6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -322,6 +322,7 @@ config PCIE_APPLE
 	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
 	  system-on-chips, like the Apple M1. This is required for the USB
-- 
2.29.2

