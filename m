Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C27C41CF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjJJUpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjJJUpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:45:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26799B9;
        Tue, 10 Oct 2023 13:45:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCABC43395;
        Tue, 10 Oct 2023 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970703;
        bh=TtBfspZRpLgYTkT4da6v7uokKzQgOLDSBI/yi1ypaEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2EmOMtlvdm8PYHlB7p4x4MLdN03vEw95+LLVFIIXE7PHxTfaYx53sFs5199tU6tI
         xasTG28bJFLsTuGpOw1EMuUdwfLwVlfZ0XQtZfaDVvaHSA89yhtYDWXE3yZaqfdyPN
         KsDtVyiqdUVW2XLd7l8dO4DxodsJCoYqAzZT1NgXGwxaLC/Wj5G5sAStzEvtiD+EJv
         mxoQK7Holzu2tjsTkOVq0ofqHpX3OpTkKBTnid8OuTwn1M2mgklDUEM53dyOsT718k
         OOekZvTUzS7pWXFDylWWyO87lkxfT+09AfHp0kh9XuTxBvgDD5sgKHQkpB+nuVVZgh
         Nab5lb2+Zi5iw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 08/10] PCI/PTM: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:34 -0500
Message-Id: <20231010204436.1000644-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
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

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index b4e5f553467c..7cfb6c0d5dcb 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -53,7 +54,7 @@ void pci_ptm_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
-	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
+	dev->ptm_granularity = FIELD_GET(PCI_PTM_GRANULARITY_MASK, cap);
 
 	/*
 	 * Per the spec recommendation (PCIe r6.0, sec 7.9.15.3), select the
@@ -146,7 +147,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 
 	ctrl |= PCI_PTM_CTRL_ENABLE;
 	ctrl &= ~PCI_PTM_GRANULARITY_MASK;
-	ctrl |= dev->ptm_granularity << 8;
+	ctrl |= FIELD_PREP(PCI_PTM_GRANULARITY_MASK, dev->ptm_granularity);
 	if (dev->ptm_root)
 		ctrl |= PCI_PTM_CTRL_ROOT;
 
-- 
2.34.1

