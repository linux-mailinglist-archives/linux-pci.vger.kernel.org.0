Return-Path: <linux-pci+bounces-3321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBA68501D9
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1591F2537F
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDD3217;
	Sat, 10 Feb 2024 01:50:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806F2114;
	Sat, 10 Feb 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529824; cv=none; b=N25wsLLE1z0UjCLrhakD1kfzq8jeVLp6JSRLFibXDUcyzkjcn+UKSHIkEwCPFpP1IKqnjPgG2Sy/YFqU1JYpCBpizGL4CvXVm4YKzX1DVjlCe7K5K85tFS3sQyoGNgUi2G5nCvuYM+esU9Pf3bTxrJTEx/afBle7ZIG+TnULBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529824; c=relaxed/simple;
	bh=6T65ndDUUTBe/AWN1GVwqzQo6XQqJje69vJIG6Mc7Pk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ep0Q0fpahFb1aSUfCQmHLe/qUUDTE1UHSWIYA5KDucfEh0ZWtdzQw32YADt4raDpIa0haRlSPe1GZ87gbV0PSjHrQ8Zm11JRMyPc5f6B7Y5iSPTpDbpuDk8IwgbKUK3zxd5GpJ5ep5TvAlN8v/IZY6kT1qU6Ko7ad8AS9+zZ2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CC45992009C; Sat, 10 Feb 2024 02:50:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C1DBC92009B;
	Sat, 10 Feb 2024 01:50:19 +0000 (GMT)
Date: Sat, 10 Feb 2024 01:50:19 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <a0e8ae37-cc11-2219-201e-d6740028b735@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2402100118350.2376@angie.orcam.me.uk>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk> <a0e8ae37-cc11-2219-201e-d6740028b735@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Feb 2024, Ilpo Järvinen wrote:

> >  You change the logic here in that the second conditional isn't run if the 
> > first has not.  This is wrong, unclamping is not supposed to rely on LBMS. 
> > It is supposed to be always run and any failure has to be reported too, as 
> > a retraining error.  I'll send an update according to what I have outlined 
> > before then, with some testing done first.
> 
> Oh I see now, I'm sorry, I didn't read all the way to the last paragraph 
> of the commit message because the earlier one in the commit message hinted 
> the restriction is removed afterwards so I thought it was only linked to 
> the first part of the quirk.

 No worries.  I have submitted the changes now: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/>.

 Unfortunately due to a sudden hardware failure I wasn't able to do any
non-trivial verification, as explained in the cover letter.  I'll try to 
get back to it as soon as reasonably possible, hopefully next month.

> >  I think it has to be a separate change, as a fix to what I can see is an 
> > issue with a three-way-merge done with commit 1abb47390350 ("Merge branch 
> > 'pci/enumeration'"); surely a bool result wasn't supposed to be assigned 
> > to an int variable carrying an error code.
> > 
> >  Either or both changes may have to be backported independently.
> 
> But can it be? Won't the intermediate state cause more breakage? (although 
> that obviously can only hit some very unfortunate bisecter so perhaps not 
> a big deal because one would need many holes to align, the biggest being 
> the link has to fail training which is rare to begin with).

 I decided to do it differently after all, still with two changes.  There 
doesn't have to be any intermediate state, and returning failure where no 
retraining has been done is no different from the case where a failure was 
caused by the lack of hardware features required, such as link active 
reporting, so if callers work without this update, then so they will with 
it in place (i.e. no regression).

  Maciej

