Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399216E1192
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDMQAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMQAc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 12:00:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD6D1726;
        Thu, 13 Apr 2023 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681401631; x=1712937631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LIJ4RlULt2rf1Gc6aHteTfEaZqZKJNQfvSIBCJ0nXxY=;
  b=AGXkQ8hbhCroJU96bjTcOj9YBA5GkYUL0ugBg7yQVBJ7TNKr64KF26hU
   QTjYDsHyJkHZRUkgZF5L6LZvGFXYmQP5wSviM7TM51yjGCJ+/Sf+RXHQb
   KrPGXGYmqLaUjJ4sguva11J48ZDrHlI7AVsRpShmJOSC99mwt4KDGqQVt
   NBT2myb1i2wqENLm6ChE07DR+BaUsMw1FejbGllhNNO0VIyvtMGfPiJ8/
   fDE7lyqnc7HkSiQZmlKK7oQZP5u0qxBIjWTyMf3zyLwQk8m2i6cIci8QV
   //skk80rb5UkcjLdpiCbA8sux9HggjIAaChEF+fEtZuWhx0WNRz79NEW5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="342969930"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="342969930"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 09:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="682994924"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="682994924"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2023 09:00:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmzN5-00GcOw-08;
        Thu, 13 Apr 2023 19:00:27 +0300
Date:   Thu, 13 Apr 2023 19:00:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: of: Propagate firmware node
Message-ID: <ZDgnGuycE5S6rlZk@smile.fi.intel.com>
References: <20230412131520.52840-1-andriy.shevchenko@linux.intel.com>
 <20230412160253.GA41376@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412160253.GA41376@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 11:02:53AM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 12, 2023 at 04:15:20PM +0300, Andy Shevchenko wrote:
> > Propagate firmware node by using a specific API call, i.e. device_set_node().
> 
> Can you add a line or two about *why* we should do this, e.g., is this
> headed toward some goal?

Because dereferencing the fwnode in struct device is preventing us from
modifications of how fwnode looks like in the future.

> Is it a simplification that's 100%
> equivalent (doesn't seem so, see below)?

To me it's an equivalent, I'll explain below.

> Seems like there's an underlying long-term effort to unify things from
> OF and ACPI, which seems like a good thing, but at the moment it's a
> little confusing to follow.  For instance pci_set_of_node() seems like
> it ought to be sort of analogous to pci_set_acpi_fwnode(), but they
> look nothing alike.

Unification to some extent, but here is not a point of this change.

...

> > +	struct device_node *node;
> > +
> >  	if (!dev->bus->dev.of_node)
> >  		return;
> > -	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
> > -						    dev->devfn);
> > -	if (dev->dev.of_node)
> > -		dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > +	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > +	device_set_node(&dev->dev, of_fwnode_handle(node));
> 
> This doesn't seem 100% equivalent.  If of_pci_find_child_device()
> returns NULL, the previous code doesn't set dev->dev.fwnode, but the
> new code does.

Yes and this is not a problem. We create device with pci_alloc_dev() in both
callers of the pci_setup_device() and the field is NULL anyway. So, the last
condition there is a simple micro-optimisation.


-- 
With Best Regards,
Andy Shevchenko


