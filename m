Return-Path: <linux-pci+bounces-838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34021810A41
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 07:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26F31F212E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 06:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC5F9F7;
	Wed, 13 Dec 2023 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLE7MoJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFBAD
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 22:28:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2cb20c82a79so68692121fa.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 22:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448890; x=1703053690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2t8hozxFxq5t5CAXeioYWvOLvwHdP83F/jAbrrScuk=;
        b=xLE7MoJ/RS0GR3dfcGLfMdP9WnX3gvZpgMZbHSE06IJ5iBBpqCkhTY9/iI9HrVj/Jt
         iVueQsix0gANrpwKIHwVT0bWGrB9wKwtQ7+sHjsgp0Mym5wMCmVp19mFD8oAGncfgyDp
         XG8BfLw/NQnRIh95prmcpCy1c4oM9GwzBMtPe+4lKPnVMHryVpRitCi6VQIfDIIf5Wka
         BRrdwAbxF8pnQfWaUN18NMt5TKyU6Olbwg/XveS5A7Cdp3zv4kZmTON/IdB4FKHODxUC
         thNQVeNg/58lU1KFLzXsrS44fcGMzmACHMeUJDHtACTrOHMavz+aMyjd3zvCSLd4cCar
         fcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448890; x=1703053690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2t8hozxFxq5t5CAXeioYWvOLvwHdP83F/jAbrrScuk=;
        b=Ifw1xft7PBAGPjsTQh6jfxpLS7R/76c869Ms10r0uN8Tq6eebCmhBX2EVHTaup6q8n
         b5gK2hIOGE+wBfq7dOxClBpvw1okA4m4CN+sidCwSS9bLCFL7AKs973oC9k7TWIYlYTA
         ZI91HAjsTmLgoE/5+JdQ4VA/1sXCWcv68D1wtdtFPVGI5IlOm3wL/rHgzxiVS+veQKqD
         AXciOI5mdvicpEpBEVSC3TqqfMK0a9pGrnmVvl1GKB1bZvzl1AJYHwDBgwWlP7NGjWWd
         9CJPQP7KlvBLGzCHd5s29PN3J3kAKjLsJzNjc5pfuOIXHBhFV7hlaVeb7K35yz9yhElg
         RtOQ==
X-Gm-Message-State: AOJu0YxU9SLhIdn8PlHm/W+Op6L9QIcOrOuQ48PykDwMNKq4RBXxmtig
	uGsbNdY1r5Ht1/gRFaU7xzv1Tw==
X-Google-Smtp-Source: AGHT+IHHZoVmjDWhy9GURQv+supetmAnz/ygdNDQCUpBrIPQbV8/LpENCIUD8FYRQUQZ7k18uvGYsA==
X-Received: by 2002:a2e:a80d:0:b0:2cc:1ec1:90f4 with SMTP id l13-20020a2ea80d000000b002cc1ec190f4mr4106608ljq.69.1702448889989;
        Tue, 12 Dec 2023 22:28:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s28-20020a50ab1c000000b0054c6b50df3asm5566246edc.92.2023.12.12.22.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 22:28:09 -0800 (PST)
Message-ID: <8ea476e0-e026-4599-a5d5-66a499a1f422@linaro.org>
Date: Wed, 13 Dec 2023 07:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
 imx@lists.linux.dev, kernel@pengutronix.de,
 krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
 <20231212224426.GA2948988-robh@kernel.org>
 <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2023 00:28, Frank Li wrote:
	>>>      items:
>>> @@ -90,6 +91,22 @@ required:
>>>  allOf:
>>>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>>>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - fsl,imx95-pcie
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 4
>>> +        reg-names:
>>> +          items:
>>> +            - const: dbi
>>> +            - const: serdes
>>
>> Did you test this? It should fail because 'serdes' would need to be 
>> added to snps,dw-pcie.yaml.
> 
> I run "make dt_binding_check DT_SCHEMA_FILES=/pci/", no error report.
> And PCIe function can work.

Did you test your DTS. The answer is, like Rob suspected: no, you did
not test it.

This fails.

Best regards,
Krzysztof


