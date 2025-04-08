Return-Path: <linux-pci+bounces-25498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7DDA80F2A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421F13A8190
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A213218584;
	Tue,  8 Apr 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4GkieZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9151E521A;
	Tue,  8 Apr 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124323; cv=none; b=iFOhGE8JzrF9u4rGbr+srhMFuPtguOQ4PdBh1kCajz5DFYK2S7dfq6iS6gFwNt8RmFuEBOAxRcVleMiSD7UOmYm9Th60s9vWmjkEKjLPYAdKHfdevb8Ft0kUh2M3ZsvicUE9uOlzu46YBIZdhc5hSjwLzaXNHgIrF98x/lVYa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124323; c=relaxed/simple;
	bh=5qALSFBZ7L1tAKOyN1L/oKlk3jA7LDA7goT+jZYqeQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mrIMN3ilD9cMlYVR1eY7tQpogWL+wx8BranSByhW86xBppr3E5iT4gboH/2jOsnzY6CkMjDN/kbOsYXbHbY9AdXgfKtJovTpHCPoA+Y5VmA8z1to3lPj78UtDL167u1JZUktNADGLJK/Rn3v6RyFyoM0Jp2haeLS3qn6jozJ/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4GkieZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B8C4CEE7;
	Tue,  8 Apr 2025 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124322;
	bh=5qALSFBZ7L1tAKOyN1L/oKlk3jA7LDA7goT+jZYqeQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K4GkieZEjPaQUxrBjrfFf+HbVXS8mw+BEAtGOYNOXTvf4VF8m3MCpnlZPMPOSRlfH
	 8vYR05N6YB7ZEJ5MQ87vjONWAfQkVD6jETSGWA2UFuQ/szVITaH3AIVNLrcoGCj003
	 87PFmhZtVwUET57ZIpb/XhgdSo4xkltqb1f9Zj3ylSM9NY6sqLG6A0EH2344ToQiuD
	 KEgwjURPS77QNjkzaQIq3IlTuPLSVd2U8mTP3DjYmhIOMPV9v8vLBzcvzI8rGj1Y6D
	 9mZLYg6pM+BxUWkElUqJrUaxNif2yaFj/pmr0rTbAPnFBQy4FK5AqLp/ut01PAtYPr
	 T3bEU0hrhAEGA==
Date: Tue, 8 Apr 2025 09:58:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Message-ID: <20250408145840.GA231894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408065221.1941928-2-hongxing.zhu@nxp.com>

On Tue, Apr 08, 2025 at 02:52:18PM +0800, Richard Zhu wrote:
> i.MX6QP PCIe is hang in L2 poll during suspend when one endpoint device is
> connected, for example the Intel e1000e network card.
> 
> Refer to Figure5-1 Link Power Management State Flow Diagram of PCI
> Express Base Spec Rev6.0. L0 can be transferred to LDn directly.

Please include the section number.  Section numbers are easy to find
because they're in the spec PDF contents, but figures are not.  E.g.,
"PCIe r6.0, sec 5.2, fig 5-1"

> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the ltssm state is in L2 or L3 on
> some PME_Turn_Off handshake broken platforms.

Maybe we don't need to poll for these LTSSM states on *any* platform,
and we could just remove the poll and timeout completely?

If not, we need to explain why it is safe to skip the poll on some
platforms.  "Skipping the poll avoids a hang" is not a sufficient
explanation.

s/ltssm/LTSSM/

> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -947,7 +947,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
> @@ -964,15 +964,17 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  			return ret;
>  	}
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> -				val == DW_PCIE_LTSSM_L2_IDLE ||
> -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +	if (!dwc_check_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +					val == DW_PCIE_LTSSM_L2_IDLE ||
> +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			/* Only log message when LTSSM isn't in DETECT or POLL */
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 56aafdbcdaca..05fe654d7761 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -282,6 +282,9 @@
>  /* Default eDMA LLP memory size */
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>  
> +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> +#define dwc_check_quirk(pci, val)	(pci->quirk_flag & val)

Maybe just my personal preference, but I don't like things named
"check" because that just means "look at"; it doesn't give any hint
about how to interpret the result of looking at it.

>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -491,6 +494,7 @@ struct dw_pcie {
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
>  	u32			type;
> +	u32			quirk_flag;
>  	unsigned long		caps;
>  	int			num_lanes;
>  	int			max_link_speed;
> -- 
> 2.37.1
> 

