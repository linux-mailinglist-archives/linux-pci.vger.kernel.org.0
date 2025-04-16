Return-Path: <linux-pci+bounces-26047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABABA90D3F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 22:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CE45A23FC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2D229B3C;
	Wed, 16 Apr 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKd7z5T9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD021F8937;
	Wed, 16 Apr 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744836053; cv=none; b=bO1b1xwRD7PJkeLRx5bJG9fP27pXRvSwBIkKeOm0u6UhCtgQM8R8/zUdBx5XAaJdegYHE+gfv/v/XzRGF61+0P/JHGAoQNZqhzI/iSwnJIOgbT4es2A/ipARyYGUg93ACTs70iFRTm6Ll3Tz78tWSoeWeGe29UN+Zww5YTSKjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744836053; c=relaxed/simple;
	bh=EvvTI2dVum18RivfEtnLiFFNULxxc8d7/TvWnBJ57e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rUM+oJOCcEDgllGGPXp65PUN8evR8ft1R/Mras3QmJibFTqZBJxVauWki5rX6PyKOJH7EGtwwLnQ3GADLOPIQcGpSD28umBoNETirpOAfwE1g6VilRUlxDfNN67HMbBLYH90gUdDzC+E3YEE/cfbBnNVWHlwXVYCKQ71PgMArv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKd7z5T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5B9C4CEE4;
	Wed, 16 Apr 2025 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744836053;
	bh=EvvTI2dVum18RivfEtnLiFFNULxxc8d7/TvWnBJ57e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eKd7z5T9E+knRBpQ3jKb/8ftx91rIF0bQBduS15ZAE2ht6hl19zLfGIL9jHC8vshl
	 ykdizw73AakIuy3I1ly2//T08eeyRE3ODKNdIFqgSHtB8hcBfBJ4LJzlAXzQu/t7Zm
	 SxWbJqE5V3eH2DBbGvY8tdy1KPA+cXGIi7fCUQ0pQrR4Qsloroe1ehc3TYdmQyzw9q
	 N9vYSg1SXVhHXpRvwzpeWwPWveWbjNh0kAPClbvhKFeY/KZ3j7OEnAqbmNQSYWp/AH
	 pkrq53hr0Xo0jqC6lng23FIZb2jtzv4zasaBJGtDpm9etx3bJvK3BIgUA6SyMXkGwn
	 T9sqLP0GT211Q==
Date: Wed, 16 Apr 2025 15:40:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <20250416204051.GA78956@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416151926.140202-1-18255117159@163.com>

On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
> The RK3588's PCIe controller defaults to a 128-byte max payload size,
> but its hardware capability actually supports 256 bytes. This results
> in suboptimal performance with devices that support larger payloads.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7ebd118..5bbb536a2576 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -477,6 +477,22 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static void rockchip_pcie_set_max_payload(struct rockchip_pcie *rockchip)
> +{
> +	struct dw_pcie *pci = &rockchip->pci;
> +	u32 dev_cap, dev_ctrl;
> +	u16 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	dev_cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCAP);
> +	dev_cap &= PCI_EXP_DEVCAP_PAYLOAD;
> +
> +	dev_ctrl = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> +	dev_ctrl &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +	dev_ctrl |= dev_cap << 5;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, dev_ctrl);
> +}

I can't really complain too much about this since meson does basically
the same thing, but there are some things I don't like about this:

  - I don't think it's safe to set MPS higher in all cases.  If we set
    the Root Port MPS=256, and an Endpoint only supports MPS=128, the
    Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
    that case the RP may respond with a 256-byte payload the Endpoint
    can't handle.  The generic code in pci_configure_mps() might be
    smart enough to avoid that situation, but I'm not confident about
    it.  Maybe I could be convinced.

  - There's nothing rockchip-specific about this.

  - It's very similar to meson_set_max_payload(), so it'd be nice to
    share that code somehow.

  - The commit log is specific about Max_Payload_Size Supported being
    256 bytes, but the patch actually reads the value from Device
    Capabilities.

  - I'd like to see FIELD_PREP()/FIELD_GET() used when possible.
    PCIE_LTSSM_STATUS_MASK is probably the only other place.

These would be material for a separate patch:

  - The #defines for register offsets and bits are kind of a mess,
    e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
    PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
    PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
    names, and they're not even defined together.

  - Same for PCIE_RDLH_LINK_UP_CHGED, PCIE_LINK_REQ_RST_NOT_INT,
    PCIE_RDLH_LINK_UP_CHGED, which are in
    PCIE_CLIENT_INTR_STATUS_MISC.

  - PCIE_LTSSM_ENABLE_ENHANCE is apparently in
    PCIE_CLIENT_HOT_RESET_CTRL?  Sure wouldn't guess that from the
    names or the order of #defines.

  - PCIE_CLIENT_GENERAL_DEBUG isn't used at all.

>  static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				      struct rockchip_pcie *rockchip)
>  {
> @@ -511,6 +527,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  	pp->ops = &rockchip_pcie_host_ops;
>  	pp->use_linkup_irq = true;
>  
> +	rockchip_pcie_set_max_payload(rockchip);
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize host\n");
> 
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> -- 
> 2.25.1
> 

