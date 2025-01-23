Return-Path: <linux-pci+bounces-20274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FAA19F96
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CD53AEB62
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042B20B817;
	Thu, 23 Jan 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eofC4bbu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BF1CAA64;
	Thu, 23 Jan 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619848; cv=none; b=Z1SWARXsk15X/Yy92gF4Zz6SwjEU7kaTk347zZrifyen4ILsKiYLAEt0u09MvqL+QauLte1SfL6SA2udZ8eLQb/7YEstbnyOegAAaz1YDPAW17yjCWOTdQpwmMX82JGvM0Z9WiInn0VywK9cS0q6JYfnjhzBpVBGQPOWX0ftV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619848; c=relaxed/simple;
	bh=zY8+3BU5laqhL7ESs/GACkWnY9T9AYwjWhuWT53+zT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C54ONVV7VOl8UpwZt617Vd7SMQBFSnR/psFiWGQjKmJic5G310eR4AFrhUyUf1fzcsFqgrRS6ht9w+11ie0e+YSzWBi9qAk3t0fS4OAKKFePQGNMlRQWrTZ2lYUs68Nbwjc8qphSqY3g/ZwQuhJvN/TOauUwZrJ0H/o8x0jbQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eofC4bbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB6DC4CED3;
	Thu, 23 Jan 2025 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737619847;
	bh=zY8+3BU5laqhL7ESs/GACkWnY9T9AYwjWhuWT53+zT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eofC4bbuvXtNh2v6IN97y1vHXuKywyGyOVRVDVAk/5V9QlvtBNPVPKWDDA57PL1Bn
	 YX3GnLwhAM3kQIjNNhvrCc7E8bNntYg2HwqMc2FF0n9xs7EwR7i0KPFcSlG+ZjBVVo
	 YULT6hIhj6+8fqv+OoBCwV3Fuw+a1Nr3usyf+NaqPhM/xMmCrhFwZ1HgoiEhKB/hM2
	 iR/dvSulAvH7PLt4SH1mr6mwAJ2VmhMrOwz7Huqj4b+BcsaM6FIhftUzbsMywQpOtW
	 iAGIlOb3G+CFiLSLAMcbSSEhk68QyTJ5NeC5su+m9LOrMbVvU1ufQoddKG6Cf3fIam
	 j5D+jg+R69daw==
Date: Thu, 23 Jan 2025 09:10:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z5H5gTQa7UEpltMa@ryzen>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
 <Z5DDZnRX3H7RZR5S@ryzen>
 <a5a6677f-f2dd-4ff6-ab46-3a28f1d1487c@app.fastmail.com>
 <72aa3800-320c-494b-ae46-b4f2ebf71e92@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72aa3800-320c-494b-ae46-b4f2ebf71e92@nvidia.com>

On Wed, Jan 22, 2025 at 11:18:44AM +0000, Jon Hunter wrote:
> 
> On 22/01/2025 10:26, Arnd Bergmann wrote:
> > On Wed, Jan 22, 2025, at 11:07, Niklas Cassel wrote:
> > > On Tue, Jan 21, 2025 at 05:46:43PM +0000, Jon Hunter wrote:
> > > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/>>
> > > > 
> > > > This change breaks building the kernel with GCC v7 and I see ...
> > > > 
> > > > ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko]
> > > > undefined!
> > > > ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko]
> > > > undefined!
> > > > 
> > > > I know that this is an old GCC version, but this is a farm builder and the
> > > > kernel still indicates that GCC v5.1 is still supported [0].
> > > 
> > > do you have any idea what is going on here?
> > > 
> > > I'm a bit puzzled, since looking at other reports of this error,
> > > e.g.:
> > > https://lore.kernel.org/all/20241018151016.3496613-1-arnd@kernel.org/
> > > 
> > > using div_u64() is usually the solution for this problem (for things that
> > > are not performance critical), not the cause of it... any ideas?
> > 
> > I have tried to look at the email thread, but not tried to reproduce
> > it yet. I have two ideas about what might be happening:
> > 
> > a) something causes a /different/ division to call into
> >     __aeabi_uldivmod(), not the one from div_u64().
> > 
> > b) the compiler notices one of the arguments to div_u64() being
> >     constant in some cases and splits the calling function into
> >     two special cases, for both the constant and non-constant
> >     cases. This sometimes confuses the __builtin_constant_p()
> >     in do_div() that decides to fall back to a 32-bit division.
> > 
> > Try looking at the .s file when you run
> > 'make drivers/misc/pci_endpoint_test.s' to see where exactly it
> > calls the two division functions, maybe you see the problem then,
> > otherwise I can try to reproduce it here.
> 
> 
> FWIW I have encountered similar problems with this before with this compiler
> ...
> 
> https://lore.kernel.org/linux-tegra/7733a4ca-330b-4127-af12-33f376fbbc47@nvidia.com/

I had no errors when building this patch using:
gcc (Debian 7.4.0-6) 7.4.0
on i386.

neither with CONFIG_PHYS_ADDR_T_64BIT=y (CONFIG_X86_PAE=y)
nor without it set.

So perhaps this is a bug in gcc 7.x on arm32 or in the arm32
implementation of div_u64() ?


Kind regards,
Niklas

