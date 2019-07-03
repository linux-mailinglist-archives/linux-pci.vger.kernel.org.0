Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9245E966
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGCQjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 12:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfGCQjx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 12:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E662C344;
        Wed,  3 Jul 2019 09:39:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914F73F718;
        Wed,  3 Jul 2019 09:39:51 -0700 (PDT)
Date:   Wed, 3 Jul 2019 17:39:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, treding@nvidia.com, swarren@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: tegra: Enable Relaxed Ordering only for Tegra20
 & Tegra30
Message-ID: <20190703161922.GA22679@e121166-lin.cambridge.arm.com>
References: <20190701110942.24305-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701110942.24305-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 04:39:42PM +0530, Vidya Sagar wrote:
> Currently Relaxed Ordering bit in the configuration space is enabled for
> all devices, but, as per the Technical Reference Manual of Tegra20 which is

What devices ?

> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
> its root ports to avoid deadlock in hardware. The same is applicable for
> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
> but the same should not be extended to root ports of other Tegra SoCs or
> other hosts.

Should not or must not ? What does this sentence mean ?

Can we try to be more precise please ?

As I said before the commit log must be clear to anyone reading it
even if he has no background information.

Lorenzo

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
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
