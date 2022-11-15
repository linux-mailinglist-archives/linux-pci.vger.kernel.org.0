Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9C629D7B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 16:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKOPaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 10:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiKOP36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:29:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE4B1C0
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:29:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6D1C617F7
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 15:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B044C433D6;
        Tue, 15 Nov 2022 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668526166;
        bh=ZzniXUx+5Hjf0Jpf7ExNN9ggxwtveE9Z17ORWk8fJ8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hyi7p2FwgRPU2IgbW8inkF95EQ/ChhCx3ZMrS33XV4yLyY79ri6E2kmzWzypyaNrC
         SdUolIE2boX0P8cihHosDXK2rfgi0nz1pfBc1q9tTC/nYNeGq8FwVsL1uo4x2HTb0h
         T6uJfR2+KzL6+IVX70JIAHStysjQd/7PzuvG9Om56aw7WwpaqFXz/Buvc4+FKqbIUl
         jvsCMFk2gMGsoqWc9FYUFFQnm71mwseQeU/ns5qkkToq4upNEufSdvBR8u6TKksg6I
         CUtp8CV3Rb0K/HFutucK9ZW8gWE1MjCMTaZxOo1mfS3JP1bTNzbaRhw9bydiDPWtCI
         fhkZGslzYOLbQ==
Date:   Tue, 15 Nov 2022 09:29:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Albert Zhou <albert.zhou.50@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4 0/2] add hotplug depedency info
Message-ID: <20221115152924.GA993452@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115113857.35800-1-albert.zhou.50@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 10:38:55PM +1100, Albert Zhou wrote:
> v3->v4: Add Mika's review tag.
> 
> v2->v3: Dependency comment made more precise and technical, as suggested
> by Mika Westerberg.
> 
> v1->v2: I added comments that PCIe cards with USB4 or Thunderbolt also
> require the hotplug feature. I also added the "default y if USB4" line
> to the relevant config options, as suggested by Lukas Wunner.
> 
> Albert Zhou (2):
>   pci: hotplug: add dependency info to Kconfig
>   pci: pcie: add dependency info to Kconfig
> 
>  drivers/pci/hotplug/Kconfig | 4 +++-
>  drivers/pci/pcie/Kconfig    | 6 ++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

No need to repost just to add Reviewed-by or other tags.  b4 does that
automatically.

I squashed these since it's really a single logical change.

I updated to follow the style conventions for subject lines, add
info to subject line, and drop extraneous whitespace change.

Applied to pci/hotplug for v6.2, thanks!

commit e67ad9354a9b ("PCI: pciehp: Enable by default if USB4 enabled")
Author: Albert Zhou <albert.zhou.50@gmail.com>
Date:   Tue Nov 15 22:38:56 2022 +1100

    PCI: pciehp: Enable by default if USB4 enabled
    
    Thunderbolt/USB4 PCIe tunneling depends on native PCIe hotplug.  Enable
    pciehp by default if USB4 is enabled.
    
    [bhelgaas: squash, update subject, commit logs, tidy whitespace]
    Link: https://lore.kernel.org/r/20221115113857.35800-2-albert.zhou.50@gmail.com
    Link: https://lore.kernel.org/r/20221115113857.35800-3-albert.zhou.50@gmail.com
    Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..48113b210cf9 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -6,11 +6,14 @@
 menuconfig HOTPLUG_PCI
 	bool "Support for PCI Hotplug"
 	depends on PCI && SYSFS
+	default y if USB4
 	help
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
 	  powered up and running.
 
+	  Thunderbolt/USB4 PCIe tunneling depends on native PCIe hotplug.
+
 	  When in doubt, say N.
 
 if HOTPLUG_PCI
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..228652a59f27 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,6 +4,7 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express Port Bus support"
+	default y if USB4
 	help
 	  This enables PCI Express Port Bus support. Users can then enable
 	  support for Native Hot-Plug, Advanced Error Reporting, Power
@@ -15,9 +16,12 @@ config PCIEPORTBUS
 config HOTPLUG_PCI_PCIE
 	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
+	default y if USB4
 	help
-	  Say Y here if you have a motherboard that supports PCI Express Native
-	  Hotplug
+	  Say Y here if you have a motherboard that supports PCIe native
+	  hotplug.
+
+	  Thunderbolt/USB4 PCIe tunneling depends on native PCIe hotplug.
 
 	  When in doubt, say N.
 
