Return-Path: <linux-pci+bounces-26151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FEA92C49
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DF1896AC0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5620408A;
	Thu, 17 Apr 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nif05Uiz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF61FF7B0;
	Thu, 17 Apr 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921688; cv=none; b=tFEjITYN+BE3cJQFRLK0Cd3Jay+Lrp6jimQX2sXwF0KJ4FOdweEU/goY8pntlV0d2Ce8Z6btv18c1x+AmFQ3CWocoroaxsCj+ecOm88vn7AqEhhirMnuqRcF2BPWg7YHaSbmVW0LN36HEktpK4anfFbhhHAOJgbfeoF8vW2Bp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921688; c=relaxed/simple;
	bh=ZwcydrHnf4owbCgmZ+z4mAJu20e6epNCBpMKRAM2UDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RMFUD+Ih7Xf6jE6ox3T0QvLars7pNZ+mnavH80L60zZIqk8mYbowBgpopBlXeHXmyOvBlh3txY3qjbYd5aknsYQ8DGysGBaFQlnAQqQ7mSo4yRxD4PXkSVNOE6pPKrxpeNWBvSmc7qPIYtcp/VQgWnChHMuWUKV0lc+CNmcshH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nif05Uiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBA6C4CEE4;
	Thu, 17 Apr 2025 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744921688;
	bh=ZwcydrHnf4owbCgmZ+z4mAJu20e6epNCBpMKRAM2UDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nif05UizHzsvI55wWdxto9hi/QnlaKBBt21ZJGgiHCCCiSZ02jQpkW/YGd5zUd2pE
	 +I9uR7UIpEx6rtt5A7UmCy0GaeryiQQmQy9djXLqPlcDo3Upucqa7yZwr3+wrthmFC
	 NlDftX1ogbkZP4CqpLdrK6ZAVOF0Ph+Xn8W/lPq+UWS4VH+8k85EbIS2NkOZaiqcBD
	 3jDSXI3KCc1cRXWvGa9zKEh+oMzKacrcbQROeO7OAQP2w0pqeSVOlWnROGDhDOIs2w
	 u0SECy2gr/Nu2+JZq3LyndL1U8NIDlzAumOy4SNT//a2An92lZDOkpTXGyAcSyrKb0
	 pqtP/rBF8KTfA==
Date: Thu, 17 Apr 2025 15:28:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH V2] PCI: Add ACS quirk for Loongson PCIe
Message-ID: <20250417202806.GA127187@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403040756.720409-1-chenhuacai@loongson.cn>

On Thu, Apr 03, 2025 at 12:07:56PM +0800, Huacai Chen wrote:
> Loongson PCIe Root Ports don't advertise an ACS capability, but they do
> not allow peer-to-peer transactions between Root Ports. Add an ACS quirk
> so each Root Port can be in a separate IOMMU group.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied to pci/virtualization for v6.16, thanks!

> ---
> V2: Add more device ids.
> 
>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8d610c17e0f2..eee96ad03614 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4995,6 +4995,18 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
> +static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * Loongson PCIe Root Ports don't advertise an ACS capability, but
> +	 * they do not allow peer-to-peer transactions between Root Ports.
> +	 * Allow each Root Port to be in a separate IOMMU group by masking
> +	 * SV/RR/CR/UF bits.
> +	 */
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> +}
> +
>  /*
>   * Wangxun 40G/25G/10G/1G NICs have no ACS capability, but on
>   * multi-function devices, the hardware isolates the functions by
> @@ -5128,6 +5140,17 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
> +	/* Loongson PCIe Root Ports */
> +	{ PCI_VENDOR_ID_LOONGSON, 0x3C09, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x3C19, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x3C29, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A09, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A19, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A29, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A39, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A49, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A59, pci_quirk_loongson_acs },
> +	{ PCI_VENDOR_ID_LOONGSON, 0x7A69, pci_quirk_loongson_acs },
>  	/* Amazon Annapurna Labs */
>  	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
>  	/* Zhaoxin multi-function devices */
> -- 
> 2.47.1
> 

