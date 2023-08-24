Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106C7878A1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbjHXThj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243302AbjHXThe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBE1B0;
        Thu, 24 Aug 2023 12:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2983A644D4;
        Thu, 24 Aug 2023 19:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6619BC433C7;
        Thu, 24 Aug 2023 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905851;
        bh=uEaMGXPYtC/OHWRHgB52pCJcn99x8H/XeVoKPGgjVAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmuwhMGtCFLPUZJ+UZh04i07ySTvpsNgfXjo9ieiXm1+FRwTdBGDCwBuBBN4tqACc
         OdzqCvk39MvrHGVkUjtkwbY2DNZPvozHgJPrIYhL/AkdQF2oqh88LjKrtqaaLtAbuO
         nuqA5M+ZM8tbXNFGJSMCN9JP5/oIUFTOsOGeLUvuqBzIMdnVJ2gKFFnrPOTidvUpVR
         kaMypFf+DH9c/vukiDNz3HQ0TwVuNnxHN4vEqfX0dfTeo2jGu3gJQWPKe0Daxc6cjK
         jGxc6h8WgxkUkF7WIsK9BAYlhYzmYaAg6GRztKshjOFXTMEO6wnmrK3/V7h2MXtsIG
         naRtAn9DZI/zQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 04/12] PCI: Fix printk field formatting
Date:   Thu, 24 Aug 2023 14:37:04 -0500
Message-Id: <20230824193712.542167-5-helgaas@kernel.org>
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

Previously we used "%#08x" to print a 32-bit value.  This fills an
8-character field with "0x...", but of course many 32-bit values require a
10-character field "0x12345678" for this format.  Fix the formats to avoid
confusion.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 967f9a758923..ceaa69491f5e 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -104,7 +104,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
-		pci_err(dev, "BAR %d: error updating (%#08x != %#08x)\n",
+		pci_err(dev, "BAR %d: error updating (%#010x != %#010x)\n",
 			resno, new, check);
 	}
 
@@ -113,7 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
-			pci_err(dev, "BAR %d: error updating (high %#08x != %#08x)\n",
+			pci_err(dev, "BAR %d: error updating (high %#010x != %#010x)\n",
 				resno, new, check);
 		}
 	}
-- 
2.34.1

