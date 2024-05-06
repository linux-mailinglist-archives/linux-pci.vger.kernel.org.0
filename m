Return-Path: <linux-pci+bounces-7137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744B8BD7AD
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 00:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AF3283556
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3CA15218B;
	Mon,  6 May 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nptyv8ad"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E681E492;
	Mon,  6 May 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035511; cv=none; b=bE3R/ngyFk5hJyIlMZle453J1HFB9Wm9i3/mVkc5nTT4a7vKLf1fEWqVtlEQ2iOXRbxOcMQW2I6WwneH5jMHfxDzIddKOMhZgv38sIUt9utmB956IUjZfWcF+KnkyiFJeQvWMzrY3lnZVr2mcR5W614xSxplVGd40uUE8y5xm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035511; c=relaxed/simple;
	bh=y5PoXckBqRbG1xrUmNqXmT+xaUFuGSK/aO21osW5ShU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ftc7+9D4BlyezMIFD9B0cQATShNowiuGKjrozn3ah9zn6l07i3kxawKOLRVR5m9arVxZEl5AV8QyUaek2VF0ezvdINa4zyQssNRDzj9bpHwiONTdRtepDvuOA4krEzuY4ZFlBkiERpo+InfufhuELFUcPIJY8uYEH7ug7P32dsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nptyv8ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8B5C116B1;
	Mon,  6 May 2024 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715035510;
	bh=y5PoXckBqRbG1xrUmNqXmT+xaUFuGSK/aO21osW5ShU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nptyv8ad6ktkyiRgxxfI+HmFXxKgpsv44szFxd28jltndbYuVI8CKC9H1isLWrCKx
	 qraawXlVqtSRMCPC9a9JAcQuULACHYrhtEZ4PnZlpgAZtOoqieHtRHkbp8m1Pb1P1y
	 lVSdSgi8tG8OqG9cFGn3UPEh2s9bTw8CSHLk0JGDcEW8JoGRztBM5wS/u7skPkZal0
	 KzffMbAPLPp/F4UTP2sOrMjEXUqkQNEbsmyVGOxg687CBrxmWiCCHZAMBz/044KaNn
	 n1ujhFrVAWd+k/64I+0GcLnlxd4uK2fmy6NjVlLHJCbDkvUjq0kCIGkEUQk8C41CZQ
	 9ai6cnVRa0M1g==
Date: Mon, 6 May 2024 17:45:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/4] PCI: brcmstb: Set reasonable value for internal
 bus timeout
Message-ID: <20240506224508.GA1713699@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403213902.26391-3-james.quinlan@broadcom.com>

On Wed, Apr 03, 2024 at 05:38:59PM -0400, Jim Quinlan wrote:
> HW initializes an internal bus timeout register to a small value for
> debugging convenience.  Set this to something reasonable, i.e. in the
> vicinity of 10 msec.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f9dd6622fe10..e3480ca4cd57 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -664,6 +664,21 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +/*
> + * An internal HW bus timer value is set to a small value for debugging
> + * convenience.  Set this to something reasonable, i.e. somewhere around
> + * 10ms.
> + */
> +static void brcm_extend_internal_bus_timeout(struct brcm_pcie *pcie, u32 nsec)
> +{
> +	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> +	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
> +	u32 timeout_us = nsec / 1000;
> +
> +	/* Each unit in timeout register is 1/216,000,000 seconds */
> +	writel(216 * timeout_us, pcie->base + REG_OFFSET);
> +}
> +
>  /* The controller is capable of serving in both RC and EP roles */
>  static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
>  {
> @@ -1059,6 +1074,9 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  		return -ENODEV;
>  	}
>  
> +	/* Extend internal bus timeout to 8ms or so */
> +	brcm_extend_internal_bus_timeout(pcie, SZ_8M);

The 216*usec is obviously determined by hardware, but the choice of
nsec for the interface, and converting to usec internally seems
arbitrary; the caller could just easily supply usec.  Or do you
envision using this interface for timeouts < 1 usec?

"SZ_8M" seems a little unusual as a time measurement and doesn't give
a hint about the units.  It's pretty common to use "8 * USEC_PER_MSEC"
or even "8 * NSEC_PER_MSEC" for things like this.

But it's fine with me as-is.

>  	if (pcie->gen)
>  		brcm_pcie_set_gen(pcie, pcie->gen);
>  
> -- 
> 2.17.1
> 



