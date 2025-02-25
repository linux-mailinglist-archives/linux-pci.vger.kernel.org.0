Return-Path: <linux-pci+bounces-22283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7CA43408
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774183A6A67
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6280322A;
	Tue, 25 Feb 2025 04:01:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7813D8A0;
	Tue, 25 Feb 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740456115; cv=none; b=HorG++YmbSDvJfU4sgLGNFSWAUHFuT40/IHkQ05PZNU7QuiAzwcCUaqnzzq4RL+tjWylZH7jOUJewgpOHu5njd+rxtMPmu9zWplnK26MMB6HeFQh36FnlSZQSNGNfjTkqdH2JK7U/dFekNJzMkhf1fkb1Ny5EjMuEDcGgBTlw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740456115; c=relaxed/simple;
	bh=KAOxZnf6DEsz/XWgRKVcqL0GMgWHzcxKejrt4WTHn70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8l6mKRodkkEwTYUwl41IeB1BzmckFEIelbDobJ++d+fOrfHvtd65zrQY5C05BvZMNaIrW+51Xp6/Y6nKPrx7yoSo4+iT3MNFlhfea7l9GO8OHFI+rgNVKRJk6oozlnqxegzP6XCMICOk9Pwe1L7lAwN2GaNj4kpq/6+KixSo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 562BD2800B6D5;
	Tue, 25 Feb 2025 05:01:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BA5F48CC4A; Tue, 25 Feb 2025 05:01:43 +0100 (CET)
Date: Tue, 25 Feb 2025 05:01:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: rafael@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z71Ap7kpV4rfhFDU@wunner.de>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>

On Tue, Feb 25, 2025 at 11:06:50AM +0800, Feng Tang wrote:
> On Mon, Feb 24, 2025 at 07:12:11PM +0100, Lukas Wunner wrote:
> > On Mon, Feb 24, 2025 at 11:44:58AM +0800, Feng Tang wrote:
> > > @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> > >  		 * Disable hot-plug interrupts in case they have been enabled
> > >  		 * by the BIOS and the hot-plug service driver is not loaded.
> > >  		 */
> > > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > > +		pcie_disable_hp_interrupts_early(dev);
> > >  	}
> > 
> > Moving the Slot Control code from pciehp to portdrv (as is done in
> > patch 1 of this series) is hackish.  It should be avoided if at all
> > possible.
> 
> I tried to remove the code duplication of 2 waiting function, according
> to Bjorn's comment in https://lore.kernel.org/lkml/20250218223354.GA196886@bhelgaas/.
> Maybe I didn't git it right. Any suggestion?

My point is just that you may not need to move the code from pciehp to
portdrv at all if you follow my suggestion.


> There might be some misunderstaning here :), I responded in
> https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> that your suggestion could solve our issue.

Well, could you test it please?

A small change like the one I proposed is definitely preferable to
moving dozens of lines of code around.


> And the reason I didn't take it is I was afraid that it might hurt
> the problem what commit 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port
> services during port initialization") tried to solve.
> 
> As you mentioned, the comment for 2bd50dd800b5 is "a bit confusing",
> and I tried to guess in my previous reply: 
> "
> I'm not sure what problem this piece of code try to avoid, maybe
> something simliar to the irq storm isseu as mentioned in the 2/2 patch?
> The code comments could be about the small time window between this
> point and the loading of pciehp driver, which will request_irq and
> enable hotplug interrupt again.
> "
> 
> The code comment from 2bd50dd800b5 is:
> 
> 	/*
> 	 * Disable hot-plug interrupts in case they have been
> 	 * enabled by the BIOS and the hot-plug service driver
> 	 * is not loaded.
> 	 */
> 
> The "is not loaded" has 2 possible meanings:
> 1. the pciehp driver is not loaded yet at this point inside
>    get_port_device_capability(), and will be loaded later
> 2. the pciehp will never be loaded, i.e. CONFIG_HOTPLUG_PCI_PCIE=n 
> 
> If it's case 2, your suggestion can solve it nicely, but for case 1,
> we may have to keep the interrupt disabling.

The pciehp driver cannot be bound to the PCIe port when
get_port_device_capability() is running.  Because at that point,
portdrv is still figuring out which capabilities the port has and
it will subsequently instantiate the port service devices to which
the drivers (such as pciehp) will bind.

So in that sense, case 1 cannot be what the code comment is
referring to.

My point is that if CONFIG_HOTPLUG_PCI_PCIE=y, there may indeed be
another write to the Slot Control register before the command written
by portdrv has been completed.  Because pciehp will write to the
register on probe.  But in this case, there shouldn't be a need for
portdrv to quiesce the interrupt because pciehp will do that anyway
shortly afterwards.

And in the CONFIG_HOTPLUG_PCI_PCIE=n case, pciehp will not quiesce
the interrupt, so portdrv has to do that.  I believe that's what
the code comment is referring to.  It should be safe to just write
to the Slot Control register without waiting for the command to
complete because there shouldn't be another Slot Control write
afterwards (not by pciehp anyway).

If making the Slot Control write in portdrv conditional on
CONFIG_HOTPLUG_PCI_PCIE=n does unexpectedly *not* solve the issue,
please try to find out where the second Slot Control write is
coming from.  E.g. you could amend pcie_capability_write_word()
with something like:

	if (pos == PCI_EXP_SLTCTL) {
		pci_info(dev, "Writing %04hx SltCtl\n", val);
		dump_stack();
	}

Thanks,

Lukas

