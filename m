Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54A8E95C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfHOK4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 06:56:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbfHOK4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 06:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A9D328;
        Thu, 15 Aug 2019 03:56:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9A053F694;
        Thu, 15 Aug 2019 03:56:08 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:56:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v8] PCI: imx6: limit DBI register length
Message-ID: <20190815105604.GA11095@e121166-lin.cambridge.arm.com>
References: <20190726144007.26605-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726144007.26605-1-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 04:40:07PM +0200, Stefan Agner wrote:
> Define the length of the DBI registers and limit config space to its
> length. This makes sure that the kernel does not access registers
> beyond that point, avoiding the following abort on a i.MX 6Quad:
>   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>   ...
>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>   ...
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v3:
> - Rebase on pci/dwc
> Changes in v4:
> - Rebase on pci/dwc
> Changes in v5:
> - Rebased ontop of pci/dwc
> - Use DBI length of 0x200
> Changes in v6:
> - Use pci_dev.cfg_size mechanism to limit config space (this made patch 1
>   of previous versions of this patchset obsolete).
> Changes in v7:
> - Restrict fixup to Synopsys/0xabcd
> - Apply cfg_size limitation only if dbi_length is specified
> Changes in v8:
> - Restrict fixup for Synopsys/0xabcd and class PCI bridge
> - Check device driver to be pci-imx6
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied to pci/imx for v5.4.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9b5cb5b70389..8b8efa3063f5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -57,6 +57,7 @@ enum imx6_pcie_variants {
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	u32 flags;
> +	int dbi_length;
>  };
>  
>  struct imx6_pcie {
> @@ -1212,6 +1213,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX6Q,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> +		.dbi_length = 0x200,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1254,6 +1256,37 @@ static struct platform_driver imx6_pcie_driver = {
>  	.shutdown = imx6_pcie_shutdown,
>  };
>  
> +static void imx6_pcie_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pcie_port *pp = bus->sysdata;
> +
> +	/* Bus parent is the PCI bridge, its parent is this platform driver */
> +	if (!bus->dev.parent || !bus->dev.parent->parent)
> +		return;
> +
> +	/* Make sure we only quirk devices associated with this driver */
> +	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
> +		return;
> +
> +	if (bus->number == pp->root_bus_nr) {
> +		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +		/*
> +		 * Limit config length to avoid the kernel reading beyond
> +		 * the register set and causing an abort on i.MX 6Quad
> +		 */
> +		if (imx6_pcie->drvdata->dbi_length) {
> +			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
> +			dev_info(&dev->dev, "Limiting cfg_size to %d\n",
> +					dev->cfg_size);
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
> +			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);
> +
>  static int __init imx6_pcie_init(void)
>  {
>  #ifdef CONFIG_ARM
> -- 
> 2.22.0
> 
