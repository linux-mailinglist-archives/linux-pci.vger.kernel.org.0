Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2412827C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLTSye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 13:54:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:17674 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfLTSye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 13:54:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 10:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="267593304"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.254.180.107])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2019 10:54:31 -0800
Date:   Fri, 20 Dec 2019 10:54:30 -0800
From:   "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-pci@vger.kernel.org>, <virtio-dev@lists.oasis-open.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <eric.auger@redhat.com>,
        <sebastien.boeuf@intel.com>, <kevin.tian@intel.com>,
        jacob.jun.pan@intel.com
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191220105430.0000437b@intel.com>
In-Reply-To: <20191218112044.GA2371701@myrica>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
        <20191122160102.00004489@intel.com>
        <20191125180247.GD945122@lophozonia>
        <20191203190136.00007171@intel.com>
        <20191218112044.GA2371701@myrica>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Dec 2019 12:20:44 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Tue, Dec 03, 2019 at 07:01:36PM -0800, Jacob Pan (Jun) wrote:
> > Hi Jean,
> > 
> > Sorry for the delay, I was out last week. Comments inline below.
> > 
> > On Mon, 25 Nov 2019 19:02:47 +0100
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:  
> > > > > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for
> > > > > AMD and IORT for Arm). From my point of view IORT is easier to
> > > > > extend, since we just need to introduce a new node type. There
> > > > > are no dependencies to Arm in the Linux IORT driver, so it
> > > > > works well with CONFIG_X86.   
> > > > From my limited understanding, IORT and VIOT is to solve device
> > > > topology enumeration only? I am not sure how it can be expanded
> > > > to cover information beyond device topology. e.g. DMAR has NUMA
> > > > information and root port ATS, I guess they are not used today
> > > > in the guest but might be additions in the future.    
> > > 
> > > The PCI root-complex node of IORT has an ATS attribute, which we
> > > can already use. However its scope is the root complex, not
> > > individual root ports like with DMAR.
> > > 
> > > I'm not very familiar with NUMA, but it looks like we just need to
> > > specify a proximity domain in relation to the SRAT table, for each
> > > viommu? The SMMUv3 node in IORT has a 4-bytes "proximity domain"
> > > field for this. We can add the same to the VIOT virtio-iommu nodes
> > > later, since the structures are extensible.
> > >   
> > I think there the proximity domain is more for each assigned device
> > than vIOMMU. vIOMMU in the guest can have assigned devices belong to
> > different pIOMMU and proximity domains. If the guest owns the first
> > level page tables (gIOVA or SVA), we want to make sure page tables
> > are allocated from the close proximity domain.
> > 
> > My understanding is virtio IOMMU supports both virtio devices and
> > assigned devices. we could care less about the former in terms of
> > NUMA.
> > 
> > In ACPI, we have _PXM method to retrieve device proximity domain. I
> > don't know if there is something equivalent or a generic way to get
> > _PXM information. I think VMM also need to make sure when an
> > assigned device is used with vIOMMU, there are some memory is
> > allocated from the device's proximity domain.
> >   
> > > But it might be better to keep the bare minimum information in
> > > the FW descriptor, and put the rest in the virtio-iommu. So yes
> > > topology enumeration is something the device cannot do itself
> > > (not fully that is, see (2)) but for the rest, virtio-iommu's
> > > PROBE request can provide details about each endpoint in relation
> > > to their physical IOMMU.
> > > 
> > > We could for example add a bit in a PROBE property saying that the
> > > whole path between the IOMMU and the endpoint supports ATS. For
> > > NUMA it might also be more interesting to have a finer
> > > granularity, since one viommu could be managing endpoints that
> > > are behind different physical IOMMUs. If in the future we want to
> > > allocate page tables close to the physical IOMMU for example, we
> > > might need to describe multiple NUMA nodes per viommu, using the
> > > PROBE request. 
> > Should we reinvent something for NUMA or use ACPI's SRAT, _PXM?   
> 
> Regardless whether we put it in the VIOT or in the virtio-iommu PROBE
> request, we necessarily need to reuse the node IDs defined by SRAT (or
> numa-node-id on devicetree, also a 32-bit value). A virtio-pci based
> virtio-iommu already has the _PXM of its closest bridge and wouldn't
> need anything more in the VIOT, while a virtio-mmio based
> virtio-iommu would need a proximity domain field in the VIOT. That
> could be added later since the table is extensible, but as you
> pointed out, that information might not be very useful.
> 
> > I am not sure how it is handled today in QEMU in terms of guest-host
> > NUMA proximity domain mapping.  
> 
> It looks like the user can specify this guest-host mapping on the
> command-line:
> 
>   -object memory-backend-ram,id=mem0,size=4G,host-nodes=3,policy=bind
>   -object memory-backend-ram,id=mem1,size=4G,host-nodes=4,policy=bind
>   -numa node,memdev=mem0,nodeid=numa0
>   -numa node,memdev=mem1,nodeid=numa1
>   -numa cpu,node-id=numa0,socket-id=0
>   -numa cpu,node-id=numa1,socket-id=1
> 
> numa0 and numa1 would get proximity domains 0 and 1, corresponding to
> host domains 3 and 4. It is also possible to specify the NUMA node of
> a PCI bus (via the PCI expander bridge), and therefore to assign a
> VFIO PCI device in the same proximity domain as its physical location.
> 
>   -device pxb,id=bridge1,bus=pci.0,numa_node=1 (simplified)
>   -device vfio-pci,host=03:01.0,bus=bridge1
> 
Thanks a lot for the thorough explanation. I will give that a try on
x86, I assume the ACPI tables also built to match these cmdline options.
> Linux can use this information to allocate DMA close to the endpoint
> (see for example __iommu_dma_alloc_pages()). For page tables
> allocation, io-pgtables currently takes the node ID of the IOMMU
> device, not the endpoint. For the scenario you describe (virtio-iommu
> endpoints managed by different physical IOMMU), we would need to take
> for example the node ID of the first endpoint in the iommu_domain for
> which we're allocating page tables.
> 
If iommu_domain is shared by multiple device from different NUMA node,
I guess taking the first one is as good as anyone. It would not be
an optimal configuration.
> Is it safe to assume that the pIOMMU is in the same proximity domain
> as the physical endpoint?
I think it is a safe assumption.
>  If that's the case, then the guest already
> has all the information it needs. Otherwise it's easy to add a
> proximity domain PROBE property for each endpoint. Configuring the
> host to pass that information might be more difficult.
> 
I agree, guest should always allocate DMA and IOVA page tables basedon
the endpoint. VT-d currently allocates page table pages based on IOMMU
NUMA node, that might have to change.
> 
> Off topic, I've been wondering how to make iommu-sva aware of NUMA
> topology as well, so that when handling a page request we allocate
> memory on the faulting device's NUMA node, but I think it might
> require invasive changes to the mm subsystem, to pass a NUMA node to
> handle_mm_fault().
> 
> Thanks,
> Jean

