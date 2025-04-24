Return-Path: <linux-pci+bounces-26658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E63A9A08B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E25019404BF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC81953BB;
	Thu, 24 Apr 2025 05:38:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411815098F;
	Thu, 24 Apr 2025 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473089; cv=none; b=LKkVeyTMuIE9//xzxDJ/Y81QPvo9/SYLAxGDAQBkXskihxk6uto3a6gxWHEGz3DTKtW6OxX08sfBo1r4YtTNiaOam/yregzy7CJanAya65yngnclJgXw/p0FgX4o8vkvOtHhJDi+ofXr510hGa6fMO8Qgd8uxtRVC5r21rRYnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473089; c=relaxed/simple;
	bh=23WVCUCHMkJ1VGdoSp2LC9yNWdqF4ixlIwlvg96w7+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv3qNo/cAZf7NL6xV8c5UMqx2ytqGPLepDB/Ut4m80iAk0Gv5PxpQvL+vprmR2288BUHb4p7aJazzzWqZyxMc/1TJEvpeZacyKTG/cLl5pfomNyA0lm+UK26jGZXSc2mTCCFtMu7cJtcQfZuslNRXwnuRqNGSFCAZzdCSsyzzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 641592C05262;
	Thu, 24 Apr 2025 07:37:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 26D2DFF6A0; Thu, 24 Apr 2025 07:38:02 +0200 (CEST)
Date: Thu, 24 Apr 2025 07:38:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with
 PCI_LINK_LBMS_SEEN flag
Message-ID: <aAnOOj91-N6rwt2x@wunner.de>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>
 <aAi734h55l7g6eXH@wunner.de>
 <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com>

On Wed, Apr 23, 2025 at 02:37:11PM +0300, Ilpo Järvinen wrote:
> On Wed, 23 Apr 2025, Lukas Wunner wrote:
> > On Tue, Apr 22, 2025 at 02:55:47PM +0300, Ilpo Järvinen wrote:
> > > +void pcie_reset_lbms(struct pci_dev *port)
> > >  {
> > > -	struct pcie_bwctrl_data *data;
> > > -
> > > -	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> > > -	data = port->link_bwctrl;
> > > -	if (data)
> > > -		atomic_set(&data->lbms_count, 0);
> > > -	else
> > > -		pcie_capability_write_word(port, PCI_EXP_LNKSTA,
> > > -					   PCI_EXP_LNKSTA_LBMS);
> > > +	clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
> > > +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
> > >  }
> > 
> > Hm, previously the LBMS bit was only cleared in the Link Status register
> > if the bandwith controller hadn't probed yet.  Now it's cleared
> > unconditionally.  I'm wondering if this changes the logic somehow?
> 
> Hmm, that's a good question and I hadn't thought all the implications.
> I suppose leaving if (!port->link_bwctrl) there would retain the existing 
> behavior better allowing bwctrl to pick the link speed changes more 
> reliably.

I think the only potential issue with clearing the LBMS bit in the register
is that the bandwidth controller's irq handler won't see the bit and may
return with IRQ_NONE.

However, looking at the callers of pcie_reset_lbms(), that doesn't seem
to be a real issue.  There are only two of them:

- pcie_retrain_link() calls the function after the link was retrained.
  I guess the LBMS bit in the register may be set as a side-effect of
  the link retraining?  The only concern here is whether the cached
  link speed is updated.  pcie_bwctrl_change_speed() does call
  pcie_update_link_speed() after calling pcie_retrain_link(), so that
  looks fine.  But there's a second caller of pcie_retrain_link():
  pcie_aspm_configure_common_clock().  It doesn't update the cached
  link speed after calling pcie_retrain_link().  Not sure if this can
  lead to a change in link speed and therefore the cached link speed
  should be updated?  The Target Link Speed isn't changed, but maybe
  the link fails to retrain to the same speed for electrical reasons?

- pciehp's remove_board() calls the function after bringing down the slot
  to avoid a stale PCI_LINK_LBMS_SEEN flag.  No real harm in clearing the
  bit in the register at this point I guess.  But I do wonder, is the link
  speed updated somewhere when a new board is added?  The replacement
  device may not support the same speeds as the previous device.


> Given this flag is only for the purposes of the quirk, it seems very much 
> out of proportions.

Yes, let's try to minimize the amount of locking, flags and code to support
the quirk.  Keep it as simple as possible.  So in that sense, the solution
you've chosen is probably fine.


> > >  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
> > >  {
> > > -	unsigned long count;
> > > -	int ret;
> > > -
> > > -	ret = pcie_lbms_count(dev, &count);
> > > -	if (ret < 0)
> > > -		return lnksta & PCI_EXP_LNKSTA_LBMS;
> > > +	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> > > +		return true;
> > >  
> > > -	return count > 0;
> > > +	return lnksta & PCI_EXP_LNKSTA_LBMS;
> > >  }
> > 
> > Another small logic change here:  Previously pcie_lbms_count()
> > returned a negative value if the bandwidth controller hadn't
> > probed yet or wasn't compiled into the kernel.
> > Only in those two cases was the LBMS flag in the lnksta variable 
> > returned.
> > 
> > Now the LBMS flag is also returned if the bandwidth controller
> > is compiled into the kernel and has probed, but its irq handler
> > hasn't recorded a seen LBMS bit yet.
> > 
> > I'm guessing this can happen if the quirk races with the irq
> > handler and wins the race, so this safety net is needed?
> 
> The main reason why this check is here is for the boot when bwctrl is not 
> yet probed when the quirk runs. But the check just seems harmless, or 
> even somewhat useful, in the case when bwctrl has already probed. LBMS 
> being asserted should result in PCI_LINK_LBMS_SEEN even if the irq 
> handler has not yet done its job to transfer it into priv_flags.

Okay I'm convinced that the logic change in pcie_lbms_seen() is fine.

Thanks,

Lukas

