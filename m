Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4D31E29
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2019 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfFANXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jun 2019 09:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfFANXa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC86124C2E;
        Sat,  1 Jun 2019 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395409;
        bh=EHWpjrtgaGdvxxLPms5l6OrWYeITpsDHv3uESD7yqJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/c4Rd04R6gokmDxJSLrmAyKyb0DcmeZCneTCRGJJfQnBmcjFapfO7KOzmBnUwGS7
         bFTszrJrwPIBzD/fE3FnO9l4MtR9dtwfW6S/lrFKXJnCsEiVpkaRJ+Ju9AypJaN3yB
         Uxg+KlNYh9qIriUK8PDiNtFM0Z2pN42a5PCjxgUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 047/141] PCI: dwc: Free MSI in dw_pcie_host_init() error path
Date:   Sat,  1 Jun 2019 09:20:23 -0400
Message-Id: <20190601132158.25821-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 9e2b5de5604a6ff2626c51e77014d92c9299722c ]

If we ever did MSI-related initializations, we need to call
dw_pcie_free_msi() in the error code path.

Remove the IS_ENABLED(CONFIG_PCI_MSI) check for MSI init because
pci_msi_enabled() already has a stub for !CONFIG_PCI_MSI.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b56e22262a774..4eedb2c54ab38 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -439,7 +439,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
+	if (pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
@@ -477,7 +477,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			goto err_free_msi;
 	}
 
 	pp->root_bus_nr = pp->busn->start;
@@ -491,7 +491,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		goto err_free_msi;
 
 	bus = bridge->bus;
 
@@ -507,6 +507,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
 
+err_free_msi:
+	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
 error:
 	pci_free_host_bridge(bridge);
 	return ret;
-- 
2.20.1

