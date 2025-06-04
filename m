Return-Path: <linux-pci+bounces-28970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD8ACDDEB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325FA7A8019
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86DD28ECCD;
	Wed,  4 Jun 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8voyw2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760528ECCE
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040174; cv=none; b=eoxvW6+zGQ2hpzMzFCZW/iEDyNAICoAwG/32FADNj0LaAIIEeToxSBcPTvuNwY6FerhwPuB0TTgOGo/fr7s1vZAmnOjucEi35kokhrfO9OIP/NOJkXnb307XBWmo7T94u1awDyUU71Sm296Dhn3HoBKaOH12fcAwh8WMnsGyNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040174; c=relaxed/simple;
	bh=jJAJ2zNRS4Mcm3SBhX/rRP1UzssTd1Y00hBueZo4LTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gClM2+uBJOL1Iro24ez3jHAr+X9a8wa4zceLWjjGycDNOSVpJAjjeUywecnEOYr2jhG6y7l7FZ/AmKncS+qn8cPjvvFEPgJWk/zCM6Yyd/bfOQabpBkOECZSgkD3VDsbEhJDrhx/BCxIccbjzXjKdhQFnb/DsVW+GM8qm5LmZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8voyw2u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so2484562f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749040170; x=1749644970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlUevRnkRKcLl384cvLF8laETHh3L8+aAG0Z3FSxUTk=;
        b=G8voyw2ucePadkaSRs17pdS+esFxGSwCoQ7WwvdU/jDbAEiYmy8A2j0L9us4J4TTt6
         kwl2BGgcisj7bQGx/ok+U7hkK6+pYDLpXHm0MTdR9IcO/c785JBamvelVyscVSgJRC8G
         +nWv5+TvTX/S4u390QcD8/RHgh79WKxWOgWhZpIinXA0Hwuup2RFFkndgbN2vAH90KcB
         +Ix7nglPjjixuXUyl/4NUo4CZXk5LT/kD8+4tk+h2ZUsb+BKRuQE8+obBboZR/T0p0M7
         5dnxxOMjb/J/G/BwL/6y/yzr4K+uqw2vy5YYvDxNFbrlCdZMvJ7yGur2PHld7JbyASsk
         ASjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040170; x=1749644970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rlUevRnkRKcLl384cvLF8laETHh3L8+aAG0Z3FSxUTk=;
        b=CKDKpcUGPheDyWk6jLTSNvPKXUI97gMAi53ovSeyX3wQtS64ZdyLixt4rhmC1NF6IM
         XfTTkF2VDmdQMrGIXcWniFZWzf8Exs+nDVW6xANS/Vnyu/nJHMJ4M1yHRRmGU/E1gviK
         GtfjlZ0NEyGWtmqmGbGOpDKdiT4nq5k46I1U//LjmZNVQ37WxIPmLcQJV11v/sc813qw
         VJcpJ7+CULq2mzJUTuNKNSDsc/EidwkvvPECSBQG5zMeKqIBOBKa3oPOm6DpFHP6xQGf
         109SgIrXdrjB1MAXwM/GIMLsKRN3Y4gjbyLtIBXQu2rhlKD7BAErjnxbbVZnpaP5it7T
         2g0g==
X-Gm-Message-State: AOJu0YzhJY6982KMEI+OE7HmkWEQz0aNTtBBNJ5sop0V0FCgLfb/Q/rJ
	4kmXJNeSbxXp4eaPcjJnXsHJTqFR9Q5M8LIA+Uag3ECwN1I/8SqGiOJJtHJqzjxgrvPqZlFSKkW
	E2wSP
X-Gm-Gg: ASbGnctIYDXMUiBYry9luxgJHo8yTfuZ7yMSdR/cmDCS14xRnXqIXrizv0OdZzKT/dz
	/kbimJv28m5C6y5q3WkwTPJYoaOvZwwwxK4ZQc49ScwWH+n+fd0kPGvDlGpi14Gnvr5IxzDEaXl
	g71pjbUKLVXeqeVnmxn+jeLf62RhStRxj1m8p0ltGm9Wbl+2MItDiapdlRUkrdtZDKLHLfHYv7C
	4EZN1zjKABOFI8PGOlwP6G2CHpMMQyKodN4ys/6lJvHVFwkgn2jGbu7f5y26LBpbRFKwDCEuQmh
	M6bLqI9jJ684p9ZFUry2MuS9UFU7x50fmtzfNu16mlzfxqCGLXbv2e/JE33ZNAtw54RsEHDoZOQ
	tZDzCDiUcenIaETTXlkM535V7ug==
X-Google-Smtp-Source: AGHT+IFAqt37X/nVv/2RwOdCdcs4UXjT/VL/HCTdp4l4p06zsedWg/2pZgay4ZmFeC40lhzrgmbAuw==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3a51dc49afcmr2088240f8f.51.1749040170100;
        Wed, 04 Jun 2025 05:29:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8? ([2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb7e41sm194312145e9.26.2025.06.04.05.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:29:29 -0700 (PDT)
Message-ID: <6976052f-a3b8-48b8-97f5-4fea7538e976@linaro.org>
Date: Wed, 4 Jun 2025 14:29:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] mailmap: Add a new entry for Manivannan Sadhasivam
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
 <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>
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
In-Reply-To: <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2025 14:08, Manivannan Sadhasivam wrote:
> Map my Linaro e-mail address is going to bounce soon. So remap it to my
> kernel.org alias.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a885e2eefc69..1e87b388f41b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -458,6 +458,7 @@ Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
>   Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
>   Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
>   Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
> +Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
>   Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
>   Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
>   Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

