Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5C4A7836
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbiBBSsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 13:48:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:48457 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346631AbiBBSsP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 13:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643827695; x=1675363695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lt4aeih5HUzhuMRVZTjJnXmGDNR4EvgwNemvdrmLpkc=;
  b=hemg9GGgYUcfjkIXDCPz5Xy4gTn7R1HNY8fiktZufsR5kPylp5XsTzQq
   lBl2t1Dg9kfDgfXuf484bk2ab51JLwMcuhY0r9hG2q+/iFAjICQXI03XC
   byTbXgJFxBCkiTxmBU5If8rHMHmLkoF/b7puuu0ho6SABzDQIpvgitQ1W
   enXr88FPitCSooSp4qJVZNPtqOYtRcejINzOqDqkqgE/MLtkZOtI4lZnp
   nTwcjTA042vpnxVFCJR8feLf8ovk0RMMhchu/rA/FvY8MmKsd718AoSEj
   dHWp0ju2fCmb8MZT+K3R7M7YOnbRgAP1xL/sqc1ErR7L8pTf8SyGjpLmD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235394659"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="235394659"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:48:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="769375114"
Received: from svenur-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.133.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:48:14 -0800
Date:   Wed, 2 Feb 2022 10:48:13 -0800
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
Message-ID: <20220202184813.euepn3m2twpybpoc@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-2-ben.widawsky@intel.com>
 <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
 <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
 <20220202182604.oangkxomx3npmobl@intel.com>
 <20220202182811.ivupsaeogyiwl5so@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202182811.ivupsaeogyiwl5so@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-02 10:28:11, Ben Widawsky wrote:
> On 22-02-02 10:26:06, Ben Widawsky wrote:
> > On 22-01-28 10:59:26, Dan Williams wrote:
> > > On Fri, Jan 28, 2022 at 10:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > [..]
> > > > Here is that put_device() I was expecting, that kfree() earlier was a
> > > > double-free it seems.
> > > >
> > > > Also, I would have expected a devm action to remove this. Something like:
> > > >
> > > > struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > >
> > > > cxl_device_lock(&port->dev);
> > > > if (port->dev.driver)
> > > >     devm_cxl_add_region(port->uport, cxld, id);
> > 
> > I assume you mean devm_cxl_delete_region(), yes?
> > 
> > > > else
> > > >     rc = -ENXIO;
> > > > cxl_device_unlock(&port->dev);
> > > >
> > > > ...then no matter what you know the region will be unregistered when
> > > > the root port goes away.
> > > 
> > > ...actually, the lock and ->dev.driver check here are not needed
> > > because this attribute is only registered while the cxl_acpi driver is
> > > bound. So, it is safe to assume this is protected as decoder remove
> > > synchronizes against active sysfs users.
> > 
> > I'm somewhat confused when you say devm action to remove this. The current auto
> > region deletion happens when the ->release() is called. Are you suggesting when
> > the root decoder is removed I delete the regions at that point?
> 
> Hmm. I went back and looked and I had changed this functionality at some
> point... So forget I said that, it isn't how it's working currently. But the
> question remains, are you suggesting I delete in the root decoder
> unregistration?

I think it's easier if I write what I think you mean.... Here are the relevant
parts:

devm_cxl_region_delete() is removed entirely.

static void unregister_region(void *_cxlr)
{
        struct cxl_region *cxlr = _cxlr;

        device_unregister(&cxlr->dev);
}


static int devm_cxl_region_add(struct cxl_decoder *cxld, struct cxl_region *cxlr)
{
        struct cxl_port *port = to_cxl_port(cxld->dev.parent);
        struct device *dev = &cxlr->dev;
        int rc;

        rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, cxlr->id);
        if (rc)
                return rc;

        rc = device_add(dev);
        if (rc)
                return rc;

        return devm_add_action_or_reset(&cxld->dev, unregister_region, cxlr);
}

static ssize_t delete_region_store(struct device *dev,
                                   struct device_attribute *attr,
                                   const char *buf, size_t len)
{
        struct cxl_decoder *cxld = to_cxl_decoder(dev);
        struct cxl_region *cxlr;

        cxlr = cxl_find_region_by_name(cxld, buf);
        if (IS_ERR(cxlr))
                return PTR_ERR(cxlr);

        devm_release_action(dev, unregister_region, cxlr);

        return len;
}
DEVICE_ATTR_WO(delete_region);
