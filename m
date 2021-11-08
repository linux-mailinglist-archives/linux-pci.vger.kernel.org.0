Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC7449EA5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 23:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhKHW2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 17:28:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:59009 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhKHW2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 17:28:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="318534617"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="318534617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 14:25:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="451645786"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 14:25:17 -0800
Date:   Mon, 8 Nov 2021 14:25:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20211108222516.GE3538886@iweiny-DESK2.sc.intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
 <20211105235056.3711389-5-ira.weiny@intel.com>
 <20211108150236.00003a6c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108150236.00003a6c@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:02:36PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Nov 2021 16:50:55 -0700
> <ira.weiny@intel.com> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 

[snip]

> 
> A few more things came to mind whilst reading the rest of the series. In particular
> lifetime management for the doe structures.

Thanks for the review I'm just working through all the comments and so I'm
somewhat working backwards.

> 
> >   * DOC: cxl pci
> > @@ -575,17 +576,106 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> >  		if (rc)
> >  			return rc;
> >  
> > -		if (device_attach(&adev->dev) != 1)
> > +		if (device_attach(&adev->dev) != 1) {
> >  			dev_err(&adev->dev,
> >  				"Failed to attach a driver to DOE device %d\n",
> >  				adev->id);
> > +			goto next;
> > +		}
> > +
> > +		if (pci_doe_supports_prot(new_dev, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > +			cxlds->cdat_doe = new_dev;
> 
> I'm probably missing something, but what prevents new_dev from going away after
> this assignment?
> Perhaps a force unbind or driver removal.  Should we get a
> reference?

I had a get_device() here at one point but took it out...  Because I was
thinking that new_dev's lifetime was equal to cxlds because cxlds 'owned' the
DOE devices.  However this is totally not true.  And there is a race between
the device going away and cxlds going away which could be a problem.

> 
> Also it's possible we'll have multiple CDAT supporting DOEs so
> I'd suggest checking if cxlds->cdata_doe is already set before setting it.

Sure.

> 
> We could break out of the loop early, but I want to bolt the CMA doe detection
> in there so I'd rather we didn't.  This is all subject to whether we attempt
> to generalize this support and move it over to the PCI side of things.

I'm not 100% sure about moving it to the PCI side but it does make some sense
because really the auxiliary devices are only bounded by the PCI device being
available.  None of the CXL stuff needs to exist for the DOE driver to talk to
the device but the pdev does need to be there...  :-/

This is all part of what drove the cxl_mem rename because that structure was
really confusing me.  Dan got me straightened out but I did not revisit this
series after that.  Now off the top of my head I'm not sure that cxlds needs to
be involved in the auxiliary device creation.  OTOH I was making it a central
place for in kernel users to know where/how to get information from DOE
mailboxes.  Hence caching which of these devices had CDAT capability.[1]

Since you seem to have arrived at this conclusion before me where in the PCI
code do you think is appropriate for this?

Ira

[1] I'm not really sure what is going to happen if multiple DOE boxes have CDAT
capability.  This seems like a recipe for confusion.

> 
> >  
> > +next:
> >  		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> >  	}
> >  
> >  	return 0;
> >  }
> >  
