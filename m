Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265C2D8DA7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbfJPKQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 06:16:42 -0400
Received: from foss.arm.com ([217.140.110.172]:35020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbfJPKQm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 06:16:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B0528;
        Wed, 16 Oct 2019 03:16:41 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50ECB3F6C4;
        Wed, 16 Oct 2019 03:16:39 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:16:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: pci: Update iProc PCI binding for
 INTx support
Message-ID: <20191016101636.GB22848@e121166-lin.cambridge.arm.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
 <1566982488-9673-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566982488-9673-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 02:24:43PM +0530, Srinath Mannam wrote:
> From: Ray Jui <ray.jui@broadcom.com>
> 
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 48 ++++++++++++++++++----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index df065aa..f23decb 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -13,9 +13,6 @@ controller, used in Stingray
>    PAXB-based root complex is used for external endpoint devices. PAXC-based
>  root complex is connected to emulated endpoint devices internal to the ASIC
>  - reg: base address and length of the PCIe controller I/O register space
> -- #interrupt-cells: set to <1>
> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> -  mapping of the PCIe interface to interrupt numbers
>  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>  - bus-range: PCI bus numbers covered
>  - #address-cells: set to <3>
> @@ -41,6 +38,21 @@ Required:
>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>  address used by the iProc PCIe core (not the PCIe address)
>  
> +Legacy interrupt (INTx) support (optional):
> +
> +Note INTx is for PAXB only.
> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
> +the mapping of the PCIe interface to interrupt numbers
> +
> +In addition, a sub-node that describes the legacy interrupt controller built
> +into the PCIe controller.
> +This sub-node must have the following properties:
> + - compatible: must be "brcm,iproc-intc"
> + - interrupt-controller: claims itself as an interrupt controller for INTx
> + - #interrupt-cells: set to <1>
> + - interrupts: interrupt line wired to the generic GIC for INTx support
> + - interrupt-parent: Phandle to the parent interrupt controller
> +
>  MSI support (optional):
>  
>  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
> @@ -77,8 +89,11 @@ Example:
>  		reg = <0x18012000 0x1000>;
>  
>  		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie0_intc 1>,
> +				<0 0 0 2 &pcie0_intc 2>,
> +				<0 0 0 3 &pcie0_intc 3>,
> +				<0 0 0 4 &pcie0_intc 4>;

This is not how the interrupt controller works in your PCI host
bridge.

You are mapping INT{A,B,C,D} to pin 0,1,2,3 of the interrupt
controller.

This is how it is meant to be (which is also removing the completely
bogus need for the (+1) in the irq domain allocation (ie the domain
size is PCI_NUM_INTX not (PCI_NUM_INTX + 1))):

interrupt-map = <0 0 0 1 &pcie0_intc 0>,
		<0 0 0 2 &pcie0_intc 1>,
		<0 0 0 3 &pcie0_intc 2>,
		<0 0 0 4 &pcie0_intc 3>;

We need to write common bindings and kernel code to deal with these PCI
host controller interrupt controllers they are almost all implemented
wrongly in the kernel and copy and paste does the rest.

The IRQ domain subsequent patch is wrong too, please have a look
at how:

drivers/pci/controller/pci-ftpci100.c

models the legacy IRQ domain and follow it.
>  
>  		linux,pci-domain = <0>;
>  
> @@ -98,6 +113,14 @@ Example:
>  
>  		msi-parent = <&msi0>;
>  
> +		pcie0_intc: interrupt-controller {
> +			compatible = "brcm,iproc-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
> +		};
> +
>  		/* iProc event queue based MSI */
>  		msi0: msi@18012000 {
>  			compatible = "brcm,iproc-msi";
> @@ -115,8 +138,11 @@ Example:
>  		reg = <0x18013000 0x1000>;
>  
>  		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie1_intc 1>,
> +				<0 0 0 2 &pcie1_intc 2>,
> +				<0 0 0 3 &pcie1_intc 3>,
> +				<0 0 0 4 &pcie1_intc 4>;
>  
>  		linux,pci-domain = <1>;
>  
> @@ -130,4 +156,12 @@ Example:
>  
>  		phys = <&phy 1 6>;
>  		phy-names = "pcie-phy";
> +
> +		pcie1_intc: interrupt-controller {
> +			compatible = "brcm,iproc-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
> +		};
>  	};
> -- 
> 2.7.4
> 
