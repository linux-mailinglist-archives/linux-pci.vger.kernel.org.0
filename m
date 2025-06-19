Return-Path: <linux-pci+bounces-30187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1117AE077F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DF71885C14
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1B225414;
	Thu, 19 Jun 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5bDbc9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC42673A9
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340169; cv=none; b=MWQ9D0Lm5afYJNJ1hMvaUOaHqmPF62au5N6JPZMmBiNXGtLHXniMkdqIY1pfgfw0hDG+mPXuSPq/EgMJ3AXqFM9ceC/hNpGIGEtBH1uMvbO3uxtAg8CXo/WV89DsTPbHw4RLBmLh1CAcyaPqPTLKf/2eOP0V+TjTcYZNUTTrLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340169; c=relaxed/simple;
	bh=OAAus+sNim0k63OoNME1m9MmGlxLTKMPiYzqnKLRQBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a57mUgujLi0Q0ymeLhJcNyBxUkdETk7MVgvKd1yj0BlDOHCeHK03+NOkiZ4MQ6SBWmIXhwgVID241C+n3PsBC1f2tgSWpAafn1NoP7Zlvlx1VzbN+AAk7Glg5NbEWS9n/E50ef2h9mbeW5MJYgy3B1K2inWJXj9HwwthiODLZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5bDbc9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF45C4CEEF;
	Thu, 19 Jun 2025 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340168;
	bh=OAAus+sNim0k63OoNME1m9MmGlxLTKMPiYzqnKLRQBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i5bDbc9+fA9YsJ/p1aJwlHD/KzYDPUWH/1ywDJtuuc4zw7zk/bbP46jJjNW1PrSap
	 h9S6As88uROwYxHDAyl6BL2btjXwDnN3I772VJ/w6xSLiGTGdKMH/qGY2se97dkITJ
	 9KHJBgDn32TSLvL+IHSLp2O/yBG4sNn36wIxTS1LFIx91ovSWlRRrv7gtOe801GA9U
	 I3TTcCq9heFVwxjGmVzRpanKBbmBGTdnqSZbTtcCs243S0zmk46X8waaAUmOlVAebl
	 Mgzuz+chT4yOMy9NqwY1fe82Cyu7zLhd3xtAsZi5/qI2vtNB2CWNEpmMUiX0cqyQ53
	 ZsGbAp1lVM5mg==
Message-ID: <bd56fdc5-87e4-4a17-9743-33a255601919@kernel.org>
Date: Thu, 19 Jun 2025 08:36:07 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Don't show errors on inaccessible PCI devices
To: Lukas Wunner <lukas@wunner.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20250616192813.3829124-1-superm1@kernel.org>
 <20250616192813.3829124-2-superm1@kernel.org> <aFOq2ub8P47kvmpC@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFOq2ub8P47kvmpC@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2025 1:14 AM, Lukas Wunner wrote:
> On Mon, Jun 16, 2025 at 02:26:56PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When a USB4 dock is unplugged the PCIe bridge it's connected to will
>> remove issue a "Link Down" and "Card not detected event". The PCI core
>> will treat this as a surprise hotplug event and unconfigure all downstream
>> devices. This involves setting the device error state to
>> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.
>>
>> As the device is already gone and the PCI core is cleaning up there isn't
>> really any reason to show error messages to the user about failing to
>> change power states. Detect the device is marked disconnected and skip the
>> messaging.
> 
> Code change looks reasonable to me, but should be cc'ed to Rafael.
> 
> I find the commit message a bit confusing.  I guess your point is
> that it doesn't make sense to runtime resume disconnected devices
> to D0 and report the (expected) failure to do so.  That's one sentence.
> And the subject could be something like:

Thanks I'll replace the second paragraph with your proposed sentence and 
update the commit subject for v3.

> 
>      PCI/PM: Skip resuming to D0 if disconnected
> 
> Thanks,
> 
> Lukas


