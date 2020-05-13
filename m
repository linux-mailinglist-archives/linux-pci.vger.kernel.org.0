Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0D1D1CA9
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgEMRzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 13:55:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMRzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 13:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589392548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z74hyvbu6yXN5JbsG7DtOgXprTXDA7QgAH7P8GaOHEs=;
        b=fG+nAlkEdcOPQkSbpDf+aoSToZzkqddUhMuTHs6RXG3slBNQp6ymIbwOYOj9BnuEPo8GQL
        XKbFhQ/Cl6Cq8ZkPrH+e2d44KDELmD64Cu0j+xeIVbrKOxHI3F34fJaQj/IP107lVhL6ek
        iqWvJEx0/B5mgS8BFyXnFtSrA68f19Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-M7y_pPAXPHWV9GooMmb8QQ-1; Wed, 13 May 2020 13:55:43 -0400
X-MC-Unique: M7y_pPAXPHWV9GooMmb8QQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE9C80183C;
        Wed, 13 May 2020 17:55:42 +0000 (UTC)
Received: from w520.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC5961F50;
        Wed, 13 May 2020 17:55:41 +0000 (UTC)
Date:   Wed, 13 May 2020 11:55:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Message-ID: <20200513115540.59a2f57d@w520.home>
In-Reply-To: <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
        <20200511190129.9313-2-jonathan.derrick@intel.com>
        <20200511165927.27b41d65@w520.home>
        <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 May 2020 00:35:47 +0000
"Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:

