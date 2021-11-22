Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4921B45956A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhKVTUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 14:20:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:29000 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhKVTUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 14:20:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234681116"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="234681116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:17:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="674172974"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:17:03 -0800
Date:   Mon, 22 Nov 2021 11:17:01 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 23/23] cxl/mem: Disable switch hierarchies for now
Message-ID: <20211122191701.w2hidak2zyqxuy3t@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-24-ben.widawsky@intel.com>
 <20211122181901.000073cb@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122181901.000073cb@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 18:19:01, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:50 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Switches aren't supported by the region driver yet. If a device finds
> > itself under a switch it will not bind a driver so that it cannot be
> > used later for region creation/configuration.
> 
> What's the reasoning in have this in this patch set rather than the region one?
> 
> I was rather hoping you'd have it working when the region set is ready :)
> 
> Jonathan
> 

I'm uncomfortable enabling it until I actually have an environment to test it
in. If Dan et al. don't mind however, I can drop this patch.

> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index e954144af4b8..997898e78d63 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -155,6 +155,11 @@ static int cxl_mem_probe(struct device *dev)
> >  		goto out;
> >  	}
> >  
> > +	/* FIXME: Add true switch support */
> > +	dev_err(dev, "Devices behind switches are currently unsupported\n");
> > +	rc = -ENODEV;
> > +	goto err_out;
> > +
> >  	/* Walk down from the root port and add all switches */
> >  	cxl_scan_ports(ctx.root_port);
> >  
> 
