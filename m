Return-Path: <linux-pci+bounces-27284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E228AAC907
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76A45083BB
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEC280029;
	Tue,  6 May 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUfLRdwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8E255E37
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543817; cv=none; b=rox702KIgX7L/VjNeFf1HQl/NvOZDqI2n27VnDOpei+3NgBUjf1Etl/wQleuKeEFR5E4jGL1iuajk5nkH8MlS/NOg3yjhKurQxxFcuKJVEcjUtI+H4+wLFZMTntCZZftvCbXvf/XjBVm2DsEzPJE4mAMgOlXlRHysw/Osdrd9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543817; c=relaxed/simple;
	bh=uqjOHkZCL/zt6C0moxUa6bUQR0377CxgzSLQDGT2e/s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gvshpZnvhPH3lKVU36ea/i9nPXB1QC4Je0EeREK0+VTvBC/vTQlPmhAwQ/plzKrFSW1pBcNsb1V2kwdHSJOZYSRpiYbbZltaAOl8EKigCvgscgLRLhDqA1qRL7dSjCz910Prxpgyqb0J3H17ieLUxbl5zGvN++tqFWcOKLOM6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUfLRdwF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f861d16622so10013381a12.2
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746543813; x=1747148613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAr8rijhsB+/WBGv8V0DB6GGHRO/HlF67zAcvOr1M70=;
        b=gUfLRdwFPVq6oWUULZISaX0AaQ5fOV270GaiXHQNjXa0MWTz2C7nZp+LQg+o+3d55I
         Ps1EAbkcfQYzcqqIDoF5WreaiKoQxGn/V/NnVZp9Adt02O5fr3kxLsmoGlVOQ7agju/e
         WADoBnUphjp/VUmiDdX+Z+fFAN22yWqXWD96HuLT0zZbcQ3lP/mQEeKFK4rf2np2iAq0
         pLRbe17aZ+c6I7fkOqPwTceAADTYGQKTtwjjF6IVy8dO6hh+eTB+jqYZ9HlKkL1Ps7J/
         popHuQQZ3H/6aGUYS1r7ixTOgZhGWwLtqmKYmYIfa3P4B9GthYD+HJg7QoDJ9Yc1VhVp
         jMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543813; x=1747148613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAr8rijhsB+/WBGv8V0DB6GGHRO/HlF67zAcvOr1M70=;
        b=id+TjfLEZMJqaW7OpJHUWyeIsqQfc+3nLcCs5kAUEz+M4SICC0gQHuhzVdFvjO+n0p
         xyl1T4+JbBBtS/7/p04fAhVQ9v5T0EioXOTPkVTN0Adn/ukinnfSFqahEgCxN/jQf85J
         lEGL/9ZJDxkjRJXCcfDuyJc53U4yKQvSScb5b33MsOVN0633YzdLF+7Z4s4X/PiSrHWx
         zs/w+dWCpFFyAUlPFYRPYEjmtz22VNHz2U1OY+HXalmxMn6jLf/8gKiLozOyd9Ijq8Tl
         ZgLCUvsZykHS1uhtbuRufkLBJ7a4eDWj8MXP+MdZT1oUQuzNcPd7AnM6zGA3dTvFwdqt
         5UWg==
X-Forwarded-Encrypted: i=1; AJvYcCWeAO9RszEUkahcS4Wv6k2VOg7FsuUYLG69FiwJxev7NLHINmO1cV3QuK0sbgvrwu89dek+0lEpCk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMS8VrjGQJWGHF4FzTsM4hHcm2fGuTVnxjWhVN34YniN5YQJ6
	H29SJqk9QePQo2hMVls3JvUpLvJdtDNpuI9jAAZslWm0Is9JvPy19Eu+x2yr82Y=
X-Gm-Gg: ASbGncv5vrZ/my0kZj2+FifIFHCtEqnG8g0Z37czwxGrzGBSKIVoHXiZWRTDLgn8AIB
	zql79TZ4XKwU1tsRBM1yPInHW8Pw6feBjqjZxpNUTeZlCOmAVazQxCrDHHmwSB7J9Z7pzgYooQH
	eiW7JQrcDKmAJivlT842M17VyKIK2BZIkFlFajhr1oX3INDViYfs67Ik9THNWeM6OcDsnRAlYsZ
	spUNo/t05lyTjVhZJE8IWDldW5G7/vK8DBEBXJe4M/ek9ne75hCtSAPS+E7Vghl+kynMidylYrm
	F5RdON4McMpVmhyjCkFAcZHd9nOJCBO8Ofn2rpjlbSuYstDkJA==
