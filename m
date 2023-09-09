Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC879939D
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjIIA0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345548AbjIIAZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:25:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069526A5;
        Fri,  8 Sep 2023 17:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C8C43397;
        Sat,  9 Sep 2023 00:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219090;
        bh=MUAy4YLJX/Ulh0SKNkIFJu0Mk9JjG0u+FYtd/Na8of8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5WMh+lgp492ezzoFEt6c3uL4GAmXfEkFY8Co1ocjJxR00h4qgYdGcOH6iJpJbDtv
         5/vQWfHIicjR8uKLYBMeqzTrYk81oWHxHjMQP6g1v/TouEeOp44VAlT/UQ9i5IcFd5
         J7vi9f9rfaehaSnLN5B8rGHI1HYonfvdT4mwi5G1O/glbj4qTwwWPlNZ67sR25ZtKR
         WJ1WnjcrJ4TyIcTcXGv2qDth5vNkgsMh6d8EQQ5uZ3AJitg0WZnM/Q/5dvKBq7eWKJ
         6JhBKBQKpiYk3xGusZq8jw6TAP74L/2LP5WrmE64xWosGA+eZLoAjGB3iLHcvIMGyd
         MLTORcCnkgeyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/5] PCI: Make quirk using inw() depend on HAS_IOPORT
Date:   Fri,  8 Sep 2023 20:24:38 -0400
Message-Id: <20230909002442.3578957-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002442.3578957-1-sashal@kernel.org>
References: <20230909002442.3578957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
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

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit f768c75d61582b011962f9dcb9ff8eafb8da0383 ]

In the future inw() and friends will not be compiled on architectures
without I/O port support.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/r/20230703135255.2202721-2-schnelle@linux.ibm.com
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7ca82b8c5c37e..0669b0d93f6f1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -102,6 +102,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_d
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
 
+#ifdef CONFIG_HAS_IOPORT
 /*
  * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
  * for some HT machines to use C4 w/o hanging.
@@ -121,6 +122,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
+#endif
 
 /*
  *	Chipsets where PCI->PCI transfers vanish or hang
-- 
2.40.1

