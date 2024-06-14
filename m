Return-Path: <linux-pci+bounces-8827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E25908B9F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9361F21231
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98D13BAC8;
	Fri, 14 Jun 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNDSYXdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B27E574
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367994; cv=none; b=rXZGRObjDXyQE0GPjem3ZGImlTrQ59tzVNK3mRGYX52jIGOeQzrTdB3e4MY+FQfFsq+kdyb25HI3C2XAvJuVIM2698q8HkGoYJnegAsoHSqY0/sGsy00Yzh8Q2guRzR+E/kVeTnu7Sml6AWZeBFngFhUSDoPIUIaV8DUuWBvgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367994; c=relaxed/simple;
	bh=J19t/DZdFPUrn1wDChEnYaslyX9pEn8ByZByC/uIDhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM7wcZRnSLWD/E+CK5E/tpTzyitqpYSH63GfHTAycRf8U2eFladUT2r9V/5IWx8BCTd3tUh4AmTqTTEWcAyuM0oiTrc7XB7soIn6bttZhxT+mniPa9WW4s6OQJZBDVSDJ5wC5Dm/W1+xu2o2zQ+ebmYRhQ6kAHJui2T6A9E3hI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNDSYXdk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso19278671fa.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718367990; x=1718972790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXrbNG2PlyKIQ2QE7DTZFRVkvh+DgqP6stJonJ6MK/8=;
        b=LNDSYXdk2QGhzXLxWWjSS6DcgNZ2Jhp8KA3O8Atplhq7rLpef9OmfHrF4yDmBNKU5q
         nTzfGrxaq5Ld7ZgdUIw/MWPdL+DyJbS5/kSxFv23KYAZ5rh4rpYgdmluNq1EQS3DSsRM
         y7QCKdRRgXT6XaJ/eKDgs3qrRBD9RFxvNNslIoOLWVtXNnyRSAzHOQU7GHCVKSKL+UeM
         lba7woMAq0ART6DHGFlceHGuEkrRzHX5TSik0Cxzf5sSpKO2jKktiRn4cSx37GEARp1C
         bs+fbRytq5sr8MlCu8XfUKCizcIWEXfxOp52zGASEwAvjQWNOTpswRj9nrP/ZyEK1cg8
         Yzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367990; x=1718972790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXrbNG2PlyKIQ2QE7DTZFRVkvh+DgqP6stJonJ6MK/8=;
        b=IKCgkdW65cuWLis7cl8Oen0qGvxCCbnxyfHS04HEgVjjO1NuHSTq/Zyacoyk2C1OtV
         +warHefOhD/92oiRAk2bRIZqg3DiTtw566DVK8uKWrGRiy2eHdG5XUKPTJlMb59hnOGp
         RIvbiTLk8ablRP+Sx2CYUqVaardxmjp3WhI20nY+nmzRGBA2plWuM3iX/SfEdBvlLUuU
         ZXdyiAk95zQjBLNGp4wYyYHYPJQJoLS5ESlOLdkkvAxi4Yvd9mhejyvuAD7+U/TJlSin
         V1sMi1JdqabgMWt1gTDUe95W9qi2092KGBH+VJT1OTnio7GbPJNnZ/avLU0DaQ8Ohg8G
         5uHA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vc1I4anYkA+2wBgm1xDDY/R6z6M+wD3hwGYfHJzGDNvaNbX9stJ6bQ0ZpdVl5iAWKyM8Kvr3u4ef9QjKG5v0u3tJa3+LAXxE
X-Gm-Message-State: AOJu0YwhL7UlK7Krp8l7ZwPIcDoZuNyhEFZzE/Xxm2Rbs/Z13q8jjrgY
	dcF7xZPFVjvGUKESxE8x1M774rTKOFzluu2kdJinIBWim2WvN9Zr
X-Google-Smtp-Source: AGHT+IHG11Ol7zqmVQRdjZuS8agnosesvN+USsxN6c4ByWYeWMsZrDV4HPQpCuDpKZmaaqiKwq7Z/A==
X-Received: by 2002:a2e:9c05:0:b0:2ec:1ad3:fb0a with SMTP id 38308e7fff4ca-2ec1ad3fc06mr7394631fa.43.1718367990098;
        Fri, 14 Jun 2024 05:26:30 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec079379casm4805751fa.124.2024.06.14.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:26:29 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:26:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, linux-pci@vger.kernel.org, code@tyhicks.com, 
	apais@linux.microsoft.com, bboscaccy@linux.microsoft.com, okaya@kernel.org, 
	srivatsa@csail.mit.edu, tballasi@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Message-ID: <rki6koi6mk4fjg7d37qidvcftrea4djaywswtsu3oop2sok4n7@ekhp4eid6jqg>
