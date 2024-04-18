Return-Path: <linux-pci+bounces-6392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F08A928B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 07:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920B11C209DB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407EE54F92;
	Thu, 18 Apr 2024 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtOx973P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29062207A
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419007; cv=none; b=D76eKkljOAcOlOOpxf93L1ekiGRiXllKDIDUnb6coABXqSR6d4+kUXwAZZATldmqjx5REhj7N0aJEvUH7qwhMjRxJV1WOQZT24KsYcWCkyHyfPR4ePPNLzzv0ULW88sUVN6+kH8pN8xrvSwG16GyLNkgoVCUfB1TGN7hE3XeLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419007; c=relaxed/simple;
	bh=TqyiQoC0g16lJ9+TzRASnQUPEbTxbgzwT1YYI/p2QQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5EDJdG8tLJsXpDms1RKeCIxWd5u/9Glahwfiso9A+zlkSep85E2mJkl0gOFZNef67bjzUuLzwxXf5tdF/VxAJLEjopPfFGlkZOenN0dqpMMDyqstr7BnVf0HiErKmfBji9yKsZtpXx7IizlDyvru8kRKbSRpUzw6+Obx4BVdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtOx973P; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so459852a91.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713419005; x=1714023805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPz6zQ9n0XvVQuYL65yFLeQ68AHLD/9kPRWZ54My/QY=;
        b=NtOx973PD50HOe8psM3rFm62leAEb59rLeOm8PXWZHGd+1f8iEtHaBrASiBypSDW7k
         1l06RrLIIui8ekTn3toGFOVbAmLXwkZNDJvNKOqpxBTqa2+MEougwT4Z+fiNrKUH8Dmn
         xQCx+NeGv2wGOTG1/1U9vqIE4mBvu7nUBsdXENfcHkAJNHpmYEQWHlDKRpjS/NUrp29V
         p8E5PI1j9q8U0I52V/82YbmoSB8gGZQKpFw3RzFqEnTjrf6ZLOrMrJxVHs5/sUSyjex2
         U/oBdfTJuzDm+sJ76uwNElkqZHBEAMd7nPBJuMvlHNV2IGgHGnzcjWNKNCD8ii/ueJ6G
         ryxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419005; x=1714023805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPz6zQ9n0XvVQuYL65yFLeQ68AHLD/9kPRWZ54My/QY=;
        b=mwKemEueF6fm8MPUQKp21P+Wydm747qFgjRN7Q6i3jzjFCeALcM22uSGkt7dgjlcE0
         Qe56+nuc5SMoU4OSzFP8eqCuHHnfkFn8k7nnLUkZPdMAv/1+4h62M75GqmU5U8fm0PRQ
         uefQFuxxcATMGIWXox6AvQrwlZ1YQsu0muK8FCBinEFQvIMKUI9jpXtVLkhta2t0B/Z7
         p0iC0JJuQWyB/4jim9HOShdgzZuuJxkJArC16YwydP7J6owVvSX6QQur9yy8x+psLZFN
         u006np4cYWuNxE6oEXdMAIuFTu8WYTUKK7Wl7NZ1+wTBmsTbOM+mRc92B9sEK/l1FE6S
         Yr+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3LrCB6dd3kJOkRjnS9OUgDIwrh+4a6MzNuUZ6hu8T8HIACg399BA7SbrmH+4KsIxxVQde0sIR/FmfKwrcD2VeDTctV0q09si+
X-Gm-Message-State: AOJu0YxowGwWOk0k+0nkL9BWGzYB/jellxxbvU3p8XNL2Ud77qtBuFpL
	Zqf7QkN36Ya5+qNi2gOxLAGyuZ09hl4N8duSBE4K/mB+kMJmpuyOBOX68MNh1Q==
X-Google-Smtp-Source: AGHT+IFEE2uClZuhQfrNvSdTPK9z9KdBSy1PpaOvM69JRhG2H58TZmh1y81qPpWCM3/rGyV0lRDkXA==
X-Received: by 2002:a17:90a:d705:b0:2ab:400a:2ba5 with SMTP id y5-20020a17090ad70500b002ab400a2ba5mr1669899pju.31.1713419004814;
        Wed, 17 Apr 2024 22:43:24 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b002a219f8079fsm618871pjy.33.2024.04.17.22.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:43:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:13:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418054319.GB2861@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

No, that's not the correct fixes tag I suppose. This redudant check is
introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
core initialization") and this commit removes the redundant check (fixing smatch
warning is a side effect). So if the fixes tag needs to be added, then this
commit should be referenced.

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
> 

Ok, if we go with this pattern, then pci_epf_test_set_bar() also needs to be
updated.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

