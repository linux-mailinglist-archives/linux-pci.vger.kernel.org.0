Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B287851DD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjHWHoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHWHoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E71E52;
        Wed, 23 Aug 2023 00:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1306D6511C;
        Wed, 23 Aug 2023 07:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABBDC433C7;
        Wed, 23 Aug 2023 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692776633;
        bh=oK3yV228DJKbwbTXFb4RHff/R+/hOvYP/LBJ/ZoSh30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAzSuLjKrRLBN4VfR9xeAelF/xpKdHk+wzqKwaO/hba0tM4UzeZkHmiHxLx6D0gQL
         /DICzsBbMFRC16rjQw+IOXs5Fu3Mxcbw/6k0xFX6fVTqimBOlQH8ioTTbhWPorP5eF
         HVJo5EZc3Pc7m6l8r8t5X8F0q2XObe7kWmblm0WiIVKhJbDvCWhG+uWr9YaTvL65N9
         cEByENw8+lfaSkDzJPhJTH5ffX4yFI6ap7iqgKvtKX7pCFU1I94cjn4KQGPeQEKpOO
         JxhimQjOmUoz1vBwWdHVMRtkYew6NlkoTQvs/PZBX7OmGZslAoSNA2Gb66GN+DLLJp
         XbREhkVVlIc9w==
Date:   Wed, 23 Aug 2023 13:13:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss
 property
Message-ID: <20230823074330.GF3737@thinkpad>
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508220126.16241-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
> This commit adds the boolean "brcm,enable-l1ss" property:
> 
>   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
>   requires the driver probe() to deliberately place the HW one of three
>   CLKREQ# modes:
> 
>   (a) CLKREQ# driven by the RC unconditionally
>   (b) CLKREQ# driven by the EP for ASPM L0s, L1
>   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> 
>   The HW+driver can tell the difference between downstream devices that
>   need (a) and (b), but does not know when to configure (c).  All devices
>   should work fine when the driver chooses (a) or (b), but (c) may be
>   desired to realize the extra power savings that L1SS offers.  So we
>   introduce the boolean "brcm,enable-l1ss" property to inform the driver
>   that (c) is desired.  Setting this property only makes sense when the
>   downstream device is L1SS-capable and the OS is configured to activate
>   this mode (e.g. policy==powersupersave).
> 
>   This property is already present in the Raspian version of Linux, but the
>   upstream driver implementation that follows adds more details and
>   discerns between (a) and (b).
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 7e15aae7d69e..8b61c2179608 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,15 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  brcm,enable-l1ss:
> +    description: Indicates that PCIe L1SS power savings
> +      are desired, the downstream device is L1SS-capable, and the
> +      OS has been configured to enable this mode.  For boards
> +      using a mini-card connector, this mode may not meet the
> +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> +      of the PCI Express Mini CEM 2.0 specification.

As Lorenzo said, this property doesn't belong in DT. DT is supposed to specify
the hardware capability and not system/OS behavior. If this flag specifies
whether the PCIe controller supports L1SS or not, then it is fine but apparantly
this specifies that all downstream devices are L1SS capable which you cannot
guarantee unless you poke into their LNKCAP during runtime.

You should handle this in the driver itself.

- Mani

> +    type: boolean
> +
>    brcm,scb-sizes:
>      description: u64 giving the 64bit PCIe memory
>        viewport size of a memory controller.  There may be up to
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
