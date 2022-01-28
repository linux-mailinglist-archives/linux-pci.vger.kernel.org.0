Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3AA49FFAC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiA1RhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiA1RhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 12:37:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFDC061714;
        Fri, 28 Jan 2022 09:37:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m14so12009381wrg.12;
        Fri, 28 Jan 2022 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=NlfUGJI0+1YpxGmrw2B+G4W+F0clMFCP86GadVW6dv8=;
        b=jYX8+UgHM64f/dvAf0KYmoqsFA89aRKPDUfqqbWgzqJR8Iz50n2h8tV5xRweAg8YHI
         gtNiZrTjyxZKuKjGL3o7fUt8Um+8N2XqVRqMUDXerDnJS5QewKV3FnALDwQG9/yDspaZ
         N5Qv2dEGOw7tSQ9vc0sJNY7tOm/PjeNtM4ULiwaohlfcbWYMj//rtqRz4Zh0K5oUj2t/
         BtTXM4W1Fa7+136kYfWfuzwRCsMjliKAbHdkgSs0XjkrwskDc0aAp6lz/DmMO7yvAuZw
         hcVvxm5owYK+Z3CoLkkDuuIwNkD9JwM1lYSP+QcKtDWEIz+DopgOMHrYFDcLhkB/Q4K0
         rSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=NlfUGJI0+1YpxGmrw2B+G4W+F0clMFCP86GadVW6dv8=;
        b=29bcEEea9ufTkZrMha9fnZh1qFjZOdterzhgIq5O5o+IXaDBrelAYbCZdf6DLKDVJO
         4BUKnsa0/aBBzuvirIGe0iR/gHrFJgf1ncpHnco9gCpQlVSVv8Y02uiUoUkTF7CHBcgW
         xtomvtLQyBt4haZE3HvaHPKV8IA0O8CFxmG4ONy3D4aO67gt2ZqT1FOfoIN0JzEDCP7m
         LcFI+luxAiewVpZ7oNC/85PjY4wZvngpNPDXlzazlX9nFTta4TEQ3GyJLEGoG8FDhZ/+
         H2AqP9oUdxnwIOYDrGXDCsVFkU/8lFApheq9MLfuPysiEYLxQZZEyFXoyxDNORdD9lQU
         +Q8g==
X-Gm-Message-State: AOAM530rPjy5Di8KmUA64+qgyuVE5F7Zm/a89uPF6bl90yJgFyKT/Ghy
        XpfqIzcgp7OoVlolhDg7XGA=
X-Google-Smtp-Source: ABdhPJwxnkhWr4Yygc6peQZz8IsYK91MheT49I1bxkJzUOtFIO3IFho9/Lpx871N99G8AB5qUaiYzw==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr7776469wrt.547.1643391437278;
        Fri, 28 Jan 2022 09:37:17 -0800 (PST)
Received: from jupiter.dyndns.org (cpc69401-oxfd27-2-0-cust150.4-3.cable.virginm.net. [82.14.184.151])
        by smtp.gmail.com with ESMTPSA id n18sm4941466wrm.47.2022.01.28.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:37:16 -0800 (PST)
Sender: Brent Spillner <spillner@gmail.com>
Date:   Fri, 28 Jan 2022 17:37:15 +0000
From:   Brent Spillner <spillner@acm.org>
To:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch:x86:pci:irq.c: Improve log message when IRQ cannot be
 identified
Message-ID: <YfQpy5yGGqY8T0wW@jupiter.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing code always suggests trying the pci=biosirq kernel
parameter, but this option is only recognized when CONFIG_PCI_BIOS is
set, which in turn depends on CONFIG_X86_32, so it is never appropriate
on x86_64.

The new version tries to form a more useful message when pci=biosirq is
not available, including by suggesting different acpi= options if
appropriate (probably the most common cause of failed IRQ discovery).

See arch/x86/pci/common.c:535 for the interpretation of pci=biosirq, and
arch/x86/Kconfig:2633 for the dependencies of CONFIG_PCI_BIOS.

Signed-off-by: Brent Spillner <spillner@acm.org>
---
 arch/x86/pci/irq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 97b63e35e152..bc4aaaa74832 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1522,7 +1522,21 @@ static int pirq_enable_irq(struct pci_dev *dev)
 		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else
+#ifdef CONFIG_PCI_BIOS
 			msg = "; please try using pci=biosirq";
+#else
+			/* pci=biosirq is not a valid option */
+#ifdef CONFIG_ACPI
+			if (acpi_noirq)
+				msg = "; consider removing acpi=noirq";
+			else
+#endif
+				msg = "; recommend verifying UEFI/BIOS IRQ options"
+#ifndef CONFIG_ACPI
+					" or enabling ACPI"
+#endif
+					;
+#endif
 
 		/*
 		 * With IDE legacy devices the IRQ lookup failure is not
-- 
2.34.1

