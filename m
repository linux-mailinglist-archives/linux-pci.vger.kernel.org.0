Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17335786080
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHWTSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbjHWTSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 15:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2ACD5;
        Wed, 23 Aug 2023 12:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290DE6378F;
        Wed, 23 Aug 2023 19:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23854C433C7;
        Wed, 23 Aug 2023 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692818317;
        bh=JKOlWUIKDPkX1sCGD0EBVZpvcdpnHpPJU8ikm6imCbI=;
        h=From:To:Cc:Subject:Date:From;
        b=b6h/tWHDoJTHDb+qS/aqiuy3rKQoxj/vsU8/LX+Ogvka47HTceWSF7GXXOrZ2yfta
         qP5r7VAqqhdWo/cx3Pk7ILgtkGZF2Ppjc39SVRsPJKDAW8ePjLx25eRITdWJztCTS+
         9LimSVoCYEIaFuzRvXa76HIkZVfSdX5cxmS+g1Efaevf54yZC1S5UaCLfgfaNjhk7O
         c43vii/AgXjldWlNYdhxkVp5S7n9D/2qT/zP5/bApGHKCsXafejBAelB68Q+57oCyy
         cHOIT0+AR+FWQCulmwCGsaOTsSNcxjMqwvzR7HnFMC4a3Q/prHvL9BUrywygOWvVtj
         JMhRmRpgpHbjA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Tidy save/restore config messages
Date:   Wed, 23 Aug 2023 14:18:31 -0500
Message-Id: <20230823191831.476579-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Update config space save/restore debug messages so they line up better.
Previously:

  nvme 0000:05:00.0: saving config space at offset 0x4 (reading 0x20100006)
  nvme 0000:05:00.0: saving config space at offset 0x8 (reading 0x1080200)
  nvme 0000:05:00.0: saving config space at offset 0xc (reading 0x0)

  nvme 0000:05:00.0: restoring config space at offset 0x4 (was 0x0, writing 0x20100006)

Now:

  nvme 0000:05:00.0: save config 0x04: 0x20100006
  nvme 0000:05:00.0: save config 0x08: 0x01080200
  nvme 0000:05:00.0: save config 0x0c: 0x00000000

  nvme 0000:05:00.0: restore config 0x04: 0x00000000 -> 0x20100006

No functional change intended.  Enable these messages by setting
CONFIG_DYNAMIC_DEBUG=y and adding 'dyndbg="file drivers/pci/* +p"'
to kernel parameters.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..920c161575d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1681,7 +1681,7 @@ int pci_save_state(struct pci_dev *dev)
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
-		pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
+		pci_dbg(dev, "save config %#04x: %#010x\n",
 			i * 4, dev->saved_config_space[i]);
 	}
 	dev->state_saved = true;
@@ -1712,7 +1712,7 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
 		return;
 
 	for (;;) {
-		pci_dbg(pdev, "restoring config space at offset %#x (was %#x, writing %#x)\n",
+		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
 			offset, val, saved_val);
 		pci_write_config_dword(pdev, offset, saved_val);
 		if (retry-- <= 0)
-- 
2.34.1

