Return-Path: <linux-pci+bounces-4057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A018868257
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4474F286847
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C14130E55;
	Mon, 26 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKUHuEZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F312F394;
	Mon, 26 Feb 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981351; cv=none; b=otqNS2wpLFDBvAoA9sJ3jhZ9eK631jSwRmEagPsaRgZmdLMxch/Cf2NCdEMfKPV1V2AnDkRmv1u2TknKnCqllxmGZy31l+9azsbLUrVWqgR2/zJiIIe3l3rkpwjolgZtk8Mz/HZk9FEs0MijVC3Q4XsT0cWG9C1PQJJxtuxwpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981351; c=relaxed/simple;
	bh=TOLX+LMPbcI2ajxr5u705EUNPqYivRst2CHEJGGDcJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z046+s47H5kb6hbrp+pLNyhh+Rg6ZXtq8NEyYVCpEBQanOZGdAIqV+3SiH6mQxvsAD0DRZN8xtDjRseACpgLSliMjMX4P/eIdtwMmwfkKgjRYd2WQwVAd3lDNqtozj/GesjKw/HvWy6IA8/BcMUGDNnfF0FW1O8OqKYZ1rDeR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKUHuEZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EBDC433F1;
	Mon, 26 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981350;
	bh=TOLX+LMPbcI2ajxr5u705EUNPqYivRst2CHEJGGDcJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sKUHuEZMGvk9Vl1IfC73A4HhjBFaLYvP/ahlPRXWDSWb6J+SzmNK7xlAh0c7LKTCZ
	 Kzu8R27JQdbW5X7AowimOxH7ogwGp6NULU7eO6nMKYe/fA7+v8ouu9ilCW+CTr992G
	 GTzY2bKhfy1qjK1TzQSIGBIkYDjE3YJwTzLfhs89WjWKZWSTDXP/USJOJ37tInFTGq
	 K7ZATwRFRPSdegNeDbkSL7FDOnZcPIhxv/Qwi2dH4QQoLQKUqcRI019MM+qLAu+V2/
	 kpZKrn5iWIb1rHk/zf3cuMvU29VHYQZeSxLkOP2TwvzzlAklF++78uM2lBBmcqLUcS
	 7FnE1HHvrtICA==
Date: Mon, 26 Feb 2024 15:02:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Edmund Raile <edmund.raile@proton.me>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240226210228.GA199890@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226102354.86757-1-edmund.raile@proton.me>

[+cc Alex]

On Mon, Feb 26, 2024 at 10:25:12AM +0000, Edmund Raile wrote:
> Using LSI / Agere FW643 with vfio-pci will issue an FLreset, causing
> a broken link only recoverable by removing power (power-off /
> suspend + rescan). Prevent this bus reset.
> With this change, the device can be assigned to VMs with VFIO.

I don't quite understand the commit log.  It says Function Level
Resets cause a problem, but the patch sets PCI_DEV_FLAGS_NO_BUS_RESET,
which prevents Secondary Bus Resets, not Function Level Resets.

By default, I think we try reset methods in order of
pci_reset_fn_methods[], so the fact that we get to the end and 
try pci_reset_bus_function() (where PCI_DEV_FLAGS_NO_BUS_RESET is
tested) suggests that we weren't able to use FLR or PM resets.

IIUC, vfio-pci resets devices to prevent leaking state from one VM to
another.  We might be willing to accept the downside of allowing that
leakage, but I think it's worth mentioning that in the commit log.

Add blank lines between paragraphs (also in the comment below), or
rewrap into a single paragraph.

> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> ---
> Usefulness:
> The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
> the only one that does not use a PCIe->PCI bridge.
> It was used in the following Apple machines:
> MacBookPro10,1
> MacBookPro9,2
> MacBookPro6,2
> MacBookPro5,1
> Macmini6,1
> Macmini3,1
> iMac12,2
> iMac9,1
> iMac8,1
> It is reliable and enables FireWire audio interfaces to be used
> on modern machines.
> Virtualization allows for flexible access to professional audio
> software.
> 
> Implementation:
> PCI_VENDOR_ID_ATT was reused as they are identical and I am
> uncertain it is correct to add another ID for LSI to pci_ids.h.
>  drivers/pci/quirks.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..a6747e1b86da 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3765,6 +3765,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Using LSI / Agere FW643 with vfio-pci will issue an FLreset, causing
> + * a broken link only recoverable by removing power (power-off /
> + * suspend + rescan). Prevent this bus reset.
> + * With this change, the device can be assigned to VMs with VFIO.
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

