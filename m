Return-Path: <linux-pci+bounces-25067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C2AA77C0E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD28F168107
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F02E339C;
	Tue,  1 Apr 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKTDNNcG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F3204089;
	Tue,  1 Apr 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514135; cv=none; b=cDiWKQF8vyNI9e6rlCSTrT4+YBBO753xzM4FopFIi9VRLOKVOmK7meLYAVcxPCplAnfv3fSKJk4PzgE3qSjyl0ItcmZMo150vwhgmIJ6aDe0xK9K1fwzATG6d/ZQjHrochSQ9nDZHEN9V1BY/v9zCPanLXr7ELlmdC0Md82h2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514135; c=relaxed/simple;
	bh=LRUD8Nzyi9W7a4tbKtk1hsca0RI3QWp1jje0ZMgNtSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdDoehsOUBccYa8CnQiLdH2S58ivNfwHHPh0qmKEAcH50HznxL/GO3nmkGEpi8kffcHpQDPJGK5TFxyb5FRDZclSVYusdjpih8CSKOViySikQY/Z8//oQylYRHMhnvKWIH3yE8ypYV+03UiRfeDLee5/yKCoeK2S68Xhs/pISCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKTDNNcG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-226185948ffso106816305ad.0;
        Tue, 01 Apr 2025 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743514133; x=1744118933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x7pqqNqLdsO7AFB2RRAVziq6nIvwLDvTSY85H4YFNog=;
        b=LKTDNNcG1cPQZvyfzkD0hFNWUMqj+amBJUX1kuLvD+Ym7wEoFY9O5uVAHu0Ii5qMqM
         AOGAmwFEfJJamzW3qmu16P9s1Oe8UoKmmKdMvEweqrg4VqqciyHePFZeFdg5SEnZe2++
         cnvYeyI9ynQU+cySOCPRI77b3vM04qLcj6nWIcttWDjfS9+hueR7T0lrHebI7Zvwcsik
         bUBNVlX+UyM3M1Kz2YbhpeGvVM8Ibuwf9wj2MCQ/FDz0l5JAsfRPVHTtsVvkTFMdxt1r
         9t6pqcoDmUolSj22Do1/3IBr3SYEPL0N6RLD1mUefQbw6oYNA+Y+ktFPHhfnryUnVSTO
         o4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514133; x=1744118933;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7pqqNqLdsO7AFB2RRAVziq6nIvwLDvTSY85H4YFNog=;
        b=QpRD5eGX2QkH3SqS6e2NdNLk9MILaFRS9mHqfgi+quwZZfPAjwDFvFcTsIJwAI50eV
         YAVU63u3p3wWjom2oFOT0oiL1v3bh5ChM7ZIozMfVZ/JoCnbtLPCX7Gv6bQNLfp8vi8Q
         rrqF1MG/MGlSI/zUjmvuB+UvhttLUV5TjjlkliLEeQcoPEa4xinpMpjN0joSQYzv7ARD
         mynog9wcWfQh+AjlleV89dCazGbA1cEWXKlfrBRMDiLUcY6LUoVROVJusXqae16a706w
         WZ/h1eMhZS0cERKnNJ3167CaQlwq4+UZUUuRixAkiw6BBeORkRtceerUlKtJh+rMfeTA
         dspw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqaDWeU0CuQbzAfS2X0+XkjWT5wyNICnugCRxj8Eagxa3IO+JVkF8iHy9w+G0lFiiK6CFTdHLwGINh2o=@vger.kernel.org, AJvYcCW/VF1InIW5LDguVVAQ88+buqzeOdor90rGkEYCOyiRSOjBmileU3RvAhJsVR8+Z1KI3Ua9Mho5Lqkt@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSnSPg65Zlrn3iqGcj12JOUcXrOsOsBFgdrmkTNesbznyDD1x
	qtsTMSd/Hy6UQEoWgnc89UGOXqeF4//Ss+06BgKg4TetzwCww1cF
X-Gm-Gg: ASbGnctu25OgWehfR8ZdNP0u8QUam3X8vRNTdZUXeBddlmlaanUGQwcPuHev/P1Ovgy
	47sj1RtKsE0NFLf6pnr7HA1Q2Ftnky4x2KlB7cYs7n6EA3XLYKY4oKRAX/O2C8+Vk/fJKZ/U5FK
	ihuREG92Ol8rwoQJh2/hJTpGA3G+FbNe7HwXvX8Yz4XxFRktR6KxlJrNFpMXI+esF7sgJCCOd80
	z1TtRmaLKR69BicR89/61fKOzl7ebmHd1+vpWySpz6nGos8mqgQfWvfyrmFwvAFbMSOzMwXKdXT
	AlHlFORwP/dRETeqm8Yz8pE7a2aDCWsKZI2P0HGJwZEuSplTm64QJor1/Q2DjiAE7naOBEDOth7
	tTi3Vgb+nUCYHEq4mlQ==
