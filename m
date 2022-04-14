Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA03501C16
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiDNTm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345798AbiDNTmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 15:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9B49FBD;
        Thu, 14 Apr 2022 12:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D7961DF9;
        Thu, 14 Apr 2022 19:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E0C385A1;
        Thu, 14 Apr 2022 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649965218;
        bh=VhIo5zoKkNLmMaQV6qXIkHE2FIUbCi00PmoyQe9eHpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qlqZnMvO27lGJle6LAb52uCOq6TnKoo+7vlwx+15HTq6j4K2xSaJ2fJsrqDeTuNKn
         Q+2NraIbrwVDYVpH59ClklZ6EoEMIJQuelB+KXJKCdlREfJwbUaeX6weDlmdhcs6qL
         ng2MhT1b8nM/UpgUigg6haFROAvMEsXGMGu2DKXuc13O2LQHDztogsrtRptutIYcn4
         +eiH/PLthKez9NVoaPRCQsBGR83LGeeXJLtrDNIU7gOiyvP1I5w5EGa9ycvSOOXNEx
         AZ5qHV4lEXbQVhHOn1nxYarxVF8YZ59cff0uPVD95Y34TtLqQ0EsLg2ThQBmbsMnQ0
         oTi1dx7D3qq0g==
Date:   Thu, 14 Apr 2022 14:40:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: pci: layerscape-pci: define AER/PME
 interrupts
Message-ID: <20220414194016.GA764042@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311234938.8706-5-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 11, 2022 at 05:49:38PM -0600, Li Yang wrote:
> Different platforms using this controller are using different numbers of
> interrupt lines and the routing of events to these interrupt lines are
> different too.  So instead of trying to define names for these interrupt
> lines, we define the more specific AER/PME events that are routed to
> these interrupt lines.
> 
> For platforms which only has a single interrupt line for miscellaneous
> controller events, we can keep using the original "intr" name for
> backward compatibility.
> 
> Also change the example from ls1021a to ls1088a for better representation.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

1) Please pay attention to your subject lines and make them match.
In this series you have:

  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  dt-bindings: pci: layerscape-pci: Update the description of SCFG property
  dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls1028a
  dt-bindings: pci: layerscape-pci: define AER/PME interrupt

Note that all are capitalized except "define AER/PME interrupt".

2) Also capitalize "AER" in the comment below so it matches usage in
the commit log and the property descriptions.

3) This diff is HUGE because you replace a bunch of tabs with spaces.
That seems like a pointless change, but if you want to do it, at least
do it in a separate patch all by itself that *only* changes tabs to
spaces.  Then we'll be able to see what actually happened in the
patch that adds the properties.

This has already been merged, so unless you need to update this series
for some other reason, these are just tips for the future.

> ---
>  .../bindings/pci/layerscape-pci.txt           | 58 ++++++++++---------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 8fd6039a826b..ee8a4791a78b 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -31,8 +31,14 @@ Required properties:
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +- interrupt-names: It could include the following entries:
> +  "aer": Used for interrupt line which reports AER events when
> +	 non MSI/MSI-X/INTx mode is used
> +  "pme": Used for interrupt line which reports PME events when
> +	 non MSI/MSI-X/INTx mode is used
> +  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> +	  which has a single interrupt line for miscellaneous controller
> +	  events(could include AER and PME events).
>  - fsl,pcie-scfg: Must include two entries.
>    The first entry must be a link to the SCFG device node
>    The second entry is the physical PCIe controller index starting from '0'.
> @@ -47,27 +53,27 @@ Optional properties:
>  
>  Example:
>  
> -	pcie@3400000 {
> -		compatible = "fsl,ls1021a-pcie";
> -		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
> -		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
> -		reg-names = "regs", "config";
> -		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> -		interrupt-names = "intr";
> -		fsl,pcie-scfg = <&scfg 0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		device_type = "pci";
> -		dma-coherent;
> -		num-lanes = <4>;
> -		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> -			  0xc2000000 0x0 0x20000000 0x40 0x20000000 0x0 0x20000000   /* prefetchable memory */
> -			  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
> -				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> -				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> -				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> +        pcie@3400000 {
> +                compatible = "fsl,ls1088a-pcie";
> +                reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> +                      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> +                reg-names = "regs", "config";
> +                interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +                interrupt-names = "aer";
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                device_type = "pci";
> +                dma-coherent;
> +                num-viewport = <256>;
> +                bus-range = <0x0 0xff>;
> +                ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                msi-parent = <&its>;
> +                #interrupt-cells = <1>;
> +                interrupt-map-mask = <0 0 0 7>;
> +                interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> +                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> +                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> +                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> +                iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +        };
> -- 
> 2.25.1
> 
