Return-Path: <linux-pci+bounces-30530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7925AE6CED
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF14A0643
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FB2E2EFA;
	Tue, 24 Jun 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJyrdiQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D626CE3A
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783728; cv=none; b=eItTrj2NeiYfX69hmjzux3pBBkqzmIFfkOHUfb/fnfTnX9j+W9gaxmqH2K24+5WPqsylj3u04u6uNY0gid7xoij0pkNz46e31Vu3Zvbhez7sV0TsN21Xb9PILxISjvpHubuPjFN7MoAbN1ZW36IeXt/ABDAGrbtoOVALTpQJv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783728; c=relaxed/simple;
	bh=u0OwnLAZra1aE2r2jUIv0th0g7mdcSaXHIYp16N1RkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jmsnlu/SRPol9l4njgKL8Fz81I86uOi/ptEnxaIRm6ezhJutVAkBhsLONQBOuOUrSq74doggkdneLKZpXxCljPE+C3uCCkz4sFjoe0NjFxPvF8QsSVcx2on7SYL0uV03i3dLrg4v3bzxGOFL+67cZMquIz8ypLgw9e06aVC8qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJyrdiQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD8C4CEEF;
	Tue, 24 Jun 2025 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750783728;
	bh=u0OwnLAZra1aE2r2jUIv0th0g7mdcSaXHIYp16N1RkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hJyrdiQCkPQbXVvaJjvRYhXnaOjQk0Pn7vr/8JfSyet9tV2l5Q/XR3YCZkXhbPL5B
	 hu3XzYYdCwG6QoRti8/AuscCrUr5gPokjbx0AYkQq3fFGX9ZHQh8YfT+DLVqVVMdRP
	 OO+TbuHLlAK9zleIL/HQm709RKmlpapd/rUhz61eL+RliFu8qnGqxH6VP/tDkvj6de
	 YNnCv1HKraKpe/DYBKjng6HxcWsWVICU32Wp8jEHNEvpQOgoysqwgZHqpqiek0V2WL
	 S86n4uzwtlzNAsmVRg8/6OUl36T00+nzGx6Vfjywyd453tbYhJsRiqd9pTDOcri/U+
	 6J8dB3Kul3QBw==
Date: Tue, 24 Jun 2025 11:48:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andrew <andreasx0@protonmail.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
Message-ID: <20250624164846.GA1482201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>

[+cc Sathy, Jiwei, Adrian]

On Mon, Jun 23, 2025 at 03:22:14PM +0200, Lukas Wunner wrote:
> When pcie_failed_link_retrain() fails to retrain, it tries to revert to
> the previous link speed.  However it calculates that speed from the Link
> Control 2 register without masking out non-speed bits first.
> 
> PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> pcie_set_target_speed():
> 
>   pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
>   pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>   pci 0000:00:01.1: retraining failed
>   WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
>   RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
>   pcie_failed_link_retrain
>   pci_device_add
>   pci_scan_single_device
>   pci_scan_slot
>   pci_scan_child_bus_extend
>   acpi_pci_root_create
>   pci_acpi_scan_root
>   acpi_pci_root_add
>   acpi_bus_attach
>   device_for_each_child
>   acpi_dev_for_each_child
>   acpi_bus_attach
>   device_for_each_child
>   acpi_dev_for_each_child
>   acpi_bus_attach
>   acpi_bus_scan
>   acpi_scan_init
>   acpi_init
> 
> Per the calling convention of the System V AMD64 ABI, the arguments to
> pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
> stored in RDI, RSI, RDX.  As visible above, RSI contains 0xff, i.e.
> PCI_SPEED_UNKNOWN.
> 
> Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed link retraining")
> Reported-by: Andrew <andreasx0@protonmail.com>
> Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.12+

I like the brevity of this patch, but I do worry that if we ever have
other users of PCIE_LNKCTL2_TLS2SPEED(), we might have the same
problem again.

Also, it looks like PCIE_LNKCAP_SLS2SPEED() has the same problem.

f68dea13405c predates PCIE_LNKCTL2_TLS2SPEED(), and I don't think this
problem existed as of f68dea13405c.  I think the Fixes: tag should be
for de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe
Link Speed"), which added PCIE_LNKCTL2_TLS2SPEED() and
PCIE_LNKCAP_SLS2SPEED() without masking out the other bits.

I think I'll take Jiwei's patch [1], which fixes
PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() without requiring
changes in the users.  I'll add the details of Andrew's report to the
commit log.

[1] https://lore.kernel.org/all/20250123055155.22648-2-sjiwei@163.com/

> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee6..deaaf4f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> -		u16 oldlnkctl2 = lnkctl2;
> +		u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>  
>  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>  
> -- 
> 2.47.2
> 

