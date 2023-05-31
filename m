Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1D718836
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEaRMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEaRMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF593;
        Wed, 31 May 2023 10:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33BB60DE9;
        Wed, 31 May 2023 17:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD87C4339C;
        Wed, 31 May 2023 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685553134;
        bh=+Ml1j+mRUJgmXvowGAHL7NQaz1pxH/evVJuvs2hRgso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BYw8uvSKtQqAvjDQ1+aUtduoiKuESJASt6I+ZqQvJA20//6FeGNg1f866MI0WmXrT
         ruslzv5W28Kb6NwsYa/Ad9LZOTko8KfxpqzYAE5WtJWktKj6c06tq4gtDVwv/0Pwaa
         mDJqQwfoyV5LITBF0ptaPtkQU62PGfvfZrYX/EoeTekMyu8tbdC4xAoE58FqEESk2p
         eFIBgNmgyA68cfWPAbwwdKubtp/VUXFKB8qg6me5gxLsMyb5ASRluj4WLsfXQxe4Un
         /blsTaEObx/P02q5JlLcYRt8k4n4G5SotCTPWArugBDQtmsIg6K2A530cZDiM7CjtV
         unjSWwsaoEZtA==
Date:   Wed, 31 May 2023 12:12:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bharat.kumar.gogada@amd.com, michals@amd.com,
        nagaradhesh.yeleswarapu@amd.com
Subject: Re: [PATCH v4 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <ZHd/7AaLaGyr1jNA@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531083825.985584-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 02:08:25PM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>

> |Reported-by: kernel test robot <lkp@intel.com>
> |Reported-by: Dan Carpenter <error27@gmail.com>
> |Closes: https://lore.kernel.org/r/202305261250.2cs1phTS-lkp@intel.com/

Not relevant.  These are basically review comments.

> +	  Add support for the Xilinx PL DMA PCIe host bridge,
> +	  The controller is an soft IP which can act as Root Port.
> +	  If you know your system provides xilinx PCIe host controller
> +	  bridge DMA as soft IP say Y; if you are not sure, say N.

s/is an soft/is soft/
s/xilinx/Xilinx/

> +#define XILINX_PCIE_DMA_REG_IMR			0x0000013c
> +#define XILINX_PCIE_DMA_REG_MSIBASE1		0x0000014c
> +#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
> ...
> +#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0FF30FE9
> +#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xFFFFFFFF

Pick upper-case hex or lower-case hex and use it consistently.

> +static inline bool xilinx_pl_dma_pcie_linkup(struct pl_dma_pcie *port)

Name this *_pcie_link_up() (not *_pcie_linkup()) to match other drivers.

> +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct pl_dma_pcie *port = bus->sysdata;
> +
> +	/* Check if link is up when trying to access downstream ports */
> +	if (!pci_is_root_bus(bus)) {
> +		if (!xilinx_pl_dma_pcie_linkup(port))
> +			return false;
> +	} else if (devfn > 0)
> +		/* Only one device down on each root port */
> +		return false;
> +
> +	return true;
> +}
> +
> +static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
> +						unsigned int devfn, int where)
> +{
> +	struct pl_dma_pcie *port = bus->sysdata;
> +
> +	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
> +		return NULL;

Checking whether the link is up is racy because the link may be up, so
xilinx_pl_dma_pcie_valid_device() returns true, then the link may go
down before the read below.

What happens then?  If it's an error that you can recover from, it
would better to skip the link up check and just handle the error.

> +	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +}

> +	/*set the Bridge enable bit */

  /* Set ... */ (add space before "Set" and capitalize it)

Bjorn
