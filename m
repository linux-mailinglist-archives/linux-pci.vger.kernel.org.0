Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9659782C6E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjHUOrE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjHUOrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 10:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47754E9;
        Mon, 21 Aug 2023 07:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA49063AA9;
        Mon, 21 Aug 2023 14:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8AEC433C8;
        Mon, 21 Aug 2023 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629221;
        bh=zc0KGAFXOhLfTVM+2oz/ikmwe4dYCgqrTJs2/1nRo9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSWSB5nwW8WJBUUL3hCoZnO0XdV9E65WSkPKJlcqnKaL+XIe6D5zPP/Y4W3eVVFJ4
         KWx86NPv5BU7JoiwrOroXT9nBobxD2OtWBGe5EeHpewqE8M/D0o9NkxlQeOuXDBWt5
         xz5ET8aEEY5WgeFeDIqUhhxAVKNOuQ5Pn8GMOnJmkGFkPnHfEROtqcjGvoNNViPuT+
         z9X5MA1tOxw5xgDia7BL2NSNCZPUSOI1driFt+xcW8iJaHaWdDdPqu8xQFVWNMY0iH
         aTfgCNoANScN9T9cvK00P1amSma1MRm0Dp9hiVzOvvslRYmnieiwAOUMVn6A4e4fX1
         ElmLueD2IvHPw==
Date:   Mon, 21 Aug 2023 16:46:54 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss
 property
Message-ID: <ZON43rPGJGzjTTj/@lpieralisi>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623144100.34196-2-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
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
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
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

What does this mean ? I don't think DT properties are supposed
to carry information related to how the OS is configured.

Again - it depends on what DT should be used for, I am not claiming to
have any authority on that, just asking.

Thanks,
Lorenzo

> +      using a mini-card connector, this mode may not meet the
> +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> +      of the PCI Express Mini CEM 2.0 specification.
> +    type: boolean
> +
>    brcm,scb-sizes:
>      description: u64 giving the 64bit PCIe memory
>        viewport size of a memory controller.  There may be up to
> -- 
> 2.17.1
> 


