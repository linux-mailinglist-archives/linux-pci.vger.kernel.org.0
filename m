Return-Path: <linux-pci+bounces-40715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD998C4788B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBEA14EFE7A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50A23D2B1;
	Mon, 10 Nov 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="aEij+ROR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697118A956
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788019; cv=none; b=CRCfQvRkzUts95OBtibvsZHrEJTmzJ5vJqkLbPdLrnVmOfNL3tU2EcV9RM/V/sSDyv6yCV0QOvjHDrXjlpUR8IEB3WDkA/Z5qQZQj+YKdN+wQ41B8LKEUPeshIPdnTJSz1xuacP+0mx6i7rlJZixwvdDkupThTmkH5ArdDeHEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788019; c=relaxed/simple;
	bh=sO2EwoD/iYNjfdcI7NveTHw7NYQaesuq9uoAsC4fvXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kVpTWK6qsGKqBh4UuMY0TcTnrb0W6iorF7UTYg0oQqBZh7u1MqwVeyDrbRw/Oi/xaT2ONaoY9/YJbdiQ6u0fd+HvzUqEHI6kTet8X+EUZM7Evn8iu1ruvdxDxLsi1sdjvX59Wn6cNMpyKHI8PMUAS5uwkbsnAe2tv5O34gL1Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=aEij+ROR; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43376624a8fso17941505ab.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762788016; x=1763392816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHqCJdsR7z6UGezYu2PLRy2EX3z1OohmVvws0HQYrFQ=;
        b=aEij+RORaRMFW8ONPGQ9MWQ2SIC99rnZNqHsx0buzMifST7WGMnZpAxk9MePnIjJAm
         z0Rk4mmyamAHdCvYKqA8ylg2mfS4aKsJ/rwSfqXDuQ0L1cPLsKVA43GTTTfSCR6xpqbR
         t1HLDL6Y2SkQGWyktQeaC0YOwa84kAizkyOKAsNGvicI9iaH4urPRZrVo8+FsCIDfTiO
         1P38R0DXg/HLhF6roXQbQxV/FuNuIaUEBlPrxshNCjcNbih4K1hSnyAwHuEolAMFRcqY
         rF+bFBf/XV4kL+gxrJKUuUgG59wW59TccqLxz0SO+BqLpBxD2G1LCVgI68AwKcn1YdUB
         bFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788016; x=1763392816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHqCJdsR7z6UGezYu2PLRy2EX3z1OohmVvws0HQYrFQ=;
        b=OChyycHrTWGWia6mpNyAg8fhIB55LF3XpOk51iwNAbFB5C3tyFLowHbmvBOhbl+qnY
         jgmvmwBFnHNXhjI1Jvsn5GH0prSW/4AgSnW/M3kOZfXfrVXMjIgItZ8eukj2/Db1/cPE
         63Hf2tSj3vN7BWmRwnNjh7rxQcatI6hJvIDHXSVwezfFbDekrJRfKGFDVKOaYUX4Z71M
         8xQVwJ4mONouDdeTyU5y19jFzxYFFVyLLkz9q7bTTn9jzMEaZ+HN0BaVeQGc5Z7N/BZD
         E299ro8LlCGvjDE4IIzBIP97Ha8MNevp6zv/j/62lpsA75yHrvj1dG6t9J052YaO15wz
         TekQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdL890lF0NYChrCrcz2CPWECfAjSujjEfCCFwR9uW7TV7sSUGRgm7p883zXYY76RBW3awsU5jRQuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF6pJHXLhJCk/4uubuOs9Ul9Ls54XRqs+Kdn/tFMofO4dmRSS
	PvhhHbysnuiV3CBk1MhIQbKddM+pkhWd+MIMBGle7Jq/h3o8p+eXsssQgL6fPidD0LY=
X-Gm-Gg: ASbGncsK85Bg+feJO6gb+16YoqHpNRsxyP0iBrvWW27BzGtDwmg/d0CPU/dQph7usVI
	7boYo1q7Co81EDP9UhAjHqwGMx2slo4ms/1IhfF+4GC+ngENHMdfw8/hKr9OkOxvY8VPz4d4oH/
	KPJMTaO9qRv8ABjo7tLCSVnoW8YuHT9xHGcHoYwUoEkq56dR/ISXzhDkyQq+iajmu5MZD15DpMc
	I+h3waFSDsLObrrLOf7zqGkF54Bq6j5mTFBw10+TtBOH3pBZoKXuXV5wylguJ5ukBkl2X1smeMc
	qTKyNzeporl5Ym3s1uN3WwSWmLHFg7ypc3UdQVVapofZilYhxhWp2yA6Q7w5ibBul8OwyGGCBao
	0ZlMZv7aCcJP2G+ghWBSO6DjVWn0YRRTPjgSlzi7Gqcuw9CHE/35IvlB8AdW0LsjBeP1ZQIXAYi
	WrbeWnOxW3dRlSw/2Lu/KsKMJbdM6lYgJ8WrX1uRo=
