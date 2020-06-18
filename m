Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD981FEB65
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 08:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgFRGSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 02:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgFRGSY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 02:18:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB11217A0;
        Thu, 18 Jun 2020 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592461104;
        bh=HAlp2tDJH3cJiBHUwxJhNgGAK1kQ1E4yMCcXlEeqs78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGFnZH/qxGeZiY//+LODKLj7bcSwyB7/m8jtc3u4vRh6hm3/Se2lEeMHSsRhqMOJq
         /c5mpTUoL6eUZry163d8kI073YDaCdpQKq0e7SAgbAI5FQfmWumi7umOoc+tT0NSYA
         zWsw0Q9eJPDd6ogQRSC4Le/4nYn7+NncYHshtZIs=
Date:   Thu, 18 Jun 2020 08:18:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618061821.GB49383@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 17, 2020 at 12:53:03PM -0700, Rajat Jain wrote:
> Hi Greg, Christoph,
> 
> On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jun 16, 2020 at 12:27:35PM -0700, Rajat Jain wrote:
> > > Need clarification. The flag "untrusted" is currently a part of
> > > pci_dev struct, and is populated within the PCI subsystem.
> >
> > Yes, and that is the problem.
> >
> > >
> > > 1) Is your suggestion to move this flag as well as the attribute to
> > > device core (in "struct device")? This would allow other buses to
> > > populate/use this flag if they want. By default it'll be set to 0 for
> > > all devices (PCI subsystem will populate it based on platform info,
> > > like it does today).
> > >
> > > OR
> > >
> > > 2) Are you suggesting to keep the "untrusted" flag within PCI, but
> > > attach the sysfs attribute to the base device? (&pci_dev->dev)?
> >
> > (1).  As for IOMMUs and userspace policy it really should not matter
> > what bus a device is on if it is external and not trustworthy.
> 
> Sure. I can move the flag to the "struct device" (and likely call
> it "external" instead of "untrusted" so as to make it suitable for
> more use cases later).  The buses can fill this up if they know which
> devices are external and which ones are not (otherwise it will be 0 by
> default). The PCI can fill this up like it does today, from platform
> info (ACPI / Device tree). Greg, how does this sound?

That's fine, convert USB over to use it at the same time if you get the
chance :)

thanks,

greg k-h
