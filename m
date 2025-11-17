Return-Path: <linux-pci+bounces-41424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 048EAC64F15
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25C19356CF6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6D283CA3;
	Mon, 17 Nov 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b85vojgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B47275864
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394297; cv=none; b=ILYBRkZE7GbCPV7LKPeKwsVkZ82USJixlloT/M8stSY99kNxacZg48mlPXoMVJYn6EtmZSVQ8rUzYCAzDvHvqvBDt9ytoJ1zsu1SJVV9XZ9ZOQcp9rxEdxmYF0PBvowEnnOCt8Pl64ribxmLfn5gSOc6nK2E0UFwmRVx6vGf/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394297; c=relaxed/simple;
	bh=zwqclxhWp3aaBUrKU9OxEKUSc4dzyHGaeFwhxPIYl+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hcgy7bimgZDPWLEkcJcKsODSQigh3XYLJoSWG7IElNXGOe3+Leiw7eifDZqE5+2VO0shG4xvcaWY5dXONY2w4DS1pkJqI+bQKLLEtNaPWjzYGXzrhYqA71Y4gruOQS43PvjqcfGAr/ECNfbHH+o6YNMZShWBkUSm0b5kATUgpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b85vojgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C0CC19423;
	Mon, 17 Nov 2025 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394296;
	bh=zwqclxhWp3aaBUrKU9OxEKUSc4dzyHGaeFwhxPIYl+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b85vojgwHlqbiy7eCYJKSVaF5SkuvltxJFQxy/p3nLdCZ4WHBj2CAkoTEbWF3Ot61
	 GUN9rNec4fiEeXmRTGz4M25A0r1DkV0CtJ5dKOHEDNjreN2aJ/zB1/AsU7kboNXNLB
	 b1dWuA4OpZKpf08J1OCtgJWH5ojMOMKNDJdQiUMufnrrrW7pI16qW/MwvTr2X735de
	 G56UvmFxMTnKwTzBJbFZKXF1fGsAo7aGveL0T+RDSKx+v/r9qVGgtUsGBNQA7ezj0G
	 43L++wjHL/87o+2EsMjcua9LARv1hiUgfJAbUaLFIPYrXCWZ59IFKEJcxPYbjqG846
	 bT6gXWGV52NDA==
Date: Mon, 17 Nov 2025 09:44:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	bhelgaas@google.com, Aaron Erhardt <aer@tuxedocomputers.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is
 `boot_vga`
Message-ID: <20251117154455.GA2457991@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50f7af87-8a04-44aa-87e8-f236102b71b8@suse.de>

On Mon, Nov 17, 2025 at 08:25:05AM +0100, Thomas Zimmermann wrote:
> Am 17.11.25 um 06:20 schrieb Mario Limonciello:
> > On 10/29/25 2:38 PM, Mario Limonciello wrote:
> > > On 10/29/25 2:34 PM, Bjorn Helgaas wrote:
> > > > On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello
> > > > (AMD) wrote:
> > > > > Some systems ship with multiple display class devices but not all
> > > > > of them are VGA devices. If the "only" VGA device on the system is not
> > > > > used for displaying the image on the screen marking it as `boot_vga`
> > > > > because nothing was found is totally wrong.
> > > > > 
> > > > > This behavior actually leads to mistakes of the wrong device being
> > > > > advertised to userspace and then userspace can make
> > > > > incorrect decisions.
> > > > > 
> > > > > As there is an accurate `boot_display` sysfs file stop lying about
> > > > > `boot_vga` by assuming if nothing is found it's the right device.
> > > > > 
> > > > > Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
> > > > > Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
> > > > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > > 
> > > > Do we need a Fixes: here?  A stable cc?
> > > > 
> > > > The bugzilla suggests this might be a regression and hence v6.18
> > > > material?
> > > 
> > > Yeah I think you're right, we should add these two tags and this
> > > should go to 6.18 if it's a reasonable change.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
> > > 
> > > But let's also make sure Thomas Zimmermann agrees with this change.
> > 
> > ping?
> 
> Sorry, this fell though the cracks. I can see that this backfires, but still
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> because the overall logic of detecting the boot-up VGA is questionable. It
> picks the first possible candidate instead of looking at all devices before
> making the decision. If we see regressions from the patch here, this would
> be the place to fix it.

One problem is that it's hard to know when we've looked at all the
devices.  I don't think we currently have a special hook for VGA after
boot-time enumeration.

> > > > > ---
> > > > >   drivers/pci/vgaarb.c | 7 -------
> > > > >   1 file changed, 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > > > > index 436fa7f4c3873..baa242b140993 100644
> > > > > --- a/drivers/pci/vgaarb.c
> > > > > +++ b/drivers/pci/vgaarb.c
> > > > > @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct
> > > > > vga_device *vgadev)
> > > > >           return true;
> > > > >       }
> > > > > -    /*
> > > > > -     * Vgadev has neither IO nor MEM enabled.  If we
> > > > > haven't found any
> > > > > -     * other VGA devices, it is the best candidate so far.
> > > > > -     */
> > > > > -    if (!boot_vga)
> > > > > -        return true;
> > > > > -
> > > > >       return false;
> > > > >   }
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > 
> > > 
> > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 

