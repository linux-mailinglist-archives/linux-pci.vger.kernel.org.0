Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71DA1121AF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 04:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLDDBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 22:01:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:47720 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfLDDBj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 22:01:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 19:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; 
   d="scan'208";a="385576029"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.254.106.153])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2019 19:01:37 -0800
Date:   Tue, 3 Dec 2019 19:01:36 -0800
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
Message-ID: <20191203190136.00007171@intel.com>
In-Reply-To: <20191125180247.GD945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
        <20191122160102.00004489@intel.com>
        <20191125180247.GD945122@lophozonia>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

Sorry for the delay, I was out last week. Comments inline below.

On Mon, 25 Nov 2019 19:02:47 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:
> > > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD
> > > and IORT for Arm). From my point of view IORT is easier to
> > > extend, since we just need to introduce a new node type. There
> > > are no dependencies to Arm in the Linux IORT driver, so it works
> > > well with CONFIG_X86. 
> > From my limited understanding, IORT and VIOT is to solve device
> > topology enumeration only? I am not sure how it can be expanded to
> > cover information beyond device topology. e.g. DMAR has NUMA
> > information and root port ATS, I guess they are not used today in
> > the guest but might be additions in the future.  
> 
> The PCI root-complex node of IORT has an ATS attribute, which we can
> already use. However its scope is the root complex, not individual
> root ports like with DMAR.
> 
> I'm not very familiar with NUMA, but it looks like we just need to
> specify a proximity domain in relation to the SRAT table, for each
> viommu? The SMMUv3 node in IORT has a 4-bytes "proximity domain"
> field for this. We can add the same to the VIOT virtio-iommu nodes
> later, since the structures are extensible.
> 
I think there the proximity domain is more for each assigned device
than vIOMMU. vIOMMU in the guest can have assigned devices belong to
different pIOMMU and proximity domains. If the guest owns the first
level page tables (gIOVA or SVA), we want to make sure page tables are
allocated from the close proximity domain.

My understanding is virtio IOMMU supports both virtio devices and
assigned devices. we could care less about the former in terms of NUMA.

In ACPI, we have _PXM method to retrieve device proximity domain. I
don't know if there is something equivalent or a generic way to get
_PXM information. I think VMM also need to make sure when an assigned
device is used with vIOMMU, there are some memory is allocated from the
device's proximity domain.

> But it might be better to keep the bare minimum information in the FW
> descriptor, and put the rest in the virtio-iommu. So yes topology
> enumeration is something the device cannot do itself (not fully that
> is, see (2)) but for the rest, virtio-iommu's PROBE request can
> provide details about each endpoint in relation to their physical
> IOMMU.
> 
> We could for example add a bit in a PROBE property saying that the
> whole path between the IOMMU and the endpoint supports ATS. For NUMA
> it might also be more interesting to have a finer granularity, since
> one viommu could be managing endpoints that are behind different
> physical IOMMUs. If in the future we want to allocate page tables
> close to the physical IOMMU for example, we might need to describe
> multiple NUMA nodes per viommu, using the PROBE request.
> 
Should we reinvent something for NUMA or use ACPI's SRAT, _PXM? I am
not sure how it is handled today in QEMU in terms of guest-host NUMA
proximity domain mapping.

> Thanks,
> Jean

