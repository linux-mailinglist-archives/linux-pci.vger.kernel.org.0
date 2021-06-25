Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC33B3FF2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFYJHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhFYJHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B7D461431;
        Fri, 25 Jun 2021 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611911;
        bh=Pbrm1uRTSvRmcoLNtqhDtj7irFXEs2zlkumxeogs/Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntVClOhHsHumuEoNFfmTKiKy31pCihbGzn7VBndYbYRAT4+DARIUGMoceuU7bllzY
         1MgEH6fleICmwDueWtbAuaS9nC5WSAF5iblBMe6qdDn+cxa0oeihI1yOD70Vz0AQ51
         YIPsTWccI/2leiIt/aNMrGlNTC5Rl+yBppzl9QkFDvZXP+JNzQbHsFJkmAzYDEcJyi
         U6yvYttaGJqKmmjM+R3MCgNehJaJ+OjnaQmBpA9JQTnw/WYUaxHj9PCBaV6XUnlt6u
         5PyWKRMuUEwjNs594L6u+cJeBnFwndyusSjqZIFjFeLR+YpknsRkzWJnhRkmcDpTTx
         xNTSGOl38gNzA==
Received: by pali.im (Postfix)
        id 8AA28A7D; Fri, 25 Jun 2021 11:05:09 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] PCI: aardvark: Do not touch status bits of masked interrupts in interrupt handler
Date:   Fri, 25 Jun 2021 11:03:13 +0200
Message-Id: <20210625090319.10220-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625090319.10220-1-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
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
index d4215da17a59..36fcc077ec72 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1210,11 +1210,8 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
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

