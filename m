Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66ED42917B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhJKOTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 10:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242540AbhJKORD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 10:17:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E2846136F;
        Mon, 11 Oct 2021 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633961179;
        bh=w5y83sNdnzbd+RwMEcSG5seR5+ET5nOWfWBbqyRe1VE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gPAisVbSkBEsYzvJp0KAUnFr1V8Z2cxEttLZOXj6pngV3I1BGyRsCjkMJttU3VOzh
         SU9HsBp3hHX92euYETfkqvSj4Jk8JPh7bKSOCXm3bZo9aprA0nC4KpitkLY5Mihgdt
         K4rgBiYjXyl/jVycnW2VWo0ttFPaNnMc71qfICE8dmk7Oqz59hxnyoPWLEbO9HP7oD
         ASCZx0J5rPrRQYyLHQLvqNXRzDUAWWRKCjD7TzvLl8NZR31r/1n/YQ5eytGw4E1Wfj
         3eXP1PftwXR6Fyw7CdiDDIvB4QZqzSHsTCeOoscwemo4vRwzkZISEkiWbUIE+5QD8z
         IJ6UOiB6ACa+g==
Date:   Mon, 11 Oct 2021 09:06:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, stefanha@redhat.com, oren@nvidia.com,
        kw@linux.com
Subject: Re: [PATCH v3 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <20211011140617.GA1643826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a947cd7e-c847-4d44-5a65-51bbdceb1a1d@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 10, 2021 at 11:36:49AM +0300, Max Gurtovoy wrote:
> 
> On 10/9/2021 1:25 AM, Bjorn Helgaas wrote:
> > On Mon, Oct 04, 2021 at 04:34:53PM +0300, Max Gurtovoy wrote:
> > > Use the proper macro instead of hard-coded (-1) value.
> > > 
> > > Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> > > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > These two patches are independent, so I applied this patch only to
> > pci/sysfs for v5.16, thanks!
> > 
> > I assume Greg will take the drivers/base patch.
> 
> I saw both patches in his
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> driver-core-next
> 
> So I guess there is no need for taking it separately, right Greg ?

No problem, I dropped the pci-sysfs.c patch.  Thanks for letting me
know!

> > > ---
> > >   drivers/pci/pci-sysfs.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 7fb5cd17cc98..f807b92afa6c 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -81,8 +81,10 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
> > >   	const struct cpumask *mask;
> > >   #ifdef CONFIG_NUMA
> > > -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> > > -					  cpumask_of_node(dev_to_node(dev));
> > > +	if (dev_to_node(dev) == NUMA_NO_NODE)
> > > +		mask = cpu_online_mask;
> > > +	else
> > > +		mask = cpumask_of_node(dev_to_node(dev));
> > >   #else
> > >   	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
> > >   #endif
> > > -- 
> > > 2.18.1
> > > 
