Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F71AFC6D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfIKMWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 08:22:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfIKMWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 08:22:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CAD91000;
        Wed, 11 Sep 2019 05:22:53 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78693F59C;
        Wed, 11 Sep 2019 05:22:52 -0700 (PDT)
Date:   Wed, 11 Sep 2019 13:22:50 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        devicetree@vger.kernel.org, repk@triplefau.lt, maz@kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: pci: amlogic,meson-pcie: Add G12A
 bindings
Message-ID: <20190911122250.GT9720@e119886-lin.cambridge.arm.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 08, 2019 at 01:42:53PM +0000, Neil Armstrong wrote:
> Add PCIE bindings for the Amlogic G12A SoC, the support is the same
> but the PHY is shared with USB3 to control the differential lines.
> 
> Thus this adds a phy phandle to control the PHY, and sets invalid
> MIPI clock as optional for G12A.

Perhaps reword to "Thus this adds a phy phandle to control the PHY,
and only requires a MIPI clock for AXG SoC Family".

Thanks,

Andrew Murray

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt   | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> index efa2c8b9b85a..84fdc422792e 100644
> --- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -9,13 +9,16 @@ Additional properties are described here:
>  
>  Required properties:
>  - compatible:
> -	should contain "amlogic,axg-pcie" to identify the core.
> +	should contain :
> +	- "amlogic,axg-pcie" for AXG SoC Family
> +	- "amlogic,g12a-pcie" for G12A SoC Family
> +	to identify the core.
>  - reg:
>  	should contain the configuration address space.
>  - reg-names: Must be
>  	- "elbi"	External local bus interface registers
>  	- "cfg"		Meson specific registers
> -	- "phy"		Meson PCIE PHY registers
> +	- "phy"		Meson PCIE PHY registers for AXG SoC Family
>  	- "config"	PCIe configuration space
>  - reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>  - clocks: Must contain an entry for each entry in clock-names.
> @@ -23,12 +26,13 @@ Required properties:
>  	- "pclk"       PCIe GEN 100M PLL clock
>  	- "port"       PCIe_x(A or B) RC clock gate
>  	- "general"    PCIe Phy clock
> -	- "mipi"       PCIe_x(A or B) 100M ref clock gate
> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate for AXG SoC Family
>  - resets: phandle to the reset lines.
>  - reset-names: must contain "phy" "port" and "apb"
> -       - "phy"         Share PHY reset
> +       - "phy"         Share PHY reset for AXG SoC Family
>         - "port"        Port A or B reset
>         - "apb"         Share APB reset
> +- phys: should contain a phandle to the shared phy for G12A SoC Family
>  - device_type:
>  	should be "pci". As specified in designware-pcie.txt
>  
> -- 
> 2.17.1
> 
