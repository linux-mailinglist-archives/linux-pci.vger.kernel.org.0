Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429A46DC57
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhLHThD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:37:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40266 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbhLHThB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:37:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD6CCCE2337;
        Wed,  8 Dec 2021 19:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8CC341C8;
        Wed,  8 Dec 2021 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638992006;
        bh=EcWZzUx4fqo+uh+hVA6nBDu/rUQP+9fMDDPThINoo4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6CQYQZp4U7EOFnagjaEa2clBMQESxBzD56wgo2Jshr2oYquwQKW1mplkBRXzEbXQ
         xpRCqeGDoDfzVEcOhscr/a6zG9lLpMpCKMmPiBxo7xX0ql0QIfmmDqmAcZo7s5VW+c
         qUaLL7py7Vw/HYCrAmy7QotEXqHokVIepgpMAGr7GM8sN9cExft5BZtB1mOqgHL+8K
         cA9IlYvHsfww1zDyMzNmf+W0CN7SDYWrMoO8Mt3wB5OYC76sE6Mif2XkQozYPms9ds
         hoFRYs8js8LooTQwH2IrvGdxgNBWJC1KXQoNV6IGRQZ/3XAWW2Zovvm0/zwZMO8mhm
         mFAT/Z9CxwBHA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 3/3] via-agp: convert to generic power management
Date:   Wed,  8 Dec 2021 13:33:05 -0600
Message-Id: <20211208193305.147072-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208193305.147072-1-helgaas@kernel.org>
References: <20211208193305.147072-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert via-agp from legacy PCI power management to the generic power
management framework.

Previously, via-agp used legacy PCI power management, and agp_via_suspend()
and agp_via_resume() were responsible for both device-specific things and
generic PCI things:

  agp_via_suspend
    pci_save_state(pdev)                <-- generic PCI
    pci_set_power_state(pdev, pci_choose_state(pdev, state)) <-- generic PCI

  agp_via_resume
    pci_set_power_state(pdev, PCI_D0)   <-- generic PCI
    pci_restore_state(pdev)             <-- generic PCI
    via_configure_agp3()                <-- device-specific
    via_configure()                     <-- device-specific

With generic power management, the PCI bus PM methods do the generic PCI
things, and the driver needs only the device-specific part, i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                    # PCI bus .suspend() method
        agp_via_suspend                 <-- not needed at all; removed
    suspend_enter
      dpm_suspend_noirq(PMSG_SUSPEND)
        pci_pm_suspend_noirq            # PCI bus .suspend_noirq() method
          pci_save_state                <-- generic PCI
          pci_prepare_to_sleep          <-- generic PCI
            pci_set_power_state
    ...
    dpm_resume_end(PMSG_RESUME)
      pci_pm_resume                     # PCI bus .resume() method
        pci_restore_standard_config
          pci_set_power_state(PCI_D0)   <-- generic PCI
          pci_restore_state             <-- generic PCI
        agp_via_resume                  # dev->driver->pm->resume
          via_configure_agp3()          <-- device-specific
          via_configure()               <-- device-specific

[bhelgaas: commit log]
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/via-agp.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a044570..a460ae352772 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -492,22 +492,11 @@ static void agp_via_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_via_suspend NULL
 
-static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_via_resume(struct device *dev)
 {
-	pci_save_state (pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
-
-	return 0;
-}
-
-static int agp_via_resume(struct pci_dev *pdev)
-{
-	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
-
-	pci_set_power_state (pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct agp_bridge_data *bridge = dev_get_drvdata(dev);
 
 	if (bridge->driver == &via_agp3_driver)
 		return via_configure_agp3();
@@ -517,8 +506,6 @@ static int agp_via_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif /* CONFIG_PM */
-
 /* must be the same order as name table above */
 static const struct pci_device_id agp_via_pci_table[] = {
 #define ID(x) \
@@ -567,16 +554,14 @@ static const struct pci_device_id agp_via_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_via_pm_ops, agp_via_suspend, agp_via_resume);
 
 static struct pci_driver agp_via_pci_driver = {
 	.name		= "agpgart-via",
 	.id_table	= agp_via_pci_table,
 	.probe		= agp_via_probe,
 	.remove		= agp_via_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_via_suspend,
-	.resume		= agp_via_resume,
-#endif
+	.driver.pm      = &agp_via_pm_ops,
 };
 
 
-- 
2.25.1

