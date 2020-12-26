Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786A2E2EC9
	for <lists+linux-pci@lfdr.de>; Sat, 26 Dec 2020 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgLZRr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Dec 2020 12:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgLZRr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Dec 2020 12:47:58 -0500
X-Greylist: delayed 2558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Dec 2020 09:47:18 PST
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458DEC061757
        for <linux-pci@vger.kernel.org>; Sat, 26 Dec 2020 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=e9X4my47ggN7suwunTpSwnYHYZG6SCZvR4V6WN+017g=; b=CxbloHr94lNKLG/iOhD/iGHn6I
        smSmnVzBae6jo8XRppjlhhEtvwKJOtJPi03E6lfinZwEUBw30LgDOy4lnoNTnGhSiBZJ2CZFrvt8N
        5wmLwboicp0P1I4EZhpA2wrjrc62LGqwcRovNt0Sgmu8xGFOsNG9yhAqAdM79VH+yUHRoQh4pGxE1
        6qPrgiBU/xVwxxKnu1Jzjl/OptYDmmLMG0vcv7bj1C6E7nid7gEUFIhGHfgFUB8YckUvfYu8Cawpj
        4h8FHY+rtaf6fXID81OU0iZ/L1VlJCrrdLgFi5WHu/tYCIyjsGbel9pXZDa0XGcDRT+WcaLyyoXbn
        QD7DHKAA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1ktCzY-0006e5-S8; Sat, 26 Dec 2020 18:04:32 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1ktCzY-0021De-2t; Sat, 26 Dec 2020 18:04:32 +0100
Date:   Sat, 26 Dec 2020 18:04:32 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com, ben.dooks@codethink.co.uk
Subject: Re: [PATCH v19 2/4] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Message-ID: <X+dtIPs70A5v17pj@aurel32.net>
References: <20201224094500.19149-1-daire.mcnamara@microchip.com>
 <20201224094500.19149-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224094500.19149-3-daire.mcnamara@microchip.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-12-24 09:44, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> new file mode 100644
> index 000000000000..5a56f07a5ceb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/microchip,pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PCIe Root Port Bridge Controller Device Tree Bindings
> +
> +maintainers:
> +  - Daire McNamara <daire.mcnamara@microchip.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: microchip,pcie-host-1.0 # PolarFire
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: apb
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: PCIe host controller
> +      - description: builtin MSI controller
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: pcie
> +      - const: msi
> +
> +  ranges:
> +    maxItems: 1
> +
> +  msi-controller:
> +    description: Identifies the node as an MSI controller.
> +
> +  msi-parent:
> +    description: MSI controller the device is capable of using.
> +
> +required:
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - msi-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            pcie0: pcie@2030000000 {
> +                    compatible = "microchip,pcie-host-1.0";
> +                    reg = <0x0 0x70000000 0x0 0x08000000>,
> +                          <0x0 0x43000000 0x0 0x00010000>;
> +                    reg-names = "cfg", "apb";
> +                    device_type = "pci";
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    #interrupt-cells = <1>;
> +                    interrupts = <119>;
> +                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +                    interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +                                    <0 0 0 2 &pcie_intc0 1>,
> +                                    <0 0 0 3 &pcie_intc0 2>,
> +                                    <0 0 0 4 &pcie_intc0 3>;
> +                    interrupt-parent = <&plic0>;
> +                    msi-parent = <&pcie0>;
> +                    msi-controller;
> +                    bus-range = <0x00 0x7f>;
> +                    ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
> +                    pcie_intc_0: interrupt-controller {

Very minor nitpick, the name here doesn't match the one in
interrupt-map, there is an extra '_'.

Otherwise I have tested this patch series on top of Atish's tree, and
it works fine with a NVME device.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
