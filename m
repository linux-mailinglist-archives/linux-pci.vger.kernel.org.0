Return-Path: <linux-pci+bounces-1333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A181D875
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 10:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963941F217C5
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0215A1;
	Sun, 24 Dec 2023 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+QbtlGZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092B15C5
	for <linux-pci@vger.kernel.org>; Sun, 24 Dec 2023 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b5155e154so40670955e9.3
        for <linux-pci@vger.kernel.org>; Sun, 24 Dec 2023 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703408550; x=1704013350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mikORaWigqoz+zexEhJ5QPZXv6VeQouYf6VKAdwFvI8=;
        b=d+QbtlGZ+1WB7zhS27xeNvziiqJtdweVit7aC7p8pqhRDM00ZnOi7Rxfh9cZTSqwjw
         PhyhIEzY8NaCFOC7jcU4KFoqiYsCSWQplBzvYpxyxPQLazw3yfVSZgUXy0V8dP/8l0Ef
         7Vv6dN0hdSTWfXmi91XkyoSPSMJPpGqq0wUaYUSEyP3Z+UZmhS1zd/pk8wb2z/6sbXgf
         uCA3CsWGzuQFg0CPwCxeC+oGEQFtko3sBnszRBX3pigpmObyHhaGekK/3kjIAQIXKg9l
         m9B9XMWoh1OsSZQkWlUjn8oy0wkIHwAsO5afl6HXbaAvpSc2t5bwGr2oITDgjFEXebsz
         aWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703408550; x=1704013350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mikORaWigqoz+zexEhJ5QPZXv6VeQouYf6VKAdwFvI8=;
        b=dstiYW1FXoGvRsn+ApM/Mo1JZM8jL4hCpTKwgbxzOpg9roCf27Ng6QYoS/yMF66Wo/
         +85l16zY6XEzqzrUbXwM5KDk9ZF4Ccu0VzFIFLTReeW96+ZfMHy6X1/GauMAfCXmv/Jw
         ZDvNwibo0S7HFAnPV5oeQ4c9VlfSAwIHHWH891vCQ/JwLVd4KsQwOZne0wglOC62Bm2P
         ClncTH6y5f53RnTobwocaZfwgZKEDDoNJuKyBwpXGLE76OwfgaehfIS0KgWV9aP0bkuZ
         u7BVkqBJSOGb62l/TB5kXbrxQH9o+eL8HfKhGMWzTFACa9aKCAFIe+C3AtZk2dhVw2yz
         lMiA==
X-Gm-Message-State: AOJu0YyxhaOa7NEiiWDah2ZdsQXOlFBFYtfuqiT5M5DSE0yXFI91tzhq
	ie46TpojUTko959UTH7kQFjuoWxqrryljg==
X-Google-Smtp-Source: AGHT+IF8LMi5Ib/9H9NjAqLPPMqJEdmNFzOXKkAG/sCeozv8KCFi5PmNPV2+MomKOW0BqlIXYPA9cA==
X-Received: by 2002:a05:600c:4f94:b0:40c:3e0a:692e with SMTP id n20-20020a05600c4f9400b0040c3e0a692emr2113243wmq.232.1703408550391;
        Sun, 24 Dec 2023 01:02:30 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id el1-20020a170907284100b00a1c96e987c4sm3784963ejc.101.2023.12.24.01.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Dec 2023 01:02:29 -0800 (PST)
Message-ID: <cf231452-e1e6-44bd-bff4-c699d5f2a53a@linaro.org>
Date: Sun, 24 Dec 2023 10:02:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as
 required for iMX8MQ
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
 l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-5-Frank.Li@nxp.com>
 <f6d9a333-3259-4dc6-bdc7-23ffa26e590b@linaro.org>
 <ZYeznY7gXM+zoQeB@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYeznY7gXM+zoQeB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/12/2023 05:29, Frank Li wrote:
> On Sat, Dec 23, 2023 at 07:40:28PM +0100, Krzysztof Kozlowski wrote:
>> On 20/12/2023 22:36, Frank Li wrote:
>>> iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
>>> proptery for iMX8MQ to indicate pci controller index.
>>
>>
>> Why it has to be required? Everything will work fine if skipped.
>> Otherwise please provide reason why it must be *required*.
> 
> Next patch will use "linux,pci-domain" as PCI slot ID, instead compared
> with hard code register address.
> 
> The below code will be removed.
> 
> -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -			imx6_pcie->controller_id = 1;
> 
> 
> when there are more than 2 controller, this compare logic will become
> complex. 
> 
> So after next patch, "linux,pci-domain" will be required.

Nothing in commit msg explains this. Why you cannot use some
auto-incremented values when this is missing?

Best regards,
Krzysztof


