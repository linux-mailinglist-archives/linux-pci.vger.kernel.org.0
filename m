Return-Path: <linux-pci+bounces-17390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74839DA2A8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85891167D1C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA1149C69;
	Wed, 27 Nov 2024 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZxZjZ+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7313BAC6
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691058; cv=none; b=fyWJSNN7GS9YNTCl+wPopyslkC0ECmYpD5vkyxxaKi8oi9XMIqse+t5TJj8iXOcOr2GQyWbb77H/VK/7PdhhUWWOsEv+uU0IhOxFyvdCqMy+0tFeQ5yKWeSunCR4HhE6PtCfMhEXI48QoUF5rwwMQiG1kL1vP2VR9+m4wABvFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691058; c=relaxed/simple;
	bh=oB42DWoNBmxQi+XTnwmIBj4DXET7I/0X6nQnilb0z5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck1yMJmuuQj+zgITvvJqdrBnYgGhX0DVtSqNZTblDs4EI3sezKfi8nuyp21IMyVeTOdKIBylEYJwwa3YhHOKARgfWMH0tth31XnyE5AsFoUFQTOxd3xF6efwZneEzi/hWf6D7sBAlSkeePLRyoVie7FESt5BSlRY+MxKFHgz8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZxZjZ+P; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso370127a12.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732691055; x=1733295855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+7cqC93ldGO+cb7flErzYvb2BfLdG9bDrzU0pHXqbY=;
        b=gZxZjZ+PK72d0msQ1n8tBmntq8WIih1iTdLBtQGclcdrVeOCyse+FHEzzo8AqzIZns
         188eATjJitwZhgTMPgU0VaLJzmX8YiBK+LFtAL3O8yuBBKUfiArJCYy+uihOUMskzfCN
         4emgOSdO7OtsZyq2ULEVJ04l8OdmUmEmXK2k/T9xRbQERserxvvuaMVVFDqI5F6qJhe6
         QAKYWAxD4TaNMaUFWZuneN1tyuLjbij4UFEJvkUqFQZf06ogMFRszFtA+Lp+z/XGhqq3
         4LTntkTos7mlJqKktXi1lv+UWOZ+AZ2MwHPc0TjktkvisL9KDl+/JrnVeA89rNgYjzwc
         MzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691055; x=1733295855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+7cqC93ldGO+cb7flErzYvb2BfLdG9bDrzU0pHXqbY=;
        b=nJYiQDc2hS6qe/X9LTn2CzKt2ScBn81N5QynGjYCAmVs4S1ARHCDq0aehk2A0nlEfm
         N8D9pRdyOXP5MU9mam1B21bGHBfqOYnVt6SDy8VWGTBfoPtrEqzJOe3RrzbZ7HWmxnpL
         MrfiOkQFUmVeTvk0YsZ5Tc+itFVLzBQw3ce42FyWkha2DbHo/I8m1QvbplvBtqSkm62Z
         jXHlpqMEi2pOhvfS2K0quWKdPdlXIP2k9xJ67QVBZ5GZhlZzgiuDKUCz53abrOv4rXUe
         mwdmC6iOmUqlcsA/a/74sC56GNgqa3xORmSMzMwCAYC+GNZJ8nuCdwbXFbZ6gTaLFqSU
         Teag==
X-Forwarded-Encrypted: i=1; AJvYcCV0lyjdJNSGhp79TchdfyJYvNeO5oXwmRbFEx6KiHCHNSgqL7MYVj1k4SBhVmcpgDWUE7FbY+8tQ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qQgMQ6AAwJNXhCliJymPfVfemVwcrYq32QCtsJrg9pR2hnfy
	MByC1fjuK4BrpeXOx3iN3UhFF/zyKzbI4oD2OWhHyIW6dry6+/PCqiMLTDCs9g==
