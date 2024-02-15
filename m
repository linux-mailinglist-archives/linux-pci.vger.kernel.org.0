Return-Path: <linux-pci+bounces-3535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEB856B7C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706701C22B0F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2D137C54;
	Thu, 15 Feb 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w30JlcnJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264E137C3D
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019224; cv=none; b=E0oh5penM8LPD5Vs+JteplFe0jvkZvz3C5+WkQBIFocl0u7wJJ/7FZzJWCDVPWNdTuN/IBAO5sREks6OTCKVxCDv+qEdyKgnelRLHliYw3FglnRqjWhXl7zYXpGplcfdrWtljlee7ds+1bNHJqYnicgCTaGAJlHtWtLzIdUdKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019224; c=relaxed/simple;
	bh=6iHjAnqtb6WKmS553f33Msu3R11CMKdhBEB4L24+Blg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cImEppJLg0wglZG61CSZAWSF/lvsDJTCVxiuG8xDyCVIGXt+DXTtnmNpgp7NDXA+4ZYbxFyBShVXqIRXWPVzt/GxxMLcQBhQK1ZcD6/tkiRKD/Fi+ZqtRLkzDYiZulOqF8cevQgBLNMuybmEWndUSP7h/WKnRczUgI8ZlP2ZZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w30JlcnJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso545830a12.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019219; x=1708624019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qGFi4nYhTSGzwEyDxOa4rN/Cn5B1c0Et6UQeZJ6o04k=;
        b=w30JlcnJCYta1W/T7gBC1rd4XdIHQVh6h53ZftOKenD+xEGkFhdFPL1f9Z/4VaTvB9
         wkZEAon7YdXQWa26HzgQagx18E09v1MZvQ5KFz402+ew0g40DhR6hkav2/j3pP44+RZA
         IiNcQU+K/fXUs5s9LZh9fCPalrzLOhvcRjhfmKIstPach83jXUaIMWoKBWJWSl+4cpq8
         8EArTaeOoxh620zP0vRs0MXo9tVztVrWPtYrYYOvecc/7A/a5FL4LkfTkxzlo16Y8Um0
         UiQOyutmLcnGiX1dTHBYIW26HJdgFG3PR0jpbIqAwfGHrulIsLEV0y7eo8bHTJ9+oDx7
         Skqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019219; x=1708624019;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGFi4nYhTSGzwEyDxOa4rN/Cn5B1c0Et6UQeZJ6o04k=;
        b=ZFwVk8Ft5qROn48pZ+0oMBK+jG7YxN8YOCXPSIEa4zR2RMqNEkwHMfxSA09aJkiqfR
         30AyPwawaei+omFbFV144R4I6G8F2HcT+Z8qEU7URSmahs58cGynKdYuJCFGMadxOGnx
         uAxQD2IronAiydl6stazPBfB3u4Kz06MQhBFwqS/5Zn7BpCqGx2KSNOBnx1G5nGxR+od
         YhBLoUCmGVFltCFj/fYnUlXFqXdaBrmzABPsCoKIttcmfgm1uM9q48XqnqQ4qmrkWRUc
         OCgv2U+/D2ZzFvrVNauh9yFMOFWgeT201zJvxG3XmbtkTMYSepnPcwESKi5NaQ0E+OC7
         pBHw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7xqAldKCm27t+Pl7wArF6mydmzeSP3FZbOwCRQ1JGYhP1nGYeYbaRusTSnY4F3MVY7vHhy/DmIpnl5w2EJCWDHJ7KKH1fnq/
X-Gm-Message-State: AOJu0Yx/1yRP2wluTIPNXO9Bp7NfPH6b3GzOODPOIOnATbOjNJQ7tlNC
	7+RsgxNBQouKMu9MV9YpkZ0UNY8V7bWAIseR8WZZEHNBkmzvvfw3NGkVynU8LYdeNQvFfbWRkqZ
	G
X-Google-Smtp-Source: AGHT+IH6K2lKLxFkkaMzYt3eVZiWsV5RtSerOOoiiTmDmLRvoHacljVqFxweD8HfL/T5NauJN/AcWg==
X-Received: by 2002:aa7:d594:0:b0:562:d88:adca with SMTP id r20-20020aa7d594000000b005620d88adcamr2205053edq.17.1708019219334;
        Thu, 15 Feb 2024 09:46:59 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r1-20020a50d681000000b005638f04c122sm790193edi.14.2024.02.15.09.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:46:58 -0800 (PST)
Message-ID: <a12217ec-ce63-4312-a412-9a5c8d1d92fe@linaro.org>
Date: Thu, 15 Feb 2024 18:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
References: <20240215170258.GA1292702@bhelgaas>
Content-Language: en-US
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
In-Reply-To: <20240215170258.GA1292702@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 18:02, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 02:35:13PM +0100, Alexander Lobakin wrote:
>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Date: Thu, 15 Feb 2024 11:39:31 +0100
>>
>>> According to [1], msleep should be used for large sleeps, such as the
>>> 100-ish ms one in this function. Comply with the guide and use it.
>>>
>>> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Tested on Qualcomm SC8280XP CRD
>>> ---
>>>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 250cf7f40b85..abce6afceb91 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>  		if (dw_pcie_link_up(pci))
>>>  			break;
>>>  
>>> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>>> +		msleep(LINK_WAIT_MSLEEP_MAX);
>>
>> Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
>> function to pick.

IMO, fsleep only makes sense when the argument is variable.. This way, we
can save on bothering the compiler or adding an unnecessary branch

> 
> Odd.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/timers/timers-howto.rst?id=v6.7#n114
> mentions fsleep() (with no real guidance about when to use it), but
> https://www.kernel.org/doc/Documentation/timers/timers-howto.txt 
> seems to be a stale copy from 2017, before fsleep() was added.  I
> emailed helpdesk@kernel.org to see if the stale content can be
> removed.
> 
> I do think fsleep() should be more widely used.
> 
>>>  /* Parameters for the waiting for link up routine */
>>>  #define LINK_WAIT_MAX_RETRIES		10
>>> -#define LINK_WAIT_USLEEP_MIN		90000
>>> -#define LINK_WAIT_USLEEP_MAX		100000
>>> +#define LINK_WAIT_MSLEEP_MAX		100
> 
> Since you're touching this anyway, it would be helpful to include the
> units on the timeout.
> 
> USLEEP/MSLEEP is definitely a hint, but I think the "SLEEP" part
> suggests something about atomic/non-atomic context and isn't relevant
> to the time interval itself, and something like "TIMEOUT" would be
> better.
> 
> I think an explicit "_US" or "_MS" would better indicate the units.
> 
> This is turning into a long tangent, but I'm not a huge fan of the
> LINK_WAIT_* pattern where I have to look up the code that uses
> LINK_WAIT_MAX_RETRIES and LINK_WAIT_USLEEP_MAX and do the math to see
> what the actual timeout is.  Obviously not fodder for *this* patch.

Might as well do that indeed

Konrad

