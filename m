Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAF36F9D4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhD3MQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 08:16:41 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:57325 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhD3MQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 08:16:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82EB11031F24D;
        Fri, 30 Apr 2021 14:15:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 47E6F28CBA; Fri, 30 Apr 2021 14:15:49 +0200 (CEST)
Date:   Fri, 30 Apr 2021 14:15:49 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210430121549.GA10784@wunner.de>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
 <20210428144041.GA27967@wunner.de>
 <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
 <20210429194214.GA22639@wunner.de>
 <98afb95c-2735-b1fd-3261-7d701b6a0801@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98afb95c-2735-b1fd-3261-7d701b6a0801@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 04:47:54PM +0800, Yicong Yang wrote:
> On 2021/4/30 3:42, Lukas Wunner wrote:
> > The 3000 msec were chosen arbitrarily.  I couldn't imagine that
> > it would ever take longer than that.  The spec does not seem to
> > mandate a time limit for DPC recovery.  But we do need a timeout
> > because the DPC Trigger Status bit may never clear and then pciehp
> > would wait indefinitely.  This can happen if dpc_wait_rp_inactive()
> > fails or perhaps because the hardware is buggy.
> 
> The DPC recovery process will not be blocked indefinitely. What about
> wait until the DPC process is finished or until the dpc_reset_link()
> is finished? We can try to up the link if the DPC recovery failed.

As I've indicated above, there's a condition when DPC never completes:

According to the PCIe Base Spec, sec. 6.2.10,

   "After DPC has been triggered in a Root Port that supports RP Extensions
    for DPC, the Root Port may require some time to quiesce and clean up
    its internal activities, such as those associated with DMA read Requests.
    When the DPC Trigger Status bit is Set and the DPC RP Busy bit is Set,
    software must leave the Root Port in DPC until the DPC RP Busy bit
    reads 0b."

The spec does not mandate a time limit until DPC RP Busy clears:

   "The DPC RP Busy bit is a means for hardware to indicate to software
    that the RP needs to remain in DPC containment while the RP does
    some internal cleanup and quiescing activities. While the details
    of these activities are implementation specific, the activities will
    typically complete within a few microseconds or less. However, under
    worst-case conditions such as those that might occur with certain
    internal errors in large systems, the busy period might extend
    substantially, possibly into multiple seconds."

Thus, dpc_wait_rp_inactive() polls every 10 msec (for up to HZ, i.e. 1 sec)
whether PCI_EXP_DPC_RP_BUSY has been cleared.  If it does not clear
within 1 sec, the function returns -EBUSY to its caller dpc_reset_link().
Note that according to the spec, we're not allowed to clear the
Trigger Status bit as long as the DPC RP Busy bit is set, hence
dpc_reset_link() errors out without clearing PCI_EXP_DPC_STATUS_TRIGGER.

Because pciehp waits for that bit to clear, it may end up waiting
indefinitely for DPC to complete.  That's not acceptable, so we do
need a timeout to allow pciehp to progress.


> I noticed the hotplug interrupt arrives prior to the DPC and then the
> wait begins. DPC will clear the Trigger Status in its irq thread.
> So not all the time is elapsed by the hardware recovery, but also by
> the software process. Considering it's in the irq thread, if we are
> preempted and clear the status slower, then we may be timed out.

That is correct.  If the system is super busy then there's a chance
that pciehp may time out because the DPC IRQ thread wasn't scheduled.
So the timeout needs to be long enough to accommodate for that.

Thanks,

Lukas
