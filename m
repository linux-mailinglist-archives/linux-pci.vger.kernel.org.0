Return-Path: <linux-pci+bounces-3875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DBB85FA2C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75C228A57A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F8134CCE;
	Thu, 22 Feb 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwNavLGi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0E135A41
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609578; cv=none; b=fPqBpK6VvW2/rW59PSBfhcgzBXXq/Bq1GLvjVax6q3Bgl3YY/dDhMhyejmD9QTbUlVjIjVsI5hsgg4YkxnqXN+sNg42T49a2nTABEKfp7h6V16EhN5FS6Pj22bqlUeicbzE837R02BxAUVGAWDvZ1GmWqfL0UoHdtnrNcEBm9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609578; c=relaxed/simple;
	bh=//BjmZqElisJvB87PrLkDfxz0MDSpq9JmNb7xW9SVRs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vh+C0AZrJ/rLFSYwoFF+0XrV26EDUXFFQlJ6XvGsdNfrZXduhu6pR6Bj47l/uavbbmdWxsXexX9TpZtepgXPyNmn5wrAq4Z0JQScsG8gDiSh2mwZuhHlxWKfpohzpDekrBs9m14e2cC9dnYHA2KtmABv70xOqXPAPu0LixJldGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kwNavLGi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d208d0b282so104057141fa.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609574; x=1709214374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxvZhJ0oC8b5xehzw1uduygrx17Uz2gfqPj007jbSmU=;
        b=kwNavLGiD2zgvn+2yrMOwLvJoabDupAYWTm3DrddP74iK31WnDXzkz2iP/rwWl+ruI
         wuGOIi5t5UTbQPF+dBCdTOXv72Aba7iEkqpmhldItXahgY8nSZT7YEkrV63BpnLb8HsW
         uoViytRHuyUR9Il1osNFusF923mMLYtBVMPQYtj7DJ5xwwfbyXunuXs/3U/j23m0bTfd
         2F70S7VHLAKmBGjL95xLBTmczuEzYGgIuTTGIeywS2BbG1+RR3cVgcXVxigRvpvQloJ1
         UAL/aF8BNabuxDIfYHEa4vPdKasVVZKJwS+f6Fn9bgJs6XPyOfML7NjFtlznTnOckvPb
         uVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609574; x=1709214374;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxvZhJ0oC8b5xehzw1uduygrx17Uz2gfqPj007jbSmU=;
        b=S9+ZLB6PNRdffDHQ8XFnuCoWBsqGE60hNIkwtFftvqYxKkcXcUz4BfNp9UbZ8QylR8
         ZXiBNmOymNU0DlSX6wyyiSExjrZjycxtGv8OtSKX7XDebawWwc+xomeUZYUVbDKALGeo
         hVVhEBq0xleZzQv14brsumriinKz5TuqDE2MfuubJ6Hyhs70rENV+j6oH/cHwnJYTUzc
         uq7YHAv1+pYzYSxYAoTZ8GDwDLgOuFuNn/S5N+vV5aM/kyQURTZHExtsejvfYsy05z9I
         xCBipTPSUKHL1Tt8aFpHmPAi4yO+UK6tiCBo3RMSAHTGhJZqwYcFlANbzQiPsuUUxv5R
         Kfpw==
X-Forwarded-Encrypted: i=1; AJvYcCUfHUOFn1TgBxN0MliCrLEhLMfiX+z+tuxFB5+qS007ImvoS7maGHrSe+muO9GI4+rzUIwnIK5cj6XYtQGSDuWsGcRnlLV0qp3p
X-Gm-Message-State: AOJu0Ywq7kjYtdyfZTaJri8azbkkc7il9uAF8fXznK1FmXpY8VZuWCKj
	nSqyJzU+pWy5ssIWaY7RKwcV1xRHe7MQU1vk5W4c7eAPXPNdM/IhwlF0LB2o+0k=
X-Google-Smtp-Source: AGHT+IEYkHYJhyetOsTePLj9kqPi0h7qj4xA8GvixXba4W/vyi5pgAF10kX6npOiu+l/MuUIlY8NOQ==
X-Received: by 2002:a2e:a9a2:0:b0:2d0:e35a:3bab with SMTP id x34-20020a2ea9a2000000b002d0e35a3babmr17094459ljq.48.1708609574044;
        Thu, 22 Feb 2024 05:46:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c3d:c732:acf9:f53b? ([2a01:e0a:982:cbb0:c3d:c732:acf9:f53b])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm20423663wrx.47.2024.02.22.05.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:46:13 -0800 (PST)
