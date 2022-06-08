Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83C543C9F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiFHTOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFHTOl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 15:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601E3F884;
        Wed,  8 Jun 2022 12:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF7D60FAB;
        Wed,  8 Jun 2022 19:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B0AC34116;
        Wed,  8 Jun 2022 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654715679;
        bh=0rNMUCfQcHHTqjT199r4QVyK/7bbE1wu48hOAmOqe/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fWUKDN3HdyeoOCCIGoO65OTTGl08TgDFk9rnT/BgnI+b9X+z7jXEmgn095lkSXDth
         r1XDIWdTOnGFFyNmJe5/hxfbsfnWdPnAPXcsQyai/ZWoP1Vjn8I/5yphOu6YwFzDOI
         YlyV1RozBHWL6vYpWOB/a7/j88JLg042gv3yn5acw0EC9SumgyVap9Rh1EuDBY/zjk
         EAEA0uhXokqqa+HC5IARypsQicbTVznZddfx4JUDwMKL88o1KHC1jh6cEeR2GRxK0j
         qiQszr0mef+a7kfx96Gu0c6N6rcZsqeRf6KQw8Y94zFII5BlQUgE2pDh2eLS5fCpgv
         wCLorWuYeMU6Q==
Date:   Wed, 8 Jun 2022 14:14:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, michals@xilinx.com, robh@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Message-ID: <20220608191437.GA411770@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608164046.3474-3-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 10:10:46PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additional register bit
>   to enable and handle legacy interrupts.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 33 +++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Per MAINTAINERS, xilinx-cpm lacks a maintainer.  Can we get one?

> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index c7cd44ed4dfc..a3b04083b6b3 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -35,6 +35,10 @@
>  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
>  #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
>  
> +#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> +#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> +#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> +
>  /* Interrupt registers definitions */
>  #define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
>  #define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> @@ -109,6 +113,7 @@
>   * @intx_irq: legacy interrupt number
>   * @irq: Error interrupt number
>   * @lock: lock protecting shared register access
> + * @is_cpm5: value to check cpm version

s/cpm version/CPM version/ to match commit log usage.

> +	port->is_cpm5 = of_device_is_compatible(dev->of_node,
> +						"xlnx,versal-cpm5-host");

One use of of_device_is_compatible() is OK, I guess, but
of_device_get_match_data() is a better pattern if we ever need more.

I would lean toward of_device_get_match_data() even here, just to
reduce the number of ways to identify device-specific things across
drivers.

Bjorn
