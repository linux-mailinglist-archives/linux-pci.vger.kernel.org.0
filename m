Return-Path: <linux-pci+bounces-35670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBEB4914C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24E41894C25
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5B2FFDC1;
	Mon,  8 Sep 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiS6owAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A941D63E4;
	Mon,  8 Sep 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341474; cv=none; b=OgQLQ7XVc+3+QVy5gYvyxoiCOEY6670ESKj1u64oMxm6D7Edb1i31rrIB0917xcFtLMwDpQYwrFFf8AhpVLfz5Uuan+hr9mJAqcfmmunU9dNdCVhvHlvbz8EtnzvYJ3ihRYaOyvchqwRlYM5nY85gpdyR30Y1/h3c25OJWxikjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341474; c=relaxed/simple;
	bh=zJKMmymOijhO5qliCp19GY2Zo7Wn5ntF/74NHogADmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxBaTOsEIiyf9mGnQP2FX4DWsxf8UVbsFq5sDa0SPhftIZ9cp2aJXQv6XzZ8emLh3tPC9/ogHBLKG1LeRxYA1Mp/rWGlIn5hlurxt4gIEcn1U9+E+VPPH0GXDgisTihm31fzGCDD4asRWqTO4gsfyaSeElzPIzt9wI0qLRhG8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiS6owAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D96C4CEF1;
	Mon,  8 Sep 2025 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757341474;
	bh=zJKMmymOijhO5qliCp19GY2Zo7Wn5ntF/74NHogADmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiS6owAmBaC/l5kzh921QiPRgHCSpKmN8M2Ulf/biUkpJ42TfsYbARiDkMzWay9NC
	 MnkPuNoSCNdr4G3ZdrTQWiYqaGpaQ/IwQq9pbH6T1Goc728dXne69jtsXadTKJFUxH
	 wjZemKrJZwCiUDwoJtkwsJG1GZt1ZQQwPz6z14YzQCUKKqwR7fwCtpOQ6+bmqU6tyE
	 /x8Wm8a+5g5LsV+xw10ylzMOkgP8boS+BISjJ2R6bWGjp2oJf6famXyUgkmdkynIof
	 e8dramR4/KJQAs+NpDfjVYSs9zowtn1TIbt6wkrwuNAUesDboEeM8Hl6+87nUY6yFg
	 aNycwCaRB5O1Q==
Date: Mon, 8 Sep 2025 15:24:29 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250908142429.GC9224@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
 <20250903140115.GC2764654@google.com>
 <b11dcd50-a87e-47ff-b406-776e432f07bd@orca.pet>
 <20250904101705.GH2764654@google.com>
 <75920526-64f4-4eda-8552-58de165f6597@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75920526-64f4-4eda-8552-58de165f6597@orca.pet>

On Thu, 04 Sep 2025, Marcos Del Sol Vives wrote:

> El 04/09/2025 a las 12:17, Lee Jones escribió:
> >> That GPIO is something required to perform the poweroff sequence, a must
> >> for any machine, while WDT is just a "nice to have".
> >>
> >> Implementing now the WDT just because of a linguistic preference means
> >> delaying something more important in favour of a "nice to have".
> > 
> > You use the word "delaying" here.  What's the rush?
> > 
> > If you only need a GPIO driver, then you don't need the MFD part.
> > 
> 
> I would honestly like that my machines can turn off properly and pretty
> sure others using these platforms would agree on that, as having to yank
> out the power cable is far from ideal.
> 
> Adding WDT would lengthen even further the review process. That ignoring
> I am doing this as a hobby on my spare time and I'd rather spend my
> scarce free time implementing the power off driver than the WDT
> (something I'd do out of completion, I have absolutely no use for a WDT
> in this machine).

Then don't implement it.  Just have the GPIO driver probe on PCI match.

> The reason I am using an MFD is that I was asked to back in v2
> (https://lore.kernel.org/all/aHElavFTptu0q4Kj@smile.fi.intel.com/).
> I'll be CC'ing him.

Andy knows the rules.

> I was told to create a southbridge driver that would match on PCI
> and registered other devices exposed by it as platform drivers.

PCI => Platform is generally decried by Greg and others.

a) With only one device to register, are you sure you need this?
b) If you have more devices, either add them here or use Aux Bus.

> GPIO was the only functionality implemented at the time, and is
> the only functionality implemented right now. So I simply delivered was
> I was asked for.

-- 
Lee Jones [李琼斯]

