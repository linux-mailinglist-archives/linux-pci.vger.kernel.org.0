Return-Path: <linux-pci+bounces-5530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82388950E8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A8E287211
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709660269;
	Tue,  2 Apr 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4MPsNrE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D85F84F;
	Tue,  2 Apr 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055136; cv=none; b=mggMM/45j59a/Awn8SOuPtkKKzfjanUpmrkFZ510xP0IpLmA52CLuVPdKyetyiY7AnWCoPXP0/i9YBjCt/gVBwgKa7mrtFEE7KiX1bzBhc46DAvnWRGOT9okL2vcNlWf/lWlILiMZKMCsLyQuyHWVshN+AjRwRBusurQ1ndbIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055136; c=relaxed/simple;
	bh=8SEISNTjMjd6fQgKPbae4xl+U7OguugiIa4T9Rb5u+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4NGGUgiw7ZfkW2Rtoa3kGu3u+i6NwBp0QLB2x6srCwQquSniUR7eictF99zcPRat32qm6yhxrUvPRD9X/h90/izEGD9u0hvV18YXcUYQrQXfbNPLR9f43xBQYi9Y2dgnyf+zOkjmb/cUAsKktT0ZjiifCkiFir7EmCEXey2c/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4MPsNrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E6C43390;
	Tue,  2 Apr 2024 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055136;
	bh=8SEISNTjMjd6fQgKPbae4xl+U7OguugiIa4T9Rb5u+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4MPsNrE5cmbGK3k1jBmWUG04hQzuCE81mF2+4cRHKWApITQdHRfaZZkH+5ZaYL3I
	 bpgZdFe9kyxMuSY3xTS2joBUZAwPhGareRD9eTIlfYy7Zp+2kJjK3SZhDiioGG0qb2
	 WPKrIa/Hv//QJu7JPaIuP4knMhIpJQXNABg+G3B2Gw6zcSU5OgouIkux49LuCCghfq
	 UKZZYA0JP7FTYeY++6H8GCzbdrFQ5QscjabQPb85kNJ8IafyjcdE2BdFzXnl7i1Wpv
	 2K7ra/QO/nqfSQ9Hul2/wHBA7vGjhK+hX7L+oa7ssB3gngNSqCf2ivruu7waKNfmbc
	 OxLdJaJ2WzRqw==
Date: Tue, 2 Apr 2024 12:52:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 03/10] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to init()
Message-ID: <ZgvjWtC0f1CY6DJs@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-3-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-pci-epf-rework-v2-3-970dbe90b99d@linaro.org>

On Mon, Apr 01, 2024 at 09:20:29PM +0530, Manivannan Sadhasivam wrote:
> core_init() callback is used to notify the EPC initialization event to the
> EPF drivers. The 'core' prefix was used indicate that the controller IP
> core has completed initialization. But it serves no purpose as the EPF
> driver will only care about the EPC initialization as a whole and there is
> no real benefit to distinguish the IP core part.
> 
> So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
> just init() to make it more clear.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
>  drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
>  include/linux/pci-epf.h                       |  4 ++--
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 280863c0eeb9..b3c26ffd29a5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -716,7 +716,7 @@ static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
>  	epf_mhi->dma_chan_rx = NULL;
>  }
>  
> -static int pci_epf_mhi_core_init(struct pci_epf *epf)
> +static int pci_epf_mhi_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>  	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> @@ -897,7 +897,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
>  }
>  
>  static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
> -	.core_init = pci_epf_mhi_core_init,
> +	.init = pci_epf_mhi_epc_init,
>  };
>  
>  static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 973db0b1bde2..abcb6ca61c4e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -731,7 +731,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static int pci_epf_test_core_init(struct pci_epf *epf)
> +static int pci_epf_test_epc_init(struct pci_epf *epf)

On V1 you agreed that it is better to remove 'epc' from the naming.
(For both pci-epf-test and pci-epf-mhi).
You seem to have forgotten to address this for V2.


Kind regards,
Niklas

