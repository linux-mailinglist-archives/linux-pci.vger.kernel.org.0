Return-Path: <linux-pci+bounces-990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDB812D4B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517B31F2171A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2B2577E;
	Thu, 14 Dec 2023 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsL4pq9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0483610B;
	Thu, 14 Dec 2023 10:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A651EC433C7;
	Thu, 14 Dec 2023 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702550853;
	bh=G10Hq0xP/zK5MeKYT++ROANkyAPjg2roDsTG8VsGAWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsL4pq9DfAK53U5u0VlSzDgEKFAmJsuM15de8Y+gdaEo1drG48/N2Ek0Zzl4ZxG0A
	 Mf2E4KD480cgTl4B9MOAWbJKEohV3EbhLdAKM25MDZcw3i1SQHhAasg2vrjFGI4o9Y
	 MGujhdkdIez3+Se9qwSryB5t4n/3SXxcYgKMefiQuhnYVrQAjQZGmaZL7yLdMWSmYz
	 LhCdUxebjvd2ZqL8ockuBP7H0x8BVZ3tfkNkB08ehd//TNON17XKFuAiJ4O4K5gc0l
	 UEHodsCAHbC6bij499aX7hb6dCDoQBlqHjwzQ56TUPmSH8DEfhanRGI2TM7bRJ4BKV
	 QKq14cK2XLs+Q==
Date: Thu, 14 Dec 2023 16:17:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231214104719.GM2938@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
 <feb4ed1b-ed74-aebe-0ab8-dec123fe0a31@quicinc.com>
 <20231214100936.GI2938@thinkpad>
 <8929dcd0-af98-5b18-2d90-aad7b5928578@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8929dcd0-af98-5b18-2d90-aad7b5928578@quicinc.com>

On Thu, Dec 14, 2023 at 03:44:21PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 12/14/2023 3:39 PM, Manivannan Sadhasivam wrote:
> > On Thu, Dec 14, 2023 at 03:10:01PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 11/27/2023 6:15 PM, Manivannan Sadhasivam wrote:
> > > > Now that both eDMA and iATU are prepared to support async transfer, let's
> > > > enable MHI async read/write by supplying the relevant callbacks.
> > > > 
> > > > In the absence of eDMA, iATU will be used for both sync and async
> > > > operations.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
> > > >    1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > index 3d09a37e5f7c..d3d6a1054036 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
> > > >    	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> > > >    	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> > > >    	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > > > +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> > > > +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
> > > >    	if (info->flags & MHI_EPF_USE_DMA) {
> > > >    		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
> > > >    		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> > > > -	} else {
> > > > -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> > > > -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> > > > +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> > > > +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> > > I think the read_async & write async should be updated inside the if
> > > condition where MHI_EPF_USE_DMA flag is set.
> > > 
> > That's what being done here. Am I missing anything?
> > 
> > - Mani
> 
> It should be like this as edma sync & aysnc read write should be update only
> if DMA is supported, in the patch I see async function pointers are being
> updated with the edma function pointers for IATU operations.
> 
>                 if (info->flags & MHI_EPF_USE_DMA) {
> 
>   		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>   		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> 		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> 		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> 	}

Are you reading the patch correctly? Please take a look at this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/tree/drivers/pci/endpoint/functions/pci-epf-mhi.c?h=mhi-next&id=d1c6f4ba4746ed41fde8269cb5fea88bddb60504#n771

- Mani

> - Krishna Chaitanya.
> 
> > > - Krishna Chaitanya.
> > > 
> > > >    	}
> > > >    	/* Register the MHI EP controller */

-- 
மணிவண்ணன் சதாசிவம்

