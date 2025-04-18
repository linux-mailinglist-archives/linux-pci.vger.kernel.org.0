Return-Path: <linux-pci+bounces-26206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E176A93396
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E1A4666BF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04D269CF0;
	Fri, 18 Apr 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy26hlvH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE524EA8F;
	Fri, 18 Apr 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962033; cv=none; b=WrOWbeP3HCaPk19fwulGxynlDNXyhqXatapi+gLPwAKKO9mR4VkVQvvkGN/mS9lXG8HC1n6gzdiVgPTtMDPEoTJ/Ztee2cQLvNqvnuwarwLgGAyr0T7Pg22k7o1GO9XvhGZuW95T04dMCxOfR0FN/LkXXXxW4bnHjfvJBdZ5pH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962033; c=relaxed/simple;
	bh=HTu5azwnJcNp5fW88jU95M322z25Yas8NYb0ahvHXmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOLPyo4GVAi8xl0YRcNX9OqAZV01D9/0WFAFcmWldHAAwGynERWIx819oTK7W7RmaK0/YA3BMrc2U7ld/JWr5/eWpZL3cWmeOtrHj4aZxRHxdoHqSxBVY/YlTD8YCii5VpeAUdkJv4q1PPuUtNzCFq5lepvQhQDpoWl3Yuhscqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy26hlvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1658C4CEE2;
	Fri, 18 Apr 2025 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744962033;
	bh=HTu5azwnJcNp5fW88jU95M322z25Yas8NYb0ahvHXmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uy26hlvHBK0d37FkJ++86AA+UhbvcEqgsDPhvOdXjPOeDGDLGxStqoJSlwmWDgiCh
	 sAxA8OTaNZtSLY3TL2QNcd2iZlQRrJle6oNC9Zf5lnhh9b6/3iTxGp6oGpduPiF9GD
	 ymFBYm8vbFrrKs5puTia+Pupxmp06KCUsJbSM6zkIiprqyDUObeJn/eNT+/X25hi3A
	 xg/UvBpvPLZfTxbhZoGbqgu/a49CMKE5ZhRXIsYHLbxklhd+x8UIKa/qonuAwP/Ava
	 ndKDAjt1DtNWvBczeXZVfdZB5bneo18d9yw/tJUnvfOHWwv1v6XlNbMYmqPb6ShfwG
	 6M37zL1Q9XGow==
Date: Fri, 18 Apr 2025 09:40:28 +0200
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
Message-ID: <aAIB7Om9n_tXDnvk@gmail.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
 <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
 <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>


* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> 
> > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo Järvinen wrote:
> > > Convert open coded resource size calculations to use
> > > resource_set_{range,size}() helpers.
> > > 
> > > While at it, use SZ_* for size parameter which makes the intent of code
> > > more obvious.
> > 
> > ...
> > 
> > > +	resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
> > 
> > Then probably
> > 
> > 	resource_set_range(res, base, BIT_ULL(segn_busn_bits) * SZ_1M);
> > 
> > to follow the same "While at it"?
> 
> I'll change that now since you brought it up. It did cross my mind to 
> convert that to * SZ_1M but it seemed to go farther than I wanted with a 
> simple conversion patch.
> 
> I've never liked the abuse of BIT*() for size related shifts though, 
> I recall I saw somewhere a helper that was better named for size 
> related operations but I just cannot recall its name and seem to not 
> find that anymore :-(. But until I come across it once again, I guess 
> I'll have to settle to BIT*().

BITS_TO_LONGS()?

Thanks,

	Ingo

