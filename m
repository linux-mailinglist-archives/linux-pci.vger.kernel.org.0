Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7661A127E38
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLTOjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 09:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfLTOi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 09:38:59 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F53E222C2;
        Fri, 20 Dec 2019 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852738;
        bh=Q0oWbWwjhrJYvZiFi0omMIk0e9XmFnsXGySlMCDM7Po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S34cSLnz12brD6nSM5Rwvixbj3fIdNLvk2cQmB4xCXmZqVEaPjAbPBX1kurbLh00D
         4NIaxKUGoxQIx9HF316jcCLSslG/mXt8hOzpLFgv1/jjGodLeIhyiHu0RuDEHyQBod
         VYNRotRitMSXsFa32ko6DYaBtMj6FZJsmiiP9a64=
Date:   Fri, 20 Dec 2019 08:38:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Message-ID: <20191220143856.GA92795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043888F94710A361E4D84DFF802D0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 08:50:14AM +0000, Nicholas Johnson wrote:
> On Thu, Dec 19, 2019 at 06:03:58PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 18, 2019 at 12:54:25AM +0000, Nicholas Johnson wrote:
> > > On Tue, Dec 17, 2019 at 09:12:48AM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:

> > > > > Nicholas Johnson (4):
> > > > >   PCI: Consider alignment of hot-added bridges when distributing
> > > > >     available resources
> Prevent failure to assign hot-added Thunderbolt PCI BARs with alignment >1M 
> 
> > > > >   PCI: In extend_bridge_window() change available to new_size
> Change variable name in extend_bridge_window() to better reflect its 
> purpose
> 
> ^ I would have preferred this not be its own commit. Is it too late to 
> squash it back together with patch 3/4?

Not too late; it's trivial to squash it.  I consider these branches to
be drafts, subject to revision until I ask Linus to pull them.

But ... why?  In general, the smaller the patch the better.

> > Basically, I'm not comfortable asking Linus to pull material unless I
> > can explain what the benefit is.  I'm still struggling to articulate
> > the benefit in this case.  I think it makes hotplug work better in
> > some cases where we need more alignment than we currently have, but
> > that's pretty sketchy.
>
> In my opinion, fixing failure to assign is a clear reason to merge, 
> especially when the failure will result in a user wondering why the 
> device they plugged in does not work.

Sure.  But there's nothing specific in the commit logs about what the
problem is and how these fix it.

For example, I think the first patch ("PCI: Consider alignment of
hot-added bridges when distributing available resources") is something
to do with increasing the alignment of bridge windows to account for
descendants that require greater alignment.

But the log says "Rewrite pci_bus_distribute_available_resources to
better handle bridges with different resource alignment requirements."
That says nothing about what the problem was or how you fix it.

Ideally that patch would very specifically change *alignment* details.
It currently also contains a bunch of other changes (interface change,
removing "b" in favor "dev->subordinate", etc).  These make the patch
bigger and harder to understand and justify.  Some of these lead up to
the alignment change but possibly could be split to separate patches.

Bjorn
