Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086F6DA0B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjDFTKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjDFTJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 15:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A771BC1;
        Thu,  6 Apr 2023 12:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F01364B62;
        Thu,  6 Apr 2023 19:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F4C433D2;
        Thu,  6 Apr 2023 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680808195;
        bh=rtqkcb59ixCCeS2OlmeTgAhzrvTyCZZpGEB8R8r/rVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bNEnr4aWDv/gAiOH3jT9VYhR2mgl5quTDbYFoX6dUu/GwA5ZebY6PYOdfw5w3UI5r
         3jTPBfEdBc8ABAai+MCb4V4xIya9Hjbw+ACebmDsLrUTYrY7rUPtR3BakxJO3OB3v9
         pl8DI8q7v5Hn/YhfgfBJjmtpBUNsTJ+lVR2R4EOERZ3ppp2xMUZYZKrH1jmp6Q/HY0
         u1yFrTcGV7gVxTWa+1SqWoQQI8KoV3sm1Fu3ZqC+7PuROAqn5I+JGQTkrtdViD4UVG
         3DBhUJxORVwPVkB7oYdUDsPNIZHNe3FO4HwSKoaVEr9++9q8XQCd/HijdCNvzuihTi
         TwdPyK4yq3+JQ==
Date:   Thu, 6 Apr 2023 14:09:53 -0500
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
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] PCI: brcmstb: Clkreq# accomodations of downstream
 device
Message-ID: <20230406190953.GA3723665@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406124625.41325-3-jim2101024@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 06, 2023 at 08:46:23AM -0400, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, may be
> set into three mutually exclusive modes:
> 
>   (a) No clkreq# expected or required, refclk is always available.
>   (b) Clkreq# is expected to be driven by downstream device when needed.
>   (c) Bidirectional clkreq# for L1SS capable devices.
> 
> Previously, only (b) was supported by the driver, as almost all STB boards
> operate in this mode.  But now there is interest in activating L1SS power
> savings from STB customers, and also interest in accomodating mode (a) for
> designs such as the RPi CM4 with IO board.
> 
> The HW can tell us when mode (a) mode is needed.  But there is no easy way
> to tell if L1SS mode is needed.  Unfortunately, getting this wrong causes a
> panic during boot time.  So we rely on the DT prop "brcm,enable-l1ss" to
> tell us when mode (c) is desired.  This property has already been in
> use by Raspian Linux, but this immplementation adds more details and
> discerns between (a) and (b) automatically.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

> +	 * We have "seen" clkreq# if it is asserted or has been in the past.
> +	 * Note that the CLKREQ_IN_MASK is 1 if clkreq# is asserted.

"CLKREQ#" to match PCIe spec and comments below.

> +	if (l1ss && IS_ENABLED(CONFIG_PCIEASPM)) {
> +		/*
> +		 * Note: This (l1ss) mode may not meet requirement for
> +		 * Endpoints that require CLKREQ# assertion to clock active
> +		 * within 400ns.
> +		 */
> +		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> +		dev_info(pcie->dev, "bi-dir clkreq; l1ss-capable devs only\n");
> +		dev_info(pcie->dev, "ASPM policy must be set to powersupersave\n");

Seems problematic since L1SS can be enabled/disabled at run-time:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-bus-pci?id=v6.2#n420

The simplistic answer is to advertise L1SS support if and only if you
can safely support it.

I don't know why this is an issue for this device but not others.  Is
it because there's some problem in the way the board is designed?  Or
(after skimming the bugzilla) maybe a problem with the plug-in cards?

Bjorn
