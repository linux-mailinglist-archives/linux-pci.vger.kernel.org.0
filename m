Return-Path: <linux-pci+bounces-26287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3BA94406
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B5916879B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADD1C84CF;
	Sat, 19 Apr 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYHDdB78"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86196B644;
	Sat, 19 Apr 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074630; cv=none; b=kBfC03WE+TOMYYHe3xUHveNTY+C85lZHKJ2gcW+0ppHpLLpjgJe5zfCkbGKL/wxLTPFzJUj9HOc6pNbQcQ8cmsmpXte7WzP/2hzzCInP/PZHb6rAIyXsI0yGPS0s9pQCcd4bb4s7XpBgucWp/9q90UZn15Djie3TAfjowVGe5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074630; c=relaxed/simple;
	bh=EfW8iyCiQTttenkzgxw9qmd4szYCqkNpB+Jv3fRbpSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBvoqx3oAYL6x1bSoDCALBBxLAORXin7vpm0C0ya58KZB0qYKTYqke5b00ac5hxXDwcCT89Cj32MnMC+c62pepuE0rH0t7sJ9ijJSCfj4rPkmYpA2FCaRi15kXEySzhwuhePpEo5K+/Pe/wGOUudwh/jbXFcHw3sQmM9EOw/DEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYHDdB78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F98C4CEE9;
	Sat, 19 Apr 2025 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745074629;
	bh=EfW8iyCiQTttenkzgxw9qmd4szYCqkNpB+Jv3fRbpSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYHDdB78nWNz3I/InPQwlyxSrRf687bqduX/zMtUVJ56tp3mmCYqQcJV+p8Dfv5Z3
	 J9MQD6bXfWVqowuc6UO7zDaZxIySxKDVoVplPVWdPDRJ1VLdHaxGUQYvimNMpTe7O+
	 FpsHoKAiritrGbSB+92fwhEq6ftvDMCBe3mlmXpq2Y+NrwUVYXheJw4l0+E9Lplgf5
	 KtlZmHa5JPsdKodoP4dSZerIHBuF8q2JoSqWNmoQFN+K63ID0ZJUsoc0CLXe2HFPHO
	 XAdw4eg0VT8cYa7rmF+qRACeWg+vrPq5/DYFwgwx65WT7pW8bWlkVBqtg+9eG5OJtm
	 3d8W39//GoH9w==
Date: Sat, 19 Apr 2025 16:57:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
Message-ID: <aAO5weh0nks6nqBq@gmail.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
 <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
 <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
 <aAIB7Om9n_tXDnvk@gmail.com>
 <db829a60-c524-73bc-e7c3-fed60e980d99@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db829a60-c524-73bc-e7c3-fed60e980d99@linux.intel.com>


* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Fri, 18 Apr 2025, Ingo Molnar wrote:
> 
> > 
> > * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > 
> > > On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> > > 
> > > > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:
> > > > > Convert open coded resource size calculations to use
> > > > > resource_set_{range,size}() helpers.
> > > > > 
> > > > > While at it, use SZ_* for size parameter which makes the intent of code
> > > > > more obvious.
> > > > 
> > > > ...
> > > > 
> > > > > +	resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
> > > > 
> > > > Then probably
> > > > 
> > > > 	resource_set_range(res, base, BIT_ULL(segn_busn_bits) * SZ_1M);
> > > > 
> > > > to follow the same "While at it"?
> > > 
> > > I'll change that now since you brought it up. It did cross my mind to 
> > > convert that to * SZ_1M but it seemed to go farther than I wanted with a 
> > > simple conversion patch.
> > > 
> > > I've never liked the abuse of BIT*() for size related shifts though, 
> > > I recall I saw somewhere a helper that was better named for size 
> > > related operations but I just cannot recall its name and seem to not 
> > > find that anymore :-(. But until I come across it once again, I guess 
> > > I'll have to settle to BIT*().
> > 
> > BITS_TO_LONGS()?
> 
> Hi Ingo,
> 
> I'm not entiry sure if you're referring to my BIT*() matching unrelated
> macros such as BITS_TO_LONGS() (I only meant BIT() and BIT_ULL() which I 
> thought was clear from the context), or that BITS_TO_LONGS() would be the 
> solution what I'm looking for.

Indeed, I misremembered BITS_TO_LONGS() - now that I looked up its 
definition it's definitely not what you wanted... :)

Thanks,

	Ingo

