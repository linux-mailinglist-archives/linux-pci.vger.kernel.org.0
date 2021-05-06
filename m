Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A237574C
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhEFPeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235506AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD95361432;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315169;
        bh=KvLt43DnzadPpOqnRUdrwzI2CtNEyAwAsOi6GeKBWRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU2IKx3lHHR8r6UTGjfQHnZIfj7luYJDfEbfeuvSbQdMku7iYZMM/+feR26Wp2Nox
         W8Q0rAK3DLiHWr6Kf17dKe10z4NuezdTK16Cz4d2ij3I8M+B/VsL+UE31ZJ+UyyJax
         AQxL5VjaYeB9TYdmSWvSHxa6UpyBjZxSYv8HiW465hYI8dltXgWQGE2fLViAJtVC+N
         Fym7Uq+SYDhtbzhL7MGy+PUXdNoLOOZBn/4asHNb4YG3o+H/Wr8+lA3pK4Eh07ejz4
         IU5EcWTCI4XKJvwbdOZTVEEPka3J0AesHrqv9agNAG3yfdla8W0R+kr+2l/KlLd3Bb
         qGTCqi1NeK8BQ==
Received: by pali.im (Postfix)
        id 1D0971250; Thu,  6 May 2021 17:32:47 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/42] PCI: aardvark: Do not touch status bits of masked interrupts in interrupt handler
Date:   Thu,  6 May 2021 17:31:22 +0200
Message-Id: <20210506153153.30454-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is incorrect to clear status bits of masked interrupts.

The aardvark driver clears all status interrupt bits when no unmasked
status bit was set. When some unmasked bit was set then masked bits were
not cleared. Fix this so that masked bits are never cleared.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index cd4b427d7692..362faddae935 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1090,11 +1090,8 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
-	if (!isr0_status && !isr1_status) {
-		advk_writel(pcie, isr0_val, PCIE_ISR0_REG);
-		advk_writel(pcie, isr1_val, PCIE_ISR1_REG);
+	if (!isr0_status && !isr1_status)
 		return;
-	}
 
 	/* Process MSI interrupts */
 	if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
-- 
2.20.1

