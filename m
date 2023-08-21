Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051F7835DF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjHUWmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 18:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42711C;
        Mon, 21 Aug 2023 15:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D41860B61;
        Mon, 21 Aug 2023 22:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9A8C433C8;
        Mon, 21 Aug 2023 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692657730;
        bh=wnGPBph7Q+YS0lgZNbdSI4MH/lKrnH8xevzYsEDK9DY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F+iESIhKAuiC0AqtVgOkNdPVExHLcRC88dW2Tq0nf4rmxSin0vO5NMsvLMyqjvEMv
         Nducytwp7mnf5M8IqMoWaSla0kXQRfcCa8cTLR0dnZE2Qjcl4dNY6iy4jHt3GtqkZE
         8D/o7xdFLUdvGhAlXsyYD1SR18p8x4edIsWnRaa8+/z85KLldpWYhq4K+B6g2Eb6D6
         FQhOhMPy+FuU88VZ3UJ+2T46uj0OD1iEnu1HHhaayPtvPMRVq5Uxvz0vDblYLvX7tw
         bmKuKSb0q0PDZZMrLmOYaviaLISUND7l4gcntVqj1Hu07XERZ9o0QpxetKd6kyC8Qr
         zj3BTHdYy1TeQ==
Date:   Mon, 21 Aug 2023 17:42:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Message-ID: <20230821224207.GA369432@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818193932.27187-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 02:39:32PM -0500, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
> 
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3 and AMD's platform can't handle USB devices waking in this
> case.
> 
> This behavior is only reported on Linux. Comparing the behavior
> on Windows and Linux, Windows doesn't put the root ports into D3.
> 
> To fix the issue without regressing existing Intel systems,
> limit the >=2015 check to only apply to Intel PCIe ports.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> In v14 this series has been split into 3 parts.
>  part A: Immediate fix for AMD issue.
>  part B: LPS0 export improvements
>  part C: Long term solution for all vendors
> v13->v14:
>  * Reword the comment
>  * add tag
> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0c..bfdad2eb36d13 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return false;
>  
>  		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> -		 * to D3.
> +		 * Allow Intel PCIe ports from 2015 onward to go into D3 to
> +		 * achieve additional energy conservation on some platforms.
> +		 *
> +		 * This is only set for Intel PCIe ports as it causes problems
> +		 * on both AMD Rembrandt and Phoenix platforms where USB keyboards
> +		 * can not be used to wake the system from suspend.
>  		 */
> -		if (dmi_get_bios_year() >= 2015)
> +		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +		    dmi_get_bios_year() >= 2015)
>  			return true;

Hmm.  I'm really not a fan of checks like this that aren't connected
to an actual property of the platform.  The Intel Vendor ID tells us
nothing about what the actual problem is, which makes it really hard
to maintain in the future.  It's also very AMD- and Intel-centric,
when this code is ostensibly arch-agnostic, so this potentially
regresses ARM64, RISC-V, powerpc, etc.

It's bad enough that we check for 2015.  A BIOS security update to a
2014 platform will break things, even though the update has nothing to
do with D3.  We're stuck with that one, and it's old enough that maybe
it won't bite us any more, but I hate to add more.

The list of conditions in pci_bridge_d3_possible() is a pretty good
clue that we don't really know what we're doing, and all we can do is
find configurations that happen to work.  

I don't have any better suggestions, other than that this should be
described somehow via ACPI (and not in vendor-specific stuff like
PNP0D80).

Bjorn
