Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4628E233
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgJNOba convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 14 Oct 2020 10:31:30 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:53029 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgJNOba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 10:31:30 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 10:31:29 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.51])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3D0A36C2DB23;
        Wed, 14 Oct 2020 16:24:19 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 14 Oct
 2020 16:24:18 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R00689b05b96-c54c-41c6-80c0-fcfcc1cbbabc,
                    7756CE0ACB29AF3C5E7C930ECAC39FAF42B28156) smtp.auth=groug@kaod.org
Date:   Wed, 14 Oct 2020 16:24:16 +0200
From:   Greg Kurz <groug@kaod.org>
To:     =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
CC:     Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] powerpc/pci: Fix PHB removal/rescan on PowerNV
Message-ID: <20201014162416.5e29e477@bahia.lan>
In-Reply-To: <06bf1b7b-e9b4-44b0-1aad-60b938f8e924@kaod.org>
References: <20200925092258.525079-1-clg@kaod.org>
        <CAOSf1CGW7ocYm2BXFiy9Nmi+G+xwVcqQzTqPo_nss_tmpG_V=w@mail.gmail.com>
        <06bf1b7b-e9b4-44b0-1aad-60b938f8e924@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 122b0630-0bca-4820-9f76-70f6754687f5
X-Ovh-Tracer-Id: 725642493523696035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedriedugdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Oct 2020 06:37:02 +0200
Cédric Le Goater <clg@kaod.org> wrote:

> On 10/8/20 4:23 AM, Oliver O'Halloran wrote:
> > On Fri, Sep 25, 2020 at 7:23 PM Cédric Le Goater <clg@kaod.org> wrote:
> >>
> >> To fix an issue with PHB hotplug on pSeries machine (HPT/XIVE), commit
> >> 3a3181e16fbd introduced a PPC specific pcibios_remove_bus() routine to
> >> clear all interrupt mappings when the bus is removed. This routine
> >> frees an array allocated in pcibios_scan_phb().
> >>
> >> This broke PHB hotplug on PowerNV because, when a PHB is removed and
> >> re-scanned through sysfs, the PCI layer un-assigns and re-assigns
> >> resources to the PHB but does not destroy and recreate the PCI
> >> controller structure. Since pcibios_remove_bus() does not clear the
> >> 'irq_map' array pointer, a second removal of the PHB will try to free
> >> the array a second time and corrupt memory.
> > 
> > "PHB hotplug" and "hot-plugging devices under a PHB" are different
> > things. What you're saying here doesn't make a whole lot of sense to
> > me unless you're conflating the two. The distinction is important
> > since on pseries we can use DLPAR to add and remove actual PHBs (i.e.
> > the pci_controller) at runtime, but there's no corresponding mechanism
> > on PowerNV.
> 
> And it's even different on QEMU. 
> 

If the real HW doesn't have the notion of adding/removing a PHB at
runtime, then QEMU should stick to that, ie. setting dc->hotpluggable
to false for PNV PHB device types.

> >> Free the 'irq_map' array in pcibios_free_controller() to fix
> >> corruption and clear interrupt mapping after it has been
> >> disposed. This to avoid filling up the array with successive
> >> remove/rescan of a bus.
> > 
> > Even with this patch I think we're still broken. With this patch
> > applied the init path is something like:
> > 
> > per-phb init:
> >     allocate phb->irq_map array
> > per-bus init:
> >     nothing
> > per-device init:
> >     pcibios_bus_add_device()
> >        pci_read_irq_line()
> >             pci_irq_map_register(pci_dev, virq)
> >                *record the device's interrupt in phb->irq_map*
> > 
> > And the teardown path:
> > 
> > per-device teardown:
> >     nothing
> > per-bus teardown:
> >     pcibios_remove_bus()
> >         pci_irq_map_dispose()
> >             *walk phb->irq_map and dispose of each mapped interrupt*
> > per-phb teardown:
> >     free(phb->irq_map)
> > 
> > There's a lot of asymmetry here, which is a problem in itself, but the
> > real issue is that when removing *any* pci_bus under a PHB we dispose
> > of the LSI\ for *every* device under that PHB. Not good.
> > 
> > Ideally we should be fixing this by having the per-device teardown
> > handle disposing the mapping. Unfortunately, there's no pcibios hook
> > that's called when removing a pci_dev. However, we can register a bus
> > notifier which will be called when the pci_dev is removed from its bus
> > and we already do that for the per-device EEH teardown and to handle
> > IOMMU TCE invalidation when the device is removed.
> 
> I lack the knowledge here and I think some else should take over,
> as I am not doing a good job. 
> 
> Michael, can you drop the initial patch again :/ It is better not
> to merge anything.
> 
> Thanks,
> 
> C. 
> 
> 

