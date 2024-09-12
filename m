Return-Path: <linux-pci+bounces-13123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8C976F09
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BEE1C23728
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9881865ED;
	Thu, 12 Sep 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EueBBxEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477A185939
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159647; cv=none; b=lCoVUskvYeWnkHvnq9udD9+VPrsCYcSRTjEUi9q47tKlb4Wuwk9VHdtTp7mg3pFMW3MdH/uSRtjntsCVBd87QHjeBBDfkBtGQKO0K3S4eEgidPpRuyqP3OJOorrYg/SUfffznW9xsgvueAN+IuOs8eii5ikrA8qqL/y9yq7eNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159647; c=relaxed/simple;
	bh=cpzqqczK+VQDrLRRb6t8i4RTnb38HixiKgUw9r8WGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJOGRAv246HBXXDniA5XO7kUlBaL6jQJB801GMSt4xD97uHEVFFKg0K/ypPlQBV8xWxViatR5VCIIiJWkAVcldorbe8jcmKnRAeQrFBdz6VXmcp98YIalT0MJiP1GSTiMDoC82GSAMcJUsr9WfbxqMtAR/7a+sBLSWnWTCRfQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EueBBxEj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71788bfe60eso926487b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726159645; x=1726764445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZJ689VHauRDIhXzcE/viOSNorg5JIFMK5kziPBMOwU=;
        b=EueBBxEjUl2aqEX9ECzt1cxvf5r5GlJEsvsKjaT8FSa7z5rPcl/HnhcefVdpe+BeHB
         qo5QeQmipIqlzdHncVqAhfWzv06z3Ot/5ubJJUYzyJ3WzdwTL+ZHpN/Dfga7rNAWgm1l
         IZAbtHvQyFAL4Y5ocY5L0t6L7Mpr8/ui/6QQtXO9jORL+ocNJ0jOUC7GMIv/Tk2w9FaU
         lt9eJd36k2+RSAt9bZeceHZYjpsSmytPg8NT4hYsMWuhEqkY2L1atzw/B28ixmA77JAM
         ynHMA62VhYkFuw6X1VgtHeUPIXJ3yBEU4IhrGiO/iz4JOIG6LS9g0BXZWcKAhyL7h/2b
         HJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159645; x=1726764445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZJ689VHauRDIhXzcE/viOSNorg5JIFMK5kziPBMOwU=;
        b=hby9OnZax26XxLf8C66To9qUPSl/nakLszjZSklgl5+jbzz91ynnYucNlfPqj8Zr3e
         oKuIt8HsQZ+0/R5ASF1fb5GKFQ+0Zu/U3URaOv9XuwaPB3/lxWr0QDZUo+VhPOcCsxgh
         z4KstDI0UzLYzSjxj3wL5sYYUzvgQG5OOa7wLA4AMXQJw4ldEpsCVzv9PeyfFEv/Mcr+
         sR0qp2h7/DJlUwx2jzxP2yAXLjbV72icWZ3S1Vquc1hroY68WYXx0zJwuNbczRZFk+o9
         VRkkZmN/47MzzN4CXEsktf7WgBWP/2997Y6+9biAPrjt2qWyeQSraDfnXGORMsUWRZS5
         PGXg==
X-Gm-Message-State: AOJu0YzgEx8T3TcNqjKxq1VPKVpYokgQsdsLEGmWqnkIe+PkEuXJl/J+
	rtnyJOUVnWIFkoT/JmrXu6Yn+VP/m9F37odUPMAU6O/9V/tHTQeqcpG+Yy6uD4cESZdg/gVByt4
	=
X-Google-Smtp-Source: AGHT+IGCZ0y1QtKqxL0q1TxEL0LWHYibDLnxUOHxeT22gVkFoYy1xMnFdPEVrZNckOj8n1/wVdxLxA==
X-Received: by 2002:a05:6a20:db0a:b0:1d0:3a28:d2ad with SMTP id adf61e73a8af0-1d03a28d330mr2878105637.33.1726159644877;
        Thu, 12 Sep 2024 09:47:24 -0700 (PDT)
