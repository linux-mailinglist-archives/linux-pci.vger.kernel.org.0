Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2225625B97
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiKKNyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiKKNym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1575CD10;
        Fri, 11 Nov 2022 05:54:25 -0800 (PST)
Message-ID: <20221111122013.947071142@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DzwMVitVEwpsnJRYX1GqcWllvAqc3k0vBxAI8Er+FBs=;
        b=rM3Hvm2A/73BTlgf/cJ63LRmKDRdAAwY5hxOMDRVqxPwJ3lk7tngBwLUDRQqeuz3V9+rh2
        UK742ef9qcpZt85XVhtCPr67bCbu6J8HmHF9/OXUHWpBeASoZHKjXY5LPgDIXkVvpfcUrh
        0Fy4d5HpPhKpH8TTLrDqDqP9eJUC4nLW6rPv1G/xbxvW0jE9wO+lR5tz8qZ51i7kz2/WdY
        HNOhZ6XfV5J0TFdNls9y7zjvYcuIerly6Q1R1KkISjg1mNrIwlh4L7Xc9RsSXApFGVviKb
        +27SOaCWk/l8xdmgBcHsAANAKPHRSa11nAfqQyh5L2hBCPUHmS6cP+bbtIJm3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DzwMVitVEwpsnJRYX1GqcWllvAqc3k0vBxAI8Er+FBs=;
        b=61OFjcySwk55/wM8ZG3QX632+240BfUAoDJeeBKxzaHUj49wFuflEH1l5zdnt0rEJuHj6f
        WudG4TZAewxnW2BQ==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 06/39] genirq/msi: Add missing kernel doc to msi_next_desc()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:23 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W=1 complains about this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL_GPL(msi_first_desc);
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
  * successful invocation of __msi_first_desc(). Consecutive invocations are

