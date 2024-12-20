Return-Path: <linux-pci+bounces-18871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B249F8EEC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B421888D85
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847F1AF0C3;
	Fri, 20 Dec 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myFgfKnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99C1A840A
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686808; cv=none; b=BwjPB9rHJ+paNvY+Vw8Wsm9utxO8etQQfx4AjATrh3VQ5Q/4zjbdW2PVZXzd2it8dMr/yvRJwWhs7PGOPgV//konMUTmjle0TIOLt3iSqXuc6nJ2lUq8BV7kWjo5/v9c1d724JraDUe72b0fJX/l9mgoN7Wg/Sv/e94epvjBdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686808; c=relaxed/simple;
	bh=xUFsgvOm2m2yYjfAWKsKGDlTd/xss0XyQV2USOxSiw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1tmytDSCCOOgFEb5UOh16N3l9z9SbdU3MdzfRKD0i6Z2uwf25H9ofwAN44j3GFpIXXCPkApb1mvUDZYD4kVQjKST7HfwrMVqEotxWBE381M9COTpL3D2lkTXAhLnDEpg14GpMdZIuDZ+FQgaA0ltYDJ0x9W76b40IA9B9GkX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=myFgfKnC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21675fd60feso19642705ad.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 01:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734686806; x=1735291606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmxHeHKigs+48dEYo5SejUJ5WLXMuH9N7v3NLc8KkRI=;
        b=myFgfKnC6VmW3Uqf6ZIgzcEx3mtqTmQa+oZXMi9wkyNMSBddJORDLUY8lc48rLXuxO
         zbVyWjH+R9hJj+3RbJ1LVvW4xP6OX7O+93P6UoGS9OqNBfv+LNuppM0VVel5P5OpN9XA
         hyDB/0vrMUXF+J08YJfFtYWjDzJkHu5284IcFu5zMA0fsTxya5IMKC8EVsddo+JqeeuD
         dOFPv6q5SrELh8kIJGuf0JL1Qlr8blee/kieWQSzxO4OETI5dV1CZoXNiRuUBlqjGV5S
         S5oCLMozTl5hJRVhPMCK3wtfca9UF6PrmC0w+PgbIydxYsk/QBp2XUJdeheeZS9kJ0rZ
         /KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686806; x=1735291606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmxHeHKigs+48dEYo5SejUJ5WLXMuH9N7v3NLc8KkRI=;
        b=PNoy/FTPbE2FrIxU1ZlHUwoBVAbHtv4Lkcsuajo9+n0oQRBoLENomp+1E47XE3gRpd
         A4DIe25rxl+w/P79UH8Ao77XJim9wEnXAfd2tapnD1R72H9vqB7qYX9JM2MnVax7xcyi
         jv5rMGCSWUEW7g1LmiddrpR0fJfQAOsRvbPMnpgHh8zus+X+1pN8XGGgGmgHuIagpJWk
         nOdoeR6XKztAhrLm4LRdF5oAiXKR+qbgV8julBDDCi+t8cd0x+sjRnBcTAP7l9G+aOw+
         WIzq2GFV3LPV3tcELEBL7UTxySXLDGWzbPxoVLb0UqK0uESQIvzrmIZjH7ul1JmCLvVQ
         K5lA==
X-Forwarded-Encrypted: i=1; AJvYcCX1hsQIJH5OM21XCIUd28bzZaEA5x98QP9bYqyKBrqNpjTcZJURd3Qoi3q/LJSmfKyml/6cemGUihE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCSYO6nbiocM68oNM7lsys6u5KO6+nXi3cq7OAx+InMHdw+Vy
	8TmXFriFFRfouOWJcagld6kwXLP6cPZDguiLYvIpsQZitnnUIyCn5Z4M16DrRQ==
X-Gm-Gg: ASbGncvkKRmNXFscxo0uq2c/T2pquYYopTcTaveCEeDuadHri/Fx6L+3Mq7VJbSRhPX
	+q5Ok7N2OxpX5sfioan2tCfl8FJbWufPDnrYrZJGmZ0AdQ0lWKCvxuzZjZ2PJoSy39BYS7JD0rE
	yTkW969zObFfd+HRxo5nUtgHa/bmMhrbq85wFDE99wFu7H+fR8gECZWOwfurkUu8XzgvBZDxfRW
	m1lGWMMTPY+auaAgvM0AMhddAHyopuIyhI0J/zt0BcFPODIyJzq0LFHuSKBiF24SZaI
X-Google-Smtp-Source: AGHT+IF8/6j5SpRZ5xVNPlCRjshyB1U8Ts28bQ7c35ZQ6MdzVSGq78q4eM7ndU4QIokwR30a8J1I+Q==
X-Received: by 2002:a17:903:990:b0:215:b45a:6a5e with SMTP id d9443c01a7336-219e6e9fdcdmr31864135ad.18.1734686806100;
        Fri, 20 Dec 2024 01:26:46 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb4csm25019475ad.77.2024.12.20.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:26:45 -0800 (PST)
Date: Fri, 20 Dec 2024 14:56:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <20241220092639.jho2tbdcxarlzpmr@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
 <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>

On Fri, Dec 20, 2024 at 05:59:05PM +0900, Damien Le Moal wrote:

[...]

> >> +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
> >> +{
> >> +	struct pci_epf *epf = nvme_epf->epf;
> >> +
> >> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> >> +			  &epf->bar[BAR_0]);
> >> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> >> +	nvme_epf->reg_bar = NULL;
> > 
> > Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
> > nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
> > dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
> > epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
> > the EPF for platforms requiring refclk from host).
> > 
> > So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
> > separate helper nvmet_pci_epf_free_bar() and call that only from
> > nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
> 
> I do not get PERST# on the RK3588... So I never noticed this.
> Does this work for you ?
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 8db084f1b20b..4d2a66668e73 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2170,14 +2170,23 @@ static int nvmet_pci_epf_configure_bar(struct
> nvmet_pci_epf *nvme_epf)
>         return 0;
>  }
> 
> +static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
> +{
> +       struct pci_epf *epf = nvme_epf->epf;
> +
> +       if (!nvme_epf->reg_bar)
> +               return;
> +
> +       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> +       nvme_epf->reg_bar = NULL;
> +}
> +
>  static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>  {
>         struct pci_epf *epf = nvme_epf->epf;
> 
>         pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>                           &epf->bar[BAR_0]);
> -       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> -       nvme_epf->reg_bar = NULL;
>  }
> 
>  static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
> @@ -2319,8 +2328,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
> 
>         nvmet_pci_epf_deinit_dma(nvme_epf);
>         nvmet_pci_epf_clear_bar(nvme_epf);
> -
> -       mutex_destroy(&nvme_epf->mmio_lock);
>  }
> 
>  static int nvmet_pci_epf_link_up(struct pci_epf *epf)
> @@ -2390,8 +2397,9 @@ static void nvmet_pci_epf_unbind(struct pci_epf *epf)
>         if (epc->init_complete) {
>                 nvmet_pci_epf_deinit_dma(nvme_epf);
>                 nvmet_pci_epf_clear_bar(nvme_epf);
> -               mutex_destroy(&nvme_epf->mmio_lock);
>         }
> +
> +       nvmet_pci_epf_free_bar(nvme_epf);
>  }
> 
>  static struct pci_epf_header nvme_epf_pci_header = {
> 
> > With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
> > setup.
> 
> With the above, does it work for you ?
> 

Yes, it does!

One more suggestion. Since you correctly removed mutex_destroy() from deinit()
and unbind(), you should also switch to devm_mutex_init() in probe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

