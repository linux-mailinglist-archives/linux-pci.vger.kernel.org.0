Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E502D63267D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKUOkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiKUOjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:39:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CCC769F;
        Mon, 21 Nov 2022 06:38:21 -0800 (PST)
Message-ID: <20221121091327.974140298@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7ozm1W9vDFfSIoLTXblkyRUQVqcZdWLOTQR4Ad9y7GE=;
        b=LhyPLCQAlQHr9qTA1Ov1RETf6QOK21scp548PxBrBrcSgTLtgu3tx6hBXW6pxwdzdk7OJO
        8b7fiFl6zWF2xK2qhaBeOyYHJWfjB/qLEo1iRYSFhkzPM3iA3nnvRQLHEyCb6wjUW9TPWG
        T/b85oB1D2A4HmnGxVuKbDpxwXpwKVHT8t4BE4a2DBLMIXIepfBfrK3aN6Ooq0Q47H4KbV
        vys+RRBzHlW4F5xwAlsY31feT/DgvE7c203LkV+kqSErylFwaiBFk/W3oDlG+VkhJBjiU6
        iGvYrduZqr6rZQGDGsxVseXs1HW6MAzAWDnO+Gka65SSU/rPpyIjzaKdgM5vYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7ozm1W9vDFfSIoLTXblkyRUQVqcZdWLOTQR4Ad9y7GE=;
        b=wFcT822CR/M3YtgqkGDDY1oHnMwc1eEUZaiI1oHqaWHZT+lcZLG85Qm845cZgcbFJnmcBz
        lq4DQI0kv9m+ncAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS support
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:19 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide the necessary constants for PCI/IMS support:

  - A new bus token for MSI irqdomain identification
  - A MSI feature flag for the MSI irqdomains to signal support
  - A secondary domain id

The latter expands the device internal domain pointer storage array from 1
to 2 entries. That extra pointer is mostly unused today, but the
alternative solutions would not be free either and would introduce more
complexity all over the place. Trade the 8bytes for simplicity.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain_defs.h |    1 +
 include/linux/msi.h            |    2 ++
 include/linux/msi_api.h        |    1 +
 3 files changed, 4 insertions(+)

--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -25,6 +25,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
+	DOMAIN_BUS_PCI_DEVICE_IMS,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -529,6 +529,8 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
+	/* Support for PCI/IMS */
+	MSI_FLAG_PCI_IMS		= (1 << 21),
 };
 
 /**
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -15,6 +15,7 @@ struct device;
  */
 enum msi_domain_ids {
 	MSI_DEFAULT_DOMAIN,
+	MSI_SECONDARY_DOMAIN,
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 

