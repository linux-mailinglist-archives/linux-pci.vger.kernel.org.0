Return-Path: <linux-pci+bounces-29651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EABAD83D7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C243AA018
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D332D279917;
	Fri, 13 Jun 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUnuo0+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941D279345;
	Fri, 13 Jun 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798919; cv=none; b=BAolZGNtXJVVB0tDV5jykyXfYNMTasytuEYvtfD7mm9PGwFW5VxQo/GRX87uFNs1c1O14r+QgMQbbUA53rSwkm94D8TIuXm1Lf761EcFkrftPxlAip4g3BGXUpvquX9TTyabvVi74tEpzIbe0GwmgWp43EbBiwvNlg7XMgO/1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798919; c=relaxed/simple;
	bh=IiL6NRarNqB3BwbEW7Ffwh5XerFNpYjLQsIHIqBL2kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaMofrKpD1Fa46LviZkeVEs99w/mYmNOMzzbggp4kym36YJTkke7ji/XqYqQr7VPzTOxdT8Km8dq8VtQkV+Tza7NBjxtgMjIWZu6bBcIkq8hLZ0R9R1gIXPVVecwH9CtVn9UytYKLco/5gJID99WVA0+NbafpATJHPMwg7DpHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUnuo0+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A10C4CEE3;
	Fri, 13 Jun 2025 07:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749798919;
	bh=IiL6NRarNqB3BwbEW7Ffwh5XerFNpYjLQsIHIqBL2kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUnuo0+zJb/ipyTX99+Lq3pi0RZd2BIQUClHbcob1WzEuVrEGjfnPlp5JHggVM6/L
	 a7n/9JKfUkbJuMpkz71nKTYMPGquxPcpaozcrdDTRndp6HtW/Cv483BqX45hGOxnts
	 1saFOD4mBxASLaa6vdVby6hNzVM5+XqhafA15MsRmt39D6fW/ED18tbsCn2yGrT38e
	 oZ/Pxou5m5UMK5yzS0xY/TthY8XXj6MTNnqxCLxz5ETxI5gpvJDslGFiHVNF8RBtQ5
	 g0Efi6bo/yWzfvkzlgT69RAsA0H0cTS9omIC4fMpglixGgYbPDaaqRp0dpxVo0ENHb
	 N7QtbDYzng5Rw==
Date: Fri, 13 Jun 2025 12:45:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>, 
	Xuefeng Li <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@gmail.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, Ming Wang <wangming01@loongson.cn>
Subject: Re: [PATCH V3 2/2] PCI: Prevent LS7A Bus Master clearing on kexec
Message-ID: <2muq3nx6oyo3vf6qvil3oesq6luf67sjd6nxbigyxto7oxtteq@stji5xaidyye>
References: <20250511083413.3326421-1-chenhuacai@loongson.cn>
 <20250511083413.3326421-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250511083413.3326421-3-chenhuacai@loongson.cn>

On Sun, May 11, 2025 at 04:34:13PM +0800, Huacai Chen wrote:
> This is similar to commit 62b6dee1b44a ("PCI/portdrv: Prevent LS7A Bus
> Master clearing on shutdown"), which prevents LS7A Bus Master clearing
> on kexec.
> 

So 62b6dee1b44a never worked as intented because the PCI core still cleared bus
master bit?

> The key point of this is to work around the LS7A defect that clearing
> PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
> we may need to do that even after .shutdown(), e.g., to print console
> messages. And in this case we rely on .shutdown() for the downstream
> devices to disable interrupts and DMA.
> 
> Only skip Bus Master clearing on bridges because endpoint devices still
> need it.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 602838416e6a..8a1e32367a06 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->current_state <= PCI_D3hot))

I'm not a Kexec expert, but wouldn't not clearing the bus mastering for all PCI
bridges safe? You are making a generic change for a defect in your hardware, so
it might not apply to all other hardwares.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

