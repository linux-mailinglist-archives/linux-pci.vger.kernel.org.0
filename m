Return-Path: <linux-pci+bounces-17243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C49D6CEE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 08:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06CAB2117B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F63D0D5;
	Sun, 24 Nov 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJqG9dYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74833FBB3
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732433569; cv=none; b=ah8u88p0CO+VBET1ML3pRMqyQMYQDF9VZ6LnqfvKxXuIwKxXtXrDDnP9EGl4pGW1WcabLIyB9oAk489o2e+JzVvE+sXIxx1l/jSl9QXr1FTUxqtz92oPWM8pO6o6y4QfbiiAGQg07s5wONYgdc4yAK4iCgIIRU00OavGwmRMZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732433569; c=relaxed/simple;
	bh=jg1trj8SIK0uw3/nGerieNHfGI/GQeoYk99nBhnMeCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbENzVVkTMdoQCbGF1FwBIpqf3wsu5WuY41Mwk8T9aFGJF3R31fQmaaatX1PWQpX/V9ax2saNlBzwT7mmcNdeLP7gYjtXuFyG/gaNG5R6Cso0x36D+nUi33rDDCpZhtFCrlkJjx17/6HVw9toB21nqZCW2YIg9IvqsvDm2CRRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJqG9dYu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724d8422dbaso2577315b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 23:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732433567; x=1733038367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HyV5xr4Ha7tQT940pOqmrtctl45RuXMP89TFFW03cOU=;
        b=LJqG9dYu0PU2DMKl0bZUKx5rAdymJguFuxSYM1lObK362atg+ubMtMkfgWs4FwUa2G
         AGuyJPqIAthEji2vtwjVdaw4E4SK/X+CLJIfrEEOP/PQFKVEkI1BfXMcZ+gBgxGAsrIE
         CUPq40GY0Y4FxvDLNJiD/69Ug4974MAtgJq2kgWxnODQtozLw8IpNjseKTe8ZfFI3Hyt
         q1rker+jvkuuHLBV9TRMuEeYUmX9An+n+fSgspRLTt7WMCwobckuDHd+hv3cX+24iiQy
         uWwfuiTYVVAyEHyzauw732hFN9lOLCTyXXkYdgPQyTxciDrXK+lvWimO8cPT0PST7i5d
         4mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732433567; x=1733038367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyV5xr4Ha7tQT940pOqmrtctl45RuXMP89TFFW03cOU=;
        b=RSoxJz35EP81PWMz0+epffoQanM+E7AaD6gSKtoNrBPSluVb8n2MQMIDWkOdRAkiiu
         YitYtlNMZlIau1sLZUXxtKdBV56LVpa2QUUat6P08Z/nuPSAAQN8UNvLsk8Hm502If/9
         ZLwV6OmzgTqLPAr6LQ7VFrjflbtTTxqMwEohn9iQWrPdc2sQBaA+Y6dhI8861Wi3zd+6
         Vb/1MVyLqhX/Tp8DS0Qi3HNhpM3we2y3Aoh7iPnTy13l5xGcUaH9c6oGvUmAlplGzPYu
         wHF9KuUZpjYPFdz1gujjiUX+F0pybiUgf066/P7nWkIO+OfGd8a9KrB4H+qdGqL1lW9F
         dyMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGhURX4B3ItgrNc2P5f6SjAKEk9y3CO3g6bi1LOnSZO5lMrpfyyABUZ3N/9LnoGPym5UV8G5dUJus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpO/+uOoI37yQT4ETeGxw+6u2iDIWwmgnPhkGxxoFCcDi5qGT
	AdJuSlFh5TYySragvkpHGXzg8OJ+/p0V9mmCnBbofnYvpF7vl13KOxS0QN2NoA==
