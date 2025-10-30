Return-Path: <linux-pci+bounces-39740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B80C1DDD4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 01:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D65402588
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D94126C17;
	Thu, 30 Oct 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SiiC7G5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4654918
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783013; cv=none; b=iRahc8IyF/Llzn3zVYrFBmgDJr4uCMtgc/lgFzyO4ZkvJ2xba07wSekIEHLdQiBEQiNKor/95VSqx5ZHGg5j3g3odaghTlslYnt7pIa6RaxGnC5gHsW8Os8H9joX0VnZ/aFJN34mobj+5p3sEe9lVYn/1Q4M636IxV9eNL9S89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783013; c=relaxed/simple;
	bh=Af6a4lUTdazPKyx9U/7AMEnzKrT4Vry00gENco6p7w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtAWrvjG7DoxDGZFqzsmmux91OGz+zO0iZ+tkgZlMqi6ot7HbYI2FyVrzDyTbQUxg21GZAUIKDd46ttP21kW16AAHLIC9qt8Ex2/68G08zvKAPfextDngrRy+nELmeYBC+lTMBTKAwvvReG2V7SDGOrK/XQQ2ys+jFdtanoyCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SiiC7G5a; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-431da4fa224so3590985ab.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761783009; x=1762387809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxyxNUOgrblEElGmyEA4sep5LlBoVO7BBRw8igevJ6s=;
        b=SiiC7G5aPAcUaadbSXAVbShvmBXkMfvaOWB5TMLyiInUGkQLhkvmvampOT2/PA9ZaK
         STt8945Nwow5kAD+LHU5MmwyLADfbRv0Ut0zA17hfY9in5AlV10AtTyKDRGvbuXuhjAz
         T0ciq0Ls28idXdqYgOGHqD88hPunAeaOHpe9ebvzTwzYJlgLNJiEqAL7wgnmEKelkn5x
         6QLy6LhbKCXsYGUt8TM3b1sgD59nB8EESKL0mD2kZHipwK17pryFlpllmZH0IfsdjNjN
         dB5AEGfmBtyiOLzSQKHvKj3g7C2isffOdNuBZ3VZL6YTk5SK1fP9RURIaOGjaGZT+/4J
         6tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783009; x=1762387809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxyxNUOgrblEElGmyEA4sep5LlBoVO7BBRw8igevJ6s=;
        b=CQ+Bf5NC3dY+kwCO39iDZPt9rSeCMjZ8YtH0ivf07H8GWpUnD+pjNv8U2Iy5cHaIpg
         TthZ4Su4mvdGxtU82PknWZvek2weAoHZzZhx3EergPaLGJSG2y1znbHEuisUoui3c4wf
         3pRTjfThveHLht7UwwpoiE3T99UJ4xfhA9glPf8WtYmEX7oOtta7Hgmo8xqqgzZdddfB
         KkyU/H1Wmh5kGSjSG3iNifoZvhYxYPuBbJIZ4e45rn4ZKRjNs9niRlAp5V2X1dwQPBQY
         fc7l4yYZMqxccmqVw41OdChrIAeyWQXoug+ASObXQTa5ClDvRMsu8svs94Zia/drUHEz
         73xg==
X-Forwarded-Encrypted: i=1; AJvYcCXQuZFLwv+KCDBw44ao06GsBgkMN7hDqKq9pl62XjdVtxITqdOe8waWUcGi317HLRRPBXhPWqm7gPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbC7ITNnVmZ33SDZ07f0QtMQE6LPeacNWjPEcvpRhlavtpCQPO
	ZDqpLZIg2vg71yKf4WFv3ajd2Z2oiBA5UfYrYQzti+zAlASM3taQfj4cnXJeGuKjg/Q=
X-Gm-Gg: ASbGnctajnkJrX/OnO97gE7PKp3a63KPWSSTuHIlS7G1Czh5f9M3jlfH/QA6yftXy3T
	o1VlVVHbRS35ys9nkkbo9NvIY0I8AE2yE+7I2r0FElZyk+rTRCQbboONRAjy9SJQXk29GN/fnNQ
	S4FmKkyp6+rZO8sYsnEz00HGPwq39PAFBlKqedtsQ1OaT6r2aNmbTYh6lQF7zTuU/Htj423eNZS
	jE4qFG1R3Mo+zbtaA2275KVE3PEcyP2nbHkycW4aCsyow4pfE+i+7H8RKTkLZFO+KJF5zcZCNWr
	SSpJUScjqCUx98Hkt8+XPLj17L5etS4UsHpqPjN1RVB0yo1MqFPyoMqhuB7oAhta0WgaBXQQfDp
	8WWmJKqB55a4RkOnxdEDVloTsF1X6CwnFGHBsaUH/14Eojct7nVNw4thGxqqq6Cc6uVE33DydRw
	bScHDp2T6VILQFrxt8HSV2YpM0xpDSl3rCaMjkxjq1
