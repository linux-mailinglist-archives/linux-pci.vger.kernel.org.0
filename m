Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECF7625BDD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiKKN5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiKKN46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3F83BBD;
        Fri, 11 Nov 2022 05:55:12 -0800 (PST)
Message-ID: <20221111122015.631728309@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+6oBh3Odymqoh23rvdka2IMdSMoyZzzr0/UBN1qNnTk=;
        b=O3tsMqs0BMeeR+sixFB4gZJapU/NxK4ghDKAVQPqDhnTZ1IBPbK56iDtMw7jiD/yvC0Vms
        vf+roT7vboCo/D68gqgyuCWbdKslCGJJlnagz5NYC84Fa+4muHYwvI8A/twTqrfeUBk4vq
        qOa5boM9ecDRIvlv/Ne3aj00R/KskvzhltFrU+g0Dwj09t1ZkfM5eE1QNWW8iR655FotRi
        SVw1neM3UJcaXYj5CYqZj6zgC6RP/mbHOygnVJyedVo6fh9IVUba5cbNVdgGznNBm/s8sV
        hI/fb/i3XF/r1foTj/UHFgkIBx8je8kZVkZCQzlLRfgqN9hBwDdlt7py4prVNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+6oBh3Odymqoh23rvdka2IMdSMoyZzzr0/UBN1qNnTk=;
        b=RaGdX6Bhz2QV0LIWcWTdx/Y0fm6Co1H4cRb08fHDA9pCZ6wSQ+pfMSrQ7MxAFpkbWFifhD
        9ql635EreUgGQKBA==
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
Subject: [patch 35/39] PCI/MSI: Reject MSI-X early
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:11 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to PCI multi-MSI reject MSI-X enablement when a irq domain is
attached to the device which does not support MSI-X.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -760,6 +760,10 @@ int __pci_enable_msix_range(struct pci_d
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
+	/* Check MSI-X early on irq domain enabled architectures */
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY))
+		return -ENOTSUPP;
+
 	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 

