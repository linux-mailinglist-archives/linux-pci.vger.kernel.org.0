Return-Path: <linux-pci+bounces-41029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C98C54D2B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 00:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1304C347025
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811D2737F3;
	Wed, 12 Nov 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpAwP8Jw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027026CE02
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990923; cv=none; b=qPU5/4pKgbBGEaWOItgyz5Bm3huyJJQf56vFK0uQr5/cp9hEpmZmH5yj27TmbXtwQdmxpDi7VpvB8OGeo0+FrPe2Rk0tAvXi/2FMeaKfI6I0d7mgcTaMavi8TErGO88vr8ZInXiiLnKE6Iojrff+IjA/VgWg1fXwGwri/c2QdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990923; c=relaxed/simple;
	bh=Qdtcjw82VHPgyUugIrOhuTsmFbDR188N/1D1MG3Nugs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AwTwtHuaOjLKXrUcXASg2FyBZWGn/ADCISYG4l+itEeohDJKROec7uVU+GW4VrR3uQe3QojGgFFGOwhumdy/czIAtpsW3EdPwYtrZIz46ERyh+s7tNn/zyrTqDCvXrdV6RABMpAr6BzBVOLh6udhlQpRDK0oSLhXlraeDHuAlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpAwP8Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62384C4CEF8;
	Wed, 12 Nov 2025 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762990922;
	bh=Qdtcjw82VHPgyUugIrOhuTsmFbDR188N/1D1MG3Nugs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XpAwP8JwkbF8yAdBNh/g3kPtDM3GTeyHSm9siqfbJBmj22LUfTyQLKwlN8cLxa+tq
	 k+bcNP7++mPF6rA9mcpRodPI0u6pp5yK8+9J6fdVxlcn+de+ZdXYM/vmjo+CXovyK5
	 wc9CmjIDvjNkcUKEr05KHbnryu1xe5H7+ElQrfT2rqSUrpRIkF53E5K+FM2FlNAyfb
	 e9gLGRfK/k4EvLEalGAv0vqD6WV1ykIncDJ9lsyuGLrT1LA7RTFK7gG/5UYeQiqmPy
	 DaJ4rLddf78V4a+MqKxMuBv13AaF4jUHz761hHcM1u4i53Zcqa/0JHzPuLF+dGh3js
	 T7RMRxnYAkHgg==
Date: Wed, 12 Nov 2025 17:42:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <20251112234201.GA2250212@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112074614.1440266-1-mika.westerberg@linux.intel.com>

On Wed, Nov 12, 2025 at 08:46:14AM +0100, Mika Westerberg wrote:
> We have a Upstream Port (2b:00.0) that has following in the PTM capability:
> 
>   Capabilities: [220 v1] Precision Time Measurement
> 		PTMCap: Requester- Responder- Root-

Sec 7.9.15.2 says "Switches supporting PTM must Set PTM Responder
Capable".  To me that sounds like "Switches with a PTM Capability must
Set PTM Responder Capable".  But I guess whoever designed this device
didn't think the same way.

> Linux enables PTM for this without looking into what roles it actually
> supports. Immediately after enabling PTM we start getting these:
> 
>   pci 0000:2b:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
>   ...
>   pci 0000:2b:00.0: PTM enabled, 4ns granularity
>   ...
>   pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
>   pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
>   pcieport 0000:00:07.1:    [21] ACSViol                (First)
>   pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> 
> Fix this by enabling PTM only if any of the following conditions are
> true (see more in PCIe r7.0 sec 6.21.1 figure 6-21):
> 
>   - PCIe Endpoint that has PTM capability must to declare requester
>     capable
>   - PCIe Switch Upstream Port that has PTM capability must declare
>     at least responder capable
>   - PCIe Root Port must declare root port capable.
> 
> While there make the enabling happen for all in __pci_enable_ptm() instead
> of enabling some in pci_ptm_init() and some in __pci_enable_ptm().
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/ptm for v6.19, thanks!

> ---
> Hi,
> 
> I hope I did not make any stupid mistakes this time ;-) My testing still
> passed: the Root Port that has ->ptm_root (and ->ptm_responder) PTM is
> enabled and the Switch Upstream Port that does not have ->ptm_responder is
> not enabled (and I don't see the flood of AER errors).
>
> Previous versions can be seen:
> 
>   v4: https://lore.kernel.org/linux-pci/20251111061048.681752-1-mika.westerberg@linux.intel.com/
>   v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
>   v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
>   v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> 
> Changes from v4:
> 
>   - Do not enable PTM automatically for all components (e.g keep the
>     existing behavior).
>   - Make the switch-case new lines consistent.
> 
> Changes from v3:
> 
>   - Cache the responder and requester capability bits.
>   - Enable PTM only in __pci_enable_ptm().
>   - Update $subject and commit message.
>   - Since this is changed quite a lot, I dropped the Reviewed-by from Lukas
>     and also stable tag.
> 
> Changes from v2:
> 
>   - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
>     Endpoints.
>   - Added stable tags suggested by Lukas, and PCIe spec reference.
>   - Added Reviewed-by tag from Lukas (hope it is okay to keep).
> 
> Changes from v1:
> 
>   - Limit Switch Upstream Port only to Responder, not both Requester and
>     Responder.
> 
>  drivers/pci/pcie/ptm.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  2 ++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 65e4b008be00..fb1f3d0d8448 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -81,6 +81,11 @@ void pci_ptm_init(struct pci_dev *dev)
>  		dev->ptm_granularity = 0;
>  	}
>  
> +	if (cap & PCI_PTM_CAP_RES)
> +		dev->ptm_responder = 1;
> +	if (cap & PCI_PTM_CAP_REQ)
> +		dev->ptm_requester = 1;
> +
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>  	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
>  		pci_enable_ptm(dev, NULL);
> @@ -144,6 +149,36 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> +	switch (pci_pcie_type(dev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		/*
> +		 * Root Port must declare Root Capable if we want to enable
> +		 * PTM for it.
> +		 */
> +		if (!dev->ptm_root)
> +			return -EINVAL;
> +		break;
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		/*
> +		 * Switch Upstream Ports must at least declare Responder
> +		 * Capable if we want to enable PTM for it.
> +		 */
> +		if (!dev->ptm_responder)
> +			return -EINVAL;
> +		break;
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_LEG_END:
> +		/*
> +		 * PCIe Endpoint must declare Requester Capable before we
> +		 * can enable PTM for it.
> +		 */
> +		if (!dev->ptm_requester)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
>  
>  	ctrl |= PCI_PTM_CTRL_ENABLE;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..d5018cb5c331 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -500,6 +500,8 @@ struct pci_dev {
>  #ifdef CONFIG_PCIE_PTM
>  	u16		ptm_cap;		/* PTM Capability */
>  	unsigned int	ptm_root:1;
> +	unsigned int	ptm_responder:1;
> +	unsigned int	ptm_requester:1;
>  	unsigned int	ptm_enabled:1;
>  	u8		ptm_granularity;
>  #endif
> -- 
> 2.50.1
> 

