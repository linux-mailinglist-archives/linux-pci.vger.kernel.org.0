Return-Path: <linux-pci+bounces-22046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F088A402C4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582077A4CC7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FB1D63C4;
	Fri, 21 Feb 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7RKwM0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22158A944;
	Fri, 21 Feb 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177346; cv=none; b=rE5jr+zIusYnpBBy7EVMzIIySfomlH+qlPYxjC4mGsHzte3EgcbzVgOanDpLZh5DNI9S5disx5n8QqwUCDKNpxSC2Na1gLZ8Ci1qp9WsncU6y9f/rxETTQ7N09yNmkT/sP7FyD2iwy+MiO6DC1EwGW3JklS+z7UK3R7hHVBxzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177346; c=relaxed/simple;
	bh=1mcOLXlU0AURcF3mVdaMpvgweL+7TaLkhfpP3sVJGDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IHy+lqXR9j5nZ1Ca4pvmDMNOS/YWS0vkCLtPoH0bgPsSbvJpKTnyPVVkbwmeaU/ddPSokPoUccOlxykipOnjbx7vs7/UuxC81EpQEhOGOJnKXDv25/rsFQuiaNomK+x7tpDlJiEbx9Iem0tKURgP8A/KZZ1wBw2vXWdN+wNi7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7RKwM0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D77C4CED6;
	Fri, 21 Feb 2025 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740177344;
	bh=1mcOLXlU0AURcF3mVdaMpvgweL+7TaLkhfpP3sVJGDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m7RKwM0ASUxKpxyVu/J7f3x8uj/pqRE+UJ9zGsZRBw5bBPyWEfxDbA8aUrXyYfTNK
	 2nuYZsWibqoI3PgRsQvnEOgEovUdwhdsfE9k/Bye9MVsCu/NI2JtEu76zcYnr1P3ze
	 +ytqld9ewvBAFsBwXW3NOmFr9DjiKtA/c9t6SEK+2v/uw6i6Ic63Pj3+rrlMiiTSzp
	 6zSqe5GsPc4PBnn2pQESjpm0H8A+URs0WYGTXSOXHgvHc/SzSewe02412iEQXtaltV
	 p35X4NSjbauf+f5V+tr2CxsdBWdf7MGFRBgymQCCyZJrBA4ORo14/UMMFE8yYCdAUw
	 rC2XGd5pF+fuQ==
Date: Fri, 21 Feb 2025 16:35:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: bhelgaas@google.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250221223543.GA369205@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220012546.318577-1-daizhiyuan@phytium.com.cn>

On Thu, Feb 20, 2025 at 09:25:46AM +0800, Zhiyuan Dai wrote:
> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
> to read the additional Capability bits from the Control register.
> 
> If 8EB support is required, callers will need to be updated to handle u64 instead of u32.
> For now, support is limited to 128TB, and support for sizes greater than 128TB can be
> deferred to a later time.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

Applied to pci/resource for v6.15, thanks!

> ---
>  drivers/pci/pci.c             | 4 ++--
>  include/uapi/linux/pci_regs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
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

