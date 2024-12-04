Return-Path: <linux-pci+bounces-17710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63E9E4861
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32BC1880405
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A31A3AB9;
	Wed,  4 Dec 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fY5Oqv6i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01F18DF6D
	for <linux-pci@vger.kernel.org>; Wed,  4 Dec 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353300; cv=none; b=gIHUYCcnhPAV5+UIXwiwbaQht3lbqV+oNlpp9C83pw5nJa9CO3XJSyseqdjLn/3+XTB+WsuX6q8bVYbWjRRpRA0ORmSOShZATFwjxHdR1QWcQdcmdrOlSTjos1jv/IhYbE81ebqhoaT1bpZ2DZIqU7B3ox+iowLWUUBNqLXi7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353300; c=relaxed/simple;
	bh=dZvdIAAIVCb1Gn6fGg1mI/DXu0J+s56rXzMjSqtVB7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saadf89jvmt6sTdgy4yUN4Hp4r6RE5i6INzf9tAnIHb43EIrvbSl7GKO920A/JbyEwnjPc+6lJZ9rNfcUBYmfTZXDJ3qZ6Xm23uCkmnaDLo+4kOY5ghBPmdQtHuImRTgODcfmT79wi6k0sDaWb22E7czTn2+C0TjhHACReSCizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fY5Oqv6i; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso2337491fa.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2024 15:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733353296; x=1733958096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vaTYGf0bQtIjfkF3yhPnmJiZRJ8Kz7bkXSyKGXSTLE=;
        b=fY5Oqv6iVNGz5a75L+TcLjyw/m0PcoKYfX2u+3vz7J+XJEfIdxt+th9QCWAoAqe2t0
         +MAxCoS2mz0tKnEzfOL5itN7zigHBrKLJMvhtIRqDK05fp5sdWxpQAl8tMAQW/VtOohy
         ScFtWSzw+lPFQk8GIJD+OEqVLuOprqC5Aj0+XTX7fNkdRgFCg5LtGphGyOuokdk9QtON
         jd5THf5Ce5IcMC+knBDKoEWJaGGHW6L4nZFyMJrivM/oWRzMbUjtjPLQd2cLu5DEBusU
         OJoup6a7e0KNG84/wp82ODxa/t/Ro+y/HXtc1IMPx/AzFpZXdXwUA+sUBmQJsEprcs8Z
         REGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353296; x=1733958096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vaTYGf0bQtIjfkF3yhPnmJiZRJ8Kz7bkXSyKGXSTLE=;
        b=ZSfsC2rYt04V1zmFMlRLuC73NRhGAKgDXaXFDBz3yMIxWAGSOJKBDO6xkYiAIdMaSL
         swZo0Bt0yqyegkR+lHqbiIfTv1Z8W4fN4v9Fu8MOm0bY3m7YfLjYlcoLTDwV6SW/k9yj
         mLn5kub75kPohzT1+1ePWEMDjqiNQk29BVVLJIz+yn8yutYGifWGCpE6b3vxTOrA2Y7e
         UtSFSAmjt9z4/d03V+lg/KXCKIWcZTLQhn8rG1C3KG41hQVtHBP98cLh2aSLtMcxDNdD
         JnSTDsmM5j8ZrULbFVfG/1zonQw5Vc0lebnJYrU1qxxGE/khjNBKxF2WLcuOuHaFI3ar
         gT6g==
X-Forwarded-Encrypted: i=1; AJvYcCVAzcKzcy8wGhAQZPIa7DCfpZ/m7JWwEIBozb2t+KGmvcohvMXO4O1GZY0BG3ZIZ3G+EmqF2gTX7qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGpqyjM/vAfiFJ2kKekSIBIi+T0/oWN3YuEdrdqVSo3BveckS
	s2jR09LqjliQ97DVNW4JRaDYcFd1MUVivjd0GVvd9U0fCIKwoa00rhcd3EGdpiY=
X-Gm-Gg: ASbGncsqUbRVCR+VOImmyG5sSm9dlxzO4zdDISTJ0oqjh1ca/f+4teNlQ3uMiT3Wlzz
	wU1H0do/xovcQdg/NzlKky8oBtyMnRqrU6GfX/ahS6pnujdZQZqm6wqHzhBeL2fJey/h1Cz74Br
	ARehoMGVGBop3FZDfnSUi7b5XhIyep/NpWoGcCkY/3ktghWWceEOXCANkoL9jPbF1y/y+AZfp1e
	MpRuL15LyzTkLTgChDwmUMwNOnPpi9xEoMtPDkcfQ7kny/ZDteBQATrsLm9FFtXb2xRH5JhSOKa
	XMHgS7/jn1Gi5v+MlMVB2hNWQZ7+KA==
X-Google-Smtp-Source: AGHT+IFTuplv2isdxHj5cnxXRgLfLSYqhiljXH2if0rM2tCYLl4uD9OrVYwTUyo0WS8OVxU2kC/gEw==
X-Received: by 2002:a2e:bd0c:0:b0:2ff:d7e8:b71b with SMTP id 38308e7fff4ca-30009c940a7mr53718381fa.12.1733353296270;
        Wed, 04 Dec 2024 15:01:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da27f1sm124871fa.37.2024.12.04.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 15:01:34 -0800 (PST)
Date: Thu, 5 Dec 2024 01:01:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <f2yfxyuhoiavwziq3nd64mly3qdxif5abt2qp4qvrizqytqrid@fqfb22rpu6ug>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204113329.3195627-3-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:25PM +0530, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5332 SoC and the phy init sequence.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
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
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 307 ++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

