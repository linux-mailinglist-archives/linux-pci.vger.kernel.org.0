Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A47DB9F3
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjJ3MeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJ3MeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 08:34:03 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3164C6
        for <linux-pci@vger.kernel.org>; Mon, 30 Oct 2023 05:34:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 96E5210189B30;
        Mon, 30 Oct 2023 13:34:00 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 703D060E0F2B;
        Mon, 30 Oct 2023 13:34:00 +0100 (CET)
X-Mailbox-Line: From fc30de5276e21d5a3ebcb7e58a8b43e399f7e6e6 Mon Sep 17 00:00:00 2001
Message-Id: <fc30de5276e21d5a3ebcb7e58a8b43e399f7e6e6.1698668982.git.lukas@wunner.de>
In-Reply-To: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>
References: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 30 Oct 2023 13:33:13 +0100
Subject: [PATCH 2/2] PCI: Remove obsolete pci_cleanup_rom() declaration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Krzysztof Wilczynski <kwilczynski@kernel.org>,
        Alistair Francis <alistair23@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit d9c8bea179a6 ("PCI: Remove unused IORESOURCE_ROM_COPY and
IORESOURCE_ROM_BIOS_COPY") removed pci_cleanup_rom(), but retained
its declaration in pci.h.

Remove it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index aedaf4e51146..d865c4321e14 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -31,7 +31,6 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
 
-void pci_cleanup_rom(struct pci_dev *dev);
 #ifdef CONFIG_DMI
 extern const struct attribute_group pci_dev_smbios_attr_group;
 #endif
-- 
2.40.1

