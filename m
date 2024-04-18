Return-Path: <linux-pci+bounces-6462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AF8AA467
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 22:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5071F21270
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D64190674;
	Thu, 18 Apr 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhAvhs8M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A3190661
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473624; cv=none; b=JHwMUKhOvnBcm9daQ+v2k8YwHtJhpTDZhowoyVTxxre2fKlBUzTo4Ja/RaUAyAptuuZoEkd2nRtWZDjHOksuPkAiQAXj78fS7SLllNoeag+0JWo2m6M+gHQTcz8P+blwpGeliM/+Is+N8F+b84Mdp95i/wfAXoj+XELSZ9q3yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473624; c=relaxed/simple;
	bh=w8qzSdpu/SCQmocJ+CH2deWP5k6I+zFiM+IUq/6rudw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZQ4pwf1fTtf7oA4TiLZzKpA0yav4PBdD3wzB65XHONJKpbzynqhe4NSfIGzSkvCZqO6v7gsoh/jQvkD+nleBAYRchQBddQKZjqNkoaqHllGoRUUFoBX54ymjOhmiJANQkvVmAfiHytCDnNy7LftBCGXUIRtU3hwrkLLXVDm/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhAvhs8M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1648822b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473622; x=1714078422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LN/OEbto8fHfbuWGWfKxktnpDKBf8NomrA6s+e0fy8U=;
        b=vhAvhs8MnEIdqJglnuUOeMdr6bjv07+2Eir4g07MVDj61qFJaP5Dd8OsNhNf4Lsg93
         4CoE5Aicjxmaw/kgj2GNag7rAgQ+VjM4yhzM8PS8jz24HxFauVoUkHOBUOe+oR8poD3S
         2f5NLaN0QAieAkuAdxK70F8if6WAg+IbeKK3oaQuKOxGo75Wxkeg+SUa4jG9K40U21BU
         wuI9ZLV12D5+jnbtoFgdtqhXR9DkbjNDnOi8HhLfUGXL6akpsQkKk5lVi2hZS8abPsze
         CoDSyYeI8TzZldDYQOt9FQeXTDNGt+RPGBQa3FQH853riy1hTIVihqODXRiUN15XmgGU
         cm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473622; x=1714078422;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN/OEbto8fHfbuWGWfKxktnpDKBf8NomrA6s+e0fy8U=;
        b=E+1GsAOuhndljTBndYdaOErPfxT3JtcFh+BhX/4CILIO7MdwC0zoaoA1HwFYLhp7Jl
         qYcuaYc5+YgFr1lfBEYqrfh3xyYLLoTA6ihhK+NPk0g03eeLsYsi/yWWAX4DBiLC5VS/
         6KCl6bFiqy695cY1z+sXkYPJcqYA8a1SHjQJA5RWBptOZtH/fbZ4W3Yiclq/6fyGz/X9
         aEGcOjg0TbxN25ofNcqoYGOyiU+5F/rIC2GUKcwZ/CLlm7Gj+EKoR8GZ1Cso/qS9GipT
         ZarIi+Uow6aayjOHKbjugzQKMXfT0tLfGTum+uTgWbvgMDFeWSAlVHQpj8h9ImoJR52X
         LYZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9CoAD/pEeNof8DIQIoiOH2CH4hHbCxzOKsN/TovbBeaTatpuBO/X0AgxOlcR9bdDefD8+ghRc+9c9+G0MX/sXqZTPb1tBk+Z+
X-Gm-Message-State: AOJu0Yx2VRcVixvkVMFzNs0jJ+JKdTE5B0bW+RllfbcoKR7DBzMZ42SX
	58SktkFv3v2ZLfnkB/uoDlW/uVTxRv18hpfTC77kfna67Ic+K3F1n2LRX1TfAyDSZ+Jmw7pmORP
	6w2k=
X-Google-Smtp-Source: AGHT+IGY9MOOiqfPFnmjuPCesBJ53bCB4xW9Rw5ODTMkZqWS3OHvOCFbvjRw9F0Nb39EsuCphGauHg==
X-Received: by 2002:a05:6a20:1054:b0:1a8:2cd1:e493 with SMTP id gt20-20020a056a20105400b001a82cd1e493mr400447pzc.29.1713473622217;
        Thu, 18 Apr 2024 13:53:42 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.147])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006ed26aa0ae6sm1930377pfb.54.2024.04.18.13.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:53:41 -0700 (PDT)
