Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5F535603
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbiEZWNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347713AbiEZWNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 18:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C18EAB8F;
        Thu, 26 May 2022 15:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C800061BEC;
        Thu, 26 May 2022 22:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A98C385B8;
        Thu, 26 May 2022 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653603182;
        bh=G3G/SsZeO3paxb3mcQ1C76lntf6UXDLo1kf3F/Jk2a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RC9i+nw8ucRIyQ8j4oLI28NzqCDoQMMVN8XGk38w1v6foK47UfqAQ3PtEPiMX4baW
         oLUwiymQfzKxhOpSs/f16++ohdWj41e3jgRUlpep2kN0/9AqCp2lIENRlSLLmWGqOQ
         vmj+Z+gMdpDmTbGXV87XJD8NC4lD2cCS0aai+B5d5XoarGpFRwsGTlMxEbcRpjz9VU
         rkzLtLiPCg0myBkDtIm0L07Mo6YJQCuUxCdOnQTPhNyDc9MoByseYLYEJkklYq11/O
         PoAvsxaves5PIh+cJD4yxKcK4VWrbYHtG+C59rCjzP3MW/QPYWKiAYfZUFxTQlbgal
         +g0/vCpgqXcfw==
Date:   Thu, 26 May 2022 17:12:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
Message-ID: <20220526221258.GA409855@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11980172.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If one of the PCIe root ports on Elo i2 is put into D3cold and then
> back into D0, the downstream device becomes permanently inaccessible,
> so add a bridge D3 DMI quirk for that system.
> 
> This was exposed by commit 14858dcc3b35 ("PCI: Use
> pci_update_current_state() in pci_enable_device_flags()"), but before
> that commit the root port in question had never been put into D3cold
> for real due to a mismatch between its power state retrieved from the
> PCI_PM_CTRL register (which was accessible even though the platform
> firmware indicated that the port was in D3cold) and the state of an
> ACPI power resource involved in its power management.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> Reported-by: Stefan Gottwald <gottwald@igel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
>  			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>  			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
>  		},
> +		/*
> +		 * Downstream device is not accessible after putting a root port
> +		 * into D3cold and back into D0 on Elo i2.
> +		 */
> +		.ident = "Elo i2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> +		},
>  	},

This has already made it to Linus' and some stable trees, but I think
we need the following touchup.  I plan to send it right after my v5.19
pull request.

commit a99f6bb133df ("PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu May 26 16:52:23 2022 -0500

    PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299
    
    92597f97a40b ("PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold") omitted
    braces around the new Elo i2 entry, so it overwrote the existing Gigabyte
    X299 entry.
    
    Found by:
    
      $ make W=1 drivers/pci/pci.o
        CC      drivers/pci/pci.o
      drivers/pci/pci.c:2974:12: error: initialized field overwritten [-Werror=override-init]
       2974 |   .ident = "Elo i2",
            |            ^~~~~~~~
    
    Fixes: 92597f97a40b ("PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold")
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org  # v5.15+

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d25122fbe98a..5b400a742621 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2920,6 +2920,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
 			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
 		},
+	},
+	{
 		/*
 		 * Downstream device is not accessible after putting a root port
 		 * into D3cold and back into D0 on Elo i2.
