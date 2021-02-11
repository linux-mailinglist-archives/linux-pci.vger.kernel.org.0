Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782003186D3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBKJQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:16:53 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34040 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhBKJKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:47 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 88B8540172;
        Thu, 11 Feb 2021 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034552; bh=e3LkhEF0r+Hvu+QsHepihtZhy6rasoZLBH/wwPPORDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LVzntpfsDVlvVER3vJEl0mP+vQk78IG/oSaD6889Xl4agA6bR93iVqurl8geePCzs
         wuZEHvrlFqTcStbP/8WxoGemEd6w0sFSy9zW0fnVJ1f9uRA97218jzsWoj8IVkVGLG
         vQXG8QLFb8dRc7jD4V5vcc08PWCpKSXR4pd8rngZyVctGpJoQVjGWnfl1rL160C+B4
         y61Y2oh4OYUPh9aUtLml1q5k1up2jix/IXAwa7DFTIcg85ntB1BwncQLO28cqxJ31j
         GTAeZ3z0rDcCVTbl1SkoqL8V/kwkvZuq4IayiL4gAAry6RR2pPZyYon10s9KVoQMeO
         u6pGikkjYUkQw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 50D63A005C;
        Thu, 11 Feb 2021 09:09:10 +0000 (UTC)
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
Subject: [PATCH v5 3/6] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Thu, 11 Feb 2021 10:08:40 +0100
Message-Id: <1b76d5e1a47bf3a30a863319587195037ac3e4d7.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..41684fe 100644
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
+	  generator IP also known as xData, present in Synopsys Designware
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
-- 
2.7.4

