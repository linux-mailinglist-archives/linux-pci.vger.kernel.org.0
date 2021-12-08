Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F346CDA2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhLHGWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbhLHGWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08203C061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5052CCE203B
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C4C341C8;
        Wed,  8 Dec 2021 06:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944352;
        bh=c32OMqEV/GSXb6+j7itgfdTekTmTZVZG1z9tLBocdU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+u+IrlnJLsHkpw8CtKQo8UyBCIgfdwuD2s+dVU+GgBuL63VBBp2y9xZNP1fJe0U4
         ygbZn4AnQB/Rpln/7Y+wjcAvWLNpSG6TjIoW3sl3zy4I+aTXX1SxyQOhe84x+WnVY8
         abDPNn8NvUPCI3UZNgFQO9Xigc+t4q7DREHrH7cDrj/4PxXJ3sJF3ZS7oU3YEndPcG
         jpYC+v3Hs6MqiR6zAEPoBLgi6tMWIm9xUY7YU28isWFB57giI9xDmRqh/8VVxW9ky8
         u+9uVfMA0flPBA7fxsXylbVBTr/7xPlK9MLrncnQIFrVRldMjKiVHOt+SY01hBNh6n
         dCsSzR/jHI3HQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 10/17] PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
Date:   Wed,  8 Dec 2021 07:18:44 +0100
Message-Id: <20211208061851.31867-11-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

The emulated bridge returns incorrect value for PCI_EXP_RTSTA register
during readout in advk_pci_bridge_emul_pcie_conf_read() function: the
correct bit is BIT(16), but we are setting BIT(23), because the code
does
  *value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16
where
  PCIE_MSG_PM_PME_MASK
is
  BIT(7).

The code should probably have been something like
  *value = (!!(isr0 & PCIE_MSG_PM_PME_MASK)) << 16,
but we are better of using an if() and using the proper macro for this
bit.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d5dcb3322d56..f7d553a63f06 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -883,7 +883,9 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTSTA: {
 		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
 		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
-		*value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16 | (msglog >> 16);
+		*value = msglog >> 16;
+		if (isr0 & PCIE_MSG_PM_PME_MASK)
+			*value |= PCI_EXP_RTSTA_PME;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
-- 
2.32.0

