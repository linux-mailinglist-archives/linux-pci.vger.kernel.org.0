Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D269469704
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhLFNdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 08:33:19 -0500
Received: from foss.arm.com ([217.140.110.172]:57506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243962AbhLFNdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 08:33:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 521C46D;
        Mon,  6 Dec 2021 05:29:50 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0ED3F73D;
        Mon,  6 Dec 2021 05:29:48 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:29:40 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211206132940.GA19176@lpieralisi>
References: <20211119220756.18628-1-jim2101024@gmail.com>
 <20211119220756.18628-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119220756.18628-4-jim2101024@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 05:07:50PM -0500, Jim Quinlan wrote:
> Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
> added to the Linux PCI subsystem that will allocate and turn on/off
> regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
> vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
> device.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)

Hi Rob,

is it Ok to pull this patch ? I would like to merge the series, please
let me know.

Thanks,
Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 22f2ef446f18..7113a7f726e7 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -159,5 +159,28 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    /* PCIe bridge */
> +                    pci@0,0 {
> +                            #address-cells = <3>;
> +                            #size-cells = <2>;
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            compatible = "pciclass,0604";
> +                            device_type = "pci";
> +                            vpcie3v3-supply = <&vreg7>;
> +                            ranges;
> +
> +                            /* PCIe endpoint */
> +                            pci-ep@0,0 {
> +                                    assigned-addresses =
> +                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> +                                    compatible = "pci14e4,1688";
> +                                    #address-cells = <3>;
> +                                    #size-cells = <2>;
> +
> +                                    ranges;
> +                            };
> +                    };
>              };
>      };
> -- 
> 2.17.1
> 
