Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9646464520
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbhLAC5z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 21:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbhLAC5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 21:57:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516CC06174A;
        Tue, 30 Nov 2021 18:54:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F17CDCE1759;
        Wed,  1 Dec 2021 02:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C992C53FC7;
        Wed,  1 Dec 2021 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638327268;
        bh=dvZcBCOO3kK40wuUuAubrhwy3njIEl4xYCrgjYTfBIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWjvklpoAs0/T2VrbflU7VrlwCYRznKQrkboHoIyttkIwrx/+nmRzdgmHN6rs8F/N
         2IlHszKLRYTnmrR5rnlEvDaoGn4CDSJl3K0/mY840wlpCOKAkVKlkglkP9TvzKLhs5
         Z1sNnxiMdJgVb2VslgocjBWY8n3e+jR4hWJy0tkGMTkrC1kf51XNroz/WYNFZcKCtt
         MlqOYyPScGtTiSPboI9zecn2A1NrWNrOV3etZJ21sUZbRw8uhGQd1unnI1Cjpk2Rk5
         VtpSZVf5D/5PFX99Qm1Nit4/o56ZHlZLHyv3A09k/pSB8nJVGUtnEuAZaoVBDaWIoi
         IcCBVqsKydczw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/3] amd64-agp: convert to generic power management
Date:   Tue, 30 Nov 2021 20:54:17 -0600
Message-Id: <20211201025419.2797624-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201025419.2797624-1-helgaas@kernel.org>
References: <20211201025419.2797624-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert amd64-agp from legacy PCI power management to the generic power
management framework.

Previously, amd64-agp used legacy PCI power management.
agp_amd64_suspend() looked like this:

  agp_amd64_suspend
    pci_save_state(pdev)
    pci_set_power_state(pdev, pci_choose_state(pdev, state))

With generic power management, these are both done by the PCI core in
pci_pm_runtime_suspend(), so drop agp_amd64_suspend() completely.

agp_amd64_resume() looked like this:

  agp_amd64_resume
    pci_set_power_state(pdev, PCI_D0)
    pci_restore_state(pdev)
    ...

With generic power management, the PCI parts are done by
pci_pm_runtime_resume(), so drop those from agp_amd64_resume().

[bhelgaas: commit log]
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae32817..dc78a4fb879e 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -588,20 +588,11 @@ static void agp_amd64_remove(struct pci_dev *pdev)
 	agp_bridges_found--;
 }
 
-#ifdef CONFIG_PM
+#define agp_amd64_suspend NULL
 
-static int agp_amd64_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_amd64_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_amd64_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA)
 		nforce3_agp_init(pdev);
@@ -609,8 +600,6 @@ static int agp_amd64_resume(struct pci_dev *pdev)
 	return amd_8151_configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_amd64_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -738,15 +727,14 @@ static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, agp_amd64_suspend, agp_amd64_resume);
+
 static struct pci_driver agp_amd64_pci_driver = {
 	.name		= "agpgart-amd64",
 	.id_table	= agp_amd64_pci_table,
 	.probe		= agp_amd64_probe,
 	.remove		= agp_amd64_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_amd64_suspend,
-	.resume		= agp_amd64_resume,
-#endif
+	.driver.pm  = &agp_amd64_pm_ops,
 };
 
 
-- 
2.25.1

