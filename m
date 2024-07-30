Return-Path: <linux-pci+bounces-11002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A447794079E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 07:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3385F1F239A5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8D2114;
	Tue, 30 Jul 2024 05:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3OhfyW2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2833999
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317316; cv=none; b=n9W3lyzykIktsZv7VSJof6Vw5Etyy7EYSCTcNBFraoawPB2fQSyNnHCNEDnExWBkBTAf0Gybi8mkSGCh5y+OZDiQJg/zy9laQG3Xb+plGzBeb0A2PlEmGx6HwwoVEPA4XbiZs/OHMMV6MMMCqjhI8ozg0RiuRM8hT2bW2Q99fVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317316; c=relaxed/simple;
	bh=I/hArHzezwMHygSBGZKIJygakxeKeGYNP7+toPqAVck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeNBjpriBL1AkiH/tLBjgLSi7jFZs4UPaeQp9ePYfGrDc7xjV0wUchOqn6h1Vn9tVgzcpJQDFjB6UTeiXuCmO6CKi08o9Ev/amNT3WIoIxTaECp8W3Keq8WyHpfQMnGfYWAhIUyjovMEb6VslVHZA8nbod7kSP5wcmEP52SP1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3OhfyW2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso3589692b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722317314; x=1722922114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQ73Nu26HSzeMwdLS96TVqMFwbRQR3zAxrRk+Py+6Js=;
        b=d3OhfyW2w4Fm+UcIQJ+qSiSVOQ6cQixCGt8qF4uJY3Di9IfSq1556qHSgnc+8ZQ5Wz
         +ru9ErRZ4UHRpgWYrmIZtSAXvD19XYXTyv7I5j95/WSKhdUIF9z5xDE8tHNTxk6uLSgV
         lrC+Fz87A983kxaZGR84WyhVvClGWtxjE9dQ5mRPFarFWOYK/MmvxRnN50CF+4CvqsGJ
         YCo7+UmKIcrMv+GAEuLwlmj09tf1tm7zAihSPOSJ2BHtJeDsZDabA1EuvzG6lkxyipz1
         aNAhWU1CY6nHhZulYOL/uuFWnMNEIV9p7t2lJh8fGcdinxtarWdpXdPViRJDZpy7fkPt
         Hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722317314; x=1722922114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ73Nu26HSzeMwdLS96TVqMFwbRQR3zAxrRk+Py+6Js=;
        b=gDC6qs7HZDofE4ySOUPxcxLjs9uUheY/eHCY6XEag3petfq1wXqfH57dHbVLB6QgZv
         togj4mqSRr/0WDer6dMSRA2DXVyIQbpv0D1JdqwoP2WxDmhn4W1QI2hBjHfMpgjoXwR0
         k3bpFUsdL5/ZV5a1KI2SXt8/6Nfat2jej0oMY+c+SJFeoO4vGHjuQ115H65vDV5Jc/gt
         GUwMcNw0i8JSSrLN7oRAIAiTdtdA/qWlngJnpKei1P7Bn+TRifB1SG/U/ESzBbRXxxGm
         +mUUA0R5frR2eQeq64/VZ2KFls3m8oI7uleWi/ByOUri/7CS0EBMKfouOlHqR0x2tL2j
         bhEg==
X-Forwarded-Encrypted: i=1; AJvYcCWab/l5aEVBz3yfLXQCcDi2dAIIMYu6S+diMFk0VobSYrON3Yx950NUg8B9EUarI1mffTpHb2TNffczDLpyur4II3RjJncii+J1
X-Gm-Message-State: AOJu0YyKiXvltgTNcWuBE1iwkRlcgWrItZarztEETmkj9vheTIaix5uI
	k6UM3UgTTETGCR7tbHcTh/9n9C/x3mP65s+ryUcUc7YseBWq8hhX+G5Bb6B+5A==
X-Google-Smtp-Source: AGHT+IH9vr4QX72Nqgqbxh4pJHyfzr5/NJLlSS8+RP/jRaAQupKsB1CJOQcjgIa7g1FRUmLAVFbAHw==
X-Received: by 2002:a05:6a21:78a9:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c4a0e15171mr12628871637.0.1722317314267;
        Mon, 29 Jul 2024 22:28:34 -0700 (PDT)
