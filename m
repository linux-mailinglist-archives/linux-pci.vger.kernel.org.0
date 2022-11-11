Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C2625C78
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiKKOHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKKOHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0808BA91;
        Fri, 11 Nov 2022 05:59:54 -0800 (PST)
Message-ID: <20221111135206.521387616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LtweMGx7oKuU2/h3mTO1bStczI1HafJrlhjPsVZ18gQ=;
        b=Ctm1DuFDy0HMJYdK9qCz1YVmZZR5lyZM+sN3sOYYfE75QgQVFJMayaXVW+5l8ZSJwAPuN+
        +GSlJ5SO58Gg6TnKKUONA4rPqWgn0Hy2gQZD3WTmbMv4P9TqKVaO8Q/t/quIGF1od/zCVM
        nqtFqwQC8F669AYvhxpu1URqit3Qvut11TVNde3tib92Gp0sUpa8Vfe95FIlG0JsqOVutD
        bSeIuJFnobA1p+MMuRRUSdneNUz9tYhawMrl/V2m6HYR1AoVHvQiPqGxsWpP30STvlrqQQ
        kKwASJfN4/OhiWltGqJIu3aeAszVDUK6pckOimNXlcc/BgKcRazi8y3tdpv5OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LtweMGx7oKuU2/h3mTO1bStczI1HafJrlhjPsVZ18gQ=;
        b=nv8txJEj8304vPLR4WxDND2n+tA605ka1X9Eieo9KDRFXP8JJT6fDJKSRkumhizd/TVqVD
        FQvjzajS4jVYlrDQ==
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
Subject: [patch 22/33] genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:46 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a new MSI feature flag in preparation for dynamic MSIX allocation
after the initial MSI-X enable has been done.

This needs to be an explicit MSI interrupt domain feature because quite
some implementations (both interrupt domains and legacy allocation mode)
have clear expectations that the allocation code is only invoked when MSI-X
is about to be enabled. They either talk to hypervisors or do some other
work and are not prepared to be invoked on an already MSI-X enabled device.

This is also explicit MSI-X only because rewriting the size of the MSI
entries is only possible when disabling MSI which in turn might cause lost
interrupts on the device.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -523,7 +523,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 18),
 	/* MSI-X entries must be contiguous */
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
-
+	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
+	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 };
 
 /**

