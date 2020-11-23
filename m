Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE502C14F0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgKWT64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 14:58:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:1054 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbgKWT6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 14:58:54 -0500
IronPort-SDR: 2WKvDm4FtfpiQTwoNuurLLsBiAuCaQ/5dsk1xIISNPv6imEV1AyjJ5Gjw1HJrWBF01FqooklsQ
 usyQfXniAyOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="235972270"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="235972270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 11:58:35 -0800
IronPort-SDR: ++nptVpYh180R/rQXo3jhOKeIgoHc33C0uL9ziietbgdx2y7sgx72fYoKkN+Z3nNFRdN76QBaB
 GIYhJJS8CHtw==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="546541234"
Received: from laloy-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 11:58:35 -0800
Date:   Mon, 23 Nov 2020 11:58:33 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201123195833.zeyhja6no6dkd32c@intel.com>
References: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
 <20201117002321.GA1344659@bjorn-Precision-5520>
 <20201123192029.pmmy6ygts5fclz7b@intel.com>
 <CAPcyv4jJpvLErK8vBW-D2ZQASU0iJqFLRr7yDXB0kfGPrmi6xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jJpvLErK8vBW-D2ZQASU0iJqFLRr7yDXB0kfGPrmi6xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-23 11:32:33, Dan Williams wrote:
> On Mon, Nov 23, 2020 at 11:20 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > -ENXIO is fine with me.  I just don't see it as often so I don't
> > > really know what it is.
> > >
> > > Bjorn
> >
> > Dan, Bjorn, I did a fairly randomized look at various probe functions and ENODEV
> > seems to be more common. My sort of historical use has been
> > - ENODEV: General, couldn't establish device presence
> > - ENXIO: Device was there but something is totally misconfigured
> > - E*: A matching errno for exactly what went wrong
> >
> > My question though is, would it be useful to propagate the error up through
> > probe?
> 
> The error from probe becomes the modprobe exit code, or the write to
> the 'bind' attribute errno. So, it's a choice between "No such device
> or address", or "No such device". The "or address" mention makes a
> small bit more sense to me since the device is obviously present as it
> is visible in lspci, but either error code clearly indicates a driver
> problem so ENODEV is fine.
> 
> For the other error codes I think it would be confusing to return
> something like EINVAL from probe as that would be mistaken as an
> invalid argument to the modprobe without stracing to see that it came
> from the result of a sysfs write

Currently in this path there are 2 general reasons for failure:
1. Driver internal problem, ENOMEM or some such.
2. Device problem (the memory device capability isn't present).

I think I'll return ENODEV for the former and ENXIO for the latter. If that
sounds good to everyone else.
