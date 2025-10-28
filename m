Return-Path: <linux-pci+bounces-39571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B703C1692E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4DD4E1118
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2234EEEC;
	Tue, 28 Oct 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="HuXNwIYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06834F46C
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678631; cv=none; b=Y7irIC1mdWQVrckTI808/HolqFhbklUSk9ndLS3Cjsx2bN6YZFeZS0dlrlRBcuiKaFHTLVv1bBwPVwykYnsDW48tIVEJwiceR/0mvPHO2KEW+myEjkNV9bJ7KKTVk0HS75tIT6WueQ20rX8koHXaGxMpHJ+yLFvBUb31PoV6gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678631; c=relaxed/simple;
	bh=3OjBoUivvl+zOanIxYssWUPcoRgm2RdCmKqy3cG34n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uLyCmEOCRjErKJzEZ8L8o8qTZoj3E7HMc6bh+tvc1XiAG35lXoIaZePiAOY9Ee7N2wFghyM5ccuX2Y96XEyULgjZ5l8AK/w4HdWlwmFBuSX0h3EgqNSKeQ+x050Ij+uHD9CoIEYICg5uOdzpy76JCfEzTQ2FA3//WwusZGZuipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=HuXNwIYb; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-93e7c7c3d0bso652609339f.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761678627; x=1762283427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvGdMAKfZ7Ml9MAZLdEsRbNSkR6vsJo2X4G5HAZ0rWo=;
        b=HuXNwIYb7ieFCsPT3ncvYapfVqyBZQ7/hYMus6hbH1eZVBMJ2g9khFx4X7TFPmulwX
         G/F7TDJ/Hz3UkMnGZwhRsXtRFjUrYIXOSxUAtVbEYWJpjd3mU/SyoSGhnWgj4nzeg1sg
         Jixx9lgChjoXSdoQunrzblHwL9M0aBFgidKxY2cgQa2gdHNCQjVDtl6BS6XOLDUJFu2V
         KFe+RQsmoyQgZXjQDznOKy9NO9dKidz1vHgZRAl7xW+a7ou22dzAaXtQZ7mlUrBkWRPS
         GwGfltOT+A/1N9B681+ajGc6bntFcgIOlgzoISOpjYh5sLkaR6SWA0jMYme7/tHIGgAW
         SCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678627; x=1762283427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvGdMAKfZ7Ml9MAZLdEsRbNSkR6vsJo2X4G5HAZ0rWo=;
        b=ghd9MxRMYht29bDWneT4oBAOXvKGrxfNRiNXqpXibiLwdsit7JXS2IWEGSo77XJ+c0
         QV9amoP/EhWXRwivV7jEnhyoNV+g/Lk8NXrZpwBW1UquSuYV1lPpVOuOdKfOMwu98A87
         BffR7tn3HeABkl3DbmpOaZPjFylAmqg508y9BjE9bfnZ3yTMYYXra8i3iqMCYSTZu9VF
         wi3rvaVBwH7M86P7wqZMfo6VJ+tn6HceJBGLiQrWNQGYQapx9osPRezD9/hUSGY6Mqni
         HJ13L0rogMkIydrNRWnJBdF2k3eiJAeQKyfW1K9uUk/hW4cxRmOMzu7i6ZTOsR/JXzbk
         C3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBbCBn9eWj1wGH28MXLaL1P7PNMaA9xh4t1MAMNaNPANBJ6p7Pa6pqBnQviOiJiHlyX3VQTE2XPss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaRitvMi6dreklBzPb+7G7zI/2tYsBeHhYcb2+OhxihEU7jI3
	DFv6YTRFt6Rdv0rSxBSFqCHXsyNLAyJQpEsjbNGsmK3OWPcV6bSS9Cjm2qumqWzQcwk=
