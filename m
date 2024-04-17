Return-Path: <linux-pci+bounces-6352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585178A84C8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EE91F2036E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B813F01A;
	Wed, 17 Apr 2024 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKpS8zwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAC13EFEE
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360879; cv=none; b=J1kLlVSGSqvnBcMO5u+UonT0d3COdKsz+huXU2whzcM2WY5HY7D2U1U76SQQb1N38mruKwuqb/4S9Op862WKyvAX7Ib5jhxPzs0tBE4CJIf4Jwq0qt41ErjTzurma1QSvvJJG2pKNJzBMoOkNAGuo/tYxmqmMqEEFSEnIks/Nfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360879; c=relaxed/simple;
	bh=alH/EZJM1d1TCFDY15jFAXlKwQO39PxcOVlCV8uY/dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRh5Yrx52AQLcQEXO6onRTdnhS5UtWht8sH8gBhJvM4+yJIMwJemtfsonBZJEQjB2rb4sWGfiwMNtxsOILEdZ2eo85WqkoO8cFpxFoZbYumxzSA0HnBpqhHhC0gGPu8djveQOkrPMBnAnmRv7r9Yd50Vo6PtNDCfyAm/7TZfzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKpS8zwe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5c7d087e1so38089905ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713360878; x=1713965678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQpk6M7q24ajxJBZjKob9s9mchMKviv3ZIY6EByy4P0=;
        b=GKpS8zweXq8tlhYKHP7xb7KrjsVHQbVYHaPd0AQRby8ZW3EXsep7JSSegFR6O1xSg/
         baqp8/6SFZCubZr1pNl4XKxcEC26Lcb5f/Wwiuk0hCmY0yWBiPxPxxaK7FRdwT9CL3nV
         YUsZg/A9nRcilxuRwFSRTWCu5dO3IpOQJc39bSj4bS3X6cR/tS+1FuUtIF2REsCWA5eM
         B7oiFlen0jVQ60dChR3HqYe7vKkgutSPSqcgKSzCBBceoQsvnfGfe8/khVXo67vyPWd6
         C0JCi5EOlI62oTJaJUhzJAOVIOi8YEn0qrHFqOz1bYJz8wuDxvdSMq1oloGnEhvC2mPe
         3MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713360878; x=1713965678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQpk6M7q24ajxJBZjKob9s9mchMKviv3ZIY6EByy4P0=;
        b=R7zTU2A5njv4cOwftwoXJRJciar+ru0OpMQr3TpJEfiF5JfsX3+GJB3WoWdjv67++M
         6kWd+2NRdyxFFrg2RKGZMWZ28YpsUvKz6/gwQhXKhzev/pORU+efZxJ0zoIVMkYw3yiZ
         0GpyPeaYnupA4dYKbYt+h1LZuI1grsa/5vjG5+vYLcLuteNusnCgfXP3mKoRzp3M4K0e
         b5fvgql6MnNLep4vJ94LMDDoK2kByC/zFHlPqdJ9VvdEt6jqEhBp0R3nPZ7iso/NlrtV
         hoWpSgae9jMpdKD1n0DRbuUmXAEN14EzaeNh4ly3QWn+o1r9gR2VEnmAmTgK7E9fbg2q
         wo7g==
X-Forwarded-Encrypted: i=1; AJvYcCV473olfJ9c5nnX8qti4n7QsHkgojHanTuxST6XE+G+3ygn/qGSqPBZXHiUE2PZnHPMRlLIyEKOBKoFWsQEqMmyw6Rm3dhdPvkk
X-Gm-Message-State: AOJu0YyBwpw2XpzcJAGJbKSO4kZGOIJ0bn6Iu5B3W6W4YIhmTDN5hnTP
	2rUg3MdZCidxiJKWj7zV+k+n8q6DsZ1Z/G1QyyLTuf227B8sFs30sLJTYHAYBzU=
X-Google-Smtp-Source: AGHT+IHNFNE8rpBby9S+K49GhqlBngJX8LZuUeYNpl230n9/7QUVMXSQQnsuylZ2sfm7+Zh0iPKPGQ==
X-Received: by 2002:a17:903:22c4:b0:1e0:b9d0:f6b with SMTP id y4-20020a17090322c400b001e0b9d00f6bmr15384739plg.68.1713360877982;
        Wed, 17 Apr 2024 06:34:37 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b001e5e6877494sm8408204plr.238.2024.04.17.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 06:34:37 -0700 (PDT)
Message-ID: <27686f2a-a517-4923-ba6d-58233cf149af@linaro.org>
Date: Wed, 17 Apr 2024 15:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: PCI: altera: Convert to YAML
To: matthew.gerlach@linux.intel.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240413172641.436341-1-matthew.gerlach@linux.intel.com>
 <c21f6d49-bd70-465e-a446-fb70838bab48@linaro.org>
 <alpine.DEB.2.22.394.2404160720360.424541@sj-4150-psse-sw-opae-dev2>
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
In-Reply-To: <alpine.DEB.2.22.394.2404160720360.424541@sj-4150-psse-sw-opae-dev2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 16:32, matthew.gerlach@linux.intel.com wrote:
>>
>> Why Hip is the first? Old binding suggested it to be the last entry. It
>> would also make binding easier, as you describe reg and reg-names in
>> top-level and just limit them with min/maxItems.
>>
>> Does anything depend on different order (Hip as first)?
> 
> I don't think the order really matters. So Hip could go last, and it makes 

The order matters, it is the ABI.

Best regards,
Krzysztof


