Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0AF1AEACD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDRIQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 04:16:42 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:26000 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgDRIQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 04:16:42 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d64 with ME
        id U8Gf220050scBcy038GfPu; Sat, 18 Apr 2020 10:16:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Apr 2020 10:16:40 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linus.walleij@linaro.org, lorenzo.pieralisi@arm.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: v3-semi: Fix a memory leak in some error handling paths in 'v3_pci_probe()'
Date:   Sat, 18 Apr 2020 10:16:37 +0200
Message-Id: <20200418081637.1585-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IF we fails somewhere in 'v3_pci_probe()', we need to free 'host'.
Use the managed version of 'pci_alloc_host_bridge()' to do that easily.
The use of managed resources is already widely used in this driver.

Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Fixes could be older than this commit, but this is as far as git can go.

There is also a 'clk_prepare_enable()' which looks un-ballanced. I don't
know if it can be an issue.

Compile tested only.
---
 drivers/pci/controller/pci-v3-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index bd05221f5a22..ddcb4571a79b 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -720,7 +720,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	host = pci_alloc_host_bridge(sizeof(*v3));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*v3));
 	if (!host)
 		return -ENOMEM;
 
-- 
2.20.1

