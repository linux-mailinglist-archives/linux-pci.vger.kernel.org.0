Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5442089C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhJDJqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 05:46:18 -0400
Received: from foss.arm.com ([217.140.110.172]:58414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232364AbhJDJqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 05:46:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BA4101E;
        Mon,  4 Oct 2021 02:44:29 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664D63F766;
        Mon,  4 Oct 2021 02:44:28 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:44:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 10/13] PCI: aardvark: Simplify initialization of rootcap
 on virtual bridge
Message-ID: <20211004094422.GA22827@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
 <20211001195856.10081-11-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001195856.10081-11-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 09:58:53PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> PCIe config space can be initialized also before pci_bridge_emul_init()
> call, so move rootcap initialization after PCI config space initialization.
> 
> This simplifies the function a little since it removes one if (ret < 0)
> check.
> 
> Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")

Is this a fix ? If not I will remove this tag.

Lorenzo

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 7b9870d0b81f..74d1ec7eff16 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -822,7 +822,6 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
>  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  {
>  	struct pci_bridge_emul *bridge = &pcie->bridge;
> -	int ret;
>  
>  	bridge->conf.vendor =
>  		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> @@ -842,19 +841,14 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	/* Support interrupt A for MSI feature */
>  	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
>  
> +	/* Indicates supports for Completion Retry Status */
> +	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> +
>  	bridge->has_pcie = true;
>  	bridge->data = pcie;
>  	bridge->ops = &advk_pci_bridge_emul_ops;
>  
> -	/* PCIe config space can be initialized after pci_bridge_emul_init() */
> -	ret = pci_bridge_emul_init(bridge, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Indicates supports for Completion Retry Status */
> -	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> -
> -	return 0;
> +	return pci_bridge_emul_init(bridge, 0);
>  }
>  
>  static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> -- 
> 2.32.0
> 
