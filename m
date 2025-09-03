Return-Path: <linux-pci+bounces-35360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DBB416C7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4313AC7B3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9922DAFAF;
	Wed,  3 Sep 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPqcucxi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365F2D94BE;
	Wed,  3 Sep 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884962; cv=none; b=ufeDJe7Q+cA4SnGrsaf+eHDVrl/2v0GJ0P+3lY2oOnSdjLWnHo1Bz0B3k4QZqffgA5dJ+fwHAGn0B2yGhAignv9D6rYyV1ntxIA2S5e9+A+PVMkj4nQL10UziPZarWleFpthjRLSOXxIh3VAkXVF+DEfP/cShss2NjeVQa81FeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884962; c=relaxed/simple;
	bh=X3VFQjKOhgj2N/yG/2HmPx47KJ7yqJvzhfPKtcVetaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCadeQMoajSGP/AYTXlNDew0QfWq6ZCx9uZjwwser4FpBT2LCqs4MI66pi+BCDV8A6XpXXeyL1vmOXHageB97sqhiHfsnWExuZOKYR2miOQu5jVsujsPl2TUQWdgIQg23GCkL9NcqUtt0RimaKkJdqP8NW7r1Z/8sU47fdFnubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPqcucxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67981C4CEF1;
	Wed,  3 Sep 2025 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756884961;
	bh=X3VFQjKOhgj2N/yG/2HmPx47KJ7yqJvzhfPKtcVetaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPqcucxiGPtihPWq7bGl9KPyTly6mue5wTLCQ/mhDST4zTTLmXkLuVylQW0V5SI0g
	 x4MbZd7c1uQSuOh9xnWFk86qMhgFZTe2GXn9V6F/BP+5272JJep2QRKLa9cYvfvuE/
	 NAT2ApAPLrc7yY3Nq19e4HzzbT5C3+Lgn+SL6jJX7lzPLIRhXi22JeR9PrmWZiHVuB
	 to3fbayuiZXG2tAw5WKAhBGh00M2F9XiaUoPzfTrHFLeHbovq/QQ1eR1wcAIjTYSju
	 diDgjxipjtrtsK3heSS3cLdhs015qT2Ryr6UNW7B21QhnQt4Pz/pg6ldxA7o8A0/GD
	 SrYlMmNPcgA3g==
Received: by pali.im (Postfix)
	id 58B207AE; Wed,  3 Sep 2025 09:35:58 +0200 (CEST)
Date: Wed, 3 Sep 2025 09:35:58 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jan Palus <jpalus@fastmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <20250903073558.6v2d7q6n6hm2vv3a@pali>
References: <bug-220479-41252@https.bugzilla.kernel.org/>
 <20250820184603.GA633069@bhelgaas>
 <20250902203226.u4i43vygl4bl2dqa@pali>
 <CAL_Jsq+cytAQAtSB7VjR8oKrXJJSSrOouKQZYQAWNvu+tStTnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+cytAQAtSB7VjR8oKrXJJSSrOouKQZYQAWNvu+tStTnA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 02 September 2025 20:35:14 Rob Herring wrote:
> On Tue, Sep 2, 2025 at 3:32 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > These issues have been discussed more times for last 3 years.
> > Tested changes which are fixing real bugs and are improving the
> > pci-mvebu.c driver from people listed as M: in MAINTAINERS are being
> > rejected or silently ignored. And untested changes which are not going
> > to fix any bug are being accepted and causing new regressions. People
> > then reporting bug reports to M: people who cannot do anything with it.
> > The only advice which they can get is to not use mainline kernel.
> > This pci-mvebu.c driver in mainline kernel is broken and nobody wanted
> > to do anything with this situation for last 3 years, I was pointing for
> > it more times. Due to this I'm ignoring bug reports for pci-mvebu.c
> > driver for mainline kernel.
> 
> This makes no sense. Mainline is broken, but yet there's a regression
> in mainline breaking the driver. The pci-mvebu.c maintainers have the
> ability to test patches, but refuse to test any submitted patches
> other than their own. I guess the only solution here is just remove
> the driver...
> 
> Rob

This is not the way how to get patches being tested. Ignoring other
people and taking untested patches because you did not wanted to
communicate with maintainers. I have no reason to test other patches if
my own are being ignored. This is fair. In past I spent lot of time on
addressing issues in this driver, preparing fixes for real bugs and
whole time was wasted. And if you expected that it would work in that,
then go ahead and do it, remove the driver.

