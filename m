Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D032E490
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 10:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEJR1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 04:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCEJRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 04:17:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89574C061574
        for <linux-pci@vger.kernel.org>; Fri,  5 Mar 2021 01:17:17 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6aC-0005BF-6p; Fri, 05 Mar 2021 10:17:16 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] PCI: mediatek: fix optional reset handling
Date:   Fri,  5 Mar 2021 10:17:15 +0100
Message-Id: <20210305091715.4319-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to unconditionally return errors from
devm_reset_control_get_optional_exclusive.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 23548b517e4b..35c66fa770a6 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -954,7 +954,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 
 	snprintf(name, sizeof(name), "pcie-rst%d", slot);
 	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
-	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
+	if (IS_ERR(port->reset))
 		return PTR_ERR(port->reset);
 
 	/* some platforms may use default PHY setting */
-- 
2.29.2

