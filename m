Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C547878B9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbjHXTiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbjHXTh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C9199D;
        Thu, 24 Aug 2023 12:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28B963E83;
        Thu, 24 Aug 2023 19:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FC6C433C8;
        Thu, 24 Aug 2023 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905870;
        bh=TxFlo3rahknBv2NQiotq3bBQOJxkeLlh82x/HlCUcLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7tk6OtT86xxJ0CtbEXRYpeQrsQw9aTDqvQezQ1M9psRMZcMaxwjxOWa2iphx/TQ+
         nrut97Rzyri2OB4eE4wTI49tKu6GwuLJG1sjT8uKxXbPca+Q6znJdT8NhjaHvVc1qQ
         CeZCyNvQrvGj7A99WWCtQb8K2GkiLREC0O6WUWIjd3JOgDrU0DqPKQPFi6h0v1V7CP
         bE0W+TOvi7/nH6jpBUgsMN4awHTQwwdBYVHc0p5SCoZhSeYlt/om0d2D1ilLsxNYmy
         /grc8L7bff1Pm7xRfHW5g2ayKcsYwZwLeK+GSiuKbxdXNUaXAdLusqWs9mY+9BdYcQ
         vOMVXZ116QWeA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/12] PCI: Simplify pcie_capability_clear_and_set_word() control flow
Date:   Thu, 24 Aug 2023 14:37:12 -0500
Message-Id: <20230824193712.542167-13-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Return early for errors in pcie_capability_clear_and_set_word_unlocked()
and pcie_capability_clear_and_set_dword() to simplify the control flow.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/access.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 0b2e90d2f04f..6554a2e89d36 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -504,13 +504,12 @@ int pcie_capability_clear_and_set_word_unlocked(struct pci_dev *dev, int pos,
 	u16 val;
 
 	ret = pcie_capability_read_word(dev, pos, &val);
-	if (!ret) {
-		val &= ~clear;
-		val |= set;
-		ret = pcie_capability_write_word(dev, pos, val);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	val &= ~clear;
+	val |= set;
+	return pcie_capability_write_word(dev, pos, val);
 }
 EXPORT_SYMBOL(pcie_capability_clear_and_set_word_unlocked);
 
@@ -535,13 +534,12 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
 	u32 val;
 
 	ret = pcie_capability_read_dword(dev, pos, &val);
-	if (!ret) {
-		val &= ~clear;
-		val |= set;
-		ret = pcie_capability_write_dword(dev, pos, val);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	val &= ~clear;
+	val |= set;
+	return pcie_capability_write_dword(dev, pos, val);
 }
 EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
-- 
2.34.1

