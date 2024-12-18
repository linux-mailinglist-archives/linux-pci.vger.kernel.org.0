Return-Path: <linux-pci+bounces-18725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E039F6E6B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 20:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B2818947C3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5121FC11C;
	Wed, 18 Dec 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ApQfajPj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040C15530B;
	Wed, 18 Dec 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551034; cv=none; b=c4uosx8wKcUby1xGW+DIDpONF2PfjxjzQeQQJhApUINHXn57PB58schaeomnLAh1YzwUFngyEQ0qOZgbNVBIyYqXS8kgitzqz0vCAm/pj+0pKG5UL4F6zZMNYlIEq9cciyrsAwIlh9GboY0wvlQGAamnGVUtklwk+oY9rgQGoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551034; c=relaxed/simple;
	bh=LEQ/s06tmZTPxKzo49jVfieEOtYH6VGRMSfilsGYE8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqhKR5InMTgyf8OZOeC8y1tiJoXewhCiEKYGlNM6wx63EPFWuqzs7xp0jMbhFosHugBHLvMGUZcZOFso8MXwy/HoZWZ5TppUdZODCh1XL0Me3EKvJEpDN5wEFDJjEQl8+EYK3uvO9z1uCGeltnpBSmKn9R6UPkfr2SHokpPX2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ApQfajPj; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r6siq0c5OvQV7pOu79hLNhx5/8LObOLe6yLaV358jZE=; b=ApQfajPjVyq0yNVpK2tHBtxQAH
	SYClV7vaTIJTUfTavKSHEZWqkZVIz+EDoYLjbR9jMbz2yHxsM2PnTEQIVxvQnGR2UI/3ioNS3RerT
	eQewkskPXaendgnoFoyd8sxhmgjhlA4cX4oDl/zthXuhdg3GCp7FoFcc+KmahY3RQKDw=;
Received: from [88.117.62.55] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tNzxQ-0000000051R-2hCK;
	Wed, 18 Dec 2024 20:43:44 +0100
Message-ID: <e9bd85fc-a682-4c60-9dfd-0829ca886889@engleder-embedded.com>
Date: Wed, 18 Dec 2024 20:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 bhelgaas@google.com, pmenzel@molgen.mpg.de, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
 <9889f570-a2a0-4a71-b140-41278f1e8639@intel.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <9889f570-a2a0-4a71-b140-41278f1e8639@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 18.12.24 16:23, Alexander Lobakin wrote:
> From: Gerhard Engleder <gerhard@engleder-embedded.com>
> Date: Sat, 14 Dec 2024 20:16:23 +0100
> 
>> From: Gerhard Engleder <eg@keba.com>
>>
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all
>> writes are flushed. As a result, DMA transfers of other targets suffer
>> from delay in the range of 50us. This results in timing violations on
>> real-time systems during link down and up of e1000e in combination with
>> an Intel i3-2310E Sandy Bridge CPU.
>>
>> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
>> robot controller. The exact root cause of the problem is unclear and
>> this situation won't change as Intel support for this CPU has ended
>> years ago. Our experience is that the number of posted PCIe writes needs
>> to be limited at least for real-time systems. With posted PCIe writes a
>> much higher throughput can be generated than with PCIe reads which
>> cannot be posted. Thus, the load on the interconnect is much higher.
>> Additionally, a PCIe read waits until all posted PCIe writes are done.
>> Therefore, the PCIe read can block the CPU for much more than 10us if a
>> lot of PCIe writes were posted before. Both issues are the reason why we
>> are limiting the number of posted PCIe writes in row in general for our
>> real-time systems, not only for this driver.
>>
>> A flush after a low enough number of posted PCIe writes eliminates the
>> delay but also increases the time needed for MTA table update. The
>> following measurements were done on i3-2310E with e1000e for 128 MTA
>> table entries:
>>
>> Single flush after all writes: 106us
>> Flush after every write:       429us
>> Flush after every 2nd write:   266us
>> Flush after every 4th write:   180us
>> Flush after every 8th write:   141us
>> Flush after every 16th write:  121us
>>
>> A flush after every 8th write delays the link up by 35us and the
>> negative impact to DMA transfers of other targets is still tolerable.
>>
>> Execute a flush after every 8th write. This prevents overloading the
>> interconnect with posted writes.
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> ---
>> v3:
>> - mention problematic platform explicitly (Bjorn Helgaas)
>> - improve comment (Paul Menzel)
>>
>> v2:
>> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
>> ---
>>   drivers/net/ethernet/intel/e1000e/mac.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
>> index d7df2a0ed629..0174c16bbb43 100644
>> --- a/drivers/net/ethernet/intel/e1000e/mac.c
>> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
>> @@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>>   	}
>>   
>>   	/* replace the entire MTA table */
>> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
>> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>>   		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
>> +
>> +		/* do not queue up too many posted writes to prevent increased
>> +		 * latency for other devices on the interconnect
>> +		 */
> 
> I think a multi-line comment should start with a capital letter and have
> a '.' at the end of the sentence.
> 
> + netdev code doesn't have the special rule for multi-line comments,
> they should look the same way as in the rest of the kernel:
> 
> 		/*
> 		 * Do not queue up ...
> 		 * latency ...
> 		 */

Oh the preferred style changed, I missed that. Will be done.

>> +		if ((i % 8) == 0 && i != 0)
>> +			e1e_flush();
> 
> IIRC explicit `== 0` / `!= 0` are considered redundant.
> 
> 		if (!(i % 8) && i)

You are right, will be changed.

> 
> I'd also mention in the comment above that this means "flush each 8th
> write" and why exactly 8.

I will add that information to the comment.

Thank you for the review!

Gerhard

