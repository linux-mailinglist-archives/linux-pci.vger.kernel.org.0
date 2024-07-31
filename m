Return-Path: <linux-pci+bounces-11031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD89424C1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A2B1C21227
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E714F70;
	Wed, 31 Jul 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9Hsfb4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1417557
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395267; cv=none; b=tF8pmd11mXfDAzwzQsMeVw6/BgcQKdr5KDCMAmBialnQf2Kgdt3epYB0HezEkyj7QslPikP15BJzb+OwOgy+cLpa2gRAe53IKL8NgPbkEsOIgpiFuz2LMGnHVnzT2EGE8JC3/8vpemdjfFVqhgp35EFpNJLZz3GGTbxuaMe4e8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395267; c=relaxed/simple;
	bh=tZY0sTkOgJiFYlD6wAAH/vhpb6b6H2KORObpPRp7fZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOQ05aSILCb+UoN12cOTciECeb9NAOtcC9dOTFSJUNVFZbgX+dYcF5B1txYGiKxldjg4m6qEi3XLQcQF3dW9h0GMgyVwGVOm7XLnMmjscn6wYXmCL6wQEAZ0cPzUYXiK8nU/h/sX1hzn2I5iMygZL9E/SdNQLFDNjuZ3ADLXD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9Hsfb4h; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710439ad77dso972328b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722395264; x=1723000064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwyoPMZxsNFKTFRkE6JH8wgDAmQgbfWEHLfDi/J7aQI=;
        b=D9Hsfb4h1sWrQ/QWSQBdLijCTyB+LeEVPO46wSeOE6t86GnkeFpWmP8t3TBzrzHP8f
         YBcVDB/Rg2vAMGm1eU7w/pmB4BzeQsWHChdhopqJaDKBVlAW+LeERnEanxsLdM5AhLjH
         wpqYQsU+NfBZX6+BAZjB7tw0WQGKPPf5skH0ibTco6hUgQuQI33WQec/MPR6mSZAMlq3
         5OwpbwjTxxaeZ1+T/t1/gfuzmYVddn8aRhz40T/kCtsgVTm0/FGwQxto5TJ97ICZR9jL
         r3Blju3Y6MCzy1q/dCePHn9+4c1vz8IpJL0aZkCZ+TlpKwKvZao5kf8TW+Tt7CiPKAyZ
         WquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395264; x=1723000064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwyoPMZxsNFKTFRkE6JH8wgDAmQgbfWEHLfDi/J7aQI=;
        b=sIWxMth4zCtk8otFgruXlKMQueVO76nBwO35nwhrNAbBS3q8gWKyddNXLYngGF8x/8
         xbQxVYJkW+uEPQZvwVMWIxz9+jZbXPWNzqjxA4oKz8A7d3RdL9n0zcMCfkgJyRVzTxS8
         3kKpLnURHvsCcZoq0LwyQ0zEhDI6brqmiUeKUzmpeK20g6pvJH4E0dOMp9MtI94Zc5Jd
         T2h1LohkxU3qLqI6U9wl/MghgeNkyv/GAin/xZBK+WnvSzrYoNYvahvNsDlMl+U8DgIw
         S5NdCIOwxabRxgyb7MmoadVn/d2vT1L6KW6YjF8tRymvCCa9fCIGXWwCsGaofW2zclAW
         +gQg==
X-Forwarded-Encrypted: i=1; AJvYcCVMBdDvYrOAhCa7KMhFYqABVKG45kvMTqgohqQTqWNAbIK8awN7M+v3loGFx2x74DEt/uwjDlQM/UETGya7rOGNkuy1bZ88piiR
X-Gm-Message-State: AOJu0YzdE7a79uhIznAyxFDFOZp6oG4s8zTAxq6ITlCYWb+Kwekq85ZO
	h5N8nKYctaOrajkRIUMBZRUm3HKT4xCiv1yl6E+stHcgCHqLucgT+e/MUp54sA==
X-Google-Smtp-Source: AGHT+IHN1wQLYqBUO/EYOhzqR2xCwSyhLaiBWcWWJvQUImT675lQovy5x4P+c/LWD8XAMjCdLBGgtA==
X-Received: by 2002:aa7:8881:0:b0:70b:1d77:730a with SMTP id d2e1a72fcca58-70ecedbdec2mr13076658b3a.28.1722395264419;
        Tue, 30 Jul 2024 20:07:44 -0700 (PDT)
