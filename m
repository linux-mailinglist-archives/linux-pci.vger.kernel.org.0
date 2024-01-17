Return-Path: <linux-pci+bounces-2276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583C830496
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D462C1F28265
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93A1DDF4;
	Wed, 17 Jan 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCNGsMzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A341DFC5
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491270; cv=none; b=gAVyD6/n+6EFD1NoXPQPg4O9jwEu9Vh6LpBMW/NAVwSgtLkT5if5K7wJELR12gtOigMRFqPbee5mJgWcPLUQKrEKQieDOdy+k2/POd0AVM+iF3O3r5Qhk08aM7Hea3MNH7khOFt3iKZx6knYEJs+jsO8bPyERapn9jczGV5kiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491270; c=relaxed/simple;
	bh=9NBh4JdtstgNI9XwFTqjeTIIJilG4HZUB+nfE7edhIk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Ca+KmFs/caSPPVq0Mhz0dCMa+WZLvSaOb78+eh9BMOjubHW5S6h5zg1TayVgnQTU2zRiq3Kh6veKAgGGLRrEdLfdx32WZov29O0cisNd6CXE9tp2QQzr21anDdKLRtPQvvZF9BqV9OA91noEdjmBo9srmypFlEYV19Kv8xETANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCNGsMzN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2cad931c50so555115466b.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 03:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705491267; x=1706096067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ghh+YL54tSMsxEEYxkWsEx/jgOTuVdo03gH5TqGxUNY=;
        b=jCNGsMzNVPP8rNB9jNfMdK7IM9FjZJxTZoSKS/IssbTgtWwLIMOoSYBU6q/NkAkuyd
         cHW2FRw7e1kV/4KwpsxqEyZ6LFSJVUbbq8IpV49Ih/lg31CXYiGzPQc8yhkJDQMAHFWg
         K8Cr7fdfECZDFcxMDQETyrMfOJ5O2tUyR02IUyV0P0Y1tRB24lGrGdbKB4KD8Mr1rGRD
         EV5LqObhLeCmikpdYzI1PAJfjtVf8XcYcTeEz8FW4l0E+bf4P1UU05gzD2ACcqHbZzVg
         YXQhM9xj6dthxK8CAXw80vUwKmFhh2oL8rlf8G+UdpY5Rpk2YSdhFSTKcGhD+lQIeEuC
         Y7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705491267; x=1706096067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghh+YL54tSMsxEEYxkWsEx/jgOTuVdo03gH5TqGxUNY=;
        b=wt3/Fvk81vYEm84nvsHDDFtRm9Gumgirpq8+pwjSEmqIanFon4lXKgy7Ugz7VlxJdn
         zPZzwvrWvv4EWtF+A/IiVjYrVOKlerpdovPNnFlaeCq5tvhSL0l0s/y4CnN7f77j5RFP
         DVSHhHx5oPD9jbkTATu0K5ZIL4Dv72+IrmTtjSZ4KPfNMAf/zf3wks0HKXfKfj48x8PQ
         pOpzyPQRVCmA8paoLqoF3vjq+kHXI8FI7IjiimfHgb4PTRwfT5xjVwWncVbsYVyDgkzp
         TOiqTmg7CbOsQwKjtPICBJspju9KmCUscE3JMPjanG1VWNEJJaCD1BD0MffrXCEKSdXK
         73yg==
X-Gm-Message-State: AOJu0YymxFAHyfOsWPjzDjqaS5qnQZXBe13xhRd0SElIYSrPtO2zueOl
	ud7jW++hyDAFlk5PJAz6FBxZPrqgeAOoL0Ug2KvubDEvHaY=
X-Google-Smtp-Source: AGHT+IFS68ve+qsPKyPl4z/okx3iaUESooLppI/Lml6Ew4VjG5ra7ALUgBAvxITS7aVDDQsTrjWoIA==
X-Received: by 2002:a17:907:7646:b0:a2e:bdaf:9302 with SMTP id kj6-20020a170907764600b00a2ebdaf9302mr466766ejc.121.1705491266855;
        Wed, 17 Jan 2024 03:34:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090607d700b00a233efe6aa7sm7672931ejc.51.2024.01.17.03.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 03:34:26 -0800 (PST)
Message-ID: <9e71bb6c-5fac-4398-8048-88b0f7aabfe9@linaro.org>
Date: Wed, 17 Jan 2024 12:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-*: Add checks for
 max-link-speed
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-3-s-vadapalli@ti.com>
 <4282b248-cb7f-4486-bde6-105a3aed6be2@linaro.org>
 <92ceb1ea-78db-4bc4-af1f-a1690eaca24c@ti.com>
 <42f44ecc-c7f4-4209-8cb5-805891c35413@linaro.org>
 <e79a1896-470e-4fba-85b0-f857a4290cbb@ti.com>
 <d8fba488-bdea-420b-84f2-a222315e1b81@linaro.org>
 <b8fb2e37-17c5-4af5-8e5d-b65a70c37734@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b8fb2e37-17c5-4af5-8e5d-b65a70c37734@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 12:22, Siddharth Vadapalli wrote:
> 
> 
> On 17/01/24 16:49, Krzysztof Kozlowski wrote:
>> On 17/01/2024 12:15, Siddharth Vadapalli wrote:
>>>
>>>
>>> On 17/01/24 16:30, Krzysztof Kozlowski wrote:
>>>> On 17/01/2024 11:58, Siddharth Vadapalli wrote:
>>>>> On 17/01/24 16:05, Krzysztof Kozlowski wrote:
>>>>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>>>>> Extend the existing compatible based checks for validating and enforcing
>>>>>>> the "max-link-speed" property.
>>>>>>
>>>>>> Based on what? Driver or hardware? Your entire change suggests you
>>>>>
>>>>> Hardware. The PCIe controller on AM64 SoC supports up to Gen2 link speed while
>>>>> the PCIe controllers on other SoCs support Gen3 link speed.
>>>>>
>>>>>> should just drop it from the binding, because this can be deduced from
>>>>>> compatible.
>>>>>
>>>>> Could you please clarify? Isn't the addition of the checks for "max-link-speed"
>>>>> identical to the checks which were added for "num-lanes", both of which are
>>>>> Hardware specific?
>>>>
>>>> Compatible defines these values, at least what it looks like from the patch.
>>>
>>> In this patch, I have added checks for the "max-link-speed" property in the same
>>> section that "num-lanes" is being evaluated. 
>>
>> I know what you did in patch. I read it.
>>
>>> The values for "max-link-speed" are
>>> based on the Hardware support and this patch is validating the "max-link-speed"
>>> property in the device-tree nodes for the devices against the Hardware supported
>>> values which this patch is adding in the corresponding section. Kindly let me
>>> know if I misunderstood what you meant to convey.
>>
>> Nothing of this is relevant.
>>
>> I used two entirely different wordings for this and you still don't get
>> it, so I don't know if I have third one.
>>
>> Maybe this:
>> Move it to driver match data.
> 
> Ok. I will drop the checks for "max-link-speed" and move them to the driver. But
> I wonder why the checks for "num-lanes" are needed in the first place when they
> could be in the driver as well.

Yes, that's why I commented in your next patch.

Best regards,
Krzysztof


