Return-Path: <linux-pci+bounces-3713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A451F85A006
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FA61F229C7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1524214;
	Mon, 19 Feb 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAV6CbRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D25551
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335764; cv=none; b=ENkkLgZesGdNXwASm1FOPXgitA/FgYogg0fndiI/setdIIGQbwx50ESK6dmU66c88LOl0Czkd/vPMy6PWck09j7UudgDTTppACW/yZ7neJYBanfwBgIsdQG651ysl4TLWqTV/aKeyod/vfwFIq78YGH1BQGeOBIkj3WxkC5wKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335764; c=relaxed/simple;
	bh=X8w7qaPKtinHDZjF5H+rGNDsPK0DugLEiwZmVKW48OU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Be+dg2AmvAGvh1FIu/Dft4YT2SGoi/3HU6nSMmdCzgy7w15ve0RaIDMSqlLQRvFOKaZp/gNlr/20voPfyoQEc/rJZvFP54NZFcLUafTMuea234k6qeiV7I5NnjYXHCljyyD4QRKizph9UltjLwo/+gUm6H68sMqAgBSHSYR7LWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAV6CbRe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41243d19ecaso19292685e9.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708335761; x=1708940561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbycw2c2h8YYWAo75A5nc8ijiR5Amsqr6B7bz/qk71A=;
        b=OAV6CbReOML3q2Ic9GEAz1c2Fe+Q8APdzyHNjq5uZ/7O2X48HsWMUOqR6JkihimdgK
         1jYrME1GqHgglTLhG8myfIBvq/jKybFMxCVdTHrgSKalD3BJkXL9Qr1JizosWOMFcveM
         cw6+M4Bl4LeWGkJkLt4RGnmmTasNYTGYJBRzTfjqeoBJg277NHiXBoGHA38eLfUoIC6z
         MMsRcDOQKeqFKDyTOJZKgUZyTfnZfomEgT/VdEAYtJ0BBIjh1YQ8aObX4siNDKROPZve
         9n8LVJF2VAuAn6uk5eRi3GjbQD9yB7z6Q9XIgZh2GD7a7wrQDWsX71Oqy0BpNGs7z/pM
         qlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708335761; x=1708940561;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vbycw2c2h8YYWAo75A5nc8ijiR5Amsqr6B7bz/qk71A=;
        b=ftfFAAuC8ofx6xXCbC9/RymXy6nTISuacrP4tWWZDeB9mYX5eYYEw4Db9+Fp2yWqLl
         CXxJfpvP4YZ+vkMhS64mAuUWkSyytE30/3Vp621Nbmm7ne4eJweAY4UaOIxSTVJhFLgA
         BMGk1vO0S/ncMltSz5eydRPErIuxxbhnng3a+IHAN3z4Gb4UTUrdYx2w/LSqyUAQyarr
         BmcdhmfeXUUyAzun+hXFg46obLy5Uxb0X6vklu4djWs/y+hQqau/zQ+Datk3JHZhBKV8
         xjZZ8zkA4+7XMhriSlnKHE+eoz8XSzJJhOP1M2u+zSH20U06HIKKyMepxSVkRlsIRAaP
         LxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEAhtXDnx4g3OZQxSzGU7yts+xcF11nhjbIoFM8a8/tbP9vIE7n1kp3JuxXdzLFveVyIwK5pmw8YkjDwJC65ujuFy99T82TB7O
X-Gm-Message-State: AOJu0YwsseTRVKgd9E8XYgCYzKudiSC7flAGWv1LsorlsTqy7NBgXlsQ
	bUOxKyrVQiVATCIRkSxG1iRzXTKEAIXXt0/PpC2R/renYYbRMIBEtSIiigxqpvQ=
X-Google-Smtp-Source: AGHT+IEaDPCR8uUdx0sRdbD2siOvMIF/SdMjOkjwLxWoEY2uhR+PzppCD9xsvyNY3eTuCS0GeOwQIQ==
X-Received: by 2002:a05:600c:a42:b0:411:50aa:110d with SMTP id c2-20020a05600c0a4200b0041150aa110dmr9142123wmq.21.1708335761107;
        Mon, 19 Feb 2024 01:42:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm10690182wmb.42.2024.02.19.01.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:42:40 -0800 (PST)
