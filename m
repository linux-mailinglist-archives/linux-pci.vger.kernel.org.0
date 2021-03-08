Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E472331210
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 16:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCHPZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 10:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCHPZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 10:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CC8365266;
        Mon,  8 Mar 2021 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615217105;
        bh=9UP28SBg+yJVhjwpCAUxQepgdABblFJ40H4Y6XxbpqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nE4N2hfKbocgNLXt+Hv8JMazX4mu1DcJlNr9yfqQk0IWWdxbvRgWvEnMtIB11ASzS
         RyLuYG9Lmd2Qy08SYhUh37iNIKs0r1htj9AMkeX8gGOwf7xx0T5HGRDLpYOuDePryX
         kGlZEDRmOxtdc2zkj5uveJ/OsIns2J9lQGT4Q0uL7DEsH8njlGXTqQ3lQIW55zsiBl
         9LAbcXVfxnieOlHBrZs+fHCDQ+4ldyMJXVmiYvMBJzaj4UKofkfmKT3wN6QsKdlqAY
         xRoG52ltSLpGKmipFIg/aKKr/Ewv8V+EBeA9TI21Myou6vqyTJyi2DcQ0Rqe8jdV4v
         D4jWeTP5VtA0A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: controller: al: select CONFIG_PCI_ECAM
Date:   Mon,  8 Mar 2021 16:24:46 +0100
Message-Id: <20210308152501.2135937-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing this driver without ECAM support results in a link
failure:

ld.lld: error: undefined symbol: pci_ecam_map_bus
>>> referenced by pcie-al.c
>>>               pci/controller/dwc/pcie-al.o:(al_pcie_map_bus) in archive drivers/built-in.a

Select CONFIG_ECAM like the other drivers do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 5a3032d9b844..d981a0eba99f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -311,6 +311,7 @@ config PCIE_AL
 	depends on OF && (ARM64 || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select PCI_ECAM
 	help
 	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
 	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
-- 
2.29.2

