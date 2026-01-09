Return-Path: <linux-pci+bounces-44384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D99BD0B126
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 16:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63343036CB3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A95280A5B;
	Fri,  9 Jan 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhdOUxd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80133500952;
	Fri,  9 Jan 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974032; cv=none; b=H2/GdcGonFGtvUpU6AjMlKNIt1qHoQqpNsMrSYYbMTbd2+UpCOFs2TelmjUhZ2asN3/qCbRD0qISriL4S5PuFQre9u8KOY1DpTAeCxb+Sh0RCml3B7dcW4z/7cfDGOrHRC/OhBdfEih7YHE5aN0jT22lAjkK9yc+N8xUI2zeG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974032; c=relaxed/simple;
	bh=zK0zjHRUg0EscVVeO0n2jsonL23Wr5elXJuCtQlfIvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EtrV1bZr+9dNHNIHn6BZTKf3pPnuxW0HURktC77dd+kv1uZOkV8GXRDi8SUK7PFT0QI1w+N5pbOk65rF/Oz1iUkMegrxAAKM4P6G5fEtE55xxeQp+cguxpmBJ2C4Re7ethSnE1D9RBlj2K2NRSVXyd9/GMSlLxYR/xZdNcIWYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhdOUxd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06978C4CEF1;
	Fri,  9 Jan 2026 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767974032;
	bh=zK0zjHRUg0EscVVeO0n2jsonL23Wr5elXJuCtQlfIvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nhdOUxd1lM18hERN+FcC1kmau3i2OjE4BlxSBRaiAzLUMZv1JsAEAbAjHgrRHrdD+
	 AsPy6IDmAIInpzBYpN6EEwRhmi7oP9XRmoShYZ4o0BgSPgAJNXRVNtEEr9Jk3sjoBk
	 cqqaPPoRDuidy47fVBzdphqqnG4yZkmwvSiSFIdpvNV3bKdZUEhdogogHqhZqfWk2V
	 SCpG/goOIC+C2cbwH4qji80ADLcLZt7gJzQyV3bEkaEbph3Yo0LLo0//4iMW/a3D/X
	 xMOTj0Yxs4AcQM/dumYzVEcza1O0YfbqVUfL4M0kHjubZd88mAbiR6zHKiGoH2eKWQ
	 NUjY7Cuy1q7bQ==
Date: Fri, 9 Jan 2026 09:53:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: dwc: Add support for retaining link during host
 init
Message-ID: <20260109155350.GA546142@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-link_retain-v1-2-7e6782230f4b@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 12:51:07PM +0530, Krishna Chaitanya Chundru wrote:
> Some platforms keep the PCIe link up across bootloader and kernel
> handoff. In such cases, reinitializing the root complex is unnecessary
> if the DWC glue drivers wants to retain the PCIe link.
> 
> Introduce a link_retain flag in struct dw_pcie_rp to indicate that
> the link should be preserved. When this flag is set by DWC glue drivers,
> skip dw_pcie_setup_rc() and only initialize MSI, avoiding redundant
> configuration steps.

It sounds like this adds an assumption that the bootloader
initialization is the same as what dw_pcie_setup_rc() would do.  This
assumption also applies to future changes in dw_pcie_setup_rc().

It looks like you mention an issue like this in [PATCH 4/5]; DBI & ATU
base being different than "HLOS" (whatever that is).  This sounds like
a maintenance issue keeping bootloader and kernel driver assumptions
synchronized.

Is there something in dw_pcie_setup_rc() that takes a lot of time or
forces a link retrain?  You mentioned some clock and GENPD issues in
the cover letter, but I don't see the connection between those and
dw_pcie_setup_rc().  If there is a connection, please include it in
this commit log and include a code comment about why
dw_pcie_setup_rc() is being skipped.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 372207c33a857b4c98572bb1e9b61fa0080bc871..d050df3f22e9507749a8f2fedd4c24fca43fb410 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -655,9 +655,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_free_msi;
>  
> -	ret = dw_pcie_setup_rc(pp);
> -	if (ret)
> -		goto err_remove_edma;
> +	if (!pp->link_retain) {

Use positive logic if possible (test "pp->link_retain" instead of
"!pp->link_retain").

I suspect this would be more maintainable if you identified specific
things *inside* dw_pcie_setup_rc() that need to be skipped, and you
added tests there.

> +		ret = dw_pcie_setup_rc(pp);
> +		if (ret)
> +			goto err_remove_edma;
> +	} else {
> +		dw_pcie_msi_init(pp);
> +	}
> +
>  
>  	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 31685951a080456b8834aab2bf79a36c78f46639..8acab751b66a06e8322e027ab55dc0ecfdcf634c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -439,6 +439,7 @@ struct dw_pcie_rp {
>  	struct pci_config_window *cfg;
>  	bool			ecam_enabled;
>  	bool			native_ecam;
> +	bool			link_retain;
>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.34.1
> 

