Return-Path: <linux-pci+bounces-6355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C08A86B8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072C4286B12
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBA14036F;
	Wed, 17 Apr 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSMym2Cj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628638DD3
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365548; cv=none; b=hNsYndlgfbzDoaOS+W5gl5xqmeZEdUIuozocr0Jq7NHCuPrcSQUtE3LwsaNBBNC7L8sIXkXn1zU0oZYPy/cT9cbCG07oIT8Me6lt3EyX/XAFH+xc+W+OPQoAKQKD2UvpsArTVb8tLYR3Ef4NLNGxldKOWS2skVzA6OPUSfIDXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365548; c=relaxed/simple;
	bh=6CbU8oZoZvfJQ4l7BQ0E7R8sd/rp6YJ97qBSOjVt0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTjE92dBb8F2LkBJ2hlzEnEtEjMDaFp60NV1VfjwdZln5TqvOxmLjiNEhs7JRrcmyaiK1/Sp8moVMOMlz3CaWfa3p4hTyeuNntE+o1fUjuorqpQkT6UT+bFMhvfklnE1Yjf3BPpqTyxdkaxs73xOQV75Zj7pv+Ox45UELOcgRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSMym2Cj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a52c544077so4181340a91.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713365546; x=1713970346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRcH7cubL16QjSGiD5EC34kxfaFUJ1HeGUtZLh460rs=;
        b=WSMym2CjTC9fso4XghQj6jYLfkG/j2ZLRDMnKSYWvcsWuWfkoGCKhDibsJkkhj2aGr
         Fn87/ZelIhCFxcw7BLJk8q0sk4+Lkqjb7ZYkpGr0kkTLYc+R3DFHauHnGhaXx8iOVDlO
         2O4KEkxyH9glPYBEbdNbjk4wzf5/Kv7+c0cTPBYDQTdTrTcaksYPhH0HAFCAwovl0u2v
         LfQjhdTn9Be4gJwlToiRrSXiHfcCPfVF9buDenW8UuG6UXIeOV/ap/WHHDfOOTxsUdot
         YkGewR9vn0Z7iiCjkPG4zs2fquzZqoVuEKKj2ozERfAOAyaaxQNqfCahY83LvSRakdpR
         FiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365546; x=1713970346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRcH7cubL16QjSGiD5EC34kxfaFUJ1HeGUtZLh460rs=;
        b=oG4j4asUMbv5QVzEs/rjQrWPrH/Qq+ta4q0ryj1UpqwkbPcvgMB+Xlr6c6i7O3p5Ib
         ssYaE8ahTZGxEdyLe/aW90g/P2PFG5vRTp1hi7qF7YxtNjdkp97kMymaKKln437bIwC7
         eQo0NFP436ZQ5nvHDs1YambI/Mp6JLgdic20zhgwzByxDhRIerlpoCNhbW5qfvrqbieh
         ZQ6AWKgpirGowbNP35Kh4AXLvzUQVmNghUIwYtInX1b4VVu3FVzglCRSt7lYRD+aamc8
         RkUv+GZ2W0MBmgWeDIPfyXbty7jatzBUlfJtjlB7ndRawFTIvxRtXuG0eNTbO/iekUQ2
         Ae7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9qpF20EubXOQn3m2XTJa3pUNdbq3LKtSyO/6YwI6pm0o5ZlDI9EexAqGPR+FUtdSzIJL4EEc/5YDhf+Qq7Nsmgg4oBZF6Tdvf
X-Gm-Message-State: AOJu0YyJ/1DGDrmmQXB9P7+OLbgM/WzZUqYa4uXX4oB6U3RTVpRItrno
	8EGEmTWe32Uy8L+A1m7HDkwrkGkfQC59CBDIhcTe0LwJmxBlh34tNQGthCUqWg==
X-Google-Smtp-Source: AGHT+IH4uiQblvN6+qvQcX3FzKjb/+STr6YBJm0netobGBM54Ggr0hc4wAhnknVts4R8UHLZsZKLEQ==
X-Received: by 2002:a17:90a:68c5:b0:2a5:d0cf:3ef with SMTP id q5-20020a17090a68c500b002a5d0cf03efmr14076350pjj.37.1713365545879;
        Wed, 17 Apr 2024 07:52:25 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b002a528a1f907sm1571527pjl.56.2024.04.17.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:52:25 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:22:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <20240417145204.GA15187@thinkpad>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
 <20240415-pme_msg-v6-5-56dad968ad3a@nxp.com>
 <20240417101944.GG3894@thinkpad>
 <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>

