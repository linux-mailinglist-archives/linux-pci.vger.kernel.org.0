Return-Path: <linux-pci+bounces-40094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8DC2AD99
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A7F1893DB2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078452F9995;
	Mon,  3 Nov 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTc9cz+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C852EF66E
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163424; cv=none; b=pVOuwK8Qf26YR2oj91U4jIiIgCKmlR8hkotUXnyjBsDM6u5F+nWiLIJAekj/W7H+CnwX2umtFUaapdz0ia6VuV0z62g/ReyWy1XOarUTkRNBot8XO7GZ3rt3xqs8CW665R7EpoZRFz+UHWk9xyYwp4YnGYjrAhABsu6JVjFP99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163424; c=relaxed/simple;
	bh=lLdro4UCejX2T0cIjEIAFpHkeF9T6b7n0Tt52fX1K9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FMuqcH1S6Y3ge4ll0ZIgNnT+CYvdT8963pbitjcPATPNI8kNFFkbAAmx/x7lvq6h/lQdzZYBiGqGWoYPyI8K36quSe5XScQUVex4vuLAiiJww/WAyO9FK8qo8JZU8Xf/gJBRcsiryD3c8HhzyFC7WWsvbjGr0+n+fpftQuyAjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTc9cz+8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so37340745e9.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163420; x=1762768220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkxRjtj8Zko1T2xij3oDoi3JjwhxKLKuoC0vibst6Dw=;
        b=QTc9cz+88GfFLIx1Z5AlfQmnkOnNLCc3W67DvqHHiXx/W3Z/ZRecLLkrIBoa1jhlu2
         COc1xKp8U+tXjSpxYFtD7nEs/uNlyfR3LEZdVTH22J2+JBYrSl5aIYs7z2Z2Xo2IpB+s
         M5AEKii5wjnoUkzIE9BGf2ugjsi+f3eVRysvAcgFqW01MkMEkajens6/VfjUCOWePocO
         buQ8DnfPGt14dFj3dF0uVDAm+s7aQwsI3T+c3Xa0jYnwJ9M5EEemqFNhPjPtlp5C8SGm
         bowvtE6phABrwULn2mYM3vOw1JHFjIkNhr9MyWe5xrJKIKXxQ8fzbqDSVpYA/HvjyqKG
         wkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163420; x=1762768220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkxRjtj8Zko1T2xij3oDoi3JjwhxKLKuoC0vibst6Dw=;
        b=SQH6fPNXIgiBPZwbZYu7dImK0h9nG5nYYW+xw2x1fy87t4ExcgmfZG/DSXFisAHjD/
         N6O2IPZA0OIJ7tLAannn7NfjjU17B3L4vQ/RRc8xZYNyoaa4bgWz/TH5i0C/1alkioRF
         vZljGVsnTFZijFAiQSqk1JZ5dtxGBvL9jgFaWIB/4h5VVfCb/zjBdRBWTiu6UaUKywAg
         PxisIU7sFZ2nA1MkWHUdVZ/I4MGlqhocgvCGm0L3VqB1tyhaTVDWEoO7qC9Of6PHIpsG
         6Guo29AJTAngcacP+eg1T83QYxwTm4R95oRFxt5R1PmWHXAVdwuD/dpBGNXKZ/ruVIOg
         tjhQ==
X-Gm-Message-State: AOJu0YzbBdmDAIklx8GGcrswVpHzJIAo5w9iyb+5QWMzJcRxuRXJioDe
	Jj6BFFK0jOYDdlvobVgDbK4AfqqFOLvYV9om9aXE6x70lD+Jo70uWCcNsFb8mMtbAhw=
X-Gm-Gg: ASbGncseAsxpzm8EYwKQ6ZyKlOqq6aii36OCmlHzyiOz1jXE1RIa/eTYQwUJWQAiejl
	mf7rBCBG2idukL4YNfv3AEhtPO4DuZJhjUv5whIROPtUuaxXZVFJbnko6Sj7CkQiaZhKH978lri
	61jcIMxHw//eEe56xYNlkq0EiiVX3gF8znsGcNac68MVAoL0Rweso+Uv4Bi/Em2xvZziJddaMAf
	6K4XT49CCwvp1It6bkuin5vfKjsY2h86BHFtbXr5fxGaKavTup2qDMAhzqRf4kOx9XTYi6oKuwy
	cP1dEbajEhfkyKNxwA/wTVCAys4Dm/wE7pGJ5DGCWUlGZVYutHGDogjDyBDEygaxklogi8zuQhp
	tsvSNHTBdFoP5BzoLxQcaBkPmMxyWSctYZnGhMpkBS3yTcOV/HMvpa3Wb6c4CIxyFCm6xhUOmYU
	v39z76qquvKv09xZa2llJdVPz1sLGe2CzzO6iWvSOfVwmg
X-Google-Smtp-Source: AGHT+IHrNu7b4MLVFNafM5XudQwLx9/rw/9sFxikTt/B5JVYOos8PxRbnxL+oXtoVWVlGPVam6SEPg==
X-Received: by 2002:a05:600c:5249:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4773087230cmr102374215e9.24.1762163420204;
        Mon, 03 Nov 2025 01:50:20 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcd45a9sm84684815e9.3.2025.11.03.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:50:19 -0800 (PST)
Message-ID: <83d07b54-d584-4297-9aae-2a170c0059d4@linaro.org>
Date: Mon, 3 Nov 2025 10:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI region
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org,
 stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
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
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> Hi,
> 
> This compile tested only series aims to fix the DBI parsing issue repored in
> [1]. The issue stems from the fact that the DT and binding described 'dbi'
> region as 'elbi' from the start.
> 
> Now, both binding and DTs are fixed and the driver is reworked to work with both
> old and new DTs.
> 
> Note: The driver patch is OK to be backported till 6.2 where the common resource
> parsing code was introduced. But the DTS patch should not be backported. And I'm
> not sure about the backporting of the binding.
> 
> Please test this series on the Meson board with old and new DTs.

Let me try this serie, I'm on a business trip this week so don't expect a full test
report until next monday.

Neil

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Resending as the git sendemail config got messed up
> 
> ---
> Manivannan Sadhasivam (3):
>        dt-bindings: PCI: amlogic: Fix the register name of the DBI region
>        arm64: dts: amlogic: Fix the register name of the 'DBI' region
>        PCI: meson: Fix parsing the DBI register region
> 
>   .../devicetree/bindings/pci/amlogic,axg-pcie.yaml      |  6 +++---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  4 ++--
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      |  2 +-
>   drivers/pci/controller/dwc/pci-meson.c                 | 18 +++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c           | 12 +++++++-----
>   5 files changed, 28 insertions(+), 14 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251031-pci-meson-fix-c8b651bc6662
> 
> Best regards,


