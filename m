Return-Path: <linux-pci+bounces-17723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322D9E4CCC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 04:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD6E280D73
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 03:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2418FDC5;
	Thu,  5 Dec 2024 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llug64nX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA516F27E;
	Thu,  5 Dec 2024 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370248; cv=none; b=ngpcSP/4rm4duitrJjh6PymSYuqePDbRP0zMgFgSISHdINx7lbQ/J7mDNrOQm9puiTcoBa5M4osjCdzIpbwcqkrzLZK8n9AayJwY1CcH4tktU01+d+7aA8KZXB8Eyo/7QZ2DPK31gTKsr4dK54t54DZ9c1LtdmhawQsGnAPursk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370248; c=relaxed/simple;
	bh=XXsbJ6QAmS815M2rjQlS33txPpyTxXAPyLcu9QJXr+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smH4vjlfeaF6v9b8CdHeWMAMvVbiBL8rlkbhNNBZhHVkuBgGGtynEvdfz8TKXpf/gG/EYTQoCogG28Dd4SYfq6YEyO+HylQKAvu2YHK6EnxPM5FTQvHmOqdu8odELQxR66DnVJZ0J0SVq/2MyoBXYgp9SfFg/oeDlkQTjXHJpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llug64nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E9CC4CED6;
	Thu,  5 Dec 2024 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733370248;
	bh=XXsbJ6QAmS815M2rjQlS33txPpyTxXAPyLcu9QJXr+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=llug64nXG1tyBGkhunXYFDpSSlD1o/PfsLwi6CvWQeI/xfrF/ml/PrD2syeaLKKez
	 Nr59zsykVVuvvafNLzPuW0zp0Anm3tq7IrmRxSfGNkB58j56Wx4yGYkRAowtoSg1sI
	 lWa2PJJ1lKsI4eh0qYrdobKQd4Hu9FLixFJ/5o4G40SCOtrl2uPiKlfBTp2atwQy++
	 7VmXMgARBru6QGckXLrFeGYGbbnK4tSVjRP9TnbNIQT8PT5EZXudTsler0epRUbuPp
	 dlCZKI9Jf17BB66w1acGXFZ5KPvGqlZNVZnSCmt8WDEKP9+hsJMLKdxQDNH47wQCv/
	 G2/LxxdHLkq2Q==
Message-ID: <a1dafdb9-1480-480a-97f1-b43367d883fb@kernel.org>
Date: Wed, 4 Dec 2024 21:44:05 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Verify devices transition from D3cold to D0
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20241204234521.GA3028067@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20241204234521.GA3028067@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/2024 17:45, Bjorn Helgaas wrote:
> On Wed, Dec 04, 2024 at 11:30:51AM -0600, Mario Limonciello wrote:
>> On 8/23/2024 10:40, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Gary has reported that when a dock is plugged into a system at the same
>>> time the autosuspend delay has tripped that the USB4 stack malfunctions.
>>>
>>> Messages show up like this:
>>>
>>> ```
>>> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
>>> ```
>>>
>>> Furthermore the USB4 router is non-functional at this point.
>>>
>>> Those messages happen because the device is still in D3cold at the time
>>> that the PCI core handed control back to the USB4 connection manager
>>> (thunderbolt).
>>>
>>> The issue is that it takes time for a device to enter D3cold and do a
>>> conventional reset, and then more time for it to exit D3cold.
>>>
>>> This appears not to be a new problem; previously there were very similar
>>> reports from Ryzen XHCI controllers.  Quirks were added for those.
>>> Furthermore; adding extra logging it's apparent that other PCI devices
>>> in the system can take more than 10ms to recover from D3cold as well.
>>>
>>> This series add a wait into pci_power_up() specifically for D3cold exit and
>>> then drops the quirks that were previously used for the Ryzen XHCI controllers.
>>>
>>> Mario Limonciello (5):
>>>     PCI: Use an enum for reset type in pci_dev_wait()
>>>     PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
>>>     PCI: Verify functions currently in D3cold have entered D0
>>>     PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
>>>     PCI: Drop Radeon quirk for Macbook Pro 8.2
>>>
>>>    drivers/pci/pci-driver.c    |  2 +-
>>>    drivers/pci/pci.c           | 70 +++++++++++++++++++++++++++----------
>>>    drivers/pci/pci.h           | 13 ++++++-
>>>    drivers/pci/pcie/dpc.c      |  2 +-
>>>    drivers/pci/quirks.c        | 25 -------------
>>>    drivers/usb/host/xhci-pci.c | 11 ------
>>>    6 files changed, 66 insertions(+), 57 deletions(-)
>>
>> Bjorn,
>>
>> This series has stalled a while.
>>
>> Mika and I went back and forth and I think are generally in agreement so I
>> think it's waiting on your feedback.
>>
>> Can you take another look?
>>
>> The alternative is to add some more piles of quirks, but I'm hoping that we
>> can go this direction and drop a bunch of the old ones instead.
>>
>> LMK if you want me to rebase it on 6.13-rc1 and resend a v6.
> 
> I'm still stuck on patch 2/5 because I'm not aware of any spec
> language about polling PCI_PM_CTRL to wait for a power state
> transition, so it seems really ad hoc.

I'm not really sure how to overcome this.  If I rebase everything I'll 
give specs another read through in case I missed anything, but I suspect 
you know these specs better than anyoe on this list.

Is it worth raising this to PCI-SIG to discuss?
Did you perhaps already do that?

> 
> If you do rebase to v6.13-rc1, in the 2/5 commit log,
> s/evices/devices/.
> 
> I guess that whole patch and commit log needs updating since the RRS
> code was added to pci_dev_wait() in the interim, so the "device that
> has gone through a reset may return a value in PCI_COMMAND but that
> doesn't mean it's finished transitioning to D0" doesn't directly apply
> anymore.
> 
> Bjorn


