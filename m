Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4D488E3E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiAJBug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59138 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiAJBuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C6360ED2
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA50C36AF5;
        Mon, 10 Jan 2022 01:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779434;
        bh=Ih0N11jBn2l6o2OI2QlXgP3YmCz6NpbiIcjRFrzHARs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFaP9vUVWZXR3ZczLtC+6MyLXkdZ7RCGMTN5aRwZzFf70UgSXQyB6IyGvM9tzb0gX
         9ZNV99122IfE8cBbIoj84RWwrfNr7uO0itLMH9xXF4bfzFoMaOs7U1GF/K9vsY+NiJ
         MIBSOyWVBo5f3Hl+G7+2qY3VqJBtVlRWa8MnPVI8TX2N5wkhY0SNUbvf8dHk1mpjYb
         wJDoS5qLaTZ4Z7pImdPBXeSLZ2SOrl/u2poOSuHoMpnqIeuIm97lHByOXsQq7aF5i0
         9Glcf7lXzEyVRM/JPA0tX8Ts5DkE3EwIbZK4apkyx9Adz+oNs7Vdo4YKDUrWbpffHw
         WhdD9Lql11tcQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 05/23] PCI: aardvark: Check return value of generic_handle_domain_irq() when processing INTx IRQ
Date:   Mon, 10 Jan 2022 02:50:00 +0100
Message-Id: <20220110015018.26359-6-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

It is possible that we receive spurious INTx interrupt. Check for the
return value of generic_handle_domain_irq() when processing INTx IRQ.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 315147f2812f..252033a46e1e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1434,7 +1434,9 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		advk_writel(pcie, PCIE_ISR1_INTX_ASSERT(i),
 			    PCIE_ISR1_REG);
 
-		generic_handle_domain_irq(pcie->irq_domain, i);
+		if (generic_handle_domain_irq(pcie->irq_domain, i) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected INT%c IRQ\n",
+					    (char)i + 'A');
 	}
 }
 
-- 
2.34.1

