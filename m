Return-Path: <linux-pci+bounces-44408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419BD0C2DE
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A95D301174F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41372E5B3D;
	Fri,  9 Jan 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD0dPmLS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041B500969;
	Fri,  9 Jan 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990397; cv=none; b=nz3l+0YuJaOXM25uNv8+hqnbQf8YOFhTXCTO1YG2JAhY8gC6F/etb2HB/BGJQoXOMLflUkLxmoRprkUopcOh7ZHOBPIOP0ntm/1BYXpD84bnBdM5mAZTnN20RclgrTLUwBpqb91zVKNSghOPJXuXZPFAKkBuBdHInUaVo4pfiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990397; c=relaxed/simple;
	bh=cY4tuSgblTSh1GneXYjqIM8DhBVUP1BFAwrvW32xrjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IuMAxbJxIZwg6fE67tIZjmaGv/UdNCl61mQ/enkbEb885ClR2Lgr0Mpj0A9hDJXNAQEmMhGbow2hQWsMeh5iNWlq9JCzfkkw2kgo8ajvOumh4P3zBF/MQbxQQxgwpRPc/nZ0Ww+Kri/ecONjJfTNDmtt+0WIscDa8dGFSXs3ksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD0dPmLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC06C4CEF1;
	Fri,  9 Jan 2026 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767990397;
	bh=cY4tuSgblTSh1GneXYjqIM8DhBVUP1BFAwrvW32xrjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qD0dPmLS0MqVSNdcgw8Y/L4h+RnGezHwHgpqv+L6xqtcVcOEcTVjxmZ7KxaP9C5ME
	 6Vn8fALZXy6cfmv+pafpywjDkuMlQm9mKljMgmUDS4AVreZOgenrqDuBnzp4RAlECl
	 nXuvnBnbu1Cjl8457RtMcxi4ZBv+joA4U/hSzyFCdp0336ba1UzvrK+n+6JLCqYOCu
	 ZwwvlI/W5pL/lDunYyuIUBhUAn0yoed+K8UXbTTseWqCtHATDB17s733tQWIQy9eT7
	 G0ejVaQZd/64YHz2ON3bV6UDelAF6OO7CJUxwkiDycbfikCZVpBtzPDLaZkkbxk12N
	 bcfmt2kt/ViVQ==
Date: Fri, 9 Jan 2026 14:26:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	jammy_huang@aspeedtech.com, mochs@nvidia.com
Subject: Re: [PATCH v2 1/2] PCI: Add ASPEED vendor ID to pci_ids.h
Message-ID: <20260109202636.GA561851@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217154529.377586-1-nirmoyd@nvidia.com>

On Wed, Dec 17, 2025 at 07:45:28AM -0800, Nirmoy Das wrote:
> Add PCI_VENDOR_ID_ASPEED to the shared pci_ids.h header and remove the
> duplicate local definition from ehci-pci.c.
> 
> This prepares for adding a PCI quirk for ASPEED devices.
> 
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

Applied both to pci/iommu for v6.20, with
s/PCI_BRIDGE_NO_ALIASES/PCI_BRIDGE_NO_ALIAS/, thanks!

> ---
>  drivers/usb/host/ehci-pci.c | 1 -
>  include/linux/pci_ids.h     | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 889dc4426271..bd3a63555594 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -21,7 +21,6 @@ static const char hcd_name[] = "ehci-pci";
>  /* defined here to avoid adding to pci_ids.h for single instance use */
>  #define PCI_DEVICE_ID_INTEL_CE4100_USB	0x2e70
>  
> -#define PCI_VENDOR_ID_ASPEED		0x1a03
>  #define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
>  
>  /*-------------------------------------------------------------------------*/
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..30dd854a9156 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2583,6 +2583,8 @@
>  #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
>  #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +
>  #define PCI_VENDOR_ID_QMI		0x1a32
>  
>  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> -- 
> 2.43.0
> 

