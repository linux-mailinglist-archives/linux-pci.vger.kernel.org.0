Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F64A6DD6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 10:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiBBJdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 04:33:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4611 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBBJdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 04:33:04 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jpc122NHpz67xJ7;
        Wed,  2 Feb 2022 17:28:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 10:33:02 +0100
Received: from localhost (10.47.70.124) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Feb
 2022 09:33:01 +0000
Date:   Wed, 2 Feb 2022 09:33:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 24/40] cxl/port: Add a driver for 'struct cxl_port'
 objects
Message-ID: <20220202093301.00004876@Huawei.com>
In-Reply-To: <CAPcyv4gA+QTS1vD83PjC4AmDtgCm79LDq+H47fPKwh=aN6MfVQ@mail.gmail.com>
References: <164298424635.3018233.9356036382052246767.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220131181118.00002471@Huawei.com>
        <CAPcyv4gA+QTS1vD83PjC4AmDtgCm79LDq+H47fPKwh=aN6MfVQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.124]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 12:43:01 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Jan 31, 2022 at 10:11 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 26 Jan 2022 12:16:52 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > The need for a CXL port driver and a dedicated cxl_bus_type is driven by
> > > a need to simultaneously support 2 independent physical memory decode
> > > domains (cache coherent CXL.mem and uncached PCI.mmio) that also
> > > intersect at a single PCIe device node. A CXL Port is a device that
> > > advertises a  CXL Component Register block with an "HDM Decoder
> > > Capability Structure".
> > >  
> > > >From Documentation/driver-api/cxl/memory-devices.rst:  
> > >
> > >     Similar to how a RAID driver takes disk objects and assembles them into
> > >     a new logical device, the CXL subsystem is tasked to take PCIe and ACPI
> > >     objects and assemble them into a CXL.mem decode topology. The need for
> > >     runtime configuration of the CXL.mem topology is also similar to RAID in
> > >     that different environments with the same hardware configuration may
> > >     decide to assemble the topology in contrasting ways. One may choose
> > >     performance (RAID0) striping memory across multiple Host Bridges and
> > >     endpoints while another may opt for fault tolerance and disable any
> > >     striping in the CXL.mem topology.
> > >
> > > The port driver identifies whether an endpoint Memory Expander is
> > > connected to a CXL topology. If an active (bound to the 'cxl_port'
> > > driver) CXL Port is not found at every PCIe Switch Upstream port and an
> > > active "root" CXL Port then the device is just a plain PCIe endpoint
> > > only capable of participating in PCI.mmio and DMA cycles, not CXL.mem
> > > coherent interleave sets.
> > >
> > > The 'cxl_port' driver lets the CXL subsystem leverage driver-core
> > > infrastructure for setup and teardown of register resources and
> > > communicating device activation status to userspace. The cxl_bus_type
> > > can rendezvous the async arrival of platform level CXL resources (via
> > > the 'cxl_acpi' driver) with the asynchronous enumeration of Memory
> > > Expander endpoints, while also implementing a hierarchical locking model
> > > independent of the associated 'struct pci_dev' locking model. The
> > > locking for dport and decoder enumeration is now handled in the core
> > > rather than callers.
> > >
> > > For now the port driver only enumerates and registers CXL resources
> > > (downstream port metadata and decoder resources) later it will be used
> > > to take action on its decoders in response to CXL.mem region
> > > provisioning requests.  
> >  
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > [djbw: add theory of operation document, move enumeration infra to core]
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> >
> > Nice docs. A few comments inline
> >
> > All trivial though, so
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> >
> >
> > ...
> >  
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 2b09d04d3568..682e7cdbcc9c 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -40,6 +40,11 @@ static int cxl_device_id(struct device *dev)  
> >
> > ...
> >  
> > >
> > > +/*
> > > + * Since root-level CXL dports cannot be enumerated by PCI they are not
> > > + * enumerated by the common port driver that acquires the port lock over
> > > + * dport add/remove. Instead, root dports are manually added by a
> > > + * platform driver and cond_port_lock() is used to take the missing port
> > > + * lock in that case.
> > > + */
> > > +static void cond_port_lock(struct cxl_port *port)  
> >
> > Could the naming here make it clear what the condition is?
> > cxl_port_lock_if_root(), or something like that?  
> 
> Sure, how about cond_cxl_root_lock()? Where the cond_ prefix is
> matching other helpers like cond_resched().

Works for me. Thanks,

