Return-Path: <linux-pci+bounces-2269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB783040D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC3B1C23FEF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A041DDCD;
	Wed, 17 Jan 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4JDaCEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981151DDCB
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489228; cv=none; b=EwYTrf+g6uAzHSmVw6y8r9RmTSW8R6lqmL/YDmmMCKcplS2ogeUhMVmWkKP7s1WW2nMDgYrTVzaKtBckAakgXCz+igrpYVC7OtV4YF8RtWdKkwya0q83W2/7N9ywUVl0t/+NG511GQSnP3H3EsoZ9xBqhVWZ0oaL9UUDBX6oQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489228; c=relaxed/simple;
	bh=xITngsa7kURJbqrGacQMsRJE78y1+AtxESRJ0OP4zeM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=TAg4j6qME/t+JGZ14hJhe8VdIMZz4ebzI4r1m42rO7+fijligVPUHTsUGcHjhMcpF4lp5+qA6zQkFhRU97AiG8D0SMOLBMijE9Y4ER+Zg1iFD+BmKkDyCyExgFvf3qBpDfwZgXIgTEraeTrYv6k0VJOBSeD3vlS4BJr9ePPCTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4JDaCEz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2ece31f5fdso54681766b.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 03:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705489225; x=1706094025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvQG4DrpE5UuG4DHiKrCJuNyFv3LnCINktwYGG00pD8=;
        b=O4JDaCEzH+ozQHxl30Ag4QFxLhu+n/f4+DuWgbaSIRUckeY4mhLvnXbMRvL/JCvG5Y
         8XQ+fV24l/z8e6Sr9u90ef/mPliPPiJvktn1A0B4QaeEObEeFMotp4tNU+dgQGmz3kKj
         LE8Mh1BnIMJTRnSMrLJ7xq7qyQ5NiZXKAOlYQCY3ujJj+vSSgCS0UmvwaQhQZvbeULbg
         3iUGMIjPBRhxFU7XKXET1udZoNPkA4mudOLNYuZl5D76ljWZjCiAIj2ArbLgVEx9u8or
         lDPogKEF3GVMjB7cRlje30jKxw6/ZGgazEG6cuc8UB131W5KAnNrPQAZMTG0cOr3Cqpw
         tUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705489225; x=1706094025;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvQG4DrpE5UuG4DHiKrCJuNyFv3LnCINktwYGG00pD8=;
        b=itCfsN3L3klubBeNxPRd21qIchzoe53HqQ+TDsLOej57hdyfy5mEwtFKBCh8axeCDf
         Dsz4PoExH+mOL8HRdJrEVK2drxyZlC85oYt60NHg3bAQSfkkubLKlI07gWJ3j7SSXk8+
         Rwr7uQSPwdb8Kphzj+1VqQt8buYYpOWNOSEGF5HXmYCVkdTOJQ7qWy5Jc51++a6+0ODr
         yzTSGNvTVboEPXK29H520UUKBssDTsIR31ARq6uJnvIkjKyP8I5jW+x7lYC/07O+sX2J
         CtorRjhS5X+jecAHF90MmkmI3imUcC1XsBxKhNNdcSoytCaxJNcNz6u1EqtcZaw2htJu
         qcJQ==
X-Gm-Message-State: AOJu0Yz1efslK52cP4BoqRgFhYuqutB1L3LJGO3IINKulxWnJV6kXA0f
	nf+WKvpKHtlLxrM4NAEf6hFAuoYXL2G82Q==
X-Google-Smtp-Source: AGHT+IF0OyPQpTuLu6ZrWZsiHFt/HVcqNRGmZjG59iRkVkoElvwf+l2rN4aeTwAGnPw4FILtPYxxvQ==
X-Received: by 2002:a17:906:9c8f:b0:a2d:9379:7fe6 with SMTP id fj15-20020a1709069c8f00b00a2d93797fe6mr3030098ejc.61.1705489224891;
        Wed, 17 Jan 2024 03:00:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906561200b00a2e99c12ea5sm1384161ejq.157.2024.01.17.03.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 03:00:24 -0800 (PST)
Message-ID: <42f44ecc-c7f4-4209-8cb5-805891c35413@linaro.org>
Date: Wed, 17 Jan 2024 12:00:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-*: Add checks for
 max-link-speed
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-3-s-vadapalli@ti.com>
 <4282b248-cb7f-4486-bde6-105a3aed6be2@linaro.org>
 <92ceb1ea-78db-4bc4-af1f-a1690eaca24c@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <92ceb1ea-78db-4bc4-af1f-a1690eaca24c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 11:58, Siddharth Vadapalli wrote:
> On 17/01/24 16:05, Krzysztof Kozlowski wrote:
>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>> Extend the existing compatible based checks for validating and enforcing
>>> the "max-link-speed" property.
>>
>> Based on what? Driver or hardware? Your entire change suggests you
> 
> Hardware. The PCIe controller on AM64 SoC supports up to Gen2 link speed while
> the PCIe controllers on other SoCs support Gen3 link speed.
> 
>> should just drop it from the binding, because this can be deduced from
>> compatible.
> 
> Could you please clarify? Isn't the addition of the checks for "max-link-speed"
> identical to the checks which were added for "num-lanes", both of which are
> Hardware specific?

Compatible defines these values, at least what it looks like from the patch.

Best regards,
Krzysztof


