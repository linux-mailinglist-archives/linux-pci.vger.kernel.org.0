Return-Path: <linux-pci+bounces-17394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FA9DA2E3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F160DB24185
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056D81AD7;
	Wed, 27 Nov 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6YYIeQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20114D433
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691634; cv=none; b=HRb+aeCbtDO9uDj+9c+EWd39Bd0CUMaBusoVFKoZDeNL3D0Rwi2FE+8DgkM0XbLxz8df/mn2EJHQ+BsWfkjcz2nx7UeJLPbbk41UHBnDkywlSTeFlqudQegu9ei9yQfTwJGiqH3Z09qX3bBIyfFXAZwmbKHNcfxFhWnNEVx4tYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691634; c=relaxed/simple;
	bh=8U0ohI6g4w+jxz7Lstovi22wqFL7bPWbOeirFG77e5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA2ieBxDejrm3bHyJoPUD+WLlxP38mMC27F6cNzeHNubtpVy2wDAYjgSMk3m6Jt/wQKmqKmzMz3+2fJt2RTfIP7b3XBbZ0tdFmkZc5vrS8Wth5YGPsLf/SxB7YrsjfxxTN/Env8JkU48BXBc+BFZEkS9YIfxOJ/CXez3hJmpCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i6YYIeQ+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251731d2b9so367247b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732691633; x=1733296433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KRWieA9cFXrLO8rw9soioO1WDvuUZgbcWMzVRCCp7c=;
        b=i6YYIeQ+A61P+Q3FQLYWj+9RcSaQzZ5H1j/Cw5HdxQK/G4bU6H1CRPk8XkAxhvJ4v9
         m5gVtC9PiheRf369p80M0jCk+b7wwKvl20NYOhqTjtzZsp+YJC/vuDb7BZ/qew0xGuh4
         UI0HU3LoozL1TpgiJA17yBO63PkStjdD9YVw44m6dJveC58htzyOFkRBTRFE+URix9Zt
         tz7aeUrl1LCe2hwgXb/6ZRuSlnq92W3TNIV2bbXlFPbZlbKH7FKzOp1GoHqjZPFDNQdh
         3iG88XBBh+iFDKUl7e3jupam6Ts42VBaL1J7UY7xfrh986MhqWYbQ38w/05MrhnZ9Jqj
         9+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691633; x=1733296433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KRWieA9cFXrLO8rw9soioO1WDvuUZgbcWMzVRCCp7c=;
        b=E47upqAiTsye411z+LuEO2d5kBwRa6BTGLaMqjCAmFtQXGVaNsBqlkMJuMzIIh+sxg
         rVhuHdo9shVq/H0oaNrFy1XewxmN3SdUaVTsofnzC7MZq6VXujzKCVBeyLJ1W3sNOkja
         OT7fZT/TG1hZhpIYsmg8spUx7ll60LQH4bX31tLj/Ig4Xwozl2slSgAtznOEqwM68D68
         zhvtv6w3H90ZdQgcPPg8aHU6ZHYBBS7Yl6VvNr5O6ILbaeqPGDXk6Z7eY2b7qqI7OGeQ
         TbYiSOayqhofNElF9Cn+FarIoJRD4YYg2b7+zIvN+lV3ZauBH7zzbxdHyTU8fT629Oj8
         ygHg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2mWrycSKHpNKVVoHHh2yKIii45vh6NBzyv9+3CxVkepLTTpz89xDg5m23aj2Y+ZLjC+F5OJiWI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnYxWUvvL9Ry+FT1b9JGe6blTATmLM3WPdkiyf3Xg74Ilna/y
	91e80+Ldrc1dlVeCG6kTFAN2TzKlq8BLm0sIbx96t/Tuszgyyli+uUu5tzGeEw==
X-Gm-Gg: ASbGncvkA6AekGjcVX86XcxLfUrpMMxcDLAISwyQ35oeomhqYYErecYqDeU8d5py8gB
	F0iVuqYUzG23hc1y2xFbBYhcilQ3mDMqQg50nxLPwSg8KwiYgpMPC+lIoFzsn/UJyzCEp5qHoWM
	3mzO5UXjysHnd9WVt1VaUs5t9G+0Lr2/Vz6Rk/h73JfU1z1ZBsxXeWNYoBoIgPXAzCfGrn0V4Ig
	jMtffHm6WcNsbgt75jep3HCpFrTMwga1NGGhvcRiYp/kJMX0mCjVDbzuhdk
X-Google-Smtp-Source: AGHT+IHvzXTNKasOfgF/xMa8tuWjgsqI7T2bO6jgeoJrjB222ILnRc9JJXpzLgCMBsgwfxAA4CzEIQ==
X-Received: by 2002:a05:6a00:228b:b0:724:d926:fbeb with SMTP id d2e1a72fcca58-7252f9b998fmr3161819b3a.0.1732691632709;
        Tue, 26 Nov 2024 23:13:52 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm9876506a12.39.2024.11.26.23.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:13:52 -0800 (PST)
Date: Wed, 27 Nov 2024 12:43:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/5] PCI: endpoint: Add size check for fixed size BARs
 in pci_epc_set_bar()
Message-ID: <20241127071347.jbchjvf3ketxrjes@thinkpad>
References: <20241122115709.2949703-7-cassel@kernel.org>
 <20241122115709.2949703-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122115709.2949703-11-cassel@kernel.org>

On Fri, Nov 22, 2024 at 12:57:13PM +0100, Niklas Cassel wrote:
> A BAR of type BAR_FIXED has a fixed BAR size (the size cannot be changed).
> 
> When using pci_epf_alloc_space() to allocate backing memory for a BAR,
> pci_epf_alloc_space() will always set the size to the fixed BAR size if
> the BAR type is BAR_FIXED (and will give an error if you the requested size
> is larger than the fixed BAR size).
> 
> However, some drivers might not call pci_epf_alloc_space() before calling
> pci_epc_set_bar(), so add a check in pci_epc_set_bar() to ensure that an
> EPF driver cannot set a size different from the fixed BAR size, if the BAR
> type is BAR_FIXED.
> 
> The pci_epc_function_is_valid() check is removed because this check is now
> done by pci_epc_get_features().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index bed7c7d1fe3c..c69c133701c9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -609,10 +609,17 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>  int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar)
>  {
> -	int ret;
> +	const struct pci_epc_features *epc_features;
> +	enum pci_barno bar = epf_bar->barno;
>  	int flags = epf_bar->flags;
> +	int ret;
>  
> -	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +	epc_features = pci_epc_get_features(epc, func_no, vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
> +
> +	if (epc_features->bar[bar].type == BAR_FIXED &&
> +	    (epc_features->bar[bar].fixed_size != epf_bar->size))
>  		return -EINVAL;
>  
>  	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

