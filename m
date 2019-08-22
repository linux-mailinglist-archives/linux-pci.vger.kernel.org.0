Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344A6991E3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfHVLPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 07:15:42 -0400
Received: from foss.arm.com ([217.140.110.172]:44146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfHVLPm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 07:15:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21DAE344;
        Thu, 22 Aug 2019 04:15:41 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EC6F3F246;
        Thu, 22 Aug 2019 04:15:40 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:15:39 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] dt-bindings: PCI: Add Amazon's Annapurna Labs
 PCIe host bridge binding
Message-ID: <20190822111537.GO23903@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821154745.31834-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154745.31834-1-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 06:47:43PM +0300, Jonathan Chocron wrote:
> Document Amazon's Annapurna Labs PCIe host bridge.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  .../devicetree/bindings/pci/pcie-al.txt       | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
> new file mode 100644
> index 000000000000..557a5089229d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> @@ -0,0 +1,46 @@
> +* Amazon Annapurna Labs PCIe host bridge
> +
> +Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
> +PCI core. It inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +Properties of the host controller node that differ from it are:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Value should contain
> +			- "amazon,al-alpine-v2-pcie" for alpine_v2
> +			- "amazon,al-alpine-v3-pcie" for alpine_v3
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Register ranges as listed in the reg-names property
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Must include the following entries
> +			- "config"	PCIe ECAM space
> +			- "controller"	AL proprietary registers
> +			- "dbi"		Designware PCIe registers
> +
> +Example:
> +
> +	pcie-external0: pcie@fb600000 {
> +		compatible = "amazon,al-alpine-v3-pcie";
> +		reg = <0x0 0xfb600000 0x0 0x00100000
> +		       0x0 0xfd800000 0x0 0x00010000
> +		       0x0 0xfd810000 0x0 0x00001000>;
> +		reg-names = "config", "controller", "dbi";
> +		bus-range = <0 255>;
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map-mask = <0x00 0 0 7>;
> +		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
> +		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..d200b16fa95c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12448,10 +12448,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
>  S:	Supported
>  F:	drivers/pci/controller/
>  
> -PCIE DRIVER FOR ANNAPURNA LABS
> +PCIE DRIVER FOR AMAZON ANNAPURNA LABS
>  M:	Jonathan Chocron <jonnyc@amazon.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pcie-al.txt
>  F:	drivers/pci/controller/dwc/pcie-al.c
>  
>  PCIE DRIVER FOR AMLOGIC MESON

I'm not sure if you need to split out the DT part of this patch, perhaps
others will comment.

But for both:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.17.1
> 
