Return-Path: <linux-pci+bounces-12247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C399601CF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FFD281C8D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECA8289C;
	Tue, 27 Aug 2024 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCd6ofim"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44584179A8
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740539; cv=none; b=gFARZfutrZAMDpNO1aa4/mqnPPsBbF5ZIhiEoFk0eLmkCMHUYQ9wBLZ+q7qVqsnVlJq8O4ScloblkwzXaj6Kd1jZ5WnpXqlHiMP4Ep7d4qA57/MaicyNQ5AskS0l/AHXZ3gQnvx65dIn7ndbLOtLQmYOwnopbgDozcw6Q4p9bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740539; c=relaxed/simple;
	bh=nY0/H3WOUrLfgv5L/RMNt/knVUJQ5epgSeoWM5zheLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLVEQzQ622VIASOX6IxPSlS6o/iweZLEBiSXJAhkBf+zfepPvLIFoizmSjfq7gBUweHNFgl/5+D8uUVMFg+Ml8eE/BpGQenH90yyswwHXydKFr5uPY6CoFzBqYN6pDC6pOkKOGtSOFwia3pyO2aeNOfXjiN1iF0XmL0T6SH3jdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCd6ofim; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42b964d7526so1981015e9.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724740536; x=1725345336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lS8pYIjpKxHllTTCGlIdW+0lwhgCRiezC87UqPm0UP0=;
        b=sCd6ofimipdVTcQbIVyS0DBC2nqrRyOuCqa7yfh2SaNp5JsdVdO3HFxog1OmYwomZq
         CE9Xby5pfUMraYFbj2oyUV2kzxPjzSlxUzIk6BTupIgM+cTwwdpSNDHYhybbJzENiuCR
         hNpvL7bE/hk5HT9yCPocWhgdaYPUqp6HIAzCSCI2C5065zy5mEYGgu7FnrAQDiZOI2/o
         hPOsEz0AES3COZ9w4Sua0YntB0TIBmf6xewTJJAc5YcuEv1QbZGGW1JK7SWc/YGycSgT
         SS0Gf4PWbezW+sbvnl8NGcVuC3En3irn6ok+1Uf+wXAPcMjycfckDt0LfAj14h+fRhO2
         cmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724740536; x=1725345336;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS8pYIjpKxHllTTCGlIdW+0lwhgCRiezC87UqPm0UP0=;
        b=FCDlVPcjRlmhpVJmFvcaHTAZQn4Cc4GpAoptG5WFKl5OpqA3KYrb7ihCzPzGW3PIwX
         4RkH9azk1Kx9TkQmgiKv2q+PkDeBdBDv6yPCyaXjzTLD3J1OZbTJBCd/Bsa1kQwTZrWU
         OAHeMH85MuwdPIdYZlBaPnL35lZZiFG6Tn5bdggsTmOwtiqWoz42xQfLO9cOWQF9EbEL
         WYRGiGobpQi+yrSyj//oFQA/k/4bc22kavRJtXhEeTbUTcWFcuf2fGRyt2dUKR4l/GGf
         2T6cO5JuGylUDFjd3LvsRp7rp5hCM3kwdGEQc+3qrJRbdYOWNYCLMsfwa2E9F7gyDrgK
         p6dw==
X-Forwarded-Encrypted: i=1; AJvYcCXhNJrT82+Rp0/5xddmgCTrnQOj/8s6OxgfvJMihUZ9nOrJxRUL6ulD2P4A0DPWNVeyTFhkGYMMAfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpapM8x1SncnwC4QriLOPiVcyacxGMMpYfeWHbwTJ+LRpXh/XL
	kEhQ605WOObSFS86RytkLFPUI0aD7PVk4D/RePR3JqEhwxD7p045sOx4/C0EwO8=
X-Google-Smtp-Source: AGHT+IEQBav1LoTijqFAOUgGVRHn+h7FMFAoykM1EKo1Lgse2BJSGKqScvQ5+HBXOKGMZ4jv+TZZ6w==
X-Received: by 2002:a05:6000:1f81:b0:373:6bf:95ea with SMTP id ffacd0b85a97d-3731185f73cmr4627255f8f.4.1724740536466;
        Mon, 26 Aug 2024 23:35:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821adc2sm12307479f8f.91.2024.08.26.23.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 23:35:35 -0700 (PDT)
Message-ID: <2b368426-a572-4d3c-b991-9532fa828d23@linaro.org>
Date: Tue, 27 Aug 2024 08:35:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
 <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2024 21:25, Jan Kiszka wrote:
> On 26.08.24 20:53, Krzysztof Kozlowski wrote:
>> On 26/08/2024 19:56, Jan Kiszka wrote:
>>> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
>>> against DMA-based attacks of external PCI devices. The AM65 is without
>>> an IOMMU, but it comes with something close to it: the Peripheral
>>> Virtualization Unit (PVU).
>>>
>>> The PVU was originally designed to establish static compartments via a
>>> hypervisor, isolate those DMA-wise against each other and the host and
>>> even allow remapping of guest-physical addresses. But it only provides
>>> a static translation region, not page-granular mappings. Thus, it cannot
>>> be handled transparently like an IOMMU.
>>
>> You keep developing on some old kernel. I noticed it on few patchsets
>> last days. Please work on mainline.
>>
> 
> How did you come to this conclusion? This patch set was written for
> mainline, just rebased and tested again over next-20240826 before
> sending today.

You send it to addresses you CANNOT get from mainline kernel. There is
no way mainline kernel get_maintainers.pl produces them.

Best regards,
Krzysztof