On Wed, Apr 17, 2024 at 10:38:04AM -0400, Frank Li wrote:
> On Wed, Apr 17, 2024 at 03:49:44PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 03:33:29PM -0400, Frank Li wrote:
> > > Instead of relying on the vendor specific implementations to send the
> > > PME_Turn_Off message, let's introduce a generic way of sending the message
> > > using the MSG TLP.
> > > 
> > > This is achieved by reserving a region for MSG TLP of size
> > > 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> > > host bridge. And then sending the PME_Turn_Off message during system
> > > suspend with the help of iATU.
> > > 
> > > The reserve space at end is a little bit better than alloc_resource()
> > > because the below reasons.
> > > - alloc_resource() will allocate space at begin of IORESOURCE_MEM window.
> > > There will be a hole when first Endpoint Device (EP) try to alloc a bigger
> > > space then 'region_align' size.
> > > - Keep EP device's IORESOURCE_MEM space unchange with/without this patch.
> > > 
> > 
> > I'd rewrite the above sentence as:
> > 
> > 'The reason for reserving the MSG TLP region at the end of the
> > IORESOURCE_MEM is to avoid generating holes in between. Because, when the region
> > is allocated using allocate_resource(), memory will be allocated from the start
> > of the window. Later, if memory gets allocated for an endpoint of size bigger
> > than 'region_align', there will be a hole between MSG TLP region and endpoint
> > memory.'
> > 
> > > It should be noted that this generic implementation is optional for the
> > > glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 3a9cb4be22ab2..5001cdf220123 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -398,6 +398,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	return 0;
> > >  }
> > >  
> > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct resource_entry *win;
> > > +	struct resource *res;
> > > +
> > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > +	if (win) {
> > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > +		if (!res)
> > > +			return;
> > > +
> > > +		/* Reserve last region_align block as message TLP space */
> > 
> > 		/*
> > 		 * Allocate MSG TLP region of size 'region_align' at the end of
> > 		 * the host bridge window.
> > 		 */
> > 
> > > +		res->start = win->res->end - pci->region_align + 1;
> > > +		res->end = win->res->end;
> > > +		res->name = "msg";
> > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > +
> > > +		if (!devm_request_resource(pci->dev, win->res, res))
> > > +			pp->msg_res = res;
> > > +		else
> > > +			devm_kfree(pci->dev, res);
> > 
> > You are explicitly freeing 'msg_res' everywhere. So either drop devm_ or rely
> > on devm to free the memory.
> > 
> > > +	}
> > > +}
> > > +
> > >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > @@ -484,6 +509,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_iatu_detect(pci);
> > >  
> > > +	/*
> > > +	 * Allocate the resource for MSG TLP before programming the iATU outbound window in
> > > +	 * dw_pcie_setup_rc(). Since the allocation depends on the value of 'region_align', this has
> > > +	 * to be done after dw_pcie_iatu_detect().
> > 
> > Please wrap the comments to 80 columns.
> 
> New code style is 100 columns. does comments still stick to 80 columns?
> 

That's only applicable for code and not comments. I also learned that some time
back.

- Mani

> > 
> > > +	 *
> > > +	 * Glue driver need set use_atu_msg before dw_pcie_host_init() if want MSG TLP feature.
> > 
> > How about,
> > 
> > 	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> > 	 * make use of the generic MSG TLP implementation.
> > 
> > > +	 */
> > > +	if (pp->use_atu_msg)
> > > +		dw_pcie_host_request_msg_tlp_res(pp);
> > > +
> > >  	ret = dw_pcie_edma_detect(pci);
> > >  	if (ret)
> > >  		goto err_free_msi;
> > > @@ -541,6 +576,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> > >  
> > >  	dw_pcie_edma_remove(pci);
> > >  
> > > +	if (pp->msg_res) {
> > > +		release_resource(pp->msg_res);
> > > +		devm_kfree(pci->dev, pp->msg_res);
> > > +	}
> > > +
> > >  	if (pp->has_msi_ctrl)
> > >  		dw_pcie_free_msi(pp);
> > >  
> > > @@ -702,6 +742,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		atu.pci_addr = entry->res->start - entry->offset;
> > >  		atu.size = resource_size(entry->res);
> > >  
> > > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> > 
> > How about,
> > 
> > 		/* Adjust iATU size if MSG TLP region was allocated before */
> > 		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > 			atu.size = resource_size(entry->res) -
> > 					resource_size(pp->msg_res);
> > 		else
> > 			atu.size = resource_size(entry->res);
> > 
> > > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > > +			atu.size -= resource_size(pp->msg_res);
> > > +
> > >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > >  		if (ret) {
> > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > @@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > >  			 pci->num_ob_windows);
> > >  
> > > +	pp->msg_atu_index = i;
> > > +
> > >  	i = 0;
> > >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > @@ -838,11 +884,48 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> > >  
> > > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> > 
> > No need of this comment.
> > 
> > > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > > +{
> > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > +	void __iomem *mem;
> > > +	int ret;
> > > +
> > > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > > +		return -EINVAL;
> > 
> > 		return -ENOSPC;
> > 
> > > +
> > > +	if (!pci->pp.msg_res)
> > > +		return -EINVAL;
> > 
> > 		return -ENOSPC;
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

