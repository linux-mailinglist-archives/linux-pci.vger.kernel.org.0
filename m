Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5063553212
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiFUMcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiFUMcL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 08:32:11 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A611E3F8
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 05:32:07 -0700 (PDT)
Received: from ubuntu-CJ.passengers.t29.sncf ([109.190.253.13])
        by smtp.orange.fr with ESMTPA
        id 3d2qoPMJEIaWO3d2yoMI69; Tue, 21 Jun 2022 14:32:05 +0200
X-ME-Helo: ubuntu-CJ.passengers.t29.sncf
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 21 Jun 2022 14:32:05 +0200
X-ME-IP: 109.190.253.13
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-renesas-soc@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: rcar-ep: Simplify bitmap allocation.
Date:   Tue, 21 Jun 2022 14:31:46 +0200
Message-Id: <0fd98d56871f6f08ca82dcc76bfa2052368a8926.1655814557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MAX_NR_INBOUND_MAPS is small (i.e. 6), so there is no real point in
dynamic allocation for a bitmap of this size.
Moreover, it is linked with the use of the 'bar_to_atu' field which is
already statically declared.

Declare it statically instead.

This saves some LoC, reduces the size of the module and saves a few bytes
of memory at run-time.

Before: (gcc 11.2.0 / allyesconfig)
   text	   data	    bss	    dec	    hex	filename
  11514	   5232	      0	  16746	   416a	drivers/pci/controller/pcie-rcar-ep.o

After: (gcc 11.2.0 / allyesconfig)
   text	   data	    bss	    dec	    hex	filename
  11183	   5064	      0	  16247	   3f77	drivers/pci/controller/pcie-rcar-ep.o


Also replace the mostly useless 'num_ib_windows' and use
MAX_NR_INBOUND_MAPS directly instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pcie-rcar-ep.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index f9682df1da61..64682876e93e 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -25,8 +25,7 @@ struct rcar_pcie_endpoint {
 	struct pci_epc_mem_window *ob_window;
 	u8			max_functions;
 	unsigned int		bar_to_atu[MAX_NR_INBOUND_MAPS];
-	unsigned long		*ib_window_map;
-	u32			num_ib_windows;
+	DECLARE_BITMAP(ib_window_map, MAX_NR_INBOUND_MAPS);
 	u32			num_ob_windows;
 };
 
@@ -205,8 +204,8 @@ static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int idx;
 	int err;
 
-	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
-	if (idx >= ep->num_ib_windows) {
+	idx = find_first_zero_bit(ep->ib_window_map, MAX_NR_INBOUND_MAPS);
+	if (idx >= MAX_NR_INBOUND_MAPS) {
 		dev_err(pcie->dev, "no free inbound window\n");
 		return -EINVAL;
 	}
@@ -502,15 +501,7 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 		goto err_pm_put;
 	}
 
-	ep->num_ib_windows = MAX_NR_INBOUND_MAPS;
-	ep->ib_window_map =
-			devm_kcalloc(dev, BITS_TO_LONGS(ep->num_ib_windows),
-				     sizeof(long), GFP_KERNEL);
-	if (!ep->ib_window_map) {
-		err = -ENOMEM;
-		dev_err(dev, "failed to allocate memory for inbound map\n");
-		goto err_pm_put;
-	}
+	bitmap_zero(ep->ib_window_map, MAX_NR_INBOUND_MAPS);
 
 	ep->ob_mapped_addr = devm_kcalloc(dev, ep->num_ob_windows,
 					  sizeof(*ep->ob_mapped_addr),
-- 
2.32.0

