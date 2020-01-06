Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54C131C61
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 00:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFXdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 18:33:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgAFXdS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 18:33:18 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47sBdm0wtzz9sRR; Tue,  7 Jan 2020 10:33:16 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3b5b9997b331e77ce967eba2c4bc80dc3134a7fe
In-Reply-To: <20191028085424.12006-1-oohall@gmail.com>
To:     Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     aik@ozlabs.ru, linux-pci@vger.kernel.org,
        Oliver O'Halloran <oohall@gmail.com>, shawn@anastas.io
Subject: Re: [PATCH v2 1/3] powernv/iov: Ensure the pdn for VFs always contains a valid PE number
Message-Id: <47sBdm0wtzz9sRR@ozlabs.org>
Date:   Tue,  7 Jan 2020 10:33:16 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-10-28 at 08:54:22 UTC, Oliver O'Halloran wrote:
> On pseries there is a bug with adding hotplugged devices to an IOMMU group.
> For a number of dumb reasons fixing that bug first requires re-working how
> VFs are configured on PowerNV. For background, on PowerNV we use the
> pcibios_sriov_enable() hook to do two things:
> 
> 1. Create a pci_dn structure for each of the VFs, and
> 2. Configure the PHB's internal BARs so the MMIO range for each VF
>    maps to a unique PE.
> 
> Roughly speaking a PE is the hardware counterpart to a Linux IOMMU group
> since all the devices in a PE share the same IOMMU table. A PE also defines
> the set of devices that should be isolated in response to a PCI error (i.e.
> bad DMA, UR/CA, AER events, etc). When isolated all MMIO and DMA traffic to
> and from devicein the PE is blocked by the root complex until the PE is
> recovered by the OS.
> 
> The requirement to block MMIO causes a giant headache because the P8 PHB
> generally uses a fixed mapping between MMIO addresses and PEs.  As a result
> we need to delay configuring the IOMMU groups for device until after MMIO
> resources are assigned. For physical devices (i.e. non-VFs) the PE
> assignment is done in pcibios_setup_bridge() which is called immediately
> after the MMIO resources for downstream devices (and the bridge's windows)
> are assigned. For VFs the setup is more complicated because:
> 
> a) pcibios_setup_bridge() is not called again when VFs are activated, and
> b) The pci_dev for VFs are created by generic code which runs after
>    pcibios_sriov_enable() is called.
> 
> The work around for this is a two step process:
> 
> 1. A fixup in pcibios_add_device() is used to initialised the cached
>    pe_number in pci_dn, then
> 2. A bus notifier then adds the device to the IOMMU group for the PE
>    specified in pci_dn->pe_number.
> 
> A side effect fixing the pseries bug mentioned in the first paragraph is
> moving the fixup out of pcibios_add_device() and into
> pcibios_bus_add_device(), which is called much later. This results in step
> 2. failing because pci_dn->pe_number won't be initialised when the bus
> notifier is run.
> 
> We can fix this by removing the need for the fixup. The PE for a VF is
> known before the VF is even scanned so we can initialise pci_dn->pe_number
> pcibios_sriov_enable() instead. Unfortunately, moving the initialisation
> causes two problems:
> 
> 1. We trip the WARN_ON() in the current fixup code, and
> 2. The EEH core clears pdn->pe_number when recovering a VF and relies
>    on the fixup to correctly re-set it.
> 
> The only justification for either of these is a comment in eeh_rmv_device()
> suggesting that pdn->pe_number *must* be set to IODA_INVALID_PE in order
> for the VF to be scanned. However, this comment appears to have no basis
> in reality. Both bugs can be fixed by just deleting the code.
> 
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b5b9997b331e77ce967eba2c4bc80dc3134a7fe

cheers
