Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419D464521
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 03:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbhLAC54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 21:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbhLAC5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 21:57:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BDBC061574;
        Tue, 30 Nov 2021 18:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A692B81DD5;
        Wed,  1 Dec 2021 02:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFD0C53FCC;
        Wed,  1 Dec 2021 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638327270;
        bh=Rs5nrByMZEKY50e3/Uybp1EofyQ1cz72KLs3O4vIiuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTHt1iODePRAHUrXQpKe+QwOyiLxbLEz+nB+knVjM5t5+npWNQCgFogwGuhzFp8gL
         +lEOr0t7c33hu6Oegss9bZj/unRhzNArb6HNiZDQ6RRzTSb30AFngXEiRkIfI8Gil2
         Pm20wxr+Aol8XCAk4EhOQOnJwGiBE7ASipljY7F81eHKRDFAsRrbqH4REuT82j3aJL
         6KUNVsrratW0wFG553EdA2pi2N3Hu0MKe5K68wEWujgTf3IPXnJuLJanc85oftSvKd
         0F5Bs2KGF2wjzxoofHmBYevb7LE1sZeNsukagUecxkVatBoI70x+0teFxrB4T+Q6MM
         hXnBe2Ks0DSZQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/3] sis-agp: convert to generic power management
Date:   Tue, 30 Nov 2021 20:54:18 -0600
Message-Id: <20211201025419.2797624-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201025419.2797624-1-helgaas@kernel.org>
References: <20211201025419.2797624-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert sis-agp from legacy PCI power management to the generic power
management framework.

Previously, sis-agp used legacy PCI power management.  agp_sis_suspend()
looked like this:

  agp_sis_suspend
    pci_save_state(pdev)
    pci_set_power_state(pdev, pci_choose_state(pdev, state))

With generic power management, these are both done by the PCI core in
pci_pm_runtime_suspend(), so drop agp_sis_suspend() completely.

agp_sis_resume() looked like this:

  agp_sis_resume
    pci_set_power_state(pdev, PCI_D0)
    pci_restore_state(pdev)
    sis_driver.configure()

With generic power management, the PCI parts are done by
pci_pm_runtime_resume(), so drop those from agp_sis_resume().

[bhelgaas: commit log]
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/sis-agp.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
index 14909fc5d767..f8a02f4bef1b 100644
--- a/drivers/char/agp/sis-agp.c
+++ b/drivers/char/agp/sis-agp.c
@@ -217,26 +217,14 @@ static void agp_sis_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_sis_suspend NULL
 
-static int agp_sis_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_sis_resume(
+	__attribute__((unused)) struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_sis_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	return sis_driver.configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_sis_pci_table[] = {
 	{
 		.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -419,15 +407,14 @@ static const struct pci_device_id agp_sis_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_sis_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_sis_pm_ops, agp_sis_suspend, agp_sis_resume);
+
 static struct pci_driver agp_sis_pci_driver = {
 	.name		= "agpgart-sis",
 	.id_table	= agp_sis_pci_table,
 	.probe		= agp_sis_probe,
 	.remove		= agp_sis_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_sis_suspend,
-	.resume		= agp_sis_resume,
-#endif
+	.driver.pm      = &agp_sis_pm_ops,
 };
 
 static int __init agp_sis_init(void)
-- 
2.25.1

