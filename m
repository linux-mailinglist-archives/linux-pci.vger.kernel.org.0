Return-Path: <linux-pci+bounces-3013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD03847093
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BD51F2CE7C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57F15D2;
	Fri,  2 Feb 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecRXyb8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B3185B
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877891; cv=none; b=jo1h8v/RsmRjm3g7n+KPGpTwiu60LDoznkMy8+iLVClJyfeUF/Q/p8cPIhkyInHH8FWjle3p5VRhZ7/JUCmWTRH9FQZqszeZ+4+stNGEl0huEbJiMv0vz24KbblkGmuS6t53oUdPhb3GDazPsowTlWccfDtwJaKlwsruTnNiHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877891; c=relaxed/simple;
	bh=PpBzCGG1kfdSEKS6ZVE0DfABNyS1LEwesMsku1vqKHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1yFCJ2FwPwDwV/lTIKDGYHuo1nigzS5L45b6x1go02lT1MR5z3EI+LdIOLGMz7V6TcO4kJjZEwmT4Ak2RDqcwtC4MjLD6WZhmcNchASq1LttgHL9VTrZqzxZaaYK8zzEgFMmGybUsNStuFs4RL0t6NyOYMzC1ejXuMKjfcbYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecRXyb8E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d780a392fdso17130385ad.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 04:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877889; x=1707482689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uHxgJc6SIrgskffi3vozHz8JcpTZE+U0V1Oe4eJ8Bk=;
        b=ecRXyb8E0LjsU7i9/UG5OcDpIGMYTjpMA83vmVuTsPhjm4eq5SYbMOnm8XnXrjdDu6
         yAtW+gApEJVdUXXGJ1SI2qjXJQTopQDDqNXir79SwlhstSQEE63LnBFzPJtQREr4H5TZ
         JmbPBPlZZKPGiWN0NXe7Jsiu61eQQaIGpsLTHb2h9YxW5H20dfiuUC2D286Y2oqBYFpW
         Mr4FINFqTcdEeQW2aTMtbY+MzsBnNGltJkuQmXa9Mtg7cu9Hc155HN1jf+Woro2TCU0d
         jGSJ0on/wNGoKQl702bb2RSwmk/FQ8SI7NWnEa7axCCq1YZ+Pnyx+nLy44IYdXeWdJk8
         Gz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877889; x=1707482689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uHxgJc6SIrgskffi3vozHz8JcpTZE+U0V1Oe4eJ8Bk=;
        b=g7eybUbT7nkjxiXjwknD28AyMUlspaQa10vjm4tlIZ6+eJhnNbKd2AN/mHmzNVI6M+
         2afrfShaa1zu78/YFNTMC0lybv6adC5p/m5HhTO/lKKwpf0bjYVxIG6GmHaHq2nMNbOK
         ifLrrLhCp5U2CUf7+/C1ILU24JS1EVEr2POF7NhslkZj6QJ1Q3AZopfylhANu85x5EqW
         VuRtvudIJwng6hzREtUzYSSX7m2IqtceL9lpGvN2Tpkh+tx4InhnppWw8A9L2+PQxpAa
         XDmaI/kp1xblxj3+Fl1gHL/WsoMKJuvPjGH6uRfz9Q3lIVDvhhHXpju7b0F6q12+JVry
         uoDQ==
X-Gm-Message-State: AOJu0Yx3g3ilOnMXcfoFO8mE1mM2VGpS5jSEVRjimxeDygn45v8QZdyQ
	lbLaHk/pGwmXx62FYe/8pFtueM8X514j7P+NZeuBnFxhGiS2jti0n2XkXF0BVYxdBjsvqkLjTR0
	=
X-Google-Smtp-Source: AGHT+IH1pBIPnV4+Kw7l0S2rRr96oqEx/hAT/W7h4rSfgtu6ZverhYAVJudCiBYv3w47WdCdnYCA5A==
X-Received: by 2002:a17:902:7d85:b0:1d9:21bc:c607 with SMTP id a5-20020a1709027d8500b001d921bcc607mr4825111plm.60.1706877888773;
        Fri, 02 Feb 2024 04:44:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFWHhEo/HupTFPZosTA5Leq5aQb3CTr4YUIIlNYt5Zmj5LOJxkReBu0YLZkFkZK06LBpvBp4n7sUY6oYEWHq8EfSHOV8AO7L1Gelz7C1cCRJUNMmxosDe/90NuMbCaPH7izSpTAEEbux0hAUN63dABuenN0hV7k8Xi+/k6W/NN0tB4yq3d5qGkBMfxaevPDwXya9MftMv0/DxGGzbtkczUz9e4K66PfcukM0k6echRwsH2NmnWwqhWKDufLEc2FsbpqXimCR8YE5BDRCR55wKA1y9moEIFJ+xpHuSBYas9hHq2b+9tE9ADzDpq
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902f24a00b001d9834f2946sm42190plc.46.2024.02.02.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:44:48 -0800 (PST)
Date: Fri, 2 Feb 2024 18:14:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240202124444.GG8020@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>

On Mon, Jan 29, 2024 at 01:10:27PM +0200, Abel Vesa wrote:
> Add the compatible and the driver data for X1E80100.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 10f2d0bb86be..2a6000e457bc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
>  	{ }
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

