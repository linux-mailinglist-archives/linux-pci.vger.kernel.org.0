Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277D61B24C2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgDULRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:17:05 -0400
Received: from mail.nic.cz ([217.31.204.67]:40748 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgDULRF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 07:17:05 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 98EEA141337;
        Tue, 21 Apr 2020 13:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467822; bh=WWdULTS/yrmI1pxEZNYpKN5Ix1wCZmr0xU/efBMkzws=;
        h=From:To:Date;
        b=P+gtIP4yAlKb6dV434lUbdneEyqVTityTaylZAxiUnA5wMFgnQ3Em6U39xDbgV3h4
         rqPE/1U8s0i4j8zcbQDDSPsBVgzsmrmDCYVoR1Af+AwkifZ6+H/gxJV0IKNqJCAjCq
         qwXu5ef/jVZ7qGyugZ37PamWbUWz93L89Gobnl7I=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 2/9] PCI: aardvark: don't write to read-only register
Date:   Tue, 21 Apr 2020 13:16:54 +0200
Message-Id: <20200421111701.17088-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Trying to change Link Status register does not have any effect as this
is a read-only register. Trying to overwrite bits for Negotiated Link
Width does not make sense.

In future proper change of link width can be done via Lane Count Select
bits in PCIe Control 0 register.

Trying to unconditionally enable ASPM L0s via ASPM Control bits in Link
Control register is wrong. There should be at least some detection if
endpoint supports L0s as isn't mandatory.

Moreover ASPM Control bits in Link Control register are controlled by
pcie/aspm.c code which sets it according to system ASPM settings,
immediately after aardvark driver probes. So setting these bits by
aardvark driver has no long running effect.

Remove code which touches ASPM L0s bits from this driver and let
kernel's ASPM implementation to set ASPM state properly.

Some users are reporting issues that this code is problematic for some
Intel wifi cards and removing it fixes them, see e.g.:
https://bugzilla.kernel.org/show_bug.cgi?id=196339

If problems with Intel wifi cards occur even after this commit, then
pcie/aspm.c code could be modified / hooked to not enable ASPM L0s state
for affected problematic cards.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b59198a102d0..551d98174613 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -356,10 +356,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_wait_for_link(pcie);
 
-	reg = PCIE_CORE_LINK_L0S_ENTRY |
-		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
-	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
-
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
 		PCIE_CORE_CMD_IO_ACCESS_EN |
-- 
2.24.1

