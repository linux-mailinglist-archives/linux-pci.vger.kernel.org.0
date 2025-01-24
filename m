Return-Path: <linux-pci+bounces-20316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C266DA1B11C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD1316B804
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D71D9A6E;
	Fri, 24 Jan 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QydKEcNG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28A1D95A2;
	Fri, 24 Jan 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704892; cv=none; b=aiSmXUPuIfqD+lKu1SlaGuEHlgVXOEut/UGo+XByAOb9gNE6XmMaI2aU+eIBFFO0Ywjc7nOgLGIONiTweu9iHsb0+AbTATXclVnUglpa2EgRP8m59XEFawwthPTelGvz8cHpC9IL+uJrcM1BuyvdFLpjUC91HpELMdyDE+AzcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704892; c=relaxed/simple;
	bh=6YUzo/lqjG9MtMlkc1Jiy04MrgOEco72woPzQZQNnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhfcRw9ysXZFEPFtcKuVh1SAxBv4bLGOExb7M8G1ckx8RTwqWmaWr9Z1t7cbZXo+NrjVniQ6UV84LTKShxJvkXJ3rNgzrXGR6LKyS2J3hzTvBCuxAQdf+aO268g3CaAICJGgi/6Q/OCaDlI0juUVTD7tY0oel7r7j+vfBdupqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QydKEcNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44291C4CEE1;
	Fri, 24 Jan 2025 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737704891;
	bh=6YUzo/lqjG9MtMlkc1Jiy04MrgOEco72woPzQZQNnYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QydKEcNG8vjV3nbKCbEhP8WMoKs33/K78l2nlv6Jhzjcszi6GG222fPL7sf+/W332
	 iX096oEO7yl8CzVwmvq8Suta7PVMxyFrhUeri20mYOp19173y+/R2ZBhAiVKOse5T0
	 5ZymshiswSd0YaMj4nkteFVJD6F8fez7hh5hyn1TE6uUUCKjTpw4NdkLxJDji9Kv3w
	 0BOIbkN+svILCjwehrgbzhtBTe7faHlT5rDnv8Al4/wfID0sfinjwy3ujFlhSqBwEV
	 xiEgAqFXbVHyq/eZDIr8TkcGXC7xonYZ/a9j1kCiNI6mzUuQuXeCIeLiCmvYYCiKuz
	 zeI58/ncr9UJQ==
Date: Fri, 24 Jan 2025 13:18:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix double free Oops
Message-ID: <20250124074802.txe5kpvpw3b4nfbq@thinkpad>
References: <20250117090903.3329039-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117090903.3329039-1-christian.bruel@foss.st.com>

On Fri, Jan 17, 2025 at 10:09:03AM +0100, Christian Bruel wrote:
> Fixes an oops found while testing the stm32_pcie ep driver with handling
> of PERST# deassertion:
> 
> [   92.154549] ------------[ cut here ]------------
> [   92.159093] Trying to vunmap() nonexistent vm area (0000000031e0f06f)
> ...
> [   92.288763]  vunmap+0x58/0x60 (P)
> [   92.292096]  dma_direct_free+0x88/0x18c
> [   92.295932]  dma_free_attrs+0x84/0xf8
> [   92.299664]  pci_epf_free_space+0x48/0x78
> [   92.303698]  pci_epf_test_epc_init+0x184/0x3c0 [pci_epf_test]
> [   92.309446]  pci_epc_init_notify+0x70/0xb4
> [   92.313578]  stm32_pcie_ep_perst_irq_thread+0xf8/0x24c
> ...
> 
> During EP initialization, pci_epf_test_alloc_space allocates all BARs,
> which are further freed if epc_set_bar fails (for instance, due to
> no free inbound window).
> 
> However, when pci_epc_set_bar fails, the error path:
>      pci_epc_set_bar -> pci_epf_free_space
> does not reset epf_test->reg[bar].
> 
> Then, if the host reboots, PERST# deassertion restarts the BAR allocation
> sequence with the same allocation failure (no free inbound window).
> 
> So, two subsequent calls to the sequence:
> 
>   if (!epf_test->reg[bar])
>       continue;
> 
>   ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
>   if (ret) {
>       pci_epf_free_space(epf, epf_test->reg[bar], bar, PRIMARY_INTERFACE);
>   }
> 
> create a double free situation since epf_test->reg[bar] was deallocated
> and is still non-NULL.
> 
> This patch makes pci_epf_alloc_space/pci_epf_free_space symmetric
> by resetting epf_test->reg[bar] when memory is deallocated.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

With comments from Niklas addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ffb534a8e50a..b29e938ee16a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -718,6 +718,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar,
>  					   PRIMARY_INTERFACE);
> +			epf_test->reg[bar] = NULL;
>  			dev_err(dev, "Failed to set BAR%d\n", bar);
>  			if (bar == test_reg_bar)
>  				return ret;
> @@ -909,6 +910,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
>  
>  		pci_epf_free_space(epf, epf_test->reg[bar], bar,
>  				   PRIMARY_INTERFACE);
> +		epf_test->reg[bar] = NULL;
>  	}
>  }
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

