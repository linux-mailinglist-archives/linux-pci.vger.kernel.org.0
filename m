Return-Path: <linux-pci+bounces-12841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4996DE30
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0941C25CFE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402BF19F479;
	Thu,  5 Sep 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOhHkvNT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8419E7F3
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550080; cv=none; b=NsQ48wJoANaf+exibM54rVk3Nj8D+MgNQXc+IAasOKKr3j9ak0pOeq6vJowP8p+ZuhIopwAHWvFWVpoS08U4vVhGk5UiWG1iADTbEDN0f4YA45OzqUMPe1vKKKhsFtWdhlOjdEKwvakPP/nRUijZvce6kJ3AOwvkTXiDOxpsD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550080; c=relaxed/simple;
	bh=R/mNN8wdhNHSKdTLojDau3fxt+9CA9tFV0gY3K1DreQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB4cZoz4eVTet3R8NqxTIn3G0C7la4+CRECxZYx0O3ahyaSxkCo4Siu9psBUkZiouwYcGg0hjsqdc0+Yn+j38YWpCIbVzY0lr5EsY3haw5Bcc0juve11bLce9bUaVbAR6Kwc3ocd2DGtywXT6MDzW0ONdHrQikikckU29XFJ7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOhHkvNT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7178df70f28so800932b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725550077; x=1726154877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oglj13jT8NZDdkH940RV6GyfjKTBkDr1yKpmIVrAzrY=;
        b=GOhHkvNT6SR5wtOUGMYE+rSitC7vlEdF0knUA7WcjRSjNgDTGya28uXJc2SRiIlAZ9
         +tlUIL/FpAIVaGLIDQ8EpCBiAmFB+Gh1wlpshWQxFnqU6WgOljqlBsklz1Kb652kg5I4
         PvspJiZ8SAIUp4kljWARX95k3zOO/W/mstU9Z8rMFnJCh8KrEtXnfHoYDEnzYuqAbSvh
         jPGKDWGNOxfnkyHGx8+BjOXOP7YSYyUme4YoLbaDjvaYUXzoElBMLSPezOSxgScfTjlr
         SpowwybTinY/L2wXg6t33+tjldqIbsfFJwc4xEC/3qp4H43viIsLNqruOiaEdl5oO9oC
         WX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550077; x=1726154877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oglj13jT8NZDdkH940RV6GyfjKTBkDr1yKpmIVrAzrY=;
        b=bvL4/5pbt1a20hf9I4T4oo1XhaPXD3xxK4ibMkzs4IpAHufiTTj1o4Uj1yCO+X2ocs
         Kw81osAwhYoPHpJNHEJTX2g8tMwohi2etCiBe8hihvTOJ+86656CjAnN+jOs5aJtsivo
         opnreSgHXfRg9QYp+ilA06B0GLLclb38ijAWaPIA3pUwTdngAyUkUchJdE8uRmZNSEfm
         co6mAheTGkqE43pgOmq2tOS4On9zZNBiNSpTOK+oZL4m4S2+wEWRXQzBl/IyeoEkR/XQ
         Stb87N35NQ8qn7Ms4aoWJe5eUGLbmRHMOJp+Lu1vWmIbQdo7PFJ/jepWoLhfwjJBHsk9
         opKw==
X-Forwarded-Encrypted: i=1; AJvYcCUEaEJD7PSOPTPKBNFqXxSmKXKwcR5nNP1U4Ho7bHKsD7eD/70w6AfHgyXxsI3Y78UdZKFqdjn14Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLT2VaNBCNT9wxM3HGAc2FjIZEIFY9BK9fvpp6/xL3p3wjQDCg
	yhnttQlWECj/Xqwy+btD6NC5SbE47c8rOp2tdLo9/fSdlfYD8zMpN2VYQtg/7w==
X-Google-Smtp-Source: AGHT+IFlXu8G84DVRp5SNbsxFjbfXP/Dw/Xcx3dm3n7P1qn/jaVoagoGhBzzqVVH6hqorkyr3amAiw==
X-Received: by 2002:a05:6a00:4f88:b0:70d:3777:da8b with SMTP id d2e1a72fcca58-717458a9cfamr16603380b3a.25.1725550076860;
        Thu, 05 Sep 2024 08:27:56 -0700 (PDT)
Received: from thinkpad ([120.60.52.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178c66839dsm1508852b3a.15.2024.09.05.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:27:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 20:57:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <20240905152742.4llkcjvvu3klmo6j@thinkpad>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>

On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:
> On Wed, Sep 04, 2024 at 12:41:59PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> > 
> > During high data transmission rates such as 16.0 GT/s, there is an
> > increased risk of signal loss due to poor channel quality and interference.
> > This can impact receiver's ability to capture signals accurately. Hence,
> > signal compensation is achieved through appropriate lane equalization
> > settings at both transmitter and receiver. This will result in increased
> > PCIe signal strength.
> > 
> > Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > [mani: dropped the code refactoring and minor changes]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[...]

> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > new file mode 100644
> > index 000000000000..259e04b7bdf9
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +#include "pcie-designware.h"
> 
> You only need a forward declaration:
> 
> 	struct dw_pcie;
> 
> > +
> > +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> 
> Compile guard still missing.
> 

Perhaps we can just get rid of the Kconfig entry and build it by default for
both RC and EP drivers? I don't see a value in building it as a separate module.
And we may also move more common code in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

