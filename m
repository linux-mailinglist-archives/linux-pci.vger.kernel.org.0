Return-Path: <linux-pci+bounces-1809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D639F826DC6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BC51F226AD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0B3FE5B;
	Mon,  8 Jan 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvoS5MCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA2405C4
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3607828cbf2so6165345ab.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704716810; x=1705321610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=esFbHJHXkt3d6VbeiojeTGg7fe/AX6HXvfjR+5ff6d0=;
        b=fvoS5MCQey5VNFCJd/UugVa+isDm9wwhMojg2Ly7bZES+hOq0LFe9XJYKROy3q7lii
         ZlmxsCcH66d7ApLkUd/iQbeGm3vP00VzyKWxHvZmVIrAG42NLkfZ8/ORpQEAW04LxWDx
         7r7CWu3tHTPRDvYc6DCdTGWHhV7hZx1FGQpLG8rQ3pY8ARXcHqgjaN9ZuKGiyeMpZ5tR
         o8nDsydlWq9LufNG5bpXSkSIrS+0IB9OB0qu7PhJz1ieI+/mOBBEKKiwQYh6zUqBgfD6
         qKbqa5hdHu9IMDkDzLXuKuvr4eR6CDmP4y0X93yZ0a87RJTVhy+WlAKTjB7DCI7HtNY3
         xJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704716810; x=1705321610;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esFbHJHXkt3d6VbeiojeTGg7fe/AX6HXvfjR+5ff6d0=;
        b=s6GdqTUBJFC0VoWrcJxjWqNJC6i1gG47GWjrSgT2EQu0S9k6iDZ4u9G37pQH+0VP0S
         0V7X6k1mt82fDbgBWjkSdxdxu02iuIx0dZqGSpMQe+7bpzH9kDl6A2HichRvoMWaSJ73
         rHUx3ECt2zF0bEdgtTyEHb4J790fwhP1mT82iRN4amEB+LliY2WefjhDIkH2ii3pUsd1
         /Cj7F0gdCS1JojCkxAqcwBwzz2bObmdBBP0pp69BrvySf276w95Ot+4dO6QHz42PwUGF
         wL8P12afbx9jkTXpItVnJDnJRFFhZcSgd0It68LhyjzmV66ALsrcUiKtwRx+InezOdoK
         uTbw==
X-Gm-Message-State: AOJu0YzWv7j0oSzH/NfD5Yu/BWiCv9urnHoeA37+Yhqj3XaCmy4TFUdR
	ScljcbJHBa/AqaaA6OWhKqIAxUTZmYtV+ujDoe92FRqxlOg=
X-Google-Smtp-Source: AGHT+IG/pFf6iArnT0Hy1HxW2S+Cxe0Qktx5I7qCAZk+vWC5f0o4VloBZZNAnByyk4HtRKIlsGZp2g==
X-Received: by 2002:a05:6e02:1d17:b0:35f:d487:986c with SMTP id i23-20020a056e021d1700b0035fd487986cmr3136619ila.6.1704716810302;
        Mon, 08 Jan 2024 04:26:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id bk10-20020a056e02328a00b00360489b2977sm2502062ilb.83.2024.01.08.04.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 04:26:49 -0800 (PST)
Message-ID: <5fc52ff2-e903-46e6-a808-b4a41a76ad58@linaro.org>
Date: Mon, 8 Jan 2024 13:26:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: PCI: ti,j721e-pci-host: Add device-id
 for TI's J784S4 SoC
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20240108050735.512445-1-s-vadapalli@ti.com>
 <67af1724-6424-456a-aff6-85d9e010c430@linaro.org>
 <bc3a0fb0-6268-476a-a13a-2d538704f61d@ti.com>
 <7d3439c2-35e3-4318-aa99-af9b7c8ed53b@linaro.org>
 <e4bd76d1-e5d9-4ff6-8917-db5784dea847@ti.com>
Content-Language: en-US
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
In-Reply-To: <e4bd76d1-e5d9-4ff6-8917-db5784dea847@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 12:34, Siddharth Vadapalli wrote:
>>>>
>>>> Why is this patch incomplete? What is missing here? What are you asking
>>>> about as RFC?
>>>
>>> Since the merge window is closed, I was hoping to get the patch reviewed in
>>> order to get any "Reviewed-by" tags if possible. That way, I will be able to
>>> post it again as v1 along with the tags when the merge window opens. For that
>>
>> This is v1, so that would be v2.
>>
>>> reason, I have marked it as an RFC patch. Is there an alternative to this "RFC
>>> patch" method that I have followed? Please let me know.
>>
>> Then how does it differ from posting without RFC? Sorry, RFC is
>> incomplete work. Often ignored during review.
> 
> I was under the impression that posting patches when the merge window is closed
> will be met with a "post your patch later when the merge window is open"
> response. That is why I chose the "RFC patch" path since RFCs can be posted anytime.
> 
> For the Networking Subsystem, it is documented that patches with new features
> shouldn't be posted when the merge window is closed. I have mostly posted
> patches for the Networking Subsystem and am not sure about the rules for the
> device-tree bindings and PCI Subsystems. To be on the safe side I posted this
> patch as an RFC patch.

Ah, so you want to go around that policy by posting non-RFC patch as
RFC. It does not work like that.

Best regards,
Krzysztof


