Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D204A5435
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 01:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiBAAkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 19:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiBAAkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 19:40:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE2C061714;
        Mon, 31 Jan 2022 16:40:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f17so28724185wrx.1;
        Mon, 31 Jan 2022 16:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=7b37+sb97Re3oAWrsxv3q1g8yG0f6pamguZVF07b8vM=;
        b=gvKPj5ggc5CJwxMCJl72etucJT8QAoxnd62+g9Zan2I+7VBRYDIVs1Sa5CDdxBZoJw
         HWIfz3n1t3ZsWBEdV5d6/QGflCgRcqckFAI1f1H6dKI77cOwKrZmvmfNvJWXIPdnQ2vO
         BBGjVPfLdH+IO4/ZBxAV/e2Yad0SeGvAVc9Q/1XfKJAyTxCUJBFqJkbQphI8xAPe0ISv
         BxaVy4V0+GCvD+0ZHtkWMB0uLOu6Vhcs5TDf07vnweE99b5AlEhvogO5St1dyHaAby6S
         gTWmj0KUc4oUQhV72OAnAOrCmh84PS4k4DKxbQqzsXbB/mBlwNgFv93enOM+j6780Lde
         yWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=7b37+sb97Re3oAWrsxv3q1g8yG0f6pamguZVF07b8vM=;
        b=ZefCCKD/4CbdmPlq62OO3uKq/uECY/4x1Sk3FGBoSKCfrmPVLwSIzVa4Brmy3LsJoA
         33SBGug2occZuy0zdVMznMe28a8LaniAvuTlBxkqphvQN7MRdmpabGJsxoNuNLcCyWBx
         JsGgQFjekwNtTAOlk6ZdunNF/ozewCpK1RegsUuB/WzpJZcgjZA/ExwNxgi0OhTQ1YLW
         Px7yaC5rtSItc+jN1Fsr52aqyzPLp+PDVtkCKTxJfKrnt2FYZi+rS6QucDD/L3O/ghQN
         fluBxY3t5s/a37vYDd2J+7DpMZLyypxRdkwSsuXuKC0TZUB/P/GzT9I5BJ+wsq594ChS
         Kx3Q==
X-Gm-Message-State: AOAM531LmEU+dVdSxqLqqHkTlCBooPGGi9KMbeyQBUFplaY4YYELfXFa
        AJfePLHMyNJvAoh+hp5CMhg=
X-Google-Smtp-Source: ABdhPJzIYdNZ5LhKCEQJ5TRnxRwbUHbNuVeBbSi1uN4zCq7ZfmulED/bq5T7i6rhPPVbUX2vKOsh0Q==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr19684978wrv.293.1643676029669;
        Mon, 31 Jan 2022 16:40:29 -0800 (PST)
Received: from jupiter.dyndns.org (cpc69401-oxfd27-2-0-cust150.4-3.cable.virginm.net. [82.14.184.151])
        by smtp.gmail.com with ESMTPSA id o8sm599148wmc.46.2022.01.31.16.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:40:29 -0800 (PST)
Sender: Brent Spillner <spillner@gmail.com>
Date:   Tue, 1 Feb 2022 00:40:29 +0000
From:   Brent Spillner <spillner@acm.org>
To:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/PCI: Improve log message when IRQ cannot be identified
Message-ID: <YfiBfdAf9uHYTf4T@jupiter.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing code always suggests trying the pci=biosirq kernel parameter, but
this option is only recognized when CONFIG_PCI_BIOS is set, which in turn
depends on CONFIG_X86_32, so it is never appropriate on x86_64.
kernel-parameters.txt confirms that pci=biosirq is intended to be supported
only on X86-32.

The new version tries to be more helpful by recommending changes to ACPI
settings if appropriate, and only mentioning pci=biosirq (and the manual
pirq= option) for kernels that support it. Additionally, it encourages
the user to file bug reports so faulty firmware can be identified and
potentially handled via known quirks in a future kernel release.

ACPI is relevant to these warnings because it will significantly change
the path taken through the PCI discovery (and later interrupt routing)
code. Booting with acpi=noirq should be highly unusual and likely
indicates an attempt to work around faulty motherboard firmware, so I
added a new log message in pci_acpi_init() for this case, with yet
another recommendation to file a bug report.

Signed-off-by: Brent Spillner <spillner@acm.org>
---
Changes in v2:
 - Tried to make the code more legible by reducing use of #ifdef (only
   used where required to guard reference to acpi_noirq)
 - The tradeoff is there's now an idiosyncratic use of do {...} while (0),
   but that lets me early-out from the acpi_noirq case without more #ifdefs
   or duplicated if statements.
 - Included a warning for acpi_noirq in pci_acpi_init() per maintainer suggestion
 - Encourage user to file bug reports in all warning messages

 arch/x86/pci/acpi.c |  4 +++-
 arch/x86/pci/irq.c  | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 052f1d78a562..12f894d345a9 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -401,8 +401,10 @@ int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
 
-	if (acpi_noirq)
+	if (acpi_noirq) {
+		printk(KERN_WARNING "PCI: ACPI IRQ routing disabled; please submit a bug report if this was required to work around firmware defects\n");
 		return -ENODEV;
+	}
 
 	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 	acpi_irq_penalty_init();
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 97b63e35e152..393b036e773b 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1519,10 +1519,26 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			} else
 				msg = "; probably buggy MP table";
 #endif
-		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+		} else if (pci_probe & PCI_BIOS_IRQ_SCAN) {
 			msg = "";
-		else
-			msg = "; please try using pci=biosirq";
+		} else {
+			do {	/* just one iteration; allows break to minimize code duplication */
+#ifdef CONFIG_ACPI
+				if (acpi_noirq) {
+				    msg = "; consider removing acpi=noirq, and file a bug report if that does not help";
+					break;		/* out of remainder of one-iteration do {} loop */
+				}
+#endif
+				if (IS_ENABLED(CONFIG_PCI_BIOS))
+					/* pci=biosirq and pirq= are valid only on x86_32, and should never be necessary */
+					msg = "; try using pci=biosirq or manual pirq=, and file a bug report for this device";
+				else if (!IS_ENABLED(CONFIG_ACPI))
+					/* ACPI will change code path through PCI subsystem, and is worth trying */
+					msg = "; try enabling ACPI if feasible, and file a bug report for this device";
+				else
+					msg = "; please file a bug report for failure to discover device IRQ via ACPI";
+			} while (0);
+		}
 
 		/*
 		 * With IDE legacy devices the IRQ lookup failure is not
-- 
2.35.1

