Return-Path: <linux-pci+bounces-4287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F286D72C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB331C21875
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5D45948;
	Thu, 29 Feb 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTdp2dZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B5200CD;
	Thu, 29 Feb 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247615; cv=none; b=UPkYdMh7aZgagTK1ek8+nz+sOCTo76HBotNzVzk7ib/FNXL4qSSVjAV18xPHtvNLb1ukgmDyyyOcX83MmibH09kPFiANU90Z3xHi/86QWx0EpezGiDfDgI62TjpzT9F/V5txERB+iTAihOr9p4wsuL31pchMZFHnb8bLnNlDq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247615; c=relaxed/simple;
	bh=hH5sR08X9k9yUY5lSYk73lTYkQH3IOJI3IyakL3nwto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IikH2by+Ct8ML/EDQZdQiAf0pNpXkI1ahBXUW/TJw+laqdbi88+IRJTeFCuIU72sBmO/x7wHhvaa/scMYNe8L/dZ31QI6E2INsSLYZrlHYVA1u+D89QHW7J5DuNVQJl3MMQ68PjFOC1339/ugD/jSulxlTyHN8gJQo4XpmYBzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTdp2dZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E247BC43394;
	Thu, 29 Feb 2024 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709247615;
	bh=hH5sR08X9k9yUY5lSYk73lTYkQH3IOJI3IyakL3nwto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QTdp2dZz7/pTysdgToQhyFuCHp7Px8ZPdKTP8vVtvleE/mjEi1U9FkE2MlZV3FWIz
	 2BAULsLqHDMyAFcmjnmy9WK+URrTvDw1NOGHMtJLd20rjNDxPj55GjEm3hcUC/jefs
	 8VbptqBoycn8vtN2ThViT2aJTL43HldDr0zmYEQVmsng+WIHcNTPEvMCU+V9ZdgNwo
	 DAsZ+v8G1mno6+UUhA9BFW8Jc0aDiEgUq6Cnyoq5ZGz8Q00fBEyF15/JQEhK7hje7e
	 +bzO1MExMhKLKPV33HuQxyx4/jo3JJGiJ8jl4riRR55DfvSAQgryU6Dzz1mGYHYl/o
	 61Czvfh0osTJg==
Date: Thu, 29 Feb 2024 17:00:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Edmund Raile <edmund.raile@proton.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240229230013.GA369538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131401.17913-1-edmund.raile@proton.me>

On Tue, Feb 27, 2024 at 01:14:18PM +0000, Edmund Raile wrote:
> Using LSI / Agere FW643 with vfio-pci will exhaust all
> pci_reset_fn_methods, the bus reset at the end causes a broken link
> only recoverable by removing power
> (power-off / suspend + rescan).
> Prevent this bus reset.
> With this change, the device can be assigned to VMs with VFIO.
> Note that it will not be reset, resulting in leaking state between VMs
> and host.
> 
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>

Applied to pci/virtualization for v6.9, thank you!

> ---
> 
> I sincerely thank you for your patience and explaining
> the background of pci resets which I lacked.
> The commit message and comment now describe it correctly.
> The comment on leaking states was added.
> 
> Usefulness:
> 
> The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
> the only one that does not use a PCIe->PCI bridge.
> It is reliable and enables FireWire audio interfaces to be used
> on modern machines.
> 
> Virtualization allows for flexible access to professional audio
> software.
> 
> It has been used in at least the following Apple machines:
> MacBookPro10,1
> MacBookPro9,2
> MacBookPro6,2
> MacBookPro5,1
> Macmini6,1
> Macmini3,1
> iMac12,2
> iMac9,1
> iMac8,1
> 
> Implementation:
> 
> PCI_VENDOR_ID_ATT was reused as they are identical.
> 
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..e0e4ad9e6d50 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3765,6 +3765,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Using LSI / Agere FW643 with vfio-pci will exhaust all
> + * pci_reset_fn_methods, the bus reset at the end causes a broken link
> + * only recoverable by removing power
> + * (power-off / suspend + rescan).
> + * Prevent this bus reset.
> + * With this change, the device can be assigned to VMs with VFIO.
> + * Note that it will not be reset, resulting in leaking state between VMs
> + * and host.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
> +
>  /*
>   * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
>   * automatically disables LTSSM when Secondary Bus Reset is received and
> -- 
> 2.43.0
> 
> 

