Return-Path: <linux-pci+bounces-5898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27A89CC69
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32DB1F25038
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802A145B0C;
	Mon,  8 Apr 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiNzgSM5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A964847B;
	Mon,  8 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604596; cv=none; b=Lk88k62251Bnj8WajstkXmAIAQxPF1f+7pedAeT+0PfRlN66zOw3IJFLBmRQbxF27foNO0uBc1uvdAvIwvtOR4sVmtyuc/W0uanUWvl2Tp4BtRhAxRFS4b2jEuDqzP/rngyFYlr3eof2GUyE+WsPTVgoMouY3nmekEhUej+UXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604596; c=relaxed/simple;
	bh=1UUcvMJHOtwmpTvXNKrcpf/ImAQ3BMCEn7Pokve/y0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4uABAMqPtj+JY9nDRPB/Zj6ijfTvdoDOwTUBzjVyd6vlCiytMQDBxRcKH0nAs0EJ0VFTo6WEmuLciVSPuIa51c640YysO43fVqE2n6iP/5XnAjMzf4IiJw26hpj4kwjpBkvbzQOFzeHzF9QPf8Ru0SQVrO3ThfcLGRFSDq6Z1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiNzgSM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E0EC433C7;
	Mon,  8 Apr 2024 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712604595;
	bh=1UUcvMJHOtwmpTvXNKrcpf/ImAQ3BMCEn7Pokve/y0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiNzgSM5uXPmYN1B3ICo5srAuEowWqvM/1wA4fhzjZiWxWY6bkE6MPYpk44Rb3G4q
	 xvZCz1vsJEcpXL0h+sjVAqOvAYnhVIo45eAM+GCyRQSzdHAcu8OW3ZiY4UE0zm09z0
	 EHeNOMQ/6XOEDIfavkN9zDw1Ov7lAYUi7OGtZEOFzjo5swdY0A+r9/fUp4eJYehjAU
	 u2awsNlFVbPn30pwjFMKQYa5JeDtwHY24S0dk/dyo9QG/qpT2r5ZrE0M3QuJMVh8nP
	 IpElzQAR+sLGC5MzEirNxayV1ycpVnPKzLpmOtWyD1MA+X4oFg52cHjK/cck4k8cT/
	 XRP5OZ6mb4C1w==
Date: Mon, 8 Apr 2024 12:29:53 -0700
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <ZhRFsUiDieY+HhfV@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
 <ZhMP-NBMb387KD4Y@wunner.de>
 <ZhNQa8wAflycciNA@snoopy>
 <20240408093422.000062d9@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240408093422.000062d9@Huawei.com>

On 24/04/08 09:34AM, Jonathan Cameron wrote:
> On Sun, 7 Apr 2024 19:03:23 -0700
> PJ Waskiewicz <ppwaskie@kernel.org> wrote:
> 
> > On 24/04/07 11:28PM, Lukas Wunner wrote:
> > 
> > Hi Lukas,
> > 
> > > On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:  
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> > > >  
> > > >  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> > > >  	if (rc != AE_OK) {
> > > > -		dev_err(dev, "unable to retrieve _UID\n");
> > > > +		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
> > > >  		return -ENOENT;
> > > >  	}  
> > > 
> > > dev_err(dev, FW_BUG "unable to retrieve _UID\n");
> > >              ^^^^^^
> > > 
> > > There's a macro for that.  
> > 
> > Doh...it's been awhile since I've crossed buggy BIOS's.  Thanks for the
> > review and comment.
> > 
> > Updated patch:
> > 
> > cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup failure
> > 
> > From: PJ Waskiewicz <ppwaskie@kernel.org>
> > 
> > Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> > drivers on Emerald Rapids systems.  However, on some production
> > systems from some vendors, a buggy BIOS exists that improperly
> > populates the ACPI => PCI mappings.  This leads to the cxl_acpi
> > driver to fail probe when it cannot find the root port's _UID, in
> > order to look up the device's CXL attributes in the CEDT.
> > 
> > Add a bit more of a descriptive message that the lookup failure
> > could be a bad BIOS, rather than just "failed."
> > 
> > v2: Updated message to use existing FW_BUG macro
> Move the change log "v2..." etc below the ---
> as we don't want it in the long term git log + better to send a fresh
> patch in a separate thread.

Thanks, it's been awhile, and my normal (i.e. old) workflow isn't
available to me just quite yet.  I can fix and send a new patch, but
I'll hold off and see what Dan's thoughts are after my reply to his
reply.

> Other than that seems reasonable to hint it is probably a bios
> bug - however I wonder how many other cases we should do this for and
> whether it is worth the effort of marking them all?

I can confirm this was definitely a BIOS bug in this particular case.
The vendor spun a quick test BIOS for us to test on an EMR and SPR host,
and the _UID's were finally correct.  I could successfully walk the CEDT
and get to the CAPS structs I was after (link speed, bus width, etc.).

I'd be fine also marking the others, but I don't have any easy way to
validate that I'd hit those cases.  My BIOS for this platform is only
minorly broken.  I suppose it could be mocked in QEMU to cause those to
fail...

-PJ

