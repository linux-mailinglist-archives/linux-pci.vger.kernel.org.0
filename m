Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3445FBF1
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhK0CUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhK0CSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:18:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B22C08EB53;
        Fri, 26 Nov 2021 17:31:32 -0800 (PST)
Message-ID: <20211126232736.079074688@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GK9xXtkPz9vBMqHoE5to0KtmwhYh1wJX9NGwNpFpD14=;
        b=kgiaq1X/Z7o7iWvmxEoBT6LFyriYsKGK8nI3/bhxK6gST0SRVOF7lbwSYLr3VlgxZ4h6WL
        g2UfKV1XDiJ8EtgxSEDcSpDTeNmSwJPBjTX9SB3RWZRalSzA1qfkg+spIvTxbd1cXIcXQx
        C7iIjlIxuiLsNrsikh7t+5ldxtZOWkxCjA4YO9b9THAsunkO+qZiZuSb3ZT1TlPIGG4zwh
        d+6ARANqiEOuIZQCE4TVfCaMnyo+M1wMh039aXP65nHogIXE3/1Ecni8vlG2N9qg2pCImS
        bjHKiOvIcvSOafGZ+G0UubKMBe/MPM9yOOOuREt5HLsALXWoqVWfx8DIdFlKCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GK9xXtkPz9vBMqHoE5to0KtmwhYh1wJX9NGwNpFpD14=;
        b=2kWEoo1W6Jg3BJgiK2WNx8glc2hsfaNdXP6hk3yM08zwNU9ODFbcmh4JTixi2wT3XxeeBO
        1o5kkoJLBnMaC5BQ==
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
Date:   Sat, 27 Nov 2021 02:24:15 +0100 (CET)
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

