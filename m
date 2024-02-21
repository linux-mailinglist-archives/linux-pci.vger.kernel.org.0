Return-Path: <linux-pci+bounces-3830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD685DFD7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F7BB24F53
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84A7F47A;
	Wed, 21 Feb 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY0TNFGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496747F7E9
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526129; cv=none; b=MkLjrDcWg+rszL4lcYBaC+ZQZilaugxQ8NsDjeYJshmWm1djr7oQWELl1jmpH18FCWHNXvfuDizFxCvnkCPTEM8KFI9UAgagUpzs+njnajoWugLKvV0Wyov7za4lS4HuBQ095crfez9R6ePazPlYeVqf5AvwY2j/mgg/5jkWhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526129; c=relaxed/simple;
	bh=gPjB+RDXPuCjeR4Zvji9FM6UPTN7zM11Ylf5UeRzCcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrUZT60e93TfK8D7JvuKrcDdjyyJqxJXIcbc7tiOY+eHlrjQ7UdrynFRohVz+O8z6erpuR/71eIswBFX0qugkm5zg7H9nMnXOGrFkTdh6WOM/zp/hgZL7souW/JxwcoSIogkSYGTKlZEy3win8UAgMq/8SsZ9vnUKh1gJyblFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FY0TNFGD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so964097866b.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 06:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526125; x=1709130925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mpg5rDXxuNVjHnT61EDD12HqwJ64u9R7UWEbZkDSa4=;
        b=FY0TNFGDlkpth+5cNVJnchAN8VkiR+qQgg9RsGg2IsgSP27kajfw6nfW2Pzj3rjB0D
         Pu5S2IzSWFxYBS59Ir3tgLDsvXZNFK1v0UmIUBpydOE5jJpHKezI0zgOXagScPEOh4Qd
         A5LxgIQXUjpnxof/GDxxeHCDKnzzfE1AOIosIHhD65qAEgCzulY/mBSObdi5Pjt7SMvT
         KAiJ46M2o+U7MM/mziGO3l03ImxgnnOC96v0Vh638LhDWnpgit897Y/DMVb9eBIQO10e
         HkkRtLcd/zJeJot5FMbDqVfgiupFiX3ByNxzXJ/n8JyC62fnyl1erHn2jplWCCg/FzdA
         9OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526125; x=1709130925;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mpg5rDXxuNVjHnT61EDD12HqwJ64u9R7UWEbZkDSa4=;
        b=k5WYdH3f0mGWjRnn414tyy9a68lHd5pC1nDMFCqflM8oo6ppoJ+/R6oj7YGfBFpMJn
         A2IF6zA1P9ZDhPzRC5a7GP5k4RdTVomro+OgQrR2U1wOJmtwG6HdUHqJpTFh+M1cVRUJ
         ADRAoTA4r9029VCoEI95heM2k66wcjN1tDzN+ERI5KatXJ0Twntn3qXA0U3PxpF05wB9
         E4L+aSkUBlabLs231FzGSc8ntWv+pu9RUvjw1wLRONwcjw4ebJSbc7UtDxlvh1XVB3ku
         dpqE7Nj6NxiMp4lNdiKoGiC2WqW8xP6zdKHA5mVg5RNGIMD8x0iBIMRjrRmLgYXbnGet
         U99w==
X-Forwarded-Encrypted: i=1; AJvYcCWxh1nVTy1NpALJq9vRfsFONSCkPU6LhRB0DY26IA3i0NIqpATuX8x675fdcss71XPpAVoL8VkaOywVNd3qald4QgrVIjUQMuKx
X-Gm-Message-State: AOJu0Yw0KOjFzZypa29pUo/Q8NfG634AYhVO0HIrZD6B9QpOEkR1vq+H
	VssoR+LtwrjLXlQ4Fw/qurvxQGWTQGifnIK/CdJM9uRriYzcAsVWnDD1LTNQDFQ=
X-Google-Smtp-Source: AGHT+IHXMK0h0j9dsKRzwpwiFDkKo9PkzVZ9sjf4SvXUXo3bUsXYCp/6Yo40Ync+24Jh+8KcvouF6Q==
X-Received: by 2002:a17:906:565a:b0:a3f:1139:5a6b with SMTP id v26-20020a170906565a00b00a3f11395a6bmr4301459ejr.32.1708526125697;
        Wed, 21 Feb 2024 06:35:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4977610ejc.69.2024.02.21.06.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:35:25 -0800 (PST)
Message-ID: <6bfc66bb-a706-4881-bcbf-57ca7ebc300b@linaro.org>
Date: Wed, 21 Feb 2024 15:35:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Content-Language: en-US
To: root <root@hu-msarkar-hyd.qualcomm.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, jingoohan1@gmail.com,
 gustavo.pimentel@synopsys.com, konrad.dybcio@linaro.org,
 manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
 quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
 Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 15:04, root wrote:
> From: Nitesh Gupta <nitegupt@quicinc.com>
> 
> Synopsys Controllers provide capabilities to detect various controller
> level errors. These can range from controller interface error to random
> PCIe configuration errors. This patch intends to add support to detect
> these errors and report it to userspace entity via sysfs, which can take
> appropriate actions to mitigate the errors.
> 

...

> +
>  static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -1496,6 +1829,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->global_irq = platform_get_irq_byname(pdev, "global");
> +	if (pcie->global_irq < 0) {
> +		ret = pcie->global_irq;
> +		goto err_pm_runtime_put;

How does this work with old DTS and with all other platforms? Was it tested?

Best regards,
Krzysztof


