Return-Path: <linux-pci+bounces-8626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D63D904B57
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAC81C237BA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00913C68C;
	Wed, 12 Jun 2024 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2Z8aUp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5B127B56
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172477; cv=none; b=GHHoIpruAp+Im1lGijtPow7EgaJhSst4Uu1yZLSgE95gLBDpXNgBrrAH/OzhCxHwaWfBOe1vjoxJMvFTCc1DjQKf4HrrKDU8n4JyTN6WlSJHKbX83V9qrfiGuBQwsi3pkexXOvMWsAsaK8bPepvdS3AVnCPAS4h0NBORqwexX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172477; c=relaxed/simple;
	bh=p3V+r4eTX+b17LbIYAZ33TI24TABi5QRAEjkylSHESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez7kqgKwus3QlUhau+0ZeyvDvJajlgbKdon6hhQQTNB0eTxkwJY6Ft6AZ+I9baPXWtCA8iQ6i9dVUW0WEj8mJCJud/NxKFkxH497hYcN/YltMjxdYTPnFMEX6rQYKt+gxmcHD0I7T8evDr/jYmIzcjW23EdUN1htlWnC3FDmJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2Z8aUp2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-704261a1f67so2021446b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718172475; x=1718777275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBmOsw1bfVsNjSsKCMK3J3k3M8ekr9N9VL8ewqUbACY=;
        b=N2Z8aUp2DOdS9cZVjAzmACMrKxMBtvVBQj7Y73riSRmccEGW8cPhXfjOaNNy37Uxw7
         omfiTd1w0h5K8+l8p12uF8bBbIJqmvCdW2HT7jjN4/hF1ENn+cGQdZFnHiqFDJ7r8p3p
         jGTHc0qwac5jAYzT5aEOVB8p7+uwglyx9lCDReF5L16bbfA1t/1sydYCCLyJYwCvFi9a
         15Um6ejKcW7WImdgXpmpaaXS99xx5GppPw1K4gYiO1fbGgBAUkty1n3TU/IM02x/9A3X
         k014monFDY6YyoQ6OFelzlE+sqHFado6+s7QRcVwed3+/LSemm36RRT3qVGcZv7ZjYEr
         ca6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172475; x=1718777275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBmOsw1bfVsNjSsKCMK3J3k3M8ekr9N9VL8ewqUbACY=;
        b=AkxFMPDR6LvyMBICCH4dUHpWIiaxI5qwNJAmjM5p+kH7O3Te1uyjn0avEGaASimuTj
         C+h2XAYZMFFD1weFP0zTvf/pPXmwQtllhzZTDr+nv3YOXLi5xOIJGQrBH76GjesX+2jc
         boEku5R0IJ87PCK4L4nB8+b+n3Wp/WPK/DQfLgrNImfD7nXr+VIp/9KDJqo3K76hpYzo
         CDxtVrn4fbFSUeANHhGSfX4FsbI1dCv4yDlEVbr4xVU7ZBJJofFGuQAukBvGe4NdoWTP
         cN/TSYs9egwVOS6UTyqq4kf5jiVOf3ZycQThjzky+EN18kjx7+TaV94cZVCPXIY1H3Bv
         TOBg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Cm99HWXAn8HDPDbSLAaOmPWUdGvxvuGWUPNu8Uli7ff18lOOlxkPFVK3e5WMRcnFi/cwkTQzixB2N9vKeJWESItR9urWxHBQ
X-Gm-Message-State: AOJu0YzLgrSOEx9HgDcLPF2vj279pCzTeZPfM1hJIdtafyhRrgY46keU
	JSpPasjpZRGd94Ji71LENfqFmPGJEzEt4wEAc2IC7Vrf4Qqm842iX6GVPOSbHw==
X-Google-Smtp-Source: AGHT+IEJqwSDFWnHoCDgwjtRI4fQuwpzPLDFyM+BHqr+Eca6LJXLhmW+9jq8EqZUoMuW7EHmdA8d7Q==
X-Received: by 2002:a05:6a20:9144:b0:1b2:cf6c:d5a4 with SMTP id adf61e73a8af0-1b8a9c510a2mr1011052637.61.1718172474686;
        Tue, 11 Jun 2024 23:07:54 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd372bb6sm9511608b3a.20.2024.06.11.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:07:54 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:37:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
	fancer.lancer@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
	code@tyhicks.com, apais@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, okaya@kernel.org,
	srivatsa@csail.mit.edu, tballasi@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: Re: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Message-ID: <20240612060743.GE2645@thinkpad>
References: <20240610235048.319266-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610235048.319266-1-shyamsaini@linux.microsoft.com>

On Mon, Jun 10, 2024 at 04:50:48PM -0700, Shyam Saini wrote:

Subject should be 'PCI: dwc: ...'

> Before this change, the dwc PCIe driver configures only 1 ATU region,
> which is sufficient for the devices with PCIe memory <= 4GB. However,
> the driver probe fails when device uses more than 4GB of pcie memory.
> 

Something is not clear... This commit message implies that the driver used to
work on your hardware (you haven't mentioned which one it is) and broken by the
commit from Sergey.

As per Sergey's commit, we auto detect the dw_pcie::region_limit. If the IP is <
4.60, then the limit is 4G, otherwise depends on CX_ATU_MAX_REGION_SIZE set in
hw.

So if your IP is < 4.60, you cannot map > 4GB of outbound memory anyway. But if
it is > 4.60, you shouldn't see the failure that you reported for > 4G space
(well you can see the failure if the limit is less than the region size). In the
previous thread you mentioned that dw_pcie::region_limit is set to 4G. So how
come your driver was working previously?

PS: When reporting issue like this, please add info about your hardware also
(platform, controller driver used etc...).

- Mani

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
>  		if (ret) {
>  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
>  				entry->res);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

