Return-Path: <linux-pci+bounces-15028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358139AB47D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21E5B22E5B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717C1BD00D;
	Tue, 22 Oct 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrxGbdTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DA1BC067
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616157; cv=none; b=b8G7eqxnU61BF/52ZsE4cloNP1vc9IeVoCMADhQ4Kbxt+/3ATplqmIOG+z8h11SR/TuOEoRz+UkWjkitWHxhD9C8S2chwIOM5qGXXXO+/8xF60z+re2kCq/d+7Tw6unYPJ9WJ3Q3X7hY42j9LGTr1i5Mqr22wl+quuFXUqbeKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616157; c=relaxed/simple;
	bh=8PsFgcVh66Lr0J3dPKY3GShM1TAUBn3LVhw/87ZVtJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+VYUbZ7Ep29VMKhczAs/YzAM01bsAc96InlSArfgMw3tT5HBL2eqSDB5u/jXXvumKAGD/msekXgkYX5hqqMu9lZ0Lfw20ZJm77Q8gyAev3W5+X3FkOWKXssteQydIOIIG4eB4+Ta610j0tYQ7Ydzx59xOc+T7LHQxOiOaQBslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrxGbdTk; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-287b8444ff3so2387972fac.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729616154; x=1730220954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zskhD/XRFsF8+SNavxZpLN+TdPJ3gjMLO/S0bb2gB5s=;
        b=ZrxGbdTkRj1mcwi1Pg2jvX4nNWnfLkg2ThMfE4uxV+pajmcuBn58lldCmKud8rDH2G
         BASJ06sabhM1h6jk86viDmnGJTueeK+pTBT5//BF4n7Y/plQCMRQwXNx72fv70xRR9/b
         Z2VxhqkYZZ9ysk16t4DAmv5WNSTT2mdSNB/N8HxU1pb/zod+kSeGvA9NwLGahpiJxJfY
         iGzB23ErbhNtO6YdvOeWTiT6+9Alr34tYw+MmS3wvacias6HRLS+eKOaaDT21zZCCWxX
         xxvkro51+fiLUQJtdkQCfZOdrYnsioh/ecALNAM5x0RMFhwMN8h0ss2LjD8n8p/vFGz2
         pTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616154; x=1730220954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zskhD/XRFsF8+SNavxZpLN+TdPJ3gjMLO/S0bb2gB5s=;
        b=GO96/wKFeW0HoVk+n4JcrnNPAhr49u1F18G9DX8UvG6AhkH/VUFoxFua2oaIU6amfS
         mvs1cPiaIwfPLhnc0rWrC8m5pYp9hjVuvpXSFG4Pbxn9ApBRnd27SvjM5qzh0fPsNxud
         j55coJWrz6LgM5nM9N/Sjkkjqt5jQvlA0EAW7f97qT/BzrGalqroS1EP9ISx5Kks3hVP
         iugsRyK9RHeGu3AJGqGe+zZ0VAUwCwrtQOqQORGU0XS8sak83iFgS4TPMXs6Paabdz9+
         WxO0Fnq6fVSBJziILDcSTkExdWF5nJINL3KZYhUdpJkZ6vL/YMsNO3Ulk3ATAbblHa95
         ZGRw==
X-Forwarded-Encrypted: i=1; AJvYcCUgZ3x92tfjDdLi73t0+P7Xxw6NXnW7EXJXAe1QhNTDzOL7RLyVmsqwuu8g2B7ET3deUztDrXzpAEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnTCarIxZCrBLGtCNQHqa5gupEVdoDuAgnWA8nPcf3I2Wdei/
	PAwNRVM2pdlYMxMZ+gHG7M/oFN7xnibpGoqDn+Jp5ee5nsRW5kO4iPIUZcAAQg==
X-Google-Smtp-Source: AGHT+IFKRfaJmVMFGvKwHBrjJenW7+/BJEzp7GEOtf7Mc+QC+1nScED+0joTknXDkn7LCJudmbfjfg==
X-Received: by 2002:a05:6871:b11:b0:270:1fc6:18 with SMTP id 586e51a60fabf-28cafeb6995mr3491513fac.3.1729616154369;
        Tue, 22 Oct 2024 09:55:54 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ed9957ba9csm424994a12.82.2024.10.22.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:55:53 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:25:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kw@linux.com, bhelgaas@google.com, lpieralisi@kernel.org,
	frank.li@nxp.com, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 4/9] PCI: imx6: Correct controller_id generation logic
 for i.MX7D
Message-ID: <20241022165548.6qhxt7dsd7m7i2tv@thinkpad>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-5-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1728981213-8771-5-git-send-email-hongxing.zhu@nxp.com>

On Tue, Oct 15, 2024 at 04:33:28PM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result. Fix by
> removing IMX7D from the switch case branch.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2ae6fa4b5d32..ca8714c625fe 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1338,7 +1338,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)

This is just *wrong*. You cannot hardcode the MMIO address in the driver. Even
though this code is old, you should fix it instead of building on top of it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

