Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78A51F35
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 01:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfFXXqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 19:46:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:41372 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfFXXqn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 19:46:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5ONj6Nk032164;
        Mon, 24 Jun 2019 18:45:07 -0500
Message-ID: <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 25 Jun 2019 09:45:04 +1000
In-Reply-To: <20190624112449.GJ2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
         <20190622210310.180905-3-helgaas@kernel.org>
         <20190624112449.GJ2640@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-24 at 14:24 +0300, Mika Westerberg wrote:
> > 
> > I'm pretty sure this patch preserves the previous behavior of
> > pci_bus_distribute_available_resources(), but I'm not sure that
> > behavior is what we want.
> > 
> > For example, in the following topology, when we process bus 10, we
> > find two non-hotplug bridges and no hotplug bridges, so IIUC we
> > return
> > without distributing any resources to them.  But I would think we
> > should try to give 10:1c.0 more space if possible because it has a
> > hotplug bridge below it.
> > 
> >    00:1c.0: hotplug bridge to [bus 10-2f]
> >      10:1c.0: non-hotplug bridge to [bus 11-2e]
> >        11:00.0: hotplug bridge to [bus 12-2e]
> >      10:1c.1: non-hotplug bridge to [bus 2f]
> 
> Yes, I agree in this case we want to preserve more space for 10:1c.0.

I sitll can't make sense of any of this stuff though.

We only every distribute resources when using
pci_assign_unassigned_bridge_resources which we only use some cases,
and it's completely non obvious why we would use it there and not in
other places.

We also don't distribute during the initial root survey meaning afaik
that we get toast for any hotplug bridge that has stuff already there
at boot.

Also, distributing the "available" space means we leave nothing for
potential SR-IOV siblings... have we ended up bloting the very PCIe-
centric assumption that it's "unlikely" that a hotplug bridge has an
SR-IOV sibling ?

This is all a terrible mess and I feel that all these little tweaks
here or there are just making it even more impossible to completely
grasp or predict how it will behave.

Ben.


