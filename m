Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839ED28CD1A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgJML4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgJML4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2020 07:56:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B8C0613D0;
        Tue, 13 Oct 2020 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0ogLBIlUVV0CdjypROGeu7AwfcIja0K5SScq0Xwq2M=; b=J2JcvL/9JKUWD4xXGI6c4tpQrz
        Avqawykjj1JhP+KCdPkiLORxjpowmRlzbufq8PWMMVYwLff/gIHYShdK9xJE2fJkL9Gc72bT+GtvT
        +KioDU3FFMWcVkP+8ebCNJLszUYEady/KF1g9IE4tw47r7+w/JZe1Sj+ldJ3CS8O7WR7NY85kxcqL
        LQ6e47n1GPNOUSB26jyBfm+DxJEVoFygYQ7a7MpBtp3wNJVthZHajNc3E3g27I7/kpq6MeKf+VZ0P
        2zA+Q2Fl5UdIrN9ApaZCu/hSxSM4cW14pGtlAn4uNZmXBwYUANBZm9e9TnUJKMD7rlzhyMiQ3Hl7S
        Un/J/ihQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSIuP-0003TM-2b; Tue, 13 Oct 2020 11:56:01 +0000
Date:   Tue, 13 Oct 2020 12:56:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.nkuppuswamy@gmail.com
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
Message-ID: <20201013115600.GA11976@infradead.org>
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

You might want to split out pcie_do_fatal_recovery and get rid of the
state argument:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a095..eec0d3fe9fd967 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -556,7 +556,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
+			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457ac0..4bf7ebb34cf854 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -947,9 +947,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		if (pcie_aer_is_native(dev))
 			pcie_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
+		pcie_do_recovery(dev, aer_root_reset);
 	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+		pcie_do_fatal_recovery(dev, aer_root_reset);
 	pci_dev_put(dev);
 }
 
@@ -985,11 +985,9 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
+			pcie_do_recovery(pdev, aer_root_reset);
 		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+			pcie_do_fatal_recovery(pdev, aer_root_reset);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index daa9a4153776ce..74e7d1da3cf054 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -233,7 +233,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
+	pcie_do_fatal_recovery(pdev, dpc_reset_link);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97ad0..87379bc566f691 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -183,7 +183,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 * or ERR_NONFATAL, since the link is already down, use the FATAL
 	 * error recovery path for both cases.
 	 */
-	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
+	estate = pcie_do_fatal_recovery(edev, dpc_reset_link);
 
 send_ost:
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c2ae4d08801a4d..11fcff16b17303 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -141,7 +141,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
+pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	struct pci_dev *udev;
@@ -194,15 +194,11 @@ static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
 
-	if (state == pci_channel_io_frozen)
-		return pcie_do_fatal_recovery(dev, reset_link);
-
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
 	 * If the downstream port detected the error, it is cleared at the end.
