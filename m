Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5871A2F3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjFAPpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjFAPpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 11:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB3D196;
        Thu,  1 Jun 2023 08:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FFF646AC;
        Thu,  1 Jun 2023 15:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D45C433EF;
        Thu,  1 Jun 2023 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634287;
        bh=TlsHW3xGl9O05igYMwgPuflqBQiSb2C3fhWdkJ/oxX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SFhxXITCjK5fxIlcrNTolKholg0bYpuFYKhF6PLBPIvonugcDMVkUy3LCJ26nMyBV
         khnOe8Y3YfDXvGkPZ1OuU76+YJaL5egqFfnELXYw6mZTSDPy+aGT3Rro8wArTk9QY4
         MWoZi9uPUE3BFo2xcnTT2FikiuQjOJ79oXNSTO2jHKNqleRkVSM2DeRN9EIkrIclel
         DaVdVG1btL1M1AZ1H3/d6vfmx3RWeHw0VsoXvkQNYjPCN6NcboCnnzwElCZbhS+UJW
         q17+lm0d+JB9r2I7AIMX0c+o9mUKCrfh9zAj23MSKE1OphXOM/hHWHXysJK9DCeZrf
         hmW6eg7Gln49Q==
Date:   Thu, 1 Jun 2023 10:44:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <ZHi87bqTFQGKDhYO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601081156.zyymihd565fscuha@skbuf>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 01, 2023 at 11:11:56AM +0300, Vladimir Oltean wrote:
> On Wed, May 31, 2023 at 03:24:46PM -0500, Bjorn Helgaas wrote:
> > I guess I should have asked "what bad things happen without this patch
> > and without the DT 'disabled' status"?
> 
> Well, now that you put it this way, I do realize that things are not so
> ideal for me.
> 
> Our drivers for the functions of this device were already checking for
> of_device_is_available() during probe. So, reverting the core PCIe
> patch, they would still not register a network interface, which is good.
> 
> However (and this is the bad part), multiple functions of this PCIe
> device unfortunately share a common memory, which is not zeroized by
> hardware, and so, to avoid multi-bit ECC errors, it must be zeroized by
> software, using some memory space accesses from all functions that have
> access to that shared memory (every function zeroizes its piece of it).
> This, sadly, includes functions which have status = "disabled". See
> commit 3222b5b613db ("net: enetc: initialize RFS/RSS memories for unused
> ports too").
> 
> What we used to do was start probing a bit in enetc_pf_probe(), enable
> the memory space, zeroize our part of the shared memory, then check
> of_device_is_available() and finally, we disable the memory space again
> and exit probing with -ENODEV.
> 
> That is not possible anymore with the core patch, because the PCIe core
> will not probe our disabled functions at all anymore.

To make sure I understand you, I think you're saying that if Function
0 has DT status "disabled", 6fffbc7ae137 ("PCI: Honor firmware's
device disabled status") breaks things because we don't enumerate
Function 0 and the driver can't temporarily claim it to zero out its
piece of the shared memory.

With just 6fffbc7ae137, we don't enumerate Function 0, which means we
don't see that it's a multi-function device, so we don't enumerate
Functions 1, 2, etc, either.

With both 6fffbc7ae137 and your current patch, we would enumerate
Functions 1, 2, etc, but we still skip Function 0, so its piece of the
shared memory still doesn't get zeroed.

> The ENETC is not a hot-pluggable PCIe device. It uses Enhanced Allocation
> to essentially describe on-chip memory spaces, which are always present.
> So presumably, a different system-level solution to initialize those
> shared memories (U-Boot?) may be chosen, if implementing this workaround
> in Linux puts too much pressure on the PCIe core and the way in which it
> does things. Initially I didn't want to do this in prior boot stages
> because we only enable the RCEC in Linux, nothing is broken other than
> the spurious AER messages, and, you know.. the kernel may still run
> indefinitely on top of bootloaders which don't have the workaround applied.
> So working around it in Linux avoids one dependency.

If I understand correctly, something (bootloader or Linux) needs to do
something to Function 0 (e.g., clear memory).  Doing it in Linux would
minimize dependences on the bootloader, so that seems desirable to me.
That means Linux needs to enumerate Function 0 so it is visible to a
driver or possibly a quirk.

I think we could contemplate implementing 6fffbc7ae137 in a different
way.  Checking DT status at driver probe-time would probably work for
Loongson, but wouldn't quite solve the NXP problem because the driver
wouldn't be able to claim Function 0 even temporarily.

Is DT the only way to learn the NXP SERDES configuration?  I think it
would be much better if there were a way to programmatically learn it,
because then you wouldn't have to worry about syncing the DT with the
platform configuration, and it would decouple this from the Loongson
situation.

(If there were a way to actually discover the Loongson situation
instead of relying on DT, e.g., by keying off a Device ID or
something, that would be much better, too.  I assume we explored that,
but I don't remember the details.)

Bjorn
