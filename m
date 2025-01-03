Return-Path: <linux-pci+bounces-19195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F19A003C1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E513A37DA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09918195B33;
	Fri,  3 Jan 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYFrsgof"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB7256E
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735883297; cv=none; b=MaMWUM+t7hPITwEfAdw4iTgoCwsjRiFlyL7d5UgHH5NsLgd9h3XH8UPqBqXAsn2zPXRrgN/loAzz94fa3gieV1H9lpMFr/EnSryGPogkjwqfcRcNcPA0JAfr9qBYAD5W8H8j8BCKgiXmEO/CaUDiRpiwu1KMmOS7gr/acpW3wBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735883297; c=relaxed/simple;
	bh=7nUe2OkzUCn6Ugrf3Pcn3prZAxmcgnzVHbxhArx5Dpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQbhLL+uUV64zv969pOuuvTuFl5hmqaEzlVj3GJtPEc1zq/wGSmOESiz261vokDrf0ziVEkrqxaSC5OXnk7iMl8mP8NidsTGEvvRmNoFE93x41HjuHh2sIjzszYy4DgJQvDXc7aCZxzLOsma41B/YHfYjPrrzm345YMClLCUqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYFrsgof; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3c47434eso12600467e87.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 21:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735883293; x=1736488093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITZIP+H7SQpVXzPPPttp6DmGDQKxV65KZQOmqyrSyow=;
        b=JYFrsgofYGKKDAEnVVLHimI9nUYr/e949+RiqYiYjFs/NnKIR68H54mSHSi7SgHbnD
         R5tH3uUCWXt+bRTYE0uzEEL5LiUpbnAXb35azvi5kXvtMCXYsKcLpy+t+/2cwYkieQTd
         FzODrVfuyJtvNP7AuyuQGT886q9RgBPV6iJNbkOgGtKYx+ovyjHu4at/o1jTh3Fr8l1w
         kNr+6CEYXPt06T3fP3OtUtvMHR/3PeG064d59+9axPk9HbtnRuy35MmWn62t9njLFHpZ
         WKMaHZUY3ETyM7pb/MOm/nHpqPmgzfrok3ySZZTvYPVi1znK5+qSMaRBvYBhhBJbthTz
         rEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735883293; x=1736488093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITZIP+H7SQpVXzPPPttp6DmGDQKxV65KZQOmqyrSyow=;
        b=ZmGbYAcdWS7zWzByaQ72HESX5zTqfR4DULrDS3KpplizEkrzA7e39FuMTisPoKlLa3
         vVyGjvwoCVQxujYJ95GnzXwh4PSGbjBrO7v7OleaVgrbRNXxwopgdA+C3t32skAc/PWM
         RKp1g+pLa14YE4tTfO3bIQtif1MWtE/gskhVkY6yeiQGgvjx34S3QUBY0TkqpcyLnLwF
         47uqE3horUdBb71KeDzVoLwazZGA9wjsDwfJjTtqDJ/bVEy5HKRRze73xQztJ3pVj6uU
         dAsFSxrQB13mP3GvQGOc8t336IU65R+o905/bShxEtGlJrr2iNwC83WNDGcqfaR+QiFC
         FK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsmEMaGSNyNFcMBx3WxgJqwjeuer5qKZm4SCh0NJjZr/vFVg6SVW0U2EVLHvoal6KZSN6AZeakL6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIllz3oOoqby08RZMIcl2m4gzEqcnu+mIsgq6OtpvqyLLyqrC
	k8PNoh3xXlRUnnuQUEDGVzgMoNDXd8vhunbH9RumivxqEnSf9oeuwJdHBnUjVl0=
X-Gm-Gg: ASbGncvokc6VYW6ba4kxzooSEdxLuilqWJF6QYZqwyW8434uy3cVZ/JUmSXrkmCzA/E
	hezWP9yT3dlZ2NogBALA9EANwGwV5ZAfg8XeCRsl6EbdJf3y7kzfv4xiHVELCgWGyj+t9zX/njC
	jO21n10y+46i9LUtgZwQ3Yj663wKaIBlOE1n2JFCUmRjOvxr77RzpPr+OBTwoPUqzdMo25b5DCF
	MEan2S0QIKgtwGJWzxNTn/vEqelfxCbvs20guR/zbMu+RCU9MQExIRpQ9Sz17WVGskcxKKxgUXg
	B5bBEXliRno1Rsw/4l5tZaSRLcguqiHkWqEz
