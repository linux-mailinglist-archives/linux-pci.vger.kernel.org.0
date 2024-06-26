Return-Path: <linux-pci+bounces-9324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E09185F9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8A328100B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417B18C33E;
	Wed, 26 Jun 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpd9IUO2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2118C32F
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416246; cv=none; b=WoXU5wo7XUbsOrNDLx+kukDkOZl4bKFSgX7GNevzmKnumR752AOuIJKs+uVHL4J8HBo9foXbluSfbz+APGiRpxoHkKx75shGpTDZMYWRLw4uEuC7oKU+1i4ckiQOQTAQ4Hn7wUck4xHpsjZi2jXgO7XpbODjMkiOnKFNsbpbcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416246; c=relaxed/simple;
	bh=678pGV40+eNWwnUvVfwueDmC3NvGqTCmHbiiJ4Q2GF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZxV4JmgDX7IE/bFLaaNa7QmPfuTJAYG4U+zPci3BQ+QF7dzFo/zQmfA+TmQ8jNZBMODil9vwWI0yon5An1PuhstvycsYQRoc/dMQkbW9jhg49+Zb9hC98aIBpPc9taTPFWLP0p8yDnyzhCEW2TVnqvSmuRTXHpIDpPqrksUL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zpd9IUO2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so599247a12.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719416243; x=1720021043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/M8ZGHQaunzKdqcWije298Gp484PNbRhdghRixdYcfI=;
        b=zpd9IUO2Ee4u0v1D0JmKCUYJz0vl59GDx2CSQ6N97yVh4IOyngm4F8L5wRaS6Z5pjP
         QHaffQgLAiQ1vre1BKmD7H1XId/HdEbevDwOzhUk4B+f74rtRqEW+K2BEiL6XlEDejrI
         +9BxxLxbiMulCY2YhVXu2VlrUMn7/G/nead6H6w/A914JBhAZHMYTMxMp/eDjJvuQxOK
         CPGXdeYINNiuvsAG7b7n5QZrHUd+DiHSJjAtM27Cxus9YvsFvb3rVfAdDkqwhpT28RFl
         fVAp7pmyiwOhEsvG8oT4mlewo2ZWyeRzwoGq6G+87rEv8CPfWUq3zdNNta6H7WB8/g9G
         d4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416243; x=1720021043;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M8ZGHQaunzKdqcWije298Gp484PNbRhdghRixdYcfI=;
        b=sH73m/mgEibkpFSjOCTOcrl33qR7ND2SNrG+4qQEMPfEnPj08MNxOaaKSwtqTOfPMg
         pammoMNGJGgeQ50p/gtGtq7oei0QONE6TGUsJxO1dNBCyhCs9OlCuwDVsc0h/t3hzrRI
         1fxwY80CvC417EljeEAm7MUsnt0Orq48xwv9THhoZh5VX5RSLcTzLD5Uy//AzB9cFuoW
         kr4YZdAfOe2Q1s78AVULYya5KEi6TtskBi+h1ibahbFQyI7LJKvjh80Y+xQQX824tpB8
         amQ2oHJShaxSsP9VhF38AK3K5O7aMngwz79VRGSMW0fybW4aJa/4eZjGjqmLWUZmStWf
         hTLA==
X-Forwarded-Encrypted: i=1; AJvYcCUMW4QW3BjnXS0gINKuMmORrXQ7kVAst25AMRq5IXi9pm9WbVCqEf98O4/x8BA/Y8iajrnyvdPl0Evqwe4LQxNGuWpeOVfCkorw
X-Gm-Message-State: AOJu0YzpfYEAMabGrj9p2nF/bj+y4/5OdjW8q0an4yLJWrJAHwsdvCUh
	z54Lr/f1EuPMPWNy7ZiY+ezHUyGvONio97ozLZiphPE5I3worKninoF3cUSKKYM=
X-Google-Smtp-Source: AGHT+IEqQeAazDOngYL3KT5BxpGqqJf5DSXST78jR3z4Ny3CbZ3jxLYwqV0Iiwe/FZ4+iYRvfmlsNQ==
X-Received: by 2002:a50:c004:0:b0:57d:3ef8:614d with SMTP id 4fb4d7f45d1cf-5847c38c72cmr3776a12.20.1719416243091;
        Wed, 26 Jun 2024 08:37:23 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040f3e0sm7280865a12.25.2024.06.26.08.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:37:22 -0700 (PDT)
Message-ID: <0b60cd30-3337-46a0-87ca-4c75b7f1ef29@linaro.org>
Date: Wed, 26 Jun 2024 17:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 7/7] pci: pwrctl: Add power control driver for qps615
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240626-qps615-v1-7-2ade7bd91e02@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.06.2024 2:37 PM, Krishna chaitanya chundru wrote:
> QPS615 switch needs to configured after powering on and before
> PCIe link was up.
> 
> As the PCIe controller driver already enables the PCIe link training
> at the host side, stop the link training.
> Otherwise the moment we turn on the switch it will participate in
> the link training and link may come before switch is configured through
> i2c.
> 
> The switch can be configured different ways like changing de-emphasis
> settings of the switch, disabling unused ports etc and these settings
> can vary from board to board, for that reason the sequence is taken
> from the firmware file which contains the address of the slave, to address
> and data to be written to the switch. The driver reads the firmware file
> and parses them to apply those configurations to the switch.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

[...]

> +static int qcom_qps615_pwrctl_init(struct qcom_qps615_pwrctl_ctx *ctx)
> +{
> +	struct device *dev = ctx->pwrctl.dev;
> +	struct qcom_qps615_pwrctl_i2c_setting *set;
> +	const struct firmware *fw;
> +	const u8 *pos, *eof;
> +	int ret;
> +	u32 val;
> +
> +	ret = request_firmware(&fw, "qcom/qps615.bin", dev);

Is this driver only going to serve one model of the device, that will use
this specific firmware file, ever?

In other words, is QPS615 super special and no other chip like it will be
ever made?

[...]

> +
> +	bridge->ops->stop_link(bus);

This is turbo intrusive. What if there are more devices on this bus?

Konrad

