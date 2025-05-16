Return-Path: <linux-pci+bounces-27849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D63AB9A4C
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082BA1BC3365
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B52233128;
	Fri, 16 May 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVguL4tZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25C1FFC77;
	Fri, 16 May 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391796; cv=none; b=dM0SRQBgy7yAvuLHqObJeQhE68iPd0v3MmHZU/HsTTC9mFZc5LCrnXOsbFTxEqZGcte2Uqn9Y0R1CDMRuAI+71MddENPh96HKsmIwPkxfySvTrdt37EY4mkUl5YbXKaK9ACYV+iLVCd0aQ2O5shTiFSmLr3s9ghZZ9ioWvhDYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391796; c=relaxed/simple;
	bh=jgVpL2kojiH7bm46Jld8D85YYTbY0kw/r105XuXS+K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7ZdkWDUGOtP1OWJp5+5+xY4SDFbZCzQeMErLYdxVF+XWXp3A5x7gL6jVoPDl+oqJ/4jriAUKL/10qjA2GwTCgKJLHi5qWpZEQxQYtZpdxcrvtfYdq6OJ1jye6zknhNqjumylOQBvsp9jerM1BdqYhuy8B2QGzwAzbd40RReiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVguL4tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560C6C4CEE4;
	Fri, 16 May 2025 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747391795;
	bh=jgVpL2kojiH7bm46Jld8D85YYTbY0kw/r105XuXS+K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVguL4tZyjFIsIcQZk4hmgGoVVxYo/WHfCUILoi3R/DCTpDnv3o9PiuWo+NZX4Bc1
	 kpU44F4ySgUBQKFVcvF2fN+BEmY7pfrvMcFdOXlGLXMscSOiR+DsRbbGYc56WVabV+
	 BaU1MYUiY8Z/7tz35yTmyCMXqKmV0sAh7PktCpNp2rZU2Q5kcwbquL1WEA+akpBs5J
	 JZIGra8owWaACG4jaKY/zxaalwY7KodlvFXsS18pa7eNKuJKMdYpJJj6AT3OHcXIRy
	 n12ufnFFze5Jos7z9RI7pRklfSEsfDan6ZFgSFoTjG6G/NHZuxuq3G2VNYQedixaB4
	 odP13CWqiw/OA==
Date: Fri, 16 May 2025 19:36:33 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <20250516103633.GA448167@rocinante>
References: <202505152337.AoKvnBmd-lkp@intel.com>
 <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
 <20250515162405.GA511285@rocinante>
 <aCcGkN-9pN-jUwkS@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCcGkN-9pN-jUwkS@ryzen>

Hello,

[...]
> Comparing the commit that landed on the branch, with Wilfred's patch on the
> mailing list, I did notice this diff:

[...]
> Reviewing the diff, the changes looks fine to me, but I strongly think
> that if the actual code is modified from the submission (rather than
> just fixing some minor grammar in the commit message), the (unwritten?)
> rule is that the person should add a:
> 
> [person: describe modifications from the original submission]

Sorry about that.  I did forgot to add this.  Good catch.

That said, a single single line with a nudge or a reminder would suffice.

There is no need for a condescending tone and the lecturing and such.

You have been doing this for a while now, and if you continue doing this,
I will have no choice but to start to ignore submissions from you, I do not
have the time to deal with any forms of such passive-aggressive attitude.

Thank you!

	Krzysztof

