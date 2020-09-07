Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0F2603EA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgIGR4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 13:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgIGLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D5321707;
        Mon,  7 Sep 2020 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477060;
        bh=5nbUPLyq2CJjjEONBbTgCkQk25oKfmEkMVaLaNwmKlE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cEtlMp4PFP9x/Wvym6vYfeAfOr3mi7LHRk6xnuM2pzHB0c/thUnW9cwnC7ysySlq8
         ZZVcPm9XAm1EShquKXeKEEUV85SG0V2mYkctBxDPuLl7pw5q3fLELhofCvmQ7pmem1
         C/ZwgafkC7TjgZDQRBKn0FC7XH0Tk9tyFuviBJ9w=
Received: by pali.im (Postfix)
        id 64D53814; Mon,  7 Sep 2020 13:10:58 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v3 2/5] PCI: aardvark: Check for errors from pci_bridge_emul_init() call
Date:   Mon,  7 Sep 2020 13:10:35 +0200
Message-Id: <20200907111038.5811-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907111038.5811-1-pali@kernel.org>
References: <20200907111038.5811-1-pali@kernel.org>
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
index 1c5f2fd47c51..2e2e2a2ff51d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -607,7 +607,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
  * Initialize the configuration space of the PCI-to-PCI bridge
  * associated with the given PCIe interface.
  */
-static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
+static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
 
@@ -633,8 +633,7 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge, 0);
-
+	return pci_bridge_emul_init(bridge, 0);
 }
 
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
@@ -1167,7 +1166,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
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

