Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8223BA07
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgHDL61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 07:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbgHDL6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F0A208C7;
        Tue,  4 Aug 2020 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542285;
        bh=3Ay+2125qwHB+t2rwbFmAyc8NW1poK8+S4xRWxjcoWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAs5oblzSzM03UMwQYrcfbdBmRTlj//jGC7lRkNq16pP7z1a3dyIRcCzEWV9kxvZo
         A+wzrzRGBMJYhYDhGqUFZL+U1pLyNl5J+xDhXn4DIL2daUgJCsrPkpR/ub5X2fJSXw
         NYJOg8EpRi+gaoGBab8thEFYaLCY5KoQfIqFD1y4=
Received: by pali.im (Postfix)
        id 070807FD; Tue,  4 Aug 2020 13:58:04 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 2/5] PCI: aardvark: Check for errors from pci_bridge_emul_init() call
Date:   Tue,  4 Aug 2020 13:57:44 +0200
Message-Id: <20200804115747.7078-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
2.20.1

