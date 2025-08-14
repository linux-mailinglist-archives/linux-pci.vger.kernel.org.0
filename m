Return-Path: <linux-pci+bounces-34064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616BEB26BC6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C37AA817A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED58242D6C;
	Thu, 14 Aug 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpJFIplf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED5199924;
	Thu, 14 Aug 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186917; cv=none; b=ecTZWMtVYnKXgFa1vt3LWMtVO0sz6rMLVbDhiph/g7MeF9nPB43jP796FLHUIgkytRvf5INY5GKJZiSKgc3AozIwzoy1/x6a4GMCUbj8DaZ2tcBSdHiITT9LG8zZya9uItsPZDbtXhgMRJ0jckTE0lNSy3G+xmMp+8W3FWCdBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186917; c=relaxed/simple;
	bh=pNoOMxoVif7AoyiRpnN5xwsXW1L4F+EIAdkruCe1QFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BcGJTdlqhqP+fznR3v3wZHtOamPkckcGDnBC+bSejudm6DpUr/7t8/g4MubFyxobVuDBNHIP1FjSu6mg8LDyynkIf51J90pbAPPWamZKmKe0fsRI5Mw1fnCLP0YcitI2kuvmwjRvI3SWB2ICmQPcuinP3uGCvCNpDEIQGG0hX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpJFIplf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C00C4CEED;
	Thu, 14 Aug 2025 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186917;
	bh=pNoOMxoVif7AoyiRpnN5xwsXW1L4F+EIAdkruCe1QFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dpJFIplfKFLWyg/RslYgpbmCzo4bCDaJEg1wvvhJkucH96EJtmrTfS6ui5cgoBHq5
	 BTVY51h7fshM/ahs+3IBJjPFTS6Yz/ORaKvEezn8N4dMsDDo0ipA9bbPK1c1xWNB+V
	 EzWrKazjdJawzhH0SMQWtoJkVaI3gKssk6YZc43axvIW0E3GRW2+lPMmrnBOxcxSXe
	 Cb5J2AY3k4zGUP30qJJ+KyRp4FkyFdbtseORRlGvW4HHbiNl9ai/8F/D4OF0gkfsS4
	 06aqNBl/J4lfwdUxKPViKJ0Dz6rtVxwPTQGwr8416bf4oAgc8xCjorSCJnbt+U8wnE
	 N7ELI2pSPRR1A==
Date: Thu, 14 Aug 2025 10:55:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	regressions@lists.linux.dev
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250814155515.GA331116@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611101442.387378-1-hui.wang@canonical.com>

On Wed, Jun 11, 2025 at 06:14:42PM +0800, Hui Wang wrote:
> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
> Configuration RRS"), this Intel nvme [8086:0a54] works well. Since
> that patch is merged to the kernel, this nvme stops working.
> 
> Through debugging, we found that commit introduces the RRS polling in
> the pci_dev_wait(), for this nvme, when polling the PCI_VENDOR_ID, it
> will return ~0 if the config access is not ready yet, but the polling
> expects a return value of 0x0001 or a valid vendor_id, so the RRS
> polling doesn't work for this nvme.
> 
> Here we add a pci quirk to disable the RRS polling for the device.
> 
> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
> Link: https://bugs.launchpad.net/bugs/2111521
> Signed-off-by: Hui Wang <hui.wang@canonical.com>

To help keep this top of mind:

#regzbot introduced: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")

> ---
>  drivers/pci/probe.c  |  3 ++-
>  drivers/pci/quirks.c | 18 ++++++++++++++++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..848fa0e6cf60 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1270,7 +1270,8 @@ static void pci_enable_rrs_sv(struct pci_dev *pdev)
>  	if (root_cap & PCI_EXP_RTCAP_RRS_SV) {
>  		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
>  					 PCI_EXP_RTCTL_RRS_SVE);
> -		pdev->config_rrs_sv = 1;
> +		if (!(pdev->dev_flags & PCI_DEV_FLAGS_NO_RRS_SV))
> +			pdev->config_rrs_sv = 1;
>  	}
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index cf483d82572c..519e48ff6448 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6336,3 +6336,21 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Although the root port device claims to support RRS, some devices don't work
> + * with RRS polling, when reading the Vendor ID, they just return ~0 if config
> + * access is not ready, this will break the pci_dev_wait(). Here disable the RRS
> + * forcibly for this type of device.
> + */
> +static void quirk_no_rrs_sv(struct pci_dev *dev)
> +{
> +	struct pci_dev *root;
> +
> +	root = pcie_find_root_port(dev);
> +	if (root) {
> +		root->dev_flags |= PCI_DEV_FLAGS_NO_RRS_SV;
> +		root->config_rrs_sv = 0;
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0a54, quirk_no_rrs_sv);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..f4dd9ada12e4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -247,6 +247,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
>  	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
>  	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
> +	/* Do not use Configuration Request Retry Status polling in pci_dev_wait() */
> +	PCI_DEV_FLAGS_NO_RRS_SV = (__force pci_dev_flags_t) (1 << 14),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.34.1
> 

