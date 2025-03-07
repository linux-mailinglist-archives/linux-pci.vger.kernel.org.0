Return-Path: <linux-pci+bounces-23140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D541A56F11
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83863B01F2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705123FC41;
	Fri,  7 Mar 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWydQl1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0321ADD1;
	Fri,  7 Mar 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368766; cv=none; b=K7tIyyVK5GrsQJztdjaTAaAdEquULPyn66lGme3VSPlF6oA5reUhzdaTvlAcqYrvziuXb5Lx85Xh+FrC8KPbKuZTmaeUCKsTf4Hsi4eRPW7shxtP687VoicxP5UNhnaYwq620b3iUq2dGYL3IVnzqltVCqFOIRazscQgMwZjqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368766; c=relaxed/simple;
	bh=WaR8Hp3zZgrEznc1nNzL6QtdxY+vpz769bjSbkaRDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NQgQo5jB0fg262UO4QmV0DnOnT4CKcj698NUYd6n8LFEGUJnvakFRJ6ICq73g36EvgHVev8r84DmPGJMcfKJ382Q1VlHl6HOl+/veomXofOhT6MWIXILQTviRGJeBtKyCCzT4A1EEi0bsqr/YeFQriPlXbHE0YZjyP7GYYy65cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWydQl1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593E8C4CEE2;
	Fri,  7 Mar 2025 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741368766;
	bh=WaR8Hp3zZgrEznc1nNzL6QtdxY+vpz769bjSbkaRDtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VWydQl1ouWatZjN1BxQykGaogd6yzRp9NuQDpU17bcfvNecoyprCI2imQr2j6U54r
	 USZVPuNzXwLvJLwfrGRvgpLJ5i02f3OrNiZD/fEGcUZllb/cqQ6AuBIYdYvtMxsTQA
	 c6BKtBGzfzCYmMFA1OLkLwdiT/Q6S43EupaCFKi2F9coekpSxBi7qvfGseZwIiwPkr
	 U7ucLJj+SbBjYBvov9hPcC4KeaZ7kzMx4lwULdCccub/1SJHw8wNMY5PNq/UO+l4Ju
	 0ltjNvdOUqfWedNMKmbQNxESocxh+hXn+kxqw85Jvv5lGZ3xVSbNbXVpWkdSeCLFt4
	 X6jHqME6bAjkg==
Date: Fri, 7 Mar 2025 11:32:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com, cassel@kernel.org,
	christian.koenig@amd.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250307173245.GA414123@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307053535.44918-1-daizhiyuan@phytium.com.cn>

On Fri, Mar 07, 2025 at 01:35:29PM +0800, Zhiyuan Dai wrote:
> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to
> pci_rebar_get_possible_sizes() to read the additional Capability bits
> from the Control register.
> 
> If 8EB support is required, callers will need to be updated to handle u64
> instead of u32. For now, support is limited to 128TB, and support for
> sizes greater than 128TB can be deferred to a later time.
> 
> Expand the alignment array of `pbus_size_mem` to support up to 128TB.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Replaced the v3 patch that was already applied with this v4 patch,
thanks.

Please:

  - Include a changelog below the "---" marker to tell me what changed
    between v3 and v4.

  - Don't include Reviewed-by from people who haven't explicitly
    replied with that tag.  In this case, arguably you could retain
    those from Christian and Niklas, because they did give that tag
    for v3, and you only added the pbus_size_mem() change.

    But Ilpo only gave you a comment on v3, and did *not* supply his
    Reviewed-by.  You should never create a Reviewed-by tag in that
    event.

    I dropped all the Reviewed-by tags for now; happy to add them
    if/when the reviewers actually supply them.

> ---
>  drivers/pci/pci.c             | 4 ++--
>  drivers/pci/setup-bus.c       | 2 +-
>  include/uapi/linux/pci_regs.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..77b9ceefb4e1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the spec
> - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
>   */
>  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  {
> @@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>   * pci_rebar_set_size - set a new size for a BAR
>   * @pdev: PCI device
>   * @bar: BAR to set size to
> - * @size: new size as defined in the spec (0=1MB, 19=512GB)
> + * @size: new size as defined in the spec (0=1MB, 31=128TB)
>   *
>   * Set the new size of a BAR as defined in the spec.
>   * Returns zero if resizing was successful, error code otherwise.
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 5e00cecf1f1a..edb64a6b5585 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1059,7 +1059,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, win_align, align, size, size0, size1;
> -	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
> +	resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
>  	int order, max_order;
>  	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..ce99d4f34ce5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1013,7 +1013,7 @@
>  
>  /* Resizable BARs */
>  #define PCI_REBAR_CAP		4	/* capability register */
> -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
>  #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
> -- 
> 2.43.0
> 

