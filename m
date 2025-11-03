Return-Path: <linux-pci+bounces-40127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CCC2D427
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24049421D66
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B733191D6;
	Mon,  3 Nov 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LUMGZJcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239C3191A9
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188150; cv=none; b=Lkrh1Rs9MowE5E4BT2XXYwK1iB8MBl86rV8DQPO4ntR+3r3bGByEzysKjmLcPsb8RElfJdnuR8t4No8QDfvJhrW7F34lzktvjJnOJ3ncqtwMi7fLZ4uvz7JUGvfs6beHcyHlWIzrOUzMwGF6KMv4MG/fvNY8Wq1+EQ8B7USGzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188150; c=relaxed/simple;
	bh=OcaI3qwgeTCF0BR+/oUJ3XCKZ1BAXfflSEB1AM9BxUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk12eztRmBuVVWN9kkMn45W7y5gLIiC38HVeroui+lo/3t0ZuLPYBR1zfdCUnTdgyh0BqpbshVbiQlYmwqnhSHSGhTYbUwSTHfN4AS7BeMll+IOlG5S5Xhvn7ZpaVS6EApaN+tq1cU24T9uAOx1PbRim9PToFJgL6leLA5BgND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LUMGZJcv; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-4331e9cb748so6805985ab.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 08:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762188147; x=1762792947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHeoDcWtrtw4Kqs9i7E9yy2tKQ26ZOwu5ohkUo50ijM=;
        b=LUMGZJcvYHB/ArPfDS6VkpidsCPOQkpUlqp5pfcS1zS31//7Gi1OVZt+udAvPCi36P
         be1c8XkF1FWzaRXVWdXDV0XgI7jf7On9pRLrd49SyqHENeMe5lugWD6VGE4Cjgh8moTV
         PAq2+RNms5vqY6bj881XTXl7ado/tgfjZn7QyP1FaTyKw8tO3CCsNC9oIr+axWIr4zmo
         W71je95IVLzv8OeyTQ568tdHll/jDHiFuuWxuDvTf4cvU7RCTxilm69UDC8MQ1eVJsxI
         Iy+XfYzuZXT9Q/aVLAJUhAG8g8FPkfc80lMdoXHtqeVtwhdwbbm2EjhFu7M+q3wIKGNn
         Jvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188147; x=1762792947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHeoDcWtrtw4Kqs9i7E9yy2tKQ26ZOwu5ohkUo50ijM=;
        b=I69X8y6K61ofKbzjWfUNKZ3QJuhTkwUSGCRE15GMZPs3ueMjFaH0Lu6TPpcU3sVBzV
         sFegDJiwLSn97JdjPe0FqvCy3977CSSsyX5VjqtnHKR/f8OCEqIyIaSbq5JSf9/30MQa
         r83v4uxxZCelBVZvJQhmh0M6w6bGeAJY4yM0SK88AIAWgK53bx4JPtroS6GRFKieVwVC
         EmoSB4RoDzK9BPQd9ldsCIpxxNoGxkAWrCs8M4CxDQX+LdvqlGBUvK0eO0ZEZI5GKjzU
         mQrquDAtTd2LU2AXOGiAVpZHw/GHkt4WZeOkdQ5TPBkCQe3e6a7kv9eUkHXUnnJQ2LSt
         AxXA==
X-Forwarded-Encrypted: i=1; AJvYcCWT9ijqU7RJ5D11YeOc1GtIKjASkP8Ktvol8Jrx/tZEJHw72NGjCKtZas2AugmUJcKOo5FGNkxdcuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCO5mO+tDxoqGt2CWA4ajM64IVqjrEnarRzD2boxIr9MieY1Bm
	Yx5RlnpNxbYFYEV2Zl/pzT5ORGgVkw/xIKZlITtN+nhQXO7Afedy8fMEVM4/9Egy8Gs=
X-Gm-Gg: ASbGncs5ehuUdwvSW0cuKk43Ts+RGw3ym8qKBuIVpGoYAuPKnAjHWOCmjHt8GcBb0mr
	DMC+7w2F2Aa0dlkd9U9p0QTs6p9lS2QvhFKo7s18VRMXrjQ7WwWF5U+6p403UDOSr1DTJhS3w5P
	xnNDs5uoO8cfESULFJqMTAx2W53cRDxCw7+wbGn6fQvw4YnnAmP8lhNOLQpRT1+eewLAmpyHVpv
	lIoki85ZNw3nKpYZcUgeywetEZEXhvlW7txYlXfdWGoEBzWhPUDEWTEYvIUvgk/acjNqajWWXC2
	oB1EzLR2/0aUEfnDbNOnwOhxpBUoq57NmczRj1NRuXV3aWV4BsUcQeAXhh6sPjoYWxfmtvIJy/n
	oqj4Xx+oXu3dnTdA7bFxRGCVmLwonU5SIBBsxT9LAn/xuHxgFlTW+WTWaCfA04EMWHnBxTJuSPD
	TXmDtPsEZEnf4jS5gmBQfc8XLFGSNlmGwiwWRLgoz+
