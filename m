Return-Path: <linux-pci+bounces-3957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8E8620E8
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1612834A7
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7D4691;
	Sat, 24 Feb 2024 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOlUYHHT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A03C35
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732929; cv=none; b=uYVFePm+NRdCELF5xsBXv5zRdOj2dGbTsBgl8xRs7IdGp0NsLZ93fvph9+GU8fZuu9VaCUpUsT1f1gIZYLFxj5K+uhwsqia5KHoIXewfHcg5bs17aeaKFlGhCGZ/pc3N+J17kSm86+ODP4+WcrURhXNO8Qg8NnbpDeN0544q22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732929; c=relaxed/simple;
	bh=UbVxq4wTDHlpK8UWuiEzg3/9BzAum9YoZK0MzyDnies=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzpbC84q3BTSmT6mWZl/IfeupTce88ThpHa3MN/McCioqzaw20Cjh5KH6VTIQ4bxBHjU/dJUYaF0n6GmccFBk+nl4ADfoVLsapL85AnWVY04sQl8jbBAIKnT3/6gMRrpkdLJi3IxsTxwpVm5f/uT5hKvZkh7i2rQsuZG8bQ1DUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOlUYHHT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e39226efso1950706e87.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708732926; x=1709337726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhD3DAWbNML3SlHPwjoNnwcDxDI9+wbM/QZnrMUkqLY=;
        b=vOlUYHHTqPwK5KiY7ZkcKCx1y0LiAA1nbk3AureYlkhU7V9P8DJ++8I5QenxAv9ljE
         cu7KxTJaweLjuKvUvGvdp4Y51djzkOOqRAmxgM0zXZgHR/jdA17kSiQQ0xPz7+JW8MdF
         xB0VQLaSvCUNyS+z1NLAJ0nrJtmAArcif2D/lNYWc9A3AbX5i9dR7ZN6shL3ylWfl7YG
         RsCx+UN44ry9jasSLwvop93Y0Ggkt1aMaKxqwWlO6RS4jQxHRzXDDz/ACxJwrUEkZNlT
         AWxvRk6yoiiMh8tw9FM5HfelVCqntT2vCwL08e1Ib4+90W7GFihQ0+ezsG6Lg1C8xJQH
         vvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732926; x=1709337726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhD3DAWbNML3SlHPwjoNnwcDxDI9+wbM/QZnrMUkqLY=;
        b=XBs+JGntuaaF1t7kJ467ioCiUxWCE4pu4JmfXVcflN9wRytnF19oKHkijtlCvrkTe5
         bXP71u2BvBUe0FEtdiOK3C/rSFJC2KW8vAkypLcNVYFDE8PaRvC1QNGqGEBpBrdC910H
         mRQxn8kKW1bNSpqCHU7HmCpeTcT0o8tPNp0oiIcKVmAaDqBMKq0eXEtcvEfbymwPSq59
         0B2U7OFfW7Jdj6FeGbrU8PDJ+S5vJzzBCz8706xlCTMao4JyrDB6h5IdBauVLeZ7VzVi
         t3AVHHqIelvtQ7DhuBMxVAiP1j1CYGFhiFaBEum9mSaZ7Ht4Vfgum217V9KPCUI4zxnz
         7RcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIwyNE3UANisgxh7TUzUAZBf7fC7a4+aLMDXONBPrQkYD2iuUrUp9SuWHpI0KARSTkLNuAZwcfyeve5qsMlySSk9qJ5znNJYSc
X-Gm-Message-State: AOJu0Yz697KuRF0AraL9qxK2mmSlYi2dh9bftqapQ6c6ymi3daE2i+Iz
	MPtBtUF930q2mY+YJb6lEX6Y2XtMRItJqN8ov1xnQE4Xa21zQS+CgPvRn6ZKgCM=
X-Google-Smtp-Source: AGHT+IFkK2ZqsQ+kADx4LKX6bQQeA6NKG9CpBHfwrTSpoNCuI4y35aQUf0eZ1nkkqJ2R+HZWqarpUQ==
X-Received: by 2002:a05:6512:242:b0:512:b935:c542 with SMTP id b2-20020a056512024200b00512b935c542mr774317lfo.59.1708732925952;
        Fri, 23 Feb 2024 16:02:05 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906350700b00a3ecfef7f1esm61330eja.189.2024.02.23.16.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 16:02:05 -0800 (PST)
Message-ID: <53f486d1-94c7-4dd9-89fc-d80a92301700@linaro.org>
Date: Sat, 24 Feb 2024 01:02:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vireshk@kernel.org, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, quic_parass@quicinc.com,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
 <20240223-opp_support-v7-3-10b4363d7e71@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223-opp_support-v7-3-10b4363d7e71@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 15:48, Krishna chaitanya chundru wrote:
> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
> ICC(interconnect consumers) path should be voted otherwise it may
> lead to NoC(Network on chip) timeout. We are surviving because of
> other driver vote for this path.
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always.
> 
> In suspend remove the disable this path after register space access
> is done.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

[...]

>  
> +	/* Remove cpu path vote after all the register access is done */
> +	ret = icc_disable(pcie->icc_cpu);
> +	if (ret) {
> +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
> +		if (pcie->suspended) {
> +			qcom_pcie_host_init(&pcie->pci->pp);
> +			pcie->suspended = false;
> +		}
> +		qcom_pcie_icc_opp_update(pcie);

This doesn't compile (you rename it in patch 6, this is patch 3)

Konrad

