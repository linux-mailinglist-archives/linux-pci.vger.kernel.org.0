Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661D3464524
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 03:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbhLAC55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 21:57:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35590 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbhLAC5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 21:57:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54CA0B81DD4;
        Wed,  1 Dec 2021 02:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BBBC53FCB;
        Wed,  1 Dec 2021 02:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638327273;
        bh=HX8RCwdqu/46D2qyz9bpRkRtDZWJITkdfTUGokM+JjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXes2SJReN5hqMLFOqRQLM6srx44ZPKmw+xkKXEr1hjGrSpX1WFqZmvbqqrFdvY4J
         02EQ/vSAu/ak1n0c+ebhnoMLoHV66nyg6NH4lDwI8n/YrcgTy7JcauC3UGMrTuKtcZ
         JkZLGAaJGoC2d38+ORhuMfgrJTVM5kds3xV4hHoPbY7IuB4603DMke7jDvJOUBsLg6
         ShsUGefIdP88a13c7d99iV91BJyXyoAB0mRVGG63rOaR5lAKasoFJbH596GLRIvy7Y
         HrNTDfAC2zlQn+zGkAFFUliySqodcRKKDLMPgU1Q8uqWwnUYdtH7qpNVk6xpy2KHOY
         XFXMx9IIC2VEQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/3] via-agp: convert to generic power management
Date:   Tue, 30 Nov 2021 20:54:19 -0600
Message-Id: <20211201025419.2797624-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201025419.2797624-1-helgaas@kernel.org>
References: <20211201025419.2797624-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert via-agp from legacy PCI power management to the generic power
management framework.

Previously, via-agp used legacy PCI power management.  agp_via_suspend()
looked like this:

  agp_via_suspend
    pci_save_state(pdev)
    pci_set_power_state(pdev, pci_choose_state(pdev, state))

With generic power management, these are both done by the PCI core in
pci_pm_runtime_suspend(), so drop agp_via_suspend() completely.

agp_via_resume() looked like this:

  agp_via_resume
    pci_set_power_state(pdev, PCI_D0)
    pci_restore_state(pdev)
    ...

With generic power management, the PCI parts are done by
pci_pm_runtime_resume(), so drop those from agp_via_resume().

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