X-Google-Smtp-Source: AGHT+IHkHY4VTZ7p5OKjtOgXuNnn4x75Ilvl4YEJ6q5B/6x6J8/6eBwuDTFeeDgt2AKvux4z5rFo4g==
X-Received: by 2002:a05:6e02:4603:b0:433:229c:351c with SMTP id e9e14a558f8ab-433377fbe1emr622165ab.1.1762188147419;
        Mon, 03 Nov 2025 08:42:27 -0800 (PST)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7226f55edsm334467173.59.2025.11.03.08.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:42:26 -0800 (PST)
Message-ID: <35da84ab-5104-4fee-a7ea-4f3d42f7344a@riscstar.com>
Date: Mon, 3 Nov 2025 10:42:23 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: Manivannan Sadhasivam <mani@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net> <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
 <20251028204832.GN15521@sventech.com>
 <5kwbaj2eqr4imcaoh6otqo7huuraqhodxh4dbwc33vqpi5j5yq@ueufnqetrg2m>
 <aQOlMcI9jTdd7QNb@aurel32.net>
 <ywr66wfkfay3xse77mb7ddbga5nced4yg7dapiybj3p2yp2an2@7zsaj5one5in>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <ywr66wfkfay3xse77mb7ddbga5nced4yg7dapiybj3p2yp2an2@7zsaj5one5in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 1:10 AM, Manivannan Sadhasivam wrote:
> On Thu, Oct 30, 2025 at 06:49:37PM +0100, Aurelien Jarno wrote:
>> Hi Mani,
>>
>> On 2025-10-30 22:11, Manivannan Sadhasivam wrote:
>>> + Aurelien
>>>
>>> On Tue, Oct 28, 2025 at 01:48:32PM -0700, Johannes Erdfelt wrote:
>>>> On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
>>>>> On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
>>>>>> I have been testing this patchset recently as well, but on an Orange Pi
>>>>>> RV2 board instead (and an extra RV2 specific patch to enable power to
>>>>>> the M.2 slot).
>>>>>>
>>>>>> I ran into the same symptoms you had ("QID 0 timeout" after about 60
>>>>>> seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
>>>>>> seems to work fine with the "pcie_aspm=off" workaround as well.
>>>>>
>>>>> I don't see this problem, and haven't tried to reproduce it yet.
>>>>>
>>>>> Mani told me I needed to add these lines to ensure the "runtime
>>>>> PM hierarchy of PCIe chain" won't be "broken":
>>>>>
>>>>> 	pm_runtime_set_active()
>>>>> 	pm_runtime_no_callbacks()
>>>>> 	devm_pm_runtime_enable()
>>>>>
>>>>> Just out of curiosity, could you try with those lines added
>>>>> just before these assignments in k1_pcie_probe()?
>>>>>
>>>>> 	k1->pci.dev = dev;
>>>>> 	k1->pci.ops = &k1_pcie_ops;
>>>>> 	dw_pcie_cap_set(&k1->pci, REQ_RES);
>>>>>
>>>>> I doubt it will fix what you're seeing, but at the moment I'm
>>>>> working on something else.
>>>>
>>>> Unfortunately there is no difference with the runtime PM hierarchy
>>>> additions.
>>>>
>>>
>>> These are not supposed to fix the issues you were facing. I discussed with Alex
>>> offline and figured out that L1 works fine on his BPI-F3 board with a NVMe SSD.
>>>
>>> And I believe, Aurelien is also using that same board, but with different
>>> SSDs. But what is puzzling me is, L1 is breaking Aurelien's setup with 3 SSDs
>>> from different vendors. It apparently works fine on Alex's setup. So it somehow
>>> confirms that Root Port supports and behaves correctly with L1. But at the same
>>> time, I cannot just say without evidence that L1 is broken on all these SSDs
>>> that you and Aurelien tested with.

Aurelien, can you please confirm that your reports are with the BPI-F3
board?  I believe you identified the three SSDs that were failing.  I
am considering buying one of those models to see if I can reproduce
the problem and troubleshoot it.

>> It could be that we have different revision of the BPI-F3 board, it's
>> not impossible that I got an early-ish version. That said I just
>> visually checked the PCB against the schematics, and the devices on the
>> CLKREQN line appear to be installed.
>>
> 
> CLKREQ# is only needed for L1 PM Substates (L1.1 and L1.2). In other ASPM states
> (L0s and L1), REFCLK is supposed to be ON. So those don't need CLKREQ# assertion
> by the endpoint.
> 
> The L1 issue you are facing could be due to the board routing issue also. I'm
> just speculating here.
> 
>> If someone has contacts to check what changes have been done between the
>> different board revision, that could help. Or same if there are
>> different revisions of the SpacemiT K1 chip.
>>
> 
> I hope Alex can get this information.

I have sent a message to SpacemiT to explain that these issues are
being reported, and asking for any useful information about the
BPI-F3 (including whether there are different versions, or different
versions of firmware, and how someone can identify what they have).

Thanks.

					-Alex

> - Mani
> 


