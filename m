Return-Path: <linux-pci+bounces-1828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B38272F4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 16:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43E72813F7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622C4C3DE;
	Mon,  8 Jan 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfRsZzVp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CF51011
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso2281389e87.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704727486; x=1705332286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDfXxaJLBdAHE/PCKaUTkc4Ha2Yd2YR4JkUzxupj3v0=;
        b=HfRsZzVpwz7gN1C4c+TM9/cOZ8kaQoM3VdD27geWtxvv2YEovQWTC7auApwsG7sQTI
         HZTqnrBTHyTfDORhzOjlkSNGvlawYk51wrZeucPuXF/NFwU2QDaNfsKPiQlGdws7oTFg
         CFLv+02uUINvfdMlN/MTAnVS50d7yAf6pWGVIhaDpRfTurt4yHp6tVhy4XcETpAJT/Qm
         XzfCzooqf0khLb+zcDw2fXgNkojc79cmcOQbuRwfreTuzMTszmtICANJl2V/I29HZttg
         y4YPX2aLgdtEJwW8D08E8CI4i+mim1JJMOzTv+E1zIcQEFPiRQ9nAt7ULYPptKvP1g+u
         VPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727486; x=1705332286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VDfXxaJLBdAHE/PCKaUTkc4Ha2Yd2YR4JkUzxupj3v0=;
        b=q0keaA9GWU6myDduQTBW6+9hFpFqTq8fn8j1kM2nrklUWAu7Vp6js02hJcXECgidx5
         Ys/If3dffunbRHejlIYRS9TPpkHUhI3w3s8DhuEUU1YSrZLEUECVVfi+/OnlM4hDdpqw
         RaJqe2SF+rg4BskWvc7cj+HowpgdVxtLvEN3f/X5/f243vqMOUQSH30QudoA6Eig6gMJ
         bKxL89Tc/IPgZAgCYsLSV/2b5hHyvpDmF2Nv64ST1DHCnt4gZyx/RRFAO8kmiF2YbFq8
         po9NzPQiXupbyCZAnCvEAsuQSHegokyOajybWzh3BBYPMzluH/8TUlMWoi0nd0ONwzrj
         m2rA==
X-Gm-Message-State: AOJu0YzjKojBXdabPEw47weUZ7M3Fjd24sa9cOZZIEDotfpv9h/V18Ln
	ni0fPZR3ePrmulKqB+OaCR/g9O/XkokTMw==
X-Google-Smtp-Source: AGHT+IHYCa4xZPwbtgnWPlFUxuQ1nlQ0aFXos10SnAsRHcyZ7Yew62wRDqXCpkRZOGiwrgwv3o6ftQ==
X-Received: by 2002:ac2:4822:0:b0:50e:6ddb:551d with SMTP id 2-20020ac24822000000b0050e6ddb551dmr1425719lft.73.1704727485712;
        Mon, 08 Jan 2024 07:24:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:32b:5e85:79f9:3fde? ([2a01:e0a:982:cbb0:32b:5e85:79f9:3fde])
        by smtp.gmail.com with ESMTPSA id qu27-20020a170907111b00b00a2af877a85dsm457794ejb.6.2024.01.08.07.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 07:24:45 -0800 (PST)
Message-ID: <abefffc7-35d0-4c29-a892-48ec606acbf8@linaro.org>
Date: Mon, 8 Jan 2024 16:24:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe
 devices
Content-Language: en-US, fr
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
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/01/2024 14:01, Bartosz Golaszewski wrote:
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

I've successfully tested this serie for the WCN7850 Wifi/BT combo onboard chip
present on the SM8550-QRD and SM8650-QRD boards and it works just fine.

Here's a branch with the wcn7850 vreg table added to the pwrseq driver,
and the DT changes:
https://git.codelinaro.org/neil.armstrong/linux/-/commits/topic/sm8x50/wcn7850-wifi-pwrseq/?ref_type=heads

Thanks,
Neil

> 
> Bartosz Golaszewski (9):
>    arm64: dts: qcom: sm8250: describe the PCIe port
>    arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
>    PCI/portdrv: create platform devices for child OF nodes
>    PCI: hold the rescan mutex when scanning for the first time
>    PCI/pwrseq: add pwrseq core code
>    dt-bindings: vendor-prefixes: add a PCI prefix for Qualcomm Atheros
>    dt-bindings: wireless: ath11k: describe QCA6390
>    PCI/pwrseq: add a pwrseq driver for QCA6390
>    arm64: defconfig: enable the PCIe power sequencing for QCA6390
> 
>   .../net/wireless/qcom,ath11k-pci.yaml         |  14 ++
>   .../devicetree/bindings/vendor-prefixes.yaml  |   1 +
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  24 +++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
>   arch/arm64/configs/defconfig                  |   2 +
>   drivers/pci/pcie/Kconfig                      |   2 +
>   drivers/pci/pcie/Makefile                     |   2 +
>   drivers/pci/pcie/portdrv.c                    |   3 +-
>   drivers/pci/pcie/pwrseq/Kconfig               |  19 ++
>   drivers/pci/pcie/pwrseq/Makefile              |   4 +
>   drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c | 197 ++++++++++++++++++
>   drivers/pci/pcie/pwrseq/pwrseq.c              |  83 ++++++++
>   drivers/pci/probe.c                           |   2 +
>   include/linux/pcie-pwrseq.h                   |  24 +++
>   14 files changed, 386 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pci/pcie/pwrseq/Kconfig
>   create mode 100644 drivers/pci/pcie/pwrseq/Makefile
>   create mode 100644 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c
>   create mode 100644 drivers/pci/pcie/pwrseq/pwrseq.c
>   create mode 100644 include/linux/pcie-pwrseq.h
> 


