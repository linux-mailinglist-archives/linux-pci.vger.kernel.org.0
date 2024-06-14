Return-Path: <linux-pci+bounces-8854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B29909400
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC431C20F7C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55514883B;
	Fri, 14 Jun 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsXI2jcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4147149C44;
	Fri, 14 Jun 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402609; cv=none; b=JxIYA1yO1B4Nn2+GqWQm1xOmMtkxBQP1H7U2xRs7ANdURT4ewQXC8LF+1VRc6MTz8R/ptqmO+o9wxocjcoz4QO+0JbeuyaPt51Jj0U05hf+oilgAdC+JG6uraXq4QDTp/9xQ1zvPfD6im3SYXpawkbXwKyYf4Ct+YTzm4qjJYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402609; c=relaxed/simple;
	bh=pnfRKVMJtcMvTZXgsbnPkluvMLxhMc1SMF0VOt5BoRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oMelfj6f0YT7nTFaO1Kst0Fu3CbUkTvpOM9VfL2NeGhy0uEercbgwVfbEf1LT+C2bEhZNeRERQzNs6X/PmpiGlZ69UjOCfSOaSxvn/uqC/ASWpGvenAFlKJhM/nu1o5xzo2wFb3+5LiIroVctmWTvlS/8CAXvgmZLSUf6uacGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsXI2jcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C8BC2BD10;
	Fri, 14 Jun 2024 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718402609;
	bh=pnfRKVMJtcMvTZXgsbnPkluvMLxhMc1SMF0VOt5BoRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OsXI2jcWYpgFuwwLeo3viE6MZZ5Zr3ulI4P+WzFGbdHbLKa0zpoT6JTwFrU3KbgdB
	 3NXjVaJ3ux4D5H/h8r1RofiY/h5d7dFmHm8JtkLRscEqqUmQC9vX/YDkI/NL9BDcK/
	 1cFoaIKi6V7CoKgfIOZ3HkKlxA/nMx6rZ+zhSWElHPOOc1Q+bkiTI5l78ZgbrFkQa+
	 3DhoZP9u6Pkq9RbL9t6NISOtaPmnDbnDfiHxwlBSAA8wz6iTDBQxlA/k+9ztyAFZH6
	 BWBqDtJ4VdCs8a14yyjjzbVT5ZYXpWoLHjVjW2tggzNOi+pC2BfAsz95LJBdEUx9/D
	 9qT2hecRbIMCA==
Date: Fri, 14 Jun 2024 17:03:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, bhelgaas@google.com,
	weirongguang@kylinos.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kanie@linux.alibaba.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <20240614220327.GA1125489@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmyb2WMhhNc7zQ2i@wunner.de>

On Fri, Jun 14, 2024 at 09:36:57PM +0200, Lukas Wunner wrote:
> On Fri, Jun 14, 2024 at 01:41:20PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 02:42:00PM +0800, Bitao Hu wrote:
> > > "present" and "link_active" can be 1 if the status is ready, and 0 if
> > > it is not. Both of them can be -ENODEV if reading the config space
> > > of the hotplug port failed. That's typically the case if the hotplug
> > > port itself was hot-removed. Therefore, this situation can occur:
> > > pciehp_card_present() may return 1 and pciehp_check_link_active()
> > > may return -ENODEV because the hotplug port was hot-removed in-between
> > > the two function calls. In that case we'll emit both "Card present"
> > > *and* "Link Up" since both 1 and -ENODEV are considered "true". This
> > > is not the expected behavior. Those messages should be emited when
> > > "present" and "link_active" are positive.
> [...]
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> > >  	case OFF_STATE:
> > >  		ctrl->state = POWERON_STATE;
> > >  		mutex_unlock(&ctrl->state_lock);
> > > -		if (present)
> > > +		if (present > 0)
> > 
> > I completely agree that this is a problem and this patch addresses it.
> > But ...
> > 
> > It seems a little bit weird to me that we even get to this switch
> > statement if we got -ENODEV from either pciehp_card_present() or
> > pciehp_check_link_active().  If that happens, a config read failed,
> > but we're going to go ahead and call pciehp_enable_slot(), which is
> > going to do a bunch more config accesses, potentially try to power up
> > the slot, etc.
> > 
> > If a config read failed, it seems like we might want to avoid doing
> > some of this stuff.
> 
> Hm, good point.  I guess we should change the logical expression instead:
> 
> -	if (present <= 0 && link_active <= 0) {
> +	if (present < 0 || link_active < 0 || (!present && !link_active)) {

It gets to be a fairly complicated expression, and I'm not 100% sure
we should handle the config read failure the same as the "!present &&
!link_active" case.  The config read failure probably means the
Downstream Port is gone, the other case means the device *below* that
port is gone.  

We likely want to cancel the delayed work in both cases, but what
about the indicators?  If the Downstream Port is gone, we're not going
to be able to change them.  Do we want the same message for both?

Maybe we should handle the config failures separately first?  These
error conditions make everything so ugly.

> > > -		if (link_active)
> > > +		if (link_active > 0)
> > >  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> > >  				  slot_name(ctrl));
> > 
> > These are cases where we misinterpreted -ENODEV as "device is present"
> > or "link is active".
> > 
> > pciehp_ignore_dpc_link_change() and pciehp_slot_reset() also call
> > pciehp_check_link_active(), and I think they also interpret -ENODEV as
> > "link is active".
> > 
> > Do we need similar changes there?
> 
> Another good observation, both need to check for <= 0 instead of == 0.
> Do you want to fix that yourself or would you prefer me (or someone else)
> to submit a patch?

It'd be great if you or somebody else could do that.

Bjorn

