Return-Path: <linux-pci+bounces-12786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7E96C833
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B954CB21F01
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84961E8B7A;
	Wed,  4 Sep 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AynawN8f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945711E7672;
	Wed,  4 Sep 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480697; cv=none; b=q1VTd+o6myowgrjVmHYFmYfQ81pKTpegxcamLy5UQyTL1ssRmbJDxO5VxxMMC7r8YIKFbZzqO7Ji35vdFeJ1Fxd3R/aplMpuMqhT1cEMmXa3foWTjIug6SZQDMLYpRu/pCUzuRgQzOGRtNxdpp2a4mZwz56p85BSNnaVVJ03AwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480697; c=relaxed/simple;
	bh=NqUCa7k/9EQcORVIPcZpHoRGyQcndPp3txYCyR9RNpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kZ/xrPvEU6jYS15tXJq7hn4pAOoD2dNUrgeqn4mnWwkrC9T+xq9pYyP5w6mWE6iPhDWDll/D0fU90JZLA5SIEkpHcs7Xd7XCXHvFUEI9kfOSVs3yOJtdgbdkar/pKkhLRV0+GnoHqukE0soYrD6YejG4cVYfIZFELvzNh8vudY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AynawN8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C232C4CEC9;
	Wed,  4 Sep 2024 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480697;
	bh=NqUCa7k/9EQcORVIPcZpHoRGyQcndPp3txYCyR9RNpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AynawN8f0LObpCPANKKj4uyYdHeox3Zx6Pjfs+MzfN+zNTG4HAOgHSNWJgX1Wgt8c
	 hx1PoJqXrDQTKUaSx2z6oeDElr3hIqYS+U54D4C2yOFQO31qhG6wTrexyiT5CLq3sS
	 7Xu093xth4dlNVTUR/DFd4cqXP3WVLJ3PbHn394tI++aePnE1WxNm3XOhaGJ5gQikz
	 baPx1OJHJ+rzssGPn9/mPrP2c3IIGpuX8kCsTUc52/BKHsAoCOhr66F1nuzOPhE+od
	 Ff4N05P7ua6xIadW8HD57QrcmNAcDpvjQC7vbPSikGWyMqOXPQvy7JvOAUtM198Ptf
	 PQioTQ54CoWIg==
Date: Wed, 4 Sep 2024 15:11:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 09/12] PCI/TPH: Add save/restore support for TPH
Message-ID: <20240904201134.GA345594@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-10-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:17PM -0500, Wei Huang wrote:
> From: Paul Luse <paul.e.luse@linux.intel.com>
> 
> Save and restore the configuration space for TPH capability to preserve
> the settings during PCI reset. The settings include the TPH control
> register and the ST table if present.

> +void pci_restore_tph_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int num_entries, i, offset;
> +	u16 *st_entry;
> +	u32 *cap;
> +
> +	if (!pdev->tph_cap)
> +		return;
> +
> +	if (!pdev->tph_enabled)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
> +	if (!save_state)
> +		return;
> +
> +	/* Restore control register and all ST entries */
> +	cap = &save_state->cap.data[0];
> +	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
> +	st_entry = (u16 *)cap;
> +	offset = PCI_TPH_BASE_SIZEOF;
> +	num_entries = get_st_table_size(pdev);
> +	for (i = 0; i < num_entries; i++) {
> +		pci_write_config_word(pdev, pdev->tph_cap + offset,
> +				      *st_entry++);
> +		offset += sizeof(u16);
> +	}
> +}
> +
> +void pci_save_tph_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int num_entries, i, offset;
> +	u16 *st_entry;
> +	u32 *cap;
> +
> +	if (!pdev->tph_cap)
> +		return;
> +
> +	if (!pdev->tph_enabled)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
> +	if (!save_state)
> +		return;

Don't we need a pci_add_ext_cap_save_buffer() somewhere for this?
E.g., in pci_tph_init()?

> +	/* Save control register */
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
> +
> +	/* Save all ST entries in extended capability structure */
> +	st_entry = (u16 *)cap;
> +	offset = PCI_TPH_BASE_SIZEOF;
> +	num_entries = get_st_table_size(pdev);
> +	for (i = 0; i < num_entries; i++) {
> +		pci_read_config_word(pdev, pdev->tph_cap + offset,
> +				     st_entry++);
> +		offset += sizeof(u16);
> +	}
> +}
> +
>  void pci_tph_init(struct pci_dev *pdev)
>  {
>  	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
> -- 
> 2.45.1
> 

