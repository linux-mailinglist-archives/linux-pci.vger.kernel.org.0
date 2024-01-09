Return-Path: <linux-pci+bounces-1916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D1828315
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB82B23BDC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E62D7AF;
	Tue,  9 Jan 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq2HYh++"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A835883;
	Tue,  9 Jan 2024 09:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F47FC43399;
	Tue,  9 Jan 2024 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704792284;
	bh=C7H7w4SCOHPEKSbdH/8LWP/KZNEqQ1r60F5xiy24wvc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Lq2HYh++x5jwY2PFeXFXc90GyBmZyuoFgbvB2Rty2xkTZA5Rc0Pxws+mzVIq++Hx7
	 ++fodCbaSjc5utdR+5Y91ANd/JrtWeSvjnL5h5vWb3tAvAnQtWjWolpyvMU4d7aDN+
	 9LST/UQvhWAb2VhEhm4wr0nAMqnyJneKpHiTRJ+Xf5u+6L7EDu6lum44x9YVevJagv
	 VHy2DRqubgZwhGtms3c7ozDyo+IPgNBsjUv3ea0WSZgZcc0CZb8pzX/wdkrsmr+sat
	 fu2lSeO8fl9BbF5JGIMcoSzNr4aWEBB9cO6MEjq26++yfer9+c76Mofl4hALQACL5b
	 /Fd1nO+/5Mqww==
From: Kalle Valo <kvalo@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Heiko Stuebner <heiko@sntech.de>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Chris Morgan <macromorgan@hotmail.com>,
  Linus Walleij <linus.walleij@linaro.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  =?utf-8?Q?N=C3=ADcolas?= F . R . A . Prado
 <nfraprado@collabora.com>,  Marek Szyprowski <m.szyprowski@samsung.com>,
  Peng Fan <peng.fan@nxp.com>,  Robert Richter <rrichter@amd.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Terry Bowman <terry.bowman@amd.com>,
  Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Huacai
 Chen
 <chenhuacai@kernel.org>,  Alex Elder <elder@linaro.org>,  Srini Kandagatla
 <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jim Quinlan <jim2101024@gmail.com>,
  james.quinlan@broadcom.com,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
  Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
References: <20240104130123.37115-1-brgl@bgdev.pl>
	<a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
Date: Tue, 09 Jan 2024 11:24:35 +0200
In-Reply-To: <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com> (Florian
	Fainelli's message of "Mon, 8 Jan 2024 20:08:33 -0800")
Message-ID: <87frz6zwoc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian Fainelli <f.fainelli@gmail.com> writes:

> Hello,
>
> On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> During last year's Linux Plumbers we had several discussions
>> centered
>> around the need to power-on PCI devices before they can be detected on
>> the bus.
>> The consensus during the conference was that we need to introduce a
>> class of "PCI slot drivers" that would handle the power-sequencing.
>> After some additional brain-storming with Manivannan and the
>> realization
>> that the DT maintainers won't like adding any "fake" nodes not
>> representing actual devices, we decided to reuse the existing
>> infrastructure provided by the PCIe port drivers.
>> The general idea is to instantiate platform devices for child nodes
>> of
>> the PCIe port DT node. For those nodes for which a power-sequencing
>> driver exists, we bind it and let it probe. The driver then triggers a
>> rescan of the PCI bus with the aim of detecting the now powered-on
>> device. The device will consume the same DT node as the platform,
>> power-sequencing device. We use device links to make the latter become
>> the parent of the former.
>> The main advantage of this approach is not modifying the existing DT
>> in
>> any way and especially not adding any "fake" platform devices.
>
> There is prior work in that area which was applied, but eventually reverted:
>
> https://www.spinics.net/lists/linux-pci/msg119136.html
>
> and finally re-applied albeit in a different shape:
>
> https://lore.kernel.org/all/20220716222454.29914-1-jim2101024@gmail.com/
>
> so we might want to think about how to have pcie-brcmstb.c converted
> over your proposed approach. AFAIR there is also pcie-rockchip.c which
> has some rudimentary support for voltage regulators of PCIe
> end-points.
>
> What does not yet appear in this RFC is support for suspend/resume,
> especially for power states where both the RC and the EP might be
> losing power. There also needs to be some thoughts given to wake-up
> enabled PCIe devices like Wi-Fi which might need to remain powered on
> to service Wake-on-WLAN frames if nothing else.

Good point, suspend and resume is very important for ath11k and ath12k.
And although I'm not expecting any issues with hibernation please also
consider that. Currently ath11k hibernation is broken because of MHI and
it has been pain trying to fix that. So best to make sure these cases
work from the beginning.

> I sense a potential for a lot of custom power sequencing drivers being
> added and ultimately leading to the decision to create a "generic" one
> which is entirely driven by Device Tree properties...
>
> Thanks for doing this!

A big thank you from me too! It's great to finally see this solved so
that ath11k and ath12k can be used in wider range of devices.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

