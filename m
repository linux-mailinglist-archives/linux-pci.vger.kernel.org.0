Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A64CA92C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiCBPiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 10:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiCBPiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 10:38:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C945B192AF;
        Wed,  2 Mar 2022 07:37:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8823313D5;
        Wed,  2 Mar 2022 07:37:30 -0800 (PST)
Received: from lpieralisi (unknown [10.57.37.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A241E3F73D;
        Wed,  2 Mar 2022 07:37:29 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:37:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Message-ID: <Yh+PN5ct8T87f6Ve@lpieralisi>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
 <20220215124606.28627-2-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215124606.28627-2-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 06:16:05PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)

https://docs.kernel.org/devicetree/bindings/submitting-patches.html

You have to CC the devicetree ML and DT maintainers.

Thanks,
Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..97c7229d7f91 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,17 +14,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    contains:
> +      enum:
> +        - xlnx,versal-cpm-host-1.00
> +        - xlnx,versal-cpm5-host-1.00
>  
>    reg:
> -    items:
> -      - description: Configuration space region and bridge registers.
> -      - description: CPM system level control and status registers.
> +    description: |
> +      Should contain cpm_slcr, cfg registers location and length.
> +      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
> +    minItems: 2
> +    maxItems: 3
>  
>    reg-names:
> -    items:
> -      - const: cfg
> -      - const: cpm_slcr
> +    minItems: 2
> +    maxItems: 3
>  
>    interrupts:
>      maxItems: 1
> @@ -95,4 +99,33 @@ examples:
>                                 interrupt-controller;
>                         };
>                 };
> +
> +              cpm5_pcie: pcie@fcdd0000 {
> +                       compatible = "xlnx,versal-cpm5-host-1.00";
> +                       device_type = "pci";
> +                       #address-cells = <3>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       interrupts = <0 72 4>;
> +                       interrupt-parent = <&gic>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
> +                                       <0 0 0 2 &pcie_intc_1 1>,
> +                                       <0 0 0 3 &pcie_intc_1 2>,
> +                                       <0 0 0 4 &pcie_intc_1 3>;
> +                       bus-range = <0x00 0xff>;
> +                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
> +                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
> +                       msi-map = <0x0 &its_gic 0x0 0x10000>;
> +                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
> +                             <0x06 0x00000000 0x00 0x1000000>,
> +                             <0x00 0xfce20000 0x00 0x1000000>;
> +                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
> +
> +                       pcie_intc_1: interrupt-controller {
> +                               #address-cells = <0>;
> +                               #interrupt-cells = <1>;
> +                               interrupt-controller;
> +                       };
> +               };
>      };
> -- 
> 2.17.1
> 
