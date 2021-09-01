Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB53FE42B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhIAUlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 16:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhIAUlo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 16:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12DDE60EBB;
        Wed,  1 Sep 2021 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630528847;
        bh=v28mP6PoTgi7Xgq3oHoJto/kuqOc6c3EfIXanjA9ihY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ezYiM2Zj+uSUYZKzy6upkAMZlI8/PQNILS0i8boFOOvLMjQg8mKKkgmL7KxNd9ooY
         X3Q+R04oRUuxiGaA2WZYIrnKq3GkcFcVVUodHk2UjR2OxJfZXlcYbpk1wUPfEOqqBN
         ysT8HnjDjprExt71p5TYwJZCkLoKfbncp/WT9NVBFLZ/C47BI0zEfuVY5DBg+9Ehrj
         4V8Zs9W2I7fEdavuQGvoP/zxNpgd7ZBQKuJp5ml2SMGwkwEykxLB03WwrClR2chF9P
         rTiDWc1XTw4mEtlUnnGnhemh1E3mZrloaVLrrQSMth7DiXKJ/NbUNxtyAviqPmZeVv
         +V/UrF14ev1jw==
Date:   Wed, 1 Sep 2021 15:40:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, treding@nvidia.com,
        swarren@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20
 & Tegra30
Message-ID: <20210901204045.GA236987@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704150428.4035-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 04, 2019 at 08:34:28PM +0530, Vidya Sagar wrote:
> Currently Relaxed Ordering bit in the configuration space is enabled for
> all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
> Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
> in Sec 34.1, it is mentioned that Relaxed Ordering bit needs to be enabled in
> its root ports to avoid deadlock in hardware. The same is applicable for
> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
> but the same must not be extended to root ports of other Tegra SoCs or
> other hosts as the same issue doesn't exist there.

While researching another thread about RO [1], I got concerned about
setting RO for root ports.

Setting RO for *endpoints* makes sense: that allows (but does not
require) the endpoint to issue writes that don't require strong
ordering.

Setting RO for *root ports* seems more problematic.  It allows the
root port to issue PCIe writes that don't require strong ordering.
These would be CPU MMIO writes to devices.  But Linux currently does
not have a way for drivers to indicate that some MMIO writes need to
be ordered while others do not, and I think drivers assume that all
MMIO writes are performed in order. 

We merged this patch as 7be142caabc4 ("PCI: tegra: Enable Relaxed
Ordering only for Tegra20 & Tegra30") [2], so Tegra20 and Tegra30 root
ports are allowed (but again, not required) to set the RO bit for MMIO
writes initiated by a CPU.

Because I think drivers *rely* on MMIO writes being strongly ordered,
this is a potential problem.  I think we should probably consider
explicitly *disabling* RO in all root ports (with exceptions for
quirks like this) in case it's set by any firmware.

So the question is, how do Tegra20 and Tegra30 actually work?  Do they
ever actually set the RO bit for these MMIO writes?  If so, I think
drivers are really at risk, and we probably should log some kind of
warning.

But if Tegra20 and Tegra30 just need "Enable Relaxed Ordering" set as
a bug workaround and they never actually initiate PCIe writes with the
RO bit set, maybe we should add a comment to that effect, but there
should be no actual problem.

[1] https://lore.kernel.org/r/20210830123704.221494-2-verdre@v0yd.nl
[2] https://git.kernel.org/linus/7be142caabc4

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Modified commit message to make it more precise and explicit
> 
> V2:
> * Modified commit message to include reference to Tegra20 TRM document.
> 
>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 9cc03a2549c0..241760aa15bd 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -787,12 +787,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
>  
> -/* Tegra PCIE requires relaxed ordering */
> +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
>  static void tegra_pcie_relax_enable(struct pci_dev *dev)
>  {
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
>  
>  static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>  {
> -- 
> 2.17.1
> 
