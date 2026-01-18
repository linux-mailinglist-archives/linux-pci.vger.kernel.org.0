Return-Path: <linux-pci+bounces-45101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB3D39544
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFB33013557
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0632C94A;
	Sun, 18 Jan 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YrYP8roG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D42325723;
	Sun, 18 Jan 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768742909; cv=none; b=Ipw7BWbp1nM0D8vO1FzswtXK1FmxlPM4mz2MV83i8nWk1eiFqiqFvJsh7mNXVJljuG+SxU63gTXXwdGm71cGl3tBK8wvOzegoCUi2dy7M3VnRtEuKTW3G9FnQU0aogsd0+bgWEY5SQbFlOJmXv5F8jFL9/obuyO+cgLLZsTyrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768742909; c=relaxed/simple;
	bh=Uf0OzjC8UiNCY2NrU0gw0n4jPgb6i72SoXLEP1uswhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dciNyVEFLdv8w+Xgrx6i+4vidwB6g8XjBwOtwiFozqnYTeTzZFUzKjfC/BtxgrSxF06h9Gefyge7ygAYMURiF2REzkKIqD2C3k0BJgLTi7HbVNe3tJiDH747ZvYD49Qg6TlwgOy6mx7bZAoyUA1JmFAOkhvzIMTBUHE2jh+aN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YrYP8roG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=j9NWfNLMXfGmHPrhiqbEiqJKeYZj3TN2WzPDL/gZWhI=;
	b=YrYP8roGqofgIqAVcaNc940Qub9UHHLMiANIrDKfmbiUMqFshjCXo3/Medm7Td
	y7kWOIYVzjIUkgfbE4gXUTVDFDaKEgFuitq+lyWf8YQkeWrznysDRaInK2paKuIH
	D9XNUmIqDsXRkjNgOa2ZFFZsdmT5D4AL8e5dZmqCrwyl4=
Received: from [IPV6:240e:b8f:927e:1000:e94b:3b22:e2ce:7986] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnuOCV32xpJgqjLw--.141S2;
	Sun, 18 Jan 2026 21:26:48 +0800 (CST)
Message-ID: <1ff0d069-14f0-439a-afca-4ecc1b569834@163.com>
Date: Sun, 18 Jan 2026 21:26:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
To: Ricardo Pardini <ricardo@pardini.net>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251127170908.14850-1-18255117159@163.com>
 <f5322597-c6dd-494a-863b-2caf24363f2d@pardini.net>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <f5322597-c6dd-494a-863b-2caf24363f2d@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnuOCV32xpJgqjLw--.141S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1UAr48WFyktF4rtr13Jwb_yoW5Xr18pF
	WYganIyFs3GFyfC34qqw4kCFW5Za4kKF43GryvqwnxJan8uF1DWFy8tws5twnFgrn3A3WS
	vF1qg3WxZwn0vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxPEhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxiTN2ls35hqSAAA3f



On 2025/12/31 10:58, Ricardo Pardini wrote:
> On 27/11/2025 18:09, Hans Zhang wrote:
>> Current PCIe initialization exhibits a key optimization gap: Root Ports
>> may operate with non-optimal Maximum Payload Size (MPS) settings. While
>> downstream device configuration is handled during bus enumeration, Root
>> Port MPS values inherited from firmware or hardware defaults often fail
>> to utilize the full capabilities supported by controller hardware. This
>> results in suboptimal data transfer efficiency throughout the PCIe
>> hierarchy.
>>
>> This patch series addresses this by:
>>
>> 1. Core PCI enhancement (Patch 1):
>> - Proactively configures Root Port MPS during host controller probing
>> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
>> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
>>    and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
>> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
>> - Preserves standard MPS negotiation during downstream enumeration
>>
>> 2. Driver cleanup (Patch 2):
>> - Removes redundant MPS configuration from Meson PCIe controller driver
>> - Functionality is now centralized in PCI core
>> - Simplifies driver maintenance long-term
>>
>> ---
>> Changes in v7:
>> - Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
>> - Remove redundant check for upstream bridge (Root Ports don't have one)
>> - Improve commit message and code comments as per Bjorn.
> Hi Hans,
> 
> I've tested on an Odroid-HC4 with a SATA SSD (via an ASM1061) by 
> applying your v7 on v6.19-rc3 + Bjorn's 20251103221930.1831376-1- 
> helgaas@kernel.org ("PCI: meson: Remove meson_pcie_link_up() timeout, 
> message, speed check" which is required to get the meson PCIe to work at 
> all since 6.18). With that setup I get:
> 
> # hdparm --direct -t /dev/sda
>   Timing O_DIRECT disk reads: 832 MB in  3.00 seconds = 277.33 MB/sec
> 
> I've an identical machine, with a similar disk (even slightly faster, on 
> paper), running plain 6.12.y and there I get:
> 
> # hdparm --direct -t /dev/sda
>   Timing O_DIRECT disk reads: 764 MB in  3.00 seconds = 254.26 MB/sec
> 
> I repeated those a few times, not very scientific, I know; but anyway:
> 
> Tested-by: Ricardo Pardini <ricardo@pardini.net> # on Odroid-HC4
> 
> I've also feedback from another user running with this series with 
> success on a different meson PCIe machine, will ask them to TB as well; 
> they had reported a significant drop in performance since v6.18 without 
> this.
Hi,

Thank you very much for your test. Let's wait for Bjorn's reply.

Best regards,
Hans

> 
> Thanks,
> Ricardo


