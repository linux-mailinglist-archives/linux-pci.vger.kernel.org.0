Return-Path: <linux-pci+bounces-18051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A29EBAA7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 21:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9727A18871CE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B496227573;
	Tue, 10 Dec 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="OKBbQ14K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF9226869;
	Tue, 10 Dec 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861419; cv=none; b=Gim4sgn+FqQ9pFJW+G2gkRt/8k+rDXAap8an4Je/UTPfIGEDlcaafvuz1Opbt8N37sKfOtcadChL8WNpZOUDsq/mL8TLx5wGAL8oC1pShKdbN3B3My+KFb38lTfazlorlqmG8KBzxw1d+ACrGMqApbUi6RagTuzMw9XyfRRQMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861419; c=relaxed/simple;
	bh=FYEQbT9tBWdrOaUmg/9LCm6UrMmwas/GkuSUSpaCRGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loxurJYRxtZ5HNKvHSnFbffnQYqoZoIuuTNhYhWGnLRGfFH33TamP1bRPDVpW0QBZRsFFtZD8pvyZnwIiUTNnZHfOgJa/1XFDA4u3bjtOBYc4m1DYvgGKOslUjFf8Obd4uxQb1Gidf7XOUGvMvoRU3kRxjOVMqpsbgQCXfoKwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=OKBbQ14K; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AhEWUKL5EhB8ncFdMFzQW4/lbKCtlIrg6mHUxIedBSE=; b=OKBbQ14KBlVrretGyyGUSDnClZ
	9c2oso6nkDj80BeuVHcyvOzAYIat6gZoqf+CYD6T973bqp/G81KnARBGKRIj27Mf8w+H8Jx4sBzrR
	3cM5y0P1b2GmVaC397CQbjq4mviSSnfEL83KrihNXJ4GizDLrJRN+1OmRanbx5ubNoaU=;
Received: from [88.117.62.55] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tL5qY-000000002GY-3Sx5;
	Tue, 10 Dec 2024 20:24:39 +0100
Message-ID: <94752230-a901-4a15-abd1-f470a62e1047@engleder-embedded.com>
Date: Tue, 10 Dec 2024 20:24:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] e1000e: Fix real-time
 violations on link up
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20241208184950.8281-1-gerhard@engleder-embedded.com>
 <7c4f3165-df86-47e1-9fc4-7087accf4a68@molgen.mpg.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <7c4f3165-df86-47e1-9fc4-7087accf4a68@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 09.12.24 12:34, Paul Menzel wrote:
> [Cc: +PCI folks]
> 
> Dear Gerhard,
> 
> 
> Thank you for your patch.
> 
> 
> Am 08.12.24 um 19:49 schrieb Gerhard Engleder:
>> From: Gerhard Engleder <eg@keba.com>
>>
>> From: Gerhard Engleder <eg@keba.com>
> 
> The from line is present twice. No idea, if git is going to remove both.

It seems git send-email is adding this line again automatically.
Will be fixed next time.

>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all 
>> writes
>> are flushed. As a result, DMA transfers of other targets suffer from 
>> delay
>> in the range of 50us. This results in timing violations on real-time
>> systems during link down and up of e1000e.
>>
>> A flush after a low enough number of PCIe writes eliminates the delay
>> but also increases the time needed for MTA table update. The following
>> measurements were done on i3-2310E with e1000e for 128 MTA table entries:
>>
>> Single flush after all writes: 106us
>> Flush after every write:       429us
>> Flush after every 2nd write:   266us
>> Flush after every 4th write:   180us
>> Flush after every 8th write:   141us
>> Flush after every 16th write:  121us
>>
>> A flush after every 8th write delays the link up by 35us and the
>> negative impact to DMA transfers of other targets is still tolerable.
>>
>> Execute a flush after every 8th write. This prevents overloading the
>> interconnect with posted writes.
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Link: 
>> https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> ---
>> v2:
>> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
>> ---
>>   drivers/net/ethernet/intel/e1000e/mac.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c 
>> b/drivers/net/ethernet/intel/e1000e/mac.c
>> index d7df2a0ed629..7d1482a9effd 100644
>> --- a/drivers/net/ethernet/intel/e1000e/mac.c
>> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
>> @@ -331,8 +331,13 @@ void e1000e_update_mc_addr_list_generic(struct 
>> e1000_hw *hw,
>>       }
>>       /* replace the entire MTA table */
>> -    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
>> +    for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>>           E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
>> +
>> +        /* do not queue up too many writes */
> 
> Maybe make the comment more elaborate?

I will try to extend based on comments from the other thread.

>> +        if ((i % 8) == 0 && i != 0)
>> +            e1e_flush();
>> +    }
>>       e1e_flush();
>>   }
> 
> 
> Kind regards,
> 
> Paul

Thank you for the review!

Gerhard

