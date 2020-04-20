Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3C1B133F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTRiN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 20 Apr 2020 13:38:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:2056 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRiN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 13:38:13 -0400
IronPort-SDR: 4O9S3bB399/mvlbO/khglyDaiARhq27kGO43jKytPh9kJKXs2/kyVtFQ/JGDZ+as4jFRJTE2Ck
 cjysrQKmW1Rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:38:12 -0700
IronPort-SDR: jXFMh9f+85u+2xYc9LWBLO1qTCipRpzuYVQpwJK5C1scNWIv66sCzwn7tksxx7xdWh5fiebynf
 FmNQdC49Ojug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="429210397"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2020 10:38:12 -0700
Date:   Mon, 20 Apr 2020 10:44:10 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420104410.3d1622e7@jacob-builder>
In-Reply-To: <65709b48-526b-ff43-760c-0fe0317d5e9c@amd.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
        <20200414170252.714402-3-jean-philippe@linaro.org>
        <20200416072852.GA32000@infradead.org>
        <20200416085402.GB1286150@myrica>
        <20200416121331.GA18661@infradead.org>
        <20200420074213.GA3180232@myrica>
        <20200420081034.GA17305@infradead.org>
        <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
        <20200420115504.GA20664@infradead.org>
        <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
        <65709b48-526b-ff43-760c-0fe0317d5e9c@amd.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 20 Apr 2020 11:00:28 -0400
Felix Kuehling <felix.kuehling@amd.com> wrote:

> Am 2020-04-20 um 8:40 a.m. schrieb Christian König:
> > Am 20.04.20 um 13:55 schrieb Christoph Hellwig:  
> >> On Mon, Apr 20, 2020 at 01:44:56PM +0200, Christian König wrote:  
> >>> Am 20.04.20 um 10:10 schrieb Christoph Hellwig:  
> >>>> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker
> >>>> wrote:  
> >>>>> Right, I can see the appeal. I still like having a single mmu
> >>>>> notifier per
> >>>>> mm because it ensures we allocate a single PASID per mm (as
> >>>>> required by
> >>>>> x86). I suppose one alternative is to maintain a hashtable of
> >>>>> mm->pasid,
> >>>>> to avoid iterating over all bonds during allocation.  
> >>>> Given that the PASID is a pretty generic and important concept
> >>>> can we just add it directly to the mm_struct and allocate it
> >>>> lazily once we first need it?  
> >>> Well the problem is that the PASID might as well be device
> >>> specific. E.g.
> >>> some devices use 16bit PASIDs, some 15bit, some other only 12bit.
> >>>
> >>> So what could (at least in theory) happen is that you need to
> >>> allocate different PASIDs for the same process because different
> >>> devices need one.  
> >> This directly contradicts the statement from Jean-Philippe above
> >> that x86 requires a single PASID per mm_struct.  If we may need
> >> different PASIDs for different devices and can actually support
> >> this just allocating one per [device, mm_struct] would make most
> >> sense of me, as it doesn't couple otherwise disjoint state.  
> >
> > Well I'm not an expert on this topic. Felix can probably tell you a
> > bit more about that.
> >
> > Maybe it is sufficient to keep the allocated PASIDs as small as
> > possible and return an appropriate error if a device can't deal with
> > the allocated number.
> >
> > If a device can only deal with 12bit PASIDs and more than 2^12 try
> > to use it there isn't much else we can do than returning an error
> > anyway.  
> 
> I'm probably missing some context. But let me try giving a useful
> reply.
> 
> The hardware allows you to have different PASIDs for each device
> referring to the same address space. But I think it's OK for software
> to choose not to do that. If Linux wants to manage one PASID
> namespace for all devices, that's a reasonable choice IMO.
> 
On VT-d, system wide PASID namespace is required. Here is a section of
the documentation I am working on.

Namespaces
====================================================
IOASIDs are limited system resources that default to 20 bits in
size. Since each device has its own table, theoretically the namespace
can be per device also. However, VT-d also supports shared workqueue
and ENQCMD[1] where one IOASID could be used to submit work on
multiple devices. This requires IOASID to be system-wide on Intel VT-d
platforms. This is also the reason why guest must use emulated virtual
command interface to allocate IOASID from the host.

On VT-d, storage of IOASID table is at per device while the
granularity of assignment is per IOASID. Even though, each guest
IOASID must have a backing host IOASID, guest IOASID can be different
than its host IOASID. The namespace of guest IOASID is controlled by
VMM, which decideds whether identity mapping of G-H IOASIDs is necessary.

1.
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

For the per mm_struct PASID question by Christian, we are proposing
that in x86 context and a lazy free.

https://lkml.org/lkml/2020/3/30/910

> Different devices have different limits for the size of PASID they can
> support. For example AMD GPUs support 16-bits but the IOMMU supports
> less. So on APUs we use small PASIDs for contexts that want to use
> IOMMUv2 to access memory, but bigger PASIDs for contexts that do not.
> 
> I choose the word "context" deliberately, because the amdgpu driver
> uses PASIDs even when we're not using IOMMUv2, and we're using them to
> identify GPU virtual address spaces. There can be more than one per
> process. In practice you can have two, one for graphics (not SVM,
> doesn't use IOMMUv2) and one for KFD compute (SVM, can use IOMMUv2 on
> APUs).
> 
> Because the IOMMUv2 supports only smaller PASIDs, we want to avoid
> exhausting that space with PASID allocations that don't use the
> IOMMUv2. So our PASID allocation function has a "size" parameter, and
> we try to allocated a PASID as big as possible in order to leave more
> precious smaller PASIDs for contexts that need them.
> 
> The bottom line is, when you allocate a PASID for a context, you want
> to know how small it needs to be for all the devices that want to use
> it. If you make it too big, some device will not be able to use it.
> If you make it too small, you waste precious PASIDs that could be
> used for other contexts that need them.
> 
So for AMD, system-wide PASID allocation works with the
restriction/optimization above?

> Regards,
>   Felix
> 

[Jacob Pan]
