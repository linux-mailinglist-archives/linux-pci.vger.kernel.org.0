Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6AC3D8A1C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG1I5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 28 Jul 2021 04:57:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3509 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1I5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 04:57:30 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZRx96H8Lz6BBQT;
        Wed, 28 Jul 2021 16:42:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 10:57:27 +0200
Received: from localhost (10.210.165.224) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 09:57:25 +0100
Date:   Wed, 28 Jul 2021 09:56:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Krzysztof =?iso-8859-2?Q?Wilczy=F1ski?= <kw@linux.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Fangjian <f.fangjian@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Varun Sampath" <varuns@nvidia.com>
Subject: Re: RFC: Plumbers microconf topic: PCI DOE and related.
Message-ID: <20210728095658.00002def@Huawei.com>
In-Reply-To: <BL0PR12MB2532CC3B64CAB199051D5AA4BDE99@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <20210727130653.00006a0a@Huawei.com>
        <BL0PR12MB2532CC3B64CAB199051D5AA4BDE99@BL0PR12MB2532.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.210.165.224]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Jul 2021 16:50:05 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> Hi Jonathan, 
> 
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>  
> 
> 
> > Open Questions / Problems:
> > 1. Control which software entity uses DOE.
> >    It does not appear to be safe (as in not going to disrupt each other rather
> >    than security) for multiple software entities (Userspace, Kernel, TEE,
> >    Firmware) to access an individual DOE instance on a device without
> >    mediation.  Some DOE protocols have clear reasons for Linux kernel
> >    access (e.g. CDAT) others are more debatable.
> >    Even running the discovery protocol could disrupt other users. Hardening
> >    against such disruption is probably best effort only (no guarantees).
> >    Question is: How to prevent this?
> >     a) Userspace vs Kernel. Are there valid reasons for userspace to access
> >        a DOE? If so do how do we enable that? Does a per protocol approach
> >        make sense? Potential vendor defined protocols? Do we need to lock
> >        out 'developer' tools such as setpci - or do we let developers shoot
> >        themselves in the foot?
> >     b) OS vs lower levels / TEE. Do we need to propose a means of telling the
> > OS
> >        to keep its hands off a DOE?  How to do it?
> > 
> > 2. CMA support.
> >    Usecases for in kernel CMA support and whether strong enough to support
> >    native access. (e.g. authentication of VF from a VM, or systems not running
> >    any suitable lower level software / TEE)  
> 
> Any time the device is reset, you'd want to measure again. I'd think every kernel
> PF FLR/SBR/CXL reset needs to be followed by a measurement of the device
> In kernel. Of course needs bigger discussion on the plumbing/infrastructure
> to report the measurement and attest that the measurements post reset are valid.
> Instead of native access, could it be mediated via ACPI or UEFI runtime service?
> Not clear that ACPI/UEFI would be the appropriate mediator in all cases. 

Absolutely agree that checking on reset.  There will be cases where it has
to be mediated by firmware of some type, as same DOE can be in use for IDE
which may well be controlled by an entity other than the kernel.  However,
there are other cases where the kernel will probably want to do it directly
- particularly as CMA can exist for VFs. From the ECN:

"In other use cases it may be desirable to evaluate individual Functions.
 For example, when a Function is directly assigned to a Virtual Machine
 (VM) that VM can use CMA via DOE to confirm that the hardware element
 assigned to it meets the VM’s requirements. For such use cases, the
 security exchange with the individual Function is not required to match
 identically the results received from other Functions."

You also raise the question of measurement management which is still very
much on the todo list. I'll add that to the cfp proposal as possible
discussion topic.  My assumption so far is it will look very much like IMA
but I've not gotten down to the details.

> 
> >    Key / Certificate management. This is somewhat like IMA, but we probably
> >    need to manage the certificate chain separately for each CMA/SPDM
> > instance.
> >    Understanding provisioning models would be useful to guide this work.
> > 
> > 3. IDE support
> >    Is native kernel support worthwhile? Perhaps good to discuss
> >    potential usecases + get some idea on priority for this feature.
> > 
> > 4. Potential blockers on merging emulation support in QEMU. (I'm less sure
> >    on this one, but perhaps worth briefly touching on or a separate
> >    session on emulation if people are interested? Ben, do you think this
> >    would be worthwhile?)
> > 
> > There are other minor questions we might slip into the discussion, time
> > allowing such as need for async support handling in the kernel DOE code.
> > 
> > For all these features, we have multiple layers on top of underlying PCI so
> > discussion of 'how' to support this might be useful.
> > 1) Service model - detected at PCI subsystem level, services to drivers.
> > 2) Driver initiated mode - library code, but per driver instantiation etc.
> > 
> > That's what have come up with this morning, so please poke holes in it and
> > point out what I've forgotten about.
> > 
> > Note for an actual CFP proposal, I'll probably split this into at least two.
> > Topic 1: DOE only.  Topic 2: CMA / IDE. As there is a lot here, for some topics
> > we may be looking at introduce the topic + questions rather than resolving
> > everything on the day.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > p.s. Perhaps it is a little unusual to have this level of 'planning' discussion
> > explicitly on list, but we are working under some unusual constraints and
> > inclusiveness and openness always good anyway!  
> 

