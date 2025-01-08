Return-Path: <linux-pci+bounces-19483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF2A04E0D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 01:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFD9162B66
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E18F4A;
	Wed,  8 Jan 2025 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpkha2qb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF91C32;
	Wed,  8 Jan 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736295337; cv=none; b=akI4Cw2evkro4KvaCConab7BSkwViVqcJoSTIvG4tajMubUuKqUalpiq+YZl2jF9P4+jgoGZM1UuY/qgTjTwGr0OEq+FWhnRRRBwzHjDcmvtkHO3Ru2K/RBV8YVhLmdTDRGai/B95fJu0EN/PJe8ENpxkW1YZaec84fIQ/5LcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736295337; c=relaxed/simple;
	bh=gNEeawsiac4VKl/86azPPZP/FUegmt4bJi7RQQ4M0Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a70RGIf0/zhPi9G/gPaQ6yjVf9LPts8K1TyyjC4E2RNkAzcocyXrjIrY/ug6ome0EFQMfSWSQQf0CL+IRNiMow11GFgoPUKybDsM+o0TyZPDGTwtUuTTwCmEtu6FwoeAaNedZPIUeoDVf4nOENWGFXcxr8h7vsH7ZLOf2O4wjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpkha2qb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso116789145e9.2;
        Tue, 07 Jan 2025 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736295332; x=1736900132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMhFY3lT4PFtVPSjGg0V0kQ8HZHT0tFEJn/9NrhH5jQ=;
        b=gpkha2qbChn2q4pkwKzBrgFaXVp2E06+WpInBNRkKT09cv1Gw9t5bd6pQySPeedhM2
         frm+h3aO11NvF1/bnoyLi3dBePnHwDao+dN9f1DShrltytzJLQ/cTVvKQHT0iMcHiuzW
         92m2tA14v/EjwV2utx5eNQu/x4V1ZbPlkK+5chSIYXrKyGc4w6Ee0bdltGvHNBu8CIgI
         MVstIqAoSXWr0R7D2Eubc1xo+wKWydTQHhoAZToTy7z8j4GKCOR46VvjxyavX0We/tLp
         JFubhvdxYMPdv4xJG2P7oQOfCRTnD3zDRn9+BtfvPHPNdzVlmqv9Yh9nDLNxxpWPppaC
         fqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736295332; x=1736900132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMhFY3lT4PFtVPSjGg0V0kQ8HZHT0tFEJn/9NrhH5jQ=;
        b=gSztn23st+Q4ud2Ri51WBQ2Q2XLQV3nSBibGMuS1NKMj9gK7MDIUj1Q1aZcB7fttWm
         R3Sb1Sly8wGXtMjUN0L5AEmkkVJ+E0jNZ8GSw3kwjA3D992RC9mjOa8k9owPZW/0ctXO
         +t2fgJHxUwJV4E9EWapu51T/pvL4xvL1W8gLqxIQFnmDAHnj5EkoINTk50EvYjiD2LUF
         gtMHxqdQp0LJULCZTaVeeJIQTqeLlmPLcaRLz+FKySgmtUcKGsyLVT6tmhvprR5pY1BL
         yr3diEIbNV1Pe7JUkJvGiAfg9w+m0Rrq3y/xV1aXhWPQjH8gAW7ijXGdFL/XVWT+zVle
         6RRg==
X-Forwarded-Encrypted: i=1; AJvYcCUpJVAdaCtMcdWv6H+Xu3RZkSjysXkAuhz7qIDvzKNzhGp/0BnNmZ501bNq5WYKkljDV1JS6DdK@vger.kernel.org, AJvYcCWVklb1QE18Jrlmxskl4ud43OOLLYR/AL9+4eZXDvD6syXQraYX5UOKM+Gtkh25bwv4rCRca6LZvelM@vger.kernel.org, AJvYcCX/L6eBef62Ixc4GNpq/BJFC2hIfrgvQ7GtcKrGFFQFkcp1CdL2VWa0DRepecY2fJqpRQqpdRVboAeHkgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNcuQkxJDK0KUGCIPEfLZs81zEtgSZelLDkzVRPCd7dbVGLco
	nYa6jSSA6+D9wpXk3/CciwlK2jm8JrVqJsQSNtctpgEcOwiDgVAt
