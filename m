Return-Path: <linux-pci+bounces-1389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F406781E91A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 20:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F51F21A1A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5B643;
	Tue, 26 Dec 2023 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTaMjA8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604DA1104
	for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2023 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a235e394758so476541166b.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2023 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703617316; x=1704222116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mv/k4E8tNQsDocRbC/Q62jxBeX63xNG+uOzrvraohns=;
        b=yTaMjA8LGiEBhymAIHJMQruV7Zl3nKkMA2AButKZnyt0FRWJKMYYgYSDgIJ7NROaH9
         36M2iEUXIdX7I1Q+GT5qTxGHbFkCiZ2sMjiK1vEEiZX/ECAxgzyDV8OMRzX4Z3l1NWa7
         Cbfnq9YZn0KhjAGO97aqJvykOmO0r/DYQFHO13BuR+GWDZXDH9vwDqfeJj1DvjOh9l23
         mw4hFgrRd4+5v2cLcLwEWz94F83MdjYY8ha/dD3Ieb1wVayx5COK03rt8k+c0I6MFyGT
         EJPhWw+8hyGCNJsGjIxKCD2xlXcfR4yrGe/zhafEOzHD2RPYlH2fqQO5taMvUXOikAP/
         Ln8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617316; x=1704222116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv/k4E8tNQsDocRbC/Q62jxBeX63xNG+uOzrvraohns=;
        b=FaORQTSOxSFGLpNfZiWw+2aKeOT4SVjOoT/bImgPi+DReGA5ZCG4nFVrMfcpKTIi6C
         G9PJlZY2SAmZ0ZNzc0qgxGFovLkVqGle1ou1mRwhV7uer6Z6EjWV9xA8gYcN/haK7xW/
         RSB+5J/wcJwzxIIDwm0ydrKOgLHBuuA/+8LyK+tyPQ7ZlQRFEeN11r8jwnyaanrXn1wu
         8bMlvzGxwDxrymha1v+8l272mymQVcINN/CPcQp/LZYA7j5XB8dphckga7oiLpnmqio8
         SH25BWOg0mcmPBvnUPYWJ3c7fxPc0v7l0zHOPw2VeX/HlsgX5ZIRRzImT4IyOA8ZUZof
         9QSg==
X-Gm-Message-State: AOJu0Yx561mBO6VjJelReFCGhX+pLOk4yaDTXwMzAj0rMmeZlsh0EK8a
	GApqi0s+VHiryEu2I1dp3XYDggUCCiXnVA==
X-Google-Smtp-Source: AGHT+IHsHiD6Zn3OsjK2DGYYWjTYRSHvI51xN7TxWZ3bS/xX57kGlz8kaVDKsTPlumPpdg/oqCnyfQ==
X-Received: by 2002:a17:906:150:b0:a19:a19b:78a8 with SMTP id 16-20020a170906015000b00a19a19b78a8mr4096990ejh.107.1703617315124;
        Tue, 26 Dec 2023 11:01:55 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906b21200b00a26f69ca8d0sm1759085ejz.71.2023.12.26.11.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 11:01:54 -0800 (PST)
Message-ID: <0233cf48-93cb-4f19-ad1d-e3e1835c1fef@linaro.org>
Date: Tue, 26 Dec 2023 20:01:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint
 compatible string
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
 imx@lists.linux.dev, kernel@pengutronix.de,
 krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
 <20231224183242.1675372-16-Frank.Li@nxp.com>
 <6a61f325-a58b-4aa6-9a0a-7a3086f63829@linaro.org>
 <ZYr7Y+mJea6fChjS@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYr7Y+mJea6fChjS@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 17:12, Frank Li wrote:
> On Mon, Dec 25, 2023 at 08:16:17PM +0100, Krzysztof Kozlowski wrote:
>> On 24/12/2023 19:32, Frank Li wrote:
>>> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
>>> Add reg-name: "atu", "dbi2", "dma" and "app".
>>> Reuse PCI linux,pci-domain as controller id at endpoint.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>
>>
>> ...
>>
>>> +# reuse PCI linux,pci-domain as controller id at Endpoint
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - fsl,imx95-pcie-ep
>>> +    then:
>>> +      properties:
>>> +        linux,pci-domain: true
>>
>> Same comment: why do you need? Don't ignore my feedback. You responded
>> you will fix it, but it is still here...
> 
> DTB_CHECK report error after I remove it. linux,pci-domain is only define
> in pci, not pci-ep.

Ah, thank you, indeed.

> 
> So I add comments about this. linux,pci-domain was resued ad controller id.

However maybe there is reason why it is not for endpoints. The
description is saying it is valid only for host bridge, so maybe it
should not be used for endpoint case?
> 
> If include pci.yaml, there are too much other properties was involved, but
> not used by pci-ep.

Best regards,
Krzysztof


