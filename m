Return-Path: <linux-pci+bounces-17487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53E9DEF4A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 09:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDB9B21BC8
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32923146D57;
	Sat, 30 Nov 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3r45eFK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676051C6A3
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954374; cv=none; b=P1sgW4qqOftNKRr6yZqDPqaKVeRYLDcWpiIT3kuGqaiPT9iEzv8zytre13abwy6FIFUhrfX8dF5XALh2ur7xO3J0EVhH/oi9WzVzq7Nzja0Tf6kLBnWAwn5HQUpYEz3YNkButyBKzZv308i+f9hB78dkdATvB7hahx/tu8Jvzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954374; c=relaxed/simple;
	bh=OIHtBXdkWOwpiubtc3zpg5BHNakjxwv19TyLmcoFvx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMdj6JJ+33PehoUCS+8wa8yvYdxbWRBP39Xap3jn+92ihLXYDC4vi9YrR3XtO+F5FLZ6Mxh1ZoXeUtjuil+oI5yhlBAb0cZ20vQLQaHlq6xaXeT/NUpvg2thqDXoGYAJnUhdwt5Kh/dpmAqG9d0Jmjd3ahEoP62/tbh4Ca7orzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3r45eFK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-214f6ed9f17so23009365ad.1
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732954372; x=1733559172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMPVbGivyvevI+VJv0tQgtPO+LvKltTbKLDJeedtsaE=;
        b=S3r45eFKMGu+ETZU17rJbtYeYeAGzYZqLFIEe8LyNO3+Y1tVy3BYIXhcooUPWwtQzN
         7xaHWGdViq9DPZF7awfeqjv/6e5tGwHRcKhF6tdySMxLsJEA618RfDef5yx8ePV3b0HS
         jkfb9kgaZyJ2s6aE4o6EbL41EibCOdPT2oqQYV1/6Ihy+EwWc4R6RuYMaNfwApxVQJKk
         ABJqbCHXdFAQtheDZOW1l2OvclHVR5rBybyXQXRT7gcGBUYB9p4+qexVB5rrNacRybhZ
         rhmqiY0UNQBN4QN50kkkzKmf5PYXvhgEgyCU60HY4CtZLKhDklGdreK1E5CCH2XOoiV3
         52wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732954372; x=1733559172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMPVbGivyvevI+VJv0tQgtPO+LvKltTbKLDJeedtsaE=;
        b=HmGoATgglodEsFFLMsuEaD2CQXfg2FKiIYQTtWCZ4Qos6skZsqT0EtB5nJ+37HG9iZ
         2K1WgDvqj/pf4tQC1IsgEyPWOwJ1PxI1gAAxE0biKWcEgRLCbkxmYCP2oT2Bk0kszMqQ
         9npmI8bDCyxhZ294oDuyMJqqhhr+nWE/kHIotDv1nT/rPHI+iEB3Uj1JANSP/qwO1OQF
         EEKsA6WH+UMEvu1tpl7KkvFu08Fus3+xfR2iLU7LKlgY/JhPX/3Au2vT3ncIsa454x0Z
         AjCiw32aOtb85q0CJNjXKdzfvygC3DD+oLSb7YAoHu6ZdXkqIuWjNzSMJxueHDH01wZG
         igaw==
X-Forwarded-Encrypted: i=1; AJvYcCUXN+rQ8d1gfY8gc625bERDpVN3PvrXutF1WV3NvxZXiGYypy+szLlXzhHOqiq5En4BwMSIMLB0c9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYolpGnVJzGl0MMzDM31U4aQvockRC0VRaQ08QsOTpYlNL6Wn
	k4KZoFc3AMfuiMe/9mZaSV5v6p9N7xil8aPU81WcmDg1Z1w9DmteIA9AGLQuHg==
X-Gm-Gg: ASbGncuACvkwE3R4kGilyaAUSQYM3VAHJKbaYgHlSqWcpojMCrPbC0j+h2bT0dYamfq
	1TMF0PZB5SfzBSmqiHSS0T828ZhUCBWJxPwAXekwQHCMcBd2FuMLouFCVVINnEH4WWIlyFDTDSS
	Hv/1LKcTlA+SYFQYVweuoqmRUCeJ/OZjpU66hjInNMi/5i165ZL5EJw9jCa9kVHglF2ApgvdF1y
	MJ05CLLMEtkPRQlFVSHq44sBRysIMWgdaW/u2zg1ljdUt+i7pPTPCPyOMmS
X-Google-Smtp-Source: AGHT+IFC+o//XMY4b4nImA6Kytlzd4MoMtCF2tOENOpb/fh9X8LwZE4msIKMQFHOK8nMw3EPSaJFig==
X-Received: by 2002:a17:90b:35c1:b0:2ea:3f3f:a3f0 with SMTP id 98e67ed59e1d1-2ee08eb2b1amr17330359a91.13.1732954371735;
        Sat, 30 Nov 2024 00:12:51 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee88d986b2sm530525a91.38.2024.11.30.00.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:12:51 -0800 (PST)
Date: Sat, 30 Nov 2024 13:42:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <20241130081245.2gjrw26d5cbbsde5@thinkpad>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121152318.2888179-5-cassel@kernel.org>

On Thu, Nov 21, 2024 at 04:23:20PM +0100, Niklas Cassel wrote:
> The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> which allocates the backing memory using dma_alloc_coherent(), which will
> return zeroed memory regardless of __GFP_ZERO was set or not.
> 
> This means that running a new version of pci-endpoint-test.c (host side)
> with an old version of pci-epf-test.c (EP side) will not see any
> capabilities being set (as intended), so this is backwards compatible.
> 
> Additionally, the EP side always allocates at least 128 bytes for the test
> BAR (excluding the MSI-X table), this means that adding another register at
> offset 0x30 is still within the 128 available bytes.
> 
> For now, we only add the CAP_UNALIGNED_ACCESS capability.
> 
> Set CAP_UNALIGNED_ACCESS if the EPC driver can handle any address (because
> it implements the .align_addr callback).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Just a small nit below.

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ef6677f34116..7351289ecddd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -44,6 +44,8 @@
>  
>  #define TIMER_RESOLUTION		1
>  
> +#define CAP_UNALIGNED_ACCESS		BIT(0)
> +
>  static struct workqueue_struct *kpcitest_workqueue;
>  
>  struct pci_epf_test {
> @@ -74,6 +76,7 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	caps;

Can we rename the 'magic' register? It is not used since the beginning and I
don't know if we will ever have a usecase for it.

- Mani

>  } __packed;
>  
>  static struct pci_epf_header test_header = {
> @@ -739,6 +742,20 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
>  	}
>  }
>  
> +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	struct pci_epc *epc = epf->epc;
> +	u32 caps = 0;
> +
> +	if (epc->ops->align_addr)
> +		caps |= CAP_UNALIGNED_ACCESS;
> +
> +	reg->caps = cpu_to_le32(caps);
> +}
> +
>  static int pci_epf_test_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -763,6 +780,8 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  		}
>  	}
>  
> +	pci_epf_test_set_capabilities(epf);
> +
>  	ret = pci_epf_test_set_bar(epf);
>  	if (ret)
>  		return ret;
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

