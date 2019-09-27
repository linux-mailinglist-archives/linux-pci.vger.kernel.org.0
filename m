Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1174FC010C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfI0IXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 04:23:45 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55603 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfI0IXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 04:23:44 -0400
Received: from localhost (unknown [65.39.69.237])
        (Authenticated sender: repk@triplefau.lt)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1228910000E;
        Fri, 27 Sep 2019 08:23:41 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2] PCI: aardvark: Don't rely on jiffies while holding spinlock
Date:   Fri, 27 Sep 2019 10:31:42 +0200
Message-Id: <20190927083142.8571-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

advk_pcie_wait_pio() can be called while holding a spinlock (from
pci_bus_read_config_dword()), then depends on jiffies in order to
timeout while polling on PIO state registers. In the case the PIO
transaction failed, the timeout will never happen and will also cause
the cpu to stall.

This decrements a variable and wait instead of using jiffies.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Changes since v1:
  - Reduce polling delay
  - Change size_t into int for loop counter
---
 drivers/pci/controller/pci-aardvark.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fc0fe4d4de49..ee05ccb2b686 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -175,7 +175,8 @@
 	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
 	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
 
-#define PIO_TIMEOUT_MS			1
+#define PIO_RETRY_CNT			10
+#define PIO_RETRY_DELAY			2 /* 2 us*/
 
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
@@ -383,17 +384,16 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	unsigned long timeout;
+	int i;
 
-	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
-
-	while (time_before(jiffies, timeout)) {
+	for (i = 0; i < PIO_RETRY_CNT; i++) {
 		u32 start, isr;
 
 		start = advk_readl(pcie, PIO_START);
 		isr = advk_readl(pcie, PIO_ISR);
 		if (!start && isr)
 			return 0;
+		udelay(PIO_RETRY_DELAY);
 	}
 
 	dev_err(dev, "config read/write timed out\n");
-- 
2.20.1

