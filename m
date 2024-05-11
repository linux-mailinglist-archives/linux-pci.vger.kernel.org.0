Return-Path: <linux-pci+bounces-7384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2298C33B5
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 22:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17198B21076
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB692200C7;
	Sat, 11 May 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DymBGjiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9E3C2D;
	Sat, 11 May 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715458560; cv=none; b=GXVJ0o/NZiqd/e3E2h0mDX7MxXcXD74jh6eqjOj7bQF4KS5MMflAutqprkOaoXeHNIfwSyBfYBXCGoMC4qhEduyC2E4n466hjuxfteBuqb5K7exaQe7vN7V7PP9MJmUP52/etO4qGLTXB7cjF3O1iBLUDTZik7rgAraJLLyZ1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715458560; c=relaxed/simple;
	bh=1IjAiNYUYctqDc35nFzL2DbzK5lYGMO8OblnXldLPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e78/789EpAKfXlzjhKb79+giW1wUFsFRq92oaH55ItGTShcGCTytsNv9npJi/EcjqoGEABoDk+W+N4gdW0s37FQZw2wu0as7eT1J0+0K7NBatxRv03vNup2T1OebeFPcTWxMaOmNUrIT81UhgteaaSldfOZtmbrXzPt2wNS/T7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DymBGjiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FCC2BBFC;
	Sat, 11 May 2024 20:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715458560;
	bh=1IjAiNYUYctqDc35nFzL2DbzK5lYGMO8OblnXldLPxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DymBGjiZNPVCIetlZ/T6O+8Es8jsNNxDZN+q+kXLRewWQeEKehHcdopzx8pQqOIzA
	 pjtj7wBSii/hrlGiOdR9OhsPUVCq/wXhe0qUXSFWdM6hqYccgyzTubuTz8cZef9l9J
	 YjAYjBdhjczWyFJUvnz6IR8gNhUAro1JitTuci2FwDVKhqrNoLaQp1zggr2WzcoisD
	 SS9aDlZ+UYCfGRG1MUVBkoWvsN9R5gMvqXJgwkJh1vmnLkpYVLXVzoEiBxUU2ykppJ
	 wV6AAFu2pHlrY+byJ2wEBKi9r2vJa9ysz2BL8rTALsjbI1iiG513k0SW7HgTrx3gpD
	 6+89gGMUYOISg==
Date: Sat, 11 May 2024 21:15:54 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 5/9] PCI/TPH: Introduce API functions to get/set
 steering tags
Message-ID: <20240511201554.GV2347895@kernel.org>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-6-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509162741.1937586-6-wei.huang2@amd.com>

On Thu, May 09, 2024 at 11:27:37AM -0500, Wei Huang wrote:
> This patch introduces two API functions, pcie_tph_get_st() and
> pcie_tph_set_st(), for a driver to retrieve or configure device's
> steering tags. There are two possible locations for steering tag
> table and the code automatically figure out the right location to
> set the tags if pcie_tph_set_st() is called. Note the tag value is
> always zero currently and will be extended in the follow-up patches.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Hi Eric and Wei,

I noticed a few minor problems flagged by Sparse
which I'd like to bring to your attention.

> ---
>  drivers/pci/pcie/tph.c  | 383 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-tph.h |  19 ++
>  2 files changed, 402 insertions(+)
> 
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c

...

> +/*
> + * For a given device, return a pointer to the MSI table entry at msi_index.
> + */
> +static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
> +					  __le16 msi_index)
> +{
> +	void *entry;
> +	u16 tbl_sz;
> +	int ret;
> +
> +	ret = tph_get_table_size(dev, &tbl_sz);
> +	if (ret || msi_index > tbl_sz)

While tbl_sz is a host-byte order integer value, msi_index is little endian.
So maths operations involving the latter doesn't seem right.

Flagged by Sparse.

> +		return NULL;
> +
> +	entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;

Likewise, there seem to be endian problems here here.

Also, entry is used on the line above and below in a way
where an __iomem annotation is expected, but entry doesn't have one.

Also flagged by Sparse.

> +
> +	return entry;
> +}

...

> +/* Write the steering tag to MSI-X vector control register */
> +static void tph_write_tag_to_msix(struct pci_dev *dev, int msix_nr, u16 tag)
> +{
> +	u32 val;
> +	void __iomem *vec_ctrl;
> +	struct msi_desc *msi_desc;
> +
> +	msi_desc = tph_msix_index_to_desc(dev, msix_nr);
> +	if (!msi_desc) {
> +		pr_err("MSI-X descriptor for #%d not found\n", msix_nr);
> +		return;
> +	}
> +
> +	vec_ctrl = tph_msix_vector_control(dev, msi_desc->msi_index);

According to Sparse, the type of msi_desc->msi_index is unsigned short.
But tph_msix_vector_control expects it's second argument to be __le16.

> +
> +	val = readl(vec_ctrl);
> +	val &= 0xffff;
> +	val |= (tag << 16);
> +	writel(val, vec_ctrl);
> +
> +	/* read back to flush the update */
> +	val = readl(vec_ctrl);
> +	msi_unlock_descs(&dev->dev);
> +}

...

