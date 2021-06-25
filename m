Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5133B3FF3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhFYJHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhFYJHc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61DC26142D;
        Fri, 25 Jun 2021 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611912;
        bh=L9Vq1i7R7xru0XqrFwmNPS8E0uTO1HEZvLpOaOBqDiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nm5DsR+HXqjcQ9IOW+H8zPWHnx/fmvVNixMByH8a+QwktgvpzX6qGTMkznIBV2q6F
         1pzTro9KhYxY9pVk2Q0JXLRwJf4wgcUyCM/wf4cgDUT05VjB64cZzKn5FBiiYhU0zv
         Uszm1XUEi9SKdeEUhRQ1QYVWI01pTto2szTsvOEstnnVRpIqr5jlDJ2u/ktH42ycoi
         XafpbucCa/WJsi/+e8Q4IwlPrfaNlI1cn0275GlCZthSP73mPfBHtjpWs5Jx8XngzM
         FFKyWVbw9eZMwLtcDQwAijTDTPccFTe1AO0QmvLBMN/+NupbIPZ6pCC1Ug1eKNtb/k
         W4gMYs+6QwA+A==
Received: by pali.im (Postfix)
        id 1FB7160E; Fri, 25 Jun 2021 11:05:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
Date:   Fri, 25 Jun 2021 11:03:15 +0200
Message-Id: <20210625090319.10220-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625090319.10220-1-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
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
Acked-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 59f91fad2481..bf44d6bfd0ca 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1152,7 +1152,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
-	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
 	pcie->irq_domain =
-- 
2.20.1

