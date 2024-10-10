Return-Path: <linux-pci+bounces-14163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDB998025
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4279B2826C1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232291B5EBC;
	Thu, 10 Oct 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7yqGsbh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3D1A3BAD
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547806; cv=none; b=uxepY57FoTCpx22DxIhgYvX6vRZC5AeG9/VA0brlaq5bhGvJVgARf1bnldVzyqz3pApVOsRCjVogxQ5P+Eqa7/bW4ovvk8t6Cc9CbF9GCxwAlxGzHyO+ZdTg+okBoQae9bnsBi9pcewx45niuVlCZEzVEG7ug1BSeTuSEGXcv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547806; c=relaxed/simple;
	bh=g36zPfGHWbFIKy+xWCvY4miH9KOz74X7KhYaStb3iD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLLwUNYqKaqCYcXoxfr1QOsvrRX0It4MxoyHSIHOSKoeF9qVRV2w9kKGh532CYcbIJyL6UFUAyZJjcFYx3As7TMuWQKHLlxoGV7lY4g0sEynLrAQtR6xKmed3ottodVJ+rMClnKc/tlZM40uO4qQkkDd9Zr8u+QieKqHC3tHw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7yqGsbh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b7259be6fso6754825ad.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728547803; x=1729152603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmKcXJUPy3GJb83o8RShQJdgCDtW41p1Q1FD22fOmPo=;
        b=A7yqGsbhWsWn4a1tYxZaggIeZg6TJtKagj8x7LtTYfMzFSgmRZI8cA9bzEkmhqD/hH
         /LUH6ehQyLwwsS44MKFL56G27eck8nQ7J+1jV7ID0jQ0TxT36Rb0GmGG6ITVbKsHoA1k
         3jCHv3jZvlSaCzozi8etdEZByEcT907Z2bslqurvhJ+oTreM+Oz51iflvgTVwYJUBUCg
         J1h4x4ZWDjaX/j/vkoBWIXhHOllVQIyi+1MUslBTlzPWTGtEvHLSEDH5N6/zirrHMVr1
         geeM5DIHfKO9XYKhZUqTYby4pKXhgtHQKw63+JRxmfsKidyNPbKf54ZwhabXF5t7CRgU
         628Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728547803; x=1729152603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmKcXJUPy3GJb83o8RShQJdgCDtW41p1Q1FD22fOmPo=;
        b=IIQcUZP+41ql1s8my8dOiXMZp+UvQdbnYQ55lgAL9Hct/rPhPO8Vzzjt1nvZXsPKZN
         a5LRLZDw6xF0k4peFM+GrbkmXIbZSe0WgsqbwdcxFf5abSExxginxMRSBKcA1xFZq2mn
         k8mTxgV/PRuVC6UjevQ5e1tHqdB4RQ8s6mi96xNeNSqaqIiH3TDrw4XT/5ne9Av59c8H
         1TC/8x+XwssIlp52JQFgo+Myih+xvcYRPQ2KbfzhTxnyZQsH/ztIjoJsh2lMBAEQAQ/h
         83c+5z00bjrnS/qQcHgpGDRqs8iyKJUK541i+CY3qIaNfEuHUyiF+tH3xpCNF+IdgiEQ
         lHKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQqCGv/XbVeYjHOgwfWIBHwle8j3V/QdMHU2nvcxthPOhjDjBfRAvYPYF4u8bzVBVw2e+4Lc9c/TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3As+DD1rq7yyfdoooRvb+vzl4hIaKPkUfhBOB8fqUhnKfz9iW
	xwv2fcW69NDu5KifuOAm+ryksydQO3c+IdbwleorSWb9bqhPclcoMNbaQ25zkw==
