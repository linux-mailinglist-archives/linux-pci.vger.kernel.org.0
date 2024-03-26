Return-Path: <linux-pci+bounces-5151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21188BB8E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B7C2E2BDA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1261327ED;
	Tue, 26 Mar 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K44Vpity"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711A130AEC
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439079; cv=none; b=eDDC2jHSDU21wI0iH0KWQrZhNNEQARlfyhqALMZRxRL+oM24HRy21X4N4IiZ86ZvFaVjBnWsjle2pgZ6DAl+yphJojCM+rMz5//8Q7iikwI4jSBX516GGOI+YiljZIVOaO31bzLlHE09nSKh8NEIJt0TldpWHptsCuROvZEA5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439079; c=relaxed/simple;
	bh=MsrkW69p8rySCRtLMEt7t+ExHfkgy2bgx4K2VLJtRIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSqPDdbX1xbQuqnYbLltLTVkN5BvxEMIV08pXF0Uym5kKOqK3s0OfHIeUYgeUOPk39kYg60Dw3SeADQ6r0AOCXTrqs2Ycwss7czDxn+QmhvHP/eIBaISO7jyPD/yUAK0CgaQWQEmWlzlyigACLpgaPMRoxgAHkAbzVsApZY/Nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K44Vpity; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3939527a12.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711439077; x=1712043877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ltBMUKgzn3zhp60fMyljAq7QO/sGMekj2XSf0AJieWY=;
        b=K44Vpityl70wxDk+ib6CnDpqrxYFhnGK9av1CsMF9Ys4/iwNWdrVIi+FEhyxvce0CB
         gU9hm41RFiiUA963wzug+ypG3N2Ze6bOC1Raaxul8rWiyjM1J2EeaG/beRff2Lh8fMFH
         pmn6GVf8JKeX8kdB8Q8AEL7lKz3Ouv63hzVoKHz+7dTaH24WI13qMZCwb+3NEfN221+1
         JblUd0Gt4ZWQUIK0y1Trvniu5goKH17Up88VAPGiIaodMO3IJLVWc6zWyf2Zwj58PdXN
         DRHDOioCrIR0i6tMhz2P/tUnusQ+BUuVf4Y7zf2iV8wppt84ptibSximcUl1xjBzj8FD
         Q5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439077; x=1712043877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltBMUKgzn3zhp60fMyljAq7QO/sGMekj2XSf0AJieWY=;
        b=fT9MlbfYKgpunWIdDKqzdu8Kz98CsihGkOpB685Nfplx5WVqG8vBOEuMXljCIjDXC/
         E8yffJEgK6K6+bBBEKBLKhq4pSQEu54kcryXEWpuIAEjcskNph+GnQU1mILQ4R/81RKl
         PGeltIUGxHGPG9hIbbQcaCVQOOJPGAKgeqhv4vm9+XJkP64BsZ38ObCUrpmCToScxbGh
         /vSYv9w5zelYThY5Q4xDBZlGFnPMECLOrE/Yv2vlF4mcXszcJUudJrWcgyAl1rmWIVoW
         MyYBLuOHmEWknRqKiB+wIwlgTb/bJ8NLtGM3NTZtOHWjqNOR3lsP2OuWnJTAVqX3DNct
         3i5A==
X-Forwarded-Encrypted: i=1; AJvYcCWmamlmH+6y/fItkexBp+ptMHd75/CDksKAZk4ivVIEsTJWowWfC/eVveDfRXJEDJWlXusEzN+7t7KQQA783uIUEJnPTaoVq96I
X-Gm-Message-State: AOJu0YwupFxk7m4AbN8KJtgqcJmbuRRgWoNr/M58wFFZtYOZVIfKreay
	A8zzVren9dqrJVpzDdouljgzROryq6MFP+DPFHiKnijIRflZkaYRuG81bHpyoCNBQFeHYuJnLVU
	=
X-Google-Smtp-Source: AGHT+IFpNW25eFjP8EzgblCKW0udVOJeCu+1W8FIYLgYCGlpAIzgTkcJLGCCZzYcvI56FkcxZcDtgA==
X-Received: by 2002:a17:90a:ec0d:b0:2a0:61ca:8d8a with SMTP id l13-20020a17090aec0d00b002a061ca8d8amr1054642pjy.6.1711439077214;
        Tue, 26 Mar 2024 00:44:37 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id q67-20020a17090a17c900b0029c5ee381dfsm8460725pja.26.2024.03.26.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:44:36 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:14:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <20240326074429.GC9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2s9kTMlZncldWx@ryzen>

On Fri, Mar 22, 2024 at 05:08:22PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> > All EP specific resources are enabled during PERST# deassert. As a counter
> > operation, all resources should be disabled during PERST# assert. There is
> > no point in skipping that if the link was not enabled.
> > 
> > This will also result in enablement of the resources twice if PERST# got
> > deasserted again. So remove the check from qcom_pcie_perst_assert() and
> > disable all the resources unconditionally.
> > 
> > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 2fb8c15e7a91..50b1635e3cbb 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> >  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > -	struct device *dev = pci->dev;
> > -
> > -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> > -		dev_dbg(dev, "Link is already disabled\n");
> > -		return;
> > -	}
> >  
> >  	dw_pcie_ep_cleanup(&pci->ep);
> >  	qcom_pcie_disable_resources(pcie_ep);
> 
> Are you really sure that this is safe?
> 
> I think I remember seeing some splat in dmesg if some clks, or maybe it
> was regulators, got disabled while already being disabled.
> 
> Perhaps you could test it by simply calling:
> qcom_pcie_disable_resources();
> twice here, and see if you see and splat in dmesg.
> 

Calling the disable_resources() function twice will definitely result in the
splat. But here PERST# is level triggered, so I don't see how the EP can see
assert twice.

Am I missing something?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

