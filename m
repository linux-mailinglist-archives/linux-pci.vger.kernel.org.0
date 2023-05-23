Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33470E68D
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjEWUfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjEWUfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 16:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53366BF;
        Tue, 23 May 2023 13:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47956191D;
        Tue, 23 May 2023 20:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C48C4339B;
        Tue, 23 May 2023 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684874120;
        bh=WD3DNIqNipkAXxMXZFy+ceH8xcUnwhSbZvx+tfZCIqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sbs3xYlaJO1k9XwN45xPjRdavvzjZ0TMYdX/kS/wSacQ78T8GZanQ3K+ha9WqP6Zb
         c5thxqiYHQVCra5Bam6DfJOs2VwDpTlvw8d7QbnHXRGi5z03lEPKjQHZd6VyZvhA+4
         IWiVRoZrCk8xwqg1Itt3pynO7gCNyjkiqfBp6LdInBgoDBsJuA7Qlenzx8ouX5n+/M
         Y4o2V1A5r3biyvgckZHIsSnzi1KD44am8wqkr1opVFqvCTFg4yc8qhBrCJHgRV9isD
         w3qTDxyKWWEuYD13BXOoHuagzp+GjDJWOKSkR4WSen0f8GcZyT1NWgfH+2LrPrcA5s
         AJ+otgQ3sHwdw==
Date:   Tue, 23 May 2023 15:35:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Don't assume root ports from > 2015 are power
 manageable
Message-ID: <ZG0jhvzAZnfscSeC@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150827.89819-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Lukas, linux-pm]

On Wed, May 17, 2023 at 10:08:27AM -0500, Mario Limonciello wrote:
> Using an XHCI device to wakeup the system from s2idle fails when
> that XHCI device is connected to a USB-C port for an AMD USB4
> router.

Are XHCI, USB-C, and the AMD USB4 router just examples?  I assume the
same issue could happen with non-XHCI and non-AMD devices, too?

I assume the problem has something to do with PME_Support and some
device being put in a power state where it cannot generate or forward
PME messages?  I think the PCIe protocol details would be helpful
here.

> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
> suspend") all root port go into D3 during s2idle.
> When the root ports are in D3 over s2idle it's not possible for the
> platform firmware to properly identify the wakeup source.

I'm not sure what the critical device is here.  9d26d3a8f1b0 and the
current pci_bridge_d3_possible() are not specific to Root Ports.  The
PCIe protocol details would probably clear this up.

> Comparing registers between Linux and Windows 11 this behavior to put root
> ports into D3 at suspend is unique to Linux.  On an affected system
> Windows does not put the root ports into D3 over Modern Standby.
> 
> Windows doesn't put the root ports into D3 because root ports are not
> power manageable; they're missing _PRW and _S0W.

platform_pci_power_manageable() tests adev->flags.power_manageable,
which is set by acpi_bus_get_power_flags() when a device has _PS0 or
_PR0.

So I don't know what's relevant out of _PRW, _S0W, _PS0, _PR0, but
this sentence doesn't seem to match the code.

> Linux shouldn't be assuming they support D3 just because they're newer
> than 2015, the ports should also be deemed power manageable.
> Add an extra check for this to ensure D3 isn't selected for such machines.

Is this talking about D3hot or D3cold or both?  If we can make this
explicit, it will help me out.  It's probably obvious to power
experts, but I'm not one.

> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..3fe27aef09e6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (dmi_check_system(bridge_d3_blacklist))
>  			return false;
>  
> +		if (!platform_pci_power_manageable(bridge))
> +			return false;
> +
>  		/*
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
> -- 
> 2.34.1
> 
