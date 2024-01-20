Return-Path: <linux-pci+bounces-2399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6D833509
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EB81C20E30
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C7EEDC;
	Sat, 20 Jan 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TB7VIXxz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97113FC01
	for <linux-pci@vger.kernel.org>; Sat, 20 Jan 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761285; cv=none; b=lkJq3Z/wD834HyuNorvY0WAz+8pAyKiUMR6DITadjpyhHn+eK2eHOlFq7bu5zdTK+fs7m1I/DxiSrRew7yn8PyunrTWX5Ta9X2n+TAb8u91b65qreDLHLaI8RZdLEM0h4LJFAxe5YQBdiO5HO0zju+pMOSV+Nsg/khiBHANgZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761285; c=relaxed/simple;
	bh=EqIGaRvmGeR/5+LdfYMsG2RUos1HSi/wsOAaXvfNF7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBVmOfOcVfuAkjyzEAGaqE7lm3QMwcwGk3G3oL7yPySEfjVbwOuNzbjbzoMC0jr1zn/ATZs3B9oF+z3EaDxns2DYq9aA09n9lnS6zeX1xx1ElN07Hcz6vYOuDuXl6BJU+ecu15k5907dL9t4eYRUOqNSGDnvzGXSwz/ea7fUD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TB7VIXxz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so1429757b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 20 Jan 2024 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705761283; x=1706366083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFhPTENInlshnxvQwGp6Fsfz+q9YoFQSTIZFOEfGInw=;
        b=TB7VIXxzYVVBiivNzpBLqCPzYHQTCmaf5pXBc3Z5FzDJjxqTtvqTa1cGh3HuOOJ+zn
         3cU8XydAUS3HvToTn/sL7hbpb7aAffqqW+/f5a316VvLA8DG733T0Hj2qfuWucEADSkK
         7Vqn6V+no+wMgbi+zFZr4i8P2RR8QmhBhTXrOqMcL4Rfck//Y+XLTE539JQLt2HqKGKZ
         sAPbBzQKC3K9nTlw3FPjIz3aX7yq3vM9CcWrePaIgn85MOpe+ewr+XNI8NgLp4hYfPjB
         EZN2lLHDLIj/FQ4S5XYnQHqTqDvRwvF7OW0e/OcsxmP2yPgDyiAJtVoNam5TV4O+YB8l
         9Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705761283; x=1706366083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFhPTENInlshnxvQwGp6Fsfz+q9YoFQSTIZFOEfGInw=;
        b=jkFaZNXI0d0sWNbvKMkAzCLUkPxqDsVyLftGQxfVLujfZTiL625wi5rgLDLnU6CECy
         tR965mmG+41p7t2PDGkzbuHlZCzFhCbd8ZbsrYYFYFKteQdblusVmsn3ntd/spMpGoyP
         GMAhSQ++q0Apk7mIwtI/pcqmK0S6XeRuiBRi8sEuVms+jogQN+IN9uFYVWRx0y9oOSjC
         Gm6umIde6/z1ojG2ejhqvc+rvTKEogg97qIWl1smWWrHVFwKF/OeFb9vlY8FH7VALdxG
         o6f4OS6gfNenxh/l7KdJh8gEra75JddGeuzvY8p2MKNBpW2Dz/1Ldd8pCv4MkIw1E6p3
         IQFw==
X-Gm-Message-State: AOJu0YwfkmkGFfkcvpIDRvd0ZSaDrmljlL1lxmlMK/Hq/3J/YIpqpKC5
	wUtk27e2BLae2YArqM7tSGB5GXsaVRHdXmJTx3E9sq+sxuk/V2IwiDiY2cMv/A==
X-Google-Smtp-Source: AGHT+IEi9lqVjS4SuKET0pY/+iog2gHw6Fauu8hXeshIgD6hoSUuXevDC4R2tk9fwv07o04qcadFDw==
X-Received: by 2002:a05:6a20:324a:b0:19a:b86c:5b98 with SMTP id hm10-20020a056a20324a00b0019ab86c5b98mr1438960pzc.121.1705761282795;
        Sat, 20 Jan 2024 06:34:42 -0800 (PST)
Received: from thinkpad ([117.202.189.10])
        by smtp.gmail.com with ESMTPSA id z2-20020aa785c2000000b006d99d986624sm6802791pfn.151.2024.01.20.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 06:34:42 -0800 (PST)
Date: Sat, 20 Jan 2024 20:04:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240120143434.GA5405@thinkpad>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zaq4ejPNomsvQuxO@google.com>

On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > In dw_pcie_host_init() regardless of whether the link has been
> > > started or not, the code waits for the link to come up. Even in
> > > cases where start_link() is not defined the code ends up spinning
> > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > gets called during probe, this one second loop for each pcie
> > > interface instance ends up extending the boot time.
> > > 
> > 
> > Which platform you are working on? Is that upstreamed? You should mention the
> > specific platform where you are observing the issue.
> >
> This is for the Pixel phone platform. The platform driver for the same
> is not upstreamed yet. It is in the process.
> 

Then you should submit this patch at the time of the driver submission. Right
now, you are trying to fix a problem which is not present in upstream. One can
argue that it is a problem for designware-plat driver, but honestly I do not
know how it works.

- Mani

> > Right now, intel-gw and designware-plat are the only drivers not defining that
> > callback. First one definitely needs a fixup and I do not know how the latter
> > works.
> > 
> > - Mani
> > 
> > > Wait for the link up in only if the start_link() is defined.
> > > 
> > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > ---
> > > v4 was applied, but then reverted. The reason being v4 added a
> > > regression on some products which expect the link to not come up as a
> > > part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> > > check, the probe function of these products started to fail.
> > > 
> > > Changelog since v4:
> > >  - Do not return error from dw_pcie_wait_for_link check
> > > 
> > >  .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > >  3 files changed, 22 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 7991f0e179b2..e53132663d1d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	if (ret)
> > >  		goto err_remove_edma;
> > >  
> > > -	if (!dw_pcie_link_up(pci)) {
> > > +	if (dw_pcie_link_up(pci)) {
> > > +		dw_pcie_print_link_status(pci);
> > > +	} else {
> > >  		ret = dw_pcie_start_link(pci);
> > >  		if (ret)
> > >  			goto err_remove_edma;
> > > -	}
> > >  
> > > -	/* Ignore errors, the link may come up later */
> > > -	dw_pcie_wait_for_link(pci);
> > > +		if (pci->ops && pci->ops->start_link) {
> > > +			/* Ignore errors, the link may come up later */
> > > +			dw_pcie_wait_for_link(pci);
> > > +		}
> > > +	}
> > >  
> > >  	bridge->sysdata = pp;
> > >  
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 250cf7f40b85..c067d2e960cf 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> > >  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> > >  }
> > >  
> > > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> > >  {
> > >  	u32 offset, val;
> > > +
> > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > +
> > > +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > +}
> > > +
> > > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > +{
> > >  	int retries;
> > >  
> > >  	/* Check if the link is up or not */
> > > @@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > >  		return -ETIMEDOUT;
> > >  	}
> > >  
> > > -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > -
> > > -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > +	dw_pcie_print_link_status(pci);
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 55ff76e3d384..164214a7219a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> > >  
> > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> > >  int dw_pcie_resume_noirq(struct dw_pcie *pci);
> > > -- 
> > > 2.43.0.381.gb435a96ce8-goog
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

