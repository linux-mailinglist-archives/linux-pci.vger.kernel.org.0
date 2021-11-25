Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900845DA52
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352683AbhKYMvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354660AbhKYMvr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D4361100;
        Thu, 25 Nov 2021 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844406;
        bh=JV4lwZuiAfd90eHa9xfMZBjWna+Fc5JfrSlxVTopPF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDjsCBGBOIirmv0i3zdhy1tGoFuNUUJyehXqRwCdtD2TfxspOO3Y4c2rmSOIB8cjo
         f4Mn7Yb2vAv5P+80pId7DY65asQBju/93huGMHL0FYh17mrDiwp8Ut2IBQe9tz3uRg
         eylAW81f0laQeIv0XXYIXoJWUZiblQkq7EkfK6opRTFp4zoh4D2qTT2iFBJ5n7mnPx
         T/x/Cei9EL9Xy2Kq82c2eFeh4hIflIXwBzq5UctBDk5LcXQWwk/JakCW2GC3yJb8Fr
         fmGfrYnemYUIjmmKfud4OuF6CPdvCKwP+a0TbaQq5KNILHzqWwOBssAJXcKJZjay6Y
         k7khJCYL9Mqjw==
Received: by pali.im (Postfix)
        id B587367E; Thu, 25 Nov 2021 13:46:45 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] PCI: mvebu: Fix support for DEVCAP2, DEVCTL2 and LNKCTL2 registers on emulated bridge
Date:   Thu, 25 Nov 2021 13:46:05 +0100
Message-Id: <20211125124605.25915-16-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Armada XP and new hardware supports access to DEVCAP2, DEVCTL2 and LNKCTL2
configuration registers of PCIe core via PCIE_CAP_PCIEXP. So export them
via emulated software root bridge.

Pre-XP hardware does not support these registers and returns zeros.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 798cf5cff8be..9a17bab4019f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -571,6 +571,18 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		*value = mvebu_readl(port, PCIE_RC_RTSTA);
 		break;
 
+	case PCI_EXP_DEVCAP2:
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCAP2);
+		break;
+
+	case PCI_EXP_DEVCTL2:
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL2);
+		break;
+
+	case PCI_EXP_LNKCTL2:
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+		break;
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -683,6 +695,17 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		if (new & PCI_EXP_RTSTA_PME)
 			mvebu_writel(port, ~PCIE_INT_PM_PME, PCIE_INT_CAUSE_OFF);
 		break;
+
+	case PCI_EXP_DEVCTL2:
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL2);
+		break;
+
+	case PCI_EXP_LNKCTL2:
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+		break;
+
+	default:
+		break;
 	}
 }
 
-- 
2.20.1