Received: from thinkpad ([220.158.156.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738fd4csm11737713a91.3.2024.07.29.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 22:28:33 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:58:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	paul.m.stillwell.jr@intel.com,
	Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Message-ID: <20240730052830.GA3122@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
 <20240724191030.GA806685@bhelgaas>
 <20240725041013.GB2317@thinkpad>
 <20240729130859.00006a5a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729130859.00006a5a@linux.intel.com>

On Mon, Jul 29, 2024 at 01:08:59PM -0700, Nirmal Patel wrote:
> On Thu, 25 Jul 2024 09:40:13 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Wed, Jul 24, 2024 at 02:10:30PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:  
> > > > VMD does not support legacy interrupts for devices downstream
> > > > from a VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0
> > > > for these devices to ensure we don't try to set up a legacy irq
> > > > for them.  
> > > 
> > > s/legacy interrupts/INTx/
> > > s/legacy irq/INTx/
> > >   
> > > > Note: This patch was proposed by Jim, I am trying to upstream it.
> > > > 
> > > > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > > ---
> > > >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > > index b33afb240601..a3b34a256e7f 100644
> > > > --- a/arch/x86/pci/fixup.c
> > > > +++ b/arch/x86/pci/fixup.c
> > > > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev
> > > > *pdev) DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL,
> > > > PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
> > > >  
> > > > +#if IS_ENABLED(CONFIG_VMD)
> > > > +/* 
> > > > + * VMD does not support legacy interrupts for downstream devices.
> > > > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure
> > > > OS
> > > > + * doesn't try to configure a legacy irq.  
> > > 
> > > s/legacy interrupts/INTx/
> > > s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> > >   
> > > > + */
> > > > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > > > +{
> > > > +	if (is_vmd(dev->bus))
> > > > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> > > > 0); +}
> > > > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > > > quirk_vmd_interrupt_line);  
> > > 
> > > A quirk for every PCI device, even on systems without VMD, seems
> > > like kind of a clumsy way to deal with this.
> > > 
> > > Conceptually, I would expect a host bridge driver (VMD acts like a
> > > host bridge in this case) to know whether it supports INTx, and if
> > > the driver knows it doesn't support INTx or it has no _PRT or DT
> > > description of INTx routing to use, an attempt to configure INTx
> > > should just fail naturally.
> > > 
> > > I don't claim this is how host bridge drivers actually work; I just
> > > think it's the way they *should* work.
> > >   
> > 
> > Absolutely! This patch is fixing the issue in a wrong place. There
> > are existing DT based host bridge drivers that disable INTx due to
> > lack of hardware capability. The driver just need to nullify
> > pci_host_bridge::map_irq callback.
> > 
> > - Mani
> > 
> For VMD as a host bridge, pci_host_bridge::map_irq is null. Even all
> VMD rootports' PCI_INTERRUPT_LINE registers are set to 0. 

If map_irq is already NULL, then how INTx is being configured? In your patch
description:

"So initialize the PCI_INTERRUPT_LINE to 0 for these devices to ensure we don't
try to set up a legacy irq for them."

Who is 'we'? For sure the PCI core wouldn't set INTx in your case. Does 'we'
refer to device firmware?

>Since VMD
> doesn't explicitly set PCI_INTERRUPT_LINE register to 0 for all of its
> sub-devices (i.e. NVMe), if some NVMes has non-zero value set for
> PCI_INTERRUPT_LINE (i.e. 0xff) then some software like SPDK can read
> it and make wrong assumption about INTx support.
> 

Is this statement is true (I haven't heard of before), then don't we need to set
PCI_INTERRUPT_LINE to 0 for all devices irrespective of host bridge? 

> Based Bjorn's and your suggestion, it might be better if VMD sets
> PCI_INTERRUPT_LINE register for all of its sub-devices during VMD
> enumeration.
> 

What about hotplug devices? 

- Mani

-- 
மணிவண்ணன் சதாசிவம்

