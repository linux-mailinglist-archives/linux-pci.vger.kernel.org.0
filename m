Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BE375743
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhEFPdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235405AbhEFPdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5713F61410;
        Thu,  6 May 2021 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315168;
        bh=MpxK0wPuDd30O+SuegHQ8xNOoI7IRN6DCqL2Bjbkn/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVnlrkf0qQBKjo9NL9mPkckQaCA36//4P2zgYDAMHIcMamihuIjFOg1guPhm5e1il
         ajyTVmIF7L6OsnFhRPAg/LYPZKkh9ZA4+8kWS4A25Fws3YkbLqtM2mxF5MBZ+cwPUt
         OnGX/U5yadN3/baS288c05N1xgb2qSDlyJ/3+jUDP0hCznirMRB6jJ7PR1n2KdgPB5
         4iJQ+oK00Ub/OqmY7pNUFmTq7+kJhQzWj3qi1apH6tHomMsJMaL/+coOkoqReevPTI
         rG6sfP9b+dBv03GcELuTxDgUngfuiORzWVreR1h4fPPz3b0IhO9esfMqxXtkY1/mRW
         o5oYpgG+4stpg==
Received: by pali.im (Postfix)
        id B2E11732; Thu,  6 May 2021 17:32:47 +0200 (CEST)
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
Subject: [PATCH 13/42] PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
Date:   Thu,  6 May 2021 17:31:24 +0200
Message-Id: <20210506153153.30454-14-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Callback for irq_mask_ack is the same as for irq_mask. As there is no
special handling for irq_ack, there is no need to define irq_mask_ack too.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e7089db11f79..2aced8c9ae9f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1032,7 +1032,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
-	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
 	pcie->irq_domain =
-- 
2.20.1