References: <20240610235048.319266-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610235048.319266-1-shyamsaini@linux.microsoft.com>

On Mon, Jun 10, 2024 at 04:50:48PM -0700, Shyam Saini wrote:
> Before this change, the dwc PCIe driver configures only 1 ATU region,
> which is sufficient for the devices with PCIe memory <= 4GB. However,
> the driver probe fails when device uses more than 4GB of pcie memory.
> 
> Fix this by configuring multiple ATU regions for the devices which
> use more than 4GB of PCIe memory.
> 
> Given each 4GB block of memory requires a new ATU region, the total
> number of ATU regions are calculated using the size of PCIe device
> tree node's MEM64 pref range size.
> 
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d15a5c2d5b48..bed0b189b6ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -652,6 +652,33 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> +static int dw_pcie_num_atu_regions(struct resource_entry *entry)
> +{
> +	return DIV_ROUND_UP(resource_size(entry->res), SZ_4G);
> +}
> +
> +static int dw_pcie_prog_outbound_atu_multi(struct dw_pcie *pci, int type,
> +						struct resource_entry *entry)
> +{
> +	int idx, ret, num_regions;
> +
> +	num_regions = dw_pcie_num_atu_regions(entry);
> +
> +	for (idx = 0; idx < num_regions; idx++) {
> +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, idx);
> +		ret = dw_pcie_prog_outbound_atu(pci, idx, PCIE_ATU_TYPE_MEM,
> +						entry->res->start,
> +						entry->res->start - entry->offset,
> +						resource_size(entry->res)/4);
> +
> +		if (ret)
> +			goto err;
> +	}
> +
> +err:
> +	return ret;
> +}
> +
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -682,10 +709,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		if (pci->num_ob_windows <= ++i)
>  			break;
>  
> -		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> -						entry->res->start,
> -						entry->res->start - entry->offset,
> -						resource_size(entry->res));
> +		if (resource_size(entry->res) > SZ_4G)
> +			ret = dw_pcie_prog_outbound_atu_multi(pci, PCIE_ATU_TYPE_MEM, entry);
> +		else
> +			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> +							entry->res->start,
> +							entry->res->start - entry->offset,
> +							resource_size(entry->res));

Sorry, but the change doesn't look correct.

First of all, you suggest to split up _all_ the PCIe ranges greater
than 4GB. As I already mentioned several times the DW PCIe controller
of v4.60a and younger may have the maximum limit address greater than
4GB. So the change is wrong for the modern IP-core which have the
CX_ATU_MAX_REGION_SIZE synthesis parameter set with a number greater
than 4GB.

Secondly the dw_pcie_iatu_setup() method is looping around all the
PCIe memory ranges and allocates the iATU regions one after another.
So should the dw_pcie_prog_outbound_atu_multi() allocated more than
one region, the second, third, etc iATU regions setup will be
overwritten with the subsequent PCIe memory ranges data.

Thirdly your dw_pcie_prog_outbound_atu_multi() initializes the iATU
regions starting from zero each time it's called. So each next call
will override the initialization performed in the framework of the
previous one.

AFAICS it's not that easy as it seemed at the first glance. One of the
possible solution is to fix the __dw_pcie_prog_outbound_atu() method
in a way so instead of failing on the
((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit))
conditional statement the method would initialize the requested region from
cpu_addr
up to
limit_addr = clamp(limit_addr, cpu_addr, cpu_addr | pci->region_limit)
and returned (limit_addr - cpu_addr + 1) from __dw_pcie_prog_outbound_atu().

The dw_pcie_prog_outbound_atu() caller shall check the returned value.
If it's negative then error happened. If the size is the same as the
requested one, then the memory window region was successfully
initialized. If the returned value is smaller than the requested one,
then the memory window only partly covers the requested region and the
next free outbound iATU region needs to be allocated and initialized.

Note 1. The suggested semantics need to be propagated to all the
dw_pcie_prog_outbound_atu() and dw_pcie_prog_ep_outbound_atu()
callers.

Note 2. The same procedure can be implemented for the inbound iATU
regions initialization procedure in dw_pcie_prog_inbound_atu(). The
difference is only in the untranslated address argument. In
dw_pcie_prog_inbound_atu() it's pci_addr. So the initialization would
be based on the PCI-address space from
pci_addr
up to
limit_addr = clamp(limit_addr, pci_addr, pci_addr | pci->region_limit)
with returning (limit_addr - pci_addr + 1).

-Serge(y)

>  		if (ret) {
>  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
>  				entry->res);
> -- 
> 2.34.1
> 