X-Gm-Gg: ASbGnctFgBCBHiTm+DLJoi6EfnhPVgKm+RM8cg7HxBLPnhjX9K+46U7vQlMneNnePw1
	pA/sAoANLKPAHoEVxTr3zbYucohcteM6PQQhL9M1U/4R9PU/UFlhy2LOnIZD9SpBKGp4itcTCLZ
	eExHxDDNYU5feASWe9yZeKcttnmDpi+hOeMgRlrgKShWSTUmANOwPx3Ml3vkPUkHq0Hz1ss7OKV
	USqL9LR/JeFvW+PN+FMJwcjBcpaPHcEUKaJaKGLCbZ1vkq0eGZhMUI3u4VUimexhc7g9bKvMCuu
	UntSiv2eOrS/PDBvWQAi1x7iK8Cy+wh7VX18Qoou2D0PEVrQT1+HLUfBSjdCrRwcqyFC4GfdQcn
	3Fl7dJr2sfiCDP9GSphmGeI+U5GuPxMyx6opJeWYi8syuxBRmAm71/svHQc9k3ZITZNpMG9Kc65
	OOnfNuMAdnU0OihSwSMfEIw3KLPV/xKwEWI3gT9mSt
X-Google-Smtp-Source: AGHT+IHKuwmELl5wvSW4I+FHrhUsBFKFYIw0+cikEGfn2t/jK11qnrH+VrvEbMUJ5F8utuhwE/grRQ==
X-Received: by 2002:a05:6e02:214f:b0:42f:9560:f733 with SMTP id e9e14a558f8ab-432f8fad5c3mr5106075ab.13.1761678626721;
        Tue, 28 Oct 2025 12:10:26 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6899e76sm45826615ab.34.2025.10.28.12.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:10:25 -0700 (PDT)
