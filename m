Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665B91941FD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgCZOvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 10:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgCZOvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 10:51:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B692078B;
        Thu, 26 Mar 2020 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234308;
        bh=p3zv7d1KVn/lO0YWV+VHW3tOP5OSRao+l1dqyJw8S5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UfsHThTwiuyFpUiJWXxGs/wTECR1yUDEUwZeUTA2UgRjdb0qc8HlCXpU+grRqkEX+
         4vCdmgFDaTGdVbk12d337OwrZ3f4gSrZwsyZKeP035fc56LSdHycfVOiwchkhrstpo
         gDmnuk9+ZUi6BAvV0Od2OLVT3LtF5O+7W3kcSKjc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jHTrH-00FuHQ-21; Thu, 26 Mar 2020 14:51:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Mar 2020 14:51:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/6] dt-bindings: pci: Update iProc PCI binding for
 INTx support
In-Reply-To: <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
 <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <54b2c749ec398e1c63880a7945f633ab@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: srinath.mannam@broadcom.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, f.fainelli@gmail.com, rjui@broadcom.com, robh+dt@kernel.org, andrew.murray@arm.com, mark.rutland@arm.com, andy.shevchenko@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ray.jui@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Srinath,

Please note that Andrew's email address as changed (see the MAINTAINERS 
file).

On 2020-03-26 06:48, Srinath Mannam wrote:
> From: Ray Jui <ray.jui@broadcom.com>
> 
> Update the iProc PCIe binding document for better modeling of the 
> legacy
> interrupt (INTx) support.
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 48 
> ++++++++++++++++++----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index df065aa..d3f833a 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -13,9 +13,6 @@ controller, used in Stingray
>    PAXB-based root complex is used for external endpoint devices. 
> PAXC-based
>  root complex is connected to emulated endpoint devices internal to the 
> ASIC
>  - reg: base address and length of the PCIe controller I/O register 
> space
> -- #interrupt-cells: set to <1>
> -- interrupt-map-mask and interrupt-map, standard PCI properties to 
> define the
> -  mapping of the PCIe interface to interrupt numbers
>  - linux,pci-domain: PCI domain ID. Should be unique for each host 
> controller
>  - bus-range: PCI bus numbers covered
>  - #address-cells: set to <3>
> @@ -41,6 +38,21 @@ Required:
>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the 
> internal
>  address used by the iProc PCIe core (not the PCIe address)
> 
> +Legacy interrupt (INTx) support (optional):
> +
> +Note INTx is for PAXB only.
> +- interrupt-map-mask and interrupt-map, standard PCI properties to 
> define
> +the mapping of the PCIe interface to interrupt numbers
> +
> +In addition, a sub-node that describes the legacy interrupt controller 
> built
> +into the PCIe controller.
> +This sub-node must have the following properties:
> + - compatible: must be "brcm,iproc-intc"
> + - interrupt-controller: claims itself as an interrupt controller for 
> INTx
> + - #interrupt-cells: set to <1>
> + - interrupts: interrupt line wired to the generic GIC for INTx 
> support
> + - interrupt-parent: Phandle to the parent interrupt controller
> +
>  MSI support (optional):
> 
>  For older platforms without MSI integrated in the GIC, iProc PCIe core 
> provides
> @@ -77,8 +89,11 @@ Example:
>  		reg = <0x18012000 0x1000>;
> 
>  		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
> +				<0 0 0 2 &pcie0_intc 1>,
> +				<0 0 0 3 &pcie0_intc 2>,
> +				<0 0 0 4 &pcie0_intc 3>;
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

There is no such thing as IRQ_TYPE_NONE in the GIC binding.
Please update this to the right trigger type (which better
be level high...)

         M.
-- 
Jazz is not dead. It just smells funny...
