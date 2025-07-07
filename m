Return-Path: <linux-pci+bounces-31639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11794AFBBD3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030CF1AA7861
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91526560C;
	Mon,  7 Jul 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx242jD+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE26194094
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917252; cv=none; b=OUC/6h9tj8cVVp9qZtkarIfWN3wu1jfeNmujZKiv72YkbQAUNblwmyDgTbjTpjm59jgIESkxsV6WesIXS+h/x6Z+ivnYjkM3y+OZI4hv1ahvPnGaouSW0Z3uqD1ggEIaXBvsPzIXWF6MStMbQRWOxR23Prl1vMjj/X3rQQGLUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917252; c=relaxed/simple;
	bh=j9UsQGYMM7Ss1VVL7GGS59w8Rq8uJILdYRZjMSoWHno=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XdLe0NSP0u+d7dimMgRyyCnSdbAUV+ktVmVHV2I4b08OtryQQdPF8pdyESAfxkQ9GkmpLtQ1+E8hdsAIEPvdliKFVWq3Lsu/v2RO/WbKPcTblpJMNgMv8dV2w0J8G5Jl+QcaqWc69b+HNb0nx9u3YouPLcvDf5+1OvxG7LdbH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx242jD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54692C4CEE3;
	Mon,  7 Jul 2025 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751917251;
	bh=j9UsQGYMM7Ss1VVL7GGS59w8Rq8uJILdYRZjMSoWHno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Tx242jD+jurrmxNUPCJMFZO7vWTZTWe3m61oSu47mUHlzOSO9bL3x6j13DAjmqNye
	 bOWx4NSrCZs6vRaPOFFXqAdWTrsryiGrDJWET4Lh5V6KLUbtC98GlAk+5nOlJCRib0
	 CuRGZ6437JdYmDjgqvwY0AzK9ElVasnHY1SvgV+gfCbbjtJG4voZTEyn7YDRm6T0n3
	 IKh3pIxVRgQxmJm/aaVfNPHlKVBfY9h0oPAK5pN7sl18J8c5GnYmlOHkAzvfnIuEYv
	 Rd6lUIBAjcTgLr0qWtYqlhwWX1dKb9FOErqU5XCOeN4kOuYAHKaA5b9xHq1B2caLFp
	 uxal6tQigWmUQ==
Date: Mon, 7 Jul 2025 14:40:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/8] pci/tph: Expose
 pcie_tph_get_st_table_size()
Message-ID: <20250707194049.GA2096181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2b18f612dc99bb46c9f5c2690013aeddeacca8.1751907231.git.leon@kernel.org>

On Mon, Jul 07, 2025 at 08:03:01PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Expose pcie_tph_get_st_table_size() to be used by drivers as will be
> done in the next patch from the series.

This series doesn't actually use pcie_tph_get_st_table_size().

Subject line convention would be "PCI/TPH: Expose ..."

> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/tph.c       | 11 ++++++-----
>  include/linux/pci-tph.h |  1 +
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 77fce5e1b830..cc64f93709a4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -168,7 +168,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
>   */
> -static u16 get_st_table_size(struct pci_dev *pdev)
> +u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  	u32 loc;
> @@ -185,6 +185,7 @@ static u16 get_st_table_size(struct pci_dev *pdev)
>  
>  	return FIELD_GET(PCI_TPH_CAP_ST_MASK, reg) + 1;
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_table_size);
>  
>  /* Return device's Root Port completer capability */
>  static u8 get_rp_completer_type(struct pci_dev *pdev)
> @@ -211,7 +212,7 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>  	int offset;
>  
>  	/* Check if index is out of bound */
> -	st_table_size = get_st_table_size(pdev);
> +	st_table_size = pcie_tph_get_st_table_size(pdev);
>  	if (index >= st_table_size)
>  		return -ENXIO;
>  
> @@ -443,7 +444,7 @@ void pci_restore_tph_state(struct pci_dev *pdev)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
>  	st_entry = (u16 *)cap;
>  	offset = PCI_TPH_BASE_SIZEOF;
> -	num_entries = get_st_table_size(pdev);
> +	num_entries = pcie_tph_get_st_table_size(pdev);
>  	for (i = 0; i < num_entries; i++) {
>  		pci_write_config_word(pdev, pdev->tph_cap + offset,
>  				      *st_entry++);
> @@ -475,7 +476,7 @@ void pci_save_tph_state(struct pci_dev *pdev)
>  	/* Save all ST entries in extended capability structure */
>  	st_entry = (u16 *)cap;
>  	offset = PCI_TPH_BASE_SIZEOF;
> -	num_entries = get_st_table_size(pdev);
> +	num_entries = pcie_tph_get_st_table_size(pdev);
>  	for (i = 0; i < num_entries; i++) {
>  		pci_read_config_word(pdev, pdev->tph_cap + offset,
>  				     st_entry++);
> @@ -499,7 +500,7 @@ void pci_tph_init(struct pci_dev *pdev)
>  	if (!pdev->tph_cap)
>  		return;
>  
> -	num_entries = get_st_table_size(pdev);
> +	num_entries = pcie_tph_get_st_table_size(pdev);
>  	save_size = sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>  }
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index c3e806c13d64..9e4e331b1603 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -28,6 +28,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  			unsigned int cpu_uid, u16 *tag);
>  void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> +u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> -- 
> 2.50.0
> 

