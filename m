Return-Path: <linux-pci+bounces-20103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E46A1604B
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF071886937
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27341369B6;
	Sun, 19 Jan 2025 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cT9Y+yQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117E176AB5
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737263705; cv=none; b=luqsFfJYwcUYef4zbttL6zJnkKC3u46pL/oFNDbs5yBOVF4mWoJBU8P4mPY0prHSXLqHRMEz3ZSHu8OeXf2U0pGVLonTObZg30I4eHrlWpL+6iraVnwrEEIptd0R4YXVSTdKfzFgwoIkJUIHtchsbH5AP7dtEbIjC2mlJKHBSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737263705; c=relaxed/simple;
	bh=2Z45GvTJvxK6U658TMMQMsyn4j1q4xxHxt0dl27y+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFnd+Ihnz8q7wg9MQcGcuf5bMEvhiFD6ChmnpzZ9UY1OKBMDHEg4u2HxMbgRzWHGfVrBtxrSnM6mKibhm8KCytNOKeIWvEIOUKKilppuOuzzmf8msned/GHpWBL6ZDDlKECVTI9Gd/tcTekHYmSN9JgXS9XD2RVITDcR2rbaXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cT9Y+yQt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so5994327a91.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737263703; x=1737868503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qi3Sy7HRn8AKFIDjhshUgb9vs43N9el0e7NWUElQl/0=;
        b=cT9Y+yQt7Ld8eVqvgezMkyFKrIERxV/S6725+/UO+jLffFT41iz9YBdPaiEc4X5/o5
         DmyfMP5+yOlYGi3Miyom0Ucxnplj0Ri+2hdlAfS+UQmnRdrU91+keVAs14J/eIoTN112
         BHZR63op+bQ5CLKd9tT6seEQoYM6x4FHTkvNmB4aya0B5xAPAiVxXMZB5Msneoz23TpO
         ov4ph9eESGaqunndgnHMNit2uR3yLgHdnyMy429AQLPf2iEbKjb5ZhxjBmmGNdGm81tx
         byjQKREKpS+wG0rPlhtyPoDpyyxQn0+BU/U9hEfVTJcYqNnsZNCbEajKIK4/kOMJB+Hp
         vhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737263703; x=1737868503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi3Sy7HRn8AKFIDjhshUgb9vs43N9el0e7NWUElQl/0=;
        b=coWf+3S0Vpb0ExXy1q42RKJjdQPrtxLyxbLUQppdoeTr9GrmWVyadNdU/pSOLlLrPO
         HKYe5DKDR+a3r1HL3PtaJc5VS1ZI6UNkKC9r1MYh+j6fnwptThEeRGW7zTQjCuvcOJ+g
         MChsEdeNhHTqR+jfL2kcZJ8vkjOpYz1+cpWw2547FUZRie8jtbn56esEXenkjylKJAcG
         KnA+k274/rw5hGyEypZGTNil2TKRfccS1rbbaP4+6z8H7wbm3C4+xEO+6py/NqgjfP8I
         2MXqrAK75mfShBoieC+CGJybALXgXLQ5N1EF1vCS+pNclfGRSOndJqqA4f6HaXc80dhC
         tX2g==
X-Forwarded-Encrypted: i=1; AJvYcCWNvej6dx9qOZ9hX2RgVbIA19W4BahhJR27oDh8aimDW5TqAJ27grnhdh6gy/SG9h6FMCPFhO9+TKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtyCW1MrGLVpzBobIgLvXCVY57Esk/T4X6SMuzzcF1xsKYGTO
	ckTnDyPkMBu7die86VN4lfIS3r6RaEN6iZVfLCGi2tQk14RW6+n3MSyjR7Z1UQ==
