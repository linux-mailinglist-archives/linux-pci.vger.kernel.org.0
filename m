Return-Path: <linux-pci+bounces-2083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FD82BD42
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC61F26621
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74C51C2E;
	Fri, 12 Jan 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFt7Ciq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494C5EE66
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59502aa878aso2939713eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 01:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705051743; x=1705656543; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1hGbIM6xAsV54bTgGea3NPypLFLKK59hdDDOkiBSco=;
        b=rFt7Ciq/4IZp/nMaSblcrSYh8noultdxnSIK2ftyqd/PY4jdpmNNEeUo5kFXgkY+yj
         qvwlb9S2WVnQncRJSCXXv84yOQKaiRIyiOhQcdBYAzfpmcv4UHFI3PxFo+EdjbjftA67
         5NV6AA1+o17tXiO3AA5RAfDa+AiG4EO7MaBpgVkgFM5YjrvzaxkuWf3Z9dPjNm1NWw8+
         hZO3wPVTTk+p6QnNIzG+/MIUZQrmOJqbJNr1Ny+sJxNifeG/nYGSbK8WUbnpTECem8eg
         shvVhGWeCmr/KaoTx7Ebay3aj270Il0L9Ig/hSW6ZiGsM6sHWmvHkCpjmj9tQmN+YaxJ
         6czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051743; x=1705656543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1hGbIM6xAsV54bTgGea3NPypLFLKK59hdDDOkiBSco=;
        b=dCSepTE5q+Qhum/QhSCtB/1cRWCOQRkCJxypmfuXelsfwwIYtuX65Nqzwj9QCBW3Fq
         jowe61+wdosJaf/Cka2KA+ruEJfYx5GhLfWo8tf8MJhtfwaevMfhJh6WrcRE6N18w5Pm
         RrzY1yKEI2VPPrl6oSFv3/wjegP3KPzNKTnkKnYLM0CEwI3/wdZiZO6b2XrKQUdBJmEt
         gn93PAVOv1pIl0MZYEN3XSjpGrzYmEPM4WpxUbGATO8Ykn3CkaMEcB1Igv/54cfqvvqH
         M06I729qLLSpRxGuqK+VYMBNyVKfad09lUNBDvH7Zso2JcBcmYiJ1hg4zshoHOtuz0q0
         X10w==
X-Gm-Message-State: AOJu0YyebxkP1umTekkRqa4Wlq7ZF3ryCL/QOtQE+8Ye0usNLCsPueme
	YThi52/yxMQpeFluZhb4z3GVtD7LJg7n
X-Google-Smtp-Source: AGHT+IEbSYUB1gPEAEKazD3pLrZrMgxdfICZCHUwECYVpNJYIZi/n8aEBGYMTzMYUCLX+u+SsJVPig==
X-Received: by 2002:a05:6359:6b85:b0:175:c51c:c69b with SMTP id ta5-20020a0563596b8500b00175c51cc69bmr843493rwb.8.1705051743202;
        Fri, 12 Jan 2024 01:29:03 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id qd15-20020a17090b3ccf00b0028d53043053sm5753127pjb.50.2024.01.12.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:29:02 -0800 (PST)
Date: Fri, 12 Jan 2024 14:58:54 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZaEGVvvEA5SUANf9@google.com>
References: <20240111152517.1881382-1-ajayagarwal@google.com>
 <20240112052816.GB2970@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112052816.GB2970@thinkpad>

On Fri, Jan 12, 2024 at 10:58:16AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 11, 2024 at 08:55:17PM +0530, Ajay Agarwal wrote:
> > In dw_pcie_host_init() regardless of whether the link has been
> > started or not, the code waits for the link to come up. Even in
> > cases where start_link() is not defined the code ends up spinning
> > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > gets called during probe, this one second loop for each pcie
> > interface instance ends up extending the boot time.
> > 
> > Wait for the link up in only if the start_link() is defined.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> 
> This is clearly not v1. Either this patch has to be a RESEND or v2. And the
> changelog should mention what happened to the earlier version (revert history
> etc...)
>
Sorry about that. I will create a v5 since the v4 version of this patch
was applied but then reverted. Will add revert history, reason and
changelog from v4 to the v5 description.
> Also, I provided feedback on the revert patch that you have completely ignored
> [1]. If you do not agree with those, it is fine, but you should justify first.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20230711073719.GA36617@thinkpad/
>
Sure. Responded to the questions on the thread you mentioned.
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
> >  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >  3 files changed, 22 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 7991f0e179b2..e53132663d1d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	if (ret)
> >  		goto err_remove_edma;
> >  
> > -	if (!dw_pcie_link_up(pci)) {
> > +	if (dw_pcie_link_up(pci)) {
> > +		dw_pcie_print_link_status(pci);
> > +	} else {
> >  		ret = dw_pcie_start_link(pci);
> >  		if (ret)
> >  			goto err_remove_edma;
> > -	}
> >  
> > -	/* Ignore errors, the link may come up later */
> > -	dw_pcie_wait_for_link(pci);
> > +		if (pci->ops && pci->ops->start_link) {
> > +			/* Ignore errors, the link may come up later */
> > +			dw_pcie_wait_for_link(pci);
> > +		}
> > +	}
> >  
> >  	bridge->sysdata = pp;
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 250cf7f40b85..c067d2e960cf 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> >  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> >  }
> >  
> > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> >  {
> >  	u32 offset, val;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > +
> > +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > +}
> > +
> > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > +{
> >  	int retries;
> >  
> >  	/* Check if the link is up or not */
> > @@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > -
> > -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > +	dw_pcie_print_link_status(pci);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 55ff76e3d384..164214a7219a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> >  
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> >  int dw_pcie_resume_noirq(struct dw_pcie *pci);
> > -- 
> > 2.43.0.275.g3460e3d667-goog
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

