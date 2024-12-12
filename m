Return-Path: <linux-pci+bounces-18242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58A9EE356
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9567B165144
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DD20E6F5;
	Thu, 12 Dec 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo06OTF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4B20E011;
	Thu, 12 Dec 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996643; cv=none; b=poERMgV6Jxy6bhkm+snKWBhhecEYNNilK49s78NAejFXFuEg40fJCZ/6Q192HmgnsX/kItOUsGNYO984KkEaX1w5O2sZwN3LpvLD+NMiCx1xEaa5wgSkPbS78qT8VsSqw5mclFxtE66inDFPKhA+nxuSWbx6+56U00nG8IAg+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996643; c=relaxed/simple;
	bh=xW8UtOL2UXi7yjUrl55suIta7E2vXsUZs6DEyaUeOyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOJjKEf/QchCRaI8fXaSeYVADhTXlzX0L1zhpPvr7+WVVzJ7tbWjzLKMaBEAaQDp8QsdY7Ffc0M4QWaqTrYI7A/q5PL0Xd82diboMOUIJrL/Mu2UYFOXN/mnOrTq6GcC8Zi/ULJ4//ZlSO0UKRq275u0QpddOXBxqsHBRx+uZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo06OTF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB5FC4CECE;
	Thu, 12 Dec 2024 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733996643;
	bh=xW8UtOL2UXi7yjUrl55suIta7E2vXsUZs6DEyaUeOyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mo06OTF2QLXnpk8pJD3fhIIcycZOR79JprHYTH7ei1OcIWL8la70QaOZRvQAZ/uhH
	 efcOtwXVSLO9VOCO9x5ULnaJ7DwHFcOCcEntyNLmi/Iu/7g/2jd306WupYjI6y0+wO
	 ktRnAY1Mo0dkvdrjOf8TxDnjC40rgrHbXgCdRdWzu5pBaFScQe29QKV8bx1Ht6p/yK
	 xxZh1p2A4AGpgYwjwDGLHT0h8f047G8xWECSF19NHyiopXQGbGG+oswKYGiOGFrtQa
	 jhgNM2mo7+yEnVhXyC1rOA7HWve1/N+sKlmUj7UuDqblpbSwgnId2nys15xpoUBgbB
	 oEBzoq5YD4Xnw==
Date: Thu, 12 Dec 2024 10:43:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <Z1qwXYtO4pBswIXS@ryzen>
References: <Z014ylYz_xrrgI4W@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z014ylYz_xrrgI4W@stanley.mountain>

On Mon, Dec 02, 2024 at 12:07:22PM +0300, Dan Carpenter wrote:
> Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.
> 
> Fixes: 945648019466 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> v2: Update the git hash for the Fixes tag because the tree was rebased I guess.
> 
>  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 1064b7b06cef..34162ca14093 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -784,6 +784,7 @@ static int rockchip_pcie_ep_init_ob_mem(struct rockchip_pcie_ep *ep)
>  						  SZ_1M);
>  	if (!ep->irq_cpu_addr) {
>  		dev_err(dev, "failed to reserve memory space for MSI\n");
> +		err = -ENOMEM;
>  		goto err_epc_mem_exit;
>  	}
>  
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