> Hi Alex,
> 
> I'm probably not getting the translation technical details correct.
> 
> On Mon, 2020-05-11 at 16:59 -0600, Alex Williamson wrote:
> > On Mon, 11 May 2020 15:01:27 -0400
> > Jon Derrick <jonathan.derrick@intel.com> wrote:
> >   
> > > The VMD endpoint provides a real PCIe domain to the guest, including  
> > 
> > Please define VMD.  I'm sure this is obvious to many, but I've had to
> > do some research.  The best TL;DR summary I've found is Keith's
> > original commit 185a383ada2e adding the controller to Linux.  If there's
> > something better, please let me know.  
> That's the correct commit, but I'll try to summarize the important bits
> for v3.
> 
> >   
> > > bridges and endpoints. Because the VMD domain is enumerated by the guest
> > > kernel, the guest kernel will assign Guest Physical Addresses to the
> > > downstream endpoint BARs and bridge windows.
> > > 
> > > When the guest kernel performs MMIO to VMD sub-devices, IOMMU will
> > > translate from the guest address space to the physical address space.
> > > Because the bridges have been programmed with guest addresses, the
> > > bridges will reject the transaction containing physical addresses.  
> > 
> > I'm lost, what IOMMU is involved in CPU access to MMIO space?  My guess
> > is that since all MMIO of this domain is mapped behind the host
> > endpoint BARs 2 & 4 that QEMU simply accesses it via mapping of those
> > BARs into the VM, so it's the MMU, not the IOMMU performing those GPA
> > to HPA translations.  But then presumably the bridges within the domain
> > are scrambled because their apertures are programmed with ranges that
> > don't map into the VMD endpoint BARs.  Is that remotely correct?  Some
> > /proc/iomem output and/or lspci listing from the host to see how this
> > works would be useful.  
> Correct. So MMU not IOMMU.
> 
> In the guest kernel, the bridges and devices in the VMD domain are
> programmed with the addresses provided in the VMD endpoint's BAR2&4
> (MEMBAR1&2). Because these BARs are populated with guest addresses, MMU
> translates to host physical and the bridge window rejects MMIO not in
> its [GPA] range.
> 
> As an example:
> Host:
>   94000000-97ffffff : 0000:17:05.5
>     94000000-97ffffff : VMD MEMBAR1
>       94000000-943fffff : PCI Bus 10000:01
>         94000000-9400ffff : 10000:01:00.0
>         94010000-94013fff : 10000:01:00.0
>           94010000-94013fff : nvme
>       94400000-947fffff : PCI Bus 10000:01
>       94800000-94bfffff : PCI Bus 10000:02
>         94800000-9480ffff : 10000:02:00.0
>         94810000-94813fff : 10000:02:00.0
>           94810000-94813fff : nvme
>       94c00000-94ffffff : PCI Bus 10000:02
> 
> 
> MEMBAR 2 is similarly assigned
> 
> >   
> > > VMD device 28C0 natively assists passthrough by providing the Host
> > > Physical Address in shadow registers accessible to the guest for bridge
> > > window assignment. The shadow registers are valid if bit 1 is set in VMD
> > > VMLOCK config register 0x70. Future VMDs will also support this feature.
> > > Existing VMDs have config register 0x70 reserved, and will return 0 on
> > > reads.  
> > 
> > So these shadow registers are simply exposing the host BAR2 & BAR4
> > addresses into the guest, so the quirk is dependent on reading those
> > values from the device before anyone has written to them and the BAR
> > emulation in the kernel kicks in (not a problem, just an observation).  
> It's not expected that there will be anything writing that resource and
> those registers are read-only.
> The first 0x2000 of MEMBAR2 (BAR4) contain msix tables, and mappings to
> subordinate buses are on 1MB aligned.
> 
> 
> > Does the VMD controller code then use these bases addresses to program
> > the bridges/endpoint within the domain?  What does the same /proc/iomem
> > or lspci look like inside the guest then?  It seems like we'd see the
> > VMD endpoint with GPA BARs, but the devices within the domain using
> > HPAs.  If that's remotely true, and we're not forcing an identity
> > mapping of this HPA range into the GPA, does the vmd controller driver
> > impose a TRA function on these MMIO addresses in the guest?  
> 
> This is the guest with the guest addresses:
>   f8000000-fbffffff : 0000:00:07.0
>     f8000000-fbffffff : VMD MEMBAR1
>   
>     f8000000-f83fffff : PCI Bus 10000:01
>         f8000000-f800ffff :
> 10000:01:00.0
>         f8010000-f8013fff : 10000:01:00.0
>           f801000
> 0-f8013fff : nvme
>       f8400000-f87fffff : PCI Bus 10000:01
>       f88000
> 00-f8bfffff : PCI Bus 10000:02
>         f8800000-f880ffff : 10000:02:00.0
>         f8810000-f8813fff : 10000:02:00.0
>           f8810000-f8813fff :
> nvme
>       f8c00000-f8ffffff : PCI Bus 10000:02
> 
> 
> The VMD guest driver does the translation on the supplied address using
> pci_add_resource_offset prior to creating the root bus and enumerating
> the domain:
> 
> 	offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
> 			readq(membar2 + MB2_SHADOW_OFFSET);
> 	offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
> 			readq(membar2 + MB2_SHADOW_OFFSET + 8);
> ...
> 	pci_add_resource(&resources, &vmd->resources[0]);
> 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
> 
> 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
> 				       &vmd_ops, sd, &resources);
> 
> 
> The offset becomes the CPU-to-bridge translation function for
> programming the guest's VMD domain with bus addresses.
> 
> 
> In the patched guest's lspci, for the bridge you see:
> # lspci -v -s 10000:00:02.0
> 10000:00:02.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port C
> 	...
> 	Memory behind bridge: 94000000-943fffff
> 
> 
> But the kernel doesn't export the offset BAR for the endpoint:
> # lspci -v -s 10000:02:00.0
> 10000:02:00.0 Non-Volatile memory controller: Intel Corporation NVMe Datacenter SSD
> 	...
> 	Memory at f8810000 (64-bit, non-prefetchable) [size=16K]
> 	[virtual] Expansion ROM at f8800000 [disabled] [size=64K]
> 
> The endpoint is still programmed with the offset:
> # setpci -s 10000:02:00.0 10.l
> 94810004
> 
> 
> > 
> > Sorry if I'm way off, I'm piecing things together from scant
> > information here.  Please Cc me on future vfio related patches.  Thanks,
> > 
> > Alex
> >   
> No problem

