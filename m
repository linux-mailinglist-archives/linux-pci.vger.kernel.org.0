Return-Path: <linux-pci+bounces-18726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973A9F6EA9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 21:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B767A142A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC2155C87;
	Wed, 18 Dec 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="eJPK66ZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14813A87C;
	Wed, 18 Dec 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552184; cv=none; b=qnaWWJmuSc45M5YdvKl10hH2Mzv/XZnDB65txB10WGVVKK22C7SZpy9cswXIvErZ44SxgSW4NeR7KlwXO+xiVv6SxH2rXLoOGJ/A4xWfik5dUzGeru64bpeRqjCfpz9xoMFTDDG7LQMGKgxnmqv6uDncLpeViCwMIbFUeIdiRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552184; c=relaxed/simple;
	bh=2Of0j9lU8b9qxWD+ndx3DbCaR0TpusZ7SAyJc5WKOQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5TfP04RjWX0m8IlPeLw/qlNoBDcI+1j1BLys8pWW46obz2TGALUBtgU0ARuRZgY+pl0gpfJC4VmsP1GuMISxW7FNTixMQefmtn0Bz64334BUvdlIIuGRQqsAa1GGUCHmzSNcq3xLkJewMVTJWG5OBOvgJUyWpvstAVJs8FkXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=eJPK66ZA; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fjmkeAFTdbSZjtHMJws8A6MlB+V8KeXQTp/OqbPGH+s=; b=eJPK66ZAJK3ZdxXkkqMYNnOrxS
	HjjOJcgNF8Pf3MSKvY+LdxvtevtvjVHCeAMFPJahbVeRz5VTEL7VlOnhDcNzYzOKq433lDDxR37Ye
	DduaYmpqLAeus/2CTgRSOcW3zogsQdHZ1Aa/xr3ppq+/1uAh/jzuSmPrZVMjBFiNUv4M=;
Received: from [88.117.62.55] (helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tNzbi-000000006xh-3u82;
	Wed, 18 Dec 2024 20:21:19 +0100
Message-ID: <af154371-8513-4ff2-a288-c8301cc8c65c@engleder-embedded.com>
Date: Wed, 18 Dec 2024 20:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, linux-pci@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bhelgaas@google.com, pmenzel@molgen.mpg.de,
 Gerhard Engleder <eg@keba.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
 <231abdb7-3b16-4c3c-be17-5d0e6a556f28@intel.com>
 <047738af-69af-49aa-ae91-7dbca40ae559@engleder-embedded.com>
 <57948d32-bd6f-473c-a7e6-90185ea41986@intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <57948d32-bd6f-473c-a7e6-90185ea41986@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 18.12.24 09:36, Przemek Kitszel wrote:
> On 12/16/24 20:23, Gerhard Engleder wrote:
>>>> @@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct 
>>>> e1000_hw *hw,
>>>>       }
>>>>       /* replace the entire MTA table */
>>>> -    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
>>>> +    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>>>>           E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw- 
>>>> >mac.mta_shadow[i]);
>>>> +
>>>> +        /* do not queue up too many posted writes to prevent increased
>>>> +         * latency for other devices on the interconnect
>>>> +         */
>>>> +        if ((i % 8) == 0 && i != 0)
>>>> +            e1e_flush();
>>>
>>>
>>> I would prefer to avoid adding this code to all devices, particularly 
>>> those that don't operate on real-time systems. Implementing this code 
>>> will introduce three additional MMIO transactions which will increase 
>>> the driver start time in various flows (up, probe, etc.).
>>>
>>> Is there a specific reason not to use if 
>>> (IS_ENABLED(CONFIG_PREEMPT_RT)) as Andrew initially suggested?
>>
>> Andrew made two suggestions: IS_ENABLED(CONFIG_PREEMPT_RT) which I used
>> in the first version after the RFC. And he suggested to check for a
>> compromise between RT and none RT performance, as some distros might
>> enable PREEMPT_RT in the future.
>> Przemek suggested to remove the PREEMPT_RT check as "this change sounds
>> reasonable also for the standard kernel" after the first version with
>> IS_ENABLED(CONFIG_PREEMPT_RT).
>>
>> I used the PREEMPT_RT dependency to limit effects to real-time systems,
>> to not make none real-time systems slower. But I could also follow the
>> reasoning of Andrew and Przemek. With that said, I have no problem to
>> add IS_ENABLED(CONFIG_PREEMPT_RT) again.
>>
>> Gerhard
> 
> I'm also fine with limiting the change to RT kernels.

I will add IS_ENABLED(CONFIG_PREEMPT_RT).

Thanks!

Gerhard

