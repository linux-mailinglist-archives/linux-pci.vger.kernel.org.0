Return-Path: <linux-pci+bounces-43234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA4CC93AC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 19:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73FC3001FDE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33A27BF93;
	Wed, 17 Dec 2025 18:07:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C104143C61;
	Wed, 17 Dec 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994846; cv=none; b=BdlrkriZD1F9iD5nb+LKjPQgeQ/gI38IXWGeSqr4WEl9nCoZ/uyL3JMuZ9nkK/0N1a1vh0N/r7+PXXexQEGZWcdqvpB+gKN4xmfVfFn8vdzM61CSkSVNsn9fd62+WkI+QViYv+Qahdrb7i/4YB8I/haxCfRFVgWfvWGxdruwFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994846; c=relaxed/simple;
	bh=R8mBQ1/29E1J6ez+bZvqQX1Pm7/qzt25+8NO5uK84Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDxDPoACZL2vhHaRv2jKPRX9SF3ugDK7t/935fNhaLg03CLHsipXPQcBiuAZseAbVFNTo7H3LeJYOpMlJ8It6rWExaK69g/P3q8AsBZPsnxHzdAaQ1XSxdRWrdWYM8aDPP9AjUDsqnJfKK5ZcF/bO/08hXoYZxk7ct/V4Zdju5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C82B339;
	Wed, 17 Dec 2025 10:07:15 -0800 (PST)
Received: from [10.1.196.95] (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9836D3F5CA;
	Wed, 17 Dec 2025 10:07:20 -0800 (PST)
Message-ID: <8c9d1129-7943-49f0-aca1-a506dcfa4955@arm.com>
Date: Wed, 17 Dec 2025 18:07:08 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Add PCI_BRIDGE_NO_ALIASES quirk for ASPEED
 AST1150
To: Nirmoy Das <nirmoyd@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 jammy_huang@aspeedtech.com, mochs@nvidia.com
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
 <20251217154529.377586-2-nirmoyd@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251217154529.377586-2-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2025 3:45 pm, Nirmoy Das wrote:
> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
> bridge that causes them to share the same stream ID:
> 
>    [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>                                      \-02.0  ASPEED USB Controller
> 
> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
> USB controller to be rejected with 'Aliasing StreamID unsupported'.
> 
> Per ASPEED, the AST1150 doesn't use a real PCI bus and always forwards
> the original requester ID from downstream devices rather than replacing
> it with any alias.
> 
> Add a new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag and apply it to the
> AST1150.

Looks reasonable to me;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

(Super-nit: perhaps s/ALIASES/ALIAS/ to neatly mirror 
PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS, which amusingly it's pretty much the 
exact opposite of, but I'll leave that to Bjorn's discretion)

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
> v2:
>    - Use new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag instead of
>      PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to only skip aliasing at this
>      bridge, not stop the entire upstream alias walk (Jason Gunthorpe)
> 
>   drivers/pci/quirks.c | 10 ++++++++++
>   drivers/pci/search.c |  2 ++
>   include/linux/pci.h  |  5 +++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..a37b7305ae5f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4453,6 +4453,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
>   				quirk_bridge_cavm_thrx2_pcie_root);
>   
> +/*
> + * AST1150 doesn't use a real PCI bus and always forwards the requester ID
> + * from downstream devices.
> + */
> +static void quirk_aspeed_pci_bridge_no_aliases(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASPEED, 0x1150, quirk_aspeed_pci_bridge_no_aliases);
> +
>   /*
>    * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>    * class code.  Fix it.
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 53840634fbfc..2f44444ae22f 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -86,6 +86,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>   			case PCI_EXP_TYPE_DOWNSTREAM:
>   				continue;
>   			case PCI_EXP_TYPE_PCI_BRIDGE:
> +				if (tmp->dev_flags & PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES)
> +					continue;
>   				ret = fn(tmp,
>   					 PCI_DEVID(tmp->subordinate->number,
>   						   PCI_DEVFN(0, 0)), data);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b16127c6a7b4..963da06ef193 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -248,6 +248,11 @@ enum pci_dev_flags {
>   	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
>   	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
>   	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
> +	/*
> +	 * PCIe to PCI bridge does not create RID aliases because the bridge is
> +	 * integrated with the downstream devices and doesn't use real PCI.
> +	 */
> +	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES = (__force pci_dev_flags_t) (1 << 14),
>   };
>   
>   enum pci_irq_reroute_variant {


