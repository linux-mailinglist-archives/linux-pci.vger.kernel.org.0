Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8553D74BA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhG0MH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 08:07:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3501 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhG0MH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 08:07:27 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYwGW1C17z6L9JT;
        Tue, 27 Jul 2021 19:55:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:07:20 +0200
Received: from localhost (10.47.8.150) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 13:07:19 +0100
Date:   Tue, 27 Jul 2021 13:06:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>
CC:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: RFC: Plumbers microconf topic: PCI DOE and related.
Message-ID: <20210727130653.00006a0a@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.150]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

There have been several mentions already of discussing some of the topics
around DOE mailboxes and the various things they enable at the upcoming
Plumbers VFIO/IOMMU/PCI microconf.

A few references:
https://lore.kernel.org/linux-pci/CAPcyv4i2ukD4ZQ_KfTaKXLyMakpSk=Y3_QJGV2P_PLHHVkPwFw@mail.gmail.com/
https://lore.kernel.org/linux-pci/20210520092205.000044ee@Huawei.com/

The intent of this email thread is to consolidate those suggestions into
a reasonable list of things to talk about (that I can then put into the
CFP system). Obviously Plumbers is still some time away and we will
"hopefully" resolve some of this stuff on this list before then. Also
open is who will lead this session if accepted.
(Perhaps Dan Williams + myself?)

Note this may be full of inaccuracies and (whilst I've tried not to) some
of my own opinions, so please do poke holes in it!

The latter parts are about CMA / SPDM for which a kernel RFC should be public
shortly (subject to summer holidays etc).

Quick background:

The elephant in the room for this topic is that there is on going related
specification work that we cannot discuss due to various confidentiality
rules. Everything in this email is based on published specs / public
discussions on the mailing lists.
Having said that there is plenty to talk about today, we just might
need a round 2 next year :)

Terms:

DOE - Data Object Exchange (PCI ECN) https://pcisig.com
 * A mailbox in PCI config space.
 
CDAT - Coherent Device Attribute table (UEFI hosted separate public spec)
 * Uses DOE mailbox to retrieve info on (CXL) EP such as bandwidth and
   latency of access to memory. 

CMA - Component Measurement and Authentication (PCI ECN) https://pcisig.com
 * Uses DMTF SPDM 1.1 based exchanges over DOE to authenticate EPs and
   carry out runtime measurements (kind of IMA for devices).

IDE - Integrity and Data Encryption (PCI ECN) https://pcisig.com
 * Link and selective (through switches) encryption.  Uses DOE / SPDM 1.1
   and builds on top of CMA.

Open Questions / Problems:
1. Control which software entity uses DOE.
   It does not appear to be safe (as in not going to disrupt each other rather
   than security) for multiple software entities (Userspace, Kernel, TEE,
   Firmware) to access an individual DOE instance on a device without
   mediation.  Some DOE protocols have clear reasons for Linux kernel
   access (e.g. CDAT) others are more debatable.
   Even running the discovery protocol could disrupt other users. Hardening
   against such disruption is probably best effort only (no guarantees).
   Question is: How to prevent this?
    a) Userspace vs Kernel. Are there valid reasons for userspace to access
       a DOE? If so do how do we enable that? Does a per protocol approach
       make sense? Potential vendor defined protocols? Do we need to lock
       out 'developer' tools such as setpci - or do we let developers shoot
       themselves in the foot?
    b) OS vs lower levels / TEE. Do we need to propose a means of telling the OS
       to keep its hands off a DOE?  How to do it?

2. CMA support.
   Usecases for in kernel CMA support and whether strong enough to support
   native access. (e.g. authentication of VF from a VM, or systems not running
   any suitable lower level software / TEE)
   Key / Certificate management. This is somewhat like IMA, but we probably
   need to manage the certificate chain separately for each CMA/SPDM instance. 
   Understanding provisioning models would be useful to guide this work.

3. IDE support
   Is native kernel support worthwhile? Perhaps good to discuss
   potential usecases + get some idea on priority for this feature.

4. Potential blockers on merging emulation support in QEMU. (I'm less sure
   on this one, but perhaps worth briefly touching on or a separate
   session on emulation if people are interested? Ben, do you think this
   would be worthwhile?)

There are other minor questions we might slip into the discussion, time
allowing such as need for async support handling in the kernel DOE code.

For all these features, we have multiple layers on top of underlying PCI
so discussion of 'how' to support this might be useful.
1) Service model - detected at PCI subsystem level, services to drivers.
2) Driver initiated mode - library code, but per driver instantiation etc.

That's what have come up with this morning, so please poke holes in it and
point out what I've forgotten about.

Note for an actual CFP proposal, I'll probably split this into at least two.
Topic 1: DOE only.  Topic 2: CMA / IDE. As there is a lot here, for some
topics we may be looking at introduce the topic + questions rather than
resolving everything on the day.

Thanks,

Jonathan

p.s. Perhaps it is a little unusual to have this level of 'planning' discussion
explicitly on list, but we are working under some unusual constraints
and inclusiveness and openness always good anyway!

