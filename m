Return-Path: <linux-pci+bounces-3951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2B861EFB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2A52876F5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B11493A7;
	Fri, 23 Feb 2024 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9+7th9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639D149388
	for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723547; cv=none; b=eS9vk1FOw+4Amz37K/XvHAy4E1/9Emvk5S1zHhjyTOjHTIyVnvNYPHHAVlda+iBpKOGPVbqniMzrD6jtBXf2k2LW6lVN0eU1UH/sAuD4zTio+pNgZdZ8hiSN94qtnmzsDqsexOO9/u2b4jCi5WLO9T5TqEH32Zipro3vOROMaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723547; c=relaxed/simple;
	bh=cznru99JdJHjYPRTDqG+Ij9bUF4G0y01OJxHAa8WieY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqF5o5Ykndg0nFmJGkhLBMbYNEN1kT6odzaedVhITNEJVKCOzzjRIJj8l055CeMpPQMo9MM3Lnmv2Cu9+2UM35du5rzQd3LUKxp2HzUJdxNUAXicvWqqTUo0riK/Yg6ItTG+7tRpk0Vq68kbPBRYIouXStzL88C8HTYL9xJRNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9+7th9n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f48422fb6so193757066b.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723544; x=1709328344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qbxz9GI5TYSbblK7pzea+6nrc2QZyFVzyiNGXILEiiU=;
        b=p9+7th9ndqqLgFR2na7qxhFIOKhOBWwbLLzFRJPmcY6T2fvmbDmhypsrzIbkujP3Ir
         Fx7/tBa08oXfBQsbPQfbreqPD5ieBakM6+f22u0iNCQO/yDzlNi5fI3+F2Mtxh8UG7sN
         sCSGfa3Z6Dx7zx3S9KvZN6FjLydVd2x3v1Cn5e3fpt8U3ebjytuQMQtXoNljzpzC7SJq
         HfplxS6P4iFhszC7cgWlCwzIptimfJ+yfm1WcUHj9+Nq8vlrCOOfNiloItOABjjQfKRs
         UMXHxmYoG37P0AthS5gzd8212JfXuMGnZzyOeAyXQALJEOmNKDyPX6bGo23FHxd5nNZl
         amcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723544; x=1709328344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbxz9GI5TYSbblK7pzea+6nrc2QZyFVzyiNGXILEiiU=;
        b=BoHX8RleMev9fZY5Hyfo61CEAb7ObR0rv+Dw+3KfjpKwBO5xApBeR7WgcrURtMWBBa
         vhWiw7K0McRhyZ7hEUZfedXBRmJ8QOqXQSKovYDII5SE6kX/jKZexfoDoSxnNun2nSDJ
         UVQD8qBErahqFTPPaSo9c3w6S/Yo/eG2AYt38eI9BHykngKXxFne0tyBzSKmWKVzM6T+
         axX3/n8eTp3TctHtVKSxRRQneQ9nHV/3H+74gppT8FUf71L6/XU9Df3RBU+1MHYCjHoa
         7bmtpTqzpEbpv3dNsXqbivIlYzJoyn/+t/CxU+UgpXY5ORUGLLI9wm4yVeV86KC8F+Ue
         tPvw==
X-Forwarded-Encrypted: i=1; AJvYcCW+45/oPHw1yVvAVcAYkBGFNu4lYb4SMwawv+iLMYIr8rU1h76u8C0fXrIMhuTcN4Hi3MDQ8suQEf8nMqqM1k5AepGCqLO4qsz6
X-Gm-Message-State: AOJu0YwzWDms0YaQaW3QXw98WeDJNREFNa+ao9gRsR3jw5/ID3f+GwxX
	b2WvDkzV0vPgfhu9vBcK3BnhTYRlSxS6IDgCDQiePr4xWGvHP/1GtOWtVIvE650=
X-Google-Smtp-Source: AGHT+IFZ83jp0CDVt6x3vmjwK0NWjGYRBnitrlUMc2n4Pk6Z6K68JDuNOD7oAMsVm693U374nnVczg==
X-Received: by 2002:a17:906:260d:b0:a3e:5cb9:8a4f with SMTP id h13-20020a170906260d00b00a3e5cb98a4fmr720080ejc.58.1708723544340;
        Fri, 23 Feb 2024 13:25:44 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id pv14-20020a170907208e00b00a3f45b80559sm2738150ejb.139.2024.02.23.13.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:25:43 -0800 (PST)
Message-ID: <f3f28cf4-36a3-47a6-a6fc-166491c8fe05@linaro.org>
Date: Fri, 23 Feb 2024 22:25:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link
 speed
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240223152124.20042-7-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223152124.20042-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 16:21, Johan Hovold wrote:
> Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
> speed that Windows uses.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

