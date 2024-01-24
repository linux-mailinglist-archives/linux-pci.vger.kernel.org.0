Return-Path: <linux-pci+bounces-2514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB083A577
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E54B2D7F9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4AEEC2;
	Wed, 24 Jan 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIJhfkCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E941B271
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088310; cv=none; b=nTExVPsWU1L02q6O7c2t27RoqETH4FPunCHTeNr8mYHZAhNte5KvPTFMViMn0nnI1facf/zWyh2i2mV1Ok1zjTSfk1AIjxOpsIJ07C7pKn9tU13NNNff49S+yvPw3QsERucCv41I3/ZQ+Y9hd2oec/Jo/M4DJ9wLpCzfsZfpEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088310; c=relaxed/simple;
	bh=GaZnXa6XsQpIYb4yo9o8IhlmIso3DO+1Q0OzIeyZOGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPDTnJ20gQ/ahLgSWBqiiL8ysSh4z7ZEgTRC3q4ha+G2euLud9ruPP8teyt2QBrkg+YTJK2gKIskFLlFlZG9YCkWvWM4NamXcbyfuSdPBzQMOl93lY3xF+Tg/vdeYbNakwfmpojNqBd1um1PPQnnUjEMF5zFGa54L39cbC1USJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIJhfkCv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so37725435ad.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706088308; x=1706693108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNmoGhIYjvtapaZ8omtVSlUol/i2RmR9P90NAqUIL1o=;
        b=AIJhfkCvtmrfDks+ycbheDRpvrxpIy6kRF4FSZRt2smVihWM4hozV+I5iHNnSr+6du
         g5fO7HEsmlS2C+WmgPFHlvKO+34sqDg5MeFiiaiXjjqrRqRTgGpHgZD/c8KrhIdPER7f
         PuFTCeJN44ehHmd2bwuZiaxXyBuvqMwR8QdSVQpK3T66Bqln4ZE18DqHHt6i0Ppe6rSz
         YDSqzSHWd7oQ2O0+iVbMcXObdXjRGSFGf3J//DpCCPIfUlDYl9f+5IZz3v5Lg7eY4guT
         gSgXFrJFPZvH1WtVaAhdDM843jx5z/nLBuLND2ijor7MP5bobjNVmxKxoxaA+Y+8u17G
         fqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088308; x=1706693108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNmoGhIYjvtapaZ8omtVSlUol/i2RmR9P90NAqUIL1o=;
        b=EbmH//ISRq+g4cfFESUb4cLrZF8g1ae9K86/N9i9+oZaewb3GLoqO8iPVVpxk9wv4s
         cnBaQMD7Ohbqm4K/wiK0QCXuoTZ6brT+Kq2HXpWGBTcnpgf+kNcheHF/V9MbgSLfNaKa
         3IFuU7G5avW4iOFEOwhR4if7kv+LLumBBMTVZrtqZQcPllrYUImXGEWm82a248kiDmIX
         telr2kk8qfNrZf7iXbAcw/IiFUjt0cbB8/jTV7LvPX1Oh15YPIy39y6p8aiRnwBo9Pj7
         A7sxpC/JYbllFj/DqUvJJ3Y8klkCVA/u8JXn5XyMMZ5Ffrc1+UVe90bTMxTLkw6LnCgF
         jbPw==
X-Gm-Message-State: AOJu0Yyzkolqfz7MXAyRVHad9/PEF0Eav7oTya4b89j36K9Z2Y9M7joP
	nGtFFn915dRcS58RAUa+Q5gqEcs983Fj4ZB+ng/gISGoXL+Hr0ZsOY1Ub9476B0pIF6eG6nv18A
	JQHb6
X-Google-Smtp-Source: AGHT+IEmV1Y1VUIwS1O0AKu8nxVenRpi8tzr7+bX+vC9RLMT5gh9tD0jnLTELtipIu0TQOIj5OOWvw==
X-Received: by 2002:a17:903:245:b0:1d7:3d40:3cd6 with SMTP id j5-20020a170903024500b001d73d403cd6mr928357plh.1.1706088307466;
        Wed, 24 Jan 2024 01:25:07 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902c9cd00b001d71eedae33sm8309787pld.45.2024.01.24.01.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:25:07 -0800 (PST)
Date: Wed, 24 Jan 2024 14:54:58 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Fabio Estevam <festevam@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZbDXahCrh-k__k82@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119204211.GA185359@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119204211.GA185359@bhelgaas>

On Fri, Jan 19, 2024 at 02:42:11PM -0600, Bjorn Helgaas wrote:
> [+cc Bjorn A, Fabio, Xiaolei, who reported the v4 issue]
> 
> On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > In dw_pcie_host_init() regardless of whether the link has been
> > started or not, the code waits for the link to come up. Even in
> > cases where start_link() is not defined the code ends up spinning
> > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > gets called during probe, this one second loop for each pcie
> > interface instance ends up extending the boot time.
> 
> s/start_link()/.start_link()/ to hint that this is a function pointer,
> not a function name in its own right (also below).
> s/1/one/ to be consistent.
> s/pcie/PCIe/ to follow spec usage.
> 
Sure, will fix it in the patch series.

> > Wait for the link up in only if the start_link() is defined.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > v4 was applied, but then reverted. The reason being v4 added a
> > regression on some products which expect the link to not come up as a
> > part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> > check, the probe function of these products started to fail.
> 
> I know this part doesn't get included in the commit log, but I think
> it would be nice to include the relevant commits here:
> 
>   da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
>   c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link is started"")
> 
> because the latter includes details about the actual failure, so we
> can review this with that platform in mind.
> 
Sure, will add the details in the patch series.

> > Changelog since v4:
> >  - Do not return error from dw_pcie_wait_for_link check
> > 
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
> 
> This part (pcie-designware.c and pcie-designware.h changes) could
> arguably be in a separate patch so they're not a distraction from the 
> important functional change.
> 
Sure, will separate it out in the patch series.

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
> > 2.43.0.381.gb435a96ce8-goog
> > 

