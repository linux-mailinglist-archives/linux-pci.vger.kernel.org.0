Return-Path: <linux-pci+bounces-13116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFB976C45
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8992B284EA1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD281AD276;
	Thu, 12 Sep 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAP9VoBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C31AD279
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151826; cv=none; b=behiVTMtokZ9UiLoWlzS3NPRAE8SifyQuW86lUNABb3YbT1OJ84wE6o1LaYO2zx0m5ogSgndWfhTRRhXDoQIXk4bWykvR4NnklmxmQ5hBUPqA7Dslsw6P1et5nk4gqfeLXiw1lpPDkn6WE0HfVEv7cSPZvfL4SjpecOW17awvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151826; c=relaxed/simple;
	bh=Vtkgpna/bKHRgJY/JAr5zkpq/2jMcMCjZoDV692lmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/ZEFKIj3wzGULv+601PWw/ojUrWYqnREqzfPOLoGXVM2qzT4stia/3l+S4pRUEk9VmGf/wZujY/fOTFC3tnjDHPHfVRGsLqb+0/lgF6mvOb6l64yctJRPO6i3j6UXzu0r4x+DweDy37uxTCNZ7JGmyoDXyBQdrv15AVSBP4/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAP9VoBJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso926224a12.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726151824; x=1726756624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anFSFPTnheRWls/K0Q3hF4+qKY/5O1ir8c9HL2uimeg=;
        b=QAP9VoBJP6p7vJN++x/dE2Q5FzsR/l7w5U6WLeCjy7Z1J1uhXgta/YnrGaHSVDCGN7
         PumgSoTtmu6XBppHsxN2vOSEYHGJb18MB1MuKkeK4neTfxeMc8rnB75awoVLTx35IK0j
         1//bzH/70sWI0lvcmbI73+vUp51mZylYgPyG2c5bAelCSb6w4drrDkxPzA4tApITAYuh
         AHSmkFicxlb88f6X34Lqa+zAAg2moKNTB1l2SaSF7GE1kbGf7R1STQzZp4TVZU4ZzeHD
         lv6PQ1c1Zs0UQmkCSbF46TleS8v1XdBXQ9N1aKKcFufXUKVaFGcvQ36RYHnI0qy+vqWG
         W6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151824; x=1726756624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anFSFPTnheRWls/K0Q3hF4+qKY/5O1ir8c9HL2uimeg=;
        b=OmWeubbAR6gV9vI8v3w+INCittBaEqaFYEJNmQ1bcwWfnERId9d41VOwt8uxNyWnCv
         DclQuWDNXZysf68sYZ/Z3UEypj+cDjb+bt2DKc8Y5BxwWVI8RzDsJYoRmxJvr2a/rxHA
         x04GkcqY8KBdC2K9DdK3vL0pKHYv3PaEdVa1NNr05iJrIRezu6X/64Z4o7AC0lRgaJtO
         tIM9awatVualmd9mxTvFKq+NWnK3FuvsaanEADBchawjy/N1d0O3T4d4vpn/D3wsvFaN
         lAh9256WDTC1Ij4i+wPvJ8x2c0BIrLoP5ODokYV6MygakOkoAoYSahImfYAZssDoTh9Z
         8P0g==
X-Gm-Message-State: AOJu0Yx+3U8uOYxg2sB3bDdIysFV9r4sGhMFArasCer3kL84PTpqpAY3
	OPJYj844qoCqhC8n4b6e9CqB214hB5o7At7lbOOm0vMVCz2gLtRU6wDwUlUOpspCsqTkP4MXyjc
	=
X-Google-Smtp-Source: AGHT+IE4qikLqQ5I8bCymfHxDdWrenloJq1hmSkXnnti718yXOSlzljTlC6NJCWxXtl/eegdxBC8Iw==
X-Received: by 2002:a05:6a20:c41a:b0:1cf:4679:9b97 with SMTP id adf61e73a8af0-1cf7620cbc7mr3566067637.37.1726151823595;
        Thu, 12 Sep 2024 07:37:03 -0700 (PDT)
Received: from thinkpad ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909252esm4650564b3a.124.2024.09.12.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:37:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:06:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <20240912143657.sgigcoj2lkedwfu4@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822113010.000059a1@linux.intel.com>

On Thu, Aug 22, 2024 at 11:30:10AM -0700, Nirmal Patel wrote:
> On Thu, 22 Aug 2024 15:18:06 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:
> > > VMD does not support INTx for devices downstream from a VMD
> > > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > > devices under VMD to ensure other applications don't try to set up
> > > an INTx for them.
> > > 
> > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>  
> > 
> > I shared a diff to put it in pci_assign_irq() and you said that you
> > were going to test it [1]. I don't see a reply to that and now you
> > came up with another approach.
> > 
> > What happened inbetween?
> 
> Apologies, I did perform the tests and the patch worked fine. However, I
> was able to see lot of bridge devices had the register set to 0xFF and I
> didn't want to alter them.

You should've either replied to my comment or mentioned it in the changelog.

> Also pci_assign_irg would still set the
> interrupt line register to 0 with or without VMD. Since I didn't want to
> introduce issues for non-VMD setup, I decide to keep the change limited
> only to the VMD.
> 

Sorry no. SPDK usecase is not specific to VMD and so is the issue. So this
should be fixed in the PCI core as I proposed. What if another bridge also wants
to do the same?

- Mani 

> -Nirmal
> > 
> > - Mani
> > 
> > [1]
> > https://lore.kernel.org/linux-pci/20240801115756.0000272e@linux.intel.com
> > 
> > > ---
> > > v2->v1: Change the execution from fixup.c to vmd.c
> > > ---
> > >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c index a726de0af011..2e9b99969b81
> > > 100644 --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct pci_dev
> > > *pdev, void *userdata) return 0;
> > >  }
> > >  
> > > +/*
> > > + * Some applications like SPDK reads PCI_INTERRUPT_LINE to decide
> > > + * whether INTx is enabled or not. Since VMD doesn't support INTx,
> > > + * write 0 to all NVMe devices under VMD.
> > > + */
> > > +static int vmd_clr_int_line_reg(struct pci_dev *dev, void
> > > *userdata) +{
> > > +	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
> > > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> > > +	return 0;
> > > +}
> > > +
> > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long
> > > features) {
> > >  	struct pci_sysdata *sd = &vmd->sysdata;
> > > @@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features) 
> > >  	pci_scan_child_bus(vmd->bus);
> > >  	vmd_domain_reset(vmd);
> > > +	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg, &features);
> > >  
> > >  	/* When Intel VMD is enabled, the OS does not discover the
> > > Root Ports
> > >  	 * owned by Intel VMD within the MMCFG space.
> > > pci_reset_bus() applies -- 
> > > 2.39.1
> > > 
> > >   
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

