Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0FA5FB89
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDQJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 12:09:55 -0400
Received: from foss.arm.com ([217.140.110.172]:44984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfGDQJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jul 2019 12:09:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B502C2B;
        Thu,  4 Jul 2019 09:09:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607C83F703;
        Thu,  4 Jul 2019 09:09:53 -0700 (PDT)
Date:   Thu, 4 Jul 2019 17:09:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, treding@nvidia.com, swarren@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20
 & Tegra30
Message-ID: <20190704160948.GA28058@e121166-lin.cambridge.arm.com>
References: <20190704150428.4035-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704150428.4035-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 04, 2019 at 08:34:28PM +0530, Vidya Sagar wrote:
> Currently Relaxed Ordering bit in the configuration space is enabled for
> all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
> Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
> its root ports to avoid deadlock in hardware. The same is applicable for
> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
> but the same must not be extended to root ports of other Tegra SoCs or
> other hosts as the same issue doesn't exist there.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

You forgot Thierry's ACK, I added it back but next time pay more
attention please.

You should link the versions through eg git send-email
--in-reply-to=Message-Id so that it is easier to follow.

> ---
> V3:
> * Modified commit message to make it more precise and explicit
> 
> V2:
> * Modified commit message to include reference to Tegra20 TRM document.
> 
>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I applied it to pci/tegra after rewriting the whole commit log and
adding a Fixes: tag that you or someone at Nvidia will follow up;
I will check.

Please have a look and report back any issues you notice.

Lorenzo

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
