Return-Path: <linux-pci+bounces-5173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCA788C03C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7791330163C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52C481A5;
	Tue, 26 Mar 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZPDLU58"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C33838C
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451431; cv=none; b=oZV6DnUiqqKOt4924mdEmDeeHEFBtLgaVAoXeeweOogUqExF+6r9eiOZQcVbm50EcOLGjpAetP2ahAcvP+cLqu242vL9jg9Ba0byRnrJXrLvq2NaqZ+mLpa0sI8c/5OyRWqayuuolpAbkas2wuty8wUXz7+lLRSaKos4MBLyK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451431; c=relaxed/simple;
	bh=lNqffwHbF4+DgPye64vC4bdBKO4etn+DRoKyxkJB4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpnOwxBfPwHIAkpj3LXZSifKmx72ictaFpErWQBtpc9k0sbiNpWHpRa6P9Y7XlqmneiEtTJBEMU/+/WRZUe6zzdx3ivfh8cm0GAgJmCgUNXJNGzE1ujW5jm1zCj8lVp3Ee6N3Rw6FB8ahaKZY1ZK1MyFlLIVjhkVG9ESnnaL8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZPDLU58; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so4538923b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711451429; x=1712056229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGBD00Nb+rvDCVS5Fn3z09PsE5MBX3NmOYcBRrgB0Ak=;
        b=zZPDLU580HPKiXYVVXk2P7n4QQ0HTnufmR9KkrA8VrQWaSSsWQYeHXj+31bQyiOVbq
         nkEC7knCDBUc3aQEZRCQX6uipN9Ffmk45NXw7wXts8xAshONBqxJhZE8T30fXsxqKsyw
         GByGYcf9dDbDh8BwYOO0P1MCAwcdldg7kdINXoY7mBOzBbRDp2JLrunGIvpJtyQdznVs
         HWXCptyBcoCyEduhch5qY7OocUee6+ZQeaxMiPPZPlCsbpKxyqqzYSljO0GNqD0B+KV9
         G5gMlyT7gyNBvBdB9l3NiAsxgEYHsyw4OJGBfmqr0D3p1wCIUNAZH8n4B2gozkbH7Yan
         acYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451429; x=1712056229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGBD00Nb+rvDCVS5Fn3z09PsE5MBX3NmOYcBRrgB0Ak=;
        b=eh3yw/UpcAAnwO6Yoc0O5m6kfcg3mtZNezCsxBJfdqkhCHMZneq50YMwQUFxxFz+ZB
         ktX7i7JM/EsYp9CyIWS1onqDJ4+TnfJaTx8GZUSk1jzu2wgJS9afD80mjqsq7YKKQ/CJ
         b+Xj6ikcg4w67fw4EOInYLd6O0VPvCnohvzoANiKvu1SDNsco206Ik+UHJzBHVuEejOm
         zZISQk+Rg8AJYXgCka9Hkjr3eYo4WyHMfmaUK/wKXXILaUj0GEAUwTK/K43jFTvgKnfA
         Fh0pSReAiUIjWPiJVdJfdX0D61+4gQZRyXThAa5P0437wjlwtw2xcSIS/28AsMVDp89G
         UOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQMqH/+65R9fo+UNr5B0oovWprXp8gHpFaY8MvkUfRIKfm5JoMAwmielO+Q1tX8ojbZ4NdGDhgzikETFd5zPVcaFVHM8uqt7sA
X-Gm-Message-State: AOJu0YxDn8lonEzEz1wTv+My9G2v8K4KirJ5UoxqFjLU3yjHCJ1oq9oX
	CYtYVakIckrTpXlt1JlDDFcUTWIefdzCJ10BVTmiEL6wvOCJcF2zflToDSidXw==
X-Google-Smtp-Source: AGHT+IGbSEcld3RliKzvUERGTeqYSFE/Rs+8oSpqppqSDIVaVGzMOSy8p0g1ooCyZlGfvgyHtpzkLQ==
X-Received: by 2002:a05:6a20:d81b:b0:1a3:bb75:17ab with SMTP id iv27-20020a056a20d81b00b001a3bb7517abmr8219769pzb.59.1711451429355;
        Tue, 26 Mar 2024 04:10:29 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e647716b6esm5943393pfd.149.2024.03.26.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:10:29 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:40:21 +0530
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
Message-ID: <20240326111021.GA13849@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
 <20240326074429.GC9565@thinkpad>
 <ZgKiUogkgrMwV1uD@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgKiUogkgrMwV1uD@x1-carbon>

On Tue, Mar 26, 2024 at 11:24:18AM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 01:14:29PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 22, 2024 at 05:08:22PM +0100, Niklas Cassel wrote:
> > > On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> > > > All EP specific resources are enabled during PERST# deassert. As a counter
> > > > operation, all resources should be disabled during PERST# assert. There is
> > > > no point in skipping that if the link was not enabled.
> > > > 
> > > > This will also result in enablement of the resources twice if PERST# got
> > > > deasserted again. So remove the check from qcom_pcie_perst_assert() and
> > > > disable all the resources unconditionally.
> > > > 
> > > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
> > > >  1 file changed, 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > index 2fb8c15e7a91..50b1635e3cbb 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> > > >  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> > > >  {
> > > >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > -	struct device *dev = pci->dev;
> > > > -
> > > > -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> > > > -		dev_dbg(dev, "Link is already disabled\n");
> > > > -		return;
> > > > -	}
> > > >  
> > > >  	dw_pcie_ep_cleanup(&pci->ep);
> > > >  	qcom_pcie_disable_resources(pcie_ep);
> > > 
> > > Are you really sure that this is safe?
> > > 
> > > I think I remember seeing some splat in dmesg if some clks, or maybe it
> > > was regulators, got disabled while already being disabled.
> > > 
> > > Perhaps you could test it by simply calling:
> > > qcom_pcie_disable_resources();
> > > twice here, and see if you see and splat in dmesg.
> > > 
> > 
> > Calling the disable_resources() function twice will definitely result in the
> > splat. But here PERST# is level triggered, so I don't see how the EP can see
> > assert twice.
> > 
> > Am I missing something?
> 
> I think I remember now, I was developing a driver using a .core_init_notifier,
> but I followed the pcie-tegra model, which does not enable any resources in
> probe() (it only gets them), so I got the splat because when PERST got
> asserted, resources would get disabled even though they were already disabled.
> 
> pcie-qcom:
> -gets resources in .probe()
> -enables resources in .probe()
> -sets no default state in .probe()
> 
> pcie-tegra:
> -gets resources in .probe()
> -enables resources in perst_deassert()
> -sets default state to EP_STATE_DISABLED in probe()
> 
> So pcie-qcom does not seem to be following the same pattern like pcie-tegra,
> because pcie-qcom actually does enable resources for the first time in
> probe(), while tegra will enable resources for the first time in
> perst_deassert().
> 
> Sorry for the noise.
> 

I was planning to drop enable_resources() from Qcom driver once the DBI rework
series gets merged. Because, the resource enablement during probe is currently
done to avoid the crash that is bound to happen if registers are accessed during
probe.

But what your observation reveals is that it is possible to get PERST# assert
during the EP boot up itself which I was not accounting for. I always assumed
that the EP will receive PERST# deassert first. If that is not the case, then
this patch needs to be dropped.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

