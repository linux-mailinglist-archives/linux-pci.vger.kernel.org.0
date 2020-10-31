Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CD2A181C
	for <lists+linux-pci@lfdr.de>; Sat, 31 Oct 2020 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgJaOVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Oct 2020 10:21:04 -0400
Received: from mxwww.masterlogin.de ([95.129.51.170]:44996 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgJaOVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Oct 2020 10:21:04 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 10:21:03 EDT
Received: from mxout3.routing.net (unknown [192.168.10.111])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 720EE2C522;
        Sat, 31 Oct 2020 14:03:58 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 7AA7D60131;
        Sat, 31 Oct 2020 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1604153030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nnqpdwBRoGTj+JO7bkuaUY6oKrUxMavYYaV/d3fKDdQ=;
        b=bVQemA238/wVSfo5rW9auRUYepbmAnKBqLrz9KJUXnluHpXQv3wtzei+B9qRorOmKRxj8B
        C3e13ePdrdgOfaDFXlI2RPzevDEsoiN3L2pG8pCQAuiBmH1uBXPnRo2rbG8u1yHCBG5/9B
        AMQAt6gYbCUhbPxmX1I9Uae1C1Z7/EE=
Received: from localhost.localdomain (fttx-pool-217.61.156.230.bambit.de [217.61.156.230])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id E134D360085;
        Sat, 31 Oct 2020 14:03:43 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] pci: mediatek: fix warning in msi.h
Date:   Sat, 31 Oct 2020 15:03:30 +0100
Message-Id: <20201031140330.83768-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

5.10 shows these warnings on bootup while enabling pcie
at least on bananapi-r2:

[    6.161730] WARNING: CPU: 2 PID: 73 at include/linux/msi.h:213 pci_msi_setup_
msi_irqs.constprop.0+0x78/0x80
....
[    6.724607] WARNING: CPU: 2 PID: 73 at include/linux/msi.h:219 free_msi_irqs+

fix this by selecting PCI_MSI_ARCH_FALLBACKS for MTK PCIe driver

Fixes: 077ee78e3928 ("PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..8345de010186 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -238,6 +238,7 @@ config PCIE_MEDIATEK
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
-- 
2.25.1

