Return-Path: <linux-pci+bounces-2958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BA8460D4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DF828A68C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99A85270;
	Thu,  1 Feb 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jo3EkCOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FB884FDF
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815245; cv=none; b=PWSYJIeMPn7bZpO5IatjBz6KggSMMFb6n3dg4OQtec3OkL9sVhtOzZF2gM+5p/Y+BFogvCAKgQfuWIlTU3C4nduTj3CEyo4IT6Wyc7AclV6RxOc3TOZItMOFrCUj27mQ7QawOWYAV2OSmDssBQ3yPmtUbQGaKOe8+Ev8iT2z6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815245; c=relaxed/simple;
	bh=U+iiBNU8Gwu7+hHtESnBs94dPAmhn+bnt9MP94sadns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYeHl+Xutei3ucoSa/cLVYKoPYkldH6dlJmQ0A08ZlNOIvM9EycPRU3c7FNU1p1Nl8yPDGDMFsdKJpqSNrZEmgFVPtAPIDl7Yaw3H32Y3EJEVeSzORLx4tXOLFrj/Iw9qnJTy/IIq/8L5aU17hdHlpuiX0KV1WYOA6eziMV3sSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jo3EkCOb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a366ad7ad45so168768166b.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815242; x=1707420042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qldQrnD4NCa7JMcPYN/JJw49V6ME+4BY945ba5mg8WM=;
        b=jo3EkCObpyhc9ArCunSRUZJeaSQ9p93nlsCGP932eF7XCIBALianuyP5srvG8F/Oad
         yWa5cyXv+syzFGPeGKLCM1nkD6c3ibe9vFueV1JklGT36w6EBBAPHY3IKHUb9yvrghV2
         7/cspfDJ0z30HBw/hEZtocSVslys99iuGEL/LjfUIiI0gll3V1xV+GuCVAz87v4KSQXP
         cQK5OdDtmrwzOrUwdfik3igr9PO+C6v3IDe8/cNKX4XGZdk6pWJlqwpRZS5ZoacJHdu+
         LkWs13wlNholN1OPfQLxyB0rOxF8pT2ISsiSiFKOMQL0fetLCUIrTDqwyu2X2kh0tWik
         q1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815242; x=1707420042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qldQrnD4NCa7JMcPYN/JJw49V6ME+4BY945ba5mg8WM=;
        b=Z4rmQeAHy06CV3iFNt/486ylBIQg2ulNIz+k8CHOjOnsoLAnuVpjSLLm/BQKi7oFpS
         ZJU1KWYEUlB+XR4hw/ROBACe9/QQuH0I2tzT1NXpP+4UNB15TzDeMQmR576sKIsfBnCh
         Ucg5Pfbs5aOE6r6rnjaMblKP11v63wyw6hpUuvJPMoQHn/Grlc/nXfBbBxsvIqp57i6E
         onNevdkM9KOcZc3sd66idS78epn/7CGc/3+0ibG7ygM2JlG3p2n1FFmDG1i1I+qOjnRF
         dzOPPZsfDBeSwVXsBAVMrL9vDNDrRlDfiSrSa1PnFrpABnOzvVXMICJ3XNOjRSlZaQN/
         hgAA==
X-Gm-Message-State: AOJu0YyuMe34uh12JcF+y1oFiIBN4FkZz7epsvpZDuz7bAT8Ri3Cxpaj
	L0egNEB9BS4K/VpQW5WbBtcy2bOeWYSDUDqTsZP7mFEn62e/KZrCtQ8nIVd6r8KcqXMr/uYtLMH
	k
X-Google-Smtp-Source: AGHT+IFUdcrJxb+88easc7bB/96Rke+fS38MGkWXidc+J+CjUUbWsJNOl5TyfZ1g+qiWMWL/sV77tA==
X-Received: by 2002:a17:906:7086:b0:a36:b64:e0c0 with SMTP id b6-20020a170906708600b00a360b64e0c0mr38364ejk.67.1706815242312;
        Thu, 01 Feb 2024 11:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMVns9gpoWFOybeV1DMvn4pPGGY5MkEt63PHJWMRrKgtEQehgezgkv0+G26rOrtcVEVg9N28ODKnhp3jDh74UBByr24lWHd4QBLtpgZ4tx9m5PKQWTRlTAcnj5cUDjDVUwEuQg3DHS2HfG8B8QncBVliEdUTlZyMbw0u3Hv5bLN3DrT15DQz42Mx3GIdpHd7fOJF+YEGF5HzWSFR7BZa31qb3Tp2L3dYjzg6ldJhJGtNioxhuDslJQpybMuGiFS7nbaQ8aWwyVwdARrBEEUfEFM+i4dMU5fKd6kpZCxUQMhTBeXRoll6nrbbMsUv0p
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a36f8fdeb98sm23088ejc.59.2024.02.01.11.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:20:41 -0800 (PST)
Message-ID: <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
Date: Thu, 1 Feb 2024 20:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.01.2024 12:10, Abel Vesa wrote:
> Add the compatible and the driver data for X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..2a6000e457bc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },

I swear I'm not delaying everything related to x1 on purpose..

But..

Would a "qcom,pcie-v1.9.0" generic match string be a good idea?

Konrad