Received: from thinkpad ([220.158.156.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812eaasm9097315b3a.105.2024.07.30.20.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:07:43 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:37:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	paul.m.stillwell.jr@intel.com,
	Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream devices
Message-ID: <20240731030739.GA2248@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
 <20240724191030.GA806685@bhelgaas>
 <20240725041013.GB2317@thinkpad>
 <20240729130859.00006a5a@linux.intel.com>
 <20240730052830.GA3122@thinkpad>
 <20240730105115.00004089@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730105115.00004089@linux.intel.com>

On Tue, Jul 30, 2024 at 10:51:15AM -0700, Nirmal Patel wrote:
> On Tue, 30 Jul 2024 10:58:30 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Mon, Jul 29, 2024 at 01:08:59PM -0700, Nirmal Patel wrote:
> > > On Thu, 25 Jul 2024 09:40:13 +0530
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >   
> > > > On Wed, Jul 24, 2024 at 02:10:30PM -0500, Bjorn Helgaas wrote:  
> > > > > On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> > > > >  
> > > > > > VMD does not support legacy interrupts for devices downstream
> > > > > > from a VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0
> > > > > > for these devices to ensure we don't try to set up a legacy
> > > > > > irq for them.    
> > > > > 
> > > > > s/legacy interrupts/INTx/
> > > > > s/legacy irq/INTx/
> > > > >     
> > > > > > Note: This patch was proposed by Jim, I am trying to upstream
> > > > > > it.
> > > > > > 
> > > > > > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > > > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > > > > ---
> > > > > >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > > > > index b33afb240601..a3b34a256e7f 100644
> > > > > > --- a/arch/x86/pci/fixup.c
> > > > > > +++ b/arch/x86/pci/fixup.c
> > > > > > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct
> > > > > > pci_dev *pdev)
> > > > > > DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL,
> > > > > > PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid); 
> > > > > > +#if IS_ENABLED(CONFIG_VMD)
> > > > > > +/* 
> > > > > > + * VMD does not support legacy interrupts for downstream
> > > > > > devices.
> > > > > > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to
> > > > > > ensure OS
> > > > > > + * doesn't try to configure a legacy irq.    
> > > > > 
> > > > > s/legacy interrupts/INTx/
> > > > > s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> > > > >     
> > > > > > + */
> > > > > > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > > > > > +{
> > > > > > +	if (is_vmd(dev->bus))
> > > > > > +		pci_write_config_byte(dev,
> > > > > > PCI_INTERRUPT_LINE, 0); +}
> > > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > > > > > quirk_vmd_interrupt_line);    
> > > > > 
> > > > > A quirk for every PCI device, even on systems without VMD, seems
> > > > > like kind of a clumsy way to deal with this.
> > > > > 
> > > > > Conceptually, I would expect a host bridge driver (VMD acts
> > > > > like a host bridge in this case) to know whether it supports
> > > > > INTx, and if the driver knows it doesn't support INTx or it has
> > > > > no _PRT or DT description of INTx routing to use, an attempt to
> > > > > configure INTx should just fail naturally.
> > > > > 
> > > > > I don't claim this is how host bridge drivers actually work; I
> > > > > just think it's the way they *should* work.
> > > > >     
> > > > 
> > > > Absolutely! This patch is fixing the issue in a wrong place. There
> > > > are existing DT based host bridge drivers that disable INTx due to
> > > > lack of hardware capability. The driver just need to nullify
> > > > pci_host_bridge::map_irq callback.
> > > > 
> > > > - Mani
> > > >   
> > > For VMD as a host bridge, pci_host_bridge::map_irq is null. Even all
> > > VMD rootports' PCI_INTERRUPT_LINE registers are set to 0.   
> > 
> > If map_irq is already NULL, then how INTx is being configured? In
> > your patch description:
> VMD uses MSIx.
> > 
> > "So initialize the PCI_INTERRUPT_LINE to 0 for these devices to
> > ensure we don't try to set up a legacy irq for them."
> > 
> > Who is 'we'? For sure the PCI core wouldn't set INTx in your case.
> > Does 'we' refer to device firmware?
> > 
> > >Since VMD
> > > doesn't explicitly set PCI_INTERRUPT_LINE register to 0 for all of
> > > its sub-devices (i.e. NVMe), if some NVMes has non-zero value set
> > > for PCI_INTERRUPT_LINE (i.e. 0xff) then some software like SPDK can
> > > read it and make wrong assumption about INTx support.
> > >   
> > 
> > Is this statement is true (I haven't heard of before), then don't we
> > need to set PCI_INTERRUPT_LINE to 0 for all devices irrespective of
> > host bridge? 
> Since VMD doesn't support legacy interrupt, BIOS sets
> PCI_INTERRUPT_LINE registers to 0 for all of the VMD rootports but
> not the NVMes'.
> 
> According to PCIe base specs, "Values in this register are
> programmed by system software and are system architecture specific.
> The Function itself does not use this value; rather the value in this
> register is used by device drivers and operating systems."
> 
> We had an issue raised on us sometime back because some SSDs have 0xff
> (i.e. Samsung) set to these registers by firmware and SPDK was reading
> them when SSDs were behind VMD which led them to believe VMD had INTx
> support enabled. After some testing, it made more sense to clear these
> registers for all of the VMD owned devices.
> 

This is a valuable information that should've been present in the patch
description. Now I can understand the intention of your patch. Previously I
couldn't.

> > 
> > > Based Bjorn's and your suggestion, it might be better if VMD sets
> > > PCI_INTERRUPT_LINE register for all of its sub-devices during VMD
> > > enumeration.
> > >   
> > 
> > What about hotplug devices?
> That is a good question and because of that I thought of putting the
> fix in fixup.c. But I am open to your suggestion since fixup is not the
> right place.
> 

How about the below change?

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 4555630be9ec..140df1138f14 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -147,6 +147,13 @@ void pci_assign_irq(struct pci_dev *dev)
        struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
 
        if (!(hbrg->map_irq)) {
+               /*
+                * Some userspace applications like SPDK reads
+                * PCI_INTERRUPT_LINE to decide whether INTx is enabled or not.
+                * So write 0 to make sure they understand that INTx is disabled
+                * for the device.
+                */
+               pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
                pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
                return;
        }


So this sets PCI_INTERRUPT_LINE to 0 for _all_ devices that don't support INTx.
As per your explanation above, the issue you are seeing is not just applicable
to VMD, but for all devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