X-Gm-Gg: ASbGncv1nIxkb9RWRk/CiuOU+Cwka/9tS1qzXJj4D4NxilerJLkKaOHVdDrdnMWfcFb
	xj4z22S6xx7oMWXvuInwgfGQaH6yXnUzQtUxrsFh8IXq55QsfJU7AvX9WgkD17V/ksfNSVPdm6f
	K401nfgGJIckiIIifUcS4P9JrBGmQ1UaeXv5jzT9lLA/sT4wUyolZusvWYVybMOJf5B2q+Cib8o
	lXWvJ3bJRQuNDafmrfuzvCeG42cG2b2T/SzKzpzqHNMzAmKk8+5ZbnY4A==
X-Google-Smtp-Source: AGHT+IFNakxXpIWxwpOH+C54E8szUih4RKypDRwYeXrLQdNiuOP6e8EmlZpFXZ/glbOx9m/7hHCgWQ==
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-436e2551d7bmr4780915e9.0.1736295332004;
        Tue, 07 Jan 2025 16:15:32 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da74dasm2649855e9.2.2025.01.07.16.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 16:15:31 -0800 (PST)
Message-ID: <c634d5bc-7a60-436a-94d8-c8a4fb0e0c26@gmail.com>
Date: Wed, 8 Jan 2025 02:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250107234530.GA191158@bhelgaas>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20250107234530.GA191158@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 08.01.2025 01:45, Bjorn Helgaas wrote:
> On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
>> On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
>>> Currently, the driver is seriously broken with respect to the
>>> hibernation (S4): after image restore the device is back into
>>> IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
>>> full re-launch of the rest of its firmware, but the driver restore
>>> handler treats the device as merely sleeping and just sends it a
>>> wake-up command.
>>>
>>> This wake-up command times out but device nodes (/dev/wwan*) remain
>>> accessible.
>>> However attempting to use them causes the bootloader to crash and
>>> enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
>>> dump is ready").
>>>
>>> It seems that the device cannot be re-initialized from this crashed
>>> stage without toggling some reset pin (on my test platform that's
>>> apparently what the device _RST ACPI method does).
>>>
>>> While it would theoretically be possible to rewrite the driver to tear
>>> down the whole MUX / IPC layers on hibernation (so the bootloader does
>>> not crash from improper access) and then re-launch the device on
>>> restore this would require significant refactoring of the driver
>>> (believe me, I've tried), since there are quite a few assumptions
>>> hard-coded in the driver about the device never being partially
>>> de-initialized (like channels other than devlink cannot be closed,
>>> for example).
>>> Probably this would also need some programming guide for this hardware.
>>>
>>> Considering that the driver seems orphaned [1] and other people are
>>> hitting this issue too [2] fix it by simply unbinding the PCI driver
>>> before hibernation and re-binding it after restore, much like
>>> USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
>>> problem.
>>>
>>> Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
>>> the existing suspend / resume handlers) and S4 (which uses the new code).
>>>
>>> [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
>>> [2]:
>>> https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413
>>>
>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>
>> Generally looks good to me. Lets wait for approval from PCI maintainers to
>> be sure that there no unexpected side effects.
> 
> I have nothing useful to contribute here.  Seems like kind of a mess.
> But Intel claims to maintain this, so it would be nice if they would
> step up and make this work nicely.

Suddenly, Intel lost their interest in the modems market and, as Maciej 
mentioned, the driver was abandon for a quite time now. The author no 
more works for Intel. You will see the bounce.

Bjorn, could you suggest how to deal easily with the device that is 
incapable to seamlessly recover from hibernation? I am totally hopeless 
regarding the PM topic. Or is the deep driver rework the only option?

--
Sergey

