Return-Path: <linux-pci+bounces-30564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C5AE7254
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 00:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F798188303F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48322586FE;
	Tue, 24 Jun 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek29q7nU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D42571B4;
	Tue, 24 Jun 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804454; cv=none; b=WehwZNhEJFhx00r4u2xwNyywHQWpqT5/S2HrBlmFMTUy1ZcqxA/poFsPmcPwujdKM/AV2UXW+7xw7iKJyWp7+2WG0e6/MIhyCox5Ap2fuNJjG6KpW0bc6pRxn+Qexs3Y/FavYWz+Y6eHe9+TUtV64WB2N3bNGE5QMIBdOSbF24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804454; c=relaxed/simple;
	bh=eK8NMyHuwrl8dXYAwi4q/jdKZLqI0hmkAk2+xKgeAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BUisn0CfKRf2LDKAfJOxjMEVIbj1phiz8ukSbzpf2VINiiVeniNJtFuO8oyS2LBp6bQgn0vH6ECfU1wzjQd8+g4tXk2YDdGEkI/RQQj9pq0CLy5i0mVLcMg6sno4w3HmNsGZ/a8PchijzgUAc9WDC34auDbtA3wLrAhX0rtlBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek29q7nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD2C4CEE3;
	Tue, 24 Jun 2025 22:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750804454;
	bh=eK8NMyHuwrl8dXYAwi4q/jdKZLqI0hmkAk2+xKgeAtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ek29q7nUOQfyYabkxpsHoxJFUrxv8u4oxmuC8/lTDIqS7HHcQq3jGJokZybHqykBW
	 GYtNHfN4SeEJu3pKWIJ03BPB50bQ1A81gHel5osuiCrybLmmE/KwsVCdAH732vdDPI
	 R9+hZSTHcyLv++4A7V9qdoIiJFg+b3d6xycUzlve50qiOSVhGG2K7ZA3Fdl/vNwMwA
	 9t13cQ5CuqKSeXNjcfunzzQHokSH0uiRlFj+XPkahPCeYlm6rXI1YZAZ3Rkvp+hjXb
	 KJPAlk1k+lL33i8KlZUBUKSIYwbjlJhNKvPW2T1ZqJvBj6/8RoBI18cquq3cbaCS27
	 db55Tm0uixDdg==
Date: Tue, 24 Jun 2025 17:34:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Message-ID: <20250624223413.GA1550003@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>

On Wed, Jun 18, 2025 at 07:37:54PM -0500, Timothy Pearson wrote:
> ----- Original Message -----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> > <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> > "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> > <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> > Sent: Wednesday, June 18, 2025 2:01:46 PM
> > Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention indicator
> 
> > On Wed, Jun 18, 2025 at 11:58:59AM -0500, Timothy Pearson wrote:
> >>  state
> > 
> > Weird wrapping of last word of subject to here.
> 
> I'll need to see what's up with my git format-patch setup. Apologies
> for that across the multiple series.

No worries.  If you can figure out how to make your mailer use the
normal "On xxx, somebody wrote:" attribution instead of duplicating
all those headers, that would be far more useful :)

> >> +static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8
> >> *state)
> >> +{
> >> +	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
> >> +	struct pci_dev *bridge = php_slot->pdev;
> >> +	u16 status;
> >> +
> >> +	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
> >> +	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
> > 
> > Should be able to do this with FIELD_GET().
> 
> I used the same overall structure as the pciehp_hpc driver here.  Do
> you want me to also fix up that driver with FIELD_GET()?

Nope, I think it's fine to keep this looking like pciehp for now.
If somebody wants to use FIELD_GET() in pciehp, I'd probably be OK
with that, but no need for you to open that can of worms.

> > Is the PCI_EXP_SLTCTL_PIC part needed?  It wasn't there before, commit
> > log doesn't mention it, and as far as I can tell, this would be the
> > only driver to do that.  Most expose only the attention status (0=off,
> > 1=on, 2=identify/blink).
> > 
> >> +	return 0;
> >> +}
> >> +
> >> +
> >>  static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
> >>  {
> >>  	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
> >>  
> >> +	pnv_php_get_raw_indicator_status(slot, &php_slot->attention_state);
> > 
> > This is a change worth noting.  Previously we didn't read the AIC
> > state from PCI_EXP_SLTCTL at all; we used php_slot->attention_state to
> > keep track of whatever had been previously set via
> > pnv_php_set_attention_state().
> > 
> > Now we read the current state from PCI_EXP_SLTCTL.  It's not clear
> > that php_slot->attention_state is still needed at all.
> 
> It probably isn't.  It's unclear why IBM took this path at all,
> given pciehp's attention handlers predate pnv-php's by many years.
> 
> > Previously, the user could write any value at all to the sysfs
> > "attention" file and then read that same value back.  After this
> > patch, the user can still write anything, but reads will only return
> > values with PCI_EXP_SLTCTL_AIC and PCI_EXP_SLTCTL_PIC.
> > 
> >>  	*state = php_slot->attention_state;
> >>  	return 0;
> >>  }
> >> @@ -461,7 +474,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot
> >> *slot, u8 state)
> >>  	mask = PCI_EXP_SLTCTL_AIC;
> >>  
> >>  	if (state)
> >> -		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
> >> +		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
> > 
> > This changes the behavior in some cases:
> > 
> >  write 0: previously turned indicator off, now writes reserved value
> >  write 2: previously turned indicator on, now sets to blink
> >  write 3: previously turned indicator on, now turns it off
> 
> If we're looking at normalizing with pciehp with an eye toward
> eventually deprecating / removing pnv-php, I can't think of a better
> time to change this behavior.  I suspect we're the only major user
> of this code path at the moment, with most software expecting to see
> pciehp-style handling.  Thoughts?

I'm OK with changing this, but I do think it would be worth calling
out the different behavior in the commit log.

Bjorn