X-Google-Smtp-Source: AGHT+IEhI0oEHMpvi/Ep8rZT37rMBupuv4nErdDsje5nS4NaslF2zKOn4ZDc5nilfaVzbMlP4HVL5w==
X-Received: by 2002:a17:903:124b:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-20c63746cafmr77627535ad.32.1728547802706;
        Thu, 10 Oct 2024 01:10:02 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33d6sm5162345ad.33.2024.10.10.01.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:10:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:39:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 07/12] PCI: rockchip-ep: Refactor
 rockchip_pcie_ep_probe() MSI-X hiding
Message-ID: <20241010080956.z3cw2mxxlgrjafhs@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-8-dlemoal@kernel.org>
 <20241010072512.f7e4kdqcfe5okcvg@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010072512.f7e4kdqcfe5okcvg@thinkpad>

On Thu, Oct 10, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:13PM +0900, Damien Le Moal wrote:
> > Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
> > to its own function, rockchip_pcie_ep_hide_msix_cap(). No functional
> > changes.
> > 
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Btw, can someone from Rockchip confirm if this hiding is necessary for all the
> SoCs? It looks to me like an SoC quirk.
> 
> - Mani
> 
> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 54 +++++++++++++----------
> >  1 file changed, 30 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index 523e9cdfd241..7a1798fcc2ad 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -581,6 +581,34 @@ static void rockchip_pcie_ep_release_resources(struct rockchip_pcie_ep *ep)
> >  	pci_epc_mem_exit(ep->epc);
> >  }
> >  
> > +static void rockchip_pcie_ep_hide_msix_cap(struct rockchip_pcie *rockchip)

Perhaps a better name would be rockchip_pcie_disable_broken_msix()? As the
function essentially disables MSIx which is broken. Again, it'd be good to know
if this applies to all SoCs or just a few.

- Mani

> > +{
> > +	u32 cfg_msi, cfg_msix_cp;
> > +
> > +	/*
> > +	 * MSI-X is not supported but the controller still advertises the MSI-X
> > +	 * capability by default, which can lead to the Root Complex side
> > +	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
> > +	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
> > +	 * the next pointer from the MSI-X entry and set that in the MSI
> > +	 * capability entry (which is the previous entry). This way the MSI-X
> > +	 * entry is skipped (left out of the linked-list) and not advertised.
> > +	 */
> > +	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> > +				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> > +
> > +	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
> > +
> > +	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> > +					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
> > +					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
> > +
> > +	cfg_msi |= cfg_msix_cp;
> > +
> > +	rockchip_pcie_write(rockchip, cfg_msi,
> > +			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> > +}
> > +
> >  static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -588,7 +616,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >  	struct rockchip_pcie *rockchip;
> >  	struct pci_epc *epc;
> >  	int err;
> > -	u32 cfg_msi, cfg_msix_cp;
> >  
> >  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> >  	if (!ep)
> > @@ -619,6 +646,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >  	if (err)
> >  		goto err_disable_clocks;
> >  
> > +	rockchip_pcie_ep_hide_msix_cap(rockchip);
> > +
> >  	/* Establish the link automatically */
> >  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> >  			    PCIE_CLIENT_CONFIG);
> > @@ -626,29 +655,6 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> >  	/* Only enable function 0 by default */
> >  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
> >  
> > -	/*
> > -	 * MSI-X is not supported but the controller still advertises the MSI-X
> > -	 * capability by default, which can lead to the Root Complex side
> > -	 * allocating MSI-X vectors which cannot be used. Avoid this by skipping
> > -	 * the MSI-X capability entry in the PCIe capabilities linked-list: get
> > -	 * the next pointer from the MSI-X entry and set that in the MSI
> > -	 * capability entry (which is the previous entry). This way the MSI-X
> > -	 * entry is skipped (left out of the linked-list) and not advertised.
> > -	 */
> > -	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> > -				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> > -
> > -	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
> > -
> > -	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> > -					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
> > -					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
> > -
> > -	cfg_msi |= cfg_msix_cp;
> > -
> > -	rockchip_pcie_write(rockchip, cfg_msi,
> > -			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> > -
> >  	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
> >  			    PCIE_CLIENT_CONFIG);
> >  
> > -- 
> > 2.46.2
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

