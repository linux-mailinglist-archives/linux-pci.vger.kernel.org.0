Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3494A7871
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 20:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiBBTC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 14:02:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:6440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbiBBTC5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 14:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643828577; x=1675364577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M231Ao4yDTb4iZ/Nqoa87sdrwTCybShfUtJJRsYigEE=;
  b=lMR8Ljo+GdSNQUHWu1ryIC2RKtucAl/vSckgG1HJ+7XkYzseNoaagcJO
   3/BDHpu5VU5XkgFqq8OgKJkSkVB3qqrvikrzjWt+YVgWQ/UUFkARwqOGa
   +ydBbQ9Tz42DBAn8doAMv+Ot8fzLRZsI9xdFIEesk8qiaWGtjNRFq9G84
   tah+lJ6kAKqRmphGhU5fIFYE5Bzf05cTnrFiuR+u9S4AJRrckh97Jd1dL
   gYmvEBQ3uXyC2eFModLWQuoqOpHqAMmY97pBJz1KNbEMvw9Gd4lr+VJD6
   rmOoE0Dx84954rsQY1zv/qaympe9UUo9mPoT/Y8cs2coPdUpsH1qwOJR7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248218145"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="248218145"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="523611584"
Received: from svenur-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.133.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 11:02:56 -0800
Date:   Wed, 2 Feb 2022 11:02:54 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 01/14] cxl/region: Add region creation ABI
Message-ID: <20220202190254.gg3t5xhpdcnfpkp2@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-2-ben.widawsky@intel.com>
 <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
 <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
 <20220202182604.oangkxomx3npmobl@intel.com>
 <20220202182811.ivupsaeogyiwl5so@intel.com>
 <20220202184813.euepn3m2twpybpoc@intel.com>
 <CAPcyv4hTRVuO=gVDe1ePTOaC3HiKKD7a00Zxz1uBLakfYFEtsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hTRVuO=gVDe1ePTOaC3HiKKD7a00Zxz1uBLakfYFEtsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-02 11:00:04, Dan Williams wrote:
> On Wed, Feb 2, 2022 at 10:48 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-02-02 10:28:11, Ben Widawsky wrote:
> > > On 22-02-02 10:26:06, Ben Widawsky wrote:
> > > > On 22-01-28 10:59:26, Dan Williams wrote:
> > > > > On Fri, Jan 28, 2022 at 10:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > [..]
> > > > > > Here is that put_device() I was expecting, that kfree() earlier was a
> > > > > > double-free it seems.
> > > > > >
> > > > > > Also, I would have expected a devm action to remove this. Something like:
> > > > > >
> > > > > > struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > > >
> > > > > > cxl_device_lock(&port->dev);
> > > > > > if (port->dev.driver)
> > > > > >     devm_cxl_add_region(port->uport, cxld, id);
> > > >
> > > > I assume you mean devm_cxl_delete_region(), yes?
> > > >
> > > > > > else
> > > > > >     rc = -ENXIO;
> > > > > > cxl_device_unlock(&port->dev);
> > > > > >
> > > > > > ...then no matter what you know the region will be unregistered when
> > > > > > the root port goes away.
> > > > >
> > > > > ...actually, the lock and ->dev.driver check here are not needed
> > > > > because this attribute is only registered while the cxl_acpi driver is
> > > > > bound. So, it is safe to assume this is protected as decoder remove
> > > > > synchronizes against active sysfs users.
> > > >
> > > > I'm somewhat confused when you say devm action to remove this. The current auto
> > > > region deletion happens when the ->release() is called. Are you suggesting when
> > > > the root decoder is removed I delete the regions at that point?
> > >
> > > Hmm. I went back and looked and I had changed this functionality at some
> > > point... So forget I said that, it isn't how it's working currently. But the
> > > question remains, are you suggesting I delete in the root decoder
> > > unregistration?
> >
> > I think it's easier if I write what I think you mean.... Here are the relevant
> > parts:
> >
> > devm_cxl_region_delete() is removed entirely.
> >
> > static void unregister_region(void *_cxlr)
> > {
> >         struct cxl_region *cxlr = _cxlr;
> >
> >         device_unregister(&cxlr->dev);
> > }
> >
> >
> > static int devm_cxl_region_add(struct cxl_decoder *cxld, struct cxl_region *cxlr)
> > {
> >         struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> >         struct device *dev = &cxlr->dev;
> >         int rc;
> >
> >         rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, cxlr->id);
> >         if (rc)
> >                 return rc;
> >
> >         rc = device_add(dev);
> >         if (rc)
> >                 return rc;
> >
> >         return devm_add_action_or_reset(&cxld->dev, unregister_region, cxlr);
> 
> Decoders can't host devm actions. The host for this action would need
> to be the parent port.

Happy to change it since I can't imagine a decoder would go down without the
port also going down. Can you please explain why a decoder can't host a devm
action though. I'd like to understand that better.

> 
> > }
> >
> > static ssize_t delete_region_store(struct device *dev,
> >                                    struct device_attribute *attr,
> >                                    const char *buf, size_t len)
> > {
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >         struct cxl_region *cxlr;
> >
> >         cxlr = cxl_find_region_by_name(cxld, buf);
> >         if (IS_ERR(cxlr))
> >                 return PTR_ERR(cxlr);
> >
> >         devm_release_action(dev, unregister_region, cxlr);
> 
> Yes, modulo the same comment as before that the decoder object is not
> a suitable devm host. This also needs a solution for the race between
> these 2 actions:
> 
> echo "ACPI0017:00" > /sys/bus/platform/drivers/cxl_acpi/unbind
> echo $region > /sys/bus/cxl/devices/$decoder/delete_region

Is there a better solution than taking the root port lock?

