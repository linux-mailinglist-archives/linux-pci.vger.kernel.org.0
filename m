Return-Path: <linux-pci+bounces-41999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F226C82E3E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 698D7340443
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418302741C0;
	Mon, 24 Nov 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZUXoqWf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723825F99F;
	Mon, 24 Nov 2025 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028390; cv=none; b=HRnkhpbrvAKptS/3DC5+cvPKpaTy7EyQU8B3jjRNsbKp1PWZd73wUnba/2GptpZEJhOCjx/6taDFoEnZztfygO6bqQnvzKlY1axI1KcCLVmh9dkWVP13E6ENt2DXm6l4bToF1UiTKaD33HezEQyqWeTx+lB39uE1CT6dLKz/yJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028390; c=relaxed/simple;
	bh=8ozChe2NeBhKpJicwWvmoaFsI868x7U7JW/L60djkjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EaeD303kIqcYcYKlTXW99OX5bBmJERZhfoM96GB2B0vGg0D460TR4b05C59A7PGzNBq6EXn6Mh6uUOjgKJlEIHMigbaY2+yVaePDgZMR2UKuUdJdnPUDpgYU8q1n/Du0ZQDnQ4Iv29WiYm4F0zsbH83BXzzC/MisFXVltbtLDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZUXoqWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6940DC4CEF1;
	Mon, 24 Nov 2025 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764028388;
	bh=8ozChe2NeBhKpJicwWvmoaFsI868x7U7JW/L60djkjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WZUXoqWfY1YGNAn9WchDfeN0W3JHXSkWLOxIv5NbXw/dXqWJLYeUYtmGJfRKdysG7
	 6yzN5talzMChtgnIEKUqEYErQWcW6SbUMyCSq2N7oUY55KiaCVQ56FneZJ8TtUec/q
	 nWZd+u1PYdsu6uO7wzqKUSJJF1gtqfZNiuj5F13AytB2IlsfhHkgv3gdfCuWz/zXqT
	 bQjoIb5JnPwB8lMaFLmG6Hs1YoSjcGviyYUSSIYOVGXlrTmEFQ3VylDnyuyVBm0Bjw
	 VE9Vu5hkBTaX7rsuaApE5jfQllzWY2/fdZ1/24ipn/ejbw5SWmHpcwg4Znf2IoVfeb
	 O702iDGoMMd3Q==
Date: Mon, 24 Nov 2025 17:53:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>,
	Jeffrey Lien <Jeff.Lien@sandisk.com>,
	Avinash M N <Avinash.M.N@sandisk.com>
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
Message-ID: <20251124235307.GA2725632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120161253.189580-1-mani@kernel.org>

[+cc Alexey, Jeffrey, Avinash]

On Thu, Nov 20, 2025 at 09:42:53PM +0530, Manivannan Sadhasivam wrote:
> The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
> Port of PCIe controller in Microsoft Surface Laptop 7, when ASPM L1 is
> enabled:
> 
>   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
>   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
>   nvme 0006:01:00.0:    [ 0] RxErr

Do we have any information about whether this error happens with the
SN740 on platforms other than the Surface Laptop 7?  Or whether it
happens on the Surface with other endpoints?

I'm a little hesitant about quirking devices and claiming they are
defective without a solid root cause.

Sandisk folks, do you have any insight into this?  Any known errata or
possibility of looking into this with an analyzer?

> Hence, add a quirk to disable L1 by removing the ASPM_L1 CAP for this SSD.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> 
> Changes in v2:
> 
> * Fixed the laptop name
> * Rebased on top of v6.18-rc6 for pcie_aspm_remove_cap()
> 
>  drivers/pci/quirks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..adc54533df7f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2527,6 +2527,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
>  
> +static void quirk_disable_aspm_l1(struct pci_dev *dev)
> +{
> +	pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L1);
> +}
> +
> +/*
> + * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
> + * Port when ASPM L1 is enabled.
> + */
> +DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5015, quirk_disable_aspm_l1);

