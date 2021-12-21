Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0747C40C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhLUQpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 11:45:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:55770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239955AbhLUQo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Dec 2021 11:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640105099; x=1671641099;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4tyfixgHyEhzlQ+wu6MKp8Bif+Yw8I7N5uaDrDgfl8=;
  b=Ol1VccmRHudcHXUXwS9xA2vQYDu3GvVYGROcHaHCrot1/yXnwFFItNAZ
   ngLK4HhVdF+o+una7YhVxCdy8QKV1zNmkdgNtbW7gYkbGlwXSuoGHjY1f
   galsDjf2O/QXOLp58hDcWYbUBAEZu+KQ5tucDryMB4O0GdHoKKUw9gqcm
   r3VVIIJLdTvDHQwRYJTtT+7MbEmdeuCeZwriQ4Npfur9f+/zUkmE+g/M0
   nAH96Pd2wmYVetQgpwcXucKya9+D/J/Z6vdx/Y4eE6VigBftseVpEQy4S
   0UhsVKSX5AcjkADijYo9fnO7snm0lVEn3erZD7rvz/mX2hBSa29TDrH3q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227279235"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227279235"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 08:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="755869271"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Dec 2021 08:44:57 -0800
Received: from abailey-MOBL.amr.corp.intel.com (unknown [10.209.52.201])
        by linux.intel.com (Postfix) with ESMTP id 74F865807C5;
        Tue, 21 Dec 2021 08:44:57 -0800 (PST)
Message-ID: <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Tue, 21 Dec 2021 08:44:57 -0800
In-Reply-To: <YcGEaH0oAAocziU2@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-4-david.e.box@linux.intel.com>
         <YbDbql39x7Kw6iAC@kroah.com>
         <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
         <YbD1NsYHbU8FvtTN@kroah.com>
         <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
         <YbEFuN7fwdiNI8vW@kroah.com>
         <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
         <YcGEaH0oAAocziU2@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
> On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
> > On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
> > > On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
> > > > On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> > > > > On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> > > > > > On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > > > > > > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > > > > > > > +static struct pci_driver intel_vsec_pci_driver = {
> > > > > > > > +       .name = "intel_vsec",
> > > > > > > > +       .id_table = intel_vsec_pci_ids,
> > > > > > > > +       .probe = intel_vsec_pci_probe,
> > > > > > > > +};
> > > > > > > 
> > > > > > > So when the PCI device is removed from the system you leak
> > > > > > > resources and
> > > > > > > have dangling devices?
> > > > > > 
> > > > > > No.
> > > > > > 
> > > > > > > Why no PCI remove driver callback?
> > > > > > 
> > > > > > After probe all resources are device managed. There's nothing to
> > > > > > explicitly clean up. When
> > > > > > the
> > > > > > PCI
> > > > > > device is removed, all aux devices are automatically removed. This
> > > > > > is the case for the SDSi
> > > > > > driver
> > > > > > as well.
> > > > > 
> > > > > Where is the "automatic cleanup" happening?  As this pci driver is
> > > > > bound
> > > > > to the PCI device, when the device is removed, what is called in this
> > > > > driver to remove the resources allocated in the probe callback?
> > > > > 
> > > > > confused,
> > > > 
> > > > devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev)
> > > 
> > > Wow that is opaque.  Why not do it on remove instead?
> > 
> > This code is common for auxdev cleanup. AFAICT most auxiliary bus code is
> > done by drivers that have
> > some other primary function. They clean up their primary function resources
> > in remove, but they
> > clean up the auxdev using the method above. In this case the sole purpose of
> > this driver is to
> > create the auxdev. There are no other resources beyond what the auxdev is
> > using.
> > 
> > Adding runtime pm to the pci driver will change this. Remove will be needed
> > then.
> 
> And who will notice that being required when that happens?
> 
> Why is there no runtime PM for this driver?  Do you not care about power
> consumption?  :)

Of course. :)

There's a backlog of patches waiting for this series. One adds support for the
telemetry device (an auxdev) on the DG2 GPU. This device requires runtime pm in
order for the slot to go D3. But this also requires changes to the telemetry
driver in order for runtime pm to be handled correctly. These and other patches,
including a series to have all current aux drivers use the new drvdata helpers,
are waiting for this.

David

> 
> thanks,
> 
> greg k-h

