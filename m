Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DCB1CA635
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHIjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 04:39:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:6264 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgEHIjq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 04:39:46 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 May 2020 17:39:44 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6E0DB60057;
        Fri,  8 May 2020 17:39:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 May 2020 17:39:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E913F1A12B9;
        Fri,  8 May 2020 17:39:43 +0900 (JST)
Received: from [10.213.29.153] (unknown [10.213.29.153])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1AB5F120136;
        Fri,  8 May 2020 17:39:43 +0900 (JST)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint
 controller description
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1584956454-8829-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1584956454-8829-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <9af851d6-03a2-1c4f-1749-4ebd2ce0465c@socionext.com>
Date:   Fri, 8 May 2020 17:39:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1584956454-8829-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/03/23 18:40, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs
> when configured in endpoint mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/pci/uniphier-pcie-ep.txt   | 53 ++++++++++++++++++++++
>   MAINTAINERS                                        |  2 +-
>   2 files changed, 54 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
> new file mode 100644
> index 0000000..072dc78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
> @@ -0,0 +1,53 @@
> +Socionext UniPhier PCIe endpoint controller bindings
> +
> +This describes the devicetree bindings for PCIe endpoint controller
> +implemented on Socionext UniPhier SoCs.
> +
> +UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
> +PCI core. It shares common functions with the PCIe DesignWare core driver
> +and inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +Required properties:
> +- compatible: Should be
> +	"socionext,uniphier-pro5-pcie-ep" for Pro5 SoC
> +- reg: Specifies offset and length of the register set for the device.
> +	According to the reg-names, appropriate register sets are required.
> +- reg-names: Must include the following entries:
> +	"dbi"        - controller configuration registers
> +	"dbi2"       - controller configuration registers for shadow
> +	"link"       - SoC-specific glue layer registers
> +	"addr_space" - PCIe configuration space
> +- clocks: A phandle to the clock gate for PCIe glue layer including
> +	the endpoint controller.
> +- clock-names: Should contain the following:
> +	"gio", "link" - for Pro5 SoC
> +- resets: A phandle to the reset line for PCIe glue layer including
> +	the endpoint controller.
> +- reset-names: Should contain the following:
> +	"gio", "link" - for Pro5 SoC
> +
> +Optional properties:
> +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> +	phys are required.
> +- phy-names: Must be "pcie-phy".
> +
> +Example:
> +
> +	pcie_ep: pcie-ep@66000000 {
> +		compatible = "socionext,uniphier-pro5-pcie-ep",
> +			     "snps,dw-pcie-ep";
> +		status = "disabled";
> +		reg-names = "dbi", "dbi2", "link", "addr_space";
> +		reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
> +		      <0x66010000 0x10000>, <0x67000000 0x400000>;
> +		clock-names = "gio", "link";
> +		clocks = <&sys_clk 12>, <&sys_clk 24>;
> +		reset-names = "gio", "link";
> +		clocks = <&sys_rst 12>, <&sys_rst 24>;

This example contains a mistake. I'll fix it.

> +		num-ib-windows = <16>;
> +		num-ob-windows = <16>;
> +		num-lanes = <4>;
> +		phy-names = "pcie-phy";
> +		phys = <&pcie_phy>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50e8b90..01a4631 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13151,7 +13151,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
>   M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/uniphier-pcie*.txt
>   F:	drivers/pci/controller/dwc/pcie-uniphier.c
>   
>   PCIE DRIVER FOR ST SPEAR13XX
> 

It is my chance to convert this to dt-schema.
I'll fix above and send dt-schema version in next.

Thank you,
  
---
Best Regards
Kunihiko Hayashi