Received: from thinkpad ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af477dfsm16331075ad.110.2024.09.12.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:47:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 22:17:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <20240912164716.qgng5yjpjbojkq76@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
 <20240912083100.000069bf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912083100.000069bf@linux.intel.com>

On Thu, Sep 12, 2024 at 08:31:00AM -0700, Nirmal Patel wrote:
> On Thu, 12 Sep 2024 20:06:57 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > On Thu, Aug 22, 2024 at 11:30:10AM -0700, Nirmal Patel wrote:
> > > On Thu, 22 Aug 2024 15:18:06 +0530
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >   
> > > > On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:  
> > > > > VMD does not support INTx for devices downstream from a VMD
> > > > > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > > > > devices under VMD to ensure other applications don't try to set
> > > > > up an INTx for them.
> > > > > 
> > > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>    
> > > > 
> > > > I shared a diff to put it in pci_assign_irq() and you said that
> > > > you were going to test it [1]. I don't see a reply to that and
> > > > now you came up with another approach.
> > > > 
> > > > What happened inbetween?  
> > > 
> > > Apologies, I did perform the tests and the patch worked fine.
> > > However, I was able to see lot of bridge devices had the register
> > > set to 0xFF and I didn't want to alter them.  
> > 
> > You should've either replied to my comment or mentioned it in the
> > changelog.
> > 
> > > Also pci_assign_irg would still set the
> > > interrupt line register to 0 with or without VMD. Since I didn't
> > > want to introduce issues for non-VMD setup, I decide to keep the
> > > change limited only to the VMD.
> > >   
> > 
> > Sorry no. SPDK usecase is not specific to VMD and so is the issue. So
> > this should be fixed in the PCI core as I proposed. What if another
> > bridge also wants to do the same?
> 
> Okay. Should I clear every device that doesn't have map_irq setup like
> you mentioned in your suggested patch or keep it to NVMe or devices
> with storage class code?
> 

For all the devices.

- Mani

> -nirmal
> > 
> > - Mani 
> > 
> > > -Nirmal  
> > > > 
> > > > - Mani
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/linux-pci/20240801115756.0000272e@linux.intel.com
> > > >   
> > > > > ---
> > > > > v2->v1: Change the execution from fixup.c to vmd.c
> > > > > ---
> > > > >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/vmd.c
> > > > > b/drivers/pci/controller/vmd.c index a726de0af011..2e9b99969b81
> > > > > 100644 --- a/drivers/pci/controller/vmd.c
> > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > @@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct
> > > > > pci_dev *pdev, void *userdata) return 0;
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * Some applications like SPDK reads PCI_INTERRUPT_LINE to
> > > > > decide
> > > > > + * whether INTx is enabled or not. Since VMD doesn't support
> > > > > INTx,
> > > > > + * write 0 to all NVMe devices under VMD.
> > > > > + */
> > > > > +static int vmd_clr_int_line_reg(struct pci_dev *dev, void
> > > > > *userdata) +{
> > > > > +	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
> > > > > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> > > > > 0);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long
> > > > > features) {
> > > > >  	struct pci_sysdata *sd = &vmd->sysdata;
> > > > > @@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev
> > > > > *vmd, unsigned long features) 
> > > > >  	pci_scan_child_bus(vmd->bus);
> > > > >  	vmd_domain_reset(vmd);
> > > > > +	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg,
> > > > > &features); 
> > > > >  	/* When Intel VMD is enabled, the OS does not discover
> > > > > the Root Ports
> > > > >  	 * owned by Intel VMD within the MMCFG space.
> > > > > pci_reset_bus() applies -- 
> > > > > 2.39.1
> > > > > 
> > > > >     
> > > >   
> > >   
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

