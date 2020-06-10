Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F401F5E7E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFJXBW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 19:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgFJXBV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 19:01:21 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7E82074B;
        Wed, 10 Jun 2020 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591830081;
        bh=D6s2GjxcLUfPry0JlH9bwLCBmcFmi7TaRMRAmNZMKz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eD8hg6rA+0GGExqkSFbfQnw5Nu7bAzc41KPvENK6rPukKhTFj+EQdWP+WY+etQu2q
         3YXFK5bZY5hVo2CEfTuafjisnTtBUISrPdGe10+lF8h12NeGMuUXgOi/O+nL59wFGl
         yLFfqyk6gkYVwsNbtKJUwwqlbUa9Ix32T7eEKSC4=
Date:   Wed, 10 Jun 2020 18:01:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200610230119.GA1528268@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:30:13PM -0700, Rajat Jain wrote:
> On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > > Thanks for sending out the summary, I was about to send it out but got lazy.
> > > ...

> > > The one thing that still needs more thought is how about the
> > > "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> > > needs to be whitelisted for further enumeration downstream. What do
> > > you think?
> >
> > The pcieport driver is required for AER, PCIe native hotplug, PME,
> > etc., and it cannot be a module, so the whitelist wouldn't apply to
> > it.
> 
> Not that I see the need, but slight clarification needed just to make
> sure I understand it clearly:
> 
> Since pcieport driver is statically compiled in, AER, pciehp, PME, DPC
> etc will always be enabled for devices plugged in during boot. But I
> can still choose to choose to allow or deny for devices added *after
> boot* using the whitelist, right?

Yes, I think so.  However, if pcieport doesn't claim hot-added devices
like a dock, I don't think hotplug of PCI things downstream from the
dock will work, e.g., if there are Thunderbolt switches in a monitor
or something.

> Also, denying pcieport driver for hot-added PCIe bridges only disables
> these pcieport services on those bridges, but device enumeration
> further downstream those bridges is not an issue?

Right.  Devices without pcieport would not be able to report hotplug
events, so we wouldn't notice hot-adds or -removes involving those
devices.
