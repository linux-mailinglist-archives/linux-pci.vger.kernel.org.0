Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FCC632639
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKUOim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKUOhs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984125C767;
        Mon, 21 Nov 2022 06:37:47 -0800 (PST)
Message-ID: <20221121083657.157152924@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fvVqjfzKtMqSR2ihDIp+a+9SKdihxgMT/+3mLv3RKds=;
        b=2RBGy9vBeaPZ+XIzc43GG0TTq88d5XSnI8Ox3lxpzq0A1qtnMbou70MJck09NPcmYhotRJ
        54XGHK67gr5DT2goidxURRwFz5gUVSFuAXpGJZcWo59cin5s9T7ReiPi4UVftuLdM9ZJ63
        GdSG6jPBy+VOEk2Tii+38E/gpNGaD5VpVGK3vnaQCFjDfQUVWloAFUeqZYz92otsMxWYHu
        PNlodDplS+8lh9wtztwHHCEPtBkyYPvZdVZFRMoWKIEC3nZdXKolajkYTDDfze6WDsp8WW
        6m2S32rxjPpj+U0i08eBJfhC3J1hetX8ZCQ8JaQQSSm8pYkze+q9ctdduFryXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fvVqjfzKtMqSR2ihDIp+a+9SKdihxgMT/+3mLv3RKds=;
        b=Qn1lfQESnNTPuKgfOlosFFHihmW6D+YhAV9BuFwAJWdnob6VNOx2PYtlYwVsJNkV3Un0t5
        u9Dblk3f/EcQbpAw==
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
Subject: [patch V2 00/33] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 3 implementation
Date:   Mon, 21 Nov 2022 15:37:46 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is V2 of the third part of the effort to provide support for per device
MSI interrupt domains.

Version 1 of this part can be found here:

  https://lore.kernel.org/all/20221111133158.196269823@linutronix.de

This is based on the second part which is available here:

  https://lore.kernel.org/all/20221121083210.309161925@linutronix.de

and from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-part2

This third part is available from git too:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-part3

This part provides the actual per device domain implementation and related
functionality:

  1) Provide infrastructure to create and remove per device MSI domains

  2) Implement per device MSI domains in the PCI/MSI code and make
     them conditional on the availability of a suitable parent MSI
     domain. This allows to convert the existing domains one by one
     and keeps both the legacy and the current "global" PCI/MSI domain
     model working.

  3) Convert the related x86 MSI domains over (vector and remapping).

  4) Provide core infrastructure for dynamic allocations

  5) Provide PCI/MSI-X interfaces for device drivers to do post
     MSI-X enable allocation/free

  6) Enable dynamic allocation support on the x86 MSI parent domains

  7) Provide infrastructure to create PCI/IMS domains

  8) Enable IMS support on the x86 MSI parent domains

  9) Provide a driver for IDXD which demonstrates how IMS domains
     look like.

Changes vs. v1:

  - Clarified argument names for the init callback (Jason)

  - Split the domain and instance data and named them accordingly

  - Fixed the recursive allocation issue and the missing index offset
    (Reinette)

  - Updated changelogs and comments (Bjorn, Jason)

  - Fixed the kernel robot fallout from randconfig builds

  - Picked up Reviewed/Acked-by tags where appropriate

Thanks,

	tglx
---
 arch/x86/include/asm/irq_remapping.h       |    4 
 arch/x86/include/asm/msi.h                 |    6 
 arch/x86/include/asm/pci.h                 |    1 
 arch/x86/kernel/apic/msi.c                 |  208 +++++++++------
 drivers/iommu/amd/amd_iommu_types.h        |    1 
 drivers/iommu/amd/iommu.c                  |   23 +
 drivers/iommu/intel/iommu.h                |    1 
 drivers/iommu/intel/irq_remapping.c        |   31 +-
 drivers/irqchip/Kconfig                    |    7 
 drivers/irqchip/Makefile                   |    1 
 drivers/irqchip/irq-pci-intel-idxd.c       |  143 ++++++++++
 drivers/pci/msi/api.c                      |  117 ++++++++
 drivers/pci/msi/irqdomain.c                |  278 ++++++++++++++++++--
 drivers/pci/msi/msi.c                      |  192 ++++++++------
 drivers/pci/msi/msi.h                      |    4 
 include/linux/irqchip/irq-pci-intel-idxd.h |   22 +
 include/linux/irqdomain.h                  |    9 
 include/linux/irqdomain_defs.h             |    5 
 include/linux/msi.h                        |  149 +++++++++-
 include/linux/msi_api.h                    |   38 ++
 include/linux/pci.h                        |   14 +
 kernel/irq/msi.c                           |  394 +++++++++++++++++++++++++++--
 22 files changed, 1395 insertions(+), 253 deletions(-)
