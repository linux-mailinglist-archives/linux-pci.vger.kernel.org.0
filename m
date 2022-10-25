Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258EE60D4BD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 21:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiJYTfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJYTfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 15:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381DD73D2;
        Tue, 25 Oct 2022 12:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6DF61B09;
        Tue, 25 Oct 2022 19:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9270EC433C1;
        Tue, 25 Oct 2022 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666726505;
        bh=CEcnd/MJyW10U1N9vmD9eLkgZa9XY0JfKKcSiavtBOw=;
        h=From:To:Cc:Subject:Date:From;
        b=cc/XXN8cZHxhoRAr6MyUEioF6EuzxrTwlIf17uXH4OjgQTzF3XIMH7BTeS1f5b15q
         HeMxw3O4i3GGduw3RpPsT/U1z3Cyb0Wim8wv8GTbqYQH7cMKox9M4CybXWPY1/h4w3
         zcsZjqZuOZgIYqjjRhhbs8bW7TcTIJzuCXuw39gLFLAD11E9yEPpY1tcFcKgcf1W8+
         TNq0KYx1yPyyjj9a1IGBSfmFbs7ozapOdoFIQH19EsI98uo0nTwEwQbqkRthwFXkFW
         c6hO32Y7yzvJVllf/1EndiiGL5toXjfDNnaZXDgBgLPZmCHEqbULxcSQJaDddKpoOO
         NiMD8zMRiEkAg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/PM: Remove unused 'state' parameter to pci_legacy_suspend_late()
Date:   Tue, 25 Oct 2022 14:35:02 -0500
Message-Id: <20221025193502.669091-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

1a1daf097e21 ("PCI/PM: Remove unused pci_driver.suspend_late() hook")
removed the legacy .suspend_late() hook, which was the only user of the
"state" parameter to pci_legacy_suspend_late(), but it neglected to remove
the parameter.

Remove the unused "state" parameter to pci_legacy_suspend_late().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 107d77f3c846..a2ceeacc33eb 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -646,7 +646,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 	return 0;
 }
 
-static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
+static int pci_legacy_suspend_late(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
@@ -848,7 +848,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		return 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
+		return pci_legacy_suspend_late(dev);
 
 	if (!pm) {
 		pci_save_state(pci_dev);
@@ -1060,7 +1060,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
+		return pci_legacy_suspend_late(dev);
 
 	if (pm && pm->freeze_noirq) {
 		int error;
@@ -1179,7 +1179,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 		return 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
+		return pci_legacy_suspend_late(dev);
 
 	if (!pm) {
 		pci_fixup_device(pci_fixup_suspend_late, pci_dev);
-- 
2.25.1

