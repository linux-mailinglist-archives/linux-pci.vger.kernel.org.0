Return-Path: <linux-pci+bounces-20713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F0A27CD7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499E21886793
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B0219A8E;
	Tue,  4 Feb 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="wH/g5+st"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D38203710;
	Tue,  4 Feb 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738701290; cv=none; b=qGoWoqRU1VOpM/1eroaB/8mzMdcX55DEljpdnI2a3PI1itPYryJKijUmtqxF9A5JBt9UzesBY1FeQ9Hb7vk+Pn0huf68XjvDva7+jjz4o2xpsf9vDho/9zJJZDGd29B+ltVJ/VwBRcHX3Uji/yStejxUdfW3KdLXBQ9ro7IXuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738701290; c=relaxed/simple;
	bh=iu18eYYQR4fLthqgNOhu/VAmwYelaQmKNYCEv86pKn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4CXL+rqF+zaFMnwGA7hnG0ztzdMjb+U5Umf1PIIm9h0gc5J5th5j/GjfaH3O2LGVp3PWjEGk3SLOgRlmUqlwMlksCVKKEpEKGD5VSAbNWYtCbS4tb5J7xcAXBxikxqxUztiXnsl4tVkzaxcGEEgnmgrS5Fvq21mx9FKeiHYolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=wH/g5+st; arc=none smtp.client-ip=81.19.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dso1EsGyxnhW5FWhayp/zMY4aUV2+LaYO3ijOICijXI=; b=wH/g5+strem6Fjbax6JIGuA4jI
	zAz+g1rjHx2TLNWIJccj9GLm/xwcXe9FkCI5BIZFy3yXAWoaU1WMs4Zn7YjJLn7dKfMhLeavUdNJh
	/pjcw3iMEz4nrkA+a8xScAmUKmcEE2XhzLwCPfjRK+kna7A46CgYgiZ/bdZ8qkKkDPPs=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfPNK-000000005UN-3Y68;
	Tue, 04 Feb 2025 21:18:27 +0100
Message-ID: <bd604c16-0f5c-479c-aa13-932f1570e5b5@engleder-embedded.com>
Date: Tue, 4 Feb 2025 21:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4] e1000e: Fix real-time violations on link up
To: anthony.l.nguyen@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bhelgaas@google.com,
 pmenzel@molgen.mpg.de, aleksander.lobakin@intel.com,
 Gerhard Engleder <eg@keba.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Avigail Dahan <avigailx.dahan@intel.com>, Simon Horman <horms@kernel.org>
References: <20241219192743.4499-1-gerhard@engleder-embedded.com>
 <20250106111752.GC4068@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250106111752.GC4068@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 06.01.25 12:17, Simon Horman wrote:
> On Thu, Dec 19, 2024 at 08:27:43PM +0100, Gerhard Engleder wrote:
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
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
>> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
>> ---
>> v4:
>> - add PREEMPT_RT dependency again (Vitaly Lifshits)
>> - fix comment styple (Alexander Lobakin)
>> - add to comment each 8th and explain why (Alexander Lobakin)
>> - simplify check for every 8th write (Alexander Lobakin)
>>
>> v3:
>> - mention problematic platform explicitly (Bjorn Helgaas)
>> - improve comment (Paul Menzel)
>>
>> v2:
>> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Is there anything left from my side to get this change over iwl-next
into net-next?

Gerhard

