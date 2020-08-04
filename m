Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ADF23BA5B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHDMaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgHDMaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2020 08:30:01 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13390C06179E
        for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2020 05:04:39 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id BQ4b2300g4C55Sk01Q4bRa; Tue, 04 Aug 2020 14:04:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2vgJ-0000fz-Qm; Tue, 04 Aug 2020 14:04:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k2vgJ-0002Q0-Nm; Tue, 04 Aug 2020 14:04:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: rcar-gen2: Fix crash in resource_list_first_type()
Date:   Tue,  4 Aug 2020 14:04:30 +0200
Message-Id: <20200804120430.9253-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The conversion to modern host bridge probing made the driver allocate
its private data using devm_pci_alloc_host_bridge(), but forgot to
remove the old allocation.  Hence part of the driver initialization is
done using the new instance, while another part is done using the old
instance, leading to a crash due to uninitialized bridge DMA ranges:

    Unable to handle kernel NULL pointer dereference at virtual address 00000008
    pgd = (ptrval)
    [00000008] *pgd=00000000
    Internal error: Oops: 5 [#1] SMP ARM
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    PC is at rcar_pci_probe+0x154/0x340
    LR is at _raw_spin_unlock_irqrestore+0x18/0x20

Fix this by dropping the old allocation.

Fixes: 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use modern host bridge probe functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/pci-rcar-gen2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 046965d284a6d54e..c9530038ca9a53fc 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -302,10 +302,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	if (mem_res->start & 0xFFFF)
 		return -EINVAL;
 
-	priv = devm_kzalloc(dev, sizeof(struct rcar_pci_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	priv->mem_res = *mem_res;
 	priv->cfg_res = cfg_res;
 
-- 
2.17.1