Message-ID: <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org>
Date: Mon, 19 Feb 2024 10:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org>
 <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
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
In-Reply-To: <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 10:22, Dmitry Baryshkov wrote:
> On Mon, 19 Feb 2024 at 10:14, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 18/02/2024 13:53, Dmitry Baryshkov wrote:
>>> On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> First, I'd like to apologize for the somewhat chaotic previous iterations
>>>> of this series and improper versioning which was rightfully pointed out
>>>> to me. I figured that the scope changed so much that it didn't make sense
>>>> to consider previous submissions part of the same series as the original
>>>> RFC but others thought otherwise so this one becomes v5 and I'll keep the
>>>> versioning going forward.
>>>>
>>>> This is the summary of the work so far:
>>>>
>>>> v1: Original RFC:
>>>>
>>>> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
>>>>
>>>> v2: First real patch series (should have been PATCH v2) adding what I
>>>>       referred to back then as PCI power sequencing:
>>>>
>>>> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
>>>>
>>>> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>>>>       modules inside the QCA6391 package (was largely separate from the
>>>>       series but probably should have been called PATCH or RFC v3):
>>>>
>>>> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
>>>>
>>>> v4: Second attempt at the full series with changed scope (introduction of
>>>>       the pwrseq subsystem, should have been RFC v4)
>>>>
>>>> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
>>>>
>>>> ===
>>>>
>>>> With that out of the way, I'd like to get down to explaining the two
>>>> problems I'm trying to solve.
>>>>
>>>> Problem statement #1: Dynamic bus chicken-and-egg problem.
>>>>
>>>> Certain on-board PCI devices need to be powered up before they are can be
>>>> detected but their PCI drivers won't get bound until the device is
>>>> powered-up so enabling the relevant resources in the PCI device driver
>>>> itself is impossible.
>>>>
>>>> Problem statement #2: Sharing inter-dependent resources between devices.
>>>>
>>>> Certain devices that use separate drivers (often on different busses)
>>>> share resources (regulators, clocks, etc.). Typically these resources
>>>> are reference-counted but in some cases there are additional interactions
>>>> between them to consider, for example specific power-up sequence timings.
>>>>
>>>> ===
>>>>
>>>> The reason for tackling both of these problems in a single series is the
>>>> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
>>>> both need to be addressed in order to enable WLAN and Bluetooth support
>>>> upstream.
>>>>
>>>> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
>>>> takes inputs from the host and exposes LDO outputs consumed by the BT and
>>>> WLAN modules which can be powered-up and down independently. However
>>>> a delay of 100ms must be respected between enabling the BT- and
>>>> WLAN-enable GPIOs[*].
>>>>
>>>> ===
>>>>
>>>> This series is logically split into several sections. I'll go
>>>> patch-by-patch and explain each step.
>>>>
>>>> Patch 1/18:
>>>>
>>>> This is a commit taken from the list by Jonathan Cameron that adds
>>>> a __free() helper for OF nodes. Not strictly related to the series but
>>>> until said commit ends in next, I need to carry it with this series.
>>>>
>>>> Patch 2/18:
>>>>
>>>> This enables the ath12k PCI module in arm64 defconfig as Qualcomm sm8650
>>>> and sm8550 reference platforms use it in the WCN7850 module.
>>>>
>>>> Patches 3/18-6/18:
>>>>
>>>> These contain all relevant DT bindings changes. We add new documents for
>>>> the QCA6390 PMU and ATH12K devices as well as extend the bindings for the
>>>> Qualcomm Bluetooth and ATH11K modules with regulators used by them in
>>>> QCA6390.
>>>>
>>>> Patches 7/18-9/18:
>>>>
>>>> These contain changes to device-tree sources for the three platforms we
>>>> work with in this series. As the WCN7850 module doesn't require any
>>>> specific timings introducing dependencies between the Bluetooth and WLAN
>>>> modules, while the QCA6390 does, we take two different approaches to how
>>>> me model them in DT.
>>>>
>>>> For WCN7850 we hide the existence of the PMU as modeling it is simply not
>>>> necessary. The BT and WLAN devices on the device-tree are represented as
>>>> consuming the inputs (relevant to the functionality of each) of the PMU
>>>> directly.
>>>
>>> We are describing the hardware. From the hardware point of view, there
>>> is a PMU. I think at some point we would really like to describe all
>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including the
>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
>>
>> While I agree with older WiFi+BT units, I don't think it's needed for
>> WCN7850 since BT+WiFi are now designed to be fully independent and PMU is
>> transparent.
> 
> I don't see any significant difference between WCN6750/WCN6855 and
> WCN7850 from the PMU / power up point of view. Could you please point
> me to the difference?
> 

The WCN7850 datasheet clearly states there's not contraint on the WLAN_EN
and BT_EN ordering and the only requirement is to have all input regulators
up before pulling up WLAN_EN and/or BT_EN.

This makes the PMU transparent and BT and WLAN can be described as independent.

Neil

