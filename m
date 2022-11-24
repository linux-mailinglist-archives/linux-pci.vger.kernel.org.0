Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B05638156
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKXXYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXXYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4487A71;
        Thu, 24 Nov 2022 15:24:16 -0800 (PST)
Message-ID: <20221124230313.632679220@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fX3YyaTkrRIM3kSpqK/PVSD3oj0zimiyOCtXLtrgK+M=;
        b=RuUSjWj3sp0CZyFt3RTyw1tmWDGmWl9Quimkod7ubNdHV2gj94Vns/2U6Nufd7LPif6u0K
        bvo6ZqMwv/Fv/shLAPLGhwzaQrzRxw2g5Mq4nRiZ5Onkahf23x+V/jhsRBM7GjDPaWa+P3
        gSslr8kqBebwKVZwvaRoSOsk3PD7aahl5FOlDluX6jWZdZAP2oQCOmv6X6k6uUXXFuDvI1
        PNXPeKMZpI6QTVouSAfPbkCPSO/HkjpdVm4dHYSi3X/JcdKqjd9l6NIpFkdVDWO8w9mhoM
        zE4BDwcXGYct7pY2DiWDQQo7dDibEtKjEUKkBCHalVrYoX3OnK2fMTragZ9bpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fX3YyaTkrRIM3kSpqK/PVSD3oj0zimiyOCtXLtrgK+M=;
        b=tQPHfy2XIhMpnnlr1ZD/kJBJWg1FxQ32uKZXH5nnCYz5PHvtkDbtr/ykZEM26do4eXsVmg
        BRky1tNIwGf+sMCg==
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
        Allen Hubbe <allenbh@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V3 04/22] genirq/msi: Create msi_api.h
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:14 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create a API header for MSI specific functions which are relevant to device
drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/msi.h     |    6 ++++--
 include/linux/msi_api.h |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -13,11 +13,14 @@
  *
  * Regular device drivers have no business with any of these functions and
  * especially storing MSI descriptor pointers in random code is considered
- * abuse. The only function which is relevant for drivers is msi_get_virq().
+ * abuse.
+ *
+ * Device driver relevant functions are available in <linux/msi_api.h>
  */
 
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
+#include <linux/msi_api.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -188,7 +191,6 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
--- /dev/null
+++ b/include/linux/msi_api.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_MSI_API_H
+#define LINUX_MSI_API_H
+
+/*
+ * APIs which are relevant for device driver code for allocating and
+ * freeing MSI interrupts and querying the associations between
+ * hardware/software MSI indices and the Linux interrupt number.
+ */
+
+struct device;
+
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
+#endif

