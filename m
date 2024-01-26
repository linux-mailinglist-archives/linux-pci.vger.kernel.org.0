Return-Path: <linux-pci+bounces-2599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E119F83E229
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86CAB2341C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AD21373;
	Fri, 26 Jan 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dI/lt0Id"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26760224C2;
	Fri, 26 Jan 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296035; cv=none; b=bTY1ngQ0P07tKkfDTUnF638URX4z7wW6M1YHci9FgoqQzHX338IjzJcM/CTiQMeDq7AdaP3CeCiGEsxaSbtzx1apKkpEq/PERY1+hUaGZ2UE5sXnbDOJ1rf3iyCmI3NbsboxIUbMAgLN/sAdNH6WMfJSMSanCpBkysL4BTBPq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296035; c=relaxed/simple;
	bh=ulx0BesNORlowdCSLIs9aXzhc69P+j4oO28lOdTdOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlyEBXTZLGVFfzQV4EXjZUjEzhPX8fkRfybmkW1MCKE6rR3KZkSBMawfxweMPkZuKFDXB0mcmeI/9sEktHBPTZm81waTjfzJrf4VeId53vjwlMRThmV3fyk/NQmEuB5uQnG4WB+xiis+6hqlR6PQAxWHPBs9uV+kz/NB05nuwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dI/lt0Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D3AC433C7;
	Fri, 26 Jan 2024 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706296034;
	bh=ulx0BesNORlowdCSLIs9aXzhc69P+j4oO28lOdTdOZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dI/lt0Id7RtS0u5U6BAPCCQ1N6ohoDFe/LJB4tsJ/fDbMomYeCwcDpC/HQxHH34Pt
	 Nsbny0iix7DE9Z9BnY38ZqULQlDjuQhRTlV1wRH0lm/kjFbZUBDzcRfatImT3TPwYJ
	 5rihqK4HrOk7pEOrAGXFoXDUdT8Me9oRjQ9kiGsM=
Date: Fri, 26 Jan 2024 11:07:13 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2024012631-removed-stuffed-ecc0@gregkh>
References: <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh>
 <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Jan 26, 2024 at 10:58:07AM -0800, Dan Williams wrote:
> Dan Williams wrote:
> > Greg KH wrote:
> > [..]
> > > > 
> > > > Hey Greg,
> > > > 
> > > > I wanted to follow up on this and see if you are able to provide more
> > > > details for reproducing or if you are able to look into it?
> > > 
> > > Last I tried this, it still crashed and would not boot either on my
> > > laptop or my workstation.  I don't know how it is working properly for
> > > you, what systems have you tried it on?
> > > 
> > > I'm not going to be able to look at this for many weeks due to
> > > conference stuff, so if you want to take the series and test it and
> > > hopefully catch my error, that would be great, I'd love to move forward
> > > and get this merged someday.
> > 
> > I mentioned to Lukas that I was working on a "sysfs group visibility"
> > patch and he pointed me to this thread. I will note that I tried to make
> > the "hide group if all attributes are invisible" approach work, but
> > reverted to a "new is_group_visible() callback" approach. I did read
> > through the thread and try to improve the argument in the changelog
> > accordingly.
> > 
> > I do admit to liking the cleanliness (not touching 'struct
> > attribute_group') of the "hide if no visible attribute" approch, but see
> > the criticism of that alternative below, and let me know if it is
> > convincing. I tested it locally with the following hack to make the
> > group disappear every other sysfs_update_group() event:
> 
> Hey Greg,
> 
> Ignore this version:
> 
> ---
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 23 Jan 2024 20:20:39 -0800
> Subject: [PATCH] sysfs: Introduce is_group_visible() for attribute_groups
> ---
> 
> I am going back to your approach without a new callback, and some fixups
> to avoid unintended directory removal. I will post that shortly with its
> consumer.

Ignore it?  I was just about to write an email that said "maybe this is
the right way forward" :)

What happened to cause it to not be ok?  And if you can find the bug in
the posted patch here, that would be great as well.

thanks,

greg k-h