X-Google-Smtp-Source: AGHT+IHKXrG7MW210zoA061o77YgCxufmlwobLpi0cswfVizvVYnxRI7NlJxwV0c9z+3Jw9Q0WirIw==
X-Received: by 2002:a50:c94a:0:b0:5fb:1fba:cd93 with SMTP id 4fb4d7f45d1cf-5fb1fbacdd8mr4486921a12.5.1746543813070;
        Tue, 06 May 2025 08:03:33 -0700 (PDT)
Received: from [10.11.12.107] ([82.76.212.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781bfa2sm7803407a12.43.2025.05.06.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 08:03:32 -0700 (PDT)
Message-ID: <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
Date: Tue, 6 May 2025 16:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

On 12/16/24 5:56 PM, Ilpo Järvinen wrote:
> Resetting resource is problematic as it prevent attempting to allocate
> the resource later, unless something in between restores the resource.
> Similarly, if fail_head does not contain all resources that were reset,
> those resource cannot be restored later.
> 
> The entire reset/restore cycle adds complexity and leaving resources
> into reseted state causes issues to other code such as for checks done
> in pci_enable_resources(). Take a small step towards not resetting
> resources by delaying reset until the end of resource assignment and
> build failure list (fail_head) in sync with the reset to avoid leaving
> behind resources that cannot be restored (for the case where the caller
> provides fail_head in the first place to allow restore somewhere in the
> callchain, as is not all callers pass non-NULL fail_head).
> 
> The Expansion ROM check is temporarily left in place while building the
> failure list until the upcoming change which reworks optional resource
> handling.
> 
> Ideally, whole resource reset could be removed but doing that in a big
> step would make the impact non-tractable due to complexity of all
> related code.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I'm hitting the BUG_ON(!list_empty(&add_list)); in
pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
pixel6 downstream pcie driver.

I saw the thread where "a34d74877c66 PCI: Restore assigned resources
fully after release" fixes things for some other cases, but it's not the
case here.

Reverting the following patches fixes the problem:
a34d74877c66 PCI: Restore assigned resources fully after release
2499f5348431 PCI: Rework optional resource handling
96336ec70264 PCI: Perform reset_resource() and build fail list in sync

In the working case the add_list list is empty throughout the entire
body of pci_assign_unassigned_bus_resources().

In the failing case __pci_bus_size_bridges() leaves the add_list not
empty and __pci_bus_assign_resources() does not consume the list, thus
the BUG_ON. The failing case contains an extra print that's not shown
when reverting the blamed commits:
[   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000

I've added some prints trying to describe the code path, see
https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#

Failing case:
[   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
0x000000 PCIe Endpoint
[   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
0x00000000-0x000fffff 64bit]
[   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
pref]
[   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
[   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
list empty? 1
[   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
[   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
[   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
[   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
[   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
[   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. list
empty? 0
[   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
__pci_bus_assign_resources -> list empty? 0
[   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
0x40000000-0x401fffff]: assigned
[   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
__pci_bus_assign_resources -> list empty? 0
[   13.952634][ T1101] ------------[ cut here ]------------
[   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
[   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 [#1]
 SMP
...
[   13.976086][ T1101] Call trace:
[   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
[   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
[   13.976628][ T1101]  exynos_pcie_rc_poweron

Working case:
[   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
0x000000 PCIe Endpoint
[   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
0x00000000-0x000fffff 64bit]
[   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
pref]
[   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
[   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
list empty? 1
[   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
[   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
[   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. list
empty? 1
[   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
__pci_bus_assign_resources -> list empty? 1
[   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
0x40000000-0x401fffff]: assigned
[   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
__pci_bus_assign_resources -> list empty? 1
[   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
up, yet(s5100_pdev is NULL)
[   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start


Any hints are welcomed. Thanks,
ta

[1]
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/setup-bus.c?h=v6.15-rc5#n2500