X-Google-Smtp-Source: AGHT+IHPWdVWih/VxuM1kwjwebDq6JydqrCSUUMDsMiPL2UbsV7YpW8IvSEXyj1tuFAeYhK6nqPhfA==
X-Received: by 2002:a05:6512:3f0d:b0:540:358d:d9b5 with SMTP id 2adb3069b0e04-542294ae2e9mr14575418e87.0.1735883292998;
        Thu, 02 Jan 2025 21:48:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235fed7asm4005816e87.61.2025.01.02.21.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 21:48:12 -0800 (PST)
Date: Fri, 3 Jan 2025 07:48:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/5] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <nudzgkfufp74eyq3vwuf7f47u6u7xy5cpqw2ktb5vdnpwc7uyv@ar7akuo5q6gp>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102113019.1347068-3-quic_varada@quicinc.com>

On Thu, Jan 02, 2025 at 05:00:16PM +0530, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5332 SoC and the phy init sequence.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: * Use 'num-lanes' to differentiate instead of '3x1' or '3x2'
>       in compatible string
>     * Drop compatible specific init data as there is only one
>       compatible string
>     * Fix header file order
> 
> v4: Fix uppercase hex digit
>     Use phy->id for pipe clock source
> 
> v3: Added 'Reviewed-by: Dmitry Baryshkov' and made following updates
>     s/unsigned int/u32/g
>     Fix 'lane_offset' comments
>     Fix #define tab -> space
>     Fix mixed case hex numbers
>     Fix licensing & owner
>     Change for-loop pointer to use [] instead of ->
>     Use 'less than max' instead of 'not equal to max' in termination condition
>     Smatch and Coccinelle passed
> 
> v2: Drop IPQ5018 related code and data
>     Use uniform prefix for struct names
>     Place "}, {", on the same line
>     In qcom_uniphy_pcie_init(), use for-loop instead of while
>     Swap reset and clock disable order in qcom_uniphy_pcie_power_off
>     Add reset assert to qcom_uniphy_pcie_power_on's error path
>     Use macros for usleep duration
>     Inlined qcom_uniphy_pcie_get_resources & use devm_platform_get_and_ioremap_resource
>     Drop 'clock-output-names' from phy_pipe_clk_register
> ---
>  drivers/phy/qualcomm/Kconfig                  |  12 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 287 ++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> 

[...]

> +
> +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct qcom_uniphy_pcie *phy;
> +	struct phy *generic_phy;
> +	int ret;
> +
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy->dev = &pdev->dev;
> +
> +	phy->data = of_device_get_match_data(dev);
> +	if (!phy->data)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(of_node_get(dev->of_node), "num-lanes",

Who will put the reference count which you have just got?

> +				   &phy->lanes);
> +	if (ret)
> +		phy->lanes = 1;

phy->lanes = 1;
of_property_read_u32(np, "num-lanes", &phy->lanes);

> +
> +	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources: %d\n", ret);
> +
> +	generic_phy = devm_phy_create(phy->dev, NULL, &pcie_ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, phy);
> +
> +	ret = phy_pipe_clk_register(phy, generic_phy->id);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to register phy pipe clk\n");
> +
> +	phy_provider = devm_of_phy_provider_register(phy->dev,
> +						     of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_uniphy_pcie_driver = {
> +	.probe		= qcom_uniphy_pcie_probe,
> +	.driver		= {
> +		.name	= "qcom-uniphy-pcie",
> +		.of_match_table = qcom_uniphy_pcie_id_table,
> +	},
> +};
> +
> +module_platform_driver(qcom_uniphy_pcie_driver);
> +
> +MODULE_DESCRIPTION("PCIE QCOM UNIPHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

