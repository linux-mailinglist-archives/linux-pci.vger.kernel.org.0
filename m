Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4012E5ABB48
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIBXf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIBXfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE44DF4C3;
        Fri,  2 Sep 2022 16:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E46A8B82E0A;
        Fri,  2 Sep 2022 23:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80484C433C1;
        Fri,  2 Sep 2022 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662161748;
        bh=RT3RQzwcZmsdKMDfRVB08SNXYiMqaAszRBdVwIagBPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTZt7uElIqBz6mNk1MqXtukLcbo3Q/pD/xTo92Z+6QLOleBITyDBTErabqb85N621
         3LjOIyZHMkQDywjG9hRlmdk+Il+NSJt2hplMAALQAZ+xuKtHME4Ek8oqmW5CNYcqdo
         hyX5nz4eBWGv0YNT8kJNz5REaBzAW657Tc4ZICjXQKz2fiAs4x9PYnNLgNNMy0/LbD
         9rY6tPbaJUtJcWom8ZTko3Dcv58qdWOTRWi7T5AB99jY8Lz27AMqkE73ZDxXbiGAGn
         BpVQxsmDnu7BYid1A1T2IgI6ViO+fR2irWNsyDi8XziMXNJtTxliJ2rL0gvFTrqCPE
         tzVnKKliVvBow==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/3] PCI/PTM: Preserve PTM Root Select
Date:   Fri,  2 Sep 2022 18:35:41 -0500
Message-Id: <20220902233543.390890-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902233543.390890-1-helgaas@kernel.org>
References: <20220902233543.390890-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

When disabling PTM, there's no need to clear the Root Select bit.  We
disable PTM during suspend, and we want to re-enable it during resume.
Clearing Root Select here makes re-enabling more complicated.

Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
this Time Source is the PTM Root," so if PTM Enable is cleared, the value
of Root Select should be irrelevant.

Preserve Root Select to simplify re-enabling PTM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pcie/ptm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..b6a417247ce3 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
-	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+	ctrl &= ~PCI_PTM_CTRL_ENABLE;
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
 }
 
-- 
2.25.1

