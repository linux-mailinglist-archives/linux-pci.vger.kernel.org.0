Return-Path: <linux-pci+bounces-38331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85538BE2F37
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78AF426251
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A47D214812;
	Thu, 16 Oct 2025 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlpDnqWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1622773E6;
	Thu, 16 Oct 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611955; cv=none; b=XzKuAZsSQ7HEqX3zxvS9jaTQ50pUO6YgVVuWzVwLz4uCbnbiVwQft5UjvbIeew72DxHVxX6M4kxVI5a9mz3Ov6anDA+s5t61KabmRnWOkrE0jDDL1yUe4Ng+oio/vmvB4D7n5a3mSNud+jmoTumFJi1sjDfuuH2fsUythtOQ7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611955; c=relaxed/simple;
	bh=pEnuuBBeWgESVm7GdbGrVzgcdIbcp4nWv1MIYNaHaDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3JBQhCpYxbMR9epSclWE/whUkj0fhEuqqPJ99tVUVd/hLfTKAokI4oh7ITat4YK1hCjQq+34uRJo3ZtXUvUI/HY9UNBBCBG755yE8x84IuEeHeROBVT1KhlMAywrGr3UG4L1CNqXh/ofJqrfy2kE8m4Y3v/nJ7dOPmOP9nuJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlpDnqWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED62C4CEF1;
	Thu, 16 Oct 2025 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760611954;
	bh=pEnuuBBeWgESVm7GdbGrVzgcdIbcp4nWv1MIYNaHaDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlpDnqWw6qVF//8uUgzaoWynTuU5//LJfdAa3fCy9tLeGnK3jq3gpplC8NDsxdjc2
	 eUluMcu2gYjG9jeJUEBrSLbGyN0VXDv5tkLvOKpn8NMBr989zFvxa5NqxhOrNqFRTz
	 k/gRWMONEvLgRPHpGVAxNyMFvrMwQtFQa7vyWaOS0w09kJSCE7UvmAd+OTKu7rMl94
	 PFpRRGZhFENsjthxPrZ/BubbWBW5e5Cc9lCnDo3TQltdxVOKVvJbBTZzSQ7j7xd2Df
	 0Ai/ViGpLqrnUjEBIVXDItKj88jINUi0hSzt2bSqemqSDfQuFULl/vJ9QDJLdw+f9L
	 /e7jlWJblmwbw==
Date: Thu, 16 Oct 2025 12:52:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use multiple ATU regions for large bridge
 windows
Message-ID: <aPDObXsvMoz1OYso@ryzen>
References: <20251015231707.3862179-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015231707.3862179-1-samuel.holland@sifive.com>

On Wed, Oct 15, 2025 at 04:15:01PM -0700, Samuel Holland wrote:
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> An example of where this is needed is the ESWIN EIC7700 SoC[1]. The SoC
> decodes 128 GiB of address space to the PCIe controller. Without this
> change, only 8 GiB is usable; after this change 48 GiB (6 ATU regions)
> is usable, which allows using PCIe cards with >8 GiB BARs:
> 
> eic7700-pcie 54000000.pcie: host bridge /soc/pcie@54000000 ranges:
> eic7700-pcie 54000000.pcie:       IO 0x0040800000..0x0040ffffff -> 0x0040800000
> eic7700-pcie 54000000.pcie:      MEM 0x0041000000..0x004fffffff -> 0x0041000000
> eic7700-pcie 54000000.pcie:      MEM 0x8000000000..0x89ffffffff -> 0x8000000000
> eic7700-pcie 54000000.pcie: iATU: unroll T, 8 ob, 4 ib, align 4K, limit 8G
> eic7700-pcie 54000000.pcie: PCIe Gen.2 x1 link up
> eic7700-pcie 54000000.pcie: PCI host bridge to bus 0000:00
> 
> [1]: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 34 ++++++++++++-------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..148076331d7b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -873,30 +873,40 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		u64 total_size;
> +
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>  
> -		if (pci->num_ob_windows <= ++i)
> -			break;
> -
> -		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> -			atu.size = resource_size(entry->res) -
> +			total_size = resource_size(entry->res) -
>  					resource_size(pp->msg_res);
>  		else
> -			atu.size = resource_size(entry->res);
> +			total_size = resource_size(entry->res);
>  
> -		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> -		if (ret) {
> -			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> -				entry->res);
> -			return ret;
> -		}
> +		do {
> +			if (pci->num_ob_windows <= ++i)
> +				break;
> +
> +			atu.index = i;
> +			atu.size = min(total_size, pci->region_limit + 1);
> +
> +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to set MEM range %pr\n",
> +					entry->res);
> +				return ret;
> +			}
> +
> +			atu.parent_bus_addr += atu.size;
> +			atu.pci_addr += atu.size;
> +			total_size -= atu.size;

1) Personal opinion, but perhaps:

			total_size -= atu.size;
			if (total_size) {
				atu.parent_bus_addr += atu.size;
				atu.pci_addr += atu.size;
			}

To more clearly show that these lines are performed/relevant only if
total_size > atu_limit ?


2) Perhaps convert the loop from:

do {

} while (total_size);


To a:

while (total_size) {

}

I don't see any reason for this to be a do-while loop.

while () also has the benefit that you will not "waste" an outbound iatu
if you get a window of size 0.


3) Since you are modifying the outbound range to support sizes > atu_limit,
I think you should do the same change for dma-ranges (inbound translation):

https://github.com/torvalds/linux/blob/v6.18-rc1/drivers/pci/controller/dwc/pcie-designware-host.c#L928-L948

Because it feels inconsistent if we allow size > atu_limit for outbound,
but not for inbound translation.


Kind regards,
Niklas

