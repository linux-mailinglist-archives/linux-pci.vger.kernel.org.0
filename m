Return-Path: <linux-pci+bounces-15367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605E9B1189
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7731F2A4C8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A81217F32;
	Fri, 25 Oct 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZjTjqXf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152F217F24
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890817; cv=none; b=LURwFOQtedCpeBKfLB0LYDRXTAhNUPapgTLX0ommvnV6A2uYH6m/r7nUdwq0/9D79bTov7Qpc/h/VH6x9Xfgh30GFzi9CpcAv65x4iJh2a+szjjyq1wH5wKIbr9T665Mfxs28XnkqBIsOkJEf83OcDVo7+AcTHGC0kuZJ+BamHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890817; c=relaxed/simple;
	bh=OfIXsVT1L+N2v4lnPcfapb+LSgEH+T1EY5dbNF3Zgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq9V7hi2xdCZonyOfWuEhQ7GYWZjzY0iIi/30hp960TWgAFR+ZdKfjGT+TW6ORRKBGEm3MXI0Ux88WnRl5q9Jgxg896+q1/7RzqW+hOmvLI0/v6j112wQ3yHrWveIajkGA52KS9RG7GpTm+oex1LTpyHU0xHKC3CuovhyxULOKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZjTjqXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8834FC4CEC3;
	Fri, 25 Oct 2024 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890816;
	bh=OfIXsVT1L+N2v4lnPcfapb+LSgEH+T1EY5dbNF3Zgkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZjTjqXflNuPbEHhdoHSzy2KD/VV+pOLe189LnawO5vBHnSAssnGZSM4P72zOiy4n
	 71w4+zlTR/mHyAqbfJ5oKGPe2pi0Yt9ofiXynA8or6elb3mxRhN1S7gQd3XzK0NJmE
	 GGamzSD9n7yJ4+sgsdpFAwAOoSZRqjhWygcbtF9NaAPvk2SehclqksOP3uU3TodGpb
	 ipz/fo9zRMPoaRpOoNa+884somuhLgWFxe5HJ/3tLfL74Hr400XNBR241rHamnGniS
	 LBsl1yzHQwuLNBxOAL1nRHaC/gJRGrRkoYFQO5Wf82m0+B6GQfeiKrXZeZsKibrMoC
	 F0+XBdIr9HHHA==
Date: Fri, 25 Oct 2024 15:13:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	Amey Narkhede <ameynarkhede03@gmail.com>,
	Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] pci: provide bus reset attribute
Message-ID: <ZxwJ_fpDUoMHLd0B@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025145021.1410645-1-kbusch@meta.com>
 <20241025165725.GA1025232@bhelgaas>
 <20241025140458.5040cc29.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025140458.5040cc29.alex.williamson@redhat.com>

On Fri, Oct 25, 2024 at 02:04:58PM -0600, Alex Williamson wrote:
> 
> I can understand your hesitation, but TBH I've wished for such a thing
> in the past.  We can already twiddle the secondary bus reset bit using
> setpci, but then we don't restore config space of the subordinate
> devices and at best we need to remove and rescan those devices.

I wasn't going to say it, but I have encountered the setpci method used
in the wild, and the results are not always consistent. :) Having the
kernel involved is safer, though you should still use it carefully.

> As Keith notes in his reply, we can also effectively trigger this same
> thing through vfio-pci, so I think we're only making it a little easier
> to accomplish through this sysfs attribute.  Yes, bad things can happen
> if we were to reset a bus of running devices, but I don't know that
> it's any more bad than resetting each of those devices individually.

If your drivers implement the .reset_prepare and .reset_done callbacks,
it's actually okay (in theory) to do this on a bus of running devices.

Might even be worth it to emit a warning if you reset running devices
that don't implement the callbacks. ?

> I would agree that "reset" is not a great name since we're resetting
> the subordinate devices and not the bridge device under which this
> attribute would appear.  Seems there should also be an update to
> Documentation/ABI/testing/sysfs-bus-pci in this patch too.  Thanks,

I'll spin out a v2 soon to change these:
  
  Move the attribute to pci_dev bridges only (it's actually easier to
  find that in sysfs compared to pci_bus attributes, IMO)

  Rename the attribute to "reset_subordinate"

  Add the attribute to pci sysfs Documentation.