Message-ID: <8e620885-9585-4ced-81c0-c1979decdfbc@linaro.org>
Date: Thu, 18 Apr 2024 22:53:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] dt-bindings: pcie: Document QCOM PCIE ECAM
 compatible root complex
To: Mayank Rana <quic_mrana@quicinc.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 andersson@kernel.org, manivannan.sadhasivam@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
 quic_nkela@quicinc.com, quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
 <51b02d02-0e20-49df-ad13-e3dbe3c3214f@linaro.org>
 <1d6911e2-d0ec-4cb0-b417-af5001a4f8a3@quicinc.com>
 <ce17f2dc-decf-4509-969e-e23bdef42eb9@linaro.org>
 <708e1adf-833d-4de5-9e94-406883337d16@quicinc.com>
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
In-Reply-To: <708e1adf-833d-4de5-9e94-406883337d16@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:56, Mayank Rana wrote:
> 
> 
> On 4/8/2024 11:21 PM, Krzysztof Kozlowski wrote:
>> On 08/04/2024 21:09, Mayank Rana wrote:
>>>>> +  Firmware configures PCIe controller in RC mode with static iATU window mappings
>>>>> +  of configuration space for entire supported bus range in ECAM compatible mode.
>>>>> +
>>>>> +maintainers:
>>>>> +  - Mayank Rana <quic_mrana@quicinc.com>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>>>> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: qcom,pcie-ecam-rc
>>>>
>>>> No, this must have SoC specific compatibles.
>>> This driver is proposed to work with any PCIe controller supported ECAM
>>> functionality on Qualcomm platform
>>> where firmware running on other VM/processor is controlling PCIe PHY and
>>> controller for PCIe link up functionality.
>>> Do you still suggest to have SoC specific compatibles here ?
>>
>> What does the writing-bindings document say? Why this is different than
>> all other bindings?
> Thank you for all your review comment and suggestions.
> 
> If it is must to have SOC name, then I am not sure how 
> pci-host-generic.c driver having non SOC prefix for standard ECAM 
> driver. I am here saying this is QCOM vendor specific generic ECAM 
> driver. saying that it seems that I would be updating now 
> pci-host-generic.c driver to add generic functionality as Rob suggested 

I don't see any problem here. I talk about bindings, not driver. You can
have also fallback, so how is it different than from existing code?

> part of review comment. With
> that I am seeing possible options as i.e. continue using default generic 
> compatible as "pcie-host-ecam-generic" OR use new as 
> "qcom,pcie-host-ecam-generic". will this work ?>>>> +

Compatible and bindings focus on the hardware, so just write them
describing the hardware. You keep asking it in context of driver, but I
would say it does not matter. Is this generic hardware/firmware
implementation or not?

>>>>> +  reg:
>>>>> +    minItems: 1
>>>>
>>>> maxItems instead
>>>>
>>>>> +    description: ECAM address space starting from root port till supported bus range
>>>>> +
>>>>> +  interrupts:
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>
>>>> This is way too unspecific.
>>> will review and update.
>>>>> +
>>>>> +  ranges:
>>>>> +    minItems: 2
>>>>> +    maxItems: 3
>>>>
>>>> Why variable?
>>> It depends on how ECAM configured to support 32-bit and 64-bit based
>>> prefetch address space.
>>> So there are different combination of prefetch (32-bit or 64-bit or
>>> both) and non-prefetch (32-bit), and IO address space available. hence
>>> kept it as variable with based on required use case and address space
>>> availability.
>>
>> Really? So same device has it configured once for 32 once for 64-bit
>> address space? Randomly?
> no. as binding is not saying for any specific SOC. Depends on memory map
> on particular SOC, how PCIe address space available based on that this 

So specific to the SoC, so this is not variable.

> would change for particular SOC variant.

So this is not variable and you did not provide sufficient
argumentation. You basically did not provide any argument, just
disagreed with me. Bindings must be specific and all fields should be
constrained, when reasonable.

Best regards,
Krzysztof


