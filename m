Return-Path: <linux-pci+bounces-2995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CD846B51
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F600290CF2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1D605DC;
	Fri,  2 Feb 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQVha+XI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC1604C1
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864134; cv=none; b=R8LtXeQp9XEtbIj3bG9ifXfq5uwyZL0NZlYHA09n/QKbxxU4HTaByJEjXDj6WWBhQo969TKU6ALrGldoo6lOeW4bIlLYVXLIw2szQmx3RAi15RCc1rxIKOIwjzQKlOW8QefsaWNhn+pMwLF48qv8jY+hqKCSb1MNLOM4fqCPbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864134; c=relaxed/simple;
	bh=k6BF/q2AUq9fet7l2bvyEg/64CUFxjGNt72Xjm2UEvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgbJWSf2Z7+f3ShK99gyCkSInYZj5uffzqd8Q4H+Ufvq67p5lljfbhoFmboplyZNcicWexiD8EEljctF/y8pWe0ubXn871jG12uNAuy2+8OPoGVCpeb7pk5MQLJ6/AORMSUlEi2zkibSiErjfZEV2RXNIi3XAw1vQCAMvse3+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQVha+XI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3604697d63so282342066b.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706864130; x=1707468930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fiin9xT95xmjaBWj39CSHW+K1rE7OpA6eoBA4kS3YI=;
        b=XQVha+XIpWelasWeO6GH/tsGHtFiHEl76r5XSXNc1tp61aLzt2rupgw3ZHDmNZx2D8
         4bVH9aSRxsWqY2IjhM4i1gIoijBlGBhg95/21IagAV0L7IRUxPvGqO9PMc0WU+UNRUrM
         W+uuA+rkLOq3BllBrw+LTBsjTCSQcUlDJeXaOtP7U3tg6bXfcsNsxeTAohXzuZx7xmYB
         FAClz8JLxXckw9DjSI8lvgkmCKzLUNaaSpJ2EVZG0vkcYbBmNMjpEbDlfha4/OVJOS97
         ic0IFBMW5RS2/i42jGjgi3eKWNRXFQ5R294qzW9jlYZFKCqNgr+sP30wuvrT2SIFERu9
         DXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864130; x=1707468930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fiin9xT95xmjaBWj39CSHW+K1rE7OpA6eoBA4kS3YI=;
        b=cONOewJ+US40LD4yvq14caqp7yYm7J6534FyEaZT9XdLce/MwVSpeQfSt314GjnXTO
         i1gdvrS44TlPbgPTdSbhmOa5XdkVhwaV2047a4hxZwR6PhUGGoGqhsNYnnC0Vnm38a5d
         Ws/vYMtQ9xBWLsuypsN/DSc+depAaOaX9nEGZNuQQwLjiCf9EvTFntDwO+F+FuVKisTN
         FJ1UJccKeT2+aq2x9GvUTlswpSDUODI20QxY3etM+MAfPJnyh054X5PEHpbzi08eUYva
         cezW4FlwcfMI0AVcUJ7SEzk03UdzqU+6wbo8oBazFVt2rC+U/z+vOwHB6FmfWPeSv0O7
         ZHqA==
X-Gm-Message-State: AOJu0YzbyzUtl/NmidjLarTvguv2thbBhqt1QVXRLLmYfiVewZMt4xRO
	1bQVJ850h0k+k3i4Eau3Qba3GZQmRX2fcXIyO5Jm20+wWchNUD4kGlTtDg2tnm4=
X-Google-Smtp-Source: AGHT+IH7WUTM7Tr4j7ap3Ccz9tzPdcldjtlakQgc7YxtH+BZ0fjWO+3Q6wdm9rI1txYNOLBjYQsLDQ==
X-Received: by 2002:a17:906:5943:b0:a34:d426:1c0a with SMTP id g3-20020a170906594300b00a34d4261c0amr4824837ejr.24.1706864130412;
        Fri, 02 Feb 2024 00:55:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtKT7tGmKSZBXztNYa5HLg/nU10SEJnDpChKo7QwnMd9ENx3wKBYBz8SnOtUgGHlzrBNBAlGE4hv64gL+IeLNYLmphZi7HpWWjwegPBWniNPjDeypYyf9eN1GLHsgMHOhckj1iO01RV5IXIE6R5/nlubOoLQ/J956fbj3vXqwYlI66ipgnYvgiDtmnQ55uXBSD0NRtn1OrMAKJGdE0sAcacyIvVwvy/crUG1Ag6v6qsfpb92ssbf5+LyL6z0f7poAEzUlT1UUj6e8XOTcu+yFk0DMnTLT1irnrS4yM90qr+LGt1rK41GM=
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906071300b00a26d20a48dasm656755ejb.125.2024.02.02.00.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:55:30 -0800 (PST)
Date: Fri, 2 Feb 2024 10:55:28 +0200
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
Message-ID: <ZbyuANz7Jza7lzZS@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <Zbyqn5wnH7yCe38P@linaro.org>
 <20240202084806.GF2961@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202084806.GF2961@thinkpad>

On 24-02-02 14:18:06, Manivannan Sadhasivam wrote:
> On Fri, Feb 02, 2024 at 10:41:03AM +0200, Abel Vesa wrote:
> > On 24-02-01 20:20:40, Konrad Dybcio wrote:
> > > On 29.01.2024 12:10, Abel Vesa wrote:
> > > > Add the compatible and the driver data for X1E80100.
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 10f2d0bb86be..2a6000e457bc 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > > >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> > > >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > > >  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > > > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> > > 
> > > I swear I'm not delaying everything related to x1 on purpose..
> > > 
> > 
> > No worries.
> > 
> > > But..
> > > 
> > > Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> > 
> > Sure. So that means this would be fallback compatible for all the following platforms:
> > 
> > - sa8540p
> > - sa8775p
> > - sc7280
> > - sc8180x
> > - sc8280xp
> > - sdx55
> > - sm8150
> > - sm8250
> > - sm8350
> > - sm8450-pcie0
> > - sm8450-pcie1
> > - sm8550
> > - x1e80100
> > 
> > Will prepare a patchset.
> > 
> 
> NO. Fallback should be based on the base SoC for this platform.

Right, so since the SM8250 is the one that has the core version 1.9.0,
should we just the sm8550 compatible as fallback for all other ones.

Yes, I know that there is SM8150, which has core version 1.5.0, but it
is still 1.9.0 compatible.

Or maybe we should rename the config to 1_5_0 and have the sm8150
compatible as fallback for all these platforms.

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