Message-ID: <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
Date: Tue, 28 Oct 2025 14:10:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: Johannes Erdfelt <johannes@erdfelt.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251028184250.GM15521@sventech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> On Tue, Oct 28, 2025, Aurelien Jarno <aurelien@aurel32.net> wrote:
>> Hi Alex,
>>
>> On 2025-10-17 11:21, Alex Elder wrote:
>>> On 10/16/25 11:47 AM, Aurelien Jarno wrote:
>>>> Hi Alex,
>>>>
>>>> On 2025-10-13 10:35, Alex Elder wrote:
>>>>> This series introduces a PHY driver and a PCIe driver to support PCIe
>>>>> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
>>>>> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
>>>>> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
>>>>> one PCIe lane, and the other two ports each have two lanes.  All PCIe
>>>>> ports operate at 5 GT/second.
>>>>>
>>>>> The PCIe PHYs must be configured using a value that can only be
>>>>> determined using the combo PHY, operating in PCIe mode.  To allow
>>>>> that PHY to be used for USB, the calibration step is performed by
>>>>> the PHY driver automatically at probe time.  Once this step is done,
>>>>> the PHY can be used for either PCIe or USB.
>>>>>
>>>>> Version 2 of this series incorporates suggestions made during the
>>>>> review of version 1.  Specific highlights are detailed below.
>>>>
>>>> With the issues mentioned in patch 4 fixed, this patchset works fine for
>>>> me. That said I had to disable ASPM by passing pcie_aspm=off on the
>>>> command line, as it is now enabled by default since 6.18-rc1 [1]. At
>>>> this stage, I am not sure if it is an issue with my NVME drive or an
>>>> issue with the controller.
>>>
>>> Can you describe what symptoms you had that required you to pass
>>> "pcie_aspm=off" on the kernel command line?
>>>
>>> I see these lines in my boot log related to ASPM (and added by
>>> the commit you link to), for both pcie1 and pcie2:
>>>
>>>    pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 AS
>>> PM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
>>>    pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
>>>
>>>    . . .
>>>
>>>    nvme nvme0: pci function 0000:01:00.0
>>>    nvme 0000:01:00.0: enabling device (0000 -> 0002)
>>>    nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
>>>    nvme nvme0: 8/0/0 default/read/poll queues
>>>     nvme0n1: p1
>>>
>>> My NVMe drive on pcie1 works correctly.
>>>    https://www.crucial.com/ssd/p3/CT1000P3SSD8
>>>
>>>    root@bananapif3:~# df /a
>>>    Filesystem     1K-blocks     Used Available Use% Mounted on
>>>    /dev/nvme0n1p1 960302804 32063304 879385040   4% /a
>>>    root@bananapif3:~#
>>
>> Sorry for the delay, it took me time to test some more things and
>> different SSDs. First of all I still see the issue with your v3 on top
>> of v6.18-rc3, which includes some fixes for ASPM support [1].
>>
>> I have tried 3 different SSDs, none of them are working, but the
>> symptoms are different, although all related with ASPM (pcie_aspm=off
>> workarounds the issue).
>>
>> With a Fox Spirit PM18 SSD (Silicon Motion, Inc. SM2263EN/SM2263XT
>> controller), I do not have more than this:
>> [    5.196723] nvme nvme0: pci function 0000:01:00.0
>> [    5.198843] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>>
>> With a WD Blue SN570 SSD, I get this:
>> [    5.199513] nvme nvme0: pci function 0000:01:00.0
>> [    5.201653] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>> [    5.270334] nvme nvme0: allocated 32 MiB host memory buffer (8 segments).
>> [    5.277624] nvme nvme0: 8/0/0 default/read/poll queues
>> [   19.192350] nvme nvme0: using unchecked data buffer
>> [   48.108400] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>> [   48.113885] nvme nvme0: Does your device have a faulty power saving mode enabled?
>> [   48.121346] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
>> [   48.176878] nvme0n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct 0x3 / sc 0x71)
>> [   48.181926] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
>> [   48.243670] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>> [   48.246914] nvme nvme0: Disabling device after reset failure: -19
>> [   48.280495] Buffer I/O error on dev nvme0n1, logical block 0, async page read
>>
>>
>> Finally with a PNY CS1030 SSD (Phison PS5015-E15 controller), I get this:
>> [    5.215631] nvme nvme0: pci function 0000:01:00.0
>> [    5.220435] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>> [    5.329565] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
>> [   66.540485] nvme nvme0: I/O tag 28 (401c) QID 0 timeout, disable controller
>> [   66.585245] nvme 0000:01:00.0: probe with driver nvme failed with error -4
>>
>> Note that I also tested this latest SSD on a VisionFive 2 board with exactly
>> the same kernel (I just moved the SSD and booted), and it works fine with ASPM
>> enabled (confirmed with lspci).
> 
> I have been testing this patchset recently as well, but on an Orange Pi
> RV2 board instead (and an extra RV2 specific patch to enable power to
> the M.2 slot).
> 
> I ran into the same symptoms you had ("QID 0 timeout" after about 60
> seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> seems to work fine with the "pcie_aspm=off" workaround as well.

I don't see this problem, and haven't tried to reproduce it yet.

Mani told me I needed to add these lines to ensure the "runtime
PM hierarchy of PCIe chain" won't be "broken":

	pm_runtime_set_active()
	pm_runtime_no_callbacks()
	devm_pm_runtime_enable()

Just out of curiosity, could you try with those lines added
just before these assignments in k1_pcie_probe()?

	k1->pci.dev = dev;
	k1->pci.ops = &k1_pcie_ops;
	dw_pcie_cap_set(&k1->pci, REQ_RES);

I doubt it will fix what you're seeing, but at the moment I'm
working on something else.

Thanks.

					-Alex

> Of note, I don't have this problem with the vendor 6.6.63 kernel.
> 
>>> I basically want to know if there's something I should do with this
>>> driver to address this.  (Mani, can you explain?)
>>
>> I am not sure on my side how to debug that. What I know is that it is
>> linked to ASPM L1, L0 works fine. In other words the SSDs work fine with
>> this patch:
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 79b9651584737..1a134ec68b591 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -801,8 +801,8 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>   	if (of_have_populated_dt()) {
>>   		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>>   			link->aspm_default |= PCIE_LINK_STATE_L0S;
>> -		if (link->aspm_support & PCIE_LINK_STATE_L1)
>> -			link->aspm_default |= PCIE_LINK_STATE_L1;
>> +//		if (link->aspm_support & PCIE_LINK_STATE_L1)
>> +//			link->aspm_default |= PCIE_LINK_STATE_L1;
>>   		override = link->aspm_default & ~link->aspm_enabled;
>>   		if (override)
>>   			pci_info(pdev, "ASPM: default states%s%s\n",
>>
>> I can test more things if needed, but I don't know where to start.
> 
> I'm not a PCIe expert, but I'm more than happy to test as well.
> 
> JE
> 


