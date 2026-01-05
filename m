Return-Path: <linux-pci+bounces-44024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE031CF4028
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CF03174EE9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC129B224;
	Mon,  5 Jan 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zw6KGBap"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A556286D5C
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620905; cv=none; b=fUOSvkdiSUluLzEGqOR0/FM7ijk1U8s/i0eD3s+baxvL3sXrQiCxd8+obfVpnLXoD/eiLc8YOxiqToLOLdD4aYAPQ0nt5IQovj/0y+lgTACe657jEDENEFWXezJdBwtmI4FJgdSgf9fkbc38r6CoI7ZUWu7L37Ljx1ek33r89Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620905; c=relaxed/simple;
	bh=KHUCaJ/Ls71BszTMTtJU0oPqKLK070kFZWFzzLSm4cs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lsO1DCTcjMsvDVeYOZ90Cbsri1PRC8NRUnyXymfpyW25MWHDXpzGwWdfB0HXbFwd0vfINNs6OTiuS9GAoFFG0Natbd5ZUYHwrlUEzvHdTda4xL3n1Ffd3jVuGsHAdiU0sIEV3Y5Ceybftf7ydsmlvjuSuEG1S/y0QgLHa9UClek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zw6KGBap; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so11724013f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767620901; x=1768225701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pm61tHOxVIMRlo2kMdlbFtWUM1V4vVjtzMYxIxE1KY=;
        b=Zw6KGBapUqxmW0MRJQ2z9ETicYDDHx//v5iNvGMLBW2mlq1pmYPCHp+APGQNMQazdy
         gp0ny4geRviKqJQEFnWrC/B9jU6ADIIRPD6Qo07YZNxQtgIkxQdnUkQ1/SzODbWnSkOx
         YdN91T6bVHpZ2YOfT0yE65UUyGlOo0ZV0e5lCVABrknXa7dN9RtT38e2HiMjq8KmFbK0
         rVWBkgMYV8kEMWaGYWREVO3EpltwuJugikqcafqHRdtnuSjj/2AFNq7c1OiiOuWHMH7N
         q+esPvCpeKuXOUoWlN9PtrArRQKy395ftPSRPxc0AZm4TeqKQ+fgDQ5MlzdNKfJm1ZpS
         jP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620901; x=1768225701;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pm61tHOxVIMRlo2kMdlbFtWUM1V4vVjtzMYxIxE1KY=;
        b=KH0ticm/MJQjUJW6ziU0CD2yCtxDwSUGR60Y2vYFM96aVwcdm7PQZYf+stq4F7r8av
         93nQ3/jIBqLH/aZ1WCRFAKlX05PzqN+hkoWafUUVlGZcAIAPW6c8qzxTdWLvr0wrSKKI
         wLGfC+v5wohik7Hc2Siw8KrCwY9jXKr86xfbXJz9ncj26eW1TZrUQNnztXrTM7zfUzRF
         LqLMUDws8dmdI/kUnr2Vuq51Qqd+I8qPciZBmVodd6cSedBSriVy2GQlfq0JR5vzc4rp
         OPRUvRGpmuU/WoKPNGALd9Cs2x8DCFKb6jYAEhgn3nXh+IrUQCpGYvVQSLRCLaRyYat7
         +XAw==
X-Forwarded-Encrypted: i=1; AJvYcCXU/jPt2fHJARvkS4q4TI/1sU3uZSFM32Ph7G4PT/Xeew8SmAhBm5I0OmfX1uyMRsqBtA2ERkWlDzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyong6V7Awmm6n/OmevhmNIujfaR34PXhvfDUBzOr7a/k8IPmnM
	FGHBbeaxOeEGX0b5LVctrnACYKA+xXqiQLMLqHRKQQ58WmsOAx+CVH7S1zjzYJgzmWY=
X-Gm-Gg: AY/fxX592vz/FxSZfj4x9wqTtJaOSR28cks36m7Ll9eY9FOae1P92YFcHzejV8HACSX
	ceMZNh7dK+8I3v/xZWBH1agaOcjc6KiYceQEFk8MUaSGUJrLIvGHI1QG7mFAmf/u/D5zwIR7uHY
	+7GmFdlEv3yvGxFCz88tfbpzVDHhty0z4/iE3JkJH2294caDFfUAFUEi33TaP6tVqvOoAwOcaHv
	ZCigLEShcw734XMBFe9lhLiNPPmmq0phrEywDrH8k6Y+Wx7zDmdqlkWh9pLveudvOenoXlkGRim
	Ps67zA3Yfm8lclx5T9s01NH2ApuT95ZwAzRfUsw8ZZAOQSwqT4OJ0QOKRgdn78OhyibFF7BB09F
	bGAlsbKv6/RNa8aRWvKpogvevNBstDGDH1GXc7Fx4xWofrNrC6D6yoK9Z8JMXLNoXRqfl0+HubU
	sXN0/D3t/GZK8hIQj1lFKdiNq+nijI5w5JMY6/xd94GBHP0goT9OylRHgYPPNhix8=
X-Google-Smtp-Source: AGHT+IFJH9vjvSt9a1g91foUnNhyxduRLS5b5HEkPDAICFvU5f47KylFUeGSvzLd5WqdKzRrR497ng==
X-Received: by 2002:a05:6000:40dc:b0:432:5bac:3915 with SMTP id ffacd0b85a97d-4325bac3a19mr59539111f8f.39.1767620901179;
        Mon, 05 Jan 2026 05:48:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033? ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100156855f8f.3.2026.01.05.05.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:48:20 -0800 (PST)
Message-ID: <46d049cd-3307-4fbb-b33e-69ba05ded106@linaro.org>
Date: Mon, 5 Jan 2026 14:48:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: meson: Drop unused WAIT_LINKUP_TIMEOUT macro
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bhelgaas@google.com, robh@kernel.org, mani@kernel.org,
 kwilczynski@kernel.org, lpieralisi@kernel.org, yue.wang@Amlogic.com
References: <20260105125625.239497-1-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20260105125625.239497-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 13:56, Martin Blumenstingl wrote:
> Commit 113d9712f63b ("PCI: meson: Report that link is up while in ASPM
> L0s and L1 states") removed the waiting loop in meson_pcie_link_up()
> making #define WAIT_LINKUP_TIMEOUT now unused.
> 
> Drop the now unused variable to keep the driver code clean.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index a1c389216362..0694084f612b 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -37,7 +37,6 @@
>   #define PCIE_CFG_STATUS17		0x44
>   #define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
>   
> -#define WAIT_LINKUP_TIMEOUT		4000
>   #define PORT_CLK_RATE			100000000UL
>   #define MAX_PAYLOAD_SIZE		256
>   #define MAX_READ_REQ_SIZE		256

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

