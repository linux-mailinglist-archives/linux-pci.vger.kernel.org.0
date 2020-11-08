Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380972AAD28
	for <lists+linux-pci@lfdr.de>; Sun,  8 Nov 2020 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgKHTKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Nov 2020 14:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHTKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2020 14:10:19 -0500
X-Greylist: delayed 1672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Nov 2020 11:10:19 PST
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430BC0613CF
        for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2020 11:10:19 -0800 (PST)
Received: from dslb-084-059-242-201.084.059.pools.vodafone-ip.de ([84.59.242.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kbpdt-0006Of-1o; Sun, 08 Nov 2020 19:42:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] PCI: brcmstb: Remove irq handler and data in one go
Date:   Sun,  8 Nov 2020 19:42:08 +0100
Message-Id: <20201108184208.19790-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the two separate calls for removing the irq handler and data with a
single irq_set_chained_handler_and_data() call.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bea86899bd5d..7c666f4deb47 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -606,8 +606,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 	if (!msi)
 		return;
-	irq_set_chained_handler(msi->irq, NULL);
-	irq_set_handler_data(msi->irq, NULL);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 	brcm_free_domains(msi);
 }
 
-- 
2.20.1

