Return-Path: <linux-pci+bounces-3449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE040854A98
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7621D282109
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824A54760;
	Wed, 14 Feb 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4PgU3+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D353E3C
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917942; cv=none; b=pxiBvfc/mZ9Bg2wstMmNwyQ+uUoKeJP6Nlr/y0cDnIiM56j21P4VDJ5XjCDJtWu9HopswejnjGrQrjCv/vGfnD0Jnfiz9F7kUgJAWkpMX8BGWUV41EjH/++adfVEEfFiabZ87y6TWkIlrSHWvUG+w2jY6mtJdra5DSnQMs1SPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917942; c=relaxed/simple;
	bh=7m8FgKYenpbcQV+utnPx5tYHSqTgQ+N6XM820y2I76w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzXDpa/5aWVcchw+j6B1AcYkHRHAURM8GKRl+uRDvAFdN9IOAGn7ZU37HNHEz1qxs82C4jqJoMOCYyamwPIq0O/5JbEa+CvoEdGPBfjNb3NRBr8gsCmWgSrjCNfrZ+zRxdeiE1zJgU/iil4co4ua7/81zWm7r9raOs6o3qWIjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4PgU3+J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26f73732c5so788369366b.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707917939; x=1708522739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xl8fdjNkOnOLzOdA3INQoYZq3zTCdkc/JpETQWx04dE=;
        b=g4PgU3+JNBdD9XtKfcu5JuDpxTJKycOZduEkVn/hL+hR01J3Ifo2cIZAtnRKC0+Orr
         +xX2v+tkv7/YHDabik6O5QG6qATKoIXMHKIxkJOH8P+L5NxL5ANKWCzL98Qowjar3Yib
         W4oNYpgbpWG8nzRAfG1L68L+Ti0LzPFWJas1K75l/69nXGCq8gcrAgPCvqxlm01BRAfJ
         KgbSGu7LkG81FFQwZ/PPw5IcY4MmRgvGRHGexk8yDx5F3w6QJBJA+iSxE+c+8q/m6BSP
         gAEHH7bcE8QyfdZn1X4MkHH8g+E2yFuwZzpfWJ7w4abTN8uLAKMGDdWhGI/T/nBOJvqq
         UErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707917939; x=1708522739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl8fdjNkOnOLzOdA3INQoYZq3zTCdkc/JpETQWx04dE=;
        b=nIC1gO+RThFyRJb0+4FZq9lmZApSoV3KzKokLHr5cjxnALNViEVR7W5J9VDtvuKYB/
         LeCUPJwa+P5AA3ay349XNsBSKe7hcIpoCsjmzFCWR2rl+PSsjalFZodaafbgffailh6K
         KzVyx/dvU1vxy69I/RWKrICOLcRaRhFZ/2mI6pIIslmiRTT7VLwNjPgtXNFYQZigzOJZ
         VyEfYdbR3GPiwhvuASH+2FXdRS4EunQvr/Pxkjzojob2x2KBmTtkcdqxnLdybpgIieF7
         +gB301yxMZl7BbXverlQ9e+D+Io7wysRHe9n3dPcssLnu1OMtBtA/TAYMUCBbXIyqrom
         pcVw==
X-Forwarded-Encrypted: i=1; AJvYcCX3jj6NLZEsZaa4IATUqnUSroXAt45Ct6UNDOCMLOBqtPfTTGXFZbfRl0I/RHhsiq29+7GGXO/froRazbhU7RIYKF5iASj/87b0
X-Gm-Message-State: AOJu0YzMtuuvNCy7S7nI28MNVOd04l88aluIC9OegnsokauJ6Fna7xF4
	zr0ReNfzZVmtEq1sYHUeS/Bw0BV1ThHXt/tDmSO8/oE2k8DM+lE/Ti6XJez+fnn0EsLi6r5GZxc
	RzR4=
X-Google-Smtp-Source: AGHT+IF44O3lJTfCP6eOt0ZcLCXWtiMF4tmyCTUbIV05jahWoL5XKoVoJ8TihVtEPkQQWbiVUTIBHQ==
X-Received: by 2002:a17:906:d10a:b0:a3d:2392:b025 with SMTP id b10-20020a170906d10a00b00a3d2392b025mr1776457ejz.50.1707917939141;
        Wed, 14 Feb 2024 05:38:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/VPB0bBip8Y19tYjb13eVOw4gZeMb4PXsejWTzIAoHHUyZXUDK4xI/c1o6R98uZC6MQrs0Z9+AlKE1g1d084AQJoGH/I3pIuMVwTdIlkJHXlrXRpcT2D1t9BW3Hgw9jmry0MVN/6G5VN/58k0iMbb0RBgKFYOvTh1sig/51HEo7an6k4uLHDl8I1Q5HN9PycOAyBqJyKsBi3WrpLmYnhK3Ut49r+3lRv0yt8iFnbt+ykXzy68dOw2xu1KdKKFFQ239Tk2GPW04zcmlT1n/oePcKJgAZG9OzCuFq0hh4eSMOGmptElBFAKDggQVkXryIZFptY/cdNzN3qHMEr4WxUhVFM9UTXuBgXeKaGjmu/2Naf6WLw+SI8EyAG7xgKRbqx9MoblQ+ZB702r3WFiTSGV5bHry8Sx8mvrbVvb3Sc+ZKg0gJYLkszXBlaXg9Yq9SjaKXXQjvhOPakvUpDLRbwO+njo6Ss1Rh4lSu8wUteREEhEL76ISnc=
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3d09d09e90sm1561399ejc.59.2024.02.14.05.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 05:38:58 -0800 (PST)
Message-ID: <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
Date: Wed, 14 Feb 2024 14:38:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 13:54, Johan Hovold wrote:
> On Wed, Feb 14, 2024 at 01:01:20PM +0100, Krzysztof Kozlowski wrote:
>> On 12/02/2024 17:50, Johan Hovold wrote:
>>> Whether the 'msi-map-mask' property is needed or not depends on how the
>>> MSI interrupts are mapped and it should therefore not be described as
>>> required.
>>
>> I could imagine that on all devices the interrupts are mapped in a way
>> you need to provide msi-map-mask. IOW, can there be a Qualcomm platform
>> without msi-map-mask?
> 
> I don't have access to the documentation so I'll leave that for you guys
> to determine. I do note that the downstream DT does not use it and that
> we have a new devicetree in linux-next which also does not have it:
> 
> 	https://lore.kernel.org/r/20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org
> 
> But at least the latter looks like an omission that should be fixed.

Hm, either that or the mask for sm8450 was not needed as well. Anyway,
thanks for explanation, appreciated!


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


