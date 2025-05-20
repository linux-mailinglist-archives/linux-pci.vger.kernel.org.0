Return-Path: <linux-pci+bounces-28111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2284ABDC51
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1127B626C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482B248F76;
	Tue, 20 May 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEgbBOqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761B247290;
	Tue, 20 May 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750346; cv=none; b=mHhcBrhNBH4fK4yNArcuxMZ2OzxopiOkt0n0t0HhSR4HKhTz2RgSFuIRbOhMF+NqbEGibbpX9nc8hE346bFsXv3DMrfGO2PF+iwlP+EpoBp+jFSSp5lARmtciBBs8d7d36+IPqHlENZOsrcgeUBlkaI5ArSvSP1ghoak04JoFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750346; c=relaxed/simple;
	bh=+Pu6dKnw6J7LjD0sUA9DOJvqMqJXTd4BBn3UDaN8PtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PayqWz/tFStMjjZxxa3NP4EBPwhLrSTgjfzJbJyGihQGoOtGSekPld9OD5fAfx0ngtZrjExUbqDp6EIYFcscaYMOEa0XDoR9hpKRH8pQ7HxyItGRIEW3K5S4aBTqcttg4Pj/QNqpa6MuV8rw1H3hGOGMQ7fikevF13VaaphzrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEgbBOqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8818C4CEEA;
	Tue, 20 May 2025 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750345;
	bh=+Pu6dKnw6J7LjD0sUA9DOJvqMqJXTd4BBn3UDaN8PtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEgbBOqa0QDAgwJUmKX7to3N4SvkLp/ELv7tbiKV0ZvoZrhp6j9CxT4rntCB515yX
	 61rxm01GNykh/pI2fgW+YpLghRUP8NXjWIZT3RwF5H2aBLJn7WILIdhxzfgfPUeylM
	 uHqe6NejBYdJNXz/x1v14ulJMOKS2h2K20Xg00xN9hzZniiihdF+EYRoy9Kf14pSWv
	 1bD61U/+0rXZwkUVmL9p1WdY/Y+PfJS2v3XydGIMhpIpzfylxUS5ADHoiHsP2m7ugA
	 n6bS8nj48sHYbZ5TDVbaRze9Oh+xb/7O6/NHntCKkYnPq/ft1k5Ffe9sSK9VCk1P4F
	 g2113p9YGILvw==
Date: Tue, 20 May 2025 10:12:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 382/642] PCI/pwrctrl: Move
 pci_pwrctrl_unregister() to pci_destroy_dev()
Message-ID: <aCyNyHqFvRmxtqtd@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-382-sashal@kernel.org>
 <aBnDI_40fX7SM4tp@wunner.de>
 <tfil3k6pjl5pvyu5hrhnoq7bleripyvdpcimuvjrvswpqrail3@65t65y2owbpw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tfil3k6pjl5pvyu5hrhnoq7bleripyvdpcimuvjrvswpqrail3@65t65y2owbpw>

On Sat, May 10, 2025 at 12:01:31PM +0530, Manivannan Sadhasivam wrote:
>On Tue, May 06, 2025 at 10:06:59AM +0200, Lukas Wunner wrote:
>> On Mon, May 05, 2025 at 06:09:58PM -0400, Sasha Levin wrote:
>> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> >
>> > [ Upstream commit 2d923930f2e3fe1ecf060169f57980da819a191f ]
>> >
>> > The PCI core will try to access the devices even after pci_stop_dev()
>> > for things like Data Object Exchange (DOE), ASPM, etc.
>> >
>> > So, move pci_pwrctrl_unregister() to the near end of pci_destroy_dev()
>> > to make sure that the devices are powered down only after the PCI core
>> > is done with them.
>>
>> The above was patch [2/5] in this series:
>>
>> https://lore.kernel.org/r/20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org/
>>
>> ... so I think the preceding patch [1/5] is a prerequisite and would
>> need to be cherry-picked as well.  Upstream commit id is:
>> 957f40d039a98d630146f74f94b3f60a40a449e4
>>
>
>Yes, thanks for spotting it Lukas, appreciated!
>
>> That said, I'm not sure this is really a fix that merits backporting
>> to stable.  Mani may have more comments whether it makes sense.
>>
>
>Both this commit and the one corresponding to patch 1/5 are not bug fixes that
>warrants backporting. So please drop this one from the queue.

I'll drop it, thanks!

-- 
Thanks,
Sasha

