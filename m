Return-Path: <linux-pci+bounces-6373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F58A8A6A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D51F1C2232D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDC172BA7;
	Wed, 17 Apr 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLtzx3DR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1A171678;
	Wed, 17 Apr 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376191; cv=none; b=NpL9CatRJQ+iFg72MQdzV9xQtop/NCF1n0JCrtwlVQVQa7sXd6e5XYwxTsFpZnmI8ScmAw02/3LAv23vYrItB+aW5V4aDlRs62Hzavh/+NrQSTK+Kb0cUrTNO1j0zzLboFBtzG4UTW/kbBagOJd1O8xW+GuxX5tMymmAJ6QnW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376191; c=relaxed/simple;
	bh=kKmiZAPl+q6hmp8UYUp88qDELSBUZ6KaZWZd1XSAtdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6WMIROxnkbe1oYDhhb2BWqdZ8xwoIN5ebeMtC2uAsb8xSRcWDXjptHD2wMA6DtKLEaNa5RkEaXxOSxn/t8XdjQVJvTd6ElnZRSJuZAAkB8s1X4V4cO99T8uJlKZ2qUT+ZuHlwTIgVv+FGT6kqBxR0Ex/8JHzuLjdADdhWSCdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLtzx3DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCABC072AA;
	Wed, 17 Apr 2024 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713376190;
	bh=kKmiZAPl+q6hmp8UYUp88qDELSBUZ6KaZWZd1XSAtdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLtzx3DRHZYf8q/L8qvoWsIV1j+mXQKUIxe3GMLZ42asCImYAwJZS/fjodoBAuPdp
	 177Dv3Hy1M3KfWejLCuesWtBigYezXbqgMed3O0h9yaNWeoc0/yre4hzW/jF7I3R5w
	 qCN0MUJmbhjf7O0DfU8Hx6MEfq1QzOTQWciowY1T1x6fEsfEcofdcp0sG2NX+lz4JQ
	 VSYK6SquDVGk4ErhYIhI17i5fkVcdALqBaDquXWhcuo9FSP10dxu7Fd2D8eHu/MMrv
	 gWR3zXZbH1NzX+Xlyhi7snGKiTBKjX0C03MIRE2JAJNBDScBAn9/JUosuRxZ4T10/D
	 VcjsO5Xw/vqtg==
Date: Wed, 17 Apr 2024 19:49:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiALuYlshLmwLhvu@ryzen>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>

On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> Instead of getting the epc_features from pci_epc_get_features() API, use
> the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> the NULL check is already performed in pci_epf_test_bind(), having one more
> check in pci_epf_test_core_init() is redundant and it is not possible to
> hit the NULL pointer dereference. This also leads to the following smatch
> warning:
> 
> drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> error: we previously assumed 'epc_features' could be null (see line 747)
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I think you forgot:
Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")


> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 977fb79c1567..0d28f413cb07 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -743,11 +743,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	bool msi_capable = true;
>  	int ret;
>  
> -	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> -	if (epc_features) {
> -		msix_capable = epc_features->msix_capable;
> -		msi_capable = epc_features->msi_capable;
> -	}
> +	epc_features = epf_test->epc_features;

How about:

index 977fb79c1567..4d6105c07ac0 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -735,7 +735,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 {
        struct pci_epf_test *epf_test = epf_get_drvdata(epf);
        struct pci_epf_header *header = epf->header;
-       const struct pci_epc_features *epc_features;
+       const struct pci_epc_features *epc_features = epf_test->epc_features;
        struct pci_epc *epc = epf->epc;
        struct device *dev = &epf->dev;
        bool linkup_notifier = false;
@@ -743,12 +743,6 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
        bool msi_capable = true;
        int ret;
 
-       epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
-       if (epc_features) {
-               msix_capable = epc_features->msix_capable;
-               msi_capable = epc_features->msi_capable;
-       }
-
        if (epf->vfunc_no <= 1) {
                ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
                if (ret) {
@@ -761,6 +755,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
        if (ret)
                return ret;
 
+       msi_capable = epc_features->msi_capable;
        if (msi_capable) {
                ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
                                      epf->msi_interrupts);
@@ -770,6 +765,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
                }
        }
 
+       msix_capable = epc_features->msix_capable;
        if (msix_capable) {
                ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
                                       epf->msix_interrupts,
@@ -814,11 +810,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
        void *base;
        enum pci_barno test_reg_bar = epf_test->test_reg_bar;
        enum pci_barno bar;
-       const struct pci_epc_features *epc_features;
+       const struct pci_epc_features *epc_features = epf_test->epc_features;
        size_t test_reg_size;
 
-       epc_features = epf_test->epc_features;
-
        test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
        msix_capable = epc_features->msix_capable;


Instead?

That way, we assign msi_capable/msix_capable just before the if-statement
where it is used. (Which matches how we already assign msix_capable just
before the if-statement in pci_epf_test_alloc_space().)


Kind regards,
Niklas


> +
> +	msix_capable = epc_features->msix_capable;
> +	msi_capable = epc_features->msi_capable;
>  
>  	if (epf->vfunc_no <= 1) {
>  		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
> 
> ---
> base-commit: 6e47dcb2ca223211c43c37497836cd9666c70674
> change-id: 20240417-pci-epf-test-fix-2209ae22be80
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