X-Google-Smtp-Source: AGHT+IEbu7UkRnaq1HAZF7KJE8mC7YX4IT4qsm04tHRZF/RRVkDmdBo8SVYWqOjog8FiLYEn3hk8pw==
X-Received: by 2002:a05:6e02:1aa2:b0:433:3034:e88 with SMTP id e9e14a558f8ab-43367e48c8bmr107760915ab.21.1762788016218;
        Mon, 10 Nov 2025 07:20:16 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4f5b90sm56357735ab.33.2025.11.10.07.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:20:15 -0800 (PST)
Message-ID: <66ab3a48-5d5a-47c7-b8eb-b477fd987314@riscstar.com>
Date: Mon, 10 Nov 2025 09:20:13 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, ziyao@disroot.org, johannes@erdfelt.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 guodong@riscstar.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251107191557.1827677-1-elder@riscstar.com>
 <aQ8kqIljwGZfkF8M@aurel32.net>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aQ8kqIljwGZfkF8M@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 5:08 AM, Aurelien Jarno wrote:
> Hi Alex,
> 
> Thanks for this new version.
> 
> On 2025-11-07 13:15, Alex Elder wrote:
>> This series introduces a PHY driver and a PCIe driver to support PCIe
>> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
>> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
>> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
>> one PCIe lane, and the other two ports each have two lanes.  All PCIe
>> ports operate at 5 GT/second.
>>
>> The PCIe PHYs must be configured using a value that can only be
>> determined using the combo PHY, operating in PCIe mode.  To allow
>> that PHY to be used for USB, the needed calibration step is performed
>> by the PHY driver automatically at probe time.  Once this step is done,
>> the PHY can be used for either PCIe or USB.
>>
>> This initial version of the driver supports 32 MSIs, and does not
>> support PCI INTx interrupts.  The hardware does not support MSI-X.
>>
>> Version 5 of this series incorporates suggestions made during the
>> review of version 4.  Specific highlights are detailed below.
>>
>> Note:
>> Aurelien Jarno and Johannes Erdfelt have reported seeing ASPM errors
>> accessing NVMe drives when using earlier versions of this series.
>> The Kconfig files they used were very different from the RISC-V
>> default configuration.
>>
>> Aurelien has since reported the errors do not occur when using
>> defconfig.  Johannes has not reported back about this.
> 
> Unfortunately, while it is true with v4, this is not the case with v5
> anymore :(

That's too bad, but thank you for reporting it.

> Fundamentally in the generic designware driver, post_init (which is used
> to disable L1 support on the controller side) is called after starting
> the link. The comparison of the capabilities is done in
> pcie_aspm_cap_init when the link is up, which happens a tiny bit after
> starting it.
> 
> In practice with v4, the link is started, ASPM L1 is disabled and the
> link becomes up. With v5, the move of the code getting and enabling the
> regulator changed the timing, and ASPM L1 is now disabled on the
> controller 2-3 ms after the link is up, which is too late.

Yes in v4, we relied on the root port driver to enable the
regulator, but (on my system anyway) that happened too late,
*after* the PCIe controller driver held PERST# asserted for
100 msec.  PERST# is not supposed to be de-asserted until
power is known to be stable.  So v5 went back to having
the controller get the regulator in k1_pcie_probe().

I am supposed to receive the WD Blue SN570 on Wednesday, and
when I get that I'll have a chance to try to reproduce at
least one of these problems, and can ensure there are no
timing-related issues like this.

Thank you for your continued testing and feedback about this.

					-Alex

> I have added a call to pci_info to display the moment where ASPM is
> disabled. This is without the regulator change:
> 
> [    0.386730] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
> [    0.386970] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
> [    0.387017] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
> [    0.387047] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
> [    0.387062] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
> [    0.400109] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
> [    0.490101] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.494195] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
> [    0.850344] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.950133] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
> [    1.129988] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
> [    1.335482] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.340946] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
> [    1.350181] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
> [    1.358734] pci_bus 0000:00: resource 4 [io  0x100000-0x1fffff]
> [    1.362033] pci_bus 0000:00: resource 5 [mem 0x90000000-0x9effffff]
> [    1.368289] spacemit-k1-pcie ca400000.pcie: pcie_aspm_override_default_link_state
> [    1.375967] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
> [    1.383043] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [    1.388927] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [    1.394826] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.400061] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
> [    1.406460] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    1.413245] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [    1.421012] pci 0000:00:00.0: supports D1
> [    1.424948] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.432718] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
> [    1.438698] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    1.445426] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    1.464897] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> And this is with the regulator change:
> 
> [    0.410796] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
> [    0.410836] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
> [    0.410889] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
> [    0.410917] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
> [    0.410932] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
> [    0.424651] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
> [    0.436446] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
> [    0.513897] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.559595] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.839412] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
> [    0.847078] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
> [    0.857600] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.868702] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
> [    1.146409] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
> [    1.373742] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
> [    1.380963] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [    1.386883] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [    1.392808] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.395394] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
> [    1.401811] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    1.408583] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [    1.416354] pci 0000:00:00.0: supports D1
> [    1.420294] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.428220] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
> [    1.434034] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    1.440772] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    1.463390] pci 0000:01:00.0: pcie_aspm_override_default_link_state
> [    1.467000] pci 0000:01:00.0: ASPM: default states L1
> [    1.472093] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> Note how the line pcie_aspm_override_default_link_state arrives too
> late.
> 
> Regards
> Aurelien
> 


