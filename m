Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B93B5319
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jun 2021 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhF0Ls7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Jun 2021 07:48:59 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:45698 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhF0Ls6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jun 2021 07:48:58 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d79 with ME
        id NBmT2500921Fzsu03BmToT; Sun, 27 Jun 2021 13:46:33 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Jun 2021 13:46:33 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kishon@ti.com, tjoseph@cadence.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: j721e: Fix an error handling path in 'j721e_pcie_probe()'
Date:   Sun, 27 Jun 2021 13:46:24 +0200
Message-Id: <db477b0cb444891a17c4bb424467667dc30d0bab.1624794264.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If an error occurs after a successful 'cdns_pcie_init_phy()' call, it must
be undone by a 'cdns_pcie_disable_phy()' call, as already done above and
below.

Update the 'goto' to branch at the correct place of the error handling
path.

Fixes: 49e0efdce791 ("PCI: j721e: Add support to provide refclk to PCIe connector")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 35e61048e133..8933db6ab1af 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -424,7 +424,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(clk);
 		if (ret) {
 			dev_err(dev, "failed to enable pcie_refclk\n");
-			goto err_get_sync;
+			goto err_pcie_setup;
 		}
 		pcie->refclk = clk;
 
-- 
2.30.2

