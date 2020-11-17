Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04D2B55AA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 01:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgKQAXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 19:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKQAXY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 19:23:24 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B74E24677;
        Tue, 17 Nov 2020 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605572603;
        bh=sYrq5ZVWtycoGePIH5LmN/YjigTf7wK8WJYW4RYZ7ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wEQLPLwtcR4SH37LZBBWPU5BFsexHAZG85AusZlOF15wABBTyV7iUbUnVxjgKSqvU
         M+05Wqv2RN204nrMqpjGeZKZi9T2XL2eg0RF+0ZBuYAilqIIvemHkxVCHR7yBMPQZC
         sfq6RQgyT6UEFENMVw+B9FAiLf9mLw1El+8xF0Bs=
Date:   Mon, 16 Nov 2020 18:23:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201117002321.GA1344659@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 03:19:41PM -0800, Dan Williams wrote:
> On Fri, Nov 13, 2020 at 5:12 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > On 20-11-13 12:17:32, Bjorn Helgaas wrote:
> > > On Tue, Nov 10, 2020 at 09:43:51PM -0800, Ben Widawsky wrote:

> > > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  {
> > > > +   struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> > > >     struct device *dev = &pdev->dev;
> > > > -   struct cxl_mem *cxlm;
> > >
> > > The order was better before ("dev", then "clxm").  Oh, I suppose this
> > > is a "reverse Christmas tree" thing.
> > >
> >
> > I don't actually care either way as long as it's consistent. I tend to do
> > reverse Christmas tree for no particular reason.
> 
> Yeah, reverse Christmas tree for no particular reason.

FWIW, the usual drivers/pci style is to order the decls in the order
the variables are used in the code.  But this isn't drivers/pci, so
it's up to you.  I only noticed because changing the order made the
diff bigger than it needed to be.

> > > I think this would be easier to read if cxl_mem_create() returned NULL
> > > on failure (it prints error messages and we throw away
> > > -ENXIO/-ENOMEM distinction here anyway) so you could do:
> > >
> > >   struct cxl_mem *cxlm = NULL;
> > >
> > >   for (...) {
> > >     if (...) {
> > >       cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > >       break;
> > >     }
> > >   }
> > >
> > >   if (!cxlm)
> > >     return -ENXIO;  /* -ENODEV might be more natural? */
> > >
> >
> > I agree on both counts. Both of these came from Dan, so I will let him explain.
> 
> I'm not attached to differentiating -ENOMEM from -ENXIO and am ok to
> drop the ERR_PTR() return. I do tend to use -ENXIO for failure to
> perform an initialization action vs failure to even find the device,
> but if -ENODEV seems more idiomatic to Bjorn, I won't argue.

-ENXIO is fine with me.  I just don't see it as often so I don't
really know what it is.

Bjorn
