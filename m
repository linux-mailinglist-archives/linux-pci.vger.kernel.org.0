Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB0226C7D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgGTQyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 12:54:51 -0400
Received: from foss.arm.com ([217.140.110.172]:34966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgGTQyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jul 2020 12:54:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612EC106F;
        Mon, 20 Jul 2020 09:54:50 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FBB73F66E;
        Mon, 20 Jul 2020 09:54:48 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:54:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, joro@8bytes.org
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping APIs
Message-ID: <20200720165442.GA19658@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 09:20:01AM +0100, Lorenzo Pieralisi wrote:
> This series is a v2 of a previous posting:
> 
> v1 -> v2
> 
> - Removed _rid() wrappers
> - Fixed !CONFIG_ACPI compilation issue
> - Converted of_pci_iommu_init() to use of_iommu_configure_dev_id()
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20200521130008.8266-1-lorenzo.pieralisi@arm.com/
> 
> Original cover letter
> ---------------------
> 
> Firmware bindings provided in the ACPI IORT table[1] and device tree
> bindings define rules to carry out input/output ID mappings - ie
> retrieving an IOMMU/MSI controller input ID for a device with a given
> ID.
> 
> At the moment these firmware bindings are used exclusively for PCI
> devices and their requester ID to IOMMU/MSI id mapping but there is
> nothing PCI specific in the ACPI and devicetree bindings that prevent
> the firmware and kernel from using the firmware bindings to traslate
> device IDs for any bus that requires its devices to carry out
> input/output id translations.
> 
> The Freescale FSL bus is an example whereby the input/output ID
> translation kernel code put in place for PCI can be reused for devices
> attached to the bus that are not PCI devices.
> 
> This series updates the kernel code to make the MSI/IOMMU input/output
> ID translation PCI agnostic and apply the resulting changes to the
> device ID space provided by the Freescale FSL bus.
> 
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: "Joerg Roedel <joro@8bytes.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> 
> Diana Craciun (2):
>   of/irq: make of_msi_map_get_device_domain() bus agnostic
>   bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver
> 
> Laurentiu Tudor (1):
>   dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus
> 
> Lorenzo Pieralisi (8):
>   ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for
>     NC
>   ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
>   ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
>   ACPI/IORT: Remove useless PCI bus walk
>   ACPI/IORT: Add an input ID to acpi_dma_configure()
>   of/iommu: Make of_map_rid() PCI agnostic
>   of/device: Add input id to of_dma_configure()
>   of/irq: Make of_msi_map_rid() PCI bus agnostic
> 
> Makarand Pawagi (1):
>   bus: fsl-mc: Add ACPI support for fsl-mc
> 
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt |  50 +++++++-
>  drivers/acpi/arm64/iort.c                     | 108 ++++++++++++------
>  drivers/acpi/scan.c                           |   8 +-
>  drivers/bus/fsl-mc/dprc-driver.c              |  31 ++---
>  drivers/bus/fsl-mc/fsl-mc-bus.c               |  79 +++++++++----
>  drivers/bus/fsl-mc/fsl-mc-msi.c               |  36 ++++--
>  drivers/bus/fsl-mc/fsl-mc-private.h           |   6 +-
>  drivers/iommu/of_iommu.c                      |  81 +++++++------
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 105 ++++++++++++++---
>  drivers/of/base.c                             |  42 +++----
>  drivers/of/device.c                           |   8 +-
>  drivers/of/irq.c                              |  34 +++---
>  drivers/pci/msi.c                             |   9 +-
>  include/acpi/acpi_bus.h                       |   9 +-
>  include/linux/acpi.h                          |   7 ++
>  include/linux/acpi_iort.h                     |  20 ++--
>  include/linux/of.h                            |   4 +-
>  include/linux/of_device.h                     |  16 ++-
>  include/linux/of_iommu.h                      |   6 +-
>  include/linux/of_irq.h                        |  13 ++-
>  20 files changed, 451 insertions(+), 221 deletions(-)

Hi guys,

I think this series is ready for upstream (there are two ACKs missing
from Rafael on patch (5) and Bjorn on patch (3) - I asked for them), it
touches lots of subsystems so I am not really sure what's the best way
to pull it, more so given that it is also late in the cycle (I do think
it is best to merge it via a single tree, it does not make sense to
split it up in my opinion).

Please let me know.

Thanks,
Lorenzo
