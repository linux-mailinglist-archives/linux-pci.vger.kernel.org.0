Return-Path: <linux-pci+bounces-20104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE9A1604C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD83A67CA
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE88366;
	Sun, 19 Jan 2025 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omorN85R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F13D561
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737263752; cv=none; b=dnMk+69byi6161OSMAK8ZGAbyttKGWBD5fq/4BcygJ8+HuKLDQGXJV/WVM5N1N2LBi53M16E7mS6kmlgISODjDUni5/DjbeMs3cBBObms/3dDdqVhTKNSKLjhyVORt8oS47ExUO4FIR7WONfH2UBZfiImGYRdHimrd8T7TtUk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737263752; c=relaxed/simple;
	bh=xgreCRXPr/b6WpLvdRum4fnCaTZ0FPhoxjZNtDlaI5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDYDYLGAl8m8aI9ByK9Uv06+q8O7kZv+0QvX+4tMd4BIICkeNpDsoUFvuFv9YNOqjwTwjvCeJ4yxUNzkeGwtUoN8by9JGnEzImhEF8hm+RyuGLOZGtvuIBq6BgHx5bLwOGCfu/5CzxsqGFZFwAYO7sDw98c60k0G4VkmAiNbvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omorN85R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216395e151bso45837915ad.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737263750; x=1737868550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/7Is4FJ+SCwXyrLW23Uj1KmY2m0oqgrKr+J/DruA2hE=;
        b=omorN85RMvs9QTqOhQnmRJn3Kh/dwtFy0+GwKOnJ1iI/b/ie5omp58NIJnpRuGmSGX
         ORXkYFyQvLv/Sn5YeO3D5ZsQQgy3Yck9kaPFIzuJBoUDjweNyEUz5EGV7711RoJc2PEJ
         2sqfQIcbdaP5E6x/jGzpMcq60G9GhJZcespEF/vP8vaLz+2sFEnVpFexxMMG3BFmSvE/
         aWGHKnuCH44hh7gWxW5Cz195O2cu+WWjvGgRH+HQRJUqVgrGrygn/+Jw6BZO2ActpEqE
         uh2ItA80S0EDLIBAFmYMG2J8Qj0ak+lOsHn5u9WQ411LkH/tGpBqgGnnOs5TAYrzCnN+
         kmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737263750; x=1737868550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7Is4FJ+SCwXyrLW23Uj1KmY2m0oqgrKr+J/DruA2hE=;
        b=Y5VnpckZJz5vPT7GSjPVlLhI4y2whDD1RefkvdZ4uKkpB/DCdy5oexuRtu1Qo3kdab
         xRlAYH2MKBWLMxxUOM144k7iYlyu7atRQ+M13ik/xe8/TWymknpjltmHQIWX7VPvi4C8
         TIrs3xjld2PaQVA/DWtwWxzWFYtqeooBQJp6tOBcADWgDXolgwqj4LYtSx1buJ/yvPbB
         6RFZegw/gN1A3oVLoKQOWIW/DcykazXHVi0LqgjWnRG9TJSHye+KHONBZ4j7EHeAKjtH
         LdLG9zoVybjg6RZ8FN8l3Sv++uv97XyOfPlboxAyVqxjLih1G36gVlUz9L7N386hJF0B
         hxEw==
X-Forwarded-Encrypted: i=1; AJvYcCXm+edq60lpVEeN6pdFThkr0mxHk8XE7fv7X20kss3tX6pma1vXjITAGQasHlDI3PkREGGQl4dH3cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjcYgqYqeZOOywsNXjck4Tx6WEqZFEliWH5AEmVZ/vMvFBkRX
	hzsUraiyLMlG0hOAWlvZ56C4HZkSjKTk60FZ5CivxmtQojXN/fR2mkSvxdvSHZXCp7+tpK3niwA
	=
X-Gm-Gg: ASbGncs2nms7SgVGCG1DbiXVBnLVpB1ppAU9rJTT/TC6ebpPijy3svyiOV/R7s/iPq/
	q38VyVAoNlMhi8Ls399ipXe5v451PhczgpO3gUQy+uWBQcir2POoeKPdTAt2idVXD6pe1sHWPY+
	w+aNx8M3kaXTV5Mn2339RkNhgpgRsRej5mtBSr2uCYRISVVMmUxEBKRuXk/ZawGx1cyrJVUbQXG
	0rrEbnHxYtog2KzeaCmdLZqlgFrIlunkt8NrTxU8t8Bx8lJM8r1j5s88nGn96VfVPlTFkfZviRZ
	nfT0eg==
X-Google-Smtp-Source: AGHT+IFUsNQssW8v6H+iwGVMSMFs0RWgq+Uljei8K/hZRVMXe3CvPfBKfOZktRYTnO2BJutYjvftcA==
X-Received: by 2002:a17:902:cecf:b0:216:5cc8:44e7 with SMTP id d9443c01a7336-21bf0d31063mr259695815ad.25.1737263750159;
        Sat, 18 Jan 2025 21:15:50 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d42b8d6sm39324265ad.253.2025.01.18.21.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:15:49 -0800 (PST)
Date: Sun, 19 Jan 2025 10:45:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/6] PCI: dwc: ep: Move
 dw_pcie_ep_find_ext_capability()
Message-ID: <20250119051538.mqss2plmf7oh65d2@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-10-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:33AM +0100, Niklas Cassel wrote:
> Move dw_pcie_ep_find_ext_capability() so that it is located next to
> dw_pcie_ep_find_capability().
> 
> Additionally, a follow-up commit requires this to be defined earlier
> in order to avoid a forward declaration.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 8e07d432e74f..6b494781da42 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -102,6 +102,24 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
>  }
>  
> +static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> +{
> +	u32 header;
> +	int pos = PCI_CFG_SPACE_SIZE;
> +
> +	while (pos) {
> +		header = dw_pcie_readl_dbi(pci, pos);
> +		if (PCI_EXT_CAP_ID(header) == cap)
> +			return pos;
> +
> +		pos = PCI_EXT_CAP_NEXT(header);
> +		if (!pos)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -690,24 +708,6 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>  
> -static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> -{
> -	u32 header;
> -	int pos = PCI_CFG_SPACE_SIZE;
> -
> -	while (pos) {
> -		header = dw_pcie_readl_dbi(pci, pos);
> -		if (PCI_EXT_CAP_ID(header) == cap)
> -			return pos;
> -
> -		pos = PCI_EXT_CAP_NEXT(header);
> -		if (!pos)
> -			break;
> -	}
> -
> -	return 0;
> -}
> -
>  static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  {
>  	unsigned int offset;
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

