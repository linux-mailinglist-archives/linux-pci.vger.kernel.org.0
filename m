Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F387D7AE5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfJOQLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 12:11:55 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:54200 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfJOQLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 12:11:55 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKPQL-0007rN-Tc; Tue, 15 Oct 2019 17:11:50 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKPQL-00019x-8c; Tue, 15 Oct 2019 17:11:49 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: mvebu_pcie_map_registers __iomem fix
Date:   Tue, 15 Oct 2019 17:11:48 +0100
Message-Id: <20191015161148.4413-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the return type of mvebu_pcie_map_registers in the
error path to have __iomem on it. Fixes the following
sparse warning:

drivers/pci/controller/pci-mvebu.c:716:31: warning: incorrect type in return expression (different address spaces)
drivers/pci/controller/pci-mvebu.c:716:31:    expected void [noderef] <asn:2> *
drivers/pci/controller/pci-mvebu.c:716:31:    got void *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed032e9a3156..153a64676bc9 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -713,7 +713,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 
 	ret = of_address_to_resource(np, 0, &regs);
 	if (ret)
-		return ERR_PTR(ret);
+		return (void __iomem *)ERR_PTR(ret);
 
 	return devm_ioremap_resource(&pdev->dev, &regs);
 }
-- 
2.23.0

