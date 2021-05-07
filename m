Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF593765B3
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhEGNEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 09:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235836AbhEGNEI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 09:04:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF6C46143F;
        Fri,  7 May 2021 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620392589;
        bh=D6tlwEAZ7eCBlX2hF7kas98mcfOt8qkO9WqLf5nvISw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qh5hEKGA1AtUF3SJIVptuc3lTAGNuwd8uyuDNNQLtDHsxiJdQi06lDyRRR+bunggf
         whyACVAcqrk2cFycZwtAO5JqX1OROu1a69+GBd7ifMooXxM59fpBo6pODO+w/9TRGn
         VbDkqD1dWbpzQCQUcKvT1RkMdajBpDh4O31BKdeiTKhS2hW09O18mQOFsbh2aTxJcK
         GYCbOc7D9noT6HQ0HwyW2Bc/Un66Y7LHP3LfqUKK35YIONJ+2icr11xYOtaHI+yjR2
         Bqa1uHeftLLv1I9sjrTd+A/kDXNMAK3mUHueaUNJLr2Ohe1FwA1AvmFmnyZK8mztN+
         K4co8ETz9d0vw==
Date:   Fri, 7 May 2021 08:03:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/42] PCI: aardvark: Fix reporting CRS Software
 Visibility on emulated bridge
Message-ID: <20210507130307.GA1448097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506153153.30454-7-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 05:31:17PM +0200, Pali Rohár wrote:
> CRS Software Visibility is supported and always enabled by PIO.
> Correctly report this information via emulated root bridge.

Maybe spell out "Configuration Request Retry Status (CRS) Software
Visibility" once.

I'm guessing the aardvark hardware spec is proprietary, but can you at
least include a reference to the section that says CRSVIS is
supported and CRSSVE is enabled?

What is PIO?  I assume this is something other than "programmed I/O"?

I'd like the commit log to say something about the effect of this
change, i.e., why are we doing it?

For one thing, I expect lspci will now show "RootCtl: ... CRSVisible+"
and "RootCap: CRSVisible+".

With PCI_EXP_RTCAP_CRSVIS set, pci_enable_crs() should now try to set
PCI_EXP_RTCTL_CRSSVE (which I think is a no-op since
advk_pci_bridge_emul_pcie_conf_write() doesn't do anything with
PCI_EXP_RTCTL_CRSSVE).

So AFAICT this has zero effect on the kernel.  Possibly we *should*
base some kernel behavior on whether PCI_EXP_RTCTL_CRSSVE is set, but
I don't think we do today.

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Cc: stable@vger.kernel.org

Again, I think this just adds functionality and doesn't fix something
that used to be broken.

Per [1], patches for the stable kernel should be for serious issues
like an oops, hang, data corruption, etc.  I know stable kernel
maintainers pick up all sorts of other stuff, but that's up to them.
I try to limit stable tags to reduce the risk of regressing.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v5.11

> ---
>  drivers/pci/controller/pci-aardvark.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 3f3c72927afb..e297ec9ec390 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -578,6 +578,8 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  	case PCI_EXP_RTCTL: {
>  		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
>  		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
> +		*value |= PCI_EXP_RTCTL_CRSSVE;
> +		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	}
>  
> @@ -659,6 +661,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
>  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  {
>  	struct pci_bridge_emul *bridge = &pcie->bridge;
> +	int ret;
>  
>  	bridge->conf.vendor =
>  		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> @@ -682,7 +685,16 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	bridge->data = pcie;
>  	bridge->ops = &advk_pci_bridge_emul_ops;
>  
> -	return pci_bridge_emul_init(bridge, 0);
> +	/* PCIe config space can be initialized after pci_bridge_emul_init() */
> +	ret = pci_bridge_emul_init(bridge, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Completion Retry Status is supported and always enabled by PIO */

"CRS Software Visibility", not "Completion Retry Status".

The CRSSVE bit is *supposed* to be RW, per spec.  Is it RO on this
hardware?

> +	bridge->pcie_conf.rootctl = cpu_to_le16(PCI_EXP_RTCTL_CRSSVE);
> +	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> +
> +	return 0;
>  }
>  
>  static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> -- 
> 2.20.1
> 
