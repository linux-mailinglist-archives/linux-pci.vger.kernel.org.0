Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1845DA6E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354766AbhKYMxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354830AbhKYMvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D66DD6113B;
        Thu, 25 Nov 2021 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844407;
        bh=dOK1Q8ui3OxrTW5NWDaV2x8xsH/B8xAQ7TbI/Tpnk80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3i3gDaQtNeKWacYBowXh4lVNmS64IGWu9G4Rh9Pz4hA+4kXn33jvUSiTCCKFwqQH
         22LZyY4TnoWWip71S+eoO/ECbe3KbafplU4KfAKnG5UccGtuDvILMrOhuxJ2DBmOHb
         x2hilyEes2645QKw9m33NCSPkU5iSWHN2uynXPrfwfp3NIEulU/u2EEg+ZwscawoP8
         21HRl+z6o1Re7aCYDciGDg/R848A4WrW3vsuG8dGiKx3On0EFDppE5tMz8F8+8ds3b
         5j+2OWqrvHFav4ZYPqOCb9JVdhKwQvUkOM/9wxzBBG67mOBGG57UmDY5lxy+kKGOCk
         n0u4OtdaMX4Lg==
Received: by pali.im (Postfix)
        id B4222EDE; Thu, 25 Nov 2021 13:46:44 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] PCI: mvebu: Fix support for PCI_EXP_RTSTA on emulated bridge
Date:   Thu, 25 Nov 2021 13:46:04 +0100
Message-Id: <20211125124605.25915-15-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PME Status bit in Root Status Register (PCIE_RC_RTSTA_OFF) is read-only and
can be cleared only by writing 0b to the Interrupt Cause RW0C register
(PCIE_INT_CAUSE_OFF).

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c9b736344b56..798cf5cff8be 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -52,6 +52,8 @@
 	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where) | \
 	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
+#define PCIE_INT_CAUSE_OFF	0x1900
+#define  PCIE_INT_PM_PME		BIT(28)
 #define PCIE_MASK_OFF		0x1910
 #define  PCIE_MASK_ENABLE_INTS          0x0f000000
 #define PCIE_CTRL_OFF		0x1a00
@@ -672,7 +674,14 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_EXP_RTSTA:
-		mvebu_writel(port, new, PCIE_RC_RTSTA);
+		/*
+		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
+		 * is read-only and can be cleared only by writing 0b to the
+		 * Interrupt Cause RW0C register (PCIE_INT_CAUSE_OFF). So
+		 * clear PME via Interrupt Cause.
+		 */
+		if (new & PCI_EXP_RTSTA_PME)
+			mvebu_writel(port, ~PCIE_INT_PM_PME, PCIE_INT_CAUSE_OFF);
 		break;
 	}
 }
-- 
2.20.1

