Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6795941EB05
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbhJAKic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 06:38:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:37232 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhJAKib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 06:38:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225053546"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="225053546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="619007355"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2021 03:36:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Oct 2021 13:36:43 +0300
Date:   Fri, 1 Oct 2021 13:36:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <YVbku7IQatCydZ+V@kuha.fi.intel.com>
References: <20210930121246.22833-2-heikki.krogerus@linux.intel.com>
 <20210930150402.GA877907@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930150402.GA877907@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 10:04:02AM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 30, 2021 at 03:12:45PM +0300, Heikki Krogerus wrote:
> > In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> > instead of device_add_properties() to set the "dma-can-stall"
> > property.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Hi,
> > 
> > The commit message now says what Bjorn requested, except I left out
> > the claim that the patch fixes a lifetime issue.
> 
> Thanks.
> 
> The commit log should help reviewers determine whether the change is
> safe and necessary.  So far it doesn't have any hints along that line.
> 
> Comparing device_add_properties() [1] and
> device_create_managed_software_node() [2], the only difference in this
> case is that the latter sets "swnode->managed = true".  The function
> comment says "managed" means the lifetime of the swnode is tied to the
> lifetime of dev, hence my question about a lifetime issue.
> 
> I can see that one reason for this change is to remove the last caller
> of device_add_properties(), so device_add_properties() itself can be
> removed.  That's a good reason for wanting to do it, and the commit
> log could mention it.

Fair enough. I need to explain the why as well as the what.

I'll improve the commit message, but just to be clear, the goal is
actually not to get rid of device_add_properties(). It is removed in
the second patch together with device_remove_properties() because
there are simply no more users for that API.

> But it doesn't help me figure out whether it's safe.  For that,
> I need to know the effect of setting "managed = true".  Obviously
> it means *something*, but I don't know what.  It looks like the only
> test is in software_node_notify():
> 
>   device_del
>     device_platform_notify_remove
>       software_node_notify_remove
>         sysfs_remove_link(dev_name)
>         sysfs_remove_link("software_node")
>         if (swnode->managed)                 <--
>           set_secondary_fwnode(dev, NULL)
>           kobject_put(&swnode->kobj)
>     device_remove_properties
>       if (is_software_node())
>         fwnode_remove_software_node
>           kobject_put(&swnode->kobj)
>         set_secondary_fwnode(dev, NULL)
> 
> I'm not sure what's going on here; it looks like some redundancy with
> multiple calls of kobject_put() and set_secondary_fwnode().  Maybe you
> are in the process of removing device_remove_properties() as well as
> device_add_properties()?

It'll get removed, but that's not the goal. The goal is to get rid of
the call to it in device_del(), so not the function itself. That call
is the problem here as explained in commit 151f6ff78cdf ("software
node: Provide replacement for device_add_properties()").

I'll split the second patch, and first only remove that
device_remove_properties() call from device_del(), and only after
that remove the functions themselves.

thanks,

-- 
heikki
