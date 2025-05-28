Return-Path: <linux-pci+bounces-28480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F23AC6033
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 05:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B191BC20EC
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C8171C9;
	Wed, 28 May 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB129fcH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D3125DF
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403953; cv=none; b=Uxvi6EE07AmezZ0vgLBB+9Vy3e0E2sDYS4IyCO9qUnR/HErR+4FpqVaJ27bH0GZOrwWNd78iKAwdEJqowlx2WGqNTC4phBz5YafKb0B9rTv+tOlnU5oLg3vZoUgNh5NJVteSIeDvUOmF7+Hi6mCsgT3bZoNqb5LLiLpiTsYUFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403953; c=relaxed/simple;
	bh=2o4r+vpdFwfhWeVhXepgdGgFomWy9DaeAv6GCCmCYBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBtvnPOQIOjg/I9skkOA6rke0qCXJJXFcpPyspGfAANY32zR13o11xXBPXiqycV5wdcLVIKpLRe5MJZe3BwRuABGZLn5BinM5UOfDDbjz16RmlPn5XW6mcRiHwxWI6c/L2YelEm92yUINObeACyZgMfWbLhFbb1W/8gFyDmgl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UB129fcH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c27df0daso3049330b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748403951; x=1749008751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3KFHQqeIqDq9v3s/Pmw6YxABq9OfugcMVVhDILxZbGo=;
        b=UB129fcH6PBQaXny2YQHcZp1d1TheSSvGyiGuYw7jlv4w/9J7eK29349/Scunu9LXA
         3u+73hEixFDtcHwSgl8bPBgqFnd4kXOysdfr9xGe4+cFBB9tNGmyB7tQyzZQprbQOVtQ
         42QP1R/xMd06B1G+CFOxVBPjuA8SnGByxD4tzyQh70mrNSfMYp5ncHktQmlIqipoMCdB
         EnXI0T5ApbnqNQ8C4mQFBvDhWnfxdfixhJw2l/u6RQ47DRBAgdZCj94ooy1JrXy+YZUC
         3yWLMx4CSa7lGiluAx+JWtq2lQcC5AQwGCAsjtJvDjgymyUZ/320V1pyhjVETiLdR86R
         ShBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403951; x=1749008751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KFHQqeIqDq9v3s/Pmw6YxABq9OfugcMVVhDILxZbGo=;
        b=NQsrOOm7F0gfund7lKLyYCIupyBPrbk7u63NDyMs1lvfBHTjADTyWLj8LBpg+odsT2
         Zi96tIMS/Q9J12CBzRMiKXIrA+B30YnCRcoEWmSdYnZENi14upogCnsVBpwkYLhD8s2R
         ktPoPpBQomCFDfadrTfuqdrthb7LS5XI00VMr+gpfFDotWVbLVZr9/0AqYPE0VdcBGW/
         VTPnFsGGOlOzIDu+ypMQLW6k8H6Dbgv4+swLg6niDh1aTomqw7JQiAh0kGiTnVxaoz0N
         Gp+x5L1YXnmX2JJT7I/K1c1Yenff0hWvyPMjOshtzz9PUn5TLjxpuhjyGj57UIoNpQvw
         EflA==
X-Forwarded-Encrypted: i=1; AJvYcCUGNSDgFcIXz08p4PsAp9t8w5JR7ui8+BBJlV8gPZ1P1Hi3lAokqAI9AUXoBuKUq7//TKhFXp149wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzW76coCcTX46rQOFL4uQ99HQx1vVKBwpGo33hr65HUYchZ9Ja
	vk+7nSJ7m9I0e191GfIV/c/Np4/XxnUSeJHPP0vBW3dj5K9hIHDQZGgSqwQXHZSS0A==
X-Gm-Gg: ASbGnctBY0GW5uJtIWraHS6vTAaFYcb6SV+5STOGUD/TAFNrrofKwBKXrdjloN4YXQP
	RkBuyb93BNlsRsx9zWgzN52S322UrSfiTCY01nLoM7+qtKfr28vlreyAOhy8boPqoC2S/mWaLyt
	UAHTAdHp+hX+oOe2wbGYdTOH8PmvB1Nj113+YmBWvUab8GeuCOFLt+i2yQGdEAHK69kBivtWHtv
	fBtvKHh/bUgna0RyRPVN1AWsGdark5mmHxfge4fWmETO4Sem08M61nGiAbZPTt3GxQsk7ZHioAx
	3SnN8lloSoNdnb5A4tAh1ihKzXM1xl/DNE00DB7RIkaICiGUhPQKTSG7Kh67qS4=
X-Google-Smtp-Source: AGHT+IHbe1onieRUEV/bziSV0zPOP55emvuU3EW+59TrXXYbryNV3CD3qqBiU1MGsi19rp/dRZE+wg==
X-Received: by 2002:a05:6a00:ccc:b0:746:cc71:cc0d with SMTP id d2e1a72fcca58-746cc71ce4amr1239483b3a.12.1748403950763;
        Tue, 27 May 2025 20:45:50 -0700 (PDT)
Received: from thinkpad ([120.56.198.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e343c2d2sm265740b3a.136.2025.05.27.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:45:50 -0700 (PDT)
Date: Wed, 28 May 2025 09:15:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Samiksha Garg <samikshagarg@google.com>
Cc: jingoohan1@gmail.com, ajayagarwal@google.com, maurora@google.com, 
	linux-pci@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
Message-ID: <savypla2dk54sc5wwp4llbg2ojmws7p3xkkmstljf7ruvh2zxr@yvm2rd4nhuzt>
References: <20250526104241.1676625-1-samikshagarg@google.com>
 <bddr5afnyppbtpajk3wsymwnxrdvyyradxwqf2kkiahwat63av@h2kttx5blizv>
 <aDSQ9EuzlHiv6HTH@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDSQ9EuzlHiv6HTH@google.com>

On Mon, May 26, 2025 at 04:04:04PM +0000, Samiksha Garg wrote:
> Hi Mani,
> Thanks for your response. I can see that pci-keystone driver already calls this function.
> Does it not mean that there is already an upstream user?
> 

No, since keystone driver is not using the exported symbol.

- Mani

> Thanks,
> Samiksha
> 
> On Mon, May 26, 2025 at 04:50:11PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, May 26, 2025 at 10:42:40AM +0000, Samiksha Garg wrote:
> > > Some vendor drivers need to write their own `msi_init` while
> > > still utilizing `dw_pcie_allocate_domains` method to allocate
> > > IRQ domains. Export the function for this purpose.
> > > 
> > 
> > NAK. Symbols should have atleast one upstream user to be exported. We do not
> > export symbols for random vendor drivers, sorry.
> > 
> > - Mani
> > 
> > > Signed-off-by: Samiksha Garg <samikshagarg@google.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index ecc33f6789e3..5b949547f917 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -249,6 +249,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> > >  
> > >  	return 0;
> > >  }
> > > +EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
> > >  
> > >  static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > >  {
> > > -- 
> > > 2.49.0.1151.ga128411c76-goog
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

