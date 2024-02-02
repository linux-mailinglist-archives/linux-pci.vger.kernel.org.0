Return-Path: <linux-pci+bounces-2989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19052846B21
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F2B1F2BFD9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DE5FB8A;
	Fri,  2 Feb 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/Wz4n2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813065FDB0
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863468; cv=none; b=cU3LVvrAOGdW+f2hKb/c3FSHLOOUIzj21nJuxN//s1BXVpHPIxTXRZVts0YX7HKvCfp8T6JOEJdhtO2CgyzKa5OM1N3cNiau8dAhGz+cJ0ITe3fFiWjQ2p1wd1VrePjDFyfKOK925wBcjBAX3wlv9nT4rSalg+ojYgpJG2wSONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863468; c=relaxed/simple;
	bh=78KkgfgjtX7OYeDRYtWnf1tTywDhE3mqsWiyg5uggiA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9ToxNRpcIXinTltOfClrc88++M7wJ1LShDEcVvwAnIYJgSnptk6zVZMl+aR7zDt17+HSUrmFVfUbtbd//xMT4tvhWm8xo5M7AJFcrrLp/YDHpckq1Y6hVDU8OL7bPINyEFB2Ozb/DC/cPmNmmKJfVO59Bn1sUACkhya3hTe4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/Wz4n2K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e76626170so15210775e9.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863465; x=1707468265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex8uFXUd/1VgYSVosIZ1+T7rhV/9CW1dKZTq90qxWzc=;
        b=c/Wz4n2K855F07tKvYiG4OJkxJKkPVbtQxZ3Hmbe5nbltkszeu1t1fPaKAbqtSHBsJ
         TH/wLukHRE2o8Kdd+zpWaEzQYySTQoIttFjSXjkCtf6WufFOSPJOtIRKnDefQ8ekr+rC
         4Gp0vfAfFApNwBCWEjh88XKxRULKotDftzQN0ViSFajRyVAwuatuM+Oqh3Xc6jeOXoax
         NeMSfErJnIA3/IHW5DyQPIioWqAcXpTAh/UvnsqEfwdGyeQpsgQkjTCMjkB6ucR5d3R+
         ghpNVMdZo7QoinWsZH+wE7TRxugZeONWilUXhgVIjg2rUGo+Ac1nMx9EJ+r7tBYtJO3P
         0UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863465; x=1707468265;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ex8uFXUd/1VgYSVosIZ1+T7rhV/9CW1dKZTq90qxWzc=;
        b=QUwqNb72ZS35KycgFuYu5nJiLs0tQHj97oD7mPNSFZm7umUeklPcQCiwB6hSLLA3KN
         h3/+o4xOsP/02e1ahZMdIplTOIg4ttFuQ+TBCWE3LbsZo5zqAo6vQyo0HonGMK9Fk3zy
         DYzdWWDMDYviDAoju8pRZphrh/0i2o4SEoWMHeSxs5bntQHuT88+B333x2TpZWrZto4k
         DHq3pdFy78q/vq+LU+eQkggBYZSrxtylBdlnI3kD6LDWmyIbswffGQ9Xq0hGzY2hBCg3
         h8J8PoWxzdV7f/RE4O4hu0XeRNwKmND/+rnQC02Kt5CoElLnGGHds5qDUAw60/Jwgk6A
         6USQ==
X-Gm-Message-State: AOJu0YxPozb7oxoqmkpldaMBq0rxj/7mmMbt/QvRorZxxYzNvvBrgZYS
	mKis86w3sOR3c5UaRV6iEirp7VIPTygg+PSzhzVzi5rmisVm4NLlY+nwQDNsTKM=
X-Google-Smtp-Source: AGHT+IFzR2SIxqmtQVUaqdGKsNaghfYjTnnk4s14RseNSNSeKFjhYGR7V+zBK/Bk5FAj/+kNx3MLTA==
X-Received: by 2002:a5d:5652:0:b0:33b:1b0b:9356 with SMTP id j18-20020a5d5652000000b0033b1b0b9356mr905914wrw.56.1706863464631;
        Fri, 02 Feb 2024 00:44:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVlZc2Fy1a/R58ufM6zRR33hyvLSkb5W6o2FlxmOhNBB2f/HJv3Eoxcd955c8Dfap7wOc6jcIkUo+5mXAsMaN2cVv57QKQyDrcviK8UqtwfsB5FMU4D8zaNlqV5Gkhj7+FS487Ijl4xq4gFmO1CPwKyoWiC9gapICgkR9jwVnv94hYthVE0B76nM1aRr6Mnf0/BfxZHjvDTLrz+sO5VwXRWk/S0RKr7dNLUYB6KcAPnnZdKR9dVJBPtbt0bE4GlFWhilup0cTOzpBqWSROGd/HvqUxRv2QPIMeC5353kItmELtp8bZiKt2Wbhtefahd2yOKP8/F/0OvJad0yvGaft2rOS+CBamF1nUQXpuDlg==
Received: from ?IPV6:2a01:e0a:982:cbb0:560a:f70f:7627:2c48? ([2a01:e0a:982:cbb0:560a:f70f:7627:2c48])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d660e000000b0033b1cb8135asm1422167wru.88.2024.02.02.00.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:44:24 -0800 (PST)
Message-ID: <0becd323-6104-4c61-80ce-935c55f9a66f@linaro.org>
Date: Fri, 2 Feb 2024 09:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Content-Language: en-US, fr
To: Abel Vesa <abel.vesa@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <Zbyqn5wnH7yCe38P@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <Zbyqn5wnH7yCe38P@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 09:41, Abel Vesa wrote:
> On 24-02-01 20:20:40, Konrad Dybcio wrote:
>> On 29.01.2024 12:10, Abel Vesa wrote:
>>> Add the compatible and the driver data for X1E80100.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 10f2d0bb86be..2a6000e457bc 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>>   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>>>   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>>>   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>>> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
>>
>> I swear I'm not delaying everything related to x1 on purpose..
>>
> 
> No worries.
> 
>> But..
>>
>> Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> 
> Sure. So that means this would be fallback compatible for all the following platforms:
> 
> - sa8540p
> - sa8775p
> - sc7280
> - sc8180x
> - sc8280xp
> - sdx55
> - sm8150
> - sm8250
> - sm8350
> - sm8450-pcie0
> - sm8450-pcie1
> - sm8550
> - x1e80100
> 
> Will prepare a patchset.

Honestly I don't know from where comes the 1_9_0 here, I didn't find a match... none of the IP version matches.

So I consider this "1_9_0" is a software implementation, not a proper IP version so I'm against using this.

But, using close cousins as fallback that are known to share 99% of IP design is ok to me, this is why I used the sm8550 as fallback because the IP *behaves* like the one in sm8550.

Neil

> 
>>
>> Konrad
> 


