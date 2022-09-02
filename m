Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51D5AB50E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiIBP0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiIBPZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:25:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B9339BAB;
        Fri,  2 Sep 2022 07:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64FEDB82C4E;
        Fri,  2 Sep 2022 14:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01ABC433D6;
        Fri,  2 Sep 2022 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130721;
        bh=RT3RQzwcZmsdKMDfRVB08SNXYiMqaAszRBdVwIagBPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkAY7R+k7mPZucBQoehE250/BiWxu/qI4+RUJhNkXWiWGuyz+B7yLItRsuAWyfxmh
         yQVgJxj/yKDqV6d8wzWI4TARqiH+LGj+UK1uQbWeUscrz1JfwPZaORvo+zQ+8SnEi9
         ajc6Ctr+6nQ6EZqewpz7OhWFqRC97HnMg5JKVWuTIvCwknz5sMRkyglHwAnF4lV0XP
         +dgZDLM6NbnmunLb7GMwfhqNZS3IjPZz6vp77CqfrFrBKUFmRyvQ7oiiuXwsZi4tlw
         PsB8i0eYQgW3f0i8R6No+R62fVV/WYZ5dviR1ovudzcBZUopRiAdpBIA3GsueisYHn
         B9+GCX3j6mMTQ==
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
Subject: [PATCH 1/4] PCI/PTM: Preserve PTM Root Select
Date:   Fri,  2 Sep 2022 09:58:32 -0500
Message-Id: <20220902145835.344302-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902145835.344302-1-helgaas@kernel.org>
References: <20220902145835.344302-1-helgaas@kernel.org>
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

