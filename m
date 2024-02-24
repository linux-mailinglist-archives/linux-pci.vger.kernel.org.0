Return-Path: <linux-pci+bounces-3972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEACF862383
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55381B22885
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B31862B;
	Sat, 24 Feb 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm3CxjUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969F175AE
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764747; cv=none; b=LC5eHSy8AFnQI0cTErCEYvER65/0md/G0y9d0dSem9KFcpnaqciaesrjTZNdUJBukPCp1WD4+DKeOqdZ5YRFZAlxjUXSzk0uUaUWFxHfeSZcaxP8aJZHFSJ3XTzAkESCdTsyRyMlp2jKxst6gHgB+eivSh1qZuYeddkSVa70q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764747; c=relaxed/simple;
	bh=01M370sC9slZyT8sM2oTN7VEL7xSUJ13fdACwlJZF9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDp1bAHrNOyuCSmmXjk2aHuZyQLHP1cy/v/X7A4MMiks3JR/FbsV7ZjnYhO9DCtF/KZ9uR/Lb6+Ha1wAbFTF1R4xb4Qz9fYCZSwP8JRNqq3NLvlx1A+u/xInWAFF69wwd/R+JihrhTyfdX9hMsYnT68Jg+mwhk9J5niOA9bSrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bm3CxjUB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3566c0309fso141172466b.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708764743; x=1709369543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRZkRZDlh9klaaBz4WWG7UFrWtv71YHpmObQ4nbgflA=;
        b=bm3CxjUBpY6Ng/EIAeysGsPFRh8aXFHbDhpshFo3NEVwPcy8zHameEefLEqzwFVbX1
         jo0p2dxpXvcxeC+v4PMdqAFyCwNjfF+gSpFqpCfTOPl3wjukwKu+ziiViCIKpIHAhQd+
         ZFtbJb0xp0NR7318uKNeJxIp3At1oTZIYmQii0wqRI4kImuLQHCty+2hpGPT9iutLaSo
         dz3yYvkmay18F53oDRqvrj9HY6lq3TqBAIVh7k98gn/0SpN+pisohfP4DlbDsHd1pIzI
         C/AxsS+cFDLiOg1GVQQcLFZQJEhkI1F2P0apOg4blrmuOhOABmLhRyJHoQAmCaKdr5Jw
         2sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708764743; x=1709369543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRZkRZDlh9klaaBz4WWG7UFrWtv71YHpmObQ4nbgflA=;
        b=otRxVFOoVUnLyK0dg/M1E9C5QEdiR3RNjPilaKqdShyVchk4CpMZtkV0ltF2yUKVaT
         cqUr/oaQ+RbzGUDrUxYW1OwhbAAL+Xu8mD66DmhPTdUxv0wW3QsrQJY98F1+9vFAX23u
         6Na3+kFO9D0xfljBKjcbuocPeV41OEuO4Wq1xMAjmOT3SP4u2vs4zxF2XwPciUff6d2f
         BvoDcikfJLRXT5PVtzUF04hhLvlm6AzVowkTnAfuG4i2KJdVJeo51QmWt984yg9o+Ned
         r93p6DboKll7VEufP/ZJnqI4lM9EYkf7DMN8aF7xBeTkSCpIaxxiC01mTzGLaje9r7Hs
         q2XA==
X-Forwarded-Encrypted: i=1; AJvYcCWBMqTEGIfXS16uD85vg47T1VJFSRTtjBmmTHgLTo9QJU5w0LTd2RB6naUYgO3GGG//kVUhlFPyspI/dH56a24wcQU6amf8o4Ri
X-Gm-Message-State: AOJu0YyDeDRXX4hgHqYFxAPl9lZOUyUR8CpRmABITp0igTGaNIRuYpb2
	U/RgsuoTngta8Fe4AUah3L/wfVNW59YMv+eb5iVaPGHTx2OcG5ty+0StdRPaDCw=
X-Google-Smtp-Source: AGHT+IGcD3Nad9XcN39rjJjikpkLcxiCL6yvaHvQKM25T39V0rvWV2ljOlY8QDsl652WLfyRgmPHtQ==
X-Received: by 2002:a17:906:b844:b0:a3f:47de:66bb with SMTP id ga4-20020a170906b84400b00a3f47de66bbmr1211837ejb.70.1708764743190;
        Sat, 24 Feb 2024 00:52:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b00a3e94142018sm389732ejb.132.2024.02.24.00.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 00:52:22 -0800 (PST)
Message-ID: <50ab0f43-9dd0-414c-b722-a406e04d9a48@linaro.org>
Date: Sat, 24 Feb 2024 09:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMRc=MfkQuaJ3FnVwbVKQRQEgmJKbZh7SJoK3Kbmb5ebzE2rKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
>>>>>>>>>>  From the hardware perspective, there is a PMU. It has several LDOs. So
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
>>>>>> From the hardware point:
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

There's like 12 emails here, so please don't just point "MR X, please
read everything to find the question I want to ask", but just ask the
question with short intro. We all (and I bet you as well) are way too
busy to read long threads...

If I got it correctly, you ask if some other, existing QCA/WCN chips
should be changed to this PMU approach?

If yes, then:
1. It depends whether they have the PMU, so some sort of analysis of
datasheet should be done.
2. You could but you don't have to. Bindings were done, they represent
the hardware more-or-less, maybe less, but still good enough.
3. It does not have to impact actual behavior of Linux. You don't have
to bind entire pwrseq driver to that QCA/WCN compatible. Anyway Linux
behavior is here a bit separate question - it can change, it can stay
the same, up to you.

Best regards,
Krzysztof