X-Google-Smtp-Source: AGHT+IGo5/UX7J0ClNKidKN2YOwDqgsyx0nxeraSSzCU9ZW8jr+AVU5FOLaQI0Rlsn9hweZUzGxIew==
X-Received: by 2002:a05:6e02:2162:b0:431:d83a:9ba with SMTP id e9e14a558f8ab-432f9045398mr62043485ab.26.1761783009512;
        Wed, 29 Oct 2025 17:10:09 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946de57sm5939330173.34.2025.10.29.17.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 17:10:09 -0700 (PDT)
Message-ID: <6a8e8e43-c86f-4c46-851b-858e5deec8ac@riscstar.com>
Date: Wed, 29 Oct 2025 19:10:06 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
 <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
 <ae92d3f4-5131-46be-b9b1-e8ec437c9ae9@riscstar.com>
 <tjnc4wwpdwlziboonlmki6nm7t523k5atemygwyg7ck5knsde4@anjrtcf5gcq7>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <tjnc4wwpdwlziboonlmki6nm7t523k5atemygwyg7ck5knsde4@anjrtcf5gcq7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 12:58 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 27, 2025 at 05:24:33PM -0500, Alex Elder wrote:
>> On 10/26/25 11:38 AM, Manivannan Sadhasivam wrote:
>>> On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
>>>> Add the Device Tree binding for the PCIe root complex found on the
>>>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>>>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>>>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>>>> typically used to support a USB 3 port.
>>>>
>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>> ---
>>>> v2: - Renamed the binding, using "host controller"
>>>>       - Added '>' to the description, and reworded it a bit
>>>>       - Added reference to /schemas/pci/snps,dw-pcie.yaml
>>>>       - Fixed and renamed the compatible string
>>>>       - Renamed the PMU property, and fixed its description
>>>>       - Consistently omit the period at the end of descriptions
>>>>       - Renamed the "global" clock to be "phy"
>>>>       - Use interrupts rather than interrupts-extended, and name the
>>>>         one interrupt "msi" to make clear its purpose
>>>>       - Added a vpcie3v3-supply property
>>>>       - Dropped the max-link-speed property
>>>>       - Changed additionalProperties to unevaluatedProperties
>>>>       - Dropped the label and status property from the example
>>>>
>>>>    .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>>>>    1 file changed, 156 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>>> new file mode 100644
>>>> index 0000000000000..87745d49c53a1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>>> @@ -0,0 +1,156 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SpacemiT K1 PCI Express Host Controller

. . .

>>>> +  interrupt-names:
>>>> +    const: msi
>>>> +
>>>> +  phys:
>>>> +    maxItems: 1
>>>> +
>>>> +  vpcie3v3-supply:
>>>> +    description:
>>>> +      A phandle for 3.3v regulator to use for PCIe
>>>
>>> Could you please move these Root Port specific properties (phy, vpcie3v3-supply)
>>> to the Root Port node?
>>>
>>> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>>
>> OK, I'll try to follow what that ST binding does (and the
>> matching driver).
>>
>>> For handling the 'vpcie3v3-supply', you can rely on PCI_PWRCTRL_SLOT driver.
>> I looked at the code under pci/pwrctrl.  But is there some other
>> documentation I should be looking at for this?
>>
> 
> Sorry, nothing available atm. But I will create one, once we fix some core
> issues with pwrctrl so that it becomes useable for all (more in the driver
> patch).

Sounds good, I think it's necessary.  I might not get it completely
right on the next try but I trust you'll help me understand what I
need to do.

>> It looks like it involves creating a new node compatible with
>> "pciclass,0604".  And that the purpose of that driver was to
>> ensure certain resources are enabled before the "real" PCI
>> device gets probed.
>>
>> I see two arm64 DTS files using it:  x1e80100.dtsi and r8a779g0.dtsi.
>> Both define this node inside the main PCIe controller node.
>>
>> Will this model (with the parent pwrctrl node and child PCI
>> controller node) be used for all PCI controllers from here on?
>>
> 
> The PCI controller (host bridge) node is the parent and the Root Port node
> (which gets bind to pwrctrl slot driver) will be the child.

That makes sense to me.

>> Or are you saying this properly represents the relationship of
>> the supply with the PCIe port in this SpacemiT case?
>>
> 
> We want to use this for all the new platforms and also try to convert the old
> ones too gradually.

OK, understood.

Thank you.

					-Alex

> 
> - Mani
> 


