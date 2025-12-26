Return-Path: <linux-pci+bounces-43729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B09CDED6C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5AA30057DF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5982E3AEA;
	Fri, 26 Dec 2025 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGR7GzLh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31E2E0413;
	Fri, 26 Dec 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766769562; cv=none; b=ASuDIRbl9jeULNTtOSxSDQC/KYEqhW5Zm4xiAQrgEICmnbNAEfnwteBpkIyTU7uetQIxx7WogRZdLPgKqpSLx5rDU9Y1/bZ8d/bIlqy157LqmpG20JS0NotuOsEKCwJc0gnAiZR3m/d6oNpbTU4VJuo/MfDYM5JbMCWCx/YfEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766769562; c=relaxed/simple;
	bh=R7Xe8Vo0sAqcTqxB+ijnQow2uxhO0kGbyfHDUMMcV7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h8euBzwoLMMC5cVVCu1fDpIj7K3PEAiCvEKq3yn2nGVnyQ9DoxEf6AXYlCzOsX+DTum609vf37vX74QISOiSDaD56gnBZ0pBlbyQGEn5rS5aIytMDz0ZhJFo7V2Wsuh/1vjSVrK3nUxBpfpqudFmKysZKm3A+s4d6taLhmMSPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGR7GzLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1B7C4CEF7;
	Fri, 26 Dec 2025 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766769560;
	bh=R7Xe8Vo0sAqcTqxB+ijnQow2uxhO0kGbyfHDUMMcV7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eGR7GzLhAOzoM/tW2iHh7BICj3wp6aJVpL1auZt5PIo8y14Aah7cHx+VU6wDZU2Pl
	 TqZDTKbjHnLHXrNmSUqSmQ9z2vMhqD4F53kR3cFbQYJ4AaBJd1teUunFB+qyc/zsC5
	 DQaODq0Sm/zgpvSXU1MHAiRUHU3yMN8QCDi3V+NhHH53qkgpED1HNKxaTjq0k+ptIT
	 +YMNKdP6N4ivct58Q9+hdFhmE0ahD1SQ6DtZmuAlJXzhrBt2VASeyBK66+TO7+IORA
	 gwKTuW2+pQabXKk8+V9FVCSJZ5vf0owUAy+qbrGzGwj7seTL91q5wQBN72TH6Fp6jH
	 CgOIgWdlrJeqg==
Date: Fri, 26 Dec 2025 11:19:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	arnd@arndb.de, kishon@kernel.org, stable@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Add config guards for Cadence Host and
 Endpoint library APIs
Message-ID: <20251226171919.GA4131469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117113246.1460644-1-s-vadapalli@ti.com>

On Mon, Nov 17, 2025 at 05:02:06PM +0530, Siddharth Vadapalli wrote:
> Commit under Fixes enabled loadable module support for the driver under
> the assumption that it shall be the sole user of the Cadence Host and
> Endpoint library APIs. This assumption guarantees that we won't end up
> in a case where the driver is built-in and the library support is built
> as a loadable module.
> 
> With the introduction of [1], this assumption is no longer valid. The
> SG2042 driver could be built as a loadable module, implying that the
> Cadence Host library is also selected as a loadable module. However, the
> pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
> due to which the Cadence Endpoint library is built-in. Despite the
> library drivers being built as specified by their respective consumers,
> since the 'pci-j721e.c' driver has references to the Cadence Host
> library APIs as well, we run into a build error as reported at [0].
> 
> Fix this by adding config guards as a temporary workaround. The proper
> fix is to split the 'pci-j721e.c' driver into independent Host and
> Endpoint drivers as aligned at [2].

If we know what the proper fix is, why aren't we just doing that
instead of adding a temporary workaround?

> Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable module")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> Cc: <stable@vger.kernel.org>
> [0]: https://lore.kernel.org/r/202511111705.MZ7ls8Hm-lkp@intel.com/
> [1]: commit 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> [2]: https://lore.kernel.org/r/37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 43 +++++++++++++---------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 5bc5ab20aa6d..67c5e02afccf 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -628,10 +628,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			gpiod_set_value_cansleep(gpiod, 1);
>  		}
>  
> -		ret = cdns_pcie_host_setup(rc);
> -		if (ret < 0) {
> -			clk_disable_unprepare(pcie->refclk);
> -			goto err_pcie_setup;
> +		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
> +			ret = cdns_pcie_host_setup(rc);
> +			if (ret < 0) {
> +				clk_disable_unprepare(pcie->refclk);
> +				goto err_pcie_setup;
> +			}
>  		}
>  
>  		break;
> @@ -642,9 +644,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  
> -		ret = cdns_pcie_ep_setup(ep);
> -		if (ret < 0)
> -			goto err_pcie_setup;
> +		if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
> +			ret = cdns_pcie_ep_setup(ep);
> +			if (ret < 0)
> +				goto err_pcie_setup;
> +		}
>  
>  		break;
>  	}
> @@ -669,10 +673,11 @@ static void j721e_pcie_remove(struct platform_device *pdev)
>  	struct cdns_pcie_ep *ep;
>  	struct cdns_pcie_rc *rc;
>  
> -	if (pcie->mode == PCI_MODE_RC) {
> +	if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
> +	    pcie->mode == PCI_MODE_RC) {
>  		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
>  		cdns_pcie_host_disable(rc);
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
>  		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
>  		cdns_pcie_ep_disable(ep);
>  	}
> @@ -739,10 +744,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
>  			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
>  		}
>  
> -		ret = cdns_pcie_host_link_setup(rc);
> -		if (ret < 0) {
> -			clk_disable_unprepare(pcie->refclk);
> -			return ret;
> +		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
> +			ret = cdns_pcie_host_link_setup(rc);
> +			if (ret < 0) {
> +				clk_disable_unprepare(pcie->refclk);
> +				return ret;
> +			}
>  		}
>  
>  		/*
> @@ -752,10 +759,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
>  		for (enum cdns_pcie_rp_bar bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
>  			rc->avail_ib_bar[bar] = true;
>  
> -		ret = cdns_pcie_host_init(rc);
> -		if (ret) {
> -			clk_disable_unprepare(pcie->refclk);
> -			return ret;
> +		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
> +			ret = cdns_pcie_host_init(rc);
> +			if (ret) {
> +				clk_disable_unprepare(pcie->refclk);
> +				return ret;
> +			}
>  		}
>  	}
>  
> -- 
> 2.51.1
> 

