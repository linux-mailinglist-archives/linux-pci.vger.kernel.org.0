Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C7231469
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgG1VDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1VDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 17:03:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B3C061794
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 14:03:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so22096633eje.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n8YTO6ok7dPJgRuGdy+eI17ddoVzqij6w23JGhuwc9Y=;
        b=uxxNN0ngiJfxG2l2S3hUbKPcJmAxqWUhIBMwpoza7u+6m8gF7/jl4Cc1Qc9zRHvrsv
         8jCnSMebmXXwy3nuO9uT5RHk3a2BlO2qZiUWsZopOj+nQO2ElBzaTeydKO284pxwDy8a
         zNz1MhhMHv/GkoenVMNC+Ki+q3uuD3o8l5TfTcU04kCHJ3q4LgxMFwu0ArC/QB7wsvd/
         D/55BlVfzSEevhD7kjFD7299cS7OjpwAyFUV2gawQ78z8WT6Q3tp2ESzyfFDVi2AyBfp
         P+55aM4vmBRRJWfl/xJavqIEWB+I97RLvVYLIwAFhKKlPfd4ukwg/kGiKwibuVw/TWpR
         IoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n8YTO6ok7dPJgRuGdy+eI17ddoVzqij6w23JGhuwc9Y=;
        b=KwgrvIlOW6fLod7vhn1beTG932E+pbfap9ETmS6Izb2qlhpE/UHK7wpSbns27m+AIA
         xt52RMp2SElEVeepTvlUKVS7g3nEW0YaGnLNYE6dYkJHXrqOeXZY8TfYotHQUm9ciSel
         STvm9tfIRBBWby/io4fCWkdX7QhsOuXh8PkSDYMXKk0LLXeeJX49sih5/VsSSnsCh+ro
         /1HkRwcn0r8lft0ZSRE2LhcsqqdEsj2LUueoy8hxaxBp6gGAb6zxD/1HMw7Z0csxAPAc
         TGIsB6MDagox3W/2+ua6rLCEk0yh7pYdkPCjrFNWFb58fEfUxt8vM6aX4Z0m6M3rkgle
         9NjQ==
X-Gm-Message-State: AOAM533IhpQ2P9Z74UgDuUe0OSEhVEaAMozy6a1M/cPjDsJ5u7yAyf1k
        e7CHveGanN++h30cEN14LRHjRzywXJo=
X-Google-Smtp-Source: ABdhPJx3It/5GgAHK2xVKRw4pc7MXZXRFeC08suG5CGm6KZD6R6e6jxdgzNj9Eu2CrtVqhGn2zszNQ==
X-Received: by 2002:a17:906:8782:: with SMTP id za2mr24557928ejb.419.1595970228988;
        Tue, 28 Jul 2020 14:03:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:908b:a51b:1175:f3b2? (p200300ea8f235700908ba51b1175f3b2.dip0.t-ipconnect.de. [2003:ea:8f23:5700:908b:a51b:1175:f3b2])
        by smtp.googlemail.com with ESMTPSA id n2sm60992edq.73.2020.07.28.14.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 14:03:48 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Remove pci_lost_interrupt
Message-ID: <e328d059-3068-6a40-28df-f81f616d15a0@gmail.com>
Date:   Tue, 28 Jul 2020 23:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

388c8c16abaf ("PCI: add routines for debugging and handling lost
interrupts") added pci_lost_interrupt() that apparently never has
had a single user. So remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/irq.c   | 50 ---------------------------------------------
 include/linux/pci.h |  7 -------
 2 files changed, 57 deletions(-)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index a1de501a2..12ecd0aaa 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -6,61 +6,11 @@
  * Copyright (C) 2017 Christoph Hellwig.
  */
 
-#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 
-static void pci_note_irq_problem(struct pci_dev *pdev, const char *reason)
-{
-	struct pci_dev *parent = to_pci_dev(pdev->dev.parent);
-
-	pci_err(pdev, "Potentially misrouted IRQ (Bridge %s %04x:%04x)\n",
-		dev_name(&parent->dev), parent->vendor, parent->device);
-	pci_err(pdev, "%s\n", reason);
-	pci_err(pdev, "Please report to linux-kernel@vger.kernel.org\n");
-	WARN_ON(1);
-}
-
-/**
- * pci_lost_interrupt - reports a lost PCI interrupt
- * @pdev:	device whose interrupt is lost
- *
- * The primary function of this routine is to report a lost interrupt
- * in a standard way which users can recognise (instead of blaming the
- * driver).
- *
- * Returns:
- * a suggestion for fixing it (although the driver is not required to
- * act on this).
- */
-enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *pdev)
-{
-	if (pdev->msi_enabled || pdev->msix_enabled) {
-		enum pci_lost_interrupt_reason ret;
-
-		if (pdev->msix_enabled) {
-			pci_note_irq_problem(pdev, "MSIX routing failure");
-			ret = PCI_LOST_IRQ_DISABLE_MSIX;
-		} else {
-			pci_note_irq_problem(pdev, "MSI routing failure");
-			ret = PCI_LOST_IRQ_DISABLE_MSI;
-		}
-		return ret;
-	}
-#ifdef CONFIG_ACPI
-	if (!(acpi_disabled || acpi_noirq)) {
-		pci_note_irq_problem(pdev, "Potential ACPI misrouting please reboot with acpi=noirq");
-		/* currently no way to fix acpi on the fly */
-		return PCI_LOST_IRQ_DISABLE_ACPI;
-	}
-#endif
-	pci_note_irq_problem(pdev, "unknown cause (not MSI or ACPI)");
-	return PCI_LOST_IRQ_NO_INFORMATION;
-}
-EXPORT_SYMBOL(pci_lost_interrupt);
-
 /**
  * pci_request_irq - allocate an interrupt line for a PCI device
  * @dev:	PCI device to operate on
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2a2d00e9d..814d652f2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1053,13 +1053,6 @@ void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
-enum pci_lost_interrupt_reason {
-	PCI_LOST_IRQ_NO_INFORMATION = 0,
-	PCI_LOST_IRQ_DISABLE_MSI,
-	PCI_LOST_IRQ_DISABLE_MSIX,
-	PCI_LOST_IRQ_DISABLE_ACPI,
-};
-enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
 int pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
-- 
2.27.0