X-Gm-Gg: ASbGncsggURdTDCdfk56/bOom45KaPHzTg5JwBXuRMQgD18sgJI1o8pVjabKeG397xe
	Vm3f64jkex2oYtRDfBRdd7aU0kUuygCM8T3fa5NJElsdQnoa7kjTFgicWajfBVGpF7oo4irl9qU
	P4PpRj+yLYsApJSnJntsdy2QAlrSrJu8IRv56USZzO+tw0Gz7gXc9b/nCCaDn1LKbPweCKcIENc
	/5lso3KqAO2IM3P+w6mtndtSku54VHMzwWFPvejaj0KbUzc30xBd7u8JqU5
X-Google-Smtp-Source: AGHT+IF3oeZLRQG9iC0esbapOV06M/7F3mzG7W4nMQTb9ieu0DJrPc/68hM2Ig2e8qKWsb5GMTfdPw==
X-Received: by 2002:a05:6a00:2d93:b0:724:f8fd:f154 with SMTP id d2e1a72fcca58-7252fbf5ee8mr2735016b3a.10.1732691055527;
        Tue, 26 Nov 2024 23:04:15 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724dea69e96sm9501319b3a.73.2024.11.26.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:04:15 -0800 (PST)
Date: Wed, 27 Nov 2024 12:34:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <20241127070407.ggv55du25mlbcpb4@thinkpad>
References: <20241122115709.2949703-7-cassel@kernel.org>
 <20241122115709.2949703-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122115709.2949703-8-cassel@kernel.org>

On Fri, Nov 22, 2024 at 12:57:10PM +0100, Niklas Cassel wrote:
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> If we do not write the BAR_MASK before writing the iATU registers, we are
> relying the reset value of the BAR_MASK being larger than the requested
> size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> dependent.
> 
> Thus, if the first set_bar() call requests a size that is larger than the
> reset value of the BAR_MASK, the iATU will try to write to read-only bits,
> which will cause the iATU to end up redirecting to a physical address that
> is different from the address that was intended.
> 
> Thus, we should always write the iATU registers after writing the BAR_MASK.
> 
> Since set_bar() supports dynamically changing the physical address of a
> BAR, this change is slightly bigger than a single line change.
> 
> While at it, add comments which clarifies the support for dynamically
> changing the physical address of a BAR. (Which was previously missing.)
> 

This is not strictly relevant to this patch, so should be separate.

> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

LGTM! This patch should only have the iATU config change and should be
backported also. 

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 46 ++++++++++++++-----
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 507e40bd18c8..34d60142ffb5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,19 +222,30 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -
> -	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -		type = PCIE_ATU_TYPE_MEM;
> -	else
> -		type = PCIE_ATU_TYPE_IO;
> +	/*
> +	 * Certain EPF drivers dynamically change the physical address of a BAR
> +	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host).
> +	 */
> +	if (ep->epf_bar[bar]) {
> +		/*
> +		 * We can only dynamically change a BAR if the new configuration
> +		 * doesn't fundamentally differ from the existing configuration.
> +		 */
> +		if (ep->epf_bar[bar]->barno != bar ||
> +		    ep->epf_bar[bar]->size != size ||
> +		    ep->epf_bar[bar]->flags != flags)
> +			return -EINVAL;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> -	if (ret)
> -		return ret;
> +		/*
> +		 * When dynamically changing a BAR, skip writing the BAR reg, as
> +		 * that would clear the BAR's PCI address assigned by the host.
> +		 */
> +		goto config_atu;
> +	}
>  
> -	if (ep->epf_bar[bar])
> -		return 0;
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -246,9 +257,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
>  	}
>  
> -	ep->epf_bar[bar] = epf_bar;
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +config_atu:
> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> +		type = PCIE_ATU_TYPE_MEM;
> +	else
> +		type = PCIE_ATU_TYPE_IO;
> +
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	if (ret)
> +		return ret;
> +
> +	ep->epf_bar[bar] = epf_bar;
> +
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

