Return-Path: <linux-pci+bounces-19337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56540A02742
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD19F1885869
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0441DD9A6;
	Mon,  6 Jan 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FSIfMNDP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E61DD87D;
	Mon,  6 Jan 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171810; cv=none; b=JfgRnjGvC51/dRyxz9a29Yn1UovYi2eSts/guhlxt3xaSBGlAfM9ep8A+jUjYMDuVHWMSFn6AMzFulTTZd704j5I+OnvUdKrzUjEgDlrbH3vYIPRMAATIb3+YYdSqv3Sl+W2BuCF0ogL+Fx50lvITT3r4mGchVtH7xv9YdRMytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171810; c=relaxed/simple;
	bh=+A9hjf11LxbMe7Wk3izot3PCWqAIc3dK+NrSbCj3o9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW86NaeKt+eLrdJApEI5+ue/ava3uYafD5JWleUb6Gps6yL/WGQESlZo18Y/4UUVohhTHTPOOXOJfQBbLBU2G6Y9TkOpP3MOMf91yANyddiLsqWSO7eZZHC4zbPCFhqyaUUoG7Vo13gKodh8afrDu5PvsZ5rGG6B+OTkKILJlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FSIfMNDP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=YM34siNnHRje5GuETOWBw8hZtNZPhZgsYoi2pUg8CxE=;
	b=FSIfMNDPLxcX247GTmwn4/5U40BuEzurJDysqbg9Ag49QZLkoPsa79FAI9oH+0
	5A8mP1+03a6jWJ+sJXZEq6CjE0NAwHx5uJNvNa3IZLVAE/A165fAxTfj122T2Yhn
	0j+yR9g8F160d4BRp74M7G435jbEO7Xgh7vbS4VnHM/iQ=
Received: from [192.168.71.44] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3P7b04HtnAkMOAQ--.38177S2;
	Mon, 06 Jan 2025 21:56:06 +0800 (CST)
Message-ID: <9c40bcca-eee3-43b7-8b80-09a0efaa409f@163.com>
Date: Mon, 6 Jan 2025 21:56:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z3vDLcq9kWL4ueq7@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgC3P7b04HtnAkMOAQ--.38177S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1DWFy5JF48Jr4rJrWDJwb_yoW3KrcEvF
	Z2kr4xuw4UWFZruw1rWrW3Crs3CanrKFyUWa4UtrWfGa4UtFWDXayDAr1vvr18KwsxuFZY
	qa43XFWS9r9F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnXJ5UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwvMo2d720OHmQAAsx



On 2025/1/6 19:49, Niklas Cassel wrote:
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> When significantly changing the patch from one version to another,
> (as in this case), you are supposed to drop the Reviewed-by tags.

Okay, i will remove the reviewer.

> 
> Doing a:
> $ git grep -A 10 "IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT"
> does not show very many hits, which suggests that this is not the proper
> way to solve this.
> 
> I don't know the proper solution to this. How is resource_size_t handled
> in other PCI driver when being built on with 32-bit PHYS_ADDR_T ?
> 
> Can't you just cast the resource_size_t to u64 before doing the division?
> 

Thank you Niklas. I'll try it.

Regards
Hans


