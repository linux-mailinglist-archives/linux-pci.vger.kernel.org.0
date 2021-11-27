Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9245FA9A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbhK0Bcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:32:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349571AbhK0Bax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:30:53 -0500
Message-ID: <20211126232735.010399268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mHgTxiBl9Pg381SuWjuguHHZxZ6bDXurYM8uLZLwzPA=;
        b=KlWZS1z9Xb0SPKweT0R7Vrryh/m8++WZ/gB2B+2WgWJEOdQDU/tRWDp/L1WeJlZQfjl5ER
        yyVhFRF79pOgtl0W+NpqlnILXikD8KTYR4S+FpFuxg4cLGPXxd2vh/rViaz3xamSVz8QJy
        JEZrmVKL5YC05xg7JuLEYDIuOOP0JCc/z+5iceQj6QjfQ8asTAVjnV8+7JdoprKABdKx5K
        XR0hWwh2fx9+DMakq1x//KzJ2qFd+q/2MdXuW4ufk48Epy4KfXI7DY1RMhZOkWU4SHYnBO
        3lfMZPV5TPqEg+kvs5jwUw7IeuNVqVPvY+W535zFl/So4WYkp1WmYEy+LYXWaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mHgTxiBl9Pg381SuWjuguHHZxZ6bDXurYM8uLZLwzPA=;
        b=8C9pVa+eSGaJ5LGAhczgi3QnJwr//Y5Cw7Oj/90p5G5lgsPOPIHy5OzqEQ0U1L3SieIx/z
        5atxIQ/OjeL82XBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 12/32] x86/pci/xen: Use msi_for_each_desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:46 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/pci/xen.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -184,7 +184,7 @@ static int xen_setup_msi_irqs(struct pci
 	if (ret)
 		goto error;
 	i = 0;
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
@@ -235,7 +235,7 @@ static int xen_hvm_setup_msi_irqs(struct
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		pirq = xen_allocate_pirq_msi(dev, msidesc);
 		if (pirq < 0) {
 			irq = -ENODEV;
@@ -270,7 +270,7 @@ static int xen_initdom_setup_msi_irqs(st
 	int ret = 0;
 	struct msi_desc *msidesc;
 
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		struct physdev_map_pirq map_irq;
 		domid_t domid;
 
@@ -389,11 +389,9 @@ static void xen_teardown_msi_irqs(struct
 	struct msi_desc *msidesc;
 	int i;
 
-	for_each_pci_msi_entry(msidesc, dev) {
-		if (msidesc->irq) {
-			for (i = 0; i < msidesc->nvec_used; i++)
-				xen_destroy_irq(msidesc->irq + i);
-		}
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
+		for (i = 0; i < msidesc->nvec_used; i++)
+			xen_destroy_irq(msidesc->irq + i);
 	}
 }
 

