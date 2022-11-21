Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B763265E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKUOjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiKUOil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E07C846F;
        Mon, 21 Nov 2022 06:38:15 -0800 (PST)
Message-ID: <20221121091327.713589628@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fGweWjopcEmhFfptqFTrW/NIWQ/1hQiFq3/Kny0SMZ4=;
        b=0trFOjA/R44BZgXeMIkt/zQa2KLYiFV47dS2jCKICJRADEWo3P+4K45ud54/XltrjjP0pr
        MDLf3zpmiqd7lmkbDv6vPaq1TcE6MpgRHzXv0Bb7i5hLDUW72+h5VmQwmVSVncl+/XpMKs
        wR8xedSJng6RivjUrfpw6RkBH/PRmCeZ3eFRXA+Y3q2//RffGFdn24XVp5YimRek+J/dhM
        D5+WSx78xnHdQxTIj5UaNqBFtZBZZ012TWHFJ568ehpMkBq/+39Hl7RCDs1LiRtcZISleS
        lBerxyrCVYJOmX2Tu3fcws/i2IqK4RVELbISH7tvkLWlgV9JPxNp0meazhk1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fGweWjopcEmhFfptqFTrW/NIWQ/1hQiFq3/Kny0SMZ4=;
        b=1tH5asyB/T4QpgfzvDVzIhaPZE1I9+3rllXFlXeotjJXAOBr9MAPDa6wAdRRqPmydeLDPz
        3+HngMWEkWKcRxCg==
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
Subject: [patch V2 22/33] genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:13 +0100 (CET)
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/msi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -546,7 +546,8 @@ enum {
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 18),
 	/* MSI-X entries must be contiguous */
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
-
+	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
+	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 };
 
 /**

