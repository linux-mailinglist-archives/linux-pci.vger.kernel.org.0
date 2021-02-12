Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9844231A398
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBLR3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 12:29:22 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42732 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhBLR3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 12:29:17 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD095C0446;
        Fri, 12 Feb 2021 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613150897; bh=863tP0aolNfteoszWABDENJIX1G0vnTYrYhI2nTehPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OBcbOPzVvwilhlsJj44auPvX7EilxnAzQaHp84GXzkJfphrP98K6LvySnSRcnqWue
         X5a3eH9Rp2L9OKkMQ6LjpkXWkOCQhjah4pAZM/B2iu1Mdd44RdssWeT6uap/vMY4n+
         sUKPzhh6n1muZm9/+JWZ6OxPNcQ2vIegP6nnOuIwR9Rt4v0cpn6gyCnfA182+YNdGT
         0RJx0Cg8hrwZ7K1U4BSVHZCy4VFo7dv0RZoK1SiMqTbgLiyYoP050ALRLM55nUxH4H
         2odsCi2W+bdfXO8RkpuXv6WCmX+s5hBzeTjxIkKSKq4kNo/dyZZXQ8yqtWR4xkheLi
         vGEfgyfQ3K+Fg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DD41AA021D;
        Fri, 12 Feb 2021 17:28:13 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 2/5] misc: Add Synopsys DesignWare xData IP driver to Makefile and Kconfig
Date:   Fri, 12 Feb 2021 18:28:04 +0100
Message-Id: <2683d06074193f2f56bdb519ceed20cb54c00056.1613150798.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Makefile and Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig  | 10 ++++++++++
 drivers/misc/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..e42b171 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,16 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	help
+	  This driver allows controlling Synopsys DesignWare PCIe traffic
+	  generator IP also known as xData, present in Synopsys DesignWare
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..bf22021 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-- 
2.7.4

