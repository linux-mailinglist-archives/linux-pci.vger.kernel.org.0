Return-Path: <linux-pci+bounces-39758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC8C1EF2E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9879423766
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057A304BC9;
	Thu, 30 Oct 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3HIYDqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017423BF9E
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812191; cv=none; b=U/ZrHYId50GtGfD49SMTjA+wUMZ5tyvMHZpE+v0YICUYYpP29Zjkkg9AFSXf3ch0AGK6I7Qre6+n4f+zKAGPBCKqn6ytqfYwsTIkAsx3cvtwTbsEslaWrrYMVJZs5VKPe5XzqfKcey2dSr15CF0MQ5zdiixWZj/DB1V2ImNebJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812191; c=relaxed/simple;
	bh=3pr3bE37JQekr4KteuJZhkqEhETeS9zVBmYKEXCpNBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwHEvVG68ZkGNaJlonm66iJtxcrluns6Hh3Qpg+qbM5BM9SpdRbW1H/hSuVgzvamDdwjgOVuEX3ZxVGnEnBqJwt7+WabUvowDvUmG4pvP8pj6XPn0EuCEH1Xrpd+0lw0/UUL95yKG8RoULNNlEbyKzFAT/LniLuqo3ym9BQgifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3HIYDqY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47107a9928cso467685e9.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812188; x=1762416988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4G1KZQl6cfiM/1J2+KFKVe0bth/8npRuFzDKYpdfXY=;
        b=G3HIYDqY2EKikOV/FyYL7VAxpw3M8Ha803qNMCbKHNpi4/br4ETfGkpRgVoLG7dWam
         90SVCko25GrK4arydrJVm6zWvzELmXU8fmkN4DQ6/mQrhHKxIbsyoFThu66+84QAS2fv
         pKl03heLbaZFeLqwFF6kJ61Jhh2ykJN6EqIa5xRts7nHybQkqMKgtB1dyqBVdZ6G2Rf1
         WtceGL+l+LzWwLHgLtvbc8Z+W5r+oxLTz66/9VIZ1OzaM9rihHNYW9UCPJvYS+8/ddTE
         YX1E6IyMM3uiRvL+Q/dLKtMf+oCqSrAAkq0l90EoW5tukTQMB/awbfQ3nuq5MAjD+re6
         0h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812188; x=1762416988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4G1KZQl6cfiM/1J2+KFKVe0bth/8npRuFzDKYpdfXY=;
        b=ARA9eZdZx3eUYw1qr+Ut7uqfX0CAQuLiUugETtMrMfdHQnTt7kqXoQRrGGFljvmjIA
         PDSRnoSaZcMbtzzwrSeG9zrV8M/bX4FA+O3TwNsfSZbiFklsEOsw+gR10HvXjWlB8TN7
         LR+LqPp94hEJsvBP2WDmKA0BrCy+2oUtPi2I8flocrTtC/pjUaA6xaHKKK3r12iXPKe0
         eO0X6S73Xc8ELz6fMESKSOS03pAXh0iBivC6+IigiWtlDW53KhnW8UAD8h7zBKCXKYpp
         tiY+0aQZ68N6JCQfA0M1uxDcxIc0ZjT38hQ+Xnwx2x95nu8aB6BAfny46VbKtD23IJWv
         cMoA==
X-Forwarded-Encrypted: i=1; AJvYcCUeoAliSApbXsFUqGx4idcBat0/WZOF92+6ee6e74YyVsEkMv9hRaOLAtB1mQH4JtqCZrQSo/amfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFp9uexZhIv3j4PmhdL6yGG0sElXMpA5fxbJl6uvWVXpFffLH
	Yf9hMJH4QV6lYol/PzKLQirKywOSlFsbXfPeZx9bYrbVEn8N3Sl7qthlK66XDCYbPRA=
X-Gm-Gg: ASbGncsB3OjnO+6Myfhtk0aFxfMOTPVLig/DVBU4vcnBPJ8Ty9NJsNnnmqrddMCzZkz
	moZbnj4jyzxHCTpiM5wViGQNC6UAXf9yFymKWOS73VPRQSSdlmGyd+qen+Ip1LIlUqbyK9k3ZO5
	vs4ZYB+Fv09XRDv1VrylET9pXne1DkZyMk4YQdAlRUtAy38fVwmXxbCDw8KXwCKBmXdEdYZdanz
	1spabNvnDw1l7Bozagtqe5jgkU9SaPKqalswi15Q9u/TOzD9lMJsrP8R3fcsF+GDXy3pmPyEjab
	UFFoH2oyrgafqWSOvgYoZTmZCS2fUHlm4nyug8i1BG4j31jL8WGJ1Q6FYJoZgxcuo24VpWdFtnk
	AChFMVVk8jBpqAawwmtzQ8vdpRTq8EXeaRavmej5pEj5pEMS9HDrFJvu6OkgAPBlqrWkuSQOCgI
	i2au2g0JPj5R73x3+UxPDn
X-Google-Smtp-Source: AGHT+IGwDYhY1y/SPYtXSVRvAki1Qhjtezt3Dx8lpKGDfc9ZEto5uWUnib3MEpqw2Tpt3iFbZQ1uAw==
X-Received: by 2002:a05:600c:5251:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4771e1e3c66mr29643195e9.5.1761812187736;
        Thu, 30 Oct 2025 01:16:27 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289a5625sm26670275e9.5.2025.10.30.01.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:16:26 -0700 (PDT)
Message-ID: <a0d9d5b8-8c6c-4da9-a660-4cbe0bfc444a@linaro.org>
Date: Thu, 30 Oct 2025 09:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
 <aQJE5kkOGh76dLvf@hovoldconsulting.com>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
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
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aQJE5kkOGh76dLvf@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 17:46, Johan Hovold wrote:
> On Wed, Oct 29, 2025 at 04:40:46PM +0100, Krzysztof Kozlowski wrote:
>> Power domains should be required for PCI, so the proper SoC supplies are
>> turned on.
>>
>> Cc: <stable@vger.kernel.org>
> 
> I have a feeling I've pointed this out before, but these kind of binding
> patches really does not seem to qualify for stable backporting (e.g.
> does not "fix a real bug that bothers people").

I wish stable users of DT bindings (so some 3rd party projects or
product trees) keep testing their stable kernels, their stable DTS with
the bindings, whenever they upgrade their LTS kernel. And if they keep
testing then they should be told about lack of the power domain. That's
why this is for.

Of course fix impact is pretty small, so I don't mind if the stable tag
is being dropped here, but I will not resend just for that unless PCI or
stable maintainers ask me.

Best regards,
Krzysztof

