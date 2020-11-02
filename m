Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97A2A2BA9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKBNhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 08:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBNhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 08:37:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B4C0617A6;
        Mon,  2 Nov 2020 05:37:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gn41so1620515ejc.4;
        Mon, 02 Nov 2020 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV0w8mEDkNAO6uiQf4/TZpEA5d4wbVYY+OmguRSwOE8=;
        b=UZbZA608GbIsNV3azDV6u3iFKlQRgFBDJvNdTRceKDcZH8YePrGwoVg/mRvk/Kgwrb
         bEBbqlC27geUxzLgR8XAlMuzKcbOg5AUo1W+otz+yIaeqrgmqYB/sPVk6KqW49IW1Y/1
         eKjCAa+dG+AetAMtMT5dU3RJsJNLI+K8AhR/eTHY3BCp2Eaw8ze4npH/kdiMIKKcMLQ5
         GumZ8G0WnEHXSyEJ4fRR+YL/6dM8Li2AkgTH9ypx2zs45XY8T+v2nWsFmZ33SviVJPwk
         M2M1LKZLN5hY3xgXqGBCh2VSyp67DYE2cCksSfCuR9WgF88rGEM7FNAcfU2v+0R2x11H
         8cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV0w8mEDkNAO6uiQf4/TZpEA5d4wbVYY+OmguRSwOE8=;
        b=NnLUy5mIkYd3P8TmGHalf1riPINCfpjNmStll1RZx1QAGCYcqxUnh/G+0DKdnst3Ne
         MqWq5nAJJNn+XgW03F09Np4gOsC/iZbd533XTmE7sGWe6+vf+sQFx3WnhIHpCyF2CDuV
         QvRxVarsJiEsUVV6ufKUvqAeQWRz+T8eh5LZjioOS5ppOxQWoPntkHPBy1+hBm1iISGq
         /WTDGo3qwGm9LtFCtTAN5RD9/cB7Ee9UZVcPuTSItel14zsiwMnMM1GuTr2LvYwcOZ9u
         /7V7B722anZLTd5T/kQYQJ19DQvz/NqXK35I2N7L+RLxIVMiToJFuPKJtzDBTWMOpdww
         lKGw==
X-Gm-Message-State: AOAM5326zMx5WrWVx3mkJfQT7dURTx/g6dCu1kJpKOY6JjDBJVYw2tKU
        VcPnmSK2ac0YOX3VTaPFAvj8dV6d/UE=
X-Google-Smtp-Source: ABdhPJyNaaIlTf20F1tQ1eKRXUELesYB8KLK9pvJdtUhr5eMa2tr28eLVll3mHclHq2IiX4HvRlQpQ==
X-Received: by 2002:a17:906:2a09:: with SMTP id j9mr15063534eje.355.1604324229295;
        Mon, 02 Nov 2020 05:37:09 -0800 (PST)
Received: from xws.fritz.box (pd9e5a73b.dip0.t-ipconnect.de. [217.229.167.59])
        by smtp.gmail.com with ESMTPSA id p17sm10642538edw.10.2020.11.02.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:37:08 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] ACPI: Remove trailing whitespace
Date:   Mon,  2 Nov 2020 14:36:41 +0100
Message-Id: <20201102133641.474413-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove trailing whitespace and fix some whitespace inconsitencies while
at it.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/acpi/pci_irq.c           |  2 +-
 drivers/acpi/pci_link.c          | 12 ++++++------
 drivers/acpi/power.c             |  4 ++--
 drivers/acpi/processor_perflib.c |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index dea8a60e18a4..14ee631cb7cf 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -175,7 +175,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
 	 * configure the IRQ assigned to this slot|dev|pin.  The 'source_index'
 	 * indicates which resource descriptor in the resource template (of
 	 * the link device) this interrupt is allocated from.
-	 * 
+	 *
 	 * NOTE: Don't query the Link Device for IRQ information at this time
 	 *       because Link Device enumeration may not have occurred yet
 	 *       (e.g. exists somewhere 'below' this _PRT entry in the ACPI
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 606da5d77ad3..fb4c5632a232 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -6,8 +6,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
  *
- * TBD: 
- *      1. Support more than one IRQ resource entry per link device (index).
+ * TBD:
+ *	1. Support more than one IRQ resource entry per link device (index).
  *	2. Implement start/stop mechanism and use ACPI Bus Driver facilities
  *	   for IRQ management (e.g. start()->_SRS).
  */
@@ -249,8 +249,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 		}
 	}
 
-	/* 
-	 * Query and parse _CRS to get the current IRQ assignment. 
+	/*
+	 * Query and parse _CRS to get the current IRQ assignment.
 	 */
 
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
@@ -396,7 +396,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 /*
  * "acpi_irq_balance" (default in APIC mode) enables ACPI to use PIC Interrupt
  * Link Devices to move the PIRQs around to minimize sharing.
- * 
+ *
  * "acpi_irq_nobalance" (default in PIC mode) tells ACPI not to move any PIC IRQs
  * that the BIOS has already set to active.  This is necessary because
  * ACPI has no automatic means of knowing what ISA IRQs are used.  Note that
@@ -414,7 +414,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  *
  * Note that PCI IRQ routers have a list of possible IRQs,
  * which may not include the IRQs this table says are available.
- * 
+ *
  * Since this heuristic can't tell the difference between a link
  * that no device will attach to, vs. a link which may be shared
  * by multiple active devices -- it is not optimal.
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 837b875d075e..9c4c3196cb07 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -13,7 +13,7 @@
  * 1. via "Device Specific (D-State) Control"
  * 2. via "Power Resource Control".
  * The code below deals with ACPI Power Resources control.
- * 
+ *
  * An ACPI "power resource object" represents a software controllable power
  * plane, clock plane, or other resource depended on by a device.
  *
@@ -690,7 +690,7 @@ int acpi_device_sleep_wake(struct acpi_device *dev,
 
 /*
  * Prepare a wakeup device, two steps (Ref ACPI 2.0:P229):
- * 1. Power on the power resources required for the wakeup device 
+ * 1. Power on the power resources required for the wakeup device
  * 2. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
  *    State Wake) for the device, if present
  */
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8fa4013..f00e66de6c53 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -627,7 +627,7 @@ int acpi_processor_preregister_performance(
 		goto err_ret;
 
 	/*
-	 * Now that we have _PSD data from all CPUs, lets setup P-state 
+	 * Now that we have _PSD data from all CPUs, lets setup P-state
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
@@ -693,7 +693,7 @@ int acpi_processor_preregister_performance(
 			if (match_pdomain->domain != pdomain->domain)
 				continue;
 
-			match_pr->performance->shared_type = 
+			match_pr->performance->shared_type =
 					pr->performance->shared_type;
 			cpumask_copy(match_pr->performance->shared_cpu_map,
 				     pr->performance->shared_cpu_map);
-- 
2.29.2

