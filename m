Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14533D9F6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCPQ7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 12:59:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2704 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhCPQ7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 12:59:06 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F0K6V1Q8rz680Mv;
        Wed, 17 Mar 2021 00:50:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 16 Mar 2021 17:59:04 +0100
Received: from localhost (10.47.94.123) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Mar
 2021 16:59:03 +0000
Date:   Tue, 16 Mar 2021 16:57:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object
 Exchange
Message-ID: <20210316165748.00003f26@Huawei.com>
In-Reply-To: <20210316162952.00001ab7@Huawei.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
        <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
        <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
        <20210316162952.00001ab7@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.123]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Mar 2021 16:29:52 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:


> >   
> > > +               [0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, 0001) |
> > > +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, 0),
> > > +               [1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),
> > > +               [2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index)
> > > +       };
> > > +       u32 response[3];
> > > +       int ret;
> > > +
> > > +       ret = pcie_doe_exchange(doe, request, sizeof(request), response, sizeof(response));
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response[2]);
> > > +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response[2]);
> > > +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response[2]);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * pcie_doe_protocol_check() - check if this DOE mailbox supports specific protocol
> > > + * @doe: DOE state structure
> > > + * @vid: Vendor ID
> > > + * @protocol: Protocol number as defined by Vendor
> > > + * Returns: 0 on success, <0 on error
> > > + */
> > > +int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol)    
> > 
> > Not clear to me that this is a comfortable API for a driver. I would
> > expect that at registration time all the supported protocols would be
> > retrieved and cached in the 'struct pcie_doe' context and then the
> > host driver could query from there without going back to the device
> > again.  
> 
> I'm not sure I follow.
> 
> Any driver will fall into one of the following categories:
> a) Already knows what protocols are available on a
>    given DOE instance perhaps because that's a characteristic of the hardware
>    supported, in which case it has no reason to check (unless driver writer
>    is paranoid)
> b) It has no way to know (e.g. class driver), then it makes sense to query
>    the DOE instance to find out what protocols are available.
> 
> Absolutely we could cache them, but it wouldn't change the interface
> presented to the driver. I think doing so at this stage is
> premature optimization.
> 
> We could present this at a different level and wrap it up as a
> find_doe that will return a DOE instance that supports the desired
> protocol, but then that puts the burden of reference counting etc
> for the different DOE instances on the core - the one thing I think
> we want to avoid.
> 
> So far we have no evidence any device will actually need that.
> 
> Of the existing protocols, only a few are allowed to coexist with
> each other and in well defined sets (CMA and IDE for example).
> 
> An alternative model we could look at (which is much more complex)
> is to have something like the following: 
> 
> struct pcie_doe_set - Central location which is responsible for
> all DOE mailboxes on a PCI device.
> 
> At init that scans all DOE mailboxes and builds a look up table
> from [vid, protocol] to [struct pcie_doe]
> Note this is 1 to 1, so if a protocol is supported on multiple
> mailboxes we use the first one.
> 
> pcie_doe_exchange(struct pcie_doe_set, u16 vid, u8 protocol...)
> Looks up the relevant DOE instance and does exchange on that.
> 
> So far I'm not convinced we should engage in this complexity.
> Nothing stops us adding it if and when it becomes apparent we
> actually need it.
> 
> An intermediate point would be to add basic list and reference
> counting infrastructure so that a driver can call
> 
> struct pcie_doe *pcie_doe_get(struct pci_dev, u16 vid, u8 protocol)
> void pci_doe_put(struct pci_doe *doe);
> 
> That means at least a list_head and possibly a lock being added
> to pci_dev. Not sure how Bjorn will feel about that.
> 
> I might see how bad this looks for v2.

Lifetime element of the DOE could be avoided by simply having

pcie_doe_register_all()
and
pcie_doe_unregister_all()

and so managing all DOE instances in one unit.

I'm not sure I like it, but certainly makes things simple.
After pcie_doe_register_all() call, all DOEs are ready to use
and we can have simple pcie_doe_find() to get one with
appropriate protocols.  There is never any need to specifically
release it because they are all cleaned up together in remove
/release path.

I'll put this together for a v2 and we can see how it shapes
up.

Jonathan


