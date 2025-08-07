Return-Path: <linux-pci+bounces-33563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5BB1DA9B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8434188D1F5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71051264A77;
	Thu,  7 Aug 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwogJJO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4814884C;
	Thu,  7 Aug 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579652; cv=none; b=hyedKIEtBvWpjeZFVfhrqeuVriPM8GgxNg1Yilxt8sXkX5PKuL36W1vuGYlSLPvl6HyfIbt4HW+LcsdtvLPEtL/g07M0VrmVxvnUzdJK2YJoJFWJk1kOePntVMg6PWdVr9AwcdmtavgVJ8IooKdLaKlV9UYlUv835OmR63LD7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579652; c=relaxed/simple;
	bh=HLy6MypCaHBszOr/Pa1itBMcfKWRzWIiaq0MSA4NCdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SABO4XXIldoBmY8v8HJmXCER1Ak3Ihp8QyYZU70ZgSw4w6l+4K9So4NtHx0e2ZID62mssE7lOxpsgVL1ki4tSqC8TLoj5HcmDjLyg73RtDY6K/XIKei8Hsp7l8LJt5xT8FqfYf4T7dPSZCXMKpBV7QIO0rzM0EiHCBZGVZJEJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwogJJO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8F5C4CEF4;
	Thu,  7 Aug 2025 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754579650;
	bh=HLy6MypCaHBszOr/Pa1itBMcfKWRzWIiaq0MSA4NCdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwogJJO768KnrCgyh0SNGIcA2dUyElXxSIJXRF2dfHNFULY0fwFiDnjaB2qUJjG5G
	 AVbBPw0zHeACbovtZPVqSorbVLEAOd16vUrVcpLCm6v8EeTYLTKqyy/dRGvN+J/tsm
	 IyaiYg1al+4bRI+v1pC6hfDFPGULDdUiatIldG4zTgu4FWcwLlq+LM/9jtJPQnXKvC
	 I3OwX5GnVPnLFBfkeSaufrxr6KTghesi6EezDxXdSQBvvHXHUB0skEfNovlB2xsIyE
	 Vff5syvXLZT6vw1aEf39tHJJyoUodGdBBt8g3dF20qkVVhvQ080KpnESLisfq0+ym8
	 4LjymzF3x5fRA==
Date: Fri, 8 Aug 2025 00:14:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shuan He <heshuan@bytedance.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] PCI: Remove redudant calls to
 pci_create_sysfs_dev_files() and pci_proc_attach_device()
Message-ID: <20250807151408.GA112878@rocinante>
References: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
 <aIDbwNdWgtKcrfF_@wunner.de>
 <d2ty2hr5jqmlqwkdnd252ctix4xqmxtonx6wqyq3oj5f3j3cpf@yuibbj5owarp>
 <CAKmKDK=dOZp1a_syV1fjdo2gjEJX=C21A_mDsMqZVZrKLjf46A@mail.gmail.com>
 <20250807141403.GA3052587@rocinante>
 <CAKmKDKmCfUgj+ZAjH-pKeaDu2xz6j1tbD7kHMUWbCRFxYAPenA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmKDKmCfUgj+ZAjH-pKeaDu2xz6j1tbD7kHMUWbCRFxYAPenA@mail.gmail.com>

Hello,

> Very sorry to bring any disturbance.

Nothing to apologise for.  If anything, I am sorry for being slow with
getting this done causing you and others some grief when this breaks.

> > What "moves" do you plan to make here?  I would say... please be a little
> > patient.  My day job is keeping me busy at the moment. Nevertheless, I
> plan
> > to get to this very soon.
> Thanks in advance for your efforts. Please do this in your early
> convenience then.

Are you having an issue with this, actually?  If so, what platform and
kernel version?  If you don't mind sharing - it's nice to document more
cases where this is causing issues...

> Plus, no worries, "moves" here didn't mean anything.

So, no dance moves? :-)

> https://github.com/kwilczynski/linux/commits/kwilczynski/sysfs-static-resource-attributes/
> > This is not the latest version, please don't use it for anything (this has
> > been since removed).
> Got it. Thanks.
> 
> > P.S. Try not to top post when replying.
> Sorry again. :(

No worries.  Not a big issue :)  It has to do with readability, as when top
and bottom posts mix up, then it's hard to follow the conversation (plus
the ettiquete of posting on the Linux-related mailing lists applies here,
too).

Thank you!

	Krzysztof

