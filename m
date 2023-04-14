Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB566E2B03
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNUOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNUOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 16:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823D5BA2;
        Fri, 14 Apr 2023 13:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9875C64A19;
        Fri, 14 Apr 2023 20:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF5C433EF;
        Fri, 14 Apr 2023 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681503255;
        bh=ihadHc7Q34AcePOx6aVt7nhJ+22BkwIb1WodWnGJFlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cDwWCSAbS5fybckM6+s1Wc9IbrWH2tkgGXp5avbemJ8B5kpNHOS9nUPlD3qzpYTAG
         MNcQuldty84KmoPI0Zl7zWpG3uQn89UQbD8g4UfdSOaZ5JqYo9Tqw1g8GUu9QdqGba
         PZ69ICfZjQY2Mxf9UDeH84rAkNEVWdrOUdT64POaihMaKOrI/0Wf5Y//G7ja0dkjy1
         pnam14qQQMK8IApALv5C7089I2P5ZBLdTiJjvJiHMKcaFHYEJrLETX2HzAZqRz1KNc
         HlAP8cZKYTdWnEU+hEvpjDh9gYJXdmZHXj0yaRrse2F8j1D+N/4wHW2IQKkjf3kA3c
         +iF3TdxQa5pIQ==
Date:   Fri, 14 Apr 2023 15:14:13 -0500
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
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Message-ID: <20230414201413.GA215912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411165919.23955-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It'd be nice to mention the property names (maybe omit the "brcm,"
prefix if that helps) in the commit log so "git log --oneline" is more
useful:

  959e000f0463 ("dt-bindings: PCI: brcmstb: Add two optional props")
  ea372f45cfff ("dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators")
  504253e44a9d ("dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.")
  145790e55d82 ("dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs")
  5e8a7d26d935 ("dt-bindings: PCI: brcmstb: compatible is required")
  f435ce7ebf8c ("dt-bindings: PCI: brcmstb: add BCM4908 binding")

On Tue, Apr 11, 2023 at 12:59:16PM -0400, Jim Quinlan wrote:
> Regarding "brcm,enable-l1ss":
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
>   need (a) and (b), but does not know when to configure (c).  Further, the
>   HW may cause a CPU abort on boot if guesses wrong regarding the need for
>   (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
>   that (c) is desired.  Setting this property only makes sense when the
>   downstream device is L1SS-capable and the OS is configured to activate
>   this mode (e.g. policy==superpowersave).
> 
>   This property is already present in the Raspian version of Linux, but the
>   upstream driver implementaion that will follow adds more details and
>   discerns between (a) and (b).
> 
> Regarding "brcm,completion-timeout-us"
> 
>   Our HW will cause a CPU abort if the L1SS exit time is longer than the
>   PCIe transaction completion abort timeout.  We've been asked to make this
>   configurable, so we are introducing "brcm,completion-timeout-us".

Completion Timeout is a generic PCIe concept.  Do we want a generic
(non-brcm) name that would be documented elsewhere?  Rob?

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 7e15aae7d69e..f7fc2f6561bb 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,22 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  brcm,enable-l1ss:
> +    description: Indicates that PCIe L1SS power savings
> +      are desired, the downstream device is L1SS-capable, and the
> +      OS has been configured to enable this mode.  Note that when
> +      in this mode, this particular HW may not meet the requirement
> +      that requires CLKREQ# assertion to clock active to be
> +      within 400ns.

Maybe a pointer to the source of the 400ns requirement?

"requirement that requires" is a little redundant, maybe "... may not
meet the requirement that Refclk be valid within 400ns of CLKREQ#
assertion"?

(I don't actually know whether this refers to Refclk or if that would
be a true statement; this is just a possible sentence structure.)
