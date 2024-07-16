Return-Path: <linux-pci+bounces-10358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E745B93220D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254061C21BB7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CEF17D374;
	Tue, 16 Jul 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJDOOh49"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF017CA19
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119282; cv=none; b=FEWWDkSanTsJY98vKaG5akl2ZGywJ5aN66T8I4YnSkoCCt/Og3+hBIMOBg55/YiKXPmAbWdzGdyjmSu+dpuQqh93zZV8W0NdfdsI5Slr/o5nL4ZHBrVp8f5e/2cgV1Cui+sQB3FFWhrEuYvCsTv9FqoTO4R4PMznxBrCIkaXWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119282; c=relaxed/simple;
	bh=WNymJro5dlv26B+surn01E8GmGRXJStnqiU6mG+qE64=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qGvwS6ui3jG+x3woWSRB/YQnoUbEE7IzY4GDUDmD4qt9hp2VBW6ioCUzBcDw8AgDS8+Kjk8GRB2OujuJg7czqHK27Ok1ZH0N6aILBEZ0Bigec5tjlWpu955MMxZ55MQM3RVFDqaBAm4NHml9SNSTRwj6UE9AKC//WzYnejYWGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJDOOh49; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36816ff695dso1419666f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721119279; x=1721724079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlYOPT3wlLjl2m/yJYxdg50G+hHzFjPas8Jb5Muv/MQ=;
        b=tJDOOh497ZZvPc8qTh8fjbuM6VJfCasVln6l+A7OTHDz3GzIkVeEtlXURVC0x9g7ti
         xqSSuAjowChXP4hnte5U+lZK5O7TQ1UAURuJneqVB0qeBJCzNC/YUlGoB/inMgA8+ibf
         mwoXkvceu9TMj2X7smZ7dDVug8AfxuqtelLVIG6r9pYtWlc4nu8dM6JbuMJdrc/WbGVC
         OWaiHcksZgyiysNrvK6OSLuFjZTFo6Ix2k0uJrfQwATkTe0GilLyPYz2P0IcqNdY9hLe
         XmoqHGtBgB2Dr4TTMXm6Kx22YSb8yMyheo1mRJH1rp7iZapPzruq8fDTyNaoe3F0ADOL
         jMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721119279; x=1721724079;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlYOPT3wlLjl2m/yJYxdg50G+hHzFjPas8Jb5Muv/MQ=;
        b=U8Io7h6S6rPe/nmpIM6dntBCRiVXC4i84hEqjUFvMKzqfuqiHHrNPUnHhCMmyu7Unb
         4GeyySG3b3PeCcTdjzsaFc0eNisB7gSyoIj4PNRrfbP3tm8onvucwgpR+Iz0v7J4snHp
         I/mThTDIlUX2z4XQJ6GYltELVyZsg6iLM6uHqm9jfGTzLyUwIDGCTrVGssCeWk3zDLyS
         vP5Gz0KKn7UEguyRR3Ea69VwhG84WZ7E4eSNAijn+VNEhD0DPwsCb4kxT9j+T9ZJGXPz
         Ox/N39bIg/7SDKhb5hrEg9U+2JhVIvfCLkgHSOa0PArlu4zd9UfA2Z09jkgwM/0OCesR
         MhQg==
X-Gm-Message-State: AOJu0YxVLVOEG2sjN8ixUnKyWTNewHtKFNKKrSEN6tKWP4ZqBGHPTI1E
	Ike3hrkMygvaRLjZV60Kj7RIrjQ3HLlqymB9YP5kg/GMFgT3ZMCvKNZPHjP+qvs=
X-Google-Smtp-Source: AGHT+IHitN2iUSi+nETjW8vRkmCEH+FB1hHkmGru6BjWujgfY9Dcss3M0nBlN7VjyW58jL9G5NzyBg==
X-Received: by 2002:a05:6000:1fa7:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-3682631f774mr1064513f8f.49.1721119278530;
        Tue, 16 Jul 2024 01:41:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197? ([2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbe5dsm8294386f8f.81.2024.07.16.01.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 01:41:18 -0700 (PDT)
Message-ID: <f89e333b-6361-4f19-b1e8-d87ea6e4bbd6@linaro.org>
Date: Tue, 16 Jul 2024 10:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 05/14] dt-bindings: PCI: qcom-ep: Document
 "linux,pci-domain" property
To: manivannan.sadhasivam@linaro.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-5-5f3765cc873a@linaro.org>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240715-pci-qcom-hotplug-v1-5-5f3765cc873a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2024 19:33, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 'linux,pci-domain' property provides the PCI domain number for the PCI
> endpoint controllers in a SoC. If this property is not present, then an
> unstable (across boots) unique number will be assigned.
> 
> Use this property to specify the domain number based on the actual hardware
> instance of the PCI endpoint controllers in a SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 46802f7d9482..1226ee5d08d1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -280,4 +280,5 @@ examples:
>           phy-names = "pciephy";
>           max-link-speed = <3>;
>           num-lanes = <2>;
> +        linux,pci-domain = <0>;
>       };
> 

I think this should be squashed into the previous patch

Neil

