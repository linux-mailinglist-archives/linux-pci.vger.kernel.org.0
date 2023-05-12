Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8F700E0F
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjELRnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbjELRnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 13:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D88A60;
        Fri, 12 May 2023 10:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E95C655A2;
        Fri, 12 May 2023 17:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281FCC433D2;
        Fri, 12 May 2023 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683913392;
        bh=8dnEAPYSaM02SPoSf8y4owLG82vWOcV/xnoeR97sfyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jGZXxrtBpXH+FlPyX750QDcQSG5gCO5NIaf3MV5P87ApMc+KRqbmU4qs6TnxfouXD
         y+0Hqmi9LDK3lvkq0Sl09zQo9kx/DBzLqcFiLd4XREXJ+CafFw65P0jxQLnuz7HOBp
         2jw8PQAGGKJaiyXfUPiqSyicXNKSFQSE5bDa7B5TtIpyu5ht7PIaocaoLxBJkERG6I
         7VOFkiDlk9Ny2TEpKtG87YcWLl5HbrEfrAHnkW2X41g1YGFt4ap6GSOF+qGEUNhjNq
         Le86qjlsYanzZ9azPFxg3rUtyy0cmSXd5D/0o0iod8dXIDWVWz+iVWufsYXzJ8SU//
         j09X9fP+RpnRA==
Date:   Fri, 12 May 2023 12:43:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <ZF56rHL+4Cv7VOuN@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 11:57:25AM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.

> +config PCIE_XILINX_DMA
> +	bool "Xilinx DMA PL PCIe host bridge support"

Whatever name/text you settle on, make sure it's in alpha order in the
config menu seen by users.  As-is, this patch would make it:

  Xilinx AXI PCIe controller
  Xilinx NWL PCIe controller
  Xilinx Versal CPM PCI controller
  Xilinx DMA PL PCIe host bridge support

which is not in alpha order.

> +	  Say 'Y' here if you want kernel to enable support for the
> +	  XILINX PL PCIe host bridge support, this PCIe controller
> +	  includes DMA PL component.

> +obj-$(CONFIG_PCIE_XILINX_DMA) += pcie-xdma-pl.o

I think this filename needs to include xilinx somehow, not just "xdma".

Since the probe function calls pci_host_probe() in addition to the DMA
setup, I guess this is a fourth Xilinx host bridge, a peer of AXI,
CPM, and NWL, and independent of them?

Is the "xdma" or ("DMA PL" as used in Kconfig) name also a peer to
"CPM" and "NWL"?  The Kconfig text, especially, should use names that
users will recognize.  "DMA" or "XDMA" seems a little generic.  The
commit log mentions "Zynq" and "Ultrascale+", neither of which appears
in Kconfig, so there are a lot of names in play here, which is
confusing.

> +struct xilinx_pcie_dma {

git grep "^struct .*pcie.*" drivers/pci/controller/ says the typical
names are "<driver>_pcie".  Please do the same.

> +	void __iomem			*reg_base;
> +	u32				irq;
> +	struct pci_config_window	*cfg;
> +	struct device			*dev;

Please use typical order, i.e., "dev" first, followed by "reg_base",
etc.  Look at other drivers and make this similar.  No need to be
creatively different.

> +static inline bool xilinx_pcie_dma_linkup(struct xilinx_pcie_dma *port)

Please use the *_pcie_link_up() naming scheme used elsewhere in
drivers/pci/controller/.

> +static bool xilinx_pcie_dma_valid_device(struct pci_bus *bus, unsigned int devfn)

Similarly, *_pcie_valid_device().  Lots more instances below.  Don't
split the "pcie" from the rest of the generic parts of the name.

> +static struct pci_ecam_ops xilinx_pcie_dma_ops = {

const *_ecam_ops

> +static void xilinx_mask_leg_irq(struct irq_data *data)
> +static void xilinx_unmask_leg_irq(struct irq_data *data)
> +static struct irq_chip xilinx_leg_irq_chip = {
> +	.name           = "INTx",
> +	.irq_mask       = xilinx_mask_leg_irq,
> +	.irq_unmask     = xilinx_unmask_leg_irq,
> +};

You use "intx" in the names below.  Please also use "intx" instead of
"leg" in the names above.  No need for two different names for the
same concept.

> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = xilinx_pcie_dma_intx_map,

> +	/* Enable the Bridge enable bit */

"Set the ... enable bit"

> +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |

> +static int xilinx_pcie_dma_parse_dt(struct xilinx_pcie_dma *port,
> +				    struct resource *bus_range)
> +{
> +	struct device *dev = port->dev;
> +	int err;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;

Weird ordering.  Suggest order of use:

  struct device *dev = port->dev;
  struct platform_device *pdev = to_platform_device(dev);
  struct resource *res;
  int err;

> +static int xilinx_pcie_dma_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_pcie_dma *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *bus;
> +	int err;

Would order "struct device *dev" first.

Bjorn
