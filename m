Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B18375749
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhEFPdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235481AbhEFPds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88BD66141E;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315169;
        bh=1Bwgi38dM/1NWEIAUJl5SKScRp/ehwbz7KhEc+qYX7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ei9TKzb/i6/uMehaFPV4MKb3I9fcfI+XdKOhmrmDjnOnNWFoh/BuD9ptcwMLDbtNU
         bYNDyfeqAN1UBuzqRoKRpWIl56t/SMCSpCHVUEGSS+VbWQqnY/HRwTS50SoUl4yt0R
         +DsmqLJKpAnoEHdviNqIbqC63IIownNfTvU+xkjBbozXMqwXVpAt8LGE0SHaW5Fsm2
         4rtonbnHT7txSHMFc5k3pfYc8ud70LLniC1RZKky/ssw1BqJCvJYSXsUoIbqcuBVMn
         GmqWQcM/u7AsjErRp+9NpZtwVnm+TQzN0aug3LXYIgZOH3Vehdza5QeTQuU6dWJgcH
         6+g9E9q4j33eA==
Received: by pali.im (Postfix)
        id C8C921211; Thu,  6 May 2021 17:32:46 +0200 (CEST)
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
Subject: [PATCH 10/42] PCI: aardvark: Implement workaround for the readback value of VEND_ID
Date:   Thu,  6 May 2021 17:31:21 +0200
Message-Id: <20210506153153.30454-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
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
index 873efd79fffb..cd4b427d7692 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -126,6 +126,7 @@
 #define     LTSSM_MASK				0x3f
 #define     LTSSM_L0				0x10
 #define     RC_BAR_CONFIG			0x300
+#define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -340,6 +341,16 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
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