Thanks for the confirmation.  The approach seems ok, but a subtle
side-effect of MemoryRegion quirks is that we're going to trap the
entire PAGE_SIZE range overlapping the quirk out to QEMU on guest
access.  The two registers at 0x2000 might be reserved for this
purpose, but is there anything else that could be performance sensitive
anywhere in that page?  If so, it might be less transparent, but more
efficient to invent a new quirk making use of config space (ex. adding
an emulated vendor capability somewhere known to be unused on the
device).  Thanks,

Alex

> > > In order to support existing VMDs, this quirk emulates the VMLOCK and
> > > HPA shadow registers for all VMD device ids which don't natively assist
> > > with passthrough. The Linux VMD driver is updated to allow existing VMD
> > > devices to query VMLOCK for passthrough support.
> > > 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  hw/vfio/pci-quirks.c | 103 +++++++++++++++++++++++++++++++++++++++++++
> > >  hw/vfio/pci.c        |   7 +++
> > >  hw/vfio/pci.h        |   2 +
> > >  hw/vfio/trace-events |   3 ++
> > >  4 files changed, 115 insertions(+)
> > > 
> > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > > index 2d348f8237..4060a6a95d 100644
> > > --- a/hw/vfio/pci-quirks.c
> > > +++ b/hw/vfio/pci-quirks.c
> > > @@ -1709,3 +1709,106 @@ free_exit:
> > >  
> > >      return ret;
> > >  }
> > > +
> > > +/*
> > > + * The VMD endpoint provides a real PCIe domain to the guest and the guest
> > > + * kernel performs enumeration of the VMD sub-device domain. Guest transactions
> > > + * to VMD sub-devices go through IOMMU translation from guest addresses to
> > > + * physical addresses. When MMIO goes to an endpoint after being translated to
> > > + * physical addresses, the bridge rejects the transaction because the window
> > > + * has been programmed with guest addresses.
> > > + *
> > > + * VMD can use the Host Physical Address in order to correctly program the
> > > + * bridge windows in its PCIe domain. VMD device 28C0 has HPA shadow registers
> > > + * located at offset 0x2000 in MEMBAR2 (BAR 4). The shadow registers are valid
> > > + * if bit 1 is set in the VMD VMLOCK config register 0x70. VMD devices without
> > > + * this native assistance can have these registers safely emulated as these
> > > + * registers are reserved.
> > > + */
> > > +typedef struct VFIOVMDQuirk {
> > > +    VFIOPCIDevice *vdev;
> > > +    uint64_t membar_phys[2];
> > > +} VFIOVMDQuirk;
> > > +
> > > +static uint64_t vfio_vmd_quirk_read(void *opaque, hwaddr addr, unsigned size)
> > > +{
> > > +    VFIOVMDQuirk *data = opaque;
> > > +    uint64_t val = 0;
> > > +
> > > +    memcpy(&val, (void *)data->membar_phys + addr, size);
> > > +    return val;
> > > +}
> > > +
> > > +static const MemoryRegionOps vfio_vmd_quirk = {
> > > +    .read = vfio_vmd_quirk_read,
> > > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > > +};
> > > +
> > > +#define VMD_VMLOCK  0x70
> > > +#define VMD_SHADOW  0x2000
> > > +#define VMD_MEMBAR2 4
> > > +
> > > +static int vfio_vmd_emulate_shadow_registers(VFIOPCIDevice *vdev)
> > > +{
> > > +    VFIOQuirk *quirk;
> > > +    VFIOVMDQuirk *data;
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    int ret;
> > > +
> > > +    data = g_malloc0(sizeof(*data));
> > > +    ret = pread(vdev->vbasedev.fd, data->membar_phys, 16,
> > > +                vdev->config_offset + PCI_BASE_ADDRESS_2);
> > > +    if (ret != 16) {
> > > +        error_report("VMD %s cannot read MEMBARs (%d)",
> > > +                     vdev->vbasedev.name, ret);
> > > +        g_free(data);
> > > +        return -EFAULT;
> > > +    }
> > > +
> > > +    quirk = vfio_quirk_alloc(1);
> > > +    quirk->data = data;
> > > +    data->vdev = vdev;
> > > +
> > > +    /* Emulate Shadow Registers */
> > > +    memory_region_init_io(quirk->mem, OBJECT(vdev), &vfio_vmd_quirk, data,
> > > +                          "vfio-vmd-quirk", sizeof(data->membar_phys));
> > > +    memory_region_add_subregion_overlap(vdev->bars[VMD_MEMBAR2].region.mem,
> > > +                                        VMD_SHADOW, quirk->mem, 1);
> > > +    memory_region_set_readonly(quirk->mem, true);
> > > +    memory_region_set_enabled(quirk->mem, true);
> > > +
> > > +    QLIST_INSERT_HEAD(&vdev->bars[VMD_MEMBAR2].quirks, quirk, next);
> > > +
> > > +    trace_vfio_pci_vmd_quirk_shadow_regs(vdev->vbasedev.name,
> > > +                                         data->membar_phys[0],
> > > +                                         data->membar_phys[1]);
> > > +
> > > +    /* Advertise Shadow Register support */
> > > +    pci_byte_test_and_set_mask(pdev->config + VMD_VMLOCK, 0x2);
> > > +    pci_set_byte(pdev->wmask + VMD_VMLOCK, 0);
> > > +    pci_set_byte(vdev->emulated_config_bits + VMD_VMLOCK, 0x2);
> > > +
> > > +    trace_vfio_pci_vmd_quirk_vmlock(vdev->vbasedev.name,
> > > +                                    pci_get_byte(pdev->config + VMD_VMLOCK));
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +int vfio_pci_vmd_init(VFIOPCIDevice *vdev)
> > > +{
> > > +    int ret = 0;
> > > +
> > > +    switch (vdev->device_id) {
> > > +    case 0x28C0: /* Native passthrough support */
> > > +        break;
> > > +    /* Emulates Native passthrough support */
> > > +    case 0x201D:
> > > +    case 0x467F:
> > > +    case 0x4C3D:
> > > +    case 0x9A0B:
> > > +        ret = vfio_vmd_emulate_shadow_registers(vdev);
> > > +        break;
> > > +    }
> > > +
> > > +    return ret;
> > > +}
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 5e75a95129..85425a1a6f 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -3024,6 +3024,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> > >          }
> > >      }
> > >  
> > > +    if (vdev->vendor_id == PCI_VENDOR_ID_INTEL) {
> > > +        ret = vfio_pci_vmd_init(vdev);
> > > +        if (ret) {
> > > +            error_report("Failed to setup VMD");
> > > +        }
> > > +    }
> > > +
> > >      vfio_register_err_notifier(vdev);
> > >      vfio_register_req_notifier(vdev);
> > >      vfio_setup_resetfn_quirk(vdev);
> > > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > > index 0da7a20a7e..e8632d806b 100644
> > > --- a/hw/vfio/pci.h
> > > +++ b/hw/vfio/pci.h
> > > @@ -217,6 +217,8 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> > >  int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
> > >  int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
> > >  
> > > +int vfio_pci_vmd_init(VFIOPCIDevice *vdev);
> > > +
> > >  void vfio_display_reset(VFIOPCIDevice *vdev);
> > >  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> > >  void vfio_display_finalize(VFIOPCIDevice *vdev);
> > > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > > index b1ef55a33f..ed64e477db 100644
> > > --- a/hw/vfio/trace-events
> > > +++ b/hw/vfio/trace-events
> > > @@ -90,6 +90,9 @@ vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "
> > >  vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
> > >  vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
> > >  
> > > +vfio_pci_vmd_quirk_shadow_regs(const char *name, uint64_t mb1, uint64_t mb2) "%s membar1_phys=0x%"PRIx64" membar2_phys=0x%"PRIx64
> > > +vfio_pci_vmd_quirk_vmlock(const char *name, uint8_t vmlock) "%s vmlock=0x%x"
> > > +
> > >  # common.c
> > >  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
> > >  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64  

