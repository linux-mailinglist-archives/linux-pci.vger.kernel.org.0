Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCC23BA0F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgHDL7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 07:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbgHDL6H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:07 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935B620A8B;
        Tue,  4 Aug 2020 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542287;
        bh=1cpl4cueW3TfrufysjqTxDM1ImHIUS1uP6sSuXLgEtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPnaylwnSDG3JU4Xto1Y/eNJvrAua5ybDzLLBRdfaUa+z6BrZ1woIhHP87g5PEECs
         eCh5Hr6TpyEuwlGfvXe6lowR7b9gTgTNbo5z3GKhqXQLMXtxLYhCFMAeGn4N0nzTan
         EJ18I/U+FFvbB4TV0pTgViL7HADN0BJ7M4o/KzUo=
Received: by pali.im (Postfix)
        id BC339AE3; Tue,  4 Aug 2020 13:58:05 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 3/5] PCI: pci-bridge-emul: Export API functions
Date:   Tue,  4 Aug 2020 13:57:45 +0200
Message-Id: <20200804115747.7078-4-pali@kernel.org>
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
2.20.1