X-Gm-Gg: ASbGncv4Ek8IOi/7wv4QxSoxOuYpBaa0qVTu5AmdhvA11aMvrWwxoPe13F0ga7CQdu/
	XoFjcUbpoYfspjOFL9pkXwpl0HB17Sl5onODK17canK9302lJPMe0WLF9z+TCbxw5txAW02a5h2
	IrJWnb0MO1eXAgfoIalKXbCWJdUFc0A+fXucqDaFVAmXaq286WDKsrFECOjbIV/xkvN4h+3u064
	j81x53CvJyL6v6IqI9TfeDu8SkWzyJIP8J3z9EEBE9ZqNL+sujBcdGFSt7Lat5aGw==
X-Google-Smtp-Source: AGHT+IH+PlSwlQjrB2gCDs+rD3Rjc8himwsAaIYeIcQh678cCt/hQCj5LyFfCLjmOQxDfzpEEgnsnw==
X-Received: by 2002:a05:6a00:21c9:b0:71e:14c:8d31 with SMTP id d2e1a72fcca58-724df6677a1mr11545467b3a.16.1732433567075;
        Sat, 23 Nov 2024 23:32:47 -0800 (PST)
Received: from thinkpad ([2409:40f2:100d:708e:8ced:6048:5b4d:7203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de55862esm4235213b3a.155.2024.11.23.23.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 23:32:46 -0800 (PST)
Date: Sun, 24 Nov 2024 13:02:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>

On Sat, Nov 16, 2024 at 09:40:43AM -0500, Frank Li wrote:
> Introduce the helper function pci_epf_align_addr() to adjust addresses

pci_epf_align_inbound_addr()?

> according to PCI BAR alignment requirements, converting addresses into base
> and offset values.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v7 to v8
> - change name to pci_epf_align_inbound_addr()
> - update comment said only need for memory, which not allocated by
> pci_epf_alloc_space().
> 
> change from v6 to v7
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 45 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             | 14 ++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 8fa2797d4169a..4dfc218ebe20b 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -464,6 +464,51 @@ struct pci_epf *pci_epf_create(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>  
> +/**
> + * pci_epf_align_inbound_addr() - Get base address and offset that match bar's

BAR's

> + *			  alignment requirement
> + * @epf: the EPF device
> + * @addr: the address of the memory
> + * @bar: the BAR number corresponding to map addr
> + * @base: return base address, which match BAR's alignment requirement, nothing
> + *	  return if NULL

Below, you are updating 'base' only if it is not NULL. Why would anyone call
this API with 'base' and 'offset' set to NULL?

> + * @off: return offset, nothing return if NULL
> + *
> + * Helper function to convert input 'addr' to base and offset, which match
> + * BAR's alignment requirement.
> + *
> + * The pci_epf_alloc_space() function already accounts for alignment. This is
> + * primarily intended for use with other memory regions not allocated by
> + * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
> + * address for a platform MSI controller.
> + */
> +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> +			       u64 addr, u64 *base, size_t *off)
> +{
> +	const struct pci_epc_features *epc_features;
> +	u64 align;
> +
> +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> +	if (!epc_features) {
> +		dev_err(&epf->dev, "epc_features not implemented\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	align = epc_features->align;
> +	align = align ? align : 128;
> +	if (epc_features->bar[bar].type == BAR_FIXED)
> +		align = max(epc_features->bar[bar].fixed_size, align);
> +
> +	if (base)
> +		*base = round_down(addr, align);
> +
> +	if (off)
> +		*off = addr & (align - 1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
> +
>  static void pci_epf_dev_release(struct device *dev)
>  {
>  	struct pci_epf *epf = to_pci_epf(dev);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 5374e6515ffa0..eff73ccb5e702 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -238,6 +238,20 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  enum pci_epc_interface_type type);
>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
> +
> +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> +			       u64 addr, u64 *base, size_t *off);
> +static inline int pci_epf_align_inbound_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> +						   u32 low, u32 high, u64 *base, size_t *off)

Why can't you just use pci_epf_align_inbound_addr() directly? Or the caller
could pass u64 address directly.

- Mani

> +{
> +	u64 addr = high;
> +
> +	addr <<= 32;
> +	addr |= low;
> +
> +	return pci_epf_align_inbound_addr(epf, bar, addr, base, off);
> +}
> +
>  int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