X-Gm-Gg: ASbGncvuakE6Jh9MAaxT+7n9Fcp9VMdo6l86GyLF1ovjuVDxL+nKqKP+KctyJpyUM6j
	BV5KruYJhVnRDzhrgHkWWDYyzgGX7THv6D78n52GRvFTKyK27lcE1FAOlRNA3t64GACK3R0eqbY
	nLol6a5G3oC25s49e2atGpYA1XXeryM/u4voyQT7QJ8+k/URvLA2zi4eK3Kvb143QBzmwy5ZfV0
	QAdWEut/QaCY+A+sk+FXQHz3naXIi9Esg+NtjPFWi0GNv4du9lr+K8jUAAqQWFs3CroJWyw4Wg7
	6gnMfg==
X-Google-Smtp-Source: AGHT+IGZN5CZEfTEBeBQYdURl0oNEab8SuIK9gBxj27Qk5BfX+NZ6fMk+FojLLG4sGaNkdQtxei2WQ==
X-Received: by 2002:a05:6a00:2914:b0:71e:4cff:2654 with SMTP id d2e1a72fcca58-72dafa00359mr10681430b3a.6.1737263703226;
        Sat, 18 Jan 2025 21:15:03 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabac5a46sm4684875b3a.177.2025.01.18.21.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:15:02 -0800 (PST)
Date: Sun, 19 Jan 2025 10:44:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: endpoint: Add BAR type BAR_RESIZABLE
Message-ID: <20250119051455.r47zqiegom3o4olr@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-9-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:32AM +0100, Niklas Cassel wrote:
> A resizable BAR is different from a normal BAR in a few ways:
> -The minimum size of a resizable BAR is 1 MB.
> -Each BAR that is resizable has a Capability and Control register in the
>  Resizable BAR Capability structure.
> 
> These registers contain the supported sizes and the currently selected
> size of a resizable BAR.
> 
> The supported sizes is a bitmap of the supported sizes. The selected size
> is a single value that is equal to one of the supported sizes.
> 
> A resizable BAR thus has to be configured differently than a
> BAR_PROGRAMMABLE BAR, which usually sets the BAR size/mask in a vendor
> specific way.
> 
> The PCI endpoint framework currently does not support resizable BARs.
> 
> Add a BAR type BAR_RESIZABLE, so that an EPC driver can support resizable
> BARs properly.
> 
> Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
> the EPC driver how it wants to configure the BAR.
> 
> struct pci_epf_bar only has a single size struct member.
> 
> This means that an EPC driver will only be able to set a single supported
> size. This is perfectly fine, as we do not need the complexity of allowing
> a host to change the size of the BAR. If someone ever wants to support
> resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
> future.
> 
> With these changes, an EPC driver will be able to support resizable BARs
> (we intentionally only support a single supported resizable BAR size).

Again, this is a bit of ambiguity. Even with these changes, an EPC driver
wouldn't be able to support resizable BARs which by the concept mean that the
host would be able to resize the BARs dynamically. Even though you are writing
the limitation in brackets, I think this sentence needs to be reworded.

> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 ++++
>  include/linux/pci-epc.h             | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 50bc2892a36c..394395c7f8de 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -274,6 +274,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> +		size = SZ_1M;
> +
>  	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
>  		if (size > bar_fixed_size) {
>  			dev_err(&epf->dev,
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index e818e3fdcded..e9d5ed23914f 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -188,11 +188,14 @@ struct pci_epc {
>   * enum pci_epc_bar_type - configurability of endpoint BAR
>   * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
>   * @BAR_FIXED: The BAR mask is fixed by the hardware.
> + * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.

> + *                 An EPC driver can currently only set a single supported size.

Could you please add 'NOTE' or 'TODO' so that this doesn't miss when a proper
resizable BAR functionality added later?

- Mani

>   * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
>   */
>  enum pci_epc_bar_type {
>  	BAR_PROGRAMMABLE = 0,
>  	BAR_FIXED,
> +	BAR_RESIZABLE,
>  	BAR_RESERVED,
>  };
>  
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

