Return-Path: <linux-pci+bounces-2068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9182B474
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EDA286DAB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EF52F83;
	Thu, 11 Jan 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6z/V6Io"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC93A1BE
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso2469324a12.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704996148; x=1705600948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUCOtH2n97Hz0BIML6TxuTZ5JzlgVY5dhEjVoTSm1xA=;
        b=z6z/V6Io13JOEEZdBJfNHtbJ4+lTbq3R8+0KAsT+Iq8aX7H9BOHJnGvrWTwLzCHQ06
         qe/nJcKoykQ6sXFEdcA1Jdw3YoJAzIwYXFEcW5Eb3h7Ou2PUitwAGr0VgpuPu8SsAA+m
         Lx+pPIKLRXrLdqg7nNsTK8eYxdAPDbbFcjnx8jF67z26NLzU8a83N8vPEMsj7USRhrFU
         6wy/qlJRHaoel3F5Ln+nrPMoDTr/872/TGtAedTuMI9Wr3OuXUf6Mzv3+xnj2Gltqueu
         mrpFfS09axjJ7sXTlz5CoiKeOh16X3VzS8X81ru9JYy6NrYSnEGrr4u53fhaEPoay6cl
         i75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704996148; x=1705600948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUCOtH2n97Hz0BIML6TxuTZ5JzlgVY5dhEjVoTSm1xA=;
        b=LHGH0RLbFo/g9eN/wu2lJ9ehPB3V0XQMNaMVzfZeUJTFAoL+nfnjikfDLyWDeSkSlo
         Izs2MHZr2hGjoklHSCiecxr+rYPZtPgXhBxXfTYbLT3PEBaVJzUr8sWtcCdyZDX19vHe
         yReaoXU4V5KccnrTRTTeXUASUS3/fIWtNxm4pVkxPhJ4/3O4RjkNU3eIq9nlsp4iUAkA
         ptVYtpTD2hlX02abMH6VyeKR5pbuQsK9QTOTyZjTz++pJXbNOAXyIRelIfuQLxzhLZ2/
         fvYMgBRYnsbuHTGlgEFvGvYOur+fMZze1cYXRFDNDPNixQBbP29LADB97GCdFXDYilBd
         RuOw==
X-Gm-Message-State: AOJu0YzB++Aoz6cvd52+Qn+DWjNx9j/LPx9SI8FZ5LPXxWssXuGvwk/S
	/oY9malcoH9Kl5aynP7zdMbySr52NWv/
X-Google-Smtp-Source: AGHT+IHDjYbtlhhtXjts8IwQNaGvhbSFE46SidbUF0P1YlRIsmIR0dVqvteCf/ns8IiGqaTcP/Obcg==
X-Received: by 2002:a17:90b:368b:b0:28c:cfd8:92d0 with SMTP id mj11-20020a17090b368b00b0028ccfd892d0mr151069pjb.31.1704996147942;
        Thu, 11 Jan 2024 10:02:27 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id bb7-20020a170902bc8700b001d4e765f5efsm1425937plb.110.2024.01.11.10.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:02:27 -0800 (PST)
Date: Thu, 11 Jan 2024 23:32:18 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: William McVicker <willmcvicker@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZaAtKqj45i3DNfiK@google.com>
References: <20240111042103.392939-1-ajayagarwal@google.com>
 <ZaAne_KeJaOYnBcu@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaAne_KeJaOYnBcu@google.com>

On Thu, Jan 11, 2024 at 09:38:03AM -0800, William McVicker wrote:
> Hi Ajay,
> 
> Thanks for sending the patch!
> 
> On 01/11/2024, Ajay Agarwal wrote:
> > There can be platforms that do not use/have 32-bit DMA addresses
> > but want to enumerate endpoints which support only 32-bit MSI
> > address. The current implementation of 32-bit IOVA allocation can
> > fail for such platforms, eventually leading to the probe failure.
> > 
> > If there is a memory region reserved for the pci->dev, pick up
> > the MSI data from this region. This can be used by the platforms
> > described above.
> > 
> > Else, if the memory region is not reserved, try to allocate a
> > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > address is allocated, then the EPs supporting 32-bit MSI address
> > will not work.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v1:
> >  - Use reserved memory, if it exists, to setup the MSI data
> >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >  2 files changed, 39 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 7991f0e179b2..8c7c77b49ca8 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	u64 *msi_vaddr;
> >  	int ret;
> >  	u32 ctrl, num_ctrls;
> > +	struct device_node *np;
> > +	struct resource r;
> >  
> >  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> >  		pp->irq_mask[ctrl] = ~0;
> > @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	 * order not to miss MSI TLPs from those devices the MSI target
> >  	 * address has to be within the lowest 4GB.
> >  	 *
> > -	 * Note until there is a better alternative found the reservation is
> > -	 * done by allocating from the artificially limited DMA-coherent
> > -	 * memory.
> > +	 * Check if there is memory region reserved for this device. If yes,
> > +	 * pick up the msi_data from this region. This will be helpful for
> > +	 * platforms that do not use/have 32-bit DMA addresses but want to use
> > +	 * endpoints which support only 32-bit MSI address.
> > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > +	 * supporting 32-bit MSI address will not work.
> >  	 */
> > -	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> > +	if (np) {
> > +		ret = of_address_to_resource(np, 0, &r);
> > +		if (ret) {
> > +			dev_err(dev, "No memory address assigned to the region\n");
> > +			return ret;
> > +		}
> >  
> > -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > -					GFP_KERNEL);
> > -	if (!msi_vaddr) {
> > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > -		dw_pcie_free_msi(pp);
> > -		return -ENOMEM;
> > +		pp->msi_data = r.start;
> > +	} else {
> > +		dev_dbg(dev, "No %s specified\n", "memory-region");
> > +		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > +		if (ret)
> > +			dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > +
> > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +						GFP_KERNEL);
> > +		if (!msi_vaddr) {
> > +			dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > +			dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > +			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +							GFP_KERNEL);
> > +		}
> > +
> > +		if (!msi_vaddr) {
> > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > +			dw_pcie_free_msi(pp);
> > +			return -ENOMEM;
> > +		}
> 
> Should we just put this second if-check inside the above fallback?
>
Yeah, we can do that. Will fix it in the next version after waiting for
comments from others.
> >  	}
> >  
> >  	return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 55ff76e3d384..c85cf4d56e98 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -317,6 +317,7 @@ struct dw_pcie_rp {
> >  	phys_addr_t		io_bus_addr;
> >  	u32			io_size;
> >  	int			irq;
> > +	u8			coherent_dma_bits;
> >  	const struct dw_pcie_host_ops *ops;
> >  	int			msi_irq[MAX_MSI_CTRLS];
> >  	struct irq_domain	*irq_domain;
> 
> Looks like this is a lingering change? Please drop.
> 
Sorry about that. Will remove in the next version.
> Thanks,
> Will
> 
> > -- 
> > 2.43.0.275.g3460e3d667-goog
> > 

