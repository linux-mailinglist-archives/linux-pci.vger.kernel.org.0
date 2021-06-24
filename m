Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5114F3B392D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhFXW3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232848AbhFXW3a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A635E613AB;
        Thu, 24 Jun 2021 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624573630;
        bh=Abh9XGgE1ipE6laKxqtRrQbaboUN5YYNzU9KrJVJ4A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPb9HZhfiRsegh08jXRFFjTY7QMb5lQk8SmScz+r8HO8aR6VTOvDijtiU8YVjDz5W
         M3y9WSYIgv/cQwe0uHVmo1AscxNAkMQGHuvjEwGLGJ2ecIp44c9ORpcW18awGuwQsP
         Dvd7hLFlkAJP3eqdfye+s6goRTsa7W0JoqhcdzA7AEfbuPOGLTp6p1ONZdzsR1BTCG
         1HDKO0H1nE/WdFzZLSduvzdnk4o0IiXArDZ4SgMnMjhJK7yAF9n8eybAmhYO2toQCW
         z4uUi6cQAPAdBsCmsZ1rq+LYECN0wYxhtG1x+rYrhR3yg2oEehXxYUF2h5jcvnEPJM
         fqOopr45O+Xqg==
Received: by pali.im (Postfix)
        id 64C9C8A3; Fri, 25 Jun 2021 00:27:10 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 4/5] PCI: aardvark: Implement workaround for the readback value of VEND_ID
Date:   Fri, 25 Jun 2021 00:26:20 +0200
Message-Id: <20210624222621.4776-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624222621.4776-1-pali@kernel.org>
References: <20210624222621.4776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
document describes in erratum 4.1 PCIe value of vendor ID (Ref #: 243):

    The readback value of VEND_ID (RD0070000h [15:0]) is 1B4Bh, while it
    should read 11ABh.

    The firmware can write the correct value, 11ABh, through VEND_ID
    (RD0076044h [15:0]).

Implement this workaround in aardvark driver for both PCI vendor id and PCI
subsystem vendor id.

This change affects and fixes PCI vendor id of emulated PCIe root bridge.
After this change emulated PCIe root bridge has correct vendor id.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 397431d641f6..9ff68abd8d1e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -166,6 +166,7 @@
 #define     LTSSM_MASK				0x3f
 #define     LTSSM_L0				0x10
 #define     RC_BAR_CONFIG			0x300
+#define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -417,6 +418,16 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg |= (IS_RC_MSK << IS_RC_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
+	/*
+	 * Replace incorrect PCI vendor id value 0x1b4b by correct value 0x11ab.
+	 * VENDOR_ID_REG contains vendor id in low 16 bits and subsystem vendor
+	 * id in high 16 bits. Updating this register changes readback value of
+	 * read-only vendor id bits in PCIE_CORE_DEV_ID_REG register. Workaround
+	 * for erratum 4.1: "The value of device and vendor ID is incorrect".
+	 */
+	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
+	advk_writel(pcie, reg, VENDOR_ID_REG);
+
 	/* Set Advanced Error Capabilities and Control PF0 register */
 	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
-- 
2.20.1

