Return-Path: <linux-pci+bounces-27855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FACAB9C08
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CD44A32A3
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454023C38C;
	Fri, 16 May 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtImGomR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F6235063;
	Fri, 16 May 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398566; cv=none; b=pqCdq7G8lLLi+MJEdEXUManjXAn7NxIPBvrxMRZRcy2XM9dQote+Q9ypg82DUyF23LwPTXO41EwxNnkd5T8KXsHDO2JyM9YmOkR43FTLweAgx27RpITMlYaZ3VIfpbk80E+gQeoeGQMbvkUS1w9GSaB1he3JKhoxFCCOXHA3vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398566; c=relaxed/simple;
	bh=KTxOt6wCKajOUiqP/zeq2Yl3SxpLh1CxH9DAEovFdqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLW8W1EoegheBy6sJCdVjIu51BfvgqnaD2Sa5+UkLndmkuh7teS93cLayXepjIV0qOMBmD9mxPLMgpvwYBtvWmBhp5ho4zZZdMlw755JZzy/MzFtfseGOdT/HmiRsTIq5paQ6lzlosyO8uxgyt/hUMO31SKZTrv0q3eIk6UqbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtImGomR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C99C4CEE4;
	Fri, 16 May 2025 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398565;
	bh=KTxOt6wCKajOUiqP/zeq2Yl3SxpLh1CxH9DAEovFdqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtImGomRKyX0HrKgOc6RhP//Sl6K2+2UApbuRiT6s9UEO9Mjx9GP7+ewdFHfBYazq
	 AobTyTbaG9E8iRygKCReEPD7DUJsYY5yEVyOA2xOD1kTgWZC8TX3Gh9diwDDOr75lX
	 vy6omROkxPgrL1/dcMQUNc4jquCCxc8Rs0JwkttKpwD7qtYfqPRxwarGG+u21jrF2+
	 sDcbazp46rrOFgq0+ojtwsuXSpGTDrqLmqefbXmY9nDsr2t85FdB3kTxX14pJ93HQr
	 FkJbRHG1mkzXgSKkqxdeHS2b4/HffhumEjnkwk7CJ/4W6sNcynSh78dGYLhb2fklwC
	 Zr3/1FYdYDDTw==
Date: Fri, 16 May 2025 14:29:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
Cc: Hans Zhang <Hans.Zhang@cixtech.com>, kernel test robot <lkp@intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbcGNpOnNsb3QtcmVz?=
 =?utf-8?Q?et_1=2F1=5D_drivers=2Fpci=2Fcontroller=2Fdwc=2Fpcie-dw-rockchip?=
 =?utf-8?Q?=2Ec=3A721=3A58=3A_error?= =?utf-8?Q?=3A?= use of undeclared
 identifier 'PCIE_CLIENT_GENERAL_CON'
Message-ID: <aCcvoPUJ3uOx_vk0@ryzen>
References: <202505152337.AoKvnBmd-lkp@intel.com>
 <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
 <20250515162405.GA511285@rocinante>
 <aCcGkN-9pN-jUwkS@ryzen>
 <20250516103633.GA448167@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516103633.GA448167@rocinante>

Hello Krzysztof,

On Fri, May 16, 2025 at 07:36:33PM +0900, Krzysztof Wilczy��ski wrote:
> Hello,
> 
> [...]
> > Comparing the commit that landed on the branch, with Wilfred's patch on the
> > mailing list, I did notice this diff:
> 
> [...]
> > Reviewing the diff, the changes looks fine to me, but I strongly think
> > that if the actual code is modified from the submission (rather than
> > just fixing some minor grammar in the commit message), the (unwritten?)
> > rule is that the person should add a:
> > 
> > [person: describe modifications from the original submission]
> 
> Sorry about that.  I did forgot to add this.  Good catch.
> 
> That said, a single single line with a nudge or a reminder would suffice.
> 
> There is no need for a condescending tone and the lecturing and such.

I've been reading my reply multiple times, and I honestly don't understand
where this is coming from.

I was simply saying that, if the actual code is changed when applying,
then I think that it is important to either:
1) Write something in the thread (e.g. in the 'Applied' message), or
2) Add a [user: ] line after the SoB

When it comes to simply modifying the commit log, then, my personal
opinion is that 1) and/or 2) is of magnitudes less importance.

I wasn't trying to lecture, I was simply trying to explain the logic of
my opinion.


> 
> You have been doing this for a while now, and if you continue doing this,
> I will have no choice but to start to ignore submissions from you, I do not
> have the time to deal with any forms of such passive-aggressive attitude.

This is surprising to me, our only other discussion recently was about
RESEND tags, were I also stated my personal opinion.

But that was also a sensible discussion IMO.

Not being allowed to pick up tags, e.g. Reviewed-by and Tested-by, when
doing a RESEND (as long as code and commit log is unchanged) seems
counterproductive to me, as the time spent by the Tester/Reviewer would
have been for nought.


Kind regards,
Niklas

