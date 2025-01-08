Return-Path: <linux-pci+bounces-19545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B98A05E2B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1616372E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AC1FCCEF;
	Wed,  8 Jan 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB6IysO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDD1FCFDC;
	Wed,  8 Jan 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345644; cv=none; b=eCOLcgb7lyEdiv0lbRgoo9SfcsZgAq7CaYRPLG4rJpVXrNtipijfU1v+swfyv8UiC521dJ0ZubAFjIRKHaCL/JS7gduFACO0bkg91pZV97KJL0eqFl4yg9LjHIh8UhVzsrXFF/RnLweJpzMzmWxF5ujFavWkH7UqE6wcaA53igE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345644; c=relaxed/simple;
	bh=PQbNT2EN4BRriyH3ZUWf76fAyYUXAtBRdoIchf6rI98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFZ+WMSXGEwAWJn4o5xLnbJ3mN99UmEmWvOaDr+MBz/AvM9MiFWfzx+GC7QpptuSV5dfQXvFTvNqtrY8OdIkDnWs5+YFXQdyGu29zOQ1ZONRWK72Y77ZPFTXPkJNqJfpOMTmI4F4mCpvdJCeqmJfRiofSjHxjyxtuSlT5Hu/9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB6IysO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFF5C4CEE3;
	Wed,  8 Jan 2025 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736345644;
	bh=PQbNT2EN4BRriyH3ZUWf76fAyYUXAtBRdoIchf6rI98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eB6IysO8vJEUc/0oprh/LFb3JhtJsB2tUPoQ+wuXWCWWena1+4lOY2K6nZZdZtR4S
	 TqR1S0aoHSAwlR0+gfKSTrMlGsjmiAxIJSikSaJ7B6OToLvspbXX78Rvl0uOKiJ1hy
	 Ggff3QYnpONj/5Uhk3klt51MRij6XiBT0C9hLKASAKMQs+oCCxKMIIuc6boRvu6Hdg
	 wXiNfiebyEF/xmTlKVvTHVBgLEFlFBt/1z2KTXwKBUxBo8at/dFOTVZ/wvKHHnzecB
	 ZOZG8u+xXrUF28jTRsDnaBZ3fWiEsRLcx8UADt5nzyFTluffxLkjEDnuLb7/RvdC8a
	 ds6JXtogvaPmQ==
Date: Wed, 8 Jan 2025 15:13:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z36IJ6ql09I_dO98@ryzen>
References: <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen>
 <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>
 <Z31O8B14sKd5eac-@ryzen>
 <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>

On Wed, Jan 08, 2025 at 03:10:03PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 7, 2025, at 16:57, Niklas Cassel wrote:
> > On Tue, Jan 07, 2025 at 11:44:21PM +0800, Hans Zhang wrote:
> >> On 2025/1/7 19:47, Niklas Cassel wrote:
> >> 
> >> Hi Niklas,
> >> 
> >> > The error:
> >> > drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
> >> > sounds like the compiler is using a specialized instruction to do both div
> >> > and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
> >> > will no longer get this error.
> >> 
> >> The __udivmoddi4 may be the way div and mod are combined.
> >> 
> >> Delete remain's patch 1/2 according to your suggestion. I compiled it as a
> >> KO module for an experiment.
> >> 
> >> There are still __udivdi3 errors, so the do_div API must be used.
> >
> > Ok. Looking at do_div(), it seems to be the correct API to use
> > for this problem. Just change bar_size type to u64 (instead of casting)
> > and use do_div() ? That is how it is seems to be used in other drivers.
> 
> I think using div_u64_rem() instead of do_div() would make this
> more readable as this is always an inline function, so the type can
> remain resource_size_t, and the division gets optimized well when
> that is a 32-bit type.

After patch 1/2, we no longer care about the remainder, so I guess
div64_u64() is the correct function to use then?


Kind regards,
Niklas

