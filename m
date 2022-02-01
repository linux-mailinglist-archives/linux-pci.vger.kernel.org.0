Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0B4A5EBD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiBAO7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 09:59:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:2515 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbiBAO7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 09:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643727585; x=1675263585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joQcQ0jFgjnT4KqUU0fnP+eX2kKna5YdK/rGnaHrhGE=;
  b=blDsMUVQ3a+BcfLC5cghu7oIx4LUJnfU6Ke4MoR7EJX78nKq85p7MnJw
   EE9cuJQj1FgRud8D0U0qEal1hYSoIn3x0F1oMSH23SUAtsy2MgCN7wsGs
   c4ZTLXiVGmlDlPGuXe4Lyff+tmXARyuHUa5DiXw8Kmbvf0YAkP2VhRHRZ
   vAQoDfxoum3rvAblMPgmYoUHice5FwhWeStrshB3jDdcxXZm6yi2CCPBr
   e05AIQEY6x0chmhoDN6TCxPujXpGByuMUOiiSjNAF/x7Z6Lr1wvD6C+X9
   5IGTv34DNgIposSnTgDN4c45q35kdR3dd4Ht6hRUbEHX1gaTxje4qcYQf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227678152"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="227678152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:59:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619812929"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:59:44 -0800
Date:   Tue, 1 Feb 2022 06:59:43 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] cxl/region: Introduce concept of region
 configuration
Message-ID: <20220201145943.mevjv3rygo43o2lf@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-3-ben.widawsky@intel.com>
 <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hHJcPLRJM-7z+wKhjBhp9HH2qXuEeC0VfDnD6yU9H-Wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I will cut to the part that effects ABI so tool development can continue. I'll
get back to the other bits later.

On 22-01-28 16:25:34, Dan Williams wrote:

[snip]

> 
> > +
> > +       return ret;
> > +}
> > +
> > +static size_t set_targetN(struct cxl_region *cxlr, const char *buf, int n,
> > +                         size_t len)
> > +{
> > +       struct device *memdev_dev;
> > +       struct cxl_memdev *cxlmd;
> > +
> > +       device_lock(&cxlr->dev);
> > +
> > +       if (len == 1 || cxlr->config.targets[n])
> > +               remove_target(cxlr, n);
> > +
> > +       /* Remove target special case */
> > +       if (len == 1) {
> > +               device_unlock(&cxlr->dev);
> > +               return len;
> > +       }
> > +
> > +       memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> 
> I think this wants to be an endpoint decoder, not a memdev. Because
> it's the decoder that joins a memdev to a region, or at least a
> decoder should be picked when the memdev is assigned so that the DPA
> mapping can be registered. If all the decoders are allocated then fail
> here.
> 

You've put two points in here:

1. Handle decoder allocation at sysfs boundary. I'll respond to this when I come
back around to the rest of the review comments.

2. Take a decoder for target instead of a memdev. I don't agree with this
direction as it's asymmetric to how LSA processing works. The goal was to model
the LSA for configuration. The kernel will have to be in the business of
reserving and enumerating decoders out of memdevs for both LSA (where we have a
list of memdevs) and volatile (where we use the memdevs in the system to
enumerate populated decoders). I don't see much value in making userspace do the
same.

I'd like to ask you reconsider if you still think it's preferable to use
decoders as part of the ABI and if you still feel that way I can go change it
since it has minimal impact overall.

> > +       if (!memdev_dev) {
> > +               device_unlock(&cxlr->dev);
> > +               return -ENOENT;
> > +       }
> > +
> > +       /* reference to memdev held until target is unset or region goes away */
> > +
> > +       cxlmd = to_cxl_memdev(memdev_dev);
> > +       cxlr->config.targets[n] = cxlmd;
> > +
> > +       device_unlock(&cxlr->dev);
> > +
> > +       return len;
> > +}
> > +

[snip]
