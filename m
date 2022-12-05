Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9001864382C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 23:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiLEWco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 17:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiLEWcj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 17:32:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A6A18D;
        Mon,  5 Dec 2022 14:32:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40256B8159B;
        Mon,  5 Dec 2022 22:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E1C433D7;
        Mon,  5 Dec 2022 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670279554;
        bh=twc81D3fz7hgH5I0d5mqqU6YSPMlz+/dTZIQZDfy3pY=;
        h=From:To:Cc:Subject:Date:From;
        b=LmerRZV1yaSepemQWm8AsmqLnoTj4/lTY0q34Yb/8YKlo5a8O8Xk1+5bQfheq+sRw
         DbOyfO088yMPdTdQuZL6bKyMArPbJVC68puDWA6Z+AHF1lGfwl0FYQq/eyV3tsW6AV
         TQ5yibbN3XqA2dC9Yy4xptxyNfc28Z7VtRy/Yrihy9X03K+szly0SMw6ZKwLoI3BKN
         xD3HVB6YMlXJ+oszsN3RJRUyq2SJQPQHzjLuw3vMzyZ+clEY5GFuwRpt0QkG2YAG24
         FicPqbbd2MiV6tOkvUvWeX7eGIdx5sacqW2YKsToy4vt5Kd7ZrARpXafeD9Gfsm3AG
         ACoDPBW/nfdJA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] cxl: Remove unnecessary cxl_pci_window_alignment()
Date:   Mon,  5 Dec 2022 16:32:31 -0600
Message-Id: <20221205223231.1268085-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

cxl_pci_window_alignment() is referenced only via the struct
pci_controller_ops.window_alignment function pointer, and only in the
powerpc implementation of pcibios_window_alignment().

pcibios_window_alignment() defaults to returning 1 if the function pointer
is NULL, which is the same was what cxl_pci_window_alignment() does.

cxl_pci_window_alignment() is unnecessary, so remove it.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cxl/vphb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 1264253cc07b..6332db8044bd 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -67,12 +67,6 @@ static void cxl_pci_disable_device(struct pci_dev *dev)
 	}
 }
 
-static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
-						unsigned long type)
-{
-	return 1;
-}
-
 static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	/* Should we do an AFU reset here ? */
@@ -200,7 +194,6 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 	.enable_device_hook = cxl_pci_enable_device_hook,
 	.disable_device = cxl_pci_disable_device,
 	.release_device = cxl_pci_disable_device,
-	.window_alignment = cxl_pci_window_alignment,
 	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
 	.setup_msi_irqs = cxl_setup_msi_irqs,
 	.teardown_msi_irqs = cxl_teardown_msi_irqs,
-- 
2.25.1

