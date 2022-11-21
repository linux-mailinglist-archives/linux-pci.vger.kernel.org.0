Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A66326A0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiKUOq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiKUOqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6EC8CA9;
        Mon, 21 Nov 2022 06:40:37 -0800 (PST)
Message-ID: <20221121135653.208611233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9fJ4Mb63/Xks6zZDq8ZHkxVKQmV+67DHF6G9VxNNEMw=;
        b=P3GT4t5Qng4wzeDGck0U3hd0s0dYvQU63G5ARPCPWkQE2ex/u/o70xly4N37+54IR40L01
        NwlK2E4M2laTDGpPMA888lXOcUnxIjXqUOynggZsqtK3D132ZbzCyTD5h6BGrqgE9/+LYJ
        xm+uCjOvCyWmi76eKKyM/RRt/MqXn77GLzm3fZ5MMCb6q7uWITMKK+bv7DBSReyXtDER3A
        /fYHWKtK4sCaarBPQ+71DAFvy9DHtpNOfLnAcT+4K37ws4cSZ1SRYLNrh1mcxAlYVhas3G
        7blYOTNQcnhM96YEj8l3VnssCDSXB4DOVsylFHOMmHAn/fBfuuARCJ17KXYCSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9fJ4Mb63/Xks6zZDq8ZHkxVKQmV+67DHF6G9VxNNEMw=;
        b=vAUxo5Ousu1yuMqQq339jI3qmjB2P0X+PepWYfo+0LgUTo+RUdYIvL43TcqyqQyRqBmZ3S
        5wCkan+Z3OWMWaBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 00/40] genirq, irqchip: Convert ARM MSI handling to per
 device MSI domains
Date:   Mon, 21 Nov 2022 15:39:28 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This builds on top of the per device MSI work which can be found here:

  https://lore.kernel.org/all/20221121083657.157152924@linutronix.de

and is available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-part3

This series converts the ARM MSI handling, especially the platform MSI
mechanics, to use per device MSI domains instead of the weird indirection
through platform MSI domains.

This also takes a different and less convoluted approach to the 'wire to
MSI' bridges by providing special MSI allocation/free functions which are
invoked from irq_create_fwspec_mapping() and irq_dispose_mapping() which
avoids the extra entry point msi_domain_populate_irqs() and its layering
violations.

The series has been tested on various systems (Ampere, Hisilicon HIP05,
ThunderX2, MVEBU MCBIN) but there is no full coverage yet.

Thanks to Marc, Mark and Robin for running this on their machines and
aiding with decoding the initial wreckage. Special thanks go to Marc for
patiently guiding me through the insanity of OF/ACPI related to this.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm

The work was done to validate that the design decisions for per device MSI
domains and the related data structures are up to the task to handle the
ARM oddities. The design held up, it was just necessary to extend some of
the data structures to handle the ARM specifics in a sane way, but there
was no fundamental shortcoming.

Thanks,

	tglx
---
 b/drivers/base/platform-msi.c                 |  354 +++-----------------------
 b/drivers/dma/mv_xor_v2.c                     |    8 
 b/drivers/dma/qcom/hidma.c                    |    6 
 b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    5 
 b/drivers/irqchip/Kconfig                     |    8 
 b/drivers/irqchip/Makefile                    |    4 
 b/drivers/irqchip/irq-gic-common.h            |    3 
 b/drivers/irqchip/irq-gic-msi-lib.c           |  136 +++++++++
 b/drivers/irqchip/irq-gic-msi-lib.h           |   27 +
 b/drivers/irqchip/irq-gic-v2m.c               |   93 ++----
 b/drivers/irqchip/irq-gic-v3-its-msi-parent.c |  207 +++++++++++++++
 b/drivers/irqchip/irq-gic-v3-its.c            |    4 
 b/drivers/irqchip/irq-gic-v3-mbi.c            |  137 ++--------
 b/drivers/irqchip/irq-gic-v3.c                |    6 
 b/drivers/irqchip/irq-imx-mu-msi.c            |   53 +--
 b/drivers/irqchip/irq-mbigen.c                |   98 ++-----
 b/drivers/irqchip/irq-mvebu-gicp.c            |   44 +--
 b/drivers/irqchip/irq-mvebu-icu.c             |  278 ++++++++------------
 b/drivers/irqchip/irq-mvebu-odmi.c            |   39 +-
 b/drivers/irqchip/irq-mvebu-sei.c             |   52 +--
 b/drivers/irqchip/irq-ti-sci-inta.c           |    2 
 b/drivers/mailbox/bcm-flexrm-mailbox.c        |    8 
 b/drivers/pci/msi/irqdomain.c                 |   30 ++
 b/drivers/perf/arm_smmuv3_pmu.c               |    4 
 b/include/linux/acpi_iort.h                   |    4 
 b/include/linux/irqdomain.h                   |   17 +
 b/include/linux/irqdomain_defs.h              |    2 
 b/include/linux/msi.h                         |   81 +----
 b/kernel/irq/irqdomain.c                      |   26 +
 b/kernel/irq/msi.c                            |  253 ++++++++++++------
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  202 --------------
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  163 -----------
 32 files changed, 1021 insertions(+), 1333 deletions(-)
