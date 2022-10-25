Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BC60D5A3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJYUjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 16:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiJYUjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 16:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA9AC4B9;
        Tue, 25 Oct 2022 13:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6561B61B8C;
        Tue, 25 Oct 2022 20:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2C3C433B5;
        Tue, 25 Oct 2022 20:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666730344;
        bh=bnYxHxTDl/z/W50ryG9bLwzmSvCiz6uSDgFkbYd/EOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quKfNtmqtPTPLTrZWSAl0cLEuhgcf/eTZn6PkksPzNTkKRdt9LLiEKmtPfTHEfH9o
         0b7yfbmDsdU0GCaUDTH4lMcyUwMh/EyH0E2X38RtiyvIQ9X84gteB04KfLVHlzXheT
         mOboh9mPuZvMcO6kQh9A8c7mvPpYnLV1r3+8OTz+qopU/CPFFbeCBUczRsFa29YRQ1
         h3zgO/hd0veku1Pxl8zzSRHy3UAwl0y5xkICWjD7n7QvTbHirRdKAPXGHMTlXrnYh+
         Gd56kvaSS9CTpc58lccQxt77LbhVxUY6YY4Z6yoylZGawZZOXMx1bGVNwz6zGay2zB
         fHTtavjyJWgew==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@redhat.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/8] agp/amd-k7: Convert to generic power management
Date:   Tue, 25 Oct 2022 15:38:47 -0500
Message-Id: <20221025203852.681822-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025203852.681822-1-helgaas@kernel.org>
References: <20221025203852.681822-1-helgaas@kernel.org>
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

Convert agpgart-amdk7 from legacy PCI power management to the generic power
management framework.

Previously agpgart-amdk7 used legacy PCI power management, and
agp_amdk7_suspend() and agp_amdk7_resume() were responsible for both
device-specific things and generic PCI things like saving and restoring
config space and managing power state:

  agp_amdk7_suspend
    pci_save_state                         <-- generic PCI
    pci_set_power_state                    <-- generic PCI

  agp_amdk7_resume
    pci_set_power_state(PCI_D0)            <-- generic PCI
    pci_restore_state                      <-- generic PCI
    amd_irongate_driver.configure          <-- device-specific

Convert to generic power management where the PCI bus PM methods do the
generic PCI things, and the driver needs only the device-specific part,
i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                       # PCI bus .suspend() method
        agp_amdk7_suspend                  <-- not needed at all; removed
    suspend_enter
      dpm_suspend_noirq(PMSG_SUSPEND)
        pci_pm_suspend_noirq               # PCI bus .suspend_noirq() method
          pci_save_state                   <-- generic PCI
          pci_prepare_to_sleep             <-- generic PCI
            pci_set_power_state
    ...
    dpm_resume_end(PMSG_RESUME)
      pci_pm_resume                        # PCI bus .resume() method
        pci_restore_standard_config
          pci_set_power_state(PCI_D0)      <-- generic PCI
          pci_restore_state                <-- generic PCI
        agp_amdk7_resume                   # driver->pm->resume
          amd_irongate_driver.configure    <-- device-specific

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/amd-k7-agp.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 2b2095542816..55397ba765d2 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -488,26 +488,11 @@ static void agp_amdk7_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-
-static int agp_amdk7_suspend(struct pci_dev *pdev, pm_message_t state)
+static int agp_amdk7_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_amdk7_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	return amd_irongate_driver.configure();
 }
 
-#endif /* CONFIG_PM */
-
 /* must be the same order as name table above */
 static const struct pci_device_id agp_amdk7_pci_table[] = {
 	{
@@ -539,15 +524,14 @@ static const struct pci_device_id agp_amdk7_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_amdk7_pci_table);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(agp_amdk7_pm_ops, NULL, agp_amdk7_resume);
+
 static struct pci_driver agp_amdk7_pci_driver = {
 	.name		= "agpgart-amdk7",
 	.id_table	= agp_amdk7_pci_table,
 	.probe		= agp_amdk7_probe,
 	.remove		= agp_amdk7_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_amdk7_suspend,
-	.resume		= agp_amdk7_resume,
-#endif
+	.driver.pm	= &agp_amdk7_pm_ops,
 };
 
 static int __init agp_amdk7_init(void)
-- 
2.25.1

