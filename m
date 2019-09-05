Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8AA99A1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 06:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfIEEcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 00:32:17 -0400
Received: from alpha.anastas.io ([104.248.188.109]:43491 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfIEEcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 00:32:17 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 00:32:17 EDT
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 7047184B9D;
        Wed,  4 Sep 2019 23:22:38 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567657359; bh=EmICgee2nNUFVTp9r6uhX6GMoMfnTqEaFNlse3ssPuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWXbsz+qQlJDwPgeEAudXQxT2TUqfzpY3dno5FjhVl+ySQe2k4YPNyAJiizFaGOW8
         30eusimYMGDWVV7N5VurXjBJTEyl9yrF8DKNx07OkJqUG2CdXRF3XRiveqkvL/Agu/
         R6S4+HhElHqIKVI/so6TWwk0f1gVazk4YZXazlJ55PF1irrgDOBWGOUXfsQIvvVwHJ
         7j3xsXfcQuaVRbQMPLQRFFCKtF3+qi+oI/7z5Fdxia2KRbzsq1y0cm4CcmwenSb1pV
         4P4WG4fVojFNGuUYaAN1N+DR6BxczBQEEjiY2rmffJyPKAxGrybqVtkVYodtVYRY/i
         SAbsgciFBr2aA==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: [PATCH 2/2] powerpc/pci: Fix IOMMU setup for hotplugged devices on pseries
Date:   Wed,  4 Sep 2019 23:22:15 -0500
Message-Id: <20190905042215.3974-3-shawn@anastas.io>
In-Reply-To: <20190905042215.3974-1-shawn@anastas.io>
References: <20190905042215.3974-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move PCI device setup from pcibios_add_device() to pcibios_fixup_dev().
This ensures that platform-specific DMA and IOMMU setup occurs after the
device has been registered in sysfs, which is a requirement for IOMMU group
assignment to work.

This fixes IOMMU group assignment for hotplugged devices on pseries, where
the existing behavior results in IOMMU assignment before registration.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/kernel/pci-common.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f627e15bb43c..21b4761bb0ed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -987,15 +987,14 @@ static void pcibios_setup_device(struct pci_dev *dev)
 		ppc_md.pci_irq_fixup(dev);
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+void pcibios_fixup_dev(struct pci_dev *dev)
 {
-	/*
-	 * We can only call pcibios_setup_device() after bus setup is complete,
-	 * since some of the platform specific DMA setup code depends on it.
-	 */
-	if (dev->bus->is_added)
-		pcibios_setup_device(dev);
+	/* Device is registered in sysfs and ready to be set up */
+	pcibios_setup_device(dev);
+}
 
+int pcibios_add_device(struct pci_dev *dev)
+{
 #ifdef CONFIG_PCI_IOV
 	if (ppc_md.pcibios_fixup_sriov)
 		ppc_md.pcibios_fixup_sriov(dev);
-- 
2.20.1

