Return-Path: <linux-pci+bounces-16142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4B9BF0DE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35181F2312A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B9202645;
	Wed,  6 Nov 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfglnlle"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5110201244
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904980; cv=none; b=cmD7IVLW+q9ZReTbw5NZlKZxW8HvFqXclblw1uQZl/9vLvKuckn615KOKmmbY23PFQQ28llLcEvyKcyiNjnbOBD+KTcBX2bgjNZI0Dpg4o16JK9jIIifof8DdMGLqdJpOZLt7mwG987HSKIWro9RTmye60ViMLLpWcOHUPypPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904980; c=relaxed/simple;
	bh=N1t/qbvVe3iNx/AQhBmmHd7vwZLoBYrMmHYR1uGpW1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcx/RRtoKs7aPAYWCA2XGkFqm0Dj+F8B2dSWgFqtxnBkJtAfeGkESvNSkZvU3CvWTTE5EwAt8mI/JGNxWQ9Eesy/rTRTsZwje2nLjvtgAdq4PfTB2h6GizNk2ABoQnCA9Gue9jhTELCKn7XFbKYE4pIDgduUneME1ldwR7vc+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rfglnlle; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9eb3794a04so287490866b.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2024 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730904977; x=1731509777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P5mEEE/p70DY7f9/MDi5BeuY9yjfwqeElPakjASaD9I=;
        b=rfglnllehlBskjqw+vyZwjY1BH6lCeXK3HCA3ZFh+nGeiEV84sAT1Bp8SucrmSLg+v
         apXe1EFlmdNpSgtIkhJeo1SAEuVkQwagbG9Aw/7vgN3eIU+8qqHmp3XvkgE1zlgI9sXl
         xEL28O+btXH0CCmiyrXjubG7HnAD9f2FjBHngmNhP/xGet9NPul9KZKKqhje6G3lXVsV
         DemA9y9MYhPADHJVJwyigHaXK8eFnOGFq4puFS0YeYb2A+0KmH3g+Euy3y//b1GzOqJi
         mDj70/xLhb3ey3Joh+THt9ZYfT122G3sz174hWN2JI0CXjqpdSe/mo0XXHbazSoGLWNg
         caPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904977; x=1731509777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5mEEE/p70DY7f9/MDi5BeuY9yjfwqeElPakjASaD9I=;
        b=SQTGxUX4DmcgRWSE/bwcZNgg6++CLXvyeYaswFRWY2Fyan6RC2c5PqRhwVVBN3lJoJ
         avshUROzHRQP1F0wDpNmW/twDyBmrIeCQyHekxGxkOEZZ4AJg2HQvlLOM2/R2cBf+QHn
         shdyz9PJc0bAtrTSTWr4SMFGpbBSkatzJe5kizdSmLbVdJLTgKUMX1e1aBmrqYnezkkK
         2lsOByluMot+mJ320IU/Xk62IEusW/T0Vg8AeqEQucOqsBwExmydaaQ89aEaYvL1Wh6L
         fM6YU8TyG8Jvp/7qgEZeWOZ7efmG+J6nLBdmzNYqbbuPR/Ii42gEJ7VtP67b/pJfF6jJ
         l5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXW/+v1NSvF+O99/buZj7eEIYxiyaXaSQLPXYLHDQULEdesnBBLDQ1ljrJFXJG4opkDVa5QqEnE58I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhwjHu+1N0jKLYU4Uf9fSZdyOkVM7QT5ShD+TYWNnJjUImR1q
	U/guZ61G0ioa5rD3CVj2lVxD/NUyTZsyvoAVt/9GjZMga4+umS7e+s74upoPuQ==
X-Google-Smtp-Source: AGHT+IF2mme5AoATunjfyJ51+ACYUXGvT7/jIPhOqjyAwZSM4kCNZeVrElZ6fNrFHPkT8xSlbnvSkg==
X-Received: by 2002:a17:907:728e:b0:a9a:6284:91ef with SMTP id a640c23a62f3a-a9e3a57390dmr2706698766b.2.1730904977122;
        Wed, 06 Nov 2024 06:56:17 -0800 (PST)
Received: from thinkpad ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d67a6sm297658666b.60.2024.11.06.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:56:16 -0800 (PST)
Date: Wed, 6 Nov 2024 14:56:15 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sricharan R <quic_srichara@quicinc.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/4] PCI: qcom: Add support for IPQ9574
Message-ID: <20241106145615.25tc7n4zcdkp47jr@thinkpad>
References: <20240801054803.3015572-5-quic_srichara@quicinc.com>
 <20241106014024.GA1499855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106014024.GA1499855@bhelgaas>

On Tue, Nov 05, 2024 at 07:40:24PM -0600, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2024 at 11:18:03AM +0530, Sricharan R wrote:
> > From: devi priya <quic_devipriy@quicinc.com>
> > 
> > The IPQ9574 platform has four Gen3 PCIe controllers:
> > two single-lane and two dual-lane based on SNPS core 5.70a.
> > 
> > QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
> > Reuse all the members of 'ops_2_9_0'.
> 
> Wow, this is confusing.
> 
> "Based on SNPS core 5.70a", but "Synopsys IP rev is 5.80a."
> Are those supposed to match?  Or is it 5.70a of one thing but 5.80a of
> a different thing?
> 

Hmm, I'm not sure why 5.70a is mentioned here. It seems irrelevant (even if it
is the base).

> And where does ops_2_9_0 come in?  The code comment says:
> 
>   /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
>   static const struct qcom_pcie_ops ops_2_9_0 = {
> 
> which doesn't match 1.27.0 or 5.70a or 5.80a.  In fact there's nothing
> in the file that matches 1.*27.*0
> 
> Honestly, I don't really care if you have all the versions here in the
> commit log.  But if the versions *are* here, can we make them make
> sense?
> 

We name the 'ops' structure based on Qcom IP revision. And we reuse it across
the SoCs which are compatible. That's why ops_2_9_0 is used for this SoC which
has Qcom IP rev 1.27.0.

- Mani

> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> > Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> > Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > ---
> >  [V7] Rebased on top of [1] to avoid DBI/ATU mirroring. With that dropped
> >       the need for separate ops.
> >  [1] https://lore.kernel.org/linux-arm-msm/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 6976efb8e2f0..e9371f945900 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1752,6 +1752,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> >  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> > +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
> >  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> >  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> >  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

