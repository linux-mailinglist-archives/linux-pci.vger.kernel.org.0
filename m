Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8482E37574B
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhEFPd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235461AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0797B6144C;
        Thu,  6 May 2021 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315170;
        bh=oZBRW1urfkXXBJqUlknYvRg4n9R+PwWJMKIKp7WdGLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLRgo/bzKb6pxtGTiIRV7bR7HxY1pDTOde57U9sQ9EiLklW/kbKVQigCECUOkCaM8
         Z4qvB/d7r62YiXJCMQWgOgu+tiYWrFcHNaEFQsJLeYRcyL2ZgqXIO1TLvqzJZ53cXN
         1Y7urItb0D0uSMcraCw8WVLjNE2uK+lizbApLtsMML/6icHGrDvI892SKSEfrqn0Nc
         U8RZa/EchOaKiMC9W/PxLIwzexzqRfaTub66/MaImmI/ruV3CJWoATOMRFr0V9jYG9
         nbwW9S+CQFXtvJ9ZtjrGpJS4JxsVmGE8IXPT0Qq6kDnac2nyiA2l+XUcCiR4Xie9BV
         JJYwk8Yf5MSzQ==
Received: by pali.im (Postfix)
        id 2957489A; Thu,  6 May 2021 17:32:48 +0200 (CEST)
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
Subject: [PATCH 14/42] PCI: aardvark: Don't mask irq when mapping
Date:   Thu,  6 May 2021 17:31:25 +0200
Message-Id: <20210506153153.30454-15-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default, all Legacy INTx interrupts are masked, so there is no need to
mask this interrupt during irq_map callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2aced8c9ae9f..08f1157e1c5e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -940,7 +940,6 @@ static int advk_pcie_irq_map(struct irq_domain *h,
 {
 	struct advk_pcie *pcie = h->host_data;
 
-	advk_pcie_irq_mask(irq_get_irq_data(virq));
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_chip_and_handler(virq, &pcie->irq_chip,
 				 handle_level_irq);
-- 
2.20.1

