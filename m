Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A77891F4
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 00:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHYWuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 18:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjHYWuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 18:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A69E77;
        Fri, 25 Aug 2023 15:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7845F60F87;
        Fri, 25 Aug 2023 22:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C734C433C7;
        Fri, 25 Aug 2023 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693003808;
        bh=nMm5vYE7JaMjDPPEEJlEV36deplR3ba5q9rfZPaSY1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AMtEe3DOiGC1QLWjcFukR0M7E2vIwgKNtgx5fHNyxgA1n7hamGnAADlmamBiCVXG2
         Wcty+n3SunqeQFcfRgHo7PDo5jJywwHuB7BH/OnV25WhKjOCYQW451ZLamu65Rrxyc
         M8Eys1xc6pioCdEjia+rq54QUWucD8VZfFENuGgK656UzCfRZTZgMYMjryg3QjeGNj
         J8246kA3g2WB5c/+IIV/QNjMRPYAxPdD07TK1oWMOdM0fVHN+LzHyU2llpaRZBDyJj
         hLuzT8C6qH+RWQw0ILn5ZRotXukNy9zOzLyumNpWgRsliHNAK2eyDtZuFYPt3n4z2M
         4fyayf86TzJqg==
Date:   Fri, 25 Aug 2023 17:50:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] PCI: epf-mhi: Make use of the alignment
 restriction from EPF core
Message-ID: <20230825225006.GA642059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717065459.14138-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 12:24:54PM +0530, Manivannan Sadhasivam wrote:
> Instead of hardcoding the alignment restriction in the EPF_MHI driver, make
> use of the info available from the EPF core that reflects the alignment
> restriction of the endpoint controller.
> 
> For this purpose, let's introduce the get_align_offset() static function.

I thought this might be related to the [1/7] patch since they both
mention an alignment restriction in the EPF core, but [1/7] sets
pci_epc_features.align and this patch doesn't reference .align, so
this must be a different alignment restriction?

I'm sure there's nothing wrong here, and this is already applied, so
no need to do anything unless .align *should* appear here.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 9c1f5a154fbd..bb7de6884824 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -102,6 +102,11 @@ struct pci_epf_mhi {
>  	int irq;
>  };
>  
> +static size_t get_align_offset(struct pci_epc *epc, u64 addr)
> +{
> +	return addr % epc->mem->window.page_size;
> +}
> +
>  static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
>  				 phys_addr_t *paddr, void __iomem **vaddr,
>  				 size_t offset, size_t size)
> @@ -134,7 +139,7 @@ static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
>  {
>  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
>  	struct pci_epc *epc = epf_mhi->epf->epc;
> -	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> +	size_t offset = get_align_offset(epc, pci_addr);
>  
>  	return __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
>  				      offset, size);
> @@ -161,7 +166,7 @@ static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
>  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
>  	struct pci_epf *epf = epf_mhi->epf;
>  	struct pci_epc *epc = epf->epc;
> -	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> +	size_t offset = get_align_offset(epc, pci_addr);
>  
>  	__pci_epf_mhi_unmap_free(mhi_cntrl, pci_addr, paddr, vaddr, offset,
>  				 size);
> @@ -185,7 +190,8 @@ static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
>  				      void *to, size_t size)
>  {
>  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> -	size_t offset = from % SZ_4K;
> +	struct pci_epc *epc = epf_mhi->epf->epc;
> +	size_t offset = get_align_offset(epc, from);
>  	void __iomem *tre_buf;
>  	phys_addr_t tre_phys;
>  	int ret;
> @@ -213,7 +219,8 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
>  				     void *from, u64 to, size_t size)
>  {
>  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> -	size_t offset = to % SZ_4K;
> +	struct pci_epc *epc = epf_mhi->epf->epc;
> +	size_t offset = get_align_offset(epc, to);
>  	void __iomem *tre_buf;
>  	phys_addr_t tre_phys;
>  	int ret;
> -- 
> 2.25.1
> 
