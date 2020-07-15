Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C08220F27
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGOO0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:09 -0400
Received: from mail.nic.cz ([217.31.204.67]:34950 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgGOO0D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:26:03 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 50B2E140A51;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=keURn+22u253qVA/hwtaY7TRtboxhUkiOumfUMd4baA=;
        h=From:To:Date;
        b=HYUl/mJ3o5KBM3YacMPRiu5S1O2iHhqHTQUlts0pF/3ISXfoBh4yNBfbNWAqv5mil
         7aUNiIt9vl7BrHwktWtDXh08y5xnpA2QsGdp54xV4aeDd9OLXcdH6VZeILhzqG3rda
         tFKWDTlUBZc2kOiWT5L9uckmWxSoawEcIuyTV0XI=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 2/5] PCI: aardvark: Check for errors from pci_bridge_emul_init() call
Date:   Wed, 15 Jul 2020 16:25:54 +0200
Message-Id: <20200715142557.17115-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715142557.17115-1-marek.behun@nic.cz>
References: <20200715142557.17115-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Function pci_bridge_emul_init() may fail so correctly check for errors.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/pci-aardvark.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8caa80b19cf8..d5f58684d962 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -608,7 +608,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
  * Initialize the configuration space of the PCI-to-PCI bridge
  * associated with the given PCIe interface.
  */
-static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
+static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
 
@@ -634,8 +634,7 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge, 0);
-
+	return pci_bridge_emul_init(bridge, 0);
 }
 
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
@@ -1169,7 +1168,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	advk_pcie_setup_hw(pcie);
 
-	advk_sw_pci_bridge_init(pcie);
+	ret = advk_sw_pci_bridge_init(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to register emulated root PCI bridge\n");
+		return ret;
+	}
 
 	ret = advk_pcie_init_irq_domain(pcie);
 	if (ret) {
-- 
2.26.2

