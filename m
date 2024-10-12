Return-Path: <linux-pci+bounces-14392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DAE99B4A0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79A5B24B22
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC64178388;
	Sat, 12 Oct 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a38T72JD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B547F69
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733989; cv=none; b=iLxRokNDoaAPssDiKoniLxSmN2dfMqIAOnr1QobYk179zP3rUdMGNMGcgimAEoYfSyysUSN1KfwnSUGatCmn7xDXGLUFjyalZxahjBvU/u1ElXw0ieFIK1CbgdPvXv2jglCd9PlwpfFQsQ2/3EnhOsOcCb8Hmc3IaEoavSEEIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733989; c=relaxed/simple;
	bh=oN18I3h0HgkeH0PluuS0A3/IqfqqvXOqj3P5RnxnDuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO04JGnLyv0lAseDdP8a+aJBP1bCbB/Eg4BeLfjh2gX/7EfCdRpiLWKOl4+RMPiHTrd1vScRoKfTC4hL4cFUEFMZGEPmlSHM2HSy8Rq7YFnxjbyeSFdwxCI+CK3K4TMZz9A62eW2Kjk1kqJBhHf9pc4H1P8R7lwP3IDmLiSdDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a38T72JD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2195526a12.2
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728733987; x=1729338787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWBMeEmhnQSq2pows0xyjo5ydXPpJJ6SKZvOAjLS5kc=;
        b=a38T72JDERChesJgHB+xEcioNPSsEUmMYHkuE2x9ma3nUp5ElizuwRBrGQI4h4Q94V
         iAZA1+DYrbmf1070f7RdVJaNqtEu0RLHLKTr/gkPTD8mG8dobdpHL9Cz11jd6gUcJPs4
         Qt5CZBUiuExD6e//Sr0RKQnNpahOjlN6SuW+Yfjt5EpOzzQUzqKYAGrSgTg9tG+2JC7O
         OvKEeig6W0A3urUXcUaW0oUm59TYHpKEpmQHLstZ2BNN+Ek+rrYwFl/l4TvLYGvJ44eE
         TamMXO93lms+TXJuae/82rlK1UfMK8axHLiL1CmgGJNvGsUZrQwMIBIAnMV3ayVrGGBX
         YL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733987; x=1729338787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWBMeEmhnQSq2pows0xyjo5ydXPpJJ6SKZvOAjLS5kc=;
        b=Mahi2/YhLSeJGvkxfGsgRQ2IXF/MWHuYVFpnfUC3e2MloBKIxKC9P6e6fp1X1IzuY6
         HJRS7O2jeePBYdwiTCKAAlk2e3Id3rfjncxvViYtyRr5JBgv9S+SiISmwiDHmcB0UMDe
         7J4PYL64L2CJ0Rj0jGcfN/FYyQBa7KIwk3C+hcOCdYzEk/r0fkYM6a4kfu5WY/l56cuB
         3MaTSGG7tNdvjrA+W0vtRTrO0GbThGn3l/P8wkycGIWNlni9Ae/CUhyjWhiQa3zec9fB
         3l5CCvuIxSXAsRnZBQdrBKxWbRMEOKxgPOhA6+kebiLfjzMW6wymKDRIbE1GWGWgknH0
         pe2g==
X-Forwarded-Encrypted: i=1; AJvYcCX2t7TDrFtEg4EsStQOixUOFa8d4Ia/+raRCxH8wVPuFWhuHyIZwG49V6JV5JyWoio5R9AMd3hl1fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wk8WCXYQudSSMGz2zD4b3/JIp+2745CSV36CVZYO+0rQ6dHW
	j+I6aIemxfvRpSgjDdNFdgKoIkQ4yjVeR+5BP+C0igoMK1401busC5AlY1tipw==
X-Google-Smtp-Source: AGHT+IEZYLEfgwygcPrG4AcmqWy6K0anKdV2rxAW2RoAamjuDkw9xD73slMi/gnEZgCVCteXuksebQ==
X-Received: by 2002:a05:6a20:b803:b0:1d2:eaca:34ca with SMTP id adf61e73a8af0-1d8bcfb608fmr5766804637.42.1728733987517;
        Sat, 12 Oct 2024 04:53:07 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448f9542sm3763051a12.33.2024.10.12.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:53:06 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:23:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 6/6] PCI: dwc: endpoint: Implement the
 pci_epc_ops::align_addr() operation
Message-ID: <20241012115301.xz2dnfgejzwoh5pp@thinkpad>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012113246.95634-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012113246.95634-7-dlemoal@kernel.org>

On Sat, Oct 12, 2024 at 08:32:46PM +0900, Damien Le Moal wrote:
> The function dw_pcie_prog_outbound_atu() used to program outbound ATU
> entries for mapping RC PCI addresses to local CPU addresses does not
> allow PCI addresses that are not aligned to the value of region_align
> of struct dw_pcie. This value is determined from the iATU hardware
> registers during probing of the iATU (done by dw_pcie_iatu_detect()).
> This value is thus valid for all DWC PCIe controllers, and valid
> regardless of the hardware configuration used when synthesizing the
> DWC PCIe controller.
> 
> Implement the ->align_addr() endpoint controller operation to allow
> this mapping alignment to be transparently handled by endpoint function
> drivers through the function pci_epc_mem_map().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df..ad602b213ec4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> +static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
> +			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	phys_addr_t mask = pci->region_align - 1;
> +	size_t ofst = pci_addr & mask;
> +
> +	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
> +	*offset = ofst;
> +
> +	return pci_addr & ~mask;
> +}
> +
>  static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				  phys_addr_t addr)
>  {
> @@ -444,6 +458,7 @@ static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
>  	.clear_bar		= dw_pcie_ep_clear_bar,
> +	.align_addr		= dw_pcie_ep_align_addr,
>  	.map_addr		= dw_pcie_ep_map_addr,
>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>  	.set_msi		= dw_pcie_ep_set_msi,
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

