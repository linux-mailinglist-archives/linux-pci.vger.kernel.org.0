Return-Path: <linux-pci+bounces-6397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8158A937D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033BC282AF7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D23A8D0;
	Thu, 18 Apr 2024 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKisF8+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B787EAE6;
	Thu, 18 Apr 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422813; cv=none; b=SuTm1j/gbTmvTbz6ynpFqkzY5Gcv0Oj5co9zixNjzTOPA5sxh1kGOuuWKrA/PQTNlXXLaThEq/KU0bYWTK6T2ODHeMvfyUQ7b6vy7dOq7+2h7kfO0iDbEiK/azeVT5Q/38aW0XHXlCx4oZmOwyzZBQ6f3+UfAv3B+yIGpgpUfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422813; c=relaxed/simple;
	bh=Jz7t1RYJbr+9YWBUJ+D3uzUpGsOLBahTcP6Q4ZlULzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtV9jHB3Jd6E7oMfPjw5qKc3Mod46mWJAozaC+xH2PA3n6GUEpls+M3EFUjS1WZMO8bK4PjDVcerykfViSQVGDoxV4ECOMuF7Rj9thbJaixIj5BjZwSs2Yi6waM9MuX+jfJMQThnEn3JLAN330iaiNK4QjhDK42R9iyU9m96hXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKisF8+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04115C113CC;
	Thu, 18 Apr 2024 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713422812;
	bh=Jz7t1RYJbr+9YWBUJ+D3uzUpGsOLBahTcP6Q4ZlULzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKisF8+jZJXJz0mgp2hTSwUg4QG21/qDymdoqk4tfjpCPKT04NsyME7hfQGnH/6gL
	 D2Mu8K6KiXX2FDLabFUh4xEDdZveJjmR7W6Re9rGORF2QgCtnLZGa3pH8k3yAiU52G
	 r2w8Qx1vRZcIT8nsplcJz+KqZMMX4eYV1HUfAYfwUpkC1Coj7HolYq2esMZ2V2rtT0
	 33WxAAbpKRsC04GB5sAJR5nPd/xLd7i4K7Qp+RxyQ4oJbW5Wm3hYFR+XLrrGuA9XmU
	 hkJ3Fo/EfbBHYmMgspa569w2Ts6VAxnqmIHXrGlCkfc2CAmedz6T9x23cYpnijZvpa
	 x7g117q7DB/Tw==
Date: Thu, 18 Apr 2024 08:46:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiDB18w4bnUCSH7D@ryzen>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418054319.GB2861@thinkpad>

On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > hit the NULL pointer dereference. This also leads to the following smatch
> > > warning:
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > I think you forgot:
> > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > 
> 
> No, that's not the correct fixes tag I suppose. This redudant check is
> introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> core initialization") and this commit removes the redundant check (fixing smatch
> warning is a side effect). So if the fixes tag needs to be added, then this
> commit should be referenced.

Well, you have a Closes: tag that links to a bug report about a smatch
warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
support to defer core initialization").

So if you want to reference another commit, then you should probably
drop the Closes: tag.


> 
> > 
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 977fb79c1567..0d28f413cb07 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -743,11 +743,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> > >  	bool msi_capable = true;
> > >  	int ret;
> > >  
> > > -	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> > > -	if (epc_features) {
> > > -		msix_capable = epc_features->msix_capable;
> > > -		msi_capable = epc_features->msi_capable;
> > > -	}
> > > +	epc_features = epf_test->epc_features;
> > 
> > How about:
> > 
> > index 977fb79c1567..4d6105c07ac0 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -735,7 +735,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >  {
> >         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >         struct pci_epf_header *header = epf->header;
> > -       const struct pci_epc_features *epc_features;
> > +       const struct pci_epc_features *epc_features = epf_test->epc_features;
> >         struct pci_epc *epc = epf->epc;
> >         struct device *dev = &epf->dev;
> >         bool linkup_notifier = false;
> > @@ -743,12 +743,6 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >         bool msi_capable = true;
> >         int ret;
> >  
> > -       epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> > -       if (epc_features) {
> > -               msix_capable = epc_features->msix_capable;
> > -               msi_capable = epc_features->msi_capable;
> > -       }
> > -
> >         if (epf->vfunc_no <= 1) {
> >                 ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
> >                 if (ret) {
> > @@ -761,6 +755,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >         if (ret)
> >                 return ret;
> >  
> > +       msi_capable = epc_features->msi_capable;
> >         if (msi_capable) {
> >                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
> >                                       epf->msi_interrupts);
> > @@ -770,6 +765,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >                 }
> >         }
> >  
> > +       msix_capable = epc_features->msix_capable;
> >         if (msix_capable) {
> >                 ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
> >                                        epf->msix_interrupts,
> > @@ -814,11 +810,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >         void *base;
> >         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >         enum pci_barno bar;
> > -       const struct pci_epc_features *epc_features;
> > +       const struct pci_epc_features *epc_features = epf_test->epc_features;
> >         size_t test_reg_size;
> >  
> > -       epc_features = epf_test->epc_features;
> > -
> >         test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
> >  
> >         msix_capable = epc_features->msix_capable;
> > 
> > 
> > Instead?
> > 
> > That way, we assign msi_capable/msix_capable just before the if-statement
> > where it is used. (Which matches how we already assign msix_capable just
> > before the if-statement in pci_epf_test_alloc_space().)
> > 
> 
> Ok, if we go with this pattern, then pci_epf_test_set_bar() also needs to be
> updated.

pci_epf_test_set_bar() ? I presume that you mean pci_epf_test_alloc_space().

How about a 1/2 patch that modifies pci_epf_test_core_init() and Closes: the
bug report, and a 2/2 patch that modifies pci_epf_test_alloc_space() ?


Kind regards,
Niklas

