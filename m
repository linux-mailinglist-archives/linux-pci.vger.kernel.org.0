Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678956F2A6B
	for <lists+linux-pci@lfdr.de>; Sun, 30 Apr 2023 21:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjD3TK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Apr 2023 15:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3TKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Apr 2023 15:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95110E7;
        Sun, 30 Apr 2023 12:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2DC60C89;
        Sun, 30 Apr 2023 19:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BBAC433D2;
        Sun, 30 Apr 2023 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682881853;
        bh=CT/MNRGnhMb2nU4AJ1Xh90FST6Y4/rdNX1wK3f9sx+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ub5cfuHmtvKTM09w14SCYtvcGo/fpb1GnDtso0JSAqTkrFL8bJL+hZ2OElNITQlnN
         /iReeSMqkdciwER6LJoH7Eo7fHbkdieKLOnBRLvwZc6/2UEwauskSbZWo0hC7WV/uk
         G3cG1PyukoGV5qAJjMZl836kXLpFr3tQzJT2xHElIJ9ruze7BGR/M9AQdvJQQWIoiP
         Qa1RO/x5bPS0M/PAnX3ISfGmXzOPzk2gksevwGX2efK1j124UIYtP0qqtr6oPT0AxI
         /ZHJ0JWw/1D5lRK/Yy5qAmPOidB6cMpKHuCuL3ZaLhFPJmEaXARCwCSsC9y8293jGB
         +AJmJRw5ZTorA==
Date:   Sun, 30 Apr 2023 14:10:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: brcmstb:
 brcm,{enable-l1ss,completion-timeout-us} props
Message-ID: <20230430191051.GA515900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428223500.23337-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> This commit introduces two new properties:

Doing two things makes this a candidate for splitting into two
patches, as you've already done for the driver support.  They seem
incidentally related but not indivisible.

> brcm,enable-l1ss (bool):
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
>   this mode (e.g. policy==superpowersave).

Is this related to the existing generic "supports-clkreq" property?  I
guess not, because supports-clkreq looks like a description of CLKREQ
signal routing, while brcm,enable-l1ss looks like a description of
what kind of downstream device is present?

What bad things would happen if the driver always configured (c)?

Other platforms don't require this, and having to edit the DT based on
what PCIe device is plugged in seems wrong.  If brcmstb does need it,
that suggests a hardware defect.  If we need this to work around a
defect, that's OK, but we should acknowledge the defect so we can stop
using this for future hardware that doesn't need it.

Maybe the name should be more specific to CLKREQ#, since this doesn't
actually *enable* L1SS; apparently it's just one of the pieces needed
to enable L1SS?

>   This property is already present in the Raspian version of Linux, but the
>   upstream driver implementaion that follows adds more details and discerns
>   between (a) and (b).

s/implementaion/implementation/

> brcm,completion-timeout-us (u32):
> 
>   Our HW will cause a CPU abort on any PCI transaction completion abort
>   error.  It makes sense then to increase the timeout value for this type
>   of error in hopes that the response is merely delayed.  Further,
>   L1SS-capable devices may have a long L1SS exit time and may require a
>   custom timeout value: we've been asked by our customers to make this
>   configurable for just this reason.

I asked before whether this should be made generic and not
brcm-specific, since completion timeouts are generic PCIe things.  I
didn't see any discussion, but Rob reviewed this so I guess it's OK
as-is.

Is there something unique about brcm that requires this?  I think it's
common for PCIe Completion Timeouts to cause CPU aborts.

Surely other drivers need to configure the completion timeout, but
pcie-rcar-host.c and pcie-rcar-ep.c are the only ones I could find.
Maybe the brcmstb power-up values are just too small?  Does the
correct value need to be in DT, or could it just be built into the
driver?

This sounds like something dependent on the downstream device
connected, which again sounds hard for users to deal with.  How would
they know what to use here?

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 7e15aae7d69e..239cc95545bd 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,22 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  brcm,enable-l1ss:
> +    description: Indicates that PCIe L1SS power savings
> +      are desired, the downstream device is L1SS-capable, and the
> +      OS has been configured to enable this mode.  For boards
> +      using a mini-card connector, this mode may not meet the
> +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.5
> +      of the PCI Express Mini CEM 2.0 specification.
> +    type: boolean
> +
> +  brcm,completion-timeout-us:
> +    description: Number of microseconds before PCI transaction
> +      completion timeout abort is signalled.
> +    minimum: 16
> +    default: 1000000
> +    maximum: 19884107
> +
>    brcm,scb-sizes:
>      description: u64 giving the 64bit PCIe memory
>        viewport size of a memory controller.  There may be up to
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
