Return-Path: <linux-pci+bounces-21897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252DEA3D74D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DB63ACFD5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0C1F1509;
	Thu, 20 Feb 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsHTUefo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A81D8A0B
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048625; cv=none; b=suGrIZny3/mIWJcttKVcTUJTXWm3ZEKUOy0CYcCyqBMRi6jnlWlWUsUpW2ddnwUigz3e74s9MungNmprbym/7EI2gJ29iBgQ5kD1ivQJV43M/iE+yG2z7CibgdLf96Tot/8E72GA2gXbCdrGN/a7scnoQHuJhunPh0uUolMSjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048625; c=relaxed/simple;
	bh=gq1nLSZGIi0615Ppw9bMjMKUijD8x1x5ap4YkeYVRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmbNP9qHf7BUD+oUDxiDdRPCtnDf5/1CIuUWBKrDsce5PJEuV59tan9dkBM8UH5sTGkoMsMZrIK6DohTcxuxWvvwK7qXIZGfK/t7gxpZnLozXOuR21xI83AoDxLyhITu4jdMqosz72xBtHPZW3a/l950JSucBOL4mJIPb/b6Dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CsHTUefo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so7730171fa.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740048621; x=1740653421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/oubRry3os2Cx+3hy0pjXTxP8tcsJBQmGx+p/CdbBs=;
        b=CsHTUefoji4ibbT5fvQiMxzKZ5qjy7kfY8wcvNOwVOBiqPJZVtKlSe7M1p+fAdOlJe
         6u5FJI9ayz27r+DEfk0oVuX5+9+9TEfZJym+GlnPoA7R2UlXG/XtwNHA+PAwYODZAQzf
         kkUDxRZyZT8Er+xzpSPC/oFH5hK8GsCrYjTftzjdZqJ/nWu1hkdjEllgDH4DXsZh7Ytc
         8tlRUGU1FGibPFAmtHpOiadx5s0EWLlgEiXOYJp70J0IQv7smK/Ey3vxz0y7JH0hjyHO
         k+08MU7agmUGJdg3+WhFd+tCHHsn9lFXlaJQK0EZXt8TsigWYYURnbC35zQ5jZUGZzle
         w2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048621; x=1740653421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/oubRry3os2Cx+3hy0pjXTxP8tcsJBQmGx+p/CdbBs=;
        b=G0qNAMYHTJjM33qa52kUoT5W9Yvy/Vcx3Fr3gITpT7Aqrgcv5wG8GNfmvDAKXExNmH
         uFexcuIE2fetx7BrNMC96UKfG54ToopdIf3qHfn/L/CRBsGGmA9+aSea2SE6u/WQZl+f
         IeyHBvOQI71m19klpOYTnpvS3/0OQ//1lDi6NWo6WF/RkDlS9Hj9rMaYSiiFxtaEs0DI
         sB3I0Xbvq1xw5kXFuic/ExwX1Hn0+AJk2DVPZa8wLNIxFxUR28DHdaIg/MgSkLMBREFu
         q8PG6LLHGUZK3km4uWg7OLnGEP8EEeYCbJy4f6tWVZHIpSTla6BIRSpbToYphIOFyYR/
         Xjkg==
X-Forwarded-Encrypted: i=1; AJvYcCXdMhF3SvuVZvLVuD9rEIR4hboMO4iOSZnpN+vG9Imw6qj0k/G/Sm+qeUGbMbD4UymSiEyVVczRt4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5KRqyQQpzEqZT+sXm9r/u44trYPxyyBcrEauri+T6btltmA6
	AxRcSev0+ugrHqihZHcLsNM/bMd0NqNeqA2yKZed7jwWCzkxQJpguNW2k9gV3VU=
X-Gm-Gg: ASbGnctzfXotnWsQNzRSpffsX4b5cSQsORNFPH1XqQdcQZeil3gxVIZJ7PBtMB7PS+K
	L+fCBXyyRXUKAwbP0lRBwr1oPJPOfHRFRKglEDaqog9EXJUDdSZhl7QT+sT5hW1QDtNTYplbSOQ
	WEqV2bEogWq0sBnWLLGXoc6fA2g9/eF/8bryvM2Oa6BygQvCI5t4pNGPFdscgtAFy86mf1Rg14l
	QkQ5ZD5XsUdHxV8FSQqj1MHBbWt7DpwKjU2mnS+25vtuTPf/PD/twoqdwdEPuBpGZ9z+Qs5VNHJ
	tViu0+MqrUeAMAqEcjNUua9n3Wi64hz5easAFvOm1DQRkpKXoC6nyd7gxozxwrRGMypivBQ=
X-Google-Smtp-Source: AGHT+IGDyF728+k8BN/ocAWv5ZgL+M3ykKw/NVBvij0H7cvdwKQpUwgrrE9HiQyWU0qxZo5WaL519g==
X-Received: by 2002:a2e:88c2:0:b0:309:269e:3ac7 with SMTP id 38308e7fff4ca-30927a71936mr62101081fa.11.1740048620618;
        Thu, 20 Feb 2025 02:50:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2c6f5ba0sm14386401fa.46.2025.02.20.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:50:19 -0800 (PST)
Date: Thu, 20 Feb 2025 12:50:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Message-ID: <wa4vr63eiaiqq54aauxviwph2wbosrmfypxpxtw7w32la6qz7q@flhdoc4k3d6e>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-4-94b20ec70a14@linaro.org>
 <20250220072310.kahf4w4u43slbwke@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220072310.kahf4w4u43slbwke@thinkpad>

On Thu, Feb 20, 2025 at 12:53:10PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 17, 2025 at 08:56:16PM +0200, Dmitry Baryshkov wrote:
> > Enable PCIe endpoint support for the Qualcomm SAR2130P platform.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
> >  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
> >  	{ .compatible = "qcom,sdx55-pcie-ep", },
> >  	{ .compatible = "qcom,sm8450-pcie-ep", },
> > +	{ .compatible = "qcom,sar2130p-pcie-ep", },
> 
> Could you please use a fallback? I'd prefer to not add compatible to the driver
> unless it requires special config.

This is a tough question, I have been thinking about it too. But granted
the differences in clocks used by the controller I opted to use
different compat strings without a fallback. I think it would be hard to
describe the schema otherwise.

-- 
With best wishes
Dmitry

