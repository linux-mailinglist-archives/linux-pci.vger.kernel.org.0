Return-Path: <linux-pci+bounces-3468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD768554E6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA031C210B8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD713F014;
	Wed, 14 Feb 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJX2R8SM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5913F00B
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946522; cv=none; b=UDUlORx57UtwB6qrvnq2so7qXC7yoIKXAsbG74P+HCek3xJbyD0hK7uRDnSE1QhyCvovifgMHGruBNaxotwd/vEhwaXgOFmuWBXmqNODWySUFpoVIUSkRcHy2PRbJsNSSFAzM1pvGtf1gM+sNYBjAy8IqMtHmhKs/uToXXp62r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946522; c=relaxed/simple;
	bh=Ordcg0/SZituwraob8gVWOitjCR9zHa3yn1RsgecL5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGf9U8holK7iUiM12MYBz0BrY5jdfY/QT18OKhFce4Da2vZkcvMnpb3fdOvaQ7lfcKyKjBBehEW/0vh2D3NUMy7tb0u+zGth1tOnSfWoOzdBLM4vwNrSNqLXdka4GgyX6Bpr5UK5BY8xBftbwMEcBQSblMgd3W25Q3wrHOFe438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJX2R8SM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d0d26182dso16146066b.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 13:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707946518; x=1708551318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdvjajy/m8WQq582LYwS0Ial7lo5kPNQuYwBh1wlPaY=;
        b=xJX2R8SM0luOhBl4RlTOBwyeYW5LwT6QRMNY+AYjeLlEfVKx70Nixmt71Zs+nWA+QG
         woPBfJE3iOfCNqG9WPfXM38or7YRSvc7RJsF9N/JubooPaBegc33RXvpN8SWLobMOquj
         7tez9hQyykCe25tWlwwl2jhq0s+XM/w4GA0bpZy1L4zWpfqwjsa+2+0pj0EwZW/PnN3l
         evMik/PXrBE64Bu1GIob+8XCpTym/CeZZuxuyxescT4J/huza/OXGFlTSbTdkURsEN2i
         i7QHc/EHJCLh5v2nqH7u3x6OQgIJSZJJI8NAn2BfC+EZoeXkTrQNAyXW4lARhrTt8jxu
         9S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946518; x=1708551318;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdvjajy/m8WQq582LYwS0Ial7lo5kPNQuYwBh1wlPaY=;
        b=YcUsr0B+OpG1lhSXDWh6nGMYcuMI6LBnYm+9CEqg++JU7WXoi2zOAV1xFWQ4qQjgUX
         RMebhrP9kbaOAMLhtX0hr68J/fvPmKT0rdg04+lunxLX2oOQTdykLBiu+n0lToo70klI
         mmVWjs0KWeokVmQ8tgUvUpnp6L+Y/AhBhtmu+ICA2haUievJJRM42pU+rd/61p71+UQH
         EccQARoH4eOZmaAG9nLH/yI7s9jz9UayzydU3rbj+DRDztqfFVIXUG4DIzanVB42lEuV
         6wQhAXIWcWqKkXWcuBRoxGtM1pwEw/l8WJ/tGosjFW/891cp6B1EpRs/VGo6+01aR61M
         q9tA==
X-Forwarded-Encrypted: i=1; AJvYcCWcp0dsVy6Oth4XrBTqf0uFDjIKmQjgQ7o/Cr+XZUD52Rht+qXqbbrig32knC/V8dZz3/cE3ZxKjC9wW09/s6aBEPow6J/fnMq/
X-Gm-Message-State: AOJu0YwsPREnVFceaDqqlKmph4IFWkRrNyL95uileuCkjaUlS9Tyef41
	SFvcWpOMpIXcwkACI2snPd9yqgzE2QXbZc0k1xbr4pNfa5ojPaUTBl+BiR0qFNA=
X-Google-Smtp-Source: AGHT+IEvjEFDuyialvCzqpnCT1km5fx24sWbsQ0l2amvxfgmzusDS6C1NrfrsqUKRXLYHikLfmZNNA==
X-Received: by 2002:a17:906:408c:b0:a3c:c11b:e260 with SMTP id u12-20020a170906408c00b00a3cc11be260mr2414974ejj.68.1707946518406;
        Wed, 14 Feb 2024 13:35:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXM8km0OZWEuOrPr0p/jvnXfD02vFpBJnfmEIAFkT/zO1xCp6k0ZUYyz7nQjhn0CUWRviZS1ZagYUQ23viySYui2TsFNGP38uvvEksQKG26iel2B373tftuPS4X9sbF723qopxtUNqt/aJxy8U2fbO/vs4rLCgGJDemaYdQ2xbWe74jySij+qKlrD+3CmxuVjl/Q9DyDa5Fp9qG3dQ31FfVU6uITMD14WYDLA4Wd6gZ8eHE5L6HX5bPAheJsdRmEO47bnlyPx6YjDE4iDCtbGwW7rWRPRZNHPL2DrqvZmdif1XozKXiJez18+4+/u+fe6Kzf4JriV2PXnh6TNiF71IXEuOrgad/l5r7upylUN5sk/Ok23Msk26duQzgUMRpTtHXDO6Q
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id tk6-20020a170907c28600b00a381ca0e589sm2666887ejc.22.2024.02.14.13.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:35:18 -0800 (PST)
Message-ID: <26015e7a-5e3f-471c-aa98-46a0dfb4d155@linaro.org>
Date: Wed, 14 Feb 2024 22:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240212211703.GA1145714@bhelgaas>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <20240212211703.GA1145714@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.02.2024 22:17, Bjorn Helgaas wrote:
> Maybe include the reason in the subject?  "Read back" is literally
> what the diff says.
> 
> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
>> To ensure write completion, read the PARF_LTSSM register after setting
>> the LTSSM enable bit before polling for "link up".
> 
> The write will obviously complete *some* time; I assume the point is
> that it's important for it to complete before some other event, and it
> would be nice to know why that's important.

Right, that's very much meaningful on non-total-store-ordering
architectures, like arm64, where the CPU receives a store instruction,
but that does not necessarily impact the memory/MMIO state immediately.

Konrad

