Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFF24BDCA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHTNNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgHTNNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 09:13:23 -0400
X-Greylist: delayed 1176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Aug 2020 06:13:22 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393AC061386
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2020 06:13:21 -0700 (PDT)
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1k8k4J-0002dR-Q1; Thu, 20 Aug 2020 14:53:25 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1k8k4J-0002ba-9U; Thu, 20 Aug 2020 14:53:23 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Thu, 20 Aug 2020 14:53:20 +0200
Message-Id: <20200820125320.9967-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:8245:f980::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=ro en fr
Subject: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Not that x86 without ACPI sees any real use...

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
Found by randconfig builds.

 arch/x86/pci/intel_mid_pci.c | 2 ++
 arch/x86/pci/xen.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 00c62115f39c..f14a911f0d06 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -299,8 +299,10 @@ int __init intel_mid_pci_init(void)
 	pcibios_disable_irq = intel_mid_pci_irq_disable;
 	pci_root_ops = intel_mid_pci_ops;
 	pci_soc_mode = 1;
+#ifdef CONFIG_ACPI
 	/* Continue with standard init */
 	acpi_noirq_set();
+#endif
 	return 1;
 }
 
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 9f9aad42ccff..681eb5c34c03 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -406,8 +406,10 @@ int __init pci_xen_init(void)
 	pcibios_enable_irq = xen_pcifront_enable_irq;
 	pcibios_disable_irq = NULL;
 
+#ifdef CONFIG_ACPI
 	/* Keep ACPI out of the picture */
 	acpi_noirq_set();
+#endif
 
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-- 
2.28.0

