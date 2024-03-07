Return-Path: <linux-pci+bounces-4597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EF874D42
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 12:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C6C1F24F31
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B7128834;
	Thu,  7 Mar 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp0rPK08"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF52128811
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810403; cv=none; b=E82rNx3zrqlILsWaiWFFMErEw08FGQl0bUmHVPIMPKHYS7xGRXUkSPfemXLdCpnnQVBxQJhl09/xO7/e9eM4oaE0iPlRrjUDDj6b7KUbDerm+cOZdBNis43wdA8uAWTr1QO+NvgH6UluBMKl6Q2oe0M5wk/g1pxZr/CgybxLoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810403; c=relaxed/simple;
	bh=DfswE7HJLLqy77GWnPiVArfI05VtoLAEZZ8wtl2bLVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+/Us344DHp+yim4vMcCQypJu+aHQ6p6DZaPDUcTTJBaCk7wo0BnTFl1Mpt0t/G7Pmmjp60T8aQwlNRuja3lWs7obMNGoAx3zC2AyEk7nfWW3Fq3HA6Z7pDwBL6+Zos4F+XQ9eHNjuMImQupDosO5CHbBLer1LWlAtzU616agng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qp0rPK08; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d4141c4438so2289581fa.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Mar 2024 03:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709810400; x=1710415200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTSBVVVJ5YriwXW83Xu49WC7Hj5VHh4fFgiqujVWr9o=;
        b=Qp0rPK08swaXH27iS0DcRBQgAvckoR8HEpAoYS75USBCO417zqthTf/8gr09pzXI4p
         uAxVuczpD7demMAmO9HaWD0yfB8mJ4HqDtDv3vGdDFZSTlJ3OzpH7EzAQR95wlpbM9oR
         d4fLEFmDr1WWv7KDbD8S9gjCAQhFG6nrhA3ekE/8txkEPblhd8mY/SphVCwirZ1kgBXi
         s03TsrU4L9ByfepDDzgQb0Eq/E4PZZ1kZF0SNcVRvuKBRN8UalR8kKLC/hYGsZlOmgSe
         RfeF9Nm3vNdxPoT+IwZj1WiO9N+cAp75bsgodOTOvBEWSjmDky+HmXMJcFo7LoKO2XrR
         4irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810400; x=1710415200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTSBVVVJ5YriwXW83Xu49WC7Hj5VHh4fFgiqujVWr9o=;
        b=sljDCF1Tbe8Mm1iEoekmsQLTY9DS3ByUFoETBocXzOkGH1CNlHT5mj/OuiFHVgKXLY
         eJ/Eqadkn9lxL8wCPuS3d71bJrXrB9mE2bd/GMCry60kBEmn8GHugFOOMqAbv9mY9SGs
         Llr4lXJXNnwuGK8mlGOCq6Wy2Wx/u7Ohr+0xqojvHyQVDgTekQaVPi6YWXt+fK37a9fB
         rFvLjGygQdTuRHVh5j0zJ1ebVx29CIPUqTMWB8lVIYfGOS0pokJHkjmrAyhHhFle3kHC
         efuHhRia9e757SMAD547tuqf3BL3LujPeZAmN4Sms0yGYj4wUTghAScXO1H2VtZxcEL+
         2LNA==
X-Gm-Message-State: AOJu0YxTxfCT+d1B7T/q4bRO1XkowjPr+XyKOZpix1agS2/mBz4gDtlD
	TtFaJfjcU2E2IZZ7ZC9/W1Bk1wtSPzIUQGtJuz/FpBOPAKetSBAmhv8mxaIbzM4=
X-Google-Smtp-Source: AGHT+IEJFP45iEkqRIJfjQVGnd9vf8NSboPCjm6h35YrqWvxgwSyal1JJf1HtYzDNDxj06EzP2Td4A==
X-Received: by 2002:a2e:6804:0:b0:2d4:5f4:dee with SMTP id c4-20020a2e6804000000b002d405f40deemr1190422lja.18.1709810400006;
        Thu, 07 Mar 2024 03:20:00 -0800 (PST)
Received: from [172.30.204.36] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s6-20020a2e9c06000000b002d38f36f3a4sm2003570lji.117.2024.03.07.03.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:19:59 -0800 (PST)
Message-ID: <afc709b5-4e4e-4308-a399-e0b521592250@linaro.org>
Date: Thu, 7 Mar 2024 12:19:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Enable BDF to SID translation properly
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/24 12:05, Manivannan Sadhasivam wrote:
> Qcom SoCs making use of ARM SMMU require BDF to SID translation table in
> the driver to properly map the SID for the PCIe devices based on their BDF
> identifier. This is currently achieved with the help of
> qcom_pcie_config_sid_1_9_0() function for SoCs supporting the 1_9_0 config.
> 
> But With newer Qcom SoCs starting from SM8450, BDF to SID translation is
> set to bypass mode by default in hardware. Due to this, the translation
> table that is set in the qcom_pcie_config_sid_1_9_0() is essentially
> unused and the default SID is used for all endpoints in SoCs starting from
> SM8450.
> 
> This is a security concern and also warrants swapping the DeviceID in DT
> while using the GIC ITS to handle MSIs from endpoints. The swapping is
> currently done like below in DT when using GIC ITS:
> 
> 			/*
> 			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> 			 * Hence, the IDs are swapped.
> 			 */
> 			msi-map = <0x0 &gic_its 0x5981 0x1>,
> 				  <0x100 &gic_its 0x5980 0x1>;
> 
> Here, swapping of the DeviceIDs ensure that the endpoint with BDF (1:0.0)
> gets the DeviceID 0x5980 which is associated with the default SID as per
> the iommu mapping in DT. So MSIs were delivered with IDs swapped so far.
> But this also means the Root Port (0:0.0) won't receive any MSIs (for PME,
> AER etc...)
> 
> So let's fix these issues by clearing the BDF to SID bypass mode for all
> SoCs making use of the 1_9_0 config. This allows the PCIe devices to use
> the correct SID, thus avoiding the DeviceID swapping hack in DT and also
> achieving the isolation between devices.
> 
> Cc:  <stable@vger.kernel.org> # 5.11
> Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Looks sensible..

Does switching away from bypass show any performance degradation?

Konrad

