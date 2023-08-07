Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2001771B48
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHGHOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjHGHOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6E10F4
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 00:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D263B6159A
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A02C433C7;
        Mon,  7 Aug 2023 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691392442;
        bh=Nkih08d8mXOLXk5m3cApOB5T5DviJlG32aAEedWiqPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r//xTzncgboEfJ0+grDoleycE1TS6km2VahnD+jrVp7FofgU4WOt/fxjepWMM/zjU
         fnd+oQ1J0eusofaFSPq2qT3qh6YpMyvkJV7qN+Y+N1AiHaw2a3SJVXGtlTVx1kHSnc
         NjXs8+AuhcE/Rac7gxnDDUpv29iR1vKtypXHve1V0JyzoDVS2GPAq6dEtFBb+dhDNS
         27ZISC8xec3Kha8mZ/T5D4+W05pNULC6aybWNhSY5n2JudWa1b8jkKEl+ErSAxbZOT
         9i0LfxdGyVueTcxC6JxjP0bP7sBsR7pfDEi6ngPFKig11YbAMaKMh57b22xOaASDEX
         e+z0q3Lv70NMw==
Received: by pali.im (Postfix)
        id F3922820; Mon,  7 Aug 2023 09:13:58 +0200 (CEST)
Date:   Mon, 7 Aug 2023 09:13:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Cyril Brulebois <kibi@debian.org>
Subject: Re: [PATCH] PCI: brcmstb: Avoid downstream access during link
 training
Message-ID: <20230807071358.gaghhtoppj2w6ynx@pali>
References: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
 <20230806214338.7ylsi6aj6medp3us@pali>
 <39e96dd0-da7f-078e-d41d-fd437898744f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39e96dd0-da7f-078e-d41d-fd437898744f@broadcom.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 06 August 2023 19:48:59 Florian Fainelli wrote:
> On 8/6/2023 2:43 PM, Pali Rohár wrote:
> > On Sunday 06 August 2023 06:44:50 Lukas Wunner wrote:
> > > The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
> > > Interrupt
> > 
> > This is little incorrect wording. PCIe controller cannot send Async
> > SError, this is ARMv8 specific thing. In this case PCIe controller is
> > connected to ARM core via AXI bus and on PCIe transaction timeout it
> > sends AXI Slave Error, which then ARMv8 core reports to kernel as Async
> > SError interrupt.
> 
> That is indeed a better way to explain the issue. FWIW, on BCM2711 the PCIe
> core connects via SCB and then AXI towards the ARMv8 CPU, does not change a
> thing about your paragraph.

Ok, it is better describe the issue correctly.

> > 
> > The proper fix is to configure PCIe controller to never send AXI Slave
> > Error and neither AXI Decode Error (to prevent SErrors at all). For
> > example Synopsys PCIe controllers have proprietary hidden configuration
> > bits for enabling/disabling this AXI error reporting behavior.
> 
> That does not exist with the version of the block present in BCM2711
> unfortunately.

I was expecting such answer. I think that we have been discussing this
issue privately more months ago.

> > 
> > Or second option is to access affected memory from the ARMv8 core via
> > synchronous operations and map memory as nGnRnE. Then ARMv8 core reports
> > AXI Slave Error as Synchronous Abort Exception which you can catch,
> > examine that was caused on PCIe memory region and fabricate all-ones
> > response. But the second option is not available for some licensed ARMv8
> > Cortex cores (e.g. A53) as they do not implement nE (non Early Write
> > Acknowledgement) memory mapping correctly.
> 
> BCM2711 uses Cortex-A72 do these cores still not implement nE correctly? Do
> you have a reference backing up that claim (not disputing it, just curious).

I remember that I read this in Cortex-A53 documentation. Let me find it.

It is here:
ARM Cortex-A53 MPCore Processor Technical Reference Manual r0p3 - Support for v8 memory types:
https://developer.arm.com/documentation/ddi0500/e/level-1-memory-system/support-for-v8-memory-types

"nGnRnE - Treated the same as nGnRE inside a Cortex-A53 processor"

So really, disabling Early-acknowledge has no effect on A53.

> > 
> > The patch below does not fix the issue at all, instead it opens a new
> > race condition that if link state is changed _after_ the check and
> > _before_ accessing config space.
> 
> Fair enough, but in the situation you describe there is not much that can be
> done anyway so we might as well deal with a narrowed window?

Unless there is hidden/proprietary/undocumented bits for PCIe controller
to disable generating AXI errors, or ability to use only synchronous
access to affected memory from ARM core (e.g. by nE) there is really not
much what can be done here. I can just say that this is badly designed HW.

One more thing, if I remember correctly, ARMv8 specifies that Syndrome
register which delivers SError has some bits reserved for optional
feature - target AXI slave id which sent AXI Error. A53 does not
implement it and I highly doubt that other licensed ARM cores have them.
But maybe you could check A72. But even with that I'm really not sure if
it could be possible to catch SError, detect that it was sent by AXI
slave corresponding to PCIe controller and ignore it.

> Thanks for reviewing.
> -- 
> Florian
