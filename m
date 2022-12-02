Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E656640FDC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiLBVS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiLBVSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:18:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B048B39E;
        Fri,  2 Dec 2022 13:18:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E647C623D6;
        Fri,  2 Dec 2022 21:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D03C433D6;
        Fri,  2 Dec 2022 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670015932;
        bh=wsQic+DniH74o9yizSX8yaBBMzi/Wi+iIyhKaROtdo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3sXXHwxN9VweUd0NumRiwmL3FmBqGo0lrQpAsZNTwWMWhlAH1z4Hvw4Z2wNQpPec
         owEC9CSEADGVaI21ILS1qF6lSOHhZoQiAlIGQE2DWLNzxtIuIyERr1u9ESbAiaBI6d
         YwAzIC2FtT/KwO8JBE+KbzFalYk/b/UTa22xwt8zT8KaURtErdrMTiCj0mcY9qsxWA
         zeFGtNAaoZV6aeMlbE1Q83Lvr/5KjtOhLXYN4P63q8Z0kZXaVFBw8XJ1qOX3Owuyw5
         wQw2xSON9scGc4fj0HxEFCwhTVfD749EM94NFKN9LtFef604z9Imao+T5hXLlUll1v
         Yd9Uozi/3S5tw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/4] x86/PCI: Fix log message typo
Date:   Fri,  2 Dec 2022 15:18:38 -0600
Message-Id: <20221202211838.1061278-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202211838.1061278-1-helgaas@kernel.org>
References: <20221202211838.1061278-1-helgaas@kernel.org>
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

Add missing word in the log message:

  - ... so future kernels can this automatically
  + ... so future kernels can do this automatically

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/pci/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2f82480fd430..83dfea9e9894 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -245,7 +245,7 @@ void __init pci_acpi_crs_quirks(void)
 	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
 	       pci_use_e820 ? "Using" : "Ignoring");
 	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
-		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can this automatically\n");
+		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
-- 
2.25.1