Message-ID: <aaa20b12-6625-43ae-a07c-9d601e5da391@linaro.org>
Date: Thu, 22 Feb 2024 14:46:11 +0100
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
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
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
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org>
 <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
 <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org>
 <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
 <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com>
 <CAA8EJprUM6=ZqTwWLB8rW8WRDqwncafa-szSsTvPQCOOSXUn_w@mail.gmail.com>
 <CAMRc=Metemd=24t0RJw-O9Z0-cg4mESouOfvMVLs_rJDCwRBPQ@mail.gmail.com>
 <CAA8EJprJTj7o0ATrQbF_38tW+kLspF1nBySg+_y_RWmadVnV9A@mail.gmail.com>
 <CAMRc=MfkQuaJ3FnVwbVKQRQEgmJKbZh7SJoK3Kbmb5ebzE2rKA@mail.gmail.com>
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
In-Reply-To: <CAMRc=MfkQuaJ3FnVwbVKQRQEgmJKbZh7SJoK3Kbmb5ebzE2rKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 13:50, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 1:47 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Thu, 22 Feb 2024 at 14:27, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> On Thu, Feb 22, 2024 at 12:27 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On Thu, 22 Feb 2024 at 13:00, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>> On Mon, Feb 19, 2024 at 11:21 PM Dmitry Baryshkov
>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>
>>>>>> On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
>>>>>>>
>>>>>>> On 19/02/2024 13:33, Dmitry Baryshkov wrote:
>>>>>>>> On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, Feb 19, 2024 at 11:26 AM Dmitry Baryshkov
>>>>>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [snip]
>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> For WCN7850 we hide the existence of the PMU as modeling it is simply not
>>>>>>>>>>>>>>> necessary. The BT and WLAN devices on the device-tree are represented as
>>>>>>>>>>>>>>> consuming the inputs (relevant to the functionality of each) of the PMU
>>>>>>>>>>>>>>> directly.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We are describing the hardware. From the hardware point of view, there
>>>>>>>>>>>>>> is a PMU. I think at some point we would really like to describe all
>>>>>>>>>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including the
>>>>>>>>>>>>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
>>>>>>>>>>>>>
>>>>>>>>>>>>> While I agree with older WiFi+BT units, I don't think it's needed for
>>>>>>>>>>>>> WCN7850 since BT+WiFi are now designed to be fully independent and PMU is
>>>>>>>>>>>>> transparent.
>>>>>>>>>>>>
>>>>>>>>>>>> I don't see any significant difference between WCN6750/WCN6855 and
>>>>>>>>>>>> WCN7850 from the PMU / power up point of view. Could you please point
>>>>>>>>>>>> me to the difference?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The WCN7850 datasheet clearly states there's not contraint on the WLAN_EN
>>>>>>>>>>> and BT_EN ordering and the only requirement is to have all input regulators
>>>>>>>>>>> up before pulling up WLAN_EN and/or BT_EN.
>>>>>>>>>>>
>>>>>>>>>>> This makes the PMU transparent and BT and WLAN can be described as independent.
>>>>>>>>>>
>>>>>>>>>>   From the hardware perspective, there is a PMU. It has several LDOs. So
>>>>>>>>>> the device tree should have the same style as the previous
>>>>>>>>>> generations.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> My thinking was this: yes, there is a PMU but describing it has no
>>>>>>>>> benefit (unlike QCA6x90). If we do describe, then we'll end up having
>>>>>>>>> to use pwrseq here despite it not being needed because now we won't be
>>>>>>>>> able to just get regulators from WLAN/BT drivers directly.
>>>>>>>>>
>>>>>>>>> So I also vote for keeping it this way. Let's go into the package
>>>>>>>>> detail only if it's required.
>>>>>>>>
>>>>>>>> The WiFi / BT parts are not powered up by the board regulators. They
>>>>>>>> are powered up by the PSU. So we are not describing it in the accurate
>>>>>>>> way.
>>>>>>>
>>>>>>> I disagree, the WCN7850 can also be used as a discrete PCIe M.2 card, and in
>>>>>>> this situation the PCIe part is powered with the M.2 slot and the BT side
>>>>>>> is powered separately as we currently do it now.
>>>>>>
>>>>>> QCA6390 can also be used as a discrete M.2 card.
>>>>>>
>>>>>>> So yes there's a PMU, but it's not an always visible hardware part, from the
>>>>>>> SoC PoV, only the separate PCIe and BT subsystems are visible/controllable/powerable.
>>>>>>
>>>>>>  From the hardware point:
>>>>>> - There is a PMU
>>>>>> - The PMU is connected to the board supplies
>>>>>> - Both WiFi and BT parts are connected to the PMU
>>>>>> - The BT_EN / WLAN_EN pins are not connected to the PMU
>>>>>>
>>>>>> So, not representing the PMU in the device tree is a simplification.
>>>>>>
>>>>>
>>>>> What about the existing WLAN and BT users of similar packages? We
>>>>> would have to deprecate a lot of existing bindings. I don't think it's
>>>>> worth it.
>>>>
>>>> We have bindings that are not reflecting the hardware. So yes, we
>>>> should gradually update them once the powerseq is merged.
>>>>
>>>>> The WCN7850 is already described in bindings as consuming what is PMUs
>>>>> inputs and not its outputs.
>>>>
>>>> So do WCN6855 and QCA6391 BlueTooth parts.
>>>>
>>>
>>> That is not true for the latter, this series is adding regulators for it.
>>
>> But the bindings exist already, so you still have to extend it,
>> deprecating regulator-less bindings.
>>
>> Bartosz, I really don't understand what is the issue there. There is a
>> PMU. As such it should be represented in the DT and it can be handled
>> by the same driver as you are adding for QCA6390.
>>
> 
> The issue is that we'll pull in the pwrseq subsystem for WCN7850 which
> clearly does not require it in practice.
> 
> I'd like to hear Krzysztof, Conor or Rob chime in here and make the
> decision on how to proceed.

For WCN7850 we'll be describing the PMU which is basically discrete, so we
could also add dummy fixed regulators, and it would be the same.

Neil

> 
> Bart
> 
>>>
>>> Bart
>>>
>>>>>
>>>>> Bart
>>>>>
>>>>>>>
>>>>>>> Neil
>>>>>>>
>>>>>>>>
>>>>>>>> Moreover, I think we definitely want to move BT driver to use only the
>>>>>>>> pwrseq power up method. Doing it in the other way results in the code
>>>>>>>> duplication and possible issues because of the regulator / pwrseq
>>>>>>>> taking different code paths.
>>>>>>
>>>>>> --
>>>>>> With best wishes
>>>>>> Dmitry
>>>>
>>>>
>>>>
>>>> --
>>>> With best wishes
>>>> Dmitry
>>
>>
>>
>> --
>> With best wishes
>> Dmitry


