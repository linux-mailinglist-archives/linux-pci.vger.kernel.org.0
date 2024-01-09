Return-Path: <linux-pci+bounces-1866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB158827DBF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 05:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E489A1C23545
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10936104;
	Tue,  9 Jan 2024 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzQpVpKe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF813AF8;
	Tue,  9 Jan 2024 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3e416f303so7056215ad.0;
        Mon, 08 Jan 2024 20:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704773318; x=1705378118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/XC7+Hzrqaul1JzDjqFzwqKQMzBB3vpvjl8qHZ5in8=;
        b=mzQpVpKeXwKSKcLWKuNiVogLVrykrSt+T9LetCfOZdRtvCZEodDvqYjY581i7y5Vu/
         6bgdpjnR4R6AWDeKAG07+BtF2VyDe1J13/De7jLDPBRsLBnQqjPu3LrRrzMSqN3iug51
         T02KBWeNwZk2ntZAXW51sfabCLnavW9Rp8k2KEz5uE89yWg/9BOwgvb6huoby+LwTUny
         TjBIWpeR9Xyrzcfx6bOMTAu2Cuk0m7ZmDK7Ar3kVmKoSwYeBglmVEc5ZbXGnrUZp94PR
         VR1WfYEKtStPNx4ecMRK3tb/Azk6TvJKKJypAHKJZdmoEe1fDSCGD3PlGe9IyRNMmCfI
         Buzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704773318; x=1705378118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/XC7+Hzrqaul1JzDjqFzwqKQMzBB3vpvjl8qHZ5in8=;
        b=hohrWUeNRgY+MVbEFwWM9ItMTuLR2pqP/Qdapj/sR6DJO9CiRmNsrEi1UDySHJZVVT
         clwajkP9RLspWFj62wttbC8xBaIaNKszOhwFbB0lR3n2mHquLcjCSlFt2jkTZ5Emg5/1
         D3HE0d4Yailxth98CiLKjJ646PrZrTQD9wVH4G1FgLD9GyLl4cZ52U+dQwukoPxewYWo
         R7x8BrgeDcVpzhSDUA5KYU3KcqMwVTJcLJMxi+DSdsbHe86CuZ5o90jr2y03yVcdnI/D
         tSdEt1sKQdtQC3qU2HsUjk1/9ial+BVtHVOi7ogLIwvGIyAIuoYAB9/R9TJCKFZtyAc2
         9XUA==
X-Gm-Message-State: AOJu0Yxa6XUBETVailmVRUk8oVO8q4Y0iW4BxY0kTUWg3zJjMhHLf0pO
	yhxBn8x4Q0f9jBc2YHJYtGg=
X-Google-Smtp-Source: AGHT+IHY1ya+YrOLTHexV8PosRb/mNRrliidXjZM2nUEIVPtdG0nc7kbSmQlzxZRWYZv+xROvd6Tgg==
X-Received: by 2002:a17:902:dac8:b0:1d4:524d:96cb with SMTP id q8-20020a170902dac800b001d4524d96cbmr2692987plx.109.1704773317516;
        Mon, 08 Jan 2024 20:08:37 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:c927:f415:d49b:1377? ([2600:8802:b00:ba1:c927:f415:d49b:1377])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902834300b001d1d6f6b67dsm651885pln.147.2024.01.08.20.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 20:08:36 -0800 (PST)
Message-ID: <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
Date: Mon, 8 Jan 2024 20:08:33 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe
 devices
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jim Quinlan <jim2101024@gmail.com>, james.quinlan@broadcom.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
> 
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
> 
> After some additional brain-storming with Manivannan and the realization
> that the DT maintainers won't like adding any "fake" nodes not
> representing actual devices, we decided to reuse the existing
> infrastructure provided by the PCIe port drivers.
> 
> The general idea is to instantiate platform devices for child nodes of
> the PCIe port DT node. For those nodes for which a power-sequencing
> driver exists, we bind it and let it probe. The driver then triggers a
> rescan of the PCI bus with the aim of detecting the now powered-on
> device. The device will consume the same DT node as the platform,
> power-sequencing device. We use device links to make the latter become
> the parent of the former.
> 
> The main advantage of this approach is not modifying the existing DT in
> any way and especially not adding any "fake" platform devices.

There is prior work in that area which was applied, but eventually reverted:

https://www.spinics.net/lists/linux-pci/msg119136.html

and finally re-applied albeit in a different shape:

https://lore.kernel.org/all/20220716222454.29914-1-jim2101024@gmail.com/

so we might want to think about how to have pcie-brcmstb.c converted 
over your proposed approach. AFAIR there is also pcie-rockchip.c which 
has some rudimentary support for voltage regulators of PCIe end-points.

What does not yet appear in this RFC is support for suspend/resume, 
especially for power states where both the RC and the EP might be losing 
power. There also needs to be some thoughts given to wake-up enabled 
PCIe devices like Wi-Fi which might need to remain powered on to service 
Wake-on-WLAN frames if nothing else.

I sense a potential for a lot of custom power sequencing drivers being 
added and ultimately leading to the decision to create a "generic" one 
which is entirely driven by Device Tree properties...

Thanks for doing this!
-- 
Florian

