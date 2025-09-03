Return-Path: <linux-pci+bounces-35362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1705B41734
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F461A840D4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EE2D876B;
	Wed,  3 Sep 2025 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgQJrgQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F82820B6;
	Wed,  3 Sep 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885814; cv=none; b=AsGn5xut16nTBKIzJcehuUQ4XXT/S7JhTxnaCB1HulLO25i0ClBQWOel7pBI2/g1WjThKHnfCPiKoPEzvojQBOoViOXkYCIxYvjkunxe6UbtnDBXtz6iUNV3OnQnwiAz24PpLfGw3+B2MoY3QGclV5szABl49CvblIxZfGpMyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885814; c=relaxed/simple;
	bh=5akVTFofggby9D3NroVdSFslNTvcjqv8xij7f8QA1t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB018P4+eL++woiokLrXWqS6aq1pvYeyfMRcYr14ZPVaYPV0pOBzL++K5vvPb17IicSWviAbSXm5uG+IfULvgBajkptp8n4Y9VuL92Sp4ijZh5YnsPvxSxrWn8ht40AS/rchWlLUjnXhY0Jcc0W1KUIhcFUbu/UZop1cVKLkNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgQJrgQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEC7C4CEF0;
	Wed,  3 Sep 2025 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756885813;
	bh=5akVTFofggby9D3NroVdSFslNTvcjqv8xij7f8QA1t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgQJrgQbFSIpsGJz3v4UQ/I4zcdTTIQxNXa0T3A6+MC/W3X4Ly4UVjMwGXYg8FJiK
	 1JBzpl1daPS8nag5vkVFH0i9U+rfh5uSszNxuV7cy0Lg8W83JP+z6W1ScHxc0g12WD
	 qTNu2dOprqyF+eqWLi479M6GiHMDvMSKRPjo4pXraKRoeKSgpzrf8FvTuGQU/RJPXI
	 zTPRbgFFopyqFE+kqXfiiwWvJ/w7h7ihBAZYvsGo79/qZQyT9+uNIt1FAXWKr6XnSI
	 8IRIkmL9uj/4fcCbF3DjWWp1A0Io+CQIkD9RryGxYZ7CevkiOWp5cU+Bkj2obEZN1Y
	 sPdQ2YMgVsisA==
Date: Wed, 3 Sep 2025 13:20:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jan Palus <jpalus@fastmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <fi257eqhpzxp245g5vab3ttth5kuiuwpk7dsyhnoxo4sjlq535@fgpwb442eeek>
References: <bug-220479-41252@https.bugzilla.kernel.org/>
 <20250820184603.GA633069@bhelgaas>
 <20250902203226.u4i43vygl4bl2dqa@pali>
 <CAL_Jsq+cytAQAtSB7VjR8oKrXJJSSrOouKQZYQAWNvu+tStTnA@mail.gmail.com>
 <20250903073558.6v2d7q6n6hm2vv3a@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903073558.6v2d7q6n6hm2vv3a@pali>

On Wed, Sep 03, 2025 at 09:35:58AM GMT, Pali Rohár wrote:
> On Tuesday 02 September 2025 20:35:14 Rob Herring wrote:
> > On Tue, Sep 2, 2025 at 3:32 PM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > These issues have been discussed more times for last 3 years.
> > > Tested changes which are fixing real bugs and are improving the
> > > pci-mvebu.c driver from people listed as M: in MAINTAINERS are being
> > > rejected or silently ignored. And untested changes which are not going
> > > to fix any bug are being accepted and causing new regressions. People
> > > then reporting bug reports to M: people who cannot do anything with it.
> > > The only advice which they can get is to not use mainline kernel.
> > > This pci-mvebu.c driver in mainline kernel is broken and nobody wanted
> > > to do anything with this situation for last 3 years, I was pointing for
> > > it more times. Due to this I'm ignoring bug reports for pci-mvebu.c
> > > driver for mainline kernel.
> > 
> > This makes no sense. Mainline is broken, but yet there's a regression
> > in mainline breaking the driver. The pci-mvebu.c maintainers have the
> > ability to test patches, but refuse to test any submitted patches
> > other than their own. I guess the only solution here is just remove
> > the driver...
> > 
> > Rob
> 
> This is not the way how to get patches being tested. Ignoring other
> people and taking untested patches because you did not wanted to
> communicate with maintainers. I have no reason to test other patches if
> my own are being ignored. This is fair. In past I spent lot of time on
> addressing issues in this driver, preparing fixes for real bugs and
> whole time was wasted. And if you expected that it would work in that,
> then go ahead and do it, remove the driver.
> 

Pali, as I communicated earlier, please send your fixes again and I'll try to
get them merged if we do not have any blocking reasons and the patches make
sense. I do not know what happened earlier with your patches and that's
irrelevant for me.

But if none of the other mainainters oppose your changes (IRQ in specific),
there are no reasons to not merge them IMO. But if there are concerns, then it
is your job to address them.

That being said, if you do not want to send them again and the driver continues
to being untested in mainline, we may need to mark it as Orphan/Obsolete and get
it removed later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

