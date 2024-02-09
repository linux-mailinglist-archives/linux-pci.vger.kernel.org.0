Return-Path: <linux-pci+bounces-3272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5184F172
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746F5B26C3A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EF65BDC;
	Fri,  9 Feb 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHTdzN1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BE523B
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467840; cv=none; b=GJZb2jw9NGlsmvhGshT0kEFdst3/hTvfkU6h55sX/6/zCCZzkT5gsXD2etUqeHdW4mCP3QmmcXA5Y3r9zOwimAehROvYEJSDeXDheW+Ec6wD7PjrUSjttkUbm9K7uT/mZO+edSeMH7F6vkBjgKhDSVH7xztbxEh5y8fxw61eYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467840; c=relaxed/simple;
	bh=Q1x/mwCvpqKpD2KI5Uc9NxuLhLGvDT6NvFYG3/WnNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAtgmUFmaI9M7bb3IyJ++rAnbNS+mMLnWuJO0Qnkcn+PqbuqBvOFxlMxb5mPiq6Q1SErcBRjNddaXOu1eMBKKBHNau/S3/LLX/8m181sbRl3icsLOdlbAo3OvMUoDwm9LD87OEzDQ3NH0xT3Q8CilHx9Z8mzblDIUtSw850fwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHTdzN1L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso471350a12.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707467838; x=1708072638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNgg1R1iWhaQvSoI3eeCjQZlvtedgek/H5pz+om4vhQ=;
        b=XHTdzN1LZopsXyMepmHKfxOEi3Rb5DsVDvzijZN4HCojF43zrxeS4ZAf+tLc5hBVR5
         RQLZlQlOrAy6LfzqvXXo49xgoDZKhVeZPzckNVwqxwT/CYYuJBQYJ+wOMhbFDiTr/eep
         KApXyhc2g/hL0fYmdxhPKziWxBd/yTeis4WF6bZEqC0rtwhO3KUdpRc+V8Bojihs1uZE
         wu0/RaR+ZoqTB1kUmzu+bMgRIfTiiMok92jYsgEQjsFSnYcq9KoX6TG5EpR0ThgZqKrV
         8guPMhO62zgCmyX/zvNXgXrQLfU2gt0E5oypV7PfAJ10UOj/dWo4SpHnXB3paIDOBBzI
         DPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467838; x=1708072638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNgg1R1iWhaQvSoI3eeCjQZlvtedgek/H5pz+om4vhQ=;
        b=w49b6s6bOrhAhvpv4OymCwiO5QrGlLHPq5mluz1Thx12D9yeYCO2jCExphazjHn0PQ
         RcLTCy0rNat0D6L4jOWr9TnxfSe2ASFD9dawlzNCU7MXXfKH//RLbJilqd5qsuImVxDp
         kfiKxkD7V1N8Jcqan9kBwc05sgevuwbywC0OjpVKwnaX/yIcwD7Q7HfRdAtgWG0TFrCV
         dNp5JqSskfXDTPxnjKQpFrm4zqdN8PuaW0NX5Llh8m4na2X9o1WYj8s0bpqtMPey6FSb
         +Yr141bMNRjm34OROEBcazqT7en8vm3+uEy9PReb8WMjsfMIQK6b+u8XHdnTIgoSijJP
         AkTA==
X-Forwarded-Encrypted: i=1; AJvYcCVySCRrr4PDTtq6zVg0XALOOeGbm61gfNtZL6WNNCZKpUKMFWb3NT7VLDpkCaFUqAOxX55BvWF5eu5koCno3RpX70pMxZOUZJ86
X-Gm-Message-State: AOJu0Yzhd9Hdgj7mNsGcHHF5ptIQPxQ1WafKzk9UmT/MIceZ2DdW1jhS
	OViFYNwxso9+uxO7ggzhnn8WmYAKMpTLcWBwDFWynbBsltvALoaoUHqjAdIvMg==
X-Google-Smtp-Source: AGHT+IF3zWvXvG9svcSUzMoATfC8z6XcBfEIh4MFOwXINDF05Mwssny7KouOBSFubuHX+uzP0I59Pw==
X-Received: by 2002:a17:90a:db4c:b0:295:b3ec:2cf7 with SMTP id u12-20020a17090adb4c00b00295b3ec2cf7mr760466pjx.48.1707467838365;
        Fri, 09 Feb 2024 00:37:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAfwHi4ANfMkxhvOD6YyPC8rNlDjByZqAtPJ0d45fTnV2BiIflzsR4gQSN/S1zyedZsGtmXT3mE0/CLNtBEvGnXeuxc0DTblbIVUFL9L8VeWVGh6/O0ylzj34Wp6zip+dWQuQYoXcVkfNxhOBLpCiHirF7VFMXjKgEl3JVOzgq0PKT9bIRN2OVgmbkrznpJEOwPmpeQzUC1htiOWo/b+XkpMUPF3o=
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id qc6-20020a17090b288600b002962057028asm1160169pjb.46.2024.02.09.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:37:17 -0800 (PST)
Date: Fri, 9 Feb 2024 14:07:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: endpoint: improve pci_epf_alloc_space()
Message-ID: <20240209083713.GC12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
 <20240207213922.1796533-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-3-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:15PM +0100, Niklas Cassel wrote:
> pci_epf_alloc_space() already performs checks on the requested BAR size,
> and will allocate and set epf_bar->size to a size higher than the
> requested BAR size if some constraint deems it necessary.
> 
> However, other than pci_epf_alloc_space() already doing these roundups,
> there are additional checks and roundups done in e.g. pci-epf-test.c.
> 
> And similar checks are proposed to other endpoint function drivers, see:
> https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/
> 
> Having these checks scattered over different locations in multiple EPF
> drivers is not maintainable and makes the code hard to follow.
> 
> Since pci_epf_alloc_space() already performs roundups, add the checks
> currently performed by pci-epf-test.c to pci_epf_alloc_space(), such that
> a follow up patch can drop these checks from pci-epf-test.c.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epf-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 1d405fd61a2a..367e029f6716 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -260,6 +260,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  const struct pci_epc_features *epc_features,
>  			  enum pci_epc_interface_type type)
>  {
> +	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
>  	size_t align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> @@ -270,6 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> +	if (bar_fixed_size && size > bar_fixed_size) {
> +		dev_err(dev, "requested BAR size is larger than fixed size\n");
> +		return NULL;
> +	}
> +
> +	if (bar_fixed_size)
> +		size = bar_fixed_size;
> +
>  	if (align)
>  		size = ALIGN(size, align);
>  	else
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

