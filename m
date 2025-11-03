Return-Path: <linux-pci+bounces-40091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C1C2AD63
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD8F3A61AE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B522F90EA;
	Mon,  3 Nov 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P72n8GwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267A2F83AE
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163264; cv=none; b=Dk5vbh23jEokS4NsuD8BbIeV+NGpcbYM5aJf7rxaQbxmjRiSGQmJ7J7uKbRAefQbhMCkTdzb2sFZzvP1cv7fliPuK7bYrxf6BniMyC+bHQEZ9awcJvpeI//eO5PqhW4HgU8ohvh456sz21eUoUVlXJ3rZYiYZZO+L7CQITZFjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163264; c=relaxed/simple;
	bh=LLMUyIe4Fx9AEEvn0jleJ4zqebz1qVtL6Af3Q9h+i6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PeqkQPR1jpYU/RIiZE3CmObNLEKgqMmUiAHc4XiFUsuP7HqRTf26yCcJ2h5qKqDWnHPsdlaPAAu+demxqcTx+YZq6Hb6EOizfj9H8bxu2YQYPRmr0OQRMuLeouEZQEgzZ5rY4NLHIY+hjNxF4oRumoKySvAbutvxld0YISzVF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P72n8GwY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so14765055e9.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163257; x=1762768057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWAXx0S/pPXGVImvk7hrySXVZEromhVxb0VxrMIicFs=;
        b=P72n8GwYmjP9dgCb9s9tJzsejc9p1w5KbRe5Gw7NwGLAYKxWfu705dYYQIcRKXloyN
         oxHkI/kj/DTNXIBDD69qSZHSuo+HxjZaCnQ88tZ01tqtw+1cY2H6zuoc8Nz8m58ZFU38
         ENNLODUNQXQjkWuhIa26nps+JeKGMMcemhorDc39Dq6n26GqsRhy188yobLsC9u//EtA
         l/hcv2MjClaRPFhOWnkgqxlInySHMMbsV/WWpK6PybvaZCrJeMJc8whgVYYovZ57Krg1
         Ay4rFS9c3wnf/9cLEloRFpOAY5Z/PjYqWQ15c6SC0u3Y37LVYlRwjuVQ8yzdbsdejJdz
         K0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163257; x=1762768057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWAXx0S/pPXGVImvk7hrySXVZEromhVxb0VxrMIicFs=;
        b=VhaTb4VU0aXBQDgSw/pa3qrs5cMwdv0Y4o8UTLo22xZrEsjzY577wwK0weecMHKc8z
         QriJ6bfHrCBYOilqSJZZvmhfZJCSj+ic5mqknAbHl26XNC5YV7hSc2miYC112NebACRH
         QtUznPr3gRILJxGm8brbx59ftEPz4C1YU6+o2BM4Lm5KkIl+J0qC11d7FGW26R9r1ynF
         F1sJkQ2a8Ng7CK1ZFzw8xfnbKH0a5wDewB9Tok20fcTRUfSLEnHJF0WuR+8utGEyebm0
         RnYCxdZDhFCXrB+Eb+IorrANUsZRKeEttW77aaE/o2kEo73IOHEMzYikJyrR/kcFG9D2
         UmSQ==
X-Gm-Message-State: AOJu0YysqhwcVqTKBC0z88Q8JpjUuk5Xh1ZE2/q3gVi2kFapKEVl9CmH
	twUCOJ0DLfpff9ydWXQN3pi7KnSVcFwqMzed4cIEYpGBhaTVl11/VcayDzLl66EbSag=
X-Gm-Gg: ASbGncsSoX5SwBxRAlGV+tn5RDAdDDxlBhtwVBEVq9OwKB5GMnuHSmHgHlrP3cemIHS
	gZ1bUiwYn2ZbJXRBCCPhf6bsoeTdYCicplOMdLpbb5lYhkuDga7P5XN8uHOI8PU+RfBpXDreo4T
	TQYud5FQn9MS3w0eZ6kocO3vzqPDqODUh3IkiF3sBTuMlG0hAevFmOJZEYw2FRd+qANH9TMg9gT
	D1ei2XDjU6yFgsyI8rQCkmq+WzM5860pPuSMqcFm+o18tC62XzEsbv6mHAEKI08JtdS1j1q6cJC
	UNE1JBIZvBjEm1I5Vavl86G30QOCKjpIFf5pnPgjVPN6exz2iTK/GI1ZtRa0y7mU00rfS8re5C+
	gXhP+TcnGF8NKPLjyemS5znIQ8TU2FOFIPJWeekqPzdQXMB2ASzQTTKcgELr6LVkzKRrxE9wc9D
	VlrcmYbzbj8IYvQ+KJVkKl5AaeejiN+RM/4umL4e2iL/yW
X-Google-Smtp-Source: AGHT+IFJTdtxUlC5NqH3U7Qd9RRa1ToHSLBe/u+l9wzF/fKHgtyig4wAMueqSDc4k0TKmlPFEUaTjQ==
X-Received: by 2002:a05:600d:4393:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-477331dbef2mr57555515e9.14.1762163256713;
        Mon, 03 Nov 2025 01:47:36 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c374f84sm144227945e9.0.2025.11.03.01.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:47:36 -0800 (PST)
Message-ID: <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
Date: Mon, 3 Nov 2025 10:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
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
 linux-amlogic@lists.infradead.org
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
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
In-Reply-To: <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mani,

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> have region for DWC controllers as it has the Root Port and controller
> specific registers, while ELBI has optional registers.
> 
> Hence, fix the binding. Though this is an ABI break, this change is needed
> to accurately describe the PCI memory map.

Not fan of this ABI break, the current bindings should be marked as deprecated instead.

> 
> Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> index 79a21ba0f9fd62804ba95fe8a6cc3252cf652197..c8258ef4032834d87cf3160ffd1d93812801b62a 100644
> --- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> @@ -36,13 +36,13 @@ properties:
>   
>     reg:
>       items:
> -      - description: External local bus interface registers
> +      - description: Data Bus Interface registers
>         - description: Meson designed configuration registers
>         - description: PCIe configuration space
>   
>     reg-names:
>       items:
> -      - const: elbi
> +      - const: dbi
>         - const: cfg
>         - const: config
>   
> @@ -113,7 +113,7 @@ examples:
>       pcie: pcie@f9800000 {
>           compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>           reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
> -        reg-names = "elbi", "cfg", "config";
> +        reg-names = "dbi", "cfg", "config";
>           interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>           clocks = <&pclk>, <&clk_port>, <&clk_phy>;
>           clock-names = "pclk", "port", "general";
> 


