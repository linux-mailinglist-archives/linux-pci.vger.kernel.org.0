Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BE625C1F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiKKOAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiKKOA3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7F7F554;
        Fri, 11 Nov 2022 05:56:44 -0800 (PST)
Message-ID: <20221111132706.220687198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+wWUy0xddNMXZ4KiuU4oL7F6PKUict1lpTyY0niJbHA=;
        b=4Ve/5OQD46++Ka7BIfp6pYk3HWqMRwK4G/JS7GSgmA9f3Mu3CWK7KMTuwExQ7K4rujCAeG
        bJeGyjMRNgVEUB/cWXx6B6xThz7osKQ6aIyXmmfaVHyqAJfz43nfgHXnWujZ+YGMoQUNar
        WL9Gz+YoeFb5iiMMatgSx9F6yY5BrM0FKyOf5fdjVPl4tOq2k+cNduEb3syKLcmVNwVU8V
        E3ngIzlwgGsjgUBDx0j4pVFQ+mjBcjmut7w8pTWgQy7L4QLKAgLRbdBolqpsak4MTJVXSa
        5/D4aUp85YEa28AhVS3vwSYQCupki/2oycF8jbAekLNqa3kydN8CTkT8QL3W6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+wWUy0xddNMXZ4KiuU4oL7F6PKUict1lpTyY0niJbHA=;
        b=pOkuRxfa/fpZvtbipaYIMhhpLDSFbLFUaARwteFpOtcpeRYQ2BCkJnMVLmqAnRuYtneAF3
        OFRQsDkKeuwdxdBg==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 03/20] genirq/msi: Create msi_api.h
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:42 +0100 (CET)
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
@@ -184,7 +187,6 @@ struct msi_device_data {
 
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

