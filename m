Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44784A77E5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiBBS0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 13:26:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:27379 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237063AbiBBS0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 13:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643826366; x=1675362366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5lFTo574KUlzFBIVhKVEFCo/gFEvbqxFvFV8HxS9aUU=;
  b=jWQ9HJKSoOk6uNWbFZ41Mkdm5AUyYMfJMe+WLc2yZxq0aJVTZ+7OFw96
   MZoSEfJf5kWJa5Fdj0MeQXxMqcdCbQJUy+yJamgNHdHdZx7wAEEtrQf3z
   0/5o/4SedT9St/jAqh+AdPcvHLUCxrv+X8vxou6+wiAlJI4vkWtEe3IS/
   Seh43J7AQtJrIkvh0qCg1nxKbWPAaVygOEoH9eW9NqrieH01oXr9eVuFE
   clGXBJ9VV5esnuMBLrSlleLhLFEvb08CgnILczjbvTIR3lTvZyPFOZ1l/
   vXB1sZh2PnFbD25M9BDSPuK/DSQX685+c0Qejn2leUgK4uXMrquB24e4l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247944744"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247944744"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:26:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="497845490"
Received: from svenur-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.133.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:26:06 -0800
Date:   Wed, 2 Feb 2022 10:26:04 -0800
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
Message-ID: <20220202182604.oangkxomx3npmobl@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-2-ben.widawsky@intel.com>
 <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
 <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-28 10:59:26, Dan Williams wrote:
> On Fri, Jan 28, 2022 at 10:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
> [..]
> > Here is that put_device() I was expecting, that kfree() earlier was a
> > double-free it seems.
> >
> > Also, I would have expected a devm action to remove this. Something like:
> >
> > struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> >
> > cxl_device_lock(&port->dev);
> > if (port->dev.driver)
> >     devm_cxl_add_region(port->uport, cxld, id);

I assume you mean devm_cxl_delete_region(), yes?

> > else
> >     rc = -ENXIO;
> > cxl_device_unlock(&port->dev);
> >
> > ...then no matter what you know the region will be unregistered when
> > the root port goes away.
> 
> ...actually, the lock and ->dev.driver check here are not needed
> because this attribute is only registered while the cxl_acpi driver is
> bound. So, it is safe to assume this is protected as decoder remove
> synchronizes against active sysfs users.

I'm somewhat confused when you say devm action to remove this. The current auto
region deletion happens when the ->release() is called. Are you suggesting when
the root decoder is removed I delete the regions at that point?
