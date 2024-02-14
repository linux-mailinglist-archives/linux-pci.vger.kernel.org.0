Return-Path: <linux-pci+bounces-3440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108B78548CB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC83D28850C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835F1AADF;
	Wed, 14 Feb 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbpKj7+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31F18E0E
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911840; cv=none; b=uXO+qsJvgGm5gLqMJZhxQJ+2DuNPamoPt6oOF4BUZ84XzWZ9ECU2DrNShY7Le3fI1gB1xpQ9j+0pu7pmB9yEf65m91OApilB1xkyYMnpU5kcyy853hLIWqufHodmHd1OTprynR4bGglQjNwpl+Kotlrb9na/dJcviGaxlZhXnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911840; c=relaxed/simple;
	bh=j5D+aaINxjsyHj6AbcFk+lVgmtpCveQmLd43Ckd6TLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSYfQdv6ou5wz/Wzat/VbCd2ENZFyIT98c3n6qsp77NYF09UTmuDqDN8FBTQG5lFUvu5X1rZ7juKt5GIMr3/Zw5J+//2XH2JG9WSOgdBJUJc9n1tU/IXYgcQaCah/CJlaLdmxb89QzLcHB4w5LlErhuMdpwU8h3oIf/Q9p/nt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbpKj7+/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d2cce1126so127311266b.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911836; x=1708516636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBqQgbk5nDN6cJZduC7G0efsieUXmtSdBOExCpTWUcs=;
        b=vbpKj7+/kQBwyVs0ONW+CIy+JUbLheBbi9J71hbHvZpTZ3R3Id4eypU2IQZWLRJ9YS
         j3S/7VPmdPinLF29e2Ks7S6ED8KbR0+LAmRe8eP/gyeb0o6XryPIWCDpOX90WJqPYcGq
         4PMAW4BXB7rEP/YNdioZ1A3FeiheX9ePiteQ80wYNqnYsiLgExvctXEerbyK2qSzsnXb
         ws0mmL/FRQbzWpW1lXBRGN9dGLz4dy+X5OM7hK9JB2GjGFr2cn9U+upboUFLdQKsaxQJ
         b84eJlDBBivGV+8aEZQ3WKsetWBH90ESluhn8nPvZg1sFQkA5mNQ3wdqs34SrMDFzbct
         2mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911836; x=1708516636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBqQgbk5nDN6cJZduC7G0efsieUXmtSdBOExCpTWUcs=;
        b=ex9w2HEZHkNQYwYwbjRk2lhblBG9hJB2yxZlk4XhkWIlboy2Q4bIwRzUtfZyBwJy6q
         Pq3/9EmvbqZf7IRQBQTSoZatbh5oZfH7qPIvracSG4XWjQshXSqGbpFqsnI9RyPoIwjC
         Qlf6Q/WfP9MJNWKsKhwNNWt5LXWzscNx0PbQb9vJQ/7Da16fRA7B+WWrQLBMuQJzT/g/
         xKUAACaSurpT8wz5cVSu2YKI/d2fwb9zSCSGpzK8r448q/x+1cHNjI+hhyQHjmtzRymu
         15YrjHFVSmCCsqduz7IG+h9iOHo9eRv4Iz8hChlgvo9I9glKE5i32Reg1dEuKkR1Pabc
         9M6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhDDG5NjFqXDNN1ZbfPB5lDpKcdbEtU21UnZHUio/lHLKja0IpzA2kz1FR7EoKSHrPo7sSXFjerXaTUaYDQuySYVUn2T/JdEiV
X-Gm-Message-State: AOJu0Yw2B8Sg5coKhf+QwUpBo3Vl5Bze5W/bYq+sDB6D792b3gPOowh0
	OnXWiHJwrNWHHdY41u4cHMwi2vZaM9cs6xOqzE9gYnCNcJ767AuOacnUN1vqWXQ=
X-Google-Smtp-Source: AGHT+IHCDxoqeZ0mJmnEhebLNy6Cntpyan+In0zepTM6F82dKssYlXjjtGDIFU8tEOepTZUtps+JKA==
X-Received: by 2002:a17:906:e092:b0:a3c:f609:5352 with SMTP id gh18-20020a170906e09200b00a3cf6095352mr1514086ejb.28.1707911836510;
        Wed, 14 Feb 2024 03:57:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD0qgac/Vn3nYmhizLYaP3xey+x5EdN2iKf9EqkioG0EFBXzqNzwr7NNhTAgQiTv1Jxr3fWBO+ae+Cl9NofsaL9hQyaNTpqMBQREk3WGOrhf+N4LuBXVspmtJn/tezuSJcXtmkxR6Czbo5VaG1CLkoc+LxPTa76ZW/k9zXJFepz063dlQtY6VWLXsqrUHAo1lexslwEEj+pUvdKrjNfTppI007/Z1fFqb5gJZkVHfzGOcKM+td6LPZqIU562s0IenLNyur0IqI57X3/Sd/5sLLtcUN43bDW/wPRF9LURvE8qIGDF0YqmOBxQkMpdDllDdCpeF02/Y3mCf3Zy53QtbdNzZUlzb5McT+qlPxac9RIInaT2XX2BErbH7Xkr8/pUSV26wU6irFXFA2l8xt+JN1mt5nSA/l9+o0MS3Ly5UrFmMLx/tpVRWihEI1ee6Yde4i1r+E3t7D8yFhdQAV
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170907b9c400b00a3d669a2055sm88651ejc.88.2024.02.14.03.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:57:16 -0800 (PST)
Message-ID: <513dfb69-aea1-4848-8755-613e03c65843@linaro.org>
Date: Wed, 14 Feb 2024 12:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Allow 'required-opps'
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-2-johan+linaro@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212165043.26961-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 17:50, Johan Hovold wrote:
> Some Qualcomm SoCs require a minimum performance level for the power
> domain so add 'required-opps' to the binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a93ab3b54066..5eda4e72f681 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -123,6 +123,9 @@ properties:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
>  
> +  required-opps:
> +    maxItems: 1
> +

Just letting know that this might conflict with:
https://lore.kernel.org/all/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/

(I would be happy if my series got applied, so people can base their
worn easily on it)

Best regards,
Krzysztof


