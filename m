Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B776E2A4C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNSzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNSzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 14:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372C8A62;
        Fri, 14 Apr 2023 11:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1CBF649E5;
        Fri, 14 Apr 2023 18:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1656EC433D2;
        Fri, 14 Apr 2023 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681498547;
        bh=4nNhHG+Pedl+92lZreFmeS0KrUw6rOoWlCRO00aERdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MwjifBkEuneOsQr/Jh4g3n64BhDb8+8iWXrZ7n1FkM3RKAUKmkwg9UkRSAliNGyNo
         60BPLz15P87X9I+8S6NnKvmhae7XsSVUWUR6lk5UQXwMsBAGyXK/kYme/T4EbnfEyP
         GXmqlhKQXeZN/2q8mPCZsEpQVFiQfnVzgGWh8V0Xjtb0JDWSXZgQy+ey/d5Xot+N0J
         YdAqBa3eUCDaFgerLPKLkEg7akBXmdh0hdfF+kWh55WghCbnQxNJ6uSrmxUitda1Wv
         FMfLAHGzuFV+UEvyFN+rb7oMgA+dB5GC2jlvlHsHO+2rHq6bc//23zf9aFbCEoo7+4
         j+6dzmcofhMUQ==
Date:   Fri, 14 Apr 2023 13:55:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: of: Propagate firmware node
Message-ID: <20230414185545.GA206084@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgnGuycE5S6rlZk@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 07:00:26PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 12, 2023 at 11:02:53AM -0500, Bjorn Helgaas wrote:
> > On Wed, Apr 12, 2023 at 04:15:20PM +0300, Andy Shevchenko wrote:
> > > Propagate firmware node by using a specific API call, i.e. device_set_node().
> > 
> > Can you add a line or two about *why* we should do this, e.g., is this
> > headed toward some goal?
> 
> Because dereferencing the fwnode in struct device is preventing us from
> modifications of how fwnode looks like in the future.

How do you want to express this in the commit log?  Something like
this?

  Insulate pci_set_of_node() and pci_set_bus_of_node() from possible
  changes to fwnode_handle implementation by using device_set_node()
  instead of open-coding dev->dev.fwnode assignments.

> > Is it a simplification that's 100%
> > equivalent (doesn't seem so, see below)?
> 
> To me it's an equivalent, I'll explain below.
> 
> > Seems like there's an underlying long-term effort to unify things from
> > OF and ACPI, which seems like a good thing, but at the moment it's a
> > little confusing to follow.  For instance pci_set_of_node() seems like
> > it ought to be sort of analogous to pci_set_acpi_fwnode(), but they
> > look nothing alike.
> 
> Unification to some extent, but here is not a point of this change.
> 
> ...
> 
> > > +	struct device_node *node;
> > > +
> > >  	if (!dev->bus->dev.of_node)
> > >  		return;
> > > -	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
> > > -						    dev->devfn);
> > > -	if (dev->dev.of_node)
> > > -		dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > > +	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> > > +	device_set_node(&dev->dev, of_fwnode_handle(node));
> > 
> > This doesn't seem 100% equivalent.  If of_pci_find_child_device()
> > returns NULL, the previous code doesn't set dev->dev.fwnode, but the
> > new code does.
> 
> Yes and this is not a problem. We create device with pci_alloc_dev() in both
> callers of the pci_setup_device() and the field is NULL anyway. So, the last
> condition there is a simple micro-optimisation.

OK, makes sense, thanks.

Bjorn
