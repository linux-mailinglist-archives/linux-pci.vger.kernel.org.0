Return-Path: <linux-pci+bounces-17221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0199D6302
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D348116150F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE91DEFC6;
	Fri, 22 Nov 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwEuj6ME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FD15B10E;
	Fri, 22 Nov 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296237; cv=none; b=XhEP2WsmyDxNWsDbE0q8Y5mUc6tQ+RcaD2TaDS7aWSu8K0OupX/puX78bJqWGf6pjdOqAQn2drah8rgWFmUpf7drzf9w1F9q8lOYUsRQusRZGO6jL1Gc464VxLTwLkQDMNj7ksZ5mVk2PvKIFjLVKxni++HfU9D6f7L/bSv66w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296237; c=relaxed/simple;
	bh=xUQH7wkZP6c1QJgIdGzz5vXiO4U5IBoMGRWvx4uaTa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i6PjS8jHK3xHT+xfi9GqBLuRkS5ea4U+rahaG31fNDQ9QD4rgr9Sqxc/bHaMqaOEBkB854LCgYexZyWLfjzRqhGWf3anTB0AcrPd4dRwKlbI9jMrb0fBOnnr6qsOR7118Pjdu0vnDOZxVKgtp2ebUR6nK7RSqbbuhWNm96Dv/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwEuj6ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE712C4CECE;
	Fri, 22 Nov 2024 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732296236;
	bh=xUQH7wkZP6c1QJgIdGzz5vXiO4U5IBoMGRWvx4uaTa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YwEuj6MEYWiBmu+jfdgcxF9qNhVtLN7DQXODQxpKpxFTyJZFNz8hmVPm8eaD1Jpbe
	 xVBnSpf9+L5ztlGo8f7pQfHRzjKJpl4MX/X9PWTf6oCH0/dveiZzazq1FitPPlcJh7
	 04gqg25tkPs70Vm6TsGV8Hz7RJUyJ1VAKg5FNO1Cu4KPYy4+6BesasgUIB/fO36l5+
	 uTgM2rhEBVWz5V1AIenoMK7iXeB33NsHAixKb6rikgA/tgOQk9dzHXqe2//XtAjImQ
	 8gXBfGHtpPjWwq/0TGr8G+l565S6ngUXZP6GO6R30aJwxSUQytmVDb/8XLwbSNFYMh
	 DDmgJLQP1aqyQ==
Date: Fri, 22 Nov 2024 11:23:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alistair Francis <alistair@alistair23.me>, lukas@wunner.de,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com, ojeda@kernel.org, tmgross@umich.edu,
	boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com, alistair23@gmail.com,
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Subject: Re: [RFC 2/6] drivers: pci: Change CONFIG_SPDM to a dependency
Message-ID: <20241122172354.GA2430869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122153040.00006791@huawei.com>

On Fri, Nov 22, 2024 at 03:30:40PM +0000, Jonathan Cameron wrote:
> 
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 68f46e4a72a6..4db9bc8e29f8 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -739,6 +739,21 @@ config LWQ_TEST
> > >  	help
> > >            Run boot-time test of light-weight queuing.
> > >  
> > > +config SPDM
> > > +	bool "SPDM"  
> > 
> > If this appears in a menuconfig or similar menu, I think expanding
> > "SPDM" would be helpful to users.
> 
> Not sure it will!  Security Protocol and Data Model
> which to me is completely useless for hinting what it is ;)
> 
> Definitely keep (SPDM) on end of expanded name as I suspect most
> people can't remember the terms (I had to look it up ;)

Agree that the expansion doesn't add a whole lot, but I do think the
unadorned "SPDM" config prompt is not quite enough since this is in
the "Library routines" section and there's no useful context at all.

Maybe a hint that it's related to PCIe (although I'm not sure it's
*only* PCIe?) or device authentication or even some kind of general
"security" connection?

I admit that you're in good company; "parman" and "objagg" have zero
context and not even any help text at all.

Bjorn

