Return-Path: <linux-pci+bounces-2294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E37830C44
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6CB1C21409
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1D22F09;
	Wed, 17 Jan 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9VKz8Jp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03322EE2
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514041; cv=none; b=YVtMOzIDQMqE9jDzzv0Z4NHeFnObjEQLtgFtlL9klD2zZe3BU0BCL/5nZ37aBymbOn79l2Rs0OBRNgEpm02Gwe1yZwfcSJ8lL0Lwo3JXkNes9Xk/Lq+NAtUBHPOzjPH1I1kQo0b+At77ZnoG+kJI4AUKN2WDRIKf8Epk8Ms2kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514041; c=relaxed/simple;
	bh=JjfVt3N71j4YPkrlh+5PUtWAmKzZVN5cdfHnZnYczp0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:
	 Content-Language:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=WzBCNsVGvXY2ImWp0EOBQfY1nx0bqFM3fsz+YwyrP/d6DFdTQTKIgXPMbNPTTofaIMa9195Gsc1nbKf4DALFQ7t17zJ9HtrSA9utxq1WvjjxnAELCObQXrM1A3wx0a3N6P6qjJCOXhTEOP2LY31XRSJYVBur4XQMJ2eCBhWu8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9VKz8Jp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e8cf57d66so6162115e9.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705514037; x=1706118837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW5dEglpjib4OhaJPnLBXWIaNV1VhhWKpxCN1epSIBk=;
        b=t9VKz8Jpk6GgEJeeeIG0oKqauKJ/Ika+8YJmknIiD/MPQEZ+CoaA8J0+zL2ln0amZb
         CPx80YB5tm3TjvOS+ku+jbt736Z3b4kSlAaCyn8iYLJxrYthoZ07PD+pWm4VhH4V3+qe
         vecrD2LuJqj7pCPkT80EqU2xT04dg1p2eun+X2Xi4iicoHQTFS4d43CaUzyklN1y6rK/
         qhNV3TqodNl0j04DwJhGhisKzvYlCB1MeDQq+33YE0pvk9BnReOyDNWJKQa7IdoHlCjN
         pKHTTtL7Kpgd5u1HC2ytatHqub1K3D+5+Xgqdemuv+qEIDPVZyt2YXT+VrbuyHxVwuPP
         VZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514037; x=1706118837;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eW5dEglpjib4OhaJPnLBXWIaNV1VhhWKpxCN1epSIBk=;
        b=wqZ9cFaK2eVOXUF1mQ3Imw3vhzRfIiXMkDQC9F3whwpEplqNMB+Tb0nYjMzK4ejLxZ
         89fC4eEU7i1h5dhvi17l4mk7eYD3199smoXbD6BiWb/IAICy2CCy4xr5kw75esofj1g1
         FZjcEldKzq7MDD00iOi1naTb5IN8QcCvxGuVs+elSi7/sep6f84jJeEah3aiavBLqRNQ
         l8jxqslwtffWskXmNw/1KxYhrlw8LAhcqNMxfhooc8pVQpsBKHH8LU50mDqheydWYiFX
         mv+fhrdB4wQDza7X9vOYEG+7SMsGwlcKiyalp1D18/Htr2JPR3Rlea8CY6Dto3RA+uyu
         JaUQ==
X-Gm-Message-State: AOJu0YyRArK5l1PwAFJdBwPP0yZBm1f3nWV+N3/+6Byf7VPcV9QPLQWh
	WdwCOfPz39i3qwr5+YmQZwQoyjq22mAtZw==
X-Google-Smtp-Source: AGHT+IF9x4mzdWYcyOfkG+g6M+1NIbBX7DCz1g2FkPEH84IOqSkzdWWBeewh4OkOtgYis9oLLtkJWg==
X-Received: by 2002:a05:600c:a41:b0:40e:38a3:70f2 with SMTP id c1-20020a05600c0a4100b0040e38a370f2mr2358767wmq.65.1705514037014;
        Wed, 17 Jan 2024 09:53:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1? ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b0040e861ad5d2sm5252331wmb.0.2024.01.17.09.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:53:56 -0800 (PST)
Message-ID: <105a6adb-bef3-4c89-a6db-7f27bcd46200@linaro.org>
Date: Wed, 17 Jan 2024 18:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
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
 Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240117160748.37682-1-brgl@bgdev.pl>
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
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 17:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The responses to the RFC were rather positive so here's a proper series.
> 
> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
> 
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
> 
> After some additional brain-storming with Manivannan and the realization
> that DT maintainers won't like adding any "fake" nodes not representing
> actual devices, we decided to reuse existing PCI infrastructure.
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
> 
> Changes since RFC:
> - move the pwrseq functionality out of the port driver and into PCI core
> - add support for WCN7850 to the first pwrseq driver (and update bindings)
> - describe the WLAN modules in sm8550-qrd and sm8650-qrd
> - rework Kconfig options, drop the defconfig changes from the series as
>    they are no longer needed
> - drop the dt-binding changes for PCI vendor codes
> - extend the DT bindings for ath11k_pci with strict property checking
> - various minor tweaks and fixes
> 
> Bartosz Golaszewski (7):
>    arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
>    PCI: create platform devices for child OF nodes of the port node
>    PCI: hold the rescan mutex when scanning for the first time
>    PCI/pwrseq: add pwrseq core code
>    dt-bindings: wireless: ath11k: describe QCA6390
>    dt-bindings: wireless: ath11k: describe WCN7850
>    PCI/pwrseq: add a pwrseq driver for QCA6390
> 
> Neil Armstrong (2):
>    arm64: dts: qcom: sm8550-qrd: add Wifi nodes
>    arm64: dts: qcom: sm8650-qrd: add Wifi nodes
> 
>   .../net/wireless/qcom,ath11k-pci.yaml         |  89 ++++++
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  29 ++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  37 +++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  29 ++
>   arch/arm64/boot/dts/qcom/sm8650.dtsi          |  10 +
>   drivers/pci/Kconfig                           |   1 +
>   drivers/pci/Makefile                          |   1 +
>   drivers/pci/bus.c                             |   9 +-
>   drivers/pci/probe.c                           |   2 +
>   drivers/pci/pwrseq/Kconfig                    |  16 ++
>   drivers/pci/pwrseq/Makefile                   |   4 +
>   drivers/pci/pwrseq/pci-pwrseq-qca6390.c       | 267 ++++++++++++++++++
>   drivers/pci/pwrseq/pwrseq.c                   |  82 ++++++
>   drivers/pci/remove.c                          |   3 +-
>   include/linux/pci-pwrseq.h                    |  24 ++
>   17 files changed, 621 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/pci/pwrseq/Kconfig
>   create mode 100644 drivers/pci/pwrseq/Makefile
>   create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c
>   create mode 100644 drivers/pci/pwrseq/pwrseq.c
>   create mode 100644 include/linux/pci-pwrseq.h
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thanks,
Neil

