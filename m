Return-Path: <linux-pci+bounces-42683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA79CA74EC
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3052343B73E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20E345CAC;
	Fri,  5 Dec 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="BQLgiN4Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4D34C811;
	Fri,  5 Dec 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920263; cv=none; b=p3WW1wssDEHiDk8C3e4SWa5Z7fHjm9v23AtTtXkzarHNBLGBn47lU17IVb3fABQVcCnr29e27geeWn6SQUWHSB0zUMk6aNPNw8ySRPQysmPI/LBOXOKoD8WIdUm87tbxvSk34oAWMUr9e6t1lR99Ry3xy/jdq6uWQABkpCHMj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920263; c=relaxed/simple;
	bh=dUB8I7YCp4sncsMDpbgJ4sxN6eZ47vyU/c54pyCYhPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/oTkY+eqDfw5u1qni+6/mFHQeA/LgyyKNi+flboQqTJrUOi9u1W50oNav4dAR4bljA5CNAQCqRdEwhzs/+o+uBLPELldrvs0J3/AAKLp0DBDbBfAXTWfo+SPjIgilNJO6gWP8C+Kqf+c+7Vba7lX0mHMGulmkhGnmWNLEx8nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=BQLgiN4Y; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1764919826;
	bh=dPQlBy9bP0uCp0f8xzuAly/jIN+QVZE/QzkPoToIR0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BQLgiN4Ypn2XIuJBDBsG2T95NfTpHXAXZ8y3aKRybJyBqGzRN48aVWiznrV/zv5LG
	 z2BpmPfG/q+518F2XXyvzde0huclOLz1gawF5QUXjxVA720eaaeM5nUYn/eyifBzo4
	 JzNonO70XQwv8rui2bPZ+DbFjNqjZaFuEYmO7/OfnD0qcXx7+BzvzcqU0ODsU/gTG1
	 qYXtChTpkIIoYMDyY+gg7L9s1F33GAiP+HctzWXHui7Dqg5FNGkJlDuGKwhUOJPOT7
	 v90yiVQYEK4j/bMdK2lJhck9G+yNBZPlu3OLRcHcg1cMiqVCaqK0MSPuTtHFq2IEDy
	 SAhzdGF6W50LA==
Received: from [192.168.2.54] (unknown [98.97.27.25])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id A331FB220603;
	Fri,  5 Dec 2025 08:30:21 +0100 (CET)
Message-ID: <72318f65-a360-4be0-baee-7f94b7cbf949@freeshell.de>
Date: Thu, 4 Dec 2025 23:30:19 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for
 VisionFive 2 Lite variants
To: Maud Spierings <maud_spierings@hotmail.com>, linux.amoon@gmail.com
Cc: aou@eecs.berkeley.edu, bhelgaas@google.com, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 emil.renner.berthing@canonical.com, hal.feng@starfivetech.com,
 heinrich.schuchardt@canonical.com, krzk+dt@kernel.org,
 kwilczynski@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com, pjw@kernel.org,
 rafael@kernel.org, robh@kernel.org, viresh.kumar@linaro.org,
 sandie.cao@deepcomputing.io
References: <CANAwSgQSBB_yTw5rDz2w6utvjUueWJi9tWUY9oZcpNAT8Wm8iA@mail.gmail.com>
 <AM7P189MB1009B900894F02496519B2F4E3A7A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <AM7P189MB1009B900894F02496519B2F4E3A7A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/4/25 23:23, Maud Spierings wrote:
>>
>> Hi Hal,
>>
>> On Tue, 25 Nov 2025 at 13:27, Hal Feng <hal.feng@starfivetech.com> wrote:
>>>
>>> Add a common board dtsi for use by VisionFive 2 Lite and
>>> VisionFive 2 Lite eMMC.
>>>
>>> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>> Tested-by: Matthias Brugger <mbrugger@suse.com>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  .../jh7110-starfive-visionfive-2-lite.dtsi    | 161 ++++++++++++++++++
>>>  1 file changed, 161 insertions(+)
>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-
>>> visionfive-2-lite.dtsi
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-
>>> visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-
>>> starfive-visionfive-2-lite.dtsi
>>> new file mode 100644
>>> index 000000000000..f8797a666dbf
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-
>>> lite.dtsi
>>> @@ -0,0 +1,161 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
>>> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "jh7110-common.dtsi"
>>> +
>>> +/ {
>>> +       vcc_3v3_pcie: regulator-vcc-3v3-pcie {
>>> +               compatible = "regulator-fixed";
>>> +               enable-active-high;
>>> +               gpio = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
>>> +               regulator-name = "vcc_3v3_pcie";
>>> +               regulator-min-microvolt = <3300000>;
>>> +               regulator-max-microvolt = <3300000>;
>>> +       };
>>> +};
>>
>> The vcc_3v3_pcie regulator node is common to all JH7110 development
>> boards.
>> and it is enabled through the PWREN_H signal (PCIE0_PWREN_H_GPIO32).
>>
>> VisionFive 2 Product Design Schematics below
>> [1] https://doc-en.rvspace.org/VisionFive2/PDF/
>> SCH_RV002_V1.2A_20221216.pdf
>>
>> Mars_Hardware_Schematics
>> [2] https://github.com/milkv-mars/mars-files/blob/main/
>> Mars_Hardware_Schematics/Milk-V_Mars_SCH_V1.21_2024-0510.pdf
>>
> 
> I'm not sure if this also holds true for the deepcomputing fml13v01,
> sadly as far as I know there is no schematics available for that.
> 
> the downstream dts [3] doesn't contain any evidence of it, neither does
> upstream.
> 
> I wouldn't be surprised if it is there but just not present in the dts,
> but it may be nice to get some feedback from someone at deepcomputing.
> 
> adding Sandie Cao who did some of the upstreaming work.
> 
> Link: https://github.com/DC-DeepComputing/fml13v01-linux/
> blob/97c64fe2832b6826914b6da7aa4febcdd4d3d444/arch/riscv/boot/dts/
> starfive/jh7110-deepcomputing-fml13v01.dts#L416-L432 [3]
> 
> kind regards,
> Maud
> 

I asked (to DeepComputing sales e-mail address) for schematics 28th July
2025, the reply was "There is no plan to public it by now." I also got
some generic response when I asked a technical question about RGPIO3
connection to look at the DeepComputing repo on github.

No schematics and no help to developers.

-E

