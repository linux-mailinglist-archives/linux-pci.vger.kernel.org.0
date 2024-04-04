Return-Path: <linux-pci+bounces-5745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB00898F09
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE021C22121
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F0134439;
	Thu,  4 Apr 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj1OcjXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A0133419
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259034; cv=none; b=qBOC+rRzKiQ3RkNCouwFb9Q79hwYjcNqBzHWUSiGPKPsvR+Ir3GTl4t+4rxJh/3d/GgJrQe8aMYSpOSZgOyW5hplmwEX+cs5y1DK3ZmCDuXUSG3B7EbvJdTuZ2lbRAj4I8qaDrU1X090zPi3V8ZH+kjzo8kyI3rujHob1O+sY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259034; c=relaxed/simple;
	bh=w5sLbhKNiFT6ejKWbgQ77eClEuya0F+lt7zUWfg8hZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IARimXzcHaSPgkpQszCHW2BVa94JFiEYDCD+A4O0EHeETNybOlB1Nvbaau8aPzgM+2gvZt8WfZSjHnIpfSdj3/sdO+RoEx2pAWNoGAKqALqvf7j5EpSeVPdqQVMIPnGSCW1o0SK8urO4oVLQH8whvR91s5Iw4kqRlSyYZi7gosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nj1OcjXG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516c547fb4eso1926048e87.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712259031; x=1712863831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg07bkYSH6sLrzzElg+Rn2GgV4JOOW7i3DjKAoQu/3k=;
        b=Nj1OcjXG4RlGoFrR1T0QlPntZ5c+KK/p9b6lCOemMW5+jQ3yKCOk6DweDvAF9NU5fM
         5FH0RrYOL0kZqLwLVswuTxJbEia6zUT/ACOYKxW0SIX22pHtQJu9g8/oEwipj662+TtI
         pja2mVZqQHkdRl9xw07cfPOkVN4RlWP9I6l0i+UEgsILwis9AyhwQ/KO0zKi9lWrMsw4
         X6gSwWIJ41i2CYvVXnMrqp1EqTYI/4rHnSSIubxc82aoIWbJUYtuO5pE0QMi0lhhesDf
         CMaWGVEB6J7P+nAci/MdKtNWEuw8M3qg9chXm2A7Ngq/LojZqvDD4IsVjDSHVz0ALNwq
         FkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259031; x=1712863831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg07bkYSH6sLrzzElg+Rn2GgV4JOOW7i3DjKAoQu/3k=;
        b=NdVogAKjLHqjY/TqTO/8yRFNiaLeg+pZokY9e20R8w7IK6HIXmTMHPM4H2z23zB2ZW
         xG4Pmd2/k8XqT8au6pQ0l9JaAWts3JYhG+jMjxe0Kl9XpxxshRWq++cqLu2QTXN8Tmfl
         TTAn1o9JAEoX8oii3RosCYpnXIdfGni6heL7h39ncgqUFBH2Z9fOtawI3MT8P3wI7E/k
         mxXViym+IC6eyvlVPz/K0Zh49borcFOCJo03vq/qNVyFP3sy7rgQWmd9Oc+FtgucWDAP
         PHUg59U/7+lHZTXhOpWQr2+IxJ4+A/+70cSw9voBwF09CwO+A8OO+Nr2P/yXXGRGce+Z
         w6pg==
X-Forwarded-Encrypted: i=1; AJvYcCX6rhSiWDBCgQx0oY0QTYLEFVSShwQP/2d8W+W6D4YJYDqoiX7ycSYTatehoqWCvmyyX7XMQLJ+jTVO6KSQVjpoHrzHaWLBA3xf
X-Gm-Message-State: AOJu0YxOArdWzUM0cvXTjIvCWKZOcc/PqV8ZQMGxwaIIgY8R6TntRjQZ
	DEVs+6fQGCKQzciV6xvKisUQKJMpH9fvXzPlLIjpocEy0BKBEc1t32VuFc2QQug=
X-Google-Smtp-Source: AGHT+IEvm1G5SQhUJuZ3P5dxlFI0YClZgQrdPKzn3m0pg7Qe3F9PkbTeOFDk4DtBnzuHzYqohzn5rQ==
X-Received: by 2002:ac2:5150:0:b0:516:a908:1880 with SMTP id q16-20020ac25150000000b00516a9081880mr209765lfd.31.1712259030708;
        Thu, 04 Apr 2024 12:30:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm9331068ejc.53.2024.04.04.12.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:30:30 -0700 (PDT)
Message-ID: <51b02d02-0e20-49df-ad13-e3dbe3c3214f@linaro.org>
Date: Thu, 4 Apr 2024 21:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] dt-bindings: pcie: Document QCOM PCIE ECAM
 compatible root complex
To: Mayank Rana <quic_mrana@quicinc.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 andersson@kernel.org, manivannan.sadhasivam@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
 quic_nkela@quicinc.com, quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 21:11, Mayank Rana wrote:
> On some of Qualcomm platform, firmware configures PCIe controller in RC

On which?

Your commit or binding must answer to all such questions.

> mode with static iATU window mappings of configuration space for entire
> supported bus range in ECAM compatible mode. Firmware also manages PCIe
> PHY as well required system resources. Here document properties and
> required configuration to power up QCOM PCIe ECAM compatible root complex
> and PHY for PCIe functionality.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ecam.yaml    | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
> new file mode 100644
> index 00000000..c209f12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-ecam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm ECAM compliant PCI express root complex
> +
> +description: |
Do not need '|' unless you need to preserve formatting.


> +  Qualcomm SOC based ECAM compatible PCIe root complex supporting MSI controller.

Which SoC?

> +  Firmware configures PCIe controller in RC mode with static iATU window mappings
> +  of configuration space for entire supported bus range in ECAM compatible mode.
> +
> +maintainers:
> +  - Mayank Rana <quic_mrana@quicinc.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
> +
> +properties:
> +  compatible:
> +    const: qcom,pcie-ecam-rc

No, this must have SoC specific compatibles.

> +
> +  reg:
> +    minItems: 1

maxItems instead

> +    description: ECAM address space starting from root port till supported bus range
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 8

This is way too unspecific.

> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 3

Why variable?

> +
> +  iommu-map:
> +    minItems: 1
> +    maxItems: 16

Why variable?

Open existing bindings and look how it is done.


> +
> +  power-domains:
> +    maxItems: 1
> +    description: A phandle to node which is able support way to communicate with firmware
> +        for enabling PCIe controller and PHY as well managing all system resources needed to
> +        make both controller and PHY operational for PCIe functionality.

This description does not tell me much. Say something specific. And drop
redundant parts like phandle.


> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ranges
> +  - power-domains
> +  - device_type
> +  - linux,pci-domain
> +  - bus-range
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie0: pci@1c00000 {
> +            compatible = "qcom,pcie-ecam-rc";
> +            reg = <0x4 0x00000000 0 0x10000000>;
> +            device_type = "pci";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges = <0x01000000 0x0 0x40000000 0x0 0x40000000 0x0 0x100000>,
> +                <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
> +                <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x100000>;

Follow DTS coding style about placement and alignment.

Best regards,
Krzysztof


