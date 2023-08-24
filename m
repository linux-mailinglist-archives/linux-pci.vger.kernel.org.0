Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570817878BC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbjHXTiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbjHXThq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B81BFA;
        Thu, 24 Aug 2023 12:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FA6644D4;
        Thu, 24 Aug 2023 19:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F12DC433C8;
        Thu, 24 Aug 2023 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905862;
        bh=IX3y8cL3p6OgNbcdIy2wVzu1+n2Vn2Sl6M/aYgTraUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDGgVbW6foEPOTfarIhhu3JkRXn8wqKj46dKS5Ka7ZGUO1K0X7X9AIVHRspgmejpv
         08ukE/sxRWGApxfZGXLhmIBT7L1U4m7ZAUfexA7zcBDwbSsE6CpmSQ/CmdHEn/7y4h
         ctVTSnCymGCrcdd5upeYGmjuy/gjSR59HQM/lcU5HcBVBAM5m5b6MAkuUymFbpLmxM
         IAJTXdt6dgEmwQFJ48539IruqddJKL6zvjTZk6lTiC4ZcrvepjH2/4bV5JRsRCOC0A
         8qMb7YBKJXHrEcXBubGREoJpjR5nMnrC5/J208hRebxjMxjyg175eCSyPfA7ba16m3
         NyxMB2GdvxCcA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 09/12] PCI: Fix pci_bus_resetable(), pci_slot_resetable() name typos
Date:   Thu, 24 Aug 2023 14:37:09 -0500
Message-Id: <20230824193712.542167-10-helgaas@kernel.org>
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

Fix typos in the pci_bus_resetable() and pci_slot_resetable() function
names.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d2b11c71e62..6b62795425a7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5627,7 +5627,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_try_reset_function);
 
 /* Do any devices on or below this bus prevent a bus reset? */
-static bool pci_bus_resetable(struct pci_bus *bus)
+static bool pci_bus_resettable(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -5637,7 +5637,7 @@ static bool pci_bus_resetable(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
+		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
 			return false;
 	}
 
@@ -5695,7 +5695,7 @@ static int pci_bus_trylock(struct pci_bus *bus)
 }
 
 /* Do any devices on or below this slot prevent a bus reset? */
-static bool pci_slot_resetable(struct pci_slot *slot)
+static bool pci_slot_resettable(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
@@ -5707,7 +5707,7 @@ static bool pci_slot_resetable(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
+		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
 			return false;
 	}
 
@@ -5843,7 +5843,7 @@ static int pci_slot_reset(struct pci_slot *slot, bool probe)
 {
 	int rc;
 
-	if (!slot || !pci_slot_resetable(slot))
+	if (!slot || !pci_slot_resettable(slot))
 		return -ENOTTY;
 
 	if (!probe)
@@ -5910,7 +5910,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
 {
 	int ret;
 
-	if (!bus->self || !pci_bus_resetable(bus))
+	if (!bus->self || !pci_bus_resettable(bus))
 		return -ENOTTY;
 
 	if (probe)
-- 
2.34.1

