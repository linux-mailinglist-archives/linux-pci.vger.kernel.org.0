Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B793A0531
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhFHUk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 16:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234000AbhFHUk0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 16:40:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41BA06127A;
        Tue,  8 Jun 2021 20:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623184713;
        bh=7QkX7aGJfBWOcOv4hu/tTv+UzURk46Al8Om+qNr0hhE=;
        h=From:To:Cc:Subject:Date:From;
        b=pCDFpGqEtkJeweZI7A9UqadRSZspUIBjpRXjC635xW11WGJb6ad60h+pVRQjWcB6+
         3xckjs9vx4NAt9ihESEf2MUsZQz+wNk8C6e2OICMxSy2Af2XKzdnMIDKtemecSRV99
         KQX9+NatBQmlkLouHlpbyiGnwANmf90y9gO+s1tY8dPN5oej77/mSLslvCaYrR9T39
         Xkuyta/YjMjSWJx0JjHqoTLn3kEZiWANY2KbH+u3SsKxl8pmds6nxAemYrqp/X3EIA
         ySGDvQBRS1XTSV+6PfFv90537CcVOwvw5j9XMsTDv9BAkcXmk1luDNrx9kWItai0Ve
         GD5GN8I7CDLhg==
Received: by pali.im (Postfix)
        id CEF917CC; Tue,  8 Jun 2021 22:38:30 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: aardvark: Fix kernel panic during PIO transfer
Date:   Tue,  8 Jun 2021 22:36:55 +0200
Message-Id: <20210608203655.31228-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Trying to start a new PIO transfer by writing value 0 in PIO_START register
when previous transfer has not yet completed (which is indicated by value 1
in PIO_START) causes an External Abort on CPU, which results in kernel
panic:

    SError Interrupt on CPU0, code 0xbf000002 -- SError
    Kernel panic - not syncing: Asynchronous SError Interrupt

To prevent kernel panic, it is required to reject a new PIO transfer when
previous one has not finished yet.

If previous PIO transfer is not finished yet, the kernel may issue a new
PIO request only if the previous PIO transfer timed out.

In the past the root cause of this issue was incorrectly identified (as it
often happens during link retraining or after link down event) and special
hack was implemented in Trusted Firmware to catch all SError events in EL3,
to ignore errors with code 0xbf000002 and not forwarding any other errors
to kernel and instead throw panic from EL3 Trusted Firmware handler.

Links to discussion and patches about this issue:
https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3c7dcdac5c50
https://lore.kernel.org/linux-pci/20190316161243.29517-1-repk@triplefau.lt/
https://lore.kernel.org/linux-pci/971be151d24312cc533989a64bd454b4@www.loen.fr/
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/1541

But the real cause was the fact that during link retraning or after link
down event the PIO transfer may take longer time, up to the 1.44s until it
times out. This increased probability that a new PIO transfer would be
issued by kernel while previous one has not finished yet.

After applying this change into the kernel, it is possible to revert the
mentioned TF-A hack and SError events do not have to be caught in TF-A EL3.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # 7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")
---
I have sent this patch for review month ago [1] as part of "PCI: aardvark:
Various driver fixes" series [2] and asked for reviewing it and merging it
into 5.13 kernel as it fixed kernel panic. I have not received any
reaction for this patch, so I'm resending it alone again. Could you
please review it?

[1] - https://lore.kernel.org/linux-pci/20210506153153.30454-2-pali@kernel.org/
[2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/
---
 drivers/pci/controller/pci-aardvark.c | 49 ++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 051b48bd7985..e3f5e7ab7606 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -514,7 +514,7 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 		udelay(PIO_RETRY_DELAY);
 	}
 
-	dev_err(dev, "config read/write timed out\n");
+	dev_err(dev, "PIO read/write transfer time out\n");
 	return -ETIMEDOUT;
 }
 
@@ -657,6 +657,35 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 	return true;
 }
 
+static bool advk_pcie_pio_is_running(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+
+	/*
+	 * Trying to start a new PIO transfer when previous has not completed
+	 * cause External Abort on CPU which results in kernel panic:
+	 *
+	 *     SError Interrupt on CPU0, code 0xbf000002 -- SError
+	 *     Kernel panic - not syncing: Asynchronous SError Interrupt
+	 *
+	 * Functions advk_pcie_rd_conf() and advk_pcie_wr_conf() are protected
+	 * by raw_spin_lock_irqsave() at pci_lock_config() level to prevent
+	 * concurrent calls at the same time. But because PIO transfer may take
+	 * about 1.5s when link is down or card is disconnected, it means that
+	 * advk_pcie_wait_pio() does not always have to wait for completion.
+	 *
+	 * Some versions of ARM Trusted Firmware handles this External Abort at
+	 * EL3 level and mask it to prevent kernel panic. Relevant TF-A commit:
+	 * https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3c7dcdac5c50
+	 */
+	if (advk_readl(pcie, PIO_START)) {
+		dev_err(dev, "Previous PIO read/write transfer is still running\n");
+		return true;
+	}
+
+	return false;
+}
+
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
@@ -673,9 +702,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
 						 size, val);
 
-	/* Start PIO */
-	advk_writel(pcie, 0, PIO_START);
-	advk_writel(pcie, 1, PIO_ISR);
+	if (advk_pcie_pio_is_running(pcie)) {
+		*val = 0xffffffff;
+		return PCIBIOS_SET_FAILED;
+	}
 
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
@@ -694,7 +724,8 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
 
-	/* Start the transfer */
+	/* Clear PIO DONE ISR and start the transfer */
+	advk_writel(pcie, 1, PIO_ISR);
 	advk_writel(pcie, 1, PIO_START);
 
 	ret = advk_pcie_wait_pio(pcie);
@@ -734,9 +765,8 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (where % size)
 		return PCIBIOS_SET_FAILED;
 
-	/* Start PIO */
-	advk_writel(pcie, 0, PIO_START);
-	advk_writel(pcie, 1, PIO_ISR);
+	if (advk_pcie_pio_is_running(pcie))
+		return PCIBIOS_SET_FAILED;
 
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
@@ -763,7 +793,8 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the data strobe */
 	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
 
-	/* Start the transfer */
+	/* Clear PIO DONE ISR and start the transfer */
+	advk_writel(pcie, 1, PIO_ISR);
 	advk_writel(pcie, 1, PIO_START);
 
 	ret = advk_pcie_wait_pio(pcie);
-- 
2.20.1

