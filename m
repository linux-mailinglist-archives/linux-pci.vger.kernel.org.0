Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8F7878C7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbjHXTiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjHXThl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DE10EF;
        Thu, 24 Aug 2023 12:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6731654DF;
        Thu, 24 Aug 2023 19:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B10C433C7;
        Thu, 24 Aug 2023 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905858;
        bh=cRcXheMwP6+1IJC+RJCLu/hAsRt8eGGz+8gJIYd9Mr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fnx+q3wot+N0rwZlsRkmOo/a0ur9OMBcgzbVfO3Q8KyWCUaQeV6CE76fqtj4mNNnh
         v97rUHuo2De5LEkm26rmn5ClFd2dKmfOKv9bac/BrqNzLcHhU8LGFEHi1VBDwqpRF8
         LR3QN/egT81La04HcYJpfRMcO5J8/kOgQYM/6K+RP4MQ3Jtw1RmVYfXUsYGOYHzCmH
         +uYo/OAZQ5v8jUuYBrZkZm4wTSAuHNursZE06y3MYBcj2gEkLEYkje42oaVtyVW6n6
         GBynX9Mr9JsBjTYJ7OjXlFPRfktdzX7qTIp3xy52+JwD3M7oMe2Ma6/xOjCJFpANXp
         qgLtgWRu8xhpg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 07/12] PCI: Simplify pci_pio_to_address()
Date:   Thu, 24 Aug 2023 14:37:07 -0500
Message-Id: <20230824193712.542167-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify pci_pio_to_address() by removing an unnecessary local variable.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..4d2b11c71e62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4191,16 +4191,12 @@ int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 
 phys_addr_t pci_pio_to_address(unsigned long pio)
 {
-	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
-
 #ifdef PCI_IOBASE
-	if (pio >= MMIO_UPPER_LIMIT)
-		return address;
-
-	address = logic_pio_to_hwaddr(pio);
+	if (pio < MMIO_UPPER_LIMIT)
+		return logic_pio_to_hwaddr(pio);
 #endif
 
-	return address;
+	return (phys_addr_t) OF_BAD_ADDR;
 }
 EXPORT_SYMBOL_GPL(pci_pio_to_address);
 
-- 
2.34.1

