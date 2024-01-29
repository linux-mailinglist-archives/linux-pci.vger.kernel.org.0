Return-Path: <linux-pci+bounces-2692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C883FEAC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 07:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D631C21852
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813DE4CE00;
	Mon, 29 Jan 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J27OzC9S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818B3C082
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511122; cv=none; b=sDR3+81IHl24OPF7+PgmRz0k2a6C/jTUloCLDjdidfoi72GPNd0p175uDmEEe03iHfMuEG4QYUIeJlJ2WBee4Ph5FVDuLnUC71gnnylPh8Vgj79bTzhHsh3/QnLqVhom/ecGgNs5zvYR0yG6aCgN0mi+8+mHB64OSpayS5KuFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511122; c=relaxed/simple;
	bh=UjO6h8ELr3sjqVkgWIzDjpkrkwTh/hl26sVHr7ycdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNA1zA+cyhJRCyiiJ7Q49dPCAmE/XsHJvOEPol692d0gAdsvt8tMqUFjSb7QAkebJfJSvpcEBn+FpYC30sGT2Z7FYmVzedwaOPOKxlam4xkOcuEXZonRoPjwlKh3WWQM3IxeUZVySeG9/3TbANDypELyOoWRIjaq/fy/0lhj0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J27OzC9S; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e132fef7baso50673a34.3
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 22:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706511120; x=1707115920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/xoU9ORqFpH0fQZTVM32kWKExD5zhAnwJQ/2UAzev0=;
        b=J27OzC9SHdaaOcErJ7SbtSGLEMT1MPHtyAAcjFt5PN8Kkd+5UAQeIDs1VTGIiOQz6g
         1Hdu7rZKAw91CblYHGe65L98ivFfU0GrDj5b1nTqu7hiOAzhJF5wHjxZ3tAglTc+Ox0/
         t3rxIv6pvjhys2HHvK8i2E+P11ZNxFpZm6gYPOjrB0JP0wKCfgCtpLYjZrJtzXAWiOCT
         EI6U0SI7N0M5ImuSZ171T0tfIUJzCgN6t90AlpZJwgodg1h9qQm7k6z8IVJ5+z1XPOtt
         4v7p1yFj0Rk/uBo61tlJWyjJAEVSmBa8TyTsgmJ6YPEovqmQVfaR8VWUJOH1Bb92dve1
         KrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706511120; x=1707115920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/xoU9ORqFpH0fQZTVM32kWKExD5zhAnwJQ/2UAzev0=;
        b=L0KrCyG8+o9Ryjuq8phV8erVBOGW6TLzc6E1r6jl0yzshVGciyr/inKam3Fff65AC+
         BfFTJfRSdzd+grf33q3kGTWsrCIqQ5/5NFaG8Z5yHuX5w2YwUw1QyMHpYsgUd1315y6Y
         /s2MP/vb4SofxB3HRe5hjs0RZwXcYIthEOz2mGGByMWMTB/4E7tVX4RL1xJ/dWjxXkgu
         faJ2XUP+PntBctqZB8A8ff44JWfYW9u+IL2F/nbyWftMJGZLeArKJqdnhTbv8AeeCwSN
         N4wEFD0pxV3ppekQ2MZoT3wG5FymXAxB5irp1Nr3aKXwmHlLL/4J3BvIqJTb6wUd7r4S
         EOEg==
X-Gm-Message-State: AOJu0YyvUKiv4coo9N/ekVUmUYKE/AmvAV/t/3y2dTBuseT4h4wHVZ7q
	nIxzFZCGtl0/wB1GGosyrVQpwFk3h2hqLWmTCWs46i4gTR3fER7hqpRbeVsLnQ==
X-Google-Smtp-Source: AGHT+IHxzxZjeKP7Zk6BN8GQYrt8bcQtvSue8r6i5Iv6EAIf8/zgYL3SUKBii3wsOSJhFlAN2uz8wA==
X-Received: by 2002:a05:6358:2925:b0:176:cd7c:ce96 with SMTP id y37-20020a056358292500b00176cd7cce96mr2920057rwb.26.1706511119486;
        Sun, 28 Jan 2024 22:51:59 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id o123-20020a62cd81000000b006ddc133f1d3sm5357642pfg.194.2024.01.28.22.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:51:59 -0800 (PST)
