Return-Path: <linux-pci+bounces-10749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1EB93BB67
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD901F213ED
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060117550;
	Thu, 25 Jul 2024 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZFKVac9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400C7FF
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880618; cv=none; b=ECVK81Hbi/2GtCEgLJXb/jdcI9Y16exrPW35lh57G0KWqsteKZAzagpLimrPRLpNnSWKGkzpQ4OUiEfHnLCSEGHqLBRwHKU+NCF4qB/WO221V/HYX/um8Xz/p/MJnmTlPbMHjkJW+zK8V8pnsv3I+LNmlzoxtK1wVK4Ew7nT3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880618; c=relaxed/simple;
	bh=cVA2MMh5hZpvr1lSPKbH1u3sUq8cydk8db/GFudfEd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr7ocO6IgM/wt7gqQh4BMJdxmBmVLMxYfAmNTIEeLKq6BI+vqDs0dR6afwZ5Ylb8LQGy8o1oCh4z1eX+Y9rYTCIfdgAJ2D7XkSZxml3JR5xadES7JbtwZ4OgqjBQGOnk97E0H25jpprhgV8WJUJMvy4t+gv3RF+TMsoqCDpNrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZFKVac9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70eae5896bcso157169b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721880616; x=1722485416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abMZUNvcjtluULe7Vf10wtd/LJtynKXkPZEsuxsYfu4=;
        b=jZFKVac97kL/jfZKjsMMrocasnk+8ziRmh1hOHW1zoOEA0ynO3u05OfUkSVaMk72kw
         UnBWs9drExjDFYNPBWO/vH9L1ObIi5iR6FUMo8xP/1/JO1EQLP9/Wrh0a4qKmgtUF17f
         0JeZbugCdbGYUEuLzDV5xwRSAUW7SdkzhgooQajNvyp9aOIYBvB50p/aXDjeXQ7C89ea
         +NNnWSHFXUEnpU4jw0A5N8rCkP5GYSropdv24vKNPaLKH/v6mOBW3BMayJm5mSTUPgq1
         iGmi61VAcXNSGVn/HPfcwNqXVMVielit2UAFA6NTOs8HhMblxYwCGx03hyZWoochpKkQ
         j22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880616; x=1722485416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abMZUNvcjtluULe7Vf10wtd/LJtynKXkPZEsuxsYfu4=;
        b=w6mE1G0sIEOyzfWVM4nItiwA2jF+j/VxKVsoQ/gnQDaLb7RwDBhwWZvq/T09UptuCE
         9ThQVL+Y6AGinMHy+SvVXXF4kyjvfgmuJpW1LQrafG/sx6EvYcpP1bqFP5cn4vRqKxtk
         TOpsapOnIfRalRCUXpY9U/PX/jRMBRVu3rRuhIT2LVUIkWgKQr3bwEMy9ZWmqMHGiD8R
         B7VkD04dtg7NJga68/Wh9W4RRNf5MVeRWZku+u0ERLIUBNfApkhofTqPKKgehr1+bvw3
         xh0Aj2AC3OKgI4mmvZqOPQbi8jtj5crWwoRw+IrsTfbUeMEnaEPhEoMmudltNWacMWGo
         RzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRRPvNBHxyD0fPxHDj3fSybEU2iLI1/rr4cckaNDwU2ksix22AF7Ui+FZjy1W3QfDp24HtrzwDbjc0e+JaNeQms1ZS+D+ugLai
X-Gm-Message-State: AOJu0Yw4ZB6DmzkqfnHEA7d7DkbTpvIQ0sxpmmH6hSHqO9OpRPWzp50x
	GyuPMkd/e1oSIaTu/x2r8MrfkS9QhwVa2m8qcZ8uF1ypQZFrRWCL9sg0lyKC+A==
X-Google-Smtp-Source: AGHT+IF829DUeKGTspPBEp77dSbSyhRwEH7BRdt35f1F0LPC42dhVWwXQbFWUNq3AlNNR9fpQh6zWw==
X-Received: by 2002:a05:6a21:3983:b0:1c3:fc87:3770 with SMTP id adf61e73a8af0-1c472ce5816mr2568955637.36.1721880616508;
        Wed, 24 Jul 2024 21:10:16 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1314sm324796b3a.6.2024.07.24.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:10:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:40:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org,
	paul.m.stillwell.jr@intel.com,
	Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Message-ID: <20240725041013.GB2317@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
 <20240724191030.GA806685@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724191030.GA806685@bhelgaas>

On Wed, Jul 24, 2024 at 02:10:30PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> > VMD does not support legacy interrupts for devices downstream from a
> > VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for these
> > devices to ensure we don't try to set up a legacy irq for them.
> 
> s/legacy interrupts/INTx/
> s/legacy irq/INTx/
> 
> > Note: This patch was proposed by Jim, I am trying to upstream it.
> > 
> > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index b33afb240601..a3b34a256e7f 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> >  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
> >  
> > +#if IS_ENABLED(CONFIG_VMD)
> > +/* 
> > + * VMD does not support legacy interrupts for downstream devices.
> > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
> > + * doesn't try to configure a legacy irq.
> 
> s/legacy interrupts/INTx/
> s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> 
> > + */
> > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > +{
> > +	if (is_vmd(dev->bus))
> > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_vmd_interrupt_line);
> 
> A quirk for every PCI device, even on systems without VMD, seems like
> kind of a clumsy way to deal with this.
> 
> Conceptually, I would expect a host bridge driver (VMD acts like a
> host bridge in this case) to know whether it supports INTx, and if the
> driver knows it doesn't support INTx or it has no _PRT or DT
> description of INTx routing to use, an attempt to configure INTx
> should just fail naturally.
> 
> I don't claim this is how host bridge drivers actually work; I just
> think it's the way they *should* work.
> 

Absolutely! This patch is fixing the issue in a wrong place. There are existing
DT based host bridge drivers that disable INTx due to lack of hardware
capability. The driver just need to nullify pci_host_bridge::map_irq callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

