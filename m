Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE04375741
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhEFPdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235404AbhEFPdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5090E6140C;
        Thu,  6 May 2021 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315168;
        bh=MTTPn1JuU+d3/eQ+Q7Ef/sfL+sWMGgOEsQXP78mZRIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kslpnpwNQOUTAzurn5Gss4CnU3SYYP2rwxKtVz9ioqugqtuiH4OXS6sIpxE+JI/xf
         LMd1ClbrzJlXfcBZYlNaJT0aZlYZSHqjj2X0d2yP9u7/ZF6IL8snkqS76vrVf1fPR+
         A5+D8ByYQDrCxORx+Zh22+kxRZzHVGvUhJJv+69M/fjDBpGJk1eFGEwQribgq00DDc
         vNcuaf3WCZTK4+OskzWUWLSnQiD6tTuGrz4y0U1NgR80opzxy6/HPeATRo4SYTazDW
         NoFjAcNtH5oYDkBXP35FvAzMFcGCDDCKCwI3mloPLkd2dUeWnUBnCoqknAxPJgjKZ4
         bvuh+Ckpfi5fA==
Received: by pali.im (Postfix)
        id 57DF8129A; Thu,  6 May 2021 17:32:47 +0200 (CEST)
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
Subject: [PATCH 12/42] PCI: aardvark: Check for virq mapping when processing INTx IRQ
Date:   Thu,  6 May 2021 17:31:23 +0200
Message-Id: <20210506153153.30454-13-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is possible that we receive spurious INTx interrupt. So add needed check
before calling generic_handle_irq() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 362faddae935..e7089db11f79 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1106,7 +1106,10 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 			    PCIE_ISR1_REG);
 
 		virq = irq_find_mapping(pcie->irq_domain, i);
-		generic_handle_irq(virq);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(&pcie->pdev->dev, "unexpected INT%c IRQ\n", (char)i+'A');
 	}
 }
 
-- 
2.20.1

