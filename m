Return-Path: <linux-pci+bounces-39765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D0C1F072
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638414E88AA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4070A3358B4;
	Thu, 30 Oct 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+pdfWjx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475753385AC
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813676; cv=none; b=Di6Bus4xM1Y+DasyJ7Gb00pUGTFthKm8XBiFaNAS13mcNHX6wuNVZ7Jg7j9ZCwSTVUvGWUxapcmrVgLl1bjXtf1/w94WEjU1rIkQRiADPHVUMWL/xF9icTJtCEUQNhSnWdRgGX4W3NzCD2PQUBWWblKHgkB3o2Xq8wyJYILVsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813676; c=relaxed/simple;
	bh=qCbGc/l+3FhemavilMQS0FZJGW57bn0dkTOragoXTKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ6csLDjKfbE2oQbxNlW761axQNmANEwYSeESZCl8o5rR8IpnCsG0PS4siQIj1ZCXw2IPG6NEvsZjfHeMRfK0O0GL2wMk6b+h3Bi6kEVLMRShGF6HCRzIV1G4jKB0f/1v9hsh7fPmfg1T0kO70+uGaV7hkNo6IHgpZWQb0FR4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+pdfWjx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4770aadd7e6so132485e9.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761813672; x=1762418472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OOGbShnIiwYlkWUZPH8sZKIlbUAvtck7T0etBTHqYqY=;
        b=Z+pdfWjxzHRezzwhd0eoNYEq19i4sBR7Ht1ibI/PV/pw8w/p1rekZ5qVK61FLaRyVP
         crVhkeY8Bk5L9l/iV5A5JaWsSEs8ec7RuXTve3BospFVq63cSXDwp9cV7UWLUX1VISa0
         DJM63EEBaCAyv9jLtXrCO4Dy4ibtxntf8+BuM15n2hAfDwvIdtEMpC4/goYNtZg0R/Nm
         0JavSDBWqFZrdsJ3stznTFRzW52p1IP0BeNgLRk+3pjtx+4QMMEqnqUMU8DnzII2GAaR
         gF/wUii9YluCkLXnGodegVdumkcszRFJyevm7Pz/Xp+/C/HWvOjF6s/qNajgV7/nZ7OS
         x/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813672; x=1762418472;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOGbShnIiwYlkWUZPH8sZKIlbUAvtck7T0etBTHqYqY=;
        b=KM5yNHZzAGUEJX7C2AA2Q+wX/GLziWll/apwvvgemI//3b50PZkDm5QXYvTcGjGN6m
         ZovJVrsQ8ttmWujmdKWGTuYgca9hFfuEC6v6g5ZKrfU8Pp6h0zLkBW7PtoWfnVofhyfs
         QVy/9oZKstwpnZSF+4xFFdsjuY63IyBxsJ71Zju7B3VjYKCJvz2GAvTDdfcIKOiUfP1J
         Pz1B+T6MQo0RlC52rlZofTOA5wfW6VntiEXaUwkmuZxn2LoFVOqwqa6jlmQV4imP+WVk
         uiTCCiHYCiUYm5xgUOZmgP6SQ/gbSCX1rCTtEoNArh/2FAwiQ1gRPh0D/83i2se0ze85
         7GDg==
X-Forwarded-Encrypted: i=1; AJvYcCWM+emmx6pwUkZ52ZuzS6ZqDLynyRq5A5g8IqH1eg6uG0PHPnxhV8YC14xa1ljvLfPnpqZ86nn/hyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHkfIJR9lc4k1fDcA0dLWXrhdrIl16SOTnHOHK8mqAmj4qZPT
	lvLC8mhnV3ptWcqMNIaGxpFkXudGMn0d4hBN45KAR7BEdjXvbDi/O3E34UFJGHPOKko=
X-Gm-Gg: ASbGncsvZ3/ixrXDHhqVj5YAp06bVL9nBqaWiEQPt9rALY8ynhOUYxkdogSZR9wjCnU
	u17cGyl+5/lUpefbHaeUtnuTCKQiwoz3AdVOSxQDf70Qg2LLkLpk/EKMU8jGojtSCNpRj8Hj3oM
	SXhgOqwIq4xt5J8zeFdT9SXG3Y5A4U+t4HKzBgGumjQwKSCA1XWfBO00Eh97i4kKshbmTEGpLWx
	4qinOsqTnxGJ1ePVxXI32ENkixkooyvFRiGQzA4UXYuqI9cuOvUcT8llKzgmov1AL9lsW12+EjJ
	TOVCgqLkq9Pnm+CQWuSKv88WeiF21jiE7kkmbD0GR6PTklHMpNQG6mEjg1mlIr4vYigNaiG3UG5
	JFsaEMWq/lRW5rjZPX+cMsfRPnImKxesCrLWvfybH/9FGu63QRMFRN88mETP5r/RodOxM1fGHFd
	uJeCcTH7P9zg1QgCuMDY/3
X-Google-Smtp-Source: AGHT+IHCmttZ5bkh2jgtncYZnDJhzGb9sNwgFWQ0B/wyy2+IgScbjudgRWnWpECFGRuLQW4JMZgS/g==
X-Received: by 2002:a05:600c:3b29:b0:475:dd59:d8ce with SMTP id 5b1f17b1804b1-4771e11b873mr30240075e9.0.1761813672464;
        Thu, 30 Oct 2025 01:41:12 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289b396dsm26629055e9.11.2025.10.30.01.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:41:11 -0700 (PDT)
Message-ID: <ca90fd36-8b2c-4b91-9844-fe577c4ec227@linaro.org>
Date: Thu, 30 Oct 2025 09:41:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: PCI: qcom,pcie-sa8775p: Add missing
 required power-domains
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-1-da7ac2c477f4@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-1-da7ac2c477f4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 16:40, Krzysztof Kozlowski wrote:
> Commit 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p
> to dedicated schema") move the device schema to separate file, but it
> missed a "if:not:...then:" clause in the original binding which was
> requiring power-domains for this particular chip.
> 
> Fixes: 544e8f96efc0 ("dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index 19afe2a03409..f3c54226a19d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -78,6 +78,7 @@ properties:
>  required:
>    - interconnects
>    - interconnect-names
> +  - power-domains


I am going through more of the bindings and I noticed now that "resets"
also were within "if:not:" and they should be required here too.

All patchses will be fixed in v2.

Best regards,
Krzysztof

