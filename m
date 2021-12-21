Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0F47C64B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhLUSTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 13:19:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:5944 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241302AbhLUSTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Dec 2021 13:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640110785; x=1671646785;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEuFFAjQyciZQYQp+HuE0uY8s9s5/twvrparNkv9kFk=;
  b=YfDkJZ84V1aKoHIKBNOzokI3nf2YOUcGNVMGwDzjreJ8uJVbYOVHoHhO
   LRxtvH0EoF96K4jFUOc4wCOZvzzXhj73ngR0e3Uj9EQ+i+mi97xP1xdKi
   XD+XWuDHw4s1fU8EtT9j81jrYz9P4lzDQZU8hfAMB38IIksvzZr24ErGS
   z87zA2ptVKWr+snBdPUGkWWQKkqCTwAuo63quNXaT6KLC89kmJlm+c6eG
   7bJh+EN9uArp3+8ZYzdiY3sRXSj+QqtkBWGfY8xtxyAYkP56k2cmp5/WO
   kXLb5dZicTadKWjR+54d0ZPHS1HuWlclRBvep31K1LnnCtK3GMSxlZKHc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="264655921"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="264655921"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 10:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="755907286"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Dec 2021 10:16:37 -0800
Received: from abailey-MOBL.amr.corp.intel.com (unknown [10.209.52.201])
        by linux.intel.com (Postfix) with ESMTP id 9C2DD580684;
        Tue, 21 Dec 2021 10:16:36 -0800 (PST)
Message-ID: <be2a1cce5691e5dc7fb875f46d5f2085b6a55542.camel@linux.intel.com>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Tue, 21 Dec 2021 10:16:36 -0800
In-Reply-To: <3913dfd7-3872-7d69-24af-eba747a7a92d@redhat.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-4-david.e.box@linux.intel.com>
         <YbDbql39x7Kw6iAC@kroah.com>
         <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
         <YbD1NsYHbU8FvtTN@kroah.com>
         <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
         <YbEFuN7fwdiNI8vW@kroah.com>
         <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
         <YcGEaH0oAAocziU2@kroah.com>
         <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
         <YcIGwZqm2sfIixkH@kroah.com>
         <3913dfd7-3872-7d69-24af-eba747a7a92d@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-12-21 at 18:04 +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/21/21 17:54, Greg KH wrote:
> > On Tue, Dec 21, 2021 at 08:44:57AM -0800, David E. Box wrote:
> > > On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
> > > > On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
> > > > > On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
> > > > > > On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
> > > > > > > On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> > > > > > > > On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> > > > > > > > > On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > > > > > > > > > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box
> > > > > > > > > > wrote:
> > > > > > > > > > > +static struct pci_driver intel_vsec_pci_driver = {
> > > > > > > > > > > +       .name = "intel_vsec",
> > > > > > > > > > > +       .id_table = intel_vsec_pci_ids,
> > > > > > > > > > > +       .probe = intel_vsec_pci_probe,
> > > > > > > > > > > +};
> > > > > > > > > > 
> > > > > > > > > > So when the PCI device is removed from the system you leak
> > > > > > > > > > resources and
> > > > > > > > > > have dangling devices?
> > > > > > > > > 
> > > > > > > > > No.
> > > > > > > > > 
> > > > > > > > > > Why no PCI remove driver callback?
> > > > > > > > > 
> > > > > > > > > After probe all resources are device managed. There's nothing
> > > > > > > > > to
> > > > > > > > > explicitly clean up. When
> > > > > > > > > the
> > > > > > > > > PCI
> > > > > > > > > device is removed, all aux devices are automatically removed.
> > > > > > > > > This
> > > > > > > > > is the case for the SDSi
> > > > > > > > > driver
> > > > > > > > > as well.
> > > > > > > > 
> > > > > > > > Where is the "automatic cleanup" happening?  As this pci driver
> > > > > > > > is
> > > > > > > > bound
> > > > > > > > to the PCI device, when the device is removed, what is called in
> > > > > > > > this
> > > > > > > > driver to remove the resources allocated in the probe callback?
> > > > > > > > 
> > > > > > > > confused,
> > > > > > > 
> > > > > > > devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux,
> > > > > > > auxdev)
> > > > > > 
> > > > > > Wow that is opaque.  Why not do it on remove instead?
> > > > > 
> > > > > This code is common for auxdev cleanup. AFAICT most auxiliary bus code
> > > > > is
> > > > > done by drivers that have
> > > > > some other primary function. They clean up their primary function
> > > > > resources
> > > > > in remove, but they
> > > > > clean up the auxdev using the method above. In this case the sole
> > > > > purpose of
> > > > > this driver is to
> > > > > create the auxdev. There are no other resources beyond what the auxdev
> > > > > is
> > > > > using.
> > > > > 
> > > > > Adding runtime pm to the pci driver will change this. Remove will be
> > > > > needed
> > > > > then.
> > > > 
> > > > And who will notice that being required when that happens?
> > > > 
> > > > Why is there no runtime PM for this driver?  Do you not care about power
> > > > consumption?  :)
> > > 
> > > Of course. :)
> > > 
> > > There's a backlog of patches waiting for this series. One adds support for
> > > the
> > > telemetry device (an auxdev) on the DG2 GPU. This device requires runtime
> > > pm in
> > > order for the slot to go D3. But this also requires changes to the
> > > telemetry
> > > driver in order for runtime pm to be handled correctly. These and other
> > > patches,
> > > including a series to have all current aux drivers use the new drvdata
> > > helpers,
> > > are waiting for this.
> > 
> > I can take the aux driver drvdata patch now, through my tree, if you
> > want, no need to make it wait for this tiny driver.
> > 
> > Feel free to send it independant of the existing patchset, and with the
> > cleanup patches at the same time, should be quite easy to get merged.
> 
> If you're going to take that one, can you perhaps take patches
> 1-3 for 5.17 through your tree as well (patch 3 depends on 2/it) ?
> 
> Note there is a v4 of this series, see please use that :)
> 
> I assume the follow up patches are also going to need patch 3
> (the actual conversion of the driver to aux-bus).

Yes.

> 
> Here is my Ack for the pdx86 bits in patch 3:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> And patch 1 and 3 also have acks from the PCI resp. MFD subsys maintainers,
> so I guess taking this all upstream through your tree is fine.

Should I send 1-3 plus the drvdata cleanup patches I have to Grep? V5?

> 
> That leaves patches 4-6, 4 is the patching adding the new
> "Intel Software Defined Silicon driver" sysfs API and I would
> like to take some time to thoroughly review the new
> userspace API, which I don't see happening before the
> Christmas Holidays, so I don't plan to merge 4-6 (which
> depends on 3) until after 5.17-rc1.

Understood. Thanks.

> 
> Regards,
> 
> Hans
> 

