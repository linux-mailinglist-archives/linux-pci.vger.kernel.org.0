Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536533407D1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCRO1U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 18 Mar 2021 10:27:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2711 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRO0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 10:26:49 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1ThH0tN4z6806m;
        Thu, 18 Mar 2021 22:20:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 15:26:47 +0100
Received: from localhost (10.47.92.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 14:26:46 +0000
Date:   Thu, 18 Mar 2021 14:25:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Chris Browy <cbrowy@avery-design.com>, <linux-cxl@vger.kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object
 Exchange
Message-ID: <20210318142529.00001507@Huawei.com>
In-Reply-To: <CAPcyv4hJG08RaksW3jH_Q5ASqpzX5MtfNFcLqMxAH5jwTidk=w@mail.gmail.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
        <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
        <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
        <20210316162952.00001ab7@Huawei.com>
        <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
        <6F0B8DDD-E661-40C8-839B-1B77998EFF23@avery-design.com>
        <CAPcyv4hJG08RaksW3jH_Q5ASqpzX5MtfNFcLqMxAH5jwTidk=w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.92.175]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 18:30:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Btw your mailer does something odd with the "In-Reply-To:" field, I
> need to fix it up manually to include your address.
> 
> On Tue, Mar 16, 2021 at 4:28 PM Chris Browy <cbrowy@avery-design.com> wrote:
> >
> > Please address and clarify 2 queries below...
> >
> >  
> > > On Mar 16, 2021, at 2:14 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 9:31 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > >>
> > >> On Mon, 15 Mar 2021 12:45:49 -0700
> > >> Dan Williams <dan.j.williams@intel.com> wrote:
> > >>  
> > >>> Hey Jonathan, happy to see this, some comments below...  
> > >>
> > >> Hi Dan,
> > >>
> > >> Thanks for taking a look!
> > >>  
> > >>>
> > >>> On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
> > >>> <Jonathan.Cameron@huawei.com> wrote:  
> > >>>>
> > >>>> Introduced in an ECN to the PCI 5.0, DOE provides a config space
> > >>>> based mailbox with standard protocol discovery.  Each mailbox
> > >>>> is accessed through a DOE PCIE Extended Capability.
> > >>>>
> > >>>> A device may have 1 or more DOE mailboxes, each of which is allowed
> > >>>> to support any number of protocols (some DOE protocols
> > >>>> specifications apply additional restrictions).  A given protocol
> > >>>> may be supported on more than one DOE mailbox on a given function.  
> > >>>
> > >>> Are all those protocol instances shared?
> > >>> I'm trying to mental model
> > >>> whether, for example, an auxiliary driver instance could be loaded per
> > >>> DOE mailbox, or if there would need to be coordination of a given
> > >>> protocol no matter how many DOE mailboxes on that device implemented
> > >>> that protocol.  
> > >>
> > >> Just to check I've understood corectly, you mean multiple instances of same
> > >> protocol across different DOE mailboxes on a given device?
> > >>  
> > >
> > > Right.  
> >
> > Could you confirm this case for clarity?  A CXL device may have multiple VF/PF.
> > For example, PF=0 could have one or more DOE instances for CDAT protocol.
> > The driver will scan PF=0 for all DOE instances and finding one or more of CDAT
> > protocol will combine/manage them.  I had not considered multiple CDAT tables
> > for single PF.  For CXL devices with multiple PF’s the same process would be
> > carried out on PF=1-N.  
> 
> This patch has nothing to do with CXL. This is a general discussion of
> how a PCIE device implements a DOE mailbox or set of mailboxes. The
> DOE definition is PF-only afaics from the DOE specification.
> 
> The CXL specification only says that a device can implement a CDAT per
> DOE capability instance, so the CXL spec does not limit the number of
> DOE instances to 1, but I can't think of a practical reason to support
> more than one.
> 
> [..]
> > >>> https://cfp.osfc.io/media/osfc2020/submissions/ECQ88N/resources/An_open_source_SPDM_implementation_for_secure_devi_kmIgAQe.pdf  
> > >>
> > >> Nice!  Looking at CMA / IDE emulation was on my todo list and that looks like
> > >> it might make that job a lot easier.  
> >
> > Would it be useful to integrate the openspdm’s SpdmResponderEmu.c onto the QEMU’s CXL Type3 Device’s
> > DOE backend for CMA/IDE testing?  Doesn’t look hard to do.  
> 
> Yes, I do think it would be useful.

Agreed.  Very useful indeed.

Jonathan
