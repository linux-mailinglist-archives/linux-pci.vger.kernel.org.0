Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DE632605
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiKUOgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKUOgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CAC80D2;
        Mon, 21 Nov 2022 06:36:20 -0800 (PST)
Message-ID: <20221121083210.309161925@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aeVS1xacxwxWzGD0v18Me3HgOgexsApC7p6cn2xAhEk=;
        b=lofUDJ9O/nZz0k6fNAZ5NFeGqe9fbm5HeVBRv81VAuBIzpm+zwDSsijHP6Pwld+WcEarBv
        Wj94MoM3jjvc6+2/KXudDLt68C6Jjq1ZrucXFXfveOAVWecy4fAP9VdVxeHNTKwQZi3Z7I
        tbGqAiy2I8ruKMdRwVFVmlZg8glZhGpRVRvrXuxsccADjPhgQNy54SC64njSWH8GrLLNuk
        GzYa6/WgJLjZLw5Go6GlPcPkEYV01ZTTn/ULwz3Bz6zNmssaByyaV0oqej0cv5N0elBDjq
        0TEzhvRmaYpim9OUHxqcVr3GTOFMkDAfFdywzMtH9XJnRGpOD5dBZeIbYSO3Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aeVS1xacxwxWzGD0v18Me3HgOgexsApC7p6cn2xAhEk=;
        b=3T5CmnFjnYJS8aCSoVNJPljzLjVE/GF+Aqn9EgyA3N2hdXzAW8XLuXhHUyw+L8NVZC4270
        70ysEOpvYZAjMbAQ==
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
Subject: [patch V2 00/21] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Date:   Mon, 21 Nov 2022 15:36:18 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is V2 of the second part of effort to provide support for per device
MSI interrupt domains.

Version 1 of this second part can be found here:

  https://lore.kernel.org/all/20221111132706.104870257@linutronix.de

The first part is available here:

  https://lore.kernel.org/all/20221111120501.026511281@linutronix.de

and has been merged into:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

This part on top of the tip irq/core branch is also available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-part2

This part is the main preparation step for per device MSI domains:

  1) Introduce irqdomain pointer storage space in device::msi::data
     and related helpers.

  2) Convert interfaces to handle multiple per device MSI domains
     based on a domain ID

  3) Provide new interfaces for allocation/free which are domain ID
     based and provide range allocation/free which is a prerequisite
     for post MSI-X enable alloc/free.

  4) Switch all existing call sites of msi allocation/free interfaces
     over to the new interfaces

  5) Remove the old interfaces

Changes vs. V1:

  - Split the kernel doc changes from the rename (Jason)

  - Rename msi_ctrl_valid() to msi_ctrl_range_valid() (Kevin)

  - Fix the off by one vs. MSI_MAX_INDEX (Kevin)

  - Update changelogs and comments (Bjorn, Jason, Kevin)

  - Fix the kernel robot fallout from randconfig builds

  - Picked up Reviewed/Acked-by tags where appropriate

Thanks,

	tglx
---
 arch/x86/kernel/apic/msi.c       |    5 
 drivers/base/platform-msi.c      |    4 
 drivers/bus/fsl-mc/fsl-mc-msi.c  |   25 -
 drivers/irqchip/irq-gic.c        |    4 
 drivers/pci/msi/irqdomain.c      |    4 
 drivers/pci/msi/msi.c            |    4 
 drivers/soc/ti/ti_sci_inta_msi.c |   12 
 include/linux/irqdomain.h        |  112 ++++----
 include/linux/msi.h              |  125 +++++++--
 include/linux/msi_api.h          |   35 ++
 kernel/irq/chip.c                |    8 
 kernel/irq/msi.c                 |  541 +++++++++++++++++++++++++++++----------
 12 files changed, 631 insertions(+), 248 deletions(-)

