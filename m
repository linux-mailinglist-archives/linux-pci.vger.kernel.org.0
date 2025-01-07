Return-Path: <linux-pci+bounces-19446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8DA04546
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F231887A79
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A941F131A;
	Tue,  7 Jan 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOvWNvMa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A91EE003;
	Tue,  7 Jan 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265461; cv=none; b=LfEQ8Yi6JrPQATzNwwXzpQzgFQAMlrMqM6vCD55AEC7lTqwXrGowh7tExqZmlnaGbobF44LiX2FLu5krfGpufjh5Ppw7UkGqukuXONY5HcFFTcVK1L5u8+Wd+La0lZyw2dIcCyk+6FdSU68kGLY2LGFuhgMX7OSVEzQpj42vsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265461; c=relaxed/simple;
	bh=woyqiwRaqcoqUJb7EmMJwpKtcKotGQmqZqgAVpM4Za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFpg1xWIq8frcsQcKHIlsIqB6tkjPyqhEL/aL7UQfg4Q63Ucb8Up3/wvwga4RE45IZOUxlCDtJVE6wWaxYPEhd/5eelJxUGYFttMiznOQGHW4pntj3avrQqNdVWz/D9zRJms7hw+UjRJVJRFpkolHb2Miq8wS7ZAOQpZwHAtmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOvWNvMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D588BC4CED6;
	Tue,  7 Jan 2025 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736265460;
	bh=woyqiwRaqcoqUJb7EmMJwpKtcKotGQmqZqgAVpM4Za8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOvWNvMamvvrkPcjzWDE//nHTuRDk0QEN2r/1+Nzq+5CfKCRLXiCqp+FSzF2ry2L/
	 RfV4pUdfiOhAtASuyYppVWkWxYHWQ1B8RkfX16t+Gigh+uBIW7/OG+G0ponqHOZ4cZ
	 n6c41wFU1sVT5fEEleT44doXb98A1cp37w9DlZzFzuNLv/YkUwXstVCkZ8iIFPqF4Z
	 yOT2y9AfpnixXHpC+7GD0w75seSeWvj+ahWkZMJn77TuA99ERdufTEtL0YQ/LVrlWq
	 6vuZsrL8PuGqZvbL+X+gV526IcSvdaGTxhB98qmAcFLw1Q8c6yZ5B07AR94J7yN6n1
	 ETz3SosMt+lIw==
Date: Tue, 7 Jan 2025 16:57:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z31O8B14sKd5eac-@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen>
 <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>

On Tue, Jan 07, 2025 at 11:44:21PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/1/7 19:47, Niklas Cassel wrote:
> 
> Hi Niklas,
> 
> > The error:
> > drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
> > sounds like the compiler is using a specialized instruction to do both div
> > and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
> > will no longer get this error.
> 
> The __udivmoddi4 may be the way div and mod are combined.
> 
> Delete remain's patch 1/2 according to your suggestion. I compiled it as a
> KO module for an experiment.
> 
> There are still __udivdi3 errors, so the do_div API must be used.

Ok. Looking at do_div(), it seems to be the correct API to use
for this problem. Just change bar_size type to u64 (instead of casting)
and use do_div() ? That is how it is seems to be used in other drivers.

I still think that a patch that removes the "remainder" code is a good
cleanup, so please send it as patch 1/2, you can be the author, just add:
Suggested-by: Niklas Cassel <cassel@kernel.org>


Kind regards,
Niklas

