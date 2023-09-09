Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F279935C
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbjIIAYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344814AbjIIAYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:24:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F42110;
        Fri,  8 Sep 2023 17:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E513C433AB;
        Sat,  9 Sep 2023 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218991;
        bh=Snqvgixc7bVxYnxBEd8RYTOCCMGUKkpLC2JkYXwsr+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcQCA6Bsmkc3B6ZMeQXCXMtz2MR+XYy/pKfkpkjWunpsmX2Y6ig7vAgCBLd357APG
         Opgqk5bTmOAnGPCJHTu49j4BYnyKcvxEavQLUgx8wmNj0AcckRXbzIS0sreNCJqgLJ
         2z24N4TaHWPDVN+eUYgBLGERfpJVrgYlWb1D1hCsfDUOD1f5m/lRRdbZ3mEWcRwuTn
         8LG+nojMCYT10FMlkB/Tr/MBASXVNq7IQLIQfRExhSNRh2e3B10SX3iUft/NglZEfi
         E03y46cTbbdz8dtSdindZrQHGvkoULbSdnH6pH18kEzM2ukyVJftpXzEwoZATNVEWT
         cBFKpFz6f9oIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/9] PCI: Make quirk using inw() depend on HAS_IOPORT
Date:   Fri,  8 Sep 2023 20:22:54 -0400
Message-Id: <20230909002302.3578361-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002302.3578361-1-sashal@kernel.org>
References: <20230909002302.3578361-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index 472fa2c8ebcec..3caa0907de00a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -268,6 +268,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_d
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
 #endif
 
+#ifdef CONFIG_HAS_IOPORT
 /*
  * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
  * for some HT machines to use C4 w/o hanging.
@@ -287,6 +288,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
+#endif
 
 /* Chipsets where PCI->PCI transfers vanish or hang */
 static void quirk_nopcipci(struct pci_dev *dev)
-- 
2.40.1

