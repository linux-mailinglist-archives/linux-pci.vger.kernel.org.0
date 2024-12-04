Return-Path: <linux-pci+bounces-17696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7319E4384
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EDCB3A53B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09566217674;
	Wed,  4 Dec 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXwlaOyF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0481A8F61;
	Wed,  4 Dec 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333453; cv=none; b=QwS8Uv3ToeY3uB7nYJ4V1Dmjx6np6WYCrdiF1khU1tT7ZVPM+7935T52TBrS754bWSQ0vcGHVteDz/8N5XorqeZWazAh4rEnaO0wGpnZz7wKaY8xGYhorbVToD5Nd9MjWfazd7zQLrNOoI5GcxoSKQwk9qfowYAPpm6pWohPj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333453; c=relaxed/simple;
	bh=jwt44kHNB6fF2lg1PZA37n3lhUUOfzmfyHuqFyxEzww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHUyEPmp1YRvJWWTi4yb7y+9SMpCiH5bvA7x5o9uVE8RiQUQkaXno3Z8YalNZXb9Y0wnrUJhoToyIG9FMQ//pupUjGyTNfS/MkVLiBJnj6bsZN+I15inT6M4ZmMvHIcKUPV/Ck/3aku/0DXcDByO0X/3vi7cWrzKs1iwzdo3Buo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXwlaOyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB94C4CED1;
	Wed,  4 Dec 2024 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733333453;
	bh=jwt44kHNB6fF2lg1PZA37n3lhUUOfzmfyHuqFyxEzww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oXwlaOyFHg8r2lL1BHPIjfcGkrFbwecYJGEFvO0y2n2WGa9QjxVB2n6v5AWgYvRiA
	 cApyakaYuHBRDA9fw5DzBGwENK90QWg4pG9R9597vAPkR0WIp5Yq5AjSfFMsRYUw3k
	 mngs9w6InT3USE+pAvgEG9lEgtSpTXYWNeVzAsNgs+8Ovvo8qCxuzc8v92iB5WCdsD
	 3wvmgIxNiwd1Rbrg50g3wvr0ilnm5iwtLaz9v+vUHSyw6s5gDBT3gay+VrunKjU5Cw
	 GD+XzQXuzvWGSUzuCecr1T+OWDv4blQOAuXBOPT0V1/elHBz3f45zUg+rVh8Bbl0/P
	 1wwnsg9t27qrw==
Message-ID: <aaac430f-ba1a-47ee-a290-0bb1559dcf24@kernel.org>
Date: Wed, 4 Dec 2024 11:30:51 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Verify devices transition from D3cold to D0
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240823154023.360234-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2024 10:40, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Gary has reported that when a dock is plugged into a system at the same
> time the autosuspend delay has tripped that the USB4 stack malfunctions.
> 
> Messages show up like this:
> 
> ```
> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
> ```
> 
> Furthermore the USB4 router is non-functional at this point.
> 
> Those messages happen because the device is still in D3cold at the time
> that the PCI core handed control back to the USB4 connection manager
> (thunderbolt).
> 
> The issue is that it takes time for a device to enter D3cold and do a
> conventional reset, and then more time for it to exit D3cold.
> 
> This appears not to be a new problem; previously there were very similar
> reports from Ryzen XHCI controllers.  Quirks were added for those.
> Furthermore; adding extra logging it's apparent that other PCI devices
> in the system can take more than 10ms to recover from D3cold as well.
> 
> This series add a wait into pci_power_up() specifically for D3cold exit and
> then drops the quirks that were previously used for the Ryzen XHCI controllers.
> 
> Mario Limonciello (5):
>    PCI: Use an enum for reset type in pci_dev_wait()
>    PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
>    PCI: Verify functions currently in D3cold have entered D0
>    PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
>    PCI: Drop Radeon quirk for Macbook Pro 8.2
> 
>   drivers/pci/pci-driver.c    |  2 +-
>   drivers/pci/pci.c           | 70 +++++++++++++++++++++++++++----------
>   drivers/pci/pci.h           | 13 ++++++-
>   drivers/pci/pcie/dpc.c      |  2 +-
>   drivers/pci/quirks.c        | 25 -------------
>   drivers/usb/host/xhci-pci.c | 11 ------
>   6 files changed, 66 insertions(+), 57 deletions(-)
> 

Bjorn,

This series has stalled a while.

Mika and I went back and forth and I think are generally in agreement so 
I think it's waiting on your feedback.

Can you take another look?

The alternative is to add some more piles of quirks, but I'm hoping that 
we can go this direction and drop a bunch of the old ones instead.

LMK if you want me to rebase it on 6.13-rc1 and resend a v6.

