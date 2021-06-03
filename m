Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D839A43F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFCPR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 11:17:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhFCPR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 11:17:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B477112FC;
        Thu,  3 Jun 2021 08:16:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C3C3F73D;
        Thu,  3 Jun 2021 08:16:10 -0700 (PDT)
Date:   Thu, 3 Jun 2021 16:16:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/42] PCI: aardvark: Various driver fixes
Message-ID: <20210603151605.GA18917@lpieralisi>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 05:31:11PM +0200, Pali Rohár wrote:
> This patch series fixes various issues in pci-aardvark.c driver
> (PCIe controller on Marvell Armada 3700 SoC) used on Espressobin
> and Turris Mox.
> 
> First patch fixes kernel panic (or TF-A panic depending on used
> firmware) during execution of PIO transfer and I would suggest to
> include this fix into v5.13 release to prevent future kernel panics.
> 
> Other patches then fixes PIO issues, PCIe link training, initialization
> of PCIe controller, accessing PCIe Root Bridge/Port registers, handling
> of interrupts (including ERR and PME), setup of Multi-MSI interrupts,
> adding support for masking MSI interrupts, adding support for more than
> 32 MSI interrupts with MSI-X support, and adding support for AER.
> 
> Note that there are still some unresolved issues with PCIe on A3720.
> I asked Marvell for PCIe documentation or explanations but I have not
> received anything (yet).
> 
> Patch "Fix checking for PIO status" is taken from the Marvell github fork
> and adapted for inclusion into mainline kernel:
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/84444d22023c
> 
> Whole patch series is available also in my git branch pci-aardvark:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> 
> If you have Espressobin, Turris Mox or other A3720 board with PCIe
> please test this patch series with your favourite PCIe card if
> everything is working fine.
> 
> Evan Wang (1):
>   PCI: aardvark: Fix checking for PIO status
> 
> Pali Rohár (39):
>   PCI: aardvark: Fix kernel panic during PIO transfer
>   PCI: aardvark: Fix checking for PIO Non-posted Request
>   PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO
>     response
>   PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
>   PCI: aardvark: Fix reporting CRS Software Visibility on emulated
>     bridge
>   PCI: aardvark: Fix link training
>   PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
>   PCI: aardvark: Fix PCIe Max Payload Size setting
>   PCI: aardvark: Implement workaround for the readback value of VEND_ID
>   PCI: aardvark: Do not touch status bits of masked interrupts in
>     interrupt handler
>   PCI: aardvark: Check for virq mapping when processing INTx IRQ
>   PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
>   PCI: aardvark: Don't mask irq when mapping
>   PCI: aardvark: Change name of INTx irq_chip to advk-INT
>   PCI: aardvark: Remove unneeded goto
>   PCI: aardvark: Fix support for MSI interrupts
>   PCI: aardvark: Correctly clear and unmask all MSI interrupts
>   PCI: aardvark: Fix setting MSI address
>   PCI: aardvark: Add support for more than 32 MSI interrupts
>   PCI: aardvark: Add support for masking MSI interrupts
>   PCI: aardvark: Enable MSI-X support
>   PCI: aardvark: Fix support for ERR interrupt on emulated bridge
>   PCI: aardvark: Fix support for PME on emulated bridge
>   PCI: aardvark: Fix support for PME requester on emulated bridge
>   PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
>     emulated bridge
>   PCI: aardvark: Disable bus mastering and mask all interrupts when
>     unbinding driver
>   PCI: aardvark: Free config space for emulated root bridge when
>     unbinding driver to fix memory leak
>   PCI: aardvark: Reset PCIe card and disable PHY when unbinding driver
>   PCI: aardvark: Rewrite irq code to chained irq handler
>   PCI: aardvark: Use separate INTA interrupt for emulated root bridge
>   PCI: pci-bridge-emul: Add description for class_revision field
>   PCI: pci-bridge-emul: Add definitions for missing capabilities
>     registers
>   PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
>     registers on emulated bridge
>   PCI: aardvark: Add support for PCI_BRIDGE_CTL_BUS_RESET on emulated
>     bridge
>   PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by
>     linux/pci_regs.h macros
>   PCI: aardvark: Replace custom PCIE_CORE_INT_* macros by linux
>     PCI_INTERRUPT_* values
>   PCI: aardvark: Cleanup some register macros
>   PCI: aardvark: Add comments for OB_WIN_ENABLE and ADDR_WIN_DISABLE
>   PCI: aardvark: Add support for Advanced Error Reporting registers on
>     emulated bridge
> 
> Russell King (2):
>   PCI: pci-bridge-emul: re-arrange register tests
>   PCI: pci-bridge-emul: add support for PCIe extended capabilities
> 
>  drivers/pci/controller/pci-aardvark.c | 980 +++++++++++++++++++-------
>  drivers/pci/pci-bridge-emul.c         | 149 ++--
>  drivers/pci/pci-bridge-emul.h         |  17 +-
>  include/uapi/linux/pci_regs.h         |   6 +
>  4 files changed, 850 insertions(+), 302 deletions(-)

May I ask you please to split this series in smaller sets so that
it is easier to merge ?

Let's start with the more urgent fixes that don't involve rework (or
you have not received change requests for since they are simple).

Thanks,
Lorenzo
