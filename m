Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5427B1F36EA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgFIJTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:19:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:4903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFIJTP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:19:15 -0400
IronPort-SDR: XsDo5P/Co/74B7/Ic7s4204uum73imScqId6rP9CJPjHkIeFUAEn6Y1TglNGpKYcvWxVViZETI
 48oSY5c67yUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:19:15 -0700
IronPort-SDR: 15YJQR1U+wZ/oPcTRvFeV+F+/MC0LmREO3KWkdSokSXsxbiOfh1Ct+DDy/fBpHuEvWraUhYWb1
 f0tRbv+dEWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="295775697"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2020 02:19:13 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] vmw_vmci: Use PCI_IRQ_ALL_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:19:10 +0200
Message-Id: <20200609091911.1517-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..ea300573f652 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -584,8 +584,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	error = pci_alloc_irq_vectors(pdev, VMCI_MAX_INTRS, VMCI_MAX_INTRS,
 			PCI_IRQ_MSIX);
 	if (error < 0) {
-		error = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+		error = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 		if (error < 0)
 			goto err_remove_bitmap;
 	} else {
-- 
2.17.2

