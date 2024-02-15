Return-Path: <linux-pci+bounces-3537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA583856B82
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D712862FD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDA137C3A;
	Thu, 15 Feb 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mqpx96TB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D695137C32
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019299; cv=none; b=TeD6j05M2fUnkHRyj1W7IfEu3jHyDlYlH6mTu6m9DjPt5mNIbQifFJrlXCeikoH4qwi3LAX1poew6FjFtWhF4upmJl330KpRqKKIeDGnegsOXyr0CYtRq2m315032qVaDkNDKke6o0+4S3OgsialQRRoi6RPraKBOaJLfLREPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019299; c=relaxed/simple;
	bh=Dt8Dfhv0KYo07qrCHA5x1pJBOjl5sHRZCS/sDgBwHEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiT4Ao35e0saT1m+vzUWjJtELeB5hKZA4cRDm/KkLGflaGPJFbH+k0bBWFyUT6xugQL48ha/HZIo+XbNhMuD6FSIoB7RNvn6KPGOBzb94DJf+hEd+tQJnEaES2yExMBHvcgEkflDtQN0Pa+wuLG8/VPGVq+nwL3p7tJUNdaWjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mqpx96TB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511a04c837bso1321970e87.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019295; x=1708624095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDRPEsVl18wfCmnlXfXdVDXZZ1/0kETp5RT+YO4+BJw=;
        b=Mqpx96TB3I78McgxJSV9m6BObXAxXSe8GBB+QaYAtCDEkNdAmJpkqY7winN86LjK4S
         0OYXZkxISG90zg9nsoO/uP7kS11bpLhT+X+jIDKy5jTWom5FY4p1XhkrrfJ4vq0N0eSX
         BsNnHuvaU7n7XH+DxuCbTZnIIUmGO4bSO3G3LrCCjvHf6xQgLT2MO7jdsMEOckYn/Bql
         hblYPHEeoJoE2yEkwOvlEnRrQkupjwoZ9sJHPkuNc2zOLLuTlcupGqaqBlf28xvo1744
         bYC8eja0J6hTRiFHFyvrbowc6OdzcNq8DAx8zKVFLy2nfoHfDd3TllgMTlKJruI8ALRj
         LBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019295; x=1708624095;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDRPEsVl18wfCmnlXfXdVDXZZ1/0kETp5RT+YO4+BJw=;
        b=E/d94gmCMha+zn02J4N/m2IdZcWHfxjZ+b0hupBIfVNeiTS8ksnarVpxljQ0VQF6uJ
         767mFxnHzCHGFZQ1nMo9wiH3qe7jU3TzDEGLZKBA+jw80WLU/dEfafrePSggqIxy1rRX
         Y0zshrqvbrdvYah//jPi8BzTjVpwKng64qL3/09FXKK8jzGiPf9YhA56SxNp1TO3lmN8
         VE26sRGpMSxmqhRteoSCzE9+O8UPAC1gais1TSiwunp5R8a4/YcE3Qytn0s171CXJtVa
         gJL1esdOsG6XOG8XDE5gfxiz/pfu1l8KAoXtcD+WOEh2VHs9KX4x/bIO4vYFb3PNraMu
         /JCg==
X-Forwarded-Encrypted: i=1; AJvYcCX9CzlN3zqFppCdxp0TmqgsYfaOEMKXrZ5tETu/Nm4u+YuEQWRRtyQrrlKb0pcK8JJuOdBMo3dDhEgVKmodrW+dHtznTpUe/oSA
X-Gm-Message-State: AOJu0YyVsfnyi7a8HohYTl/10kvaYs/c6qxX1w6pobyo9rJ7zrqdybG+
	BAtwX9A2ZQ7EqiYMSIu0LodcWFwh2lvZiAmJBhiINCvTO0wB3Dk1zslzR2ldPWY=
X-Google-Smtp-Source: AGHT+IH+DDidS/qWlWAnaKHYhVQ4/oQQG5fntEcyum7K8rd28y88HERLLrjZsuTYMPNK3nFmDHDUAw==
X-Received: by 2002:a19:ca53:0:b0:511:acd9:c10d with SMTP id h19-20020a19ca53000000b00511acd9c10dmr1652514lfj.40.1708019295073;
        Thu, 15 Feb 2024 09:48:15 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r1-20020a50d681000000b005638f04c122sm790193edi.14.2024.02.15.09.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:48:14 -0800 (PST)
Message-ID: <a09e5b69-7938-4da3-861a-4b2fbf827552@linaro.org>
Date: Thu, 15 Feb 2024 18:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
 <361f7ae0-6de1-423c-bb64-82a5acccb502@linux.intel.com>
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
In-Reply-To: <361f7ae0-6de1-423c-bb64-82a5acccb502@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 15:51, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/15/24 2:39 AM, Konrad Dybcio wrote:
>> According to [1], msleep should be used for large sleeps, such as the
>> 100-ish ms one in this function. Comply with the guide and use it.
>>
>> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Tested on Qualcomm SC8280XP CRD
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 250cf7f40b85..abce6afceb91 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>  		if (dw_pcie_link_up(pci))
>>  			break;
>>  
>> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +		msleep(LINK_WAIT_MSLEEP_MAX);
>>  	}
>>  
>>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 26dae4837462..3f145d6a8a31 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -63,8 +63,7 @@
>>  
>>  /* Parameters for the waiting for link up routine */
>>  #define LINK_WAIT_MAX_RETRIES		10
>> -#define LINK_WAIT_USLEEP_MIN		90000
>> -#define LINK_WAIT_USLEEP_MAX		100000
>> +#define LINK_WAIT_MSLEEP_MAX		100
> 
> Since 90 ms is an acceptable value, why not use it?

I suppose I can do that indeed.. Usually I go for the safer option
when cleaning up old code, but you're right, 90 should be ok

(unless somebody has some documentation stating otherwise)

Konrad

