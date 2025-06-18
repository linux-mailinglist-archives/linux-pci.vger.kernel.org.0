Return-Path: <linux-pci+bounces-30130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA36ADF704
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AC14A2B9A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57422218585;
	Wed, 18 Jun 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZcEcIlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16F20296E;
	Wed, 18 Jun 2025 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275842; cv=none; b=Bq0ScZgPIbdgO9NzxYPfpbM/KKtWOZ1tLLScWGDGwjZE5l7hrwEfn7Vt5P2t9AR9Rh0CL9KiA2OUPKILy1dY1v6q24zmWLouj1g2vOD+I6GGzTg6oB/NiLf1g7h6fQSG9ctxgi4wopPefFiShkjsjurLnxjUI4NXjzfCO0YKwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275842; c=relaxed/simple;
	bh=7eVewN673jHwQZJkWhF/hgscqK5uhDvpq3jqJohTquY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gZvJrwgB1lkyA7fS/XpLBWJ3oFKgV6vBys7O/yANCuqlF1Z4VZ18sMgl2mzE5yVe6ZSqBnFKM8CsWLKEcitwkiCCgL1IbCYmlHxp8sjTgYANjEDNcfkJim+NYYEItGCy3WhVWqcRRkVLRhJrbnYypxOmdhcEmFrxWzKLWgDSIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZcEcIlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8420CC4CEED;
	Wed, 18 Jun 2025 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750275841;
	bh=7eVewN673jHwQZJkWhF/hgscqK5uhDvpq3jqJohTquY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dZcEcIlxzmjGjevrwPL5VBRthst/bU56HrpDzV0SouXpQbvei7g5qbgCHWFqg9tow
	 c3HnRznLYYO682GbXkOGRxLgkAr6CMVtiRRQwP75W+ELUt7oooYVg4VW+sBh2jo8bj
	 bLZ1+/p7n0pz7i+b9I9A+djx9Oycqw8ovLsxM/nGFK60BCWmWZDiiygJ7eZwvrHX4N
	 cKL31BTq9sktKWJ04J0EYepoNYmjD+aO1i9ImxJaU3liXwbTPhC7conbfzRo/Oiu5w
	 awSotYZAfYhQZbmDH1Nz0X7wS4fZd6904++Xj/ENr+JJUZId4fQ1RyjCm/7sfK6yTP
	 MJ01+FAErk35Q==
Date: Wed, 18 Jun 2025 14:44:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Message-ID: <20250618194400.GA1219576@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741778252.1310636.1750265814430.JavaMail.zimbra@raptorengineeringinc.com>

[+cc Lukas, pciehp expert]

On Wed, Jun 18, 2025 at 11:56:54AM -0500, Timothy Pearson wrote:
>  presence detection

(subject/commit wrapping seems to be on all of these patches)

> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> was observed to incorrectly assert the Presence Detect Set bit in its
> capabilities when tested on a Raptor Computing Systems Blackbird system,
> resulting in the hot insert path never attempting a rescan of the bus
> and any downstream devices not being re-detected.

Seems like this switch supports standard PCIe hotplug?  Quite a bit of
this driver looks similar to things in pciehp.  Is there some reason
we can't use pciehp directly?  Maybe pciehp could work if there were
hooks for the PPC-specific bits?

> Work around this by additionally checking whether the PCIe data link is
> active or not when performing presence detection on downstream switches'
> ports, similar to the pciehp_hpc.c driver.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/pci/hotplug/pnv_php.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index aec0a6d594ac..bac8af3df41a 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -391,6 +391,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
>  	return 0;
>  }
>  
> +static int pcie_check_link_active(struct pci_dev *pdev)
> +{
> +	u16 lnk_status;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> +		return -ENODEV;
> +
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +
> +	return ret;
> +}
> +
>  static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
>  {
>  	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
> @@ -403,6 +417,19 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
>  	 */
>  	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
>  	if (ret >= 0) {
> +		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
> +			presence == OPAL_PCI_SLOT_EMPTY) {
> +			/*
> +			 * Similar to pciehp_hpc, check whether the Link Active
> +			 * bit is set to account for broken downstream bridges
> +			 * that don't properly assert Presence Detect State, as
> +			 * was observed on the Microsemi Switchtec PM8533 PFX
> +			 * [11f8:8533].
> +			 */
> +			if (pcie_check_link_active(php_slot->pdev) > 0)
> +				presence = OPAL_PCI_SLOT_PRESENT;
> +		}
> +
>  		*state = presence;
>  		ret = 0;
>  	} else {
> -- 
> 2.39.5