Date: Mon, 29 Jan 2024 12:21:51 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <ZbdLBySr2do2M_cs@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240120143434.GA5405@thinkpad>

On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > started or not, the code waits for the link to come up. Even in
> > > > cases where start_link() is not defined the code ends up spinning
> > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > gets called during probe, this one second loop for each pcie
> > > > interface instance ends up extending the boot time.
> > > > 
> > > 
> > > Which platform you are working on? Is that upstreamed? You should mention the
> > > specific platform where you are observing the issue.
> > >
> > This is for the Pixel phone platform. The platform driver for the same
> > is not upstreamed yet. It is in the process.
> > 
> 
> Then you should submit this patch at the time of the driver submission. Right
> now, you are trying to fix a problem which is not present in upstream. One can
> argue that it is a problem for designware-plat driver, but honestly I do not
> know how it works.
> 
> - Mani
>
Yes Mani, this can be a problem for the designware-plat driver. To me,
the problem of a second being wasted in the probe path seems pretty
obvious. We will wait for the link to be up even though we are not
starting the link training. Can this patch be accepted considering the
problem in the dw-plat driver then?

Additionally, I have made this patch a part of a series [1] to keep the
functional and refactoring changes separate. Please let me know if you
see a concern with that.

[1] https://lore.kernel.org/linux-pci/20240124092533.1267836-1-ajayagarwal@google.com/

> > > Right now, intel-gw and designware-plat are the only drivers not defining that
> > > callback. First one definitely needs a fixup and I do not know how the latter
> > > works.
> > > 
> > > - Mani
> > > 
> > > > Wait for the link up in only if the start_link() is defined.
> > > > 
> > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > ---
> > > > v4 was applied, but then reverted. The reason being v4 added a
> > > > regression on some products which expect the link to not come up as a
> > > > part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> > > > check, the probe function of these products started to fail.
> > > > 
> > > > Changelog since v4:
> > > >  - Do not return error from dw_pcie_wait_for_link check
> > > > 
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > > >  3 files changed, 22 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 7991f0e179b2..e53132663d1d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >  	if (ret)
> > > >  		goto err_remove_edma;
> > > >  
> > > > -	if (!dw_pcie_link_up(pci)) {
> > > > +	if (dw_pcie_link_up(pci)) {
> > > > +		dw_pcie_print_link_status(pci);
> > > > +	} else {
> > > >  		ret = dw_pcie_start_link(pci);
> > > >  		if (ret)
> > > >  			goto err_remove_edma;
> > > > -	}
> > > >  
> > > > -	/* Ignore errors, the link may come up later */
> > > > -	dw_pcie_wait_for_link(pci);
> > > > +		if (pci->ops && pci->ops->start_link) {
> > > > +			/* Ignore errors, the link may come up later */
> > > > +			dw_pcie_wait_for_link(pci);
> > > > +		}
> > > > +	}
> > > >  
> > > >  	bridge->sysdata = pp;
> > > >  
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 250cf7f40b85..c067d2e960cf 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> > > >  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> > > >  }
> > > >  
> > > > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> > > >  {
> > > >  	u32 offset, val;
> > > > +
> > > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > +
> > > > +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > +}
> > > > +
> > > > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > +{
> > > >  	int retries;
> > > >  
> > > >  	/* Check if the link is up or not */
> > > > @@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >  		return -ETIMEDOUT;
> > > >  	}
> > > >  
> > > > -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > -
> > > > -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > +	dw_pcie_print_link_status(pci);
> > > >  
> > > >  	return 0;
> > > >  }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 55ff76e3d384..164214a7219a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> > > >  
> > > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci);
> > > >  int dw_pcie_resume_noirq(struct dw_pcie *pci);
> > > > -- 
> > > > 2.43.0.381.gb435a96ce8-goog
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

