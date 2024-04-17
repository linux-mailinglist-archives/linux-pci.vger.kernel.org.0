Return-Path: <linux-pci+bounces-6376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8DD8A8A8B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC8A1C20E35
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3C172BAF;
	Wed, 17 Apr 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZWrEymo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D3171085;
	Wed, 17 Apr 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376501; cv=none; b=hkzlpJ3imkhYN9Pz6ZOZJFxKMXVCP2IyKtkE+aVXaTF/c+/4mvXuIFLlcBcHC+o5NBrgjEeCipEWHXXfDCeaovCUzeDziZ35wkRinWkYiqVVokG1j5Sk6NsPWVxhzjYZM49gprbcyzLRwbms2lwgamfSL+tKj3mSJrDQR/Wbdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376501; c=relaxed/simple;
	bh=kP4KZgGxptEzt0uGCLTrdIeZdz6Bjv/rNYIUCX6ObTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyo16KySMo8RRbvxa9ESb4jDnBSOdFMzXVh35a3UbDzLDlqyk62DVZUq87dNAXr9JYM3lslp7UWj0VHyHKyqjZp/8UcAmeH2qPQPQRzEFSAREMezsV/xqHbq8IIOfiTjGbIf2cV71FHhCRhtXKWVF2mjFFAKcu7r9VcLJM2W2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZWrEymo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A9C072AA;
	Wed, 17 Apr 2024 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713376501;
	bh=kP4KZgGxptEzt0uGCLTrdIeZdz6Bjv/rNYIUCX6ObTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZWrEymoameUeWO6ldRkpNsGN/Psgewym91GfiMf1ZdwgC0n8BcXTY0Efh+ckHYUs
	 80aXSRkEkNljt043JyAFKdio86RckOGSS84s00wB89liOAgfAgty4FmrSMy+bL/81o
	 JRHlP5BFp64OvwIghEoddAkj6X1CyN4NlwLDyhQxLWuEjK+BDr8lOUasjli3wDkn45
	 HOGG8pBHOLUs76Crii3Ri8RKVGRVQ4zMmvbgI+U2UgJPEZe1wF/fHE+hJ8UfJ+GJO5
	 R2dt7B2mdnZtASLHYwwN1aWfdKbfA+ShYX5bcKNhwB0XIDfz8mSzyCPITnDhvHrQOH
	 B9pLs85VMzMUQ==
Date: Wed, 17 Apr 2024 19:54:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiAM8Hp24XF8CyUJ@ryzen>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiALuYlshLmwLhvu@ryzen>

On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > Instead of getting the epc_features from pci_epc_get_features() API, use
> > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > the NULL check is already performed in pci_epf_test_bind(), having one more
> > check in pci_epf_test_core_init() is redundant and it is not possible to
> > hit the NULL pointer dereference. This also leads to the following smatch
> > warning:
> > 
> > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > error: we previously assumed 'epc_features' could be null (see line 747)
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I think you forgot:
> Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> 
> 
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 977fb79c1567..0d28f413cb07 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -743,11 +743,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >  	bool msi_capable = true;
> >  	int ret;
> >  
> > -	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> > -	if (epc_features) {
> > -		msix_capable = epc_features->msix_capable;
> > -		msi_capable = epc_features->msi_capable;
> > -	}
> > +	epc_features = epf_test->epc_features;
> 
> How about:
> 
> index 977fb79c1567..4d6105c07ac0 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -735,7 +735,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  {
>         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>         struct pci_epf_header *header = epf->header;
> -       const struct pci_epc_features *epc_features;
> +       const struct pci_epc_features *epc_features = epf_test->epc_features;
>         struct pci_epc *epc = epf->epc;
>         struct device *dev = &epf->dev;
>         bool linkup_notifier = false;
> @@ -743,12 +743,6 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>         bool msi_capable = true;
>         int ret;
>  
> -       epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> -       if (epc_features) {
> -               msix_capable = epc_features->msix_capable;
> -               msi_capable = epc_features->msi_capable;
> -       }
> -
>         if (epf->vfunc_no <= 1) {
>                 ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
>                 if (ret) {
> @@ -761,6 +755,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>         if (ret)
>                 return ret;
>  
> +       msi_capable = epc_features->msi_capable;
>         if (msi_capable) {
>                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
>                                       epf->msi_interrupts);
> @@ -770,6 +765,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>                 }
>         }
>  
> +       msix_capable = epc_features->msix_capable;
>         if (msix_capable) {
>                 ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
>                                        epf->msix_interrupts,
> @@ -814,11 +810,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>         void *base;
>         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>         enum pci_barno bar;
> -       const struct pci_epc_features *epc_features;
> +       const struct pci_epc_features *epc_features = epf_test->epc_features;
>         size_t test_reg_size;
>  
> -       epc_features = epf_test->epc_features;
> -
>         test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
>  
>         msix_capable = epc_features->msix_capable;
> 
> 
> Instead?
> 
> That way, we assign msi_capable/msix_capable just before the if-statement
> where it is used. (Which matches how we already assign msix_capable just
> before the if-statement in pci_epf_test_alloc_space().)

...or just kill the local variables:
bool msi_capable/msix_capable in pci_epf_test_core_init(), and
bool msix_capable pci_epf_test_alloc_space()
and just do:

if (epc_features->msix_capable) / if (epc_features->msi_capable)

directly?


Kind regards,
Niklas

