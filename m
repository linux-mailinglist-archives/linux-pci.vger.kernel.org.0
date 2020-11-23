Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D722C1465
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgKWTUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 14:20:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:51658 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbgKWTUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 14:20:32 -0500
IronPort-SDR: wpqtrXlSh/tld29/7HMwRkLwgTaaGwvqAu61zmAkYmDwx8tQvTNbtd9I/aEGgstF9AUW9AhKog
 /hBTCEEvSmgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233437087"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="233437087"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 11:20:31 -0800
IronPort-SDR: 4osoD/jQLFTXy5LI1vf4UreBRHY4eXiI8Ga6csa8pmpOpB05cVZ7OvHBvUabTlEWF91QWnEYbg
 NKIXacmNcYFA==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="327302195"
Received: from laloy-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 11:20:30 -0800
Date:   Mon, 23 Nov 2020 11:20:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201123192029.pmmy6ygts5fclz7b@intel.com>
References: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
 <20201117002321.GA1344659@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117002321.GA1344659@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-16 18:23:21, Bjorn Helgaas wrote:
> On Mon, Nov 16, 2020 at 03:19:41PM -0800, Dan Williams wrote:
> > On Fri, Nov 13, 2020 at 5:12 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > On 20-11-13 12:17:32, Bjorn Helgaas wrote:
> > > > On Tue, Nov 10, 2020 at 09:43:51PM -0800, Ben Widawsky wrote:
> 
> > > > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > >  {
> > > > > +   struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> > > > >     struct device *dev = &pdev->dev;
> > > > > -   struct cxl_mem *cxlm;
> > > >
> > > > The order was better before ("dev", then "clxm").  Oh, I suppose this
> > > > is a "reverse Christmas tree" thing.
> > > >
> > >
> > > I don't actually care either way as long as it's consistent. I tend to do
> > > reverse Christmas tree for no particular reason.
> > 
> > Yeah, reverse Christmas tree for no particular reason.
> 
> FWIW, the usual drivers/pci style is to order the decls in the order
> the variables are used in the code.  But this isn't drivers/pci, so
> it's up to you.  I only noticed because changing the order made the
> diff bigger than it needed to be.
> 
> > > > I think this would be easier to read if cxl_mem_create() returned NULL
> > > > on failure (it prints error messages and we throw away
> > > > -ENXIO/-ENOMEM distinction here anyway) so you could do:
> > > >
> > > >   struct cxl_mem *cxlm = NULL;
> > > >
> > > >   for (...) {
> > > >     if (...) {
> > > >       cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > > >       break;
> > > >     }
> > > >   }
> > > >
> > > >   if (!cxlm)
> > > >     return -ENXIO;  /* -ENODEV might be more natural? */
> > > >
> > >
> > > I agree on both counts. Both of these came from Dan, so I will let him explain.
> > 
> > I'm not attached to differentiating -ENOMEM from -ENXIO and am ok to
> > drop the ERR_PTR() return. I do tend to use -ENXIO for failure to
> > perform an initialization action vs failure to even find the device,
> > but if -ENODEV seems more idiomatic to Bjorn, I won't argue.
> 
> -ENXIO is fine with me.  I just don't see it as often so I don't
> really know what it is.
> 
> Bjorn

Dan, Bjorn, I did a fairly randomized look at various probe functions and ENODEV
seems to be more common. My sort of historical use has been
- ENODEV: General, couldn't establish device presence
- ENXIO: Device was there but something is totally misconfigured
- E*: A matching errno for exactly what went wrong

My question though is, would it be useful to propagate the error up through
probe?
