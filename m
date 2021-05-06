Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D948D375765
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhEFPfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhEFPdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97FDC61625;
        Thu,  6 May 2021 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315174;
        bh=0YkTEBWISevDvHgokN8XUsGMwtVKvfnG9KGkSIjT5Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMXkbHyayU7EJ06iuIZVStBfcPs+TIdvxPzRYPg8sKF16YEUQphEicjVbabUnZ6we
         zAsro4QRH2vBWa45bDxXDGF8qn3RmOoKKofVmkL1CO1n1i9FIUeMaGEVca5rVP1V1V
         R124NrK+EXSGLJDgSlFbliWaAJzrvsyuKjgHA+F8yYMmOVtkeAn+DnKZy5NUnjyKJZ
         DT4AMkYg7Pun4Jz5Bln0vhpx1XjEOIhQqV75+fGsZUITSupwc8uY++tv8j1gJBlM5X
         8RA2AW+hhHx8xJ+BtgdO18m9vakQXjItJtF6f2Rd9RI9Zpqpo2SB3w/26Bt7AH+cqe
         aRxXLoC6NVivw==
Received: by pali.im (Postfix)
        id 535E389A; Thu,  6 May 2021 17:32:54 +0200 (CEST)
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
Subject: [PATCH 34/42] PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
Date:   Thu,  6 May 2021 17:31:45 +0200
Message-Id: <20210506153153.30454-35-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI aardvark hardware supports access to DEVCAP2, DEVCTL2, LNKCAP2 and
LNKCTL2 configuration registers of PCIe core via PCIE_CORE_PCIEXP_CAP.
Export them via emulated software root bridge.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
---
 drivers/pci/controller/pci-aardvark.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e724d05a61a8..13bbc0b5134d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -610,8 +610,13 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_LNKCAP:
+	case PCI_EXP_DEVCAP2:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCAP2:
+	case PCI_EXP_LNKCTL2:
 		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
 		return PCI_BRIDGE_EMUL_HANDLED;
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -631,16 +636,18 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	 */
 
 	switch (reg) {
-	case PCI_EXP_DEVCTL:
-		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
-		break;
-
 	case PCI_EXP_LNKCTL:
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
 		if (new & PCI_EXP_LNKCTL_RL)
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_DEVCTL2:
+	case PCI_EXP_LNKCTL2:
+		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		break;
+
 	default:
 		break;
 	}
-- 
2.20.1

