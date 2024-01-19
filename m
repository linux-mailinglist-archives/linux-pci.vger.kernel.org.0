Return-Path: <linux-pci+bounces-2392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AA832E8C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29E81F2507E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E456447;
	Fri, 19 Jan 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8dNbGwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BF56445
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687173; cv=none; b=A7iJbPI1GyNn30ErQID1FBaC0SKySX6OzCdWtiWz/GEcZ56t4HGRqN+rEJx5WaFNaZB0SECWj/YTFmYqviZVxByW8AuWZzjcG3k2Z8mOGwiFn2E5kkE9U/M/3DC9f0Q49xH96ToyeYwUZhGTgOR0OqP6672z74N8RH6zLkOcU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687173; c=relaxed/simple;
	bh=wPIPD7XhSPcKhGZipfgpD6EoPyEt+snmsz7/NiTPbPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4m5t7uGFAZLfhW+8Dxi1ibSrsZxjx29VAUpxr/jrjf6AN2fMaRrvPmbshMbDXWUXy5QLE4LiQGfAR0A1Khq5H4bb1gE3FDY40GyocMpt20qa9q5w+L0/WFL+2FXsWZwAtJlIt0b1FbsxwGF3jrOmlVe1qJK9xRWyEglzEbG0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8dNbGwF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2903cd158f8so854362a91.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705687171; x=1706291971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=50cWvnubgr7CpK0ZhJPNmpumUnBz1pudZTtjUlGOM5M=;
        b=F8dNbGwFis4Mc3NkZLkQJJVKj5MVD4ynQSzEIXlzMGFxoCzIshEOIEg3z0tDXvbu1d
         YDY3q2KeZ3lw7v660y6qh+mSlbl3XstKM1/kBVoo8mTk1evpzVAG+n8VOqXZvXeO3dNw
         6gklYJT8PPqsRIkU5rpF7iahqs04l8IfTTv69cRfEKhpbIV+0Jk1/gQrsbfbhBSE18Vy
         l7N9D8ItJW/rAKCHkAADGm12Kr6BrXgBjFmScdyRtRXqoV65ZOzKmxsKB8QBFk20W+Ue
         S5q1kh9CH6Wu9uZGdqNfA/e6ihWEr3wmtHBq5YdP67k5SN1mzi8INLJlNyOioQi1+eG7
         lBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687171; x=1706291971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50cWvnubgr7CpK0ZhJPNmpumUnBz1pudZTtjUlGOM5M=;
        b=Z8gbWPSylRphlV1VzDhYLJ9sHMtIXbsACNCFRRee8yK6KR8vmy4vjCqHoJnUbkUUk4
         B1ekAHBSSuVDhJIxk2gnU5UfzeKy+0zSB+y5GNQn3z7XU4F444M+m5RH6cB4LzdX9OCf
         IY43CWTjT8Iux4Ono43YHLcLlCSfGEgbvjJON8StO/CrjQS9n4QsuvTVdpV1oP50eLYo
         OrIylgst9NTcXbLgFAahcB01RlqgShxUwzrn9uLxtOCB0ubEhEhwe/Ko3b8h45i+mmQK
         NlBTc/YUfHLucSnTQMnhni5GlgyzEOdzB3U/TirEEUcItHwj/gGYgEWk5lTu4Gap2EVm
         S+xA==
X-Gm-Message-State: AOJu0YzBRIltQyXNsxB/IgaNGJLDlJCKVf3f2vDkzItf4Qq4kbbUcXzj
	FxEof/ULxOzdZyq9s3Gbop7TwZ2/xgBBOtMbprE8g8JPnkE3tTD6QcYlpfzkzw==
X-Google-Smtp-Source: AGHT+IE/oa8MNk0mN+aZn3sMmnFaWVoi0urjcfP1MEH656fCJQ9KMwR8hKhwivJ8ME9GtWZb+gpqbg==
X-Received: by 2002:a17:90a:cf87:b0:290:9a0:ed3b with SMTP id i7-20020a17090acf8700b0029009a0ed3bmr135843pju.19.1705687170670;
        Fri, 19 Jan 2024 09:59:30 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id ok3-20020a17090b1d4300b0028ca92ab09asm4360964pjb.56.2024.01.19.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:59:30 -0800 (PST)
Date: Fri, 19 Jan 2024 23:29:22 +0530
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
Message-ID: <Zaq4ejPNomsvQuxO@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119075219.GC2866@thinkpad>

On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > In dw_pcie_host_init() regardless of whether the link has been
> > started or not, the code waits for the link to come up. Even in
> > cases where start_link() is not defined the code ends up spinning
> > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > gets called during probe, this one second loop for each pcie
> > interface instance ends up extending the boot time.
> > 
> 
> Which platform you are working on? Is that upstreamed? You should mention the
> specific platform where you are observing the issue.
>
This is for the Pixel phone platform. The platform driver for the same
is not upstreamed yet. It is in the process.

> Right now, intel-gw and designware-plat are the only drivers not defining that
> callback. First one definitely needs a fixup and I do not know how the latter
> works.
> 
> - Mani
> 
> > Wait for the link up in only if the start_link() is defined.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > v4 was applied, but then reverted. The reason being v4 added a
> > regression on some products which expect the link to not come up as a
> > part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> > check, the probe function of these products started to fail.
> > 
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
> 
> -- 
> மணிவண்ணன் சதாசிவம்

