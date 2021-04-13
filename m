Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70335E693
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbhDMSj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347975AbhDMSjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 14:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07AD613C7;
        Tue, 13 Apr 2021 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618339130;
        bh=ZzZvh+8hqbrZC/s++4ql+SYt7zdY1s/EX+w4MxcPS6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZXvxxtbKnWHHOu9sSwQuukRgWl/ILhFeyNn3T5tw5fzlHD44uBzOrxfuT0wU37BP/
         1XAMCQ14zD+cmWWBl5i+S1FECs4c39giyl5frvgUO5uEBtMkUg91fB6HHgV0FAD71Y
         lUmoHf4lXu7zq67zrZgH0LLo4e/1c8cKcvn0r0cv92JeDui0NNi9rlUaLznEPjNa8p
         StxqAqQeBZBY4/TLnzVZYqPvhz5M79g9sUequTGDw0zZutl+BGyGOo1Jpw0Bh677cc
         jkzazGjD0BbuzHbTooWvXRgOLu2dGeJyfOKyDRNVyKZasKJry/bEb9o4JJrDVEc56q
         4dscHz5CGtZcw==
Date:   Tue, 13 Apr 2021 13:38:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v2 1/4] PCI: Add vendor define ID for the PCI SIG
Message-ID: <20210413183849.GA2253107@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413192135.000024de@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 07:21:35PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Apr 2021 11:34:48 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Apr 14, 2021 at 12:01:56AM +0800, Jonathan Cameron wrote:
> > > This ID is used in DOE headers to identify protocols that are
> > > defined within the PCI Express Base Specification.  
> > 
> > Can you please include the specific spec citation here?
> 
> Will make sure to add to cover leter for next version but for now, 
> 
> Table 7-x2: Data Object Exchange ECN
> (first column lists the Vendor ID for the protocols)

I wish the SIG would formally define this Vendor ID instead of just
starting to use it, but this is better than nothing.

Please put this in the log for this commit, since the cover letter may
not be merged and isn't directly connected to this commit.

> Available on the PCI SIG spec downloads page.
> It also exists in various other places in the 5.0 spec, but I'm
> not sure if any are software visible (e.g. VDMs)
> 
> Jonathan
> 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > Since V1: New Patch
> > > 
> > >  include/linux/pci_ids.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index a76ccb697bef..2c0459c23331 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -149,6 +149,7 @@
> > >  #define PCI_CLASS_OTHERS		0xff
> > >  
> > >  /* Vendors and devices.  Sort key: vendor first, device next. */
> > > +#define PCI_VENDOR_ID_PCI_SIG		0x0001
> > >  
> > >  #define PCI_VENDOR_ID_LOONGSON		0x0014
> > >  
> > > -- 
> > > 2.19.1
> > >   
> 
