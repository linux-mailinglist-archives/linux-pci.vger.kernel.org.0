Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFA375764
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhEFPfh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235564AbhEFPdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCD8161926;
        Thu,  6 May 2021 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315175;
        bh=75Ia8fDMMjN9738pBwL6dSeC+rSyhLtGbCVaSNAnl5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7oZZZvz8KrPf3MxbDZcnpDiHlR3yQJiWXA7OBbCD8ij4wLxeJYntqob3tH3S8LIX
         h/e6DaMEKIb3ov5GmP2FT6mrXCQXDvjzLZf6p61LeAqhBuVC0FtVbNJfeZIRe9uXPD
         vyqgR6Mulfk4+fWddU0mnzDk1KYYyaZ56PwP+j8X7en+sg7GSCa5hLSbjWBJrzf8CL
         9wbVeKuWz0+iP4FzOyMT7mdGOHf5EziHK9zAgvexO9wIerOp22dg33hISIBo8vZWs5
         2bB7OniF2FMB8UVSUMf21LstrYByFi/HDk0uMEno+B7PLJDQz7mcW4wNd/n6SH505g
         l54NAeaBeX+HA==
Received: by pali.im (Postfix)
        id 95D418A1; Thu,  6 May 2021 17:32:54 +0200 (CEST)
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
Subject: [PATCH 35/42] PCI: aardvark: Add support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
Date:   Thu,  6 May 2021 17:31:46 +0200
Message-Id: <20210506153153.30454-36-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI aardvark hardware supports PCIe Hot Reset via PCIE_CORE_CTRL1_REG
register. Use it for implementing PCI_BRIDGE_CTL_BUS_RESET bit of
PCI_BRIDGE_CONTROL register on emulated bridge.

With this change the function pci_reset_secondary_bus() starts working and
can reset connected PCIe card. Also custom userspace script [1] which uses
setpci can trigger PCIe Hot Reset and reset the card manually.

[1] - https://alexforencich.com/wiki/en/pcie/hot-reset-linux

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
---
 drivers/pci/controller/pci-aardvark.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 13bbc0b5134d..d8fb43604154 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -558,6 +558,22 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 		return PCI_BRIDGE_EMUL_HANDLED;
 
+	case PCI_INTERRUPT_LINE: {
+		/*
+		 * From the whole 32bit register we support propagating to HW
+		 * only one bit: PCI_BRIDGE_CTL_BUS_RESET. Other bits are
+		 * retrieved only from emulated config space buffer.
+		 */
+		__le32 *cfgspace = (__le32 *)&bridge->conf;
+		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
+		if (advk_readl(pcie, PCIE_CORE_CTRL1_REG) & HOT_RESET_GEN)
+			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
+		else
+			val &= ~(PCI_BRIDGE_CTL_BUS_RESET << 16);
+		*value = val;
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -574,6 +590,17 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
 		break;
 
+	case PCI_INTERRUPT_LINE:
+		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
+			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
+			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
+				val |= HOT_RESET_GEN;
+			else
+				val &= ~HOT_RESET_GEN;
+			advk_writel(pcie, val, PCIE_CORE_CTRL1_REG);
+		}
+		break;
+
 	default:
 		break;
 	}
-- 
2.20.1

