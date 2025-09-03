Return-Path: <linux-pci+bounces-35408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C79B42C73
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E36A206839
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5432D3EE1;
	Wed,  3 Sep 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N20+XeY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DB1917FB
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936995; cv=none; b=pdWSPorn5OM+c4+HUbDMOGl7YVc1X9xdmnPcw3KeqfUXVRIV87OZ2Azk1173ToGrFpO3bRsESRRFyCnItjSVVk2oD/okNSp1lcmmlAY/4wXj7BjWyMj8A643ZGzWWbZGbSTgxSCW/x6eSlUgA80U3i3FPExbh29MhO+VCvs9oCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936995; c=relaxed/simple;
	bh=WLfMKb1ZqppjS33fU+aw0W+/8EBIFjvK/nk5xTZTR7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QZEeARQp8KVPwilxKpymMv2+MajmGJzMW87SrqafN02lzRzc2FAPBaPCqXu66pCblwynSkxVs+eRlb8DuhquLVKu8VIkVx+LCK+TproE5nWSja2BkYqo0b/WpwLZzzaaz1/5rfqTOmgnFEiCWXVE06MKyy+UVI8oAEvJH/ZIFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N20+XeY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1118FC4CEE7;
	Wed,  3 Sep 2025 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936994;
	bh=WLfMKb1ZqppjS33fU+aw0W+/8EBIFjvK/nk5xTZTR7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N20+XeY4mqUGwpEf/QXux78vqV+WMoTFlBM3tSXA3b15Rj1EVmUasJGP5RC61uFeu
	 0PNEfkHwgL3N8pwJPUz2DZfzCs0pj7QPmK0IGwFSCuVlaCXkFmIbbW4rRWxeNN8H8Z
	 tLwmyTVPKGBaFefIQtJ2MR8vQXPooJQhLMgOQNc5plLuajBuZJSn4gwsYW74xUQt2c
	 uWAwt2Ntf/RSmHZ4haVE8MJ95apz9+tM2SacEw/N1rIJmdLzBwfT6ody8LITXqcr93
	 FjPG/DqDnspQa+ToNTlnUq+tmlNd15j8YVq7MXaTLigWeawAXrViLNt6jTheR3G7jl
	 7CfyX+oGQDzuw==
Date: Wed, 3 Sep 2025 17:03:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] PCI/P2PDMA: Reduce scope of pci_has_p2pmem function
Message-ID: <20250903220312.GA1234784@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40f3f1decf54c9236bc38b48a6aae612a5c182f.1756900291.git.leon@kernel.org>

On Wed, Sep 03, 2025 at 02:52:56PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_has_p2pmem() function is not used outside of p2pdma.c and there is
> no need in EXPORT_SYMBOL_GPL for this function at all.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to pci/p2pdma for v6.18, thanks!

> ---
>  drivers/pci/p2pdma.c       | 3 +--
>  include/linux/pci-p2pdma.h | 5 -----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 3fa1292c8d91..988e7788c68e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -787,7 +787,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_distance_many);
>   * pci_has_p2pmem - check if a given PCI device has published any p2pmem
>   * @pdev: PCI device to check
>   */
> -bool pci_has_p2pmem(struct pci_dev *pdev)
> +static bool pci_has_p2pmem(struct pci_dev *pdev)
>  {
>  	struct pci_p2pdma *p2pdma;
>  	bool res;
> @@ -799,7 +799,6 @@ bool pci_has_p2pmem(struct pci_dev *pdev)
>  
>  	return res;
>  }
> -EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>  
>  /**
>   * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index dea98baee5ce..b9ba63c40e51 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -71,7 +71,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  		u64 offset);
>  int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  			     int num_clients, bool verbose);
> -bool pci_has_p2pmem(struct pci_dev *pdev);
>  struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
>  void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size);
>  void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size);
> @@ -101,10 +100,6 @@ static inline int pci_p2pdma_distance_many(struct pci_dev *provider,
>  {
>  	return -1;
>  }
> -static inline bool pci_has_p2pmem(struct pci_dev *pdev)
> -{
> -	return false;
> -}
>  static inline struct pci_dev *pci_p2pmem_find_many(struct device **clients,
>  						   int num_clients)
>  {
> -- 
> 2.51.0
> 

