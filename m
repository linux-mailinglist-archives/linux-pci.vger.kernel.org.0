Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B737575E
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhEFPf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhEFPdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BADBA61623;
        Thu,  6 May 2021 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315172;
        bh=cukb1RYa3CPOxDWIDu0hDutwDBoEWduM1fL88dBLs4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb7tDkFKtE7FRK/k2f18pwsTzXMm4bFr0ttYvQCxLMbM0iCF2+0X0LTMMu/W+35Bv
         1bGFBql7WyK/hns70U+rXulXmJfFeSf1IIt2cGtGPsm35j+wwc5XMgnAK/S+8CH9S4
         ztvPfN/aLjjZe2/eOgQ9kYRU1lZWRMEe4wOIqLt6Z7+mQxQD/FiqW8ZZmUBR9nU6ar
         WNy338Xp7JpoE7JWFLqF7Bn88bz06Wdd4FzWlbcf/m52H61F1ptY2m0kUqRm9zOtRL
         1Gy71CSqQ6o0VX8jo5pWsoDgCuNUnbw9LTkYbsqfSXH86MnjtAxxaRE6qaerkiWrJS
         WPXN5vwBOKroA==
Received: by pali.im (Postfix)
        id 7499B732; Thu,  6 May 2021 17:32:52 +0200 (CEST)
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
Subject: [PATCH 28/42] PCI: aardvark: Free config space for emulated root bridge when unbinding driver to fix memory leak
Date:   Thu,  6 May 2021 17:31:39 +0200
Message-Id: <20210506153153.30454-29-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do it after disabling and masking all interrupts, since aardvark interrupt
handler accesses config space of emulated root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 28ddffce1bec..4b531675db81 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1491,6 +1491,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
+	/* Free config space for emulated root bridge */
+	pci_bridge_emul_cleanup(&pcie->bridge);
+
 	return 0;
 }
 
-- 
2.20.1

