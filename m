Return-Path: <linux-pci+bounces-2246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950F83007B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 08:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F325F1F24E1B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88439467;
	Wed, 17 Jan 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em/bewgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F91C2C6
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476177; cv=none; b=oddO4D8RQThGie334JsQ+P7MLHUutmndfcKBYiOVV6Us7Tnb/Gg3Gva8FGd0+A76VAusd1r+wBh2QsPcSM2YyZjuy+8sGTCGcixl5sQM+Gv1fqzft8h8O/XFh9MVRRYjY2BxPKOWebAm0YE2aZ5EVNSj050n1FuvIGFCBLtxTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476177; c=relaxed/simple;
	bh=tQ9ArgiEIxDhZiS+bkgzgrxh5erJCH0nJTQEtIK/eEo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=JIu+wmebpOI8GIxGszJTDOuvuZWJo9u5muX+gca5ZU5qU71XPYlIIM0Cs7OlDgylpVlKPbAIAe2OP9yb1yLMhShS5aShQkySvUi3lxiBGVpQn1wygbSEZ6NESxELDJQJQP2Wwqr/afqj85scRVD9H73pYO55I7YSjhIdTP9Mf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em/bewgX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso124748951fa.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705476174; x=1706080974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOYHVbiUAnjjQrw6HsFcyiBwIfZXDGBhM5yuxq5BenE=;
        b=Em/bewgXnZV/S6jk3dKi9cybwRALWAiDgjvmm59gMgAN6MUK/AQnvEAvBoePFnOZ0s
         1Zt9Xh92tfs4ltHNeQMV68y0VUwnk0mOMHtF5d9S+2Qxt9/c0p3gUDJFH4BzwVezYBS7
         B27kOzBIkcAA+IRzOyvTay9eM/ARyCUx7QG56fqZ3pSm4RqEDh0lwb0qZUYqwUVBZeLy
         d+LCVGJRv41IwabgFD5lsmXUZSyn7foQ9wfHgfISqgWJZQht3kVq60RN1vJ88T+ub30X
         N2tYYk+fue+U6e0Dc5MjwsGN/TDcpue94cT3EYH1N2JThnqCqjhhU1kc/UqG8AIlP5rC
         Z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705476174; x=1706080974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOYHVbiUAnjjQrw6HsFcyiBwIfZXDGBhM5yuxq5BenE=;
        b=wP8W8w7xsCzLJu0u86d24tDz52BYUvOpxvFOY6Qag4mUevpuE2Sxvs8S7m04abgQyG
         DCt3gv5BlVRLwyye+V84qEQz4keXW5zQAFbJkmtUWINOD3xjXe0v9VF+28DaGxbXLrJ0
         ++wVYNoxNIReYp0iuqX+hPoPAiFsd4zy3il9EDT7mv/pEqL70deueIcLtJH+Ikz11DvX
         BJax5idrYhxbWMTJVcbQXjW2fjfnOe/7STvLYXslsIY2N239Kcbzsgyom+vGksWi0bvf
         Nt1uoEic2gX/F0B7HVCNmamC97b9tr8jiCkbSaf9cJa2xQbELBaMQLuB1HRf1R0OdLHV
         Gzhw==
X-Gm-Message-State: AOJu0YwqroOyJ9AKJh1PPyyxt6CXwGeriO4KrFFzljJr+792ZpEzUl4C
	OlSNMTuCpT4oQ/dw5f7RUeQ1dSvWIcZyCg==
X-Google-Smtp-Source: AGHT+IHVcF0qeMEpqs7uSkwl1gujCZSqpe2AEHAv6VCSRq3gAHW9c+mFiHiyS4ZxEJ6pJzQ5249ZBw==
X-Received: by 2002:a2e:bd87:0:b0:2cd:cfdb:c2b3 with SMTP id o7-20020a2ebd87000000b002cdcfdbc2b3mr2415461ljq.101.1705476174083;
        Tue, 16 Jan 2024 23:22:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm1332043edb.6.2024.01.16.23.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:22:53 -0800 (PST)
Message-ID: <18300e5d-364c-4d62-b460-781dc44b8f9c@linaro.org>
Date: Wed, 17 Jan 2024 08:22:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-2-d541f05f4de0@linaro.org>
 <20240116144832.GA3862516-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240116144832.GA3862516-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 15:48, Rob Herring wrote:
>> +        clock-names:
>> +          items:
>> +            - const: pipe # PIPE clock
>> +            - const: pipe_mux # PIPE MUX
>> +            - const: phy_pipe # PIPE output clock
>> +            - const: ref # REFERENCE clock
>> +            - const: aux # Auxiliary clock
>> +            - const: cfg # Configuration clock
>> +            - const: bus_master # Master AXI clock
>> +            - const: bus_slave # Slave AXI clock
>> +            - const: slave_q2a # Slave Q2A clock
>> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> 
> Almost the same list. Combine them and just make the 11th entry "enum: 
> [aggre0, aggre1]".

Sure.

Best regards,
Krzysztof


