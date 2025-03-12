Return-Path: <linux-pci+bounces-23543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B43A5E6C0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED038178EBB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D291E2823;
	Wed, 12 Mar 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7peAbpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACF1662F1;
	Wed, 12 Mar 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816023; cv=none; b=RI2z1Zc7SkBQJQZNRITsaWWCzCNzJSVinjbCt3NgIQJ3noyl8HWOapgYAKZdOnap8sb26+UMU4UuXc0hfv7CAjYe2wUxIOZC9hoBjNI/FU6iT94+rpz9ek7NwNO/UcU0/rQWIXyQToKFseLnJt1mutnyxIZttrU8NOTR2y9Xsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816023; c=relaxed/simple;
	bh=eukJfZ9lLW2zVXuJ19t/+gNkbCNm+nSMBj7VGlDh7R4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xr4rZz7pCL3oqGdW38ViVrZEpoGwvf+bqwXZW863YXwUkyNfsFAnv8XhbJnjfRAxqfh24080l4M3FCWzJDv8gp5/+eTIr1r6CRAWmzlhZa5qswz+wNFI8gZvZj38x/u/8njFi4oh89nftU+y1vOB8v9flJ4ssdeHM6IwbPbKN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7peAbpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237DAC4CEDD;
	Wed, 12 Mar 2025 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741816022;
	bh=eukJfZ9lLW2zVXuJ19t/+gNkbCNm+nSMBj7VGlDh7R4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S7peAbpQbGMzX3T47ZwjFOUvtYLAA9TG1NmfFHLT4cKlayaOCdIaXuKBmBbPtcQqi
	 yD1eRfVjG2/9w23hUlqrcvoB7ZeImSFosNLcfld3E2n4LFkWc+fMuh0nAmqCq7vEXi
	 MMrwdR9zHrd0EuoXCxSVzdw5PZHekzIbznL18rz4l0l5xn5Ft6tNwTQN5b+VVE4VKH
	 hDCQykz6hnGsksUFPvytnXMx0P1cNMAS122LN8IpNVhueFUjnabpwSnqlBTVtNkF/B
	 ww6pS817d6S7VGYdsIBsOCWHPzH3ZqcZOq8yh0CE5DWz74vJ5bsB2f43MUppiQEUUt
	 luQSd19EsinVg==
Date: Wed, 12 Mar 2025 16:47:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v10 09/10] PCI: dwc: ep: Ensure proper iteration over
 outbound map windows
Message-ID: <20250312214700.GA710620@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-pci_fixup_addr-v10-9-409dafc950d1@nxp.com>

On Mon, Mar 10, 2025 at 04:16:47PM -0400, Frank Li wrote:
> Most systems' PCIe outbound map windows have non-zero physical addresses,
> but the possibility of encountering zero increased with commit
> ("PCI: dwc: ep: Add bus_addr_base for outbound window").

What is this commit?  I don't see it in the tree, and I don't see it
in this series.

It look like it might be a fixup for something in this series.  In
that case it should go *before* the other commit (or be squashed into
it if it's logically part of it).

I don't think this series touches ep->ob_window_map, so if it's a fix
it looks like it could go anywhere earlier.

> 'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
> some hardware, which trims high address bits through bus fabric before
> sending to the PCIe controller.
> 
> Replace the iteration logic with 'for_each_set_bit()' to ensure only
> allocated map windows are iterated when determining the ATU index from a
> given address.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v9 to v10
> - remove commit hash value
> 
> change from v8 to v9
> - new patch
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 62bc71ad20719..e333855633a77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	u32 index;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	for (index = 0; index < pci->num_ob_windows; index++) {
> +	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
>  		if (ep->outbound_addr[index] != addr)
>  			continue;
>  		*atu_index = index;
> 
> -- 
> 2.34.1
> 

