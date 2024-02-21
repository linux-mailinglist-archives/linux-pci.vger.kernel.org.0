Return-Path: <linux-pci+bounces-3807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E424585D01B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 06:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706951F21468
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777493A1AC;
	Wed, 21 Feb 2024 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmxECABs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC73A8C2
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494446; cv=none; b=G7SMS6u7iQPSsszeLVlahujxJZWmn9T3y9M2nl7cj3sVBpey+L8FtV26qs0VzLyl2o7ouIdqmn3pBgYzJth/RvKqTSyEDEZJ4fClRj9KbL5yciaqDsUS+hB5fZayMk8tIE5HkG6xCdWVjZ9RBPaQI4QtmPQDxfhr0FF8vtg1lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494446; c=relaxed/simple;
	bh=oUGqJKRmyE73/OCUiJPX5/V32RtLxxP379p0zn9gIsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diqj6uTNpy0dcKeNp7JkEgd4hlWrGgyaakC1zzZB+7tluxvr4tZ8Hg6MYuOVrlxCjFjPfGm2vqt4C04MOEg5oRnbuYoHCmhJ95w+DiSy7FZh4kTxj8hW5VCBzNIghtkNroR7hUec4Rt/OnTiFT4MdUgvNKSKElUx5055dB8HcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmxECABs; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c049ccb623so3971824b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 21:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708494444; x=1709099244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HrXxqjXeQd7rGczyYWNx0WtVun71oLEsSY83BcY3BA=;
        b=EmxECABsqyRqQycpZ8pIij3gj2WnsKiPrEL0yeTHI/LFmrnQQSCvyKlsyyYkZA74lU
         duvgbIg2OrpBjIzomz7DCluEDH6XCy5pK+0745/wPiDfBKYSmPB4LFzt/GJuxw217XHW
         LYRG740kCE4Ru8ldh941qgYNO+HlfxrRN5BxajSltnHeOPWg7r11Hyrg5naOvjytkak5
         SzBTgRlckJ6is7tOi9a4Lik+A9i9B6VziUJHmOoMJEECBsDfPGzsQLV0Uzfi2O45XVNL
         GK26CoM8n0smNt4fYHVsMh2pRhg0F2fSr0OU1K34MsWGW7amgDmvE1K8i2gy3qXzy9+H
         KFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494444; x=1709099244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HrXxqjXeQd7rGczyYWNx0WtVun71oLEsSY83BcY3BA=;
        b=eh0ZBzk6QvU34ahy3BUiiSi+XcnjVf7zWu5HLQKWZuW8vOoGr+QqoYyPIWqLAMsyWU
         ZJC5uIZVWSI6utUd2ejCCSjQCXZ+Z5u12RP2LpgKh+ReQ6G0kfTCbPFps5NPL0DQ+R83
         idAqCPn6jVs2auNFaALDnrugXWLG35KIoYs0xWWDy9KGiUko36vpRofyD4CzbW9r101s
         EFA5eEbaQISbUl4DprrjyhoZfbqEjESJfdgQpup2vGFcjrxmaRuy4Y5xe+AKaJpPkcO3
         oP60X8h73jKpVr3cruxkH3cXgLzIdaodNYjLwOmVTd496xyQ3s+WOai/9FESmCh01m93
         7mHA==
X-Forwarded-Encrypted: i=1; AJvYcCXSa/Offro+JMxUy0C+42t7JfmxuSsDXLvzyHxD5p7usJVsBSa4uzRXnhxNb95IwDzsoBajKTywPZqWdycjpwXr2xP1DXHLGWFQ
X-Gm-Message-State: AOJu0YybNQphSITho0SvrPVpXskVN0hZBiUf0kzEhFf77SaoSTWsmFBz
	ffJxYa8PLDjoS5hbybT3eL5wiC86v/MNzXXVmCfiWANEEGvntHaWlWI5DDnmqw==
X-Google-Smtp-Source: AGHT+IE6bTUXwc2ur3mp18DxA20g1NkmZU5o+3eFkGmMHUaVolt8kiSQ7nb6Dok3oHjD3+2TbD6/1A==
X-Received: by 2002:a05:6870:3922:b0:21e:63b7:54a3 with SMTP id b34-20020a056870392200b0021e63b754a3mr14597870oap.29.1708494443586;
        Tue, 20 Feb 2024 21:47:23 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm7741851pgi.9.2024.02.20.21.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:47:22 -0800 (PST)
Date: Wed, 21 Feb 2024 11:17:14 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZdWOYuMoLclEoB1f@google.com>
References: <20240214053415.3360897-1-ajayagarwal@google.com>
 <20240214070842.GE4618@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214070842.GE4618@thinkpad>

On Wed, Feb 14, 2024 at 12:38:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 14, 2024 at 11:04:15AM +0530, Ajay Agarwal wrote:
> > There can be platforms that do not use/have 32-bit DMA addresses
> > but want to enumerate endpoints which support only 32-bit MSI
> > address. The current implementation of 32-bit IOVA allocation can
> > fail for such platforms, eventually leading to the probe failure.
> > 
> > If the vendor driver has already setup the MSI address using
> > some mechanism, use the same. This method can be used by the
> > platforms described above to support EPs they wish to. Such
> > drivers should set the DW_PCIE_CAP_MSI_DATA_SET flag.
> > 
> > Else, try to allocate a 32-bit IOVA. Additionally, if this
> > allocation also fails, attempt a 64-bit allocation for probe to
> > be successful. If the 64-bit MSI address is allocated, then the
> > EPs supporting 32-bit MSI address will not work.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v3:
> >  - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
> >  - Refactor the comments and print statements
> > 
> > Changelog since v2:
> >  - If the vendor driver has setup the msi_data, use the same
> > 
> > Changelog since v1:
> >  - Use reserved memory, if it exists, to setup the MSI data
> >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c  | 18 +++++++++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.h   |  1 +
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d5fc31f8345f..06ee2e5deebc 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -373,11 +373,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	 * peripheral PCIe devices may lack 64-bit message support. In
> >  	 * order not to miss MSI TLPs from those devices the MSI target
> >  	 * address has to be within the lowest 4GB.
> > +	 * Permit the platforms to override the MSI target address if they
> > +	 * have a free PCIe-bus memory specifically reserved for that. Such
> > +	 * platforms should set the 'DW_PCIE_CAP_MSI_DATA_SET' cap flag.
> >  	 *
> >  	 * Note until there is a better alternative found the reservation is
> >  	 * done by allocating from the artificially limited DMA-coherent
> >  	 * memory.
> >  	 */
> 
> Now the above comments are misplaced. Please move the comments related to
> setting coherent mask just above the dma_set_coherent_mask() API and keep the
> flag related comments here.
>
ACK. Will take care of this.

> > +	if (dw_pcie_cap_is(pci, MSI_DATA_SET))
> 
> Who is setting this flag? You should not add code when there are no in-kernel
> consumers.
>
ACK. I will remove this flag and only add the 64-bit address support via
this patch.

> > +		return 0;
> > +
> >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> >  	if (ret)
> >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > @@ -385,9 +391,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> >  					GFP_KERNEL);
> >  	if (!msi_vaddr) {
> > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > -		dw_pcie_free_msi(pp);
> > -		return -ENOMEM;
> > +		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
> 
> This is a duplicated error log.
> 
ACK. Will remove.

> > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> 
> Is there a guarantee that this will never fail?
> 
> - Mani
> 
ACK. No guarantee that this will succeed. Will fix in the next version.
> -- 
> மணிவண்ணன் சதாசிவம்

