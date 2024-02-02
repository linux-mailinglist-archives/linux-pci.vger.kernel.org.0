Return-Path: <linux-pci+bounces-3000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4E846BFB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4534928720C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BA65BA5;
	Fri,  2 Feb 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foD40yoc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44D5FDC7
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866315; cv=none; b=KRJL2ROHGf1xNxejj/yf1hO4vp5Q541xKdaFDf/QjZMrX39MpsfnViXLAh+LBBtU7Ex1wDnFF7+wfThiL9DGjHQRtnb4Ww7CQ+31ujlYxD7O/ZacWyd0EGn6oREK14k0rslNuKiiY8BFLDus9x1NFuP0xQkf6tqQydOYj9LAiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866315; c=relaxed/simple;
	bh=qemFVdz8drhJlZ2QFPkmnp00qePRuil7WJFA99tBSIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8IGjPja9e8GCRQFc83PXSWXcjGXLTAMPEDmN2hGfTSsRDfoL3se/6CJ12AjIqAFb840GS7upLxHgTK/B/ZYETpLdZvN6kxOKGci+CAgloiFbJWiBEPjI8IVh+8W4kSr1XDPSjb0CjwSED3dulvNr7Wfs+2dCecIgqy3AIB0Uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foD40yoc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35e65df2d8so253063366b.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 01:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706866312; x=1707471112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoEIyCsLXaY7M3crxGURKXz5Fgd745HNqfUsmEwe3DI=;
        b=foD40yocJ1RMuM40SWqBNUe6OY51W1V72Ll2Y/y/X3fHz/Zq+MJBC8JGA5GD9rwnp9
         Sqcrkkc2D79Iq44iCNjB1ILFhfhwJUXRAuFCESvi/3hPFGX3ba16gBZ8q0bS8mPBq3PO
         DQs+kN1RbYmMU6xaUlXjsXxlHihBxJisn3ldhsYRMnHbrz3nvoOfIJ9dE/XtBbxuBrfp
         rS7fEqvWnjohQm75H3MrAPrYhi29mw8wYp0G2WsiAHVtn5apzORjxBJob7OdK8+PPi/3
         tSU10EwLldceC6rQ9T5Pb+xxOmAdjxctfah2B+uHILCwFm503PXHTzRfM+J/LBYfYQQL
         xbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866312; x=1707471112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoEIyCsLXaY7M3crxGURKXz5Fgd745HNqfUsmEwe3DI=;
        b=XiIqH7+5f2MXZuqUAr0b/U+Ez1XCM2gOMSrcxbGMn7btVq6V9Z5Sodx35Zdl+59Zs+
         owvnSyyY1JWoT7EZBf5wIt8woguFafDNCwD4b3HEXxltNNxIQmER3KpRnYZkRG+6N1U0
         LrXq4L38qOrsCulQJXVZ5eC/qBTMPEblTrV+nXwZcxCnZhIvWletumHPvHVkaAUkESoh
         EZA0yQQOPXTWCxMwzvlo7Og5jXuTCy4nRCuNJSy1vG1lKEderMdRbfhQEHrS98fwnRi/
         lFMvtMTWU9ykr1LYnGFquZlr02ou2bVjD7HPbOjIYWZKUL97XTZwSy3SoyigW+Y9Yx3a
         RkNQ==
X-Gm-Message-State: AOJu0YwQFv5dneN4T1BhoW326gYZJ0n8hxyOU+GrAhQgWvU/Q4u+8vGO
	schIptY5z07+1zMoeB/qcu7ygewcXxKdXMCLG4Cp6p9GwPh2zxNSDZByTViUABU=
X-Google-Smtp-Source: AGHT+IFpHZDB0Lm8TPIyEfnx56tN25N83gV3zu+CXiaU244TUMOytO72oVOCB5SCR2SLGLpFY0LLdA==
X-Received: by 2002:a17:906:a1d6:b0:a36:3345:be88 with SMTP id bx22-20020a170906a1d600b00a363345be88mr1140545ejb.30.1706866312409;
        Fri, 02 Feb 2024 01:31:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9V0zc+gDtDPzFvLCjzRe+iabJaGddwMMexlbprkGRefzc925muTOFNriF1N9L3/5Mf/JIkTuXJZOhm5hDDI7Dl+LLkoma5He0bVoUrUsL0LsmR5Gr1m9E7J4VlWvTx/6e1gljMB2q9eBxIks5lMa524hAGeQ5tcCGmlvndoYorD9Uz5wKMn3ErNa5KRoQlxJRbsitWIAwxU6RMRusSFW11nscwerb42R7/eglRu4Nk+bDeu1CVG9JctRqD4TftQwca4eKYnp8FrwbRuej0f+jkPtI9fWjklzNsmmRi7xP2794DQiAg2w=
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id sd25-20020a170906ce3900b00a359558648esm696796ejb.24.2024.02.02.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:31:52 -0800 (PST)
Date: Fri, 2 Feb 2024 11:31:50 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <Zby2hp2vH4TRv+xV@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <Zbyqn5wnH7yCe38P@linaro.org>
 <20240202084806.GF2961@thinkpad>
 <ZbyuANz7Jza7lzZS@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbyuANz7Jza7lzZS@linaro.org>

On 24-02-02 10:55:28, Abel Vesa wrote:
> On 24-02-02 14:18:06, Manivannan Sadhasivam wrote:
> > On Fri, Feb 02, 2024 at 10:41:03AM +0200, Abel Vesa wrote:
> > > On 24-02-01 20:20:40, Konrad Dybcio wrote:
> > > > On 29.01.2024 12:10, Abel Vesa wrote:
> > > > > Add the compatible and the driver data for X1E80100.
> > > > > 
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 10f2d0bb86be..2a6000e457bc 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > > > >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> > > > >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > > > >  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > > > > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> > > > 
> > > > I swear I'm not delaying everything related to x1 on purpose..
> > > > 
> > > 
> > > No worries.
> > > 
> > > > But..
> > > > 
> > > > Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> > > 
> > > Sure. So that means this would be fallback compatible for all the following platforms:
> > > 
> > > - sa8540p
> > > - sa8775p
> > > - sc7280
> > > - sc8180x
> > > - sc8280xp
> > > - sdx55
> > > - sm8150
> > > - sm8250
> > > - sm8350
> > > - sm8450-pcie0
> > > - sm8450-pcie1
> > > - sm8550
> > > - x1e80100
> > > 
> > > Will prepare a patchset.
> > > 
> > 
> > NO. Fallback should be based on the base SoC for this platform.
> 
> Right, so since the SM8250 is the one that has the core version 1.9.0,
> should we just the sm8550 compatible as fallback for all other ones.
> 
> Yes, I know that there is SM8150, which has core version 1.5.0, but it
> is still 1.9.0 compatible.
> 
> Or maybe we should rename the config to 1_5_0 and have the sm8150
> compatible as fallback for all these platforms.
> 

Actually no, that's a bad idea. I would break DT backwards compatibility.

I'll just drop the compatible from driver and add fallback in DT for
X1E80100.

> > 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

