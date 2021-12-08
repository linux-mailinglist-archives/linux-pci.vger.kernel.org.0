Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0303F46DC54
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhLHThC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:37:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbhLHTg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:36:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F389B82278;
        Wed,  8 Dec 2021 19:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840BBC341C7;
        Wed,  8 Dec 2021 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638992003;
        bh=XgKW2vyyZYQGYzni3fp78p+14knK06px3dtohloRSvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8xg3Agj7uVxGxstd+276zCF9GIF2onW0E2QI9/39s0fk+/anfRptBTMgxna4gNuD
         X17t1v17sl7pPDH+8eR2B49t0POMpbIaS/0SPJu+TbGnqEHt3XfIK91zKJKeK7hrfR
         38CpsuMXP+K8Nx8a2HStHIvOcutN3KNEei8ixn727BSjKTyxaGbvC0l2BdVir1ISnO
         ok37koTw7US1YQznUmX01kmQS5psP+x+P0C75+1etJYC0NrZRmWq7RwMsh3a0GfyVd
         nbe/CZz8WPwIAn8arv18CTC5Ec9lMmuakk3GSnqO8XWI5U83J+8V4LuO+je2mLteb0
         hb2Sw++Aa05Kw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/3] sis-agp: convert to generic power management
Date:   Wed,  8 Dec 2021 13:33:04 -0600
Message-Id: <20211208193305.147072-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208193305.147072-1-helgaas@kernel.org>
References: <20211208193305.147072-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert sis-agp from legacy PCI power management to the generic power
management framework.

Previously, sis-agp used legacy PCI power management, and agp_sis_suspend()
and agp_sis_resume() were responsible for both device-specific things and
generic PCI things:

  agp_sis_suspend
    pci_save_state(pdev)                <-- generic PCI
    pci_set_power_state(pdev, pci_choose_state(pdev, state)) <-- generic PCI

  agp_sis_resume
    pci_set_power_state(pdev, PCI_D0)   <-- generic PCI
    pci_restore_state(pdev)             <-- generic PCI
    sis_driver.configure()              <-- device-specific

With generic power management, the PCI bus PM methods do the generic PCI
things, and the driver needs only the device-specific part, i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                    # PCI bus .suspend() method
        agp_sis_suspend                 <-- not needed at all; removed
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
        agp_sis_resume                  # dev->driver->pm->resume
          sis_driver.configure()        <-- device-specific

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

