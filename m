Return-Path: <linux-pci+bounces-30886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A98AEAD0B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC84F4A6C6C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4A192B75;
	Fri, 27 Jun 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMV0fDiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F407219E8
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992972; cv=none; b=q61zpaphsgpTkwUmqZ+FRP7/MI2QWqILKDHihKvMPJY6jQiOKRi56GwZ2Vb4zQnVJwdO2Zg6aKpEuy/jK8wB9HiPjyA7nde6uoTJJkXTwaB8d0LY/fvd+NeF1SaYC1tVzezMX29tILXdMTIdd6Zf0vYWVFmtWDi8jLUgSI2Is58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992972; c=relaxed/simple;
	bh=I3+sn9Von/renyoy0E6aK+jfLDzCxMn32xR0ZdIUU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s9bTMvZRJ2gCflyzSIpgmmunQZlsrByoyZGby/CzYmwSHm/6TkWD5ucXIOPJiRbfzNx0pOVSL99REqma33RqUMwB+m5A6Ya+EAJuR91GoECBwYxExhJ9Os8wE/u/qUR9owzrGsUD1sNn2PfjW/LS4Qd/rQoN6ikxKKcZ86s6/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMV0fDiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3988C4CEEB;
	Fri, 27 Jun 2025 02:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750992970;
	bh=I3+sn9Von/renyoy0E6aK+jfLDzCxMn32xR0ZdIUU4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VMV0fDiCaP+rrZKBUqKhMi0yKgach5kDfFO7UErQzGUHLjIe2MCCRwSTrxdfRaiYH
	 BtxzD3ZuI46VOFA1Q4PlTX1bjtpMSaR9spGmhXiWqy2DTFYTTJP87MY8slYBGJmDYG
	 /eOM0qt/uCsMpy3cKaS31xAKtTs7qYu7vzJ19+P4R46Lnq/FluanZfuGU4eIyyMWdL
	 iJHanwBw7mBFxhMjHG/rtynyeZAB7YvkRRbb3CDcnPniJW/oHfmUMQa+AB3GMDwBOM
	 1mTTX1xhejL334vQ24gm7c+KSbNI6yJX/47GAQYrhfMt36/fAcXrzBAc/JoWd29UbY
	 vOGXC6kde2FKQ==
Date: Thu, 26 Jun 2025 21:56:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <20250627025607.GA1650254@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>

[+cc Ilpo]

On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
> 
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().
> 
> The resulting runtime PM ref imbalance causes errors such as:
> 
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
> 
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.

pci_dev->is_hotplug_bridge is not just a cache of PCI_EXP_SLTCAP_HPC;
it can also be set in two other cases.  Example below.

> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
> 
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
> 
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
>  drivers/pci/pci-acpi.c             |  5 -----
>  include/linux/pci_hotplug.h        |  4 ----
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..ae2bb8970f63 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>  static void hotplug_event(u32 type, struct acpiphp_context *context);
>  static void free_bridge(struct kref *kref);
>  
> +static bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +	u32 slot_cap;
> +
> +	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
> +		return true;
> +
> +	if (shpchp_is_native(bridge))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * acpiphp_init_context - Create hotplug context and grab a reference to it.
>   * @adev: ACPI device object to create the context for.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..57bce9cc8a38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  bool pciehp_is_native(struct pci_dev *bridge)
>  {
>  	const struct pci_host_bridge *host;
> -	u32 slot_cap;
>  
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>  		return false;
>  
> -	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> -		return false;

If we have a bridge where bridge->is_hotplug_bridge=1 from the acpiphp
check_hotplug_bridge() or quirk_hotplug_bridge(), and the bridge has
no Slot or a Slot with PCI_EXP_SLTCAP_HPC=0, we previously returned
false here but may now return true.  That seems like a problem, but
maybe I'm missing the reason why it is not an issue.  

Previously pciehp_is_native() depended on the bridge, but now it will
only depend on the negotiation with the platform for native PCIe
hotplug control, so it definitely changes the semantics.

If the new semantics are what we want, that would be great because I
think we could probably set host->native_pcie_hotplug up front based
on CONFIG_HOTPLUG_PCI_PCIE and pcie_ports_native, and
pciehp_is_native() would collapse to just an accessor for
host->native_pcie_hotplug.

>  	if (pcie_ports_native)
>  		return true;
>  
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index ec77ccf1fc4d..02efeea62b25 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
>  #endif
>  
> -static inline bool hotplug_is_native(struct pci_dev *bridge)
> -{
> -	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> -}
>  #endif
> -- 
> 2.47.2
> 