X-Google-Smtp-Source: AGHT+IErc+jYYI2mveDqcDFVaMlPhYKS6RgfSxTuNffIzFrB71vBmH4dFtQozhG41bbPH4PCFLQGmQ==
X-Received: by 2002:a05:6a00:ac3:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-739803c0672mr15799848b3a.14.1743514132894;
        Tue, 01 Apr 2025 06:28:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deed76sm9113085b3a.11.2025.04.01.06.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 06:28:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e54e87cb-5f40-4e7e-8f88-fb08746b701b@roeck-us.net>
Date: Tue, 1 Apr 2025 06:28:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
 <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/25 03:18, Ilpo Järvinen wrote:
> On Mon, 31 Mar 2025, Guenter Roeck wrote:
>> On Mon, Dec 16, 2024 at 07:56:31PM +0200, Ilpo Järvinen wrote:
>>> Resetting resource is problematic as it prevent attempting to allocate
>>> the resource later, unless something in between restores the resource.
>>> Similarly, if fail_head does not contain all resources that were reset,
>>> those resource cannot be restored later.
>>>
>>> The entire reset/restore cycle adds complexity and leaving resources
>>> into reseted state causes issues to other code such as for checks done
>>> in pci_enable_resources(). Take a small step towards not resetting
>>> resources by delaying reset until the end of resource assignment and
>>> build failure list (fail_head) in sync with the reset to avoid leaving
>>> behind resources that cannot be restored (for the case where the caller
>>> provides fail_head in the first place to allow restore somewhere in the
>>> callchain, as is not all callers pass non-NULL fail_head).
>>>
>>> The Expansion ROM check is temporarily left in place while building the
>>> failure list until the upcoming change which reworks optional resource
>>> handling.
>>>
>>> Ideally, whole resource reset could be removed but doing that in a big
>>> step would make the impact non-tractable due to complexity of all
>>> related code.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> With this patch in the mainline kernel, all mips:boston qemu emulations
>> fail when running a 64-bit little endian configuration (64r6el_defconfig).
>>
>> The problem is that the PCI based IDE/ATA controller is not initialized.
>> There are a number of pci error messages.
>>
>> pci_bus 0002:01: extended config space not accessible
>> pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
>> pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
>> pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
>> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
>> pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
>> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
>> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't assign; no space
>> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed to assign
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
>> pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign; bogus alignment
>> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff 64bit pref]: assigned
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
>> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
>> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
>> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
>> pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
>> pci 0002:00:00.0: PCI bridge to [bus 01]
>> pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff 64bit pref]
>> pci_bus 0002:00: Some PCI device resources are unassigned, try booting with pci=realloc
>> pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
>> pci_bus 0002:01: resource 2 [mem 0x16000000-0x160fffff 64bit pref]
>> ...
>> pci 0002:00:00.0: enabling device (0000 -> 0002)
>> ahci 0002:01:00.0: probe with driver ahci failed with error -12
>>
>> Bisect points to this patch. Reverting it together with "PCI: Rework
>> optional resource handling" fixes the problem. For comparison, after
>> reverting the offending patches, the log messages are as follows.
>>
>> pci_bus 0002:00: root bus resource [bus 00-ff]
>> pci_bus 0002:00: root bus resource [mem 0x16000000-0x160fffff]
>> pci 0002:00:00.0: [10ee:7021] type 01 class 0x060400 PCIe Root Complex Integrated Endpoint
>> pci 0002:00:00.0: PCI bridge to [bus 00]
>> pci 0002:00:00.0:   bridge window [io  0x0000-0x0fff]
>> pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>> pci 0002:00:00.0: enabling Extended Tags
>> pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci_bus 0002:01: extended config space not accessible
>> pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
>> pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
>> pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
>> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
>> pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
>> pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
>> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't assign; no space
>> pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed to assign
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
>> pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
>> pci 0002:01:00.0: BAR 5 [mem 0x16000000-0x16000fff]: assigned
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
>> pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
>> pci 0002:00:00.0: PCI bridge to [bus 01]
>> pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff]
>> pci_bus 0002:00: Some PCI device resources are unassigned, try booting with pci=realloc
>> pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
>> pci_bus 0002:01: resource 1 [mem 0x16000000-0x160fffff]
>> ...
>> pci 0002:00:00.0: enabling device (0000 -> 0002)
>> ahci 0002:01:00.0: enabling device (0000 -> 0002)
>> ahci 0002:01:00.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
>> ahci 0002:01:00.0: 6/6 ports implemented (port mask 0x3f)
>> ahci 0002:01:00.0: flags: 64bit ncq only
> 
> Hi,
> 
> Thanks for reporting. Please add this to the command line to get the
> resource releasing between the steps to show:
> 
> dyndbg="file drivers/pci/setup-bus.c +p"
> 
> Also, the log snippet just shows it fails but it is impossible to know
> from it why the resource assigments do not fit so could you please provide
> a complete dmesg logs. Also providing the contents of /proc/iomem from the
> working case would save me quite a bit of decoding the iomem layout from
> the dmesgs.
> 

You should find everything you need at http://server.roeck-us.net/qemu/mipsel64/.
Please let me know if you need anything else.

Thanks,
Guenter


