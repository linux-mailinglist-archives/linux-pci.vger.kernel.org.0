Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654EB45FACC
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351697AbhK0Bep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:34:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbhK0Bco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:32:44 -0500
Message-ID: <20211126232736.079074688@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GK9xXtkPz9vBMqHoE5to0KtmwhYh1wJX9NGwNpFpD14=;
        b=RTtQyBG7KJ2bRYbiWrkQdhFhS3w593oltoeuAfgWAP8JAPCZnzbP2cgaYB4y4OhCee3Mls
        V6z2TLASxYaTjUm4qUztIbqSZFhGeT1ueRNtSFaogmFHVkF7C4Kb9ZBa0pwH9AWLa3NoIo
        uIWx7D3P+TV1USGNwxs36DsUS9Xdy/udjLcoDF4pVvXMUneMQKSi+59wJJVVut8yhOehxF
        ekFMjhpEPbgF+oG8zzEP+4cf1QkQ9ZDrkXHlpTYhd3QCjR+3eqZpBRNeCMWggAuDcdoVjw
        O6zCmwldoYn+LhxjjxMNKpvs1/zmBBWG/JALUHPy94hGXyfoWOddiXdK6kKdbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GK9xXtkPz9vBMqHoE5to0KtmwhYh1wJX9NGwNpFpD14=;
        b=W87SWjgVfefuwAddIuT4ademwASXAktfYlO+BHEcRgFFf21llxItvATu6azPs2++oKZ0h0
        Y+uzC3Dlz186THDw==
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
Subject: [patch 30/32] genirq/msi: Add abuse prevention comment to msi header
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:14 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,6 +2,20 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
+/*
+ * This header file contains MSI data structures and functions which are
+ * only relevant for:
+ *	- Interrupt core code
+ *	- PCI/MSI core code
+ *	- MSI interrupt domain implementations
+ *	- IOMMU, low level VFIO, NTB and other justified exceptions
+ *	  dealing with low level MSI details.
+ *
+ * Regular device drivers have no business with any of these functions and
+ * especially storing MSI descriptor pointers in random code is considered
+ * abuse. The only function which is relevant for drivers is msi_get_virq().
+ */
+
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>

