Return-Path: <linux-pci+bounces-37739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87254BC6B62
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 273414E36FA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C826E6FD;
	Wed,  8 Oct 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="izGtxcPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200120296E
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960435; cv=none; b=LPgkVlC1eaafq2KP2fgeKi1WENDPPbZyOcVtvd4Vd06lm+N7H9/OH/pAnf0yBo+B1sHXLvys2zKQ/qssT25HanCDo7jANFh5zKe2ReUGL6KLSqu3GAXqBzidIjxDRTfv9UzVyBA7eYeFiR33TmY69TPq7P1tISEOccSjs7C3l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960435; c=relaxed/simple;
	bh=TwL8fSe6ypaUWThvj+WbLVnVG1nkkTI5BxCxND33tgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmkN27s/QEALMmkDy1tW6d0Yk6usCZJm/fxX5PYYAQyJLh4Zyyy5tzUvOc9itjyZqBqn/zZjbie231S53yrxK9jLG0WmEsth0CLdLq+8Y/MUHoOulLAWDyk1Y9o6Np3aE3F8W4BFVA2wy458llHkMDJzE9Ccl2bXXJIpaj1eqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=izGtxcPH; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chmwl46MJz45Bs;
	Wed,  8 Oct 2025 17:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759960424; bh=TwL8fSe6ypaUWThvj+WbLVnVG1nkkTI5BxCxND33tgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=izGtxcPHz/JGALZkS2oKt8yCEVmsxPDK11g/ycPSkheGv8ZdKR12JH9/f+K5dHLQi
	 96gdac8u8jw6YHyRRG7J1SyeXWLLRvqmIdxylXHC+cBnk7aUZmA6kN2oVRdtAInUks
	 qyMluK5qGienxpI2WHHNjOAEfHHt3yMYmGXRL9Qw=
Message-ID: <78e35f80-d250-4ece-9d34-045a55609ec4@panix.com>
Date: Wed, 8 Oct 2025 14:53:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
To: Bjorn Helgaas <helgaas@kernel.org>, Kenneth C <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20251008201443.GA638724@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251008201443.GA638724@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-By: Kenneth R. Crudup <kenny@panix.com>

On 10/8/25 13:14, Bjorn Helgaas wrote:
> On Tue, Oct 07, 2025 at 02:39:09PM -0700, Kenneth Crudup wrote:
>>
>> I'm running Linus' master (as of a8cdf51cda30).
>>
>> I have a Thunderbolt dock (Amazon Basics generic thing, but it also happens
>> on my CalDigit TB4). With the above commit (and aaae2863e731 ("PCI: Refactor
>> remove_dev_resources() to use pbus_select_window()), so the Subject: commit
>> would come out cleanly) if I plug in a TB device past my TB Dock, they don't
>> fully enumerate (i.e., no DP tunneling, no partitions created, etc.)
> 
> Can you try this patch, which identified the same 4292a1e45fd4 commit?
> 
>    https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com
> 
> I tentatively put it on pci/for-linus.
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


