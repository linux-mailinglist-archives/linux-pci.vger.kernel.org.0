Return-Path: <linux-pci+bounces-16746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E799C87B5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5612E28516F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE61F892C;
	Thu, 14 Nov 2024 10:34:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6D1F8915;
	Thu, 14 Nov 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580479; cv=none; b=gyIr5iLoe4695J1BfNU9ljgKDDKMuqLMNOZh8GWol3veW67zCORfx7nclf306YRx5UIrVAH7r1PX+U1jzs39C95stsfUDs4RNVPMscj49ZnvAbVt+L0jiDb1BtVWkr8HhrgVL64jNQefX2ylbgv8uEKUvLA5F6j2P8IQUkStphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580479; c=relaxed/simple;
	bh=oTcnX4FEsq7Npe1e0dWgB4bZMF4x6bsnIEAjhu5v5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4VVGgO9A6l78k8UxGeNPTeng+NVgMxtFq6oPGHw20S3/udVTnOw3mzkEN8xI/PtA623+z9VVR1//oo6JMiYP2HEInTwCITDkm3ea5Hkw7bL9koic4aqTEh8VWM/jRDJDRZHqEcW5MBDiWEtICkIi/025jbBuewsEYJhcEQQJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1964D2BC2;
	Thu, 14 Nov 2024 02:35:06 -0800 (PST)
Received: from [10.57.89.20] (unknown [10.57.89.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26FF83F6A8;
	Thu, 14 Nov 2024 02:34:34 -0800 (PST)
Message-ID: <987544e9-82b1-4471-a8af-c47dbffcaf16@arm.com>
Date: Thu, 14 Nov 2024 10:34:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] ARM: dts: Configure interconnect target module for
 dra7 sata
To: Romain Naour <romain.naour@smile.fr>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-pci@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
References: <20210126124004.52550-1-tony@atomide.com>
 <20210126124004.52550-8-tony@atomide.com>
 <c583e1bb-f56b-4489-8012-ce742e85f233@smile.fr>
 <9d030892-8639-4bb0-9225-f84d43e17fd8@smile.fr>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <9d030892-8639-4bb0-9225-f84d43e17fd8@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-14 10:22 am, Romain Naour wrote:
> Hello,
> 
> Le 12/11/2024 à 15:15, Romain Naour a écrit :
>> Hello Tony, Roger, All,
>>
>> Le 26/01/2021 à 13:39, Tony Lindgren a écrit :
>>> We can now probe devices with device tree only configuration using
>>> ti-sysc interconnect target module driver. Let's configure the
>>> module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
>>> time warnings. The legacy property will be removed in later patches
>>> together with the legacy platform data.
>>>
>>> Note that the old sysc register offset is wrong, the real offset is at
>>> 0x1100 as listed in TRM for SATA_SYSCONFIG register. Looks like we've been
>>> happily using sata on the bootloader configured sysconfig register and
>>> nobody noticed. Also the old register range for SATAMAC_wrapper registers
>>> is wrong at 7 while it should be 8. But that too seems harmless.
>>>
>>> There is also an L3 parent interconnect range that we don't seem to be
>>> using. That can be added as needed later on.
>>
>> Since the switch from a kernel 5.10 to 6.1, the dra7 (AM574x) sata interface
>> doesn't work as expected.
>>
>> Using a kernel 6.1 with a preformated ext4 SATA disc, any copied file will be
>> corrupted when the filesystem is umounted.
>>
>> mount /dev/sda1 /mnt
>> cp /<test_file> /mnt/
>> sync
>> sha256sum /mnt/<test_file> /<test_file>
>> <same hash>
>> umount /mnt
>>
>> mount /dev/sda1 /mnt
>> sha256sum /mnt/<test_file> /<test_file>
>> /mnt/<test_file> is corrupted.
>>
>> git bisect report 8af15365a368 ("ARM: dts: Configure interconnect target module
>> for dra7 sata") as the first bad commit [1] (merged in 5.13).
>>
>> While looking for existing SATA issue on dra7 SoC, I found this old patch:
>>
>> "On TI Platforms using LPAE, SATA breaks with 64-bit DMA. Restrict it to
>> 32-bit." [2].
>>
>> Even if it's not the correct fix, disabling 64-bit DMA allows to use the sata
>> disc correctly. The discussion about this issue seems to have stopped [3] and
>> the suggested change was never merged.
>>
>> The SATA port is unlikely not available on TI AM57 EVM boards or the beaglebone-AI.
>>
>> Any suggestion?
> 
> It seems we have to use a pseudo-bus to constrain sata dma size (see [1])

No, the target-module node already represents a parent "bus", at least 
as far as the DT abstraction cares - just add a dma-ranges property 
there. Anything which has a ranges property to represent passing MMIO 
traffic downstream can equally have dma-ranges to represent DMA traffic 
coming back upstream.

Thanks,
Robin.

> But the sata node is placed inside a "ti,sysc-omap4" node, it's not clear if we
> can do that.
> 
> target-module@40000 {			/* 0x4a140000, ap 31 06.0 */
>      compatible = "ti,sysc-omap4", "ti,sysc";
>      reg = <0x400fc 4>,
>              <0x41100 4>;
>      reg-names = "rev", "sysc";
>      ti,sysc-midle = <SYSC_IDLE_FORCE>,
>              <SYSC_IDLE_NO>,
>              <SYSC_IDLE_SMART>;
>      ti,sysc-sidle = <SYSC_IDLE_FORCE>,
>              <SYSC_IDLE_NO>,
>              <SYSC_IDLE_SMART>,
>              <SYSC_IDLE_SMART_WKUP>;
>      power-domains = <&prm_l3init>;
>      clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 0>;
>      clock-names = "fck";
> 
>      #size-cells = <2>;
>      #address-cells = <2>; // [2] parent-bus-address
>      ranges = <0x0 0x0 0x40000 0x0 0x10000>;
> 
>      aux_bus: aux_bus {
>          #address-cells = <2>; // [1] child-bus-address
>          #size-cells = <2>; // [3] length
>          compatible = "simple-bus";
>          ranges;
>          dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;
>          /*           | [1]   |[2]    | [3] | */
>          /* dma-ranges = <child-bus-address, parent-bus-address, length> */
> 
>          sata: sata@0 {
>              compatible = "snps,dwc-ahci";
>              reg = <0x0 0x0 0x0 0x1100>, <0x0 0x0 0x0 0x8>;
>              interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>              phys = <&sata_phy>;
>              phy-names = "sata-phy";
>              clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
>              ports-implemented = <0x1>;
>          };
>      };
> };
> 
> Note: ti,sysc-omap4 doesn't allows anything than #address-cells = <1> and
> #size-cells = <1> before commit [2].
> 
> bus: ti-sysc: Remove open coded "ranges" parsing
> 
>      "ranges" is a standard property and we have common helper functions for
>      parsing it, so let's use them.
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=2a2ab4d5206d25875e30a8a8153f0b4f3c951ee4
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=41e4f807f85d02a44426b87e01ed98b191dbbf9d
> 
> Best regards,
> Romain
> 
> 
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8af15365a36845c4c15d4c8046ddccff331d5263
>> [2] https://lore.kernel.org/all/20200206111728.6703-1-rogerq@ti.com/T/
>> [3] https://lore.kernel.org/lkml/c753a232-403d-6ed2-89fd-09476c887391@ti.com/
>>
>> Best regards,
>> Romain
>>
>>
>>>
> 


