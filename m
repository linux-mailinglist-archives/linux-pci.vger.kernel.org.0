Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB62B2B4BD0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgKPQ4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgKPQ4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:56:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB8C0613CF;
        Mon, 16 Nov 2020 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ez/r2/t/kaF/FI46SV1LmO29yACb2u0s7Czy4NzcvE4=; b=kHsGrYZx3pXNKiKe3+8BlasjBW
        /ZgYNui94kDLwShlww2me1+1fA4ohcU1nTMG85WRNbyMRPoOQPx+S9zKAlfQuvxKVwd+6GuqrZCl7
        NTIQc7+ZTB6ssHPk8RT7yF3ufRM0rOvmKByQ6wBPZcypkiNt6+eBX73VqR2BLS9eoYFCvQcVPfDIb
        rDlGRMSQ6n91vNZ38kfhhWPquKS9z/Q+pnuCzdDgzMQrCtNXPBNMeZ39vH4tKWiH6N9GFZh5Zi+Gi
        ok7Prt96LS1TzyORkJiN/vVnb7x+BtXvQKO6pPfQb0bj0RUITHw2K84UVxvdKTG2xR1Cq0q0gnyOb
        oCpYy1Dw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehnj-0006G5-3G; Mon, 16 Nov 2020 16:56:23 +0000
Date:   Mon, 16 Nov 2020 16:56:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Message-ID: <20201116165623.GA23268@infradead.org>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com>
 <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 09:17:37AM -0800, Dan Williams wrote:
> > > +config CXL_MEM
> > > +        tristate "CXL.mem Device Support"
> > > +        depends on PCI && CXL_BUS_PROVIDER != n
> >
> > depend on PCI && CXL_BUS_PROVIDER
> >
> > > +        default m if CXL_BUS_PROVIDER
> >
> > Please don't set weird defaults for new code.  Especially not default
> > to module crap like this.
> 
> This goes back to what people like Dave C. asked for LIBNVDIMM / DAX,
> a way to blanket turn on a subsystem without needing to go hunt down
> individual configs.

Then at least do a

   default CXL_BUS_PROVIDER

but we really don't do this elsewhere.  E.g. we don't default the scsi
disk driver on if there is some host adapter selected.


> > > +MODULE_AUTHOR("Intel Corporation");
> >
> > A module author is not a company.
> 
> At least I don't have a copyright assignment clause, I don't agree
> with the vanity of listing multiple people here especially when
> MAINTAINERS has the contact info, and I don't want to maintain a list
> as people do drive-by contributions and we need to figure out at what
> level of contribution mandates a new MODULE_AUTHOR line. Now, that
> said I would be ok to duplicate the MAINTAINERS as MODULE_AUTHOR
> lines, but I otherwise expect MAINTAINERS is the central source for
> module contact info.

IMHO MODULE_AUTHOR is completely pointless.  I haven't used for ~15
years.  Especially as the concept that a module has a single author
is a rather strange one.
