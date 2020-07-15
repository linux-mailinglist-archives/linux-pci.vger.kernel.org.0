Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547E220F21
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGOO0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:00 -0400
Received: from lists.nic.cz ([217.31.204.67]:34900 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgGOOZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:25:59 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 79497140A5D;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=sQp6sw1pd1H2vwHpvza0rOe5XDLopPj0Q2DKS+BS2DA=;
        h=From:To:Date;
        b=A6FljPmOlB1YnkZW/BHqu5LZjzNogxWbG6hQ4nOYYzJrD1Am/M3LlZiDZ2b0DXsez
         sZoEMejCL3j/AsKLsfB5iooPQu+6uJOrT31E4d9Si8bLSSUTP3YFxkXJ0V/cwUCtEI
         yUXc/6PHDHH3kQOBR12cZ/gv1fWgz6J/DQepYB3M=
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
Subject: [PATCH 3/5] PCI: pci-bridge-emul: Export API functions
Date:   Wed, 15 Jul 2020 16:25:55 +0200
Message-Id: <20200715142557.17115-4-marek.behun@nic.cz>
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

It allows kernel modules which are not compiled into kernel image to use
pci-bridge-emul API functions.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/pci-bridge-emul.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index ccf26d12ec61..139869d50eb2 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -294,6 +294,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_init);
 
 /*
  * Cleanup a pci_bridge_emul structure that was previously initialized
@@ -305,6 +306,7 @@ void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge)
 		kfree(bridge->pcie_cap_regs_behavior);
 	kfree(bridge->pci_regs_behavior);
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_cleanup);
 
 /*
  * Should be called by the PCI controller driver when reading the PCI
@@ -366,6 +368,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_conf_read);
 
 /*
  * Should be called by the PCI controller driver when writing the PCI
@@ -430,3 +433,4 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_conf_write);
-- 
2.26.2

