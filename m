Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8977D56F9C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZRfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 13:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZRfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:07 -0400
Received: from localhost (c-67-164-175-55.hsd1.co.comcast.net [67.164.175.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA07F2080C;
        Wed, 26 Jun 2019 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561570506;
        bh=AYrRdeA88kGnRapkZRCfkzdjFMsrStCImYiRgioEu+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN7+rEU+bDUYZW+oQmvrgYT2zY28dWp2dF67mlPRPKbduVlRNGbZ4io05gOVTF4PI
         2oN9OdXY96mTnfYRfjzOmck89T9EjWVqUXPkbeFJBK2HmbWhMBIDI4sd7u+bfOwwB6
         4kVZf3+v6F/CDVaLM0R6oBP+22hdrJL4sXkOnCcU=
Date:   Wed, 26 Jun 2019 12:35:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
Message-ID: <20190626173505.GB183605@google.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
 <20190624112449.GJ2640@lahna.fi.intel.com>
 <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 09:45:04AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-06-24 at 14:24 +0300, Mika Westerberg wrote:
> > > 
> > > I'm pretty sure this patch preserves the previous behavior of
> > > pci_bus_distribute_available_resources(), but I'm not sure that
> > > behavior is what we want.
> > > 
> > > For example, in the following topology, when we process bus 10, we
> > > find two non-hotplug bridges and no hotplug bridges, so IIUC we
> > > return
> > > without distributing any resources to them.  But I would think we
> > > should try to give 10:1c.0 more space if possible because it has a
> > > hotplug bridge below it.
> > > 
> > >    00:1c.0: hotplug bridge to [bus 10-2f]
> > >      10:1c.0: non-hotplug bridge to [bus 11-2e]
> > >        11:00.0: hotplug bridge to [bus 12-2e]
> > >      10:1c.1: non-hotplug bridge to [bus 2f]
> > 
> > Yes, I agree in this case we want to preserve more space for 10:1c.0.
> 
> I sitll can't make sense of any of this stuff though.
> 
> We only every distribute resources when using
> pci_assign_unassigned_bridge_resources which we only use some cases,
> and it's completely non obvious why we would use it there and not in
> other places.
> 
> We also don't distribute during the initial root survey meaning afaik
> that we get toast for any hotplug bridge that has stuff already there
> at boot.
> 
> Also, distributing the "available" space means we leave nothing for
> potential SR-IOV siblings... have we ended up bloting the very PCIe-
> centric assumption that it's "unlikely" that a hotplug bridge has an
> SR-IOV sibling ?
> 
> This is all a terrible mess and I feel that all these little tweaks
> here or there are just making it even more impossible to completely
> grasp or predict how it will behave.

No argument about it being a mess.

I agree that tweaks clutter the history, which is definitely a
downside.  Do you think these actually change the way things work or
make the code harder to read?

I think there is value in even minor simplifications that make the
code easier to understand.  Small improvements compound over time and
expose opportunities for more significant improvement.

Bjorn
