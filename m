Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB04E7DFBA5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKBUlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBUlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 16:41:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3419184
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 13:41:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D24EC433C7;
        Thu,  2 Nov 2023 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698957663;
        bh=SzMgNZJCc1gmvRxvFE+VfBdiVY5Rg+N026RjR705RvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TtkEHLcGuMmFxprVIj1nNfyGGKviBD8WWWeAeo+tW2zysw65PnhT6BKhoJxgoJt8n
         PIjbnxIKN2hgQ30L6AtVL6zv+gClUnOA+2E7zOkox8xl+wONzQxRFtzERhycmoYwXq
         XDS1Y1fXPN3GPCQF4K5exeRJbQFJfLPgymjaEYKfvzVv6aaNGkZkG1fKkuaLyYzWGX
         1TRWRsIabES7+Wqb0M8Jdt+WZxA1pGpWmhrtqhqOCS69m0Lv2lKTqEX9aEziPez3JR
         ESokik0j7memH8drrumErenI/Pi+DptyIcysEfXV2+ngSR2VSCS6I9LzOaqVj0N0vd
         6L85/1hLCOy4g==
Date:   Thu, 2 Nov 2023 15:41:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231102204101.GA132084@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f6fc377b36b23a3efca23af67ea9331c2bf3b6.camel@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng]

On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > > rootports' Hotplug configuration in BIOS. is_hotplug_bridge
> > > > > is set on each VMD rootport based on Hotplug capable bit in
> > > > > SltCap in probe.c.  Check is_hotplug_bridge and enable or
> > > > > disable native_pcie_hotplug based on that value.
> > > > > 
> > > > > Currently VMD driver copies ACPI settings or platform
> > > > > configurations for Hotplug, AER, DPC, PM, etc and enables or
> > > > > disables these features on VMD bridge which is not correct
> > > > > in case of Hotplug.
> > > > 
> > > > This needs some background about why it's correct to copy the
> > > > ACPI settings in the case of AER, DPC, PM, etc, but incorrect
> > > > for hotplug.
> > > > 
> > > > > Also during the Guest boot up, ACPI settings along with VMD
> > > > > UEFI driver are not present in Guest BIOS which results in
> > > > > assigning default values to Hotplug, AER, DPC, etc. As a
> > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > 
> > > > > This patch will make sure that Hotplug is enabled properly
> > > > > in Host as well as in VM.
> > > > 
> > > > Did we come to some consensus about how or whether _OSC for
> > > > the host bridge above the VMD device should apply to devices
> > > > in the separate domain below the VMD?
> > > 
> > > We are not able to come to any consensus. Someone suggested to
> > > copy either all _OSC flags or none. But logic behind that
> > > assumption is that the VMD is a bridge device which is not
> > > completely true. VMD is an endpoint device and it owns its
> > > domain.
> > 
> > Do you want to facilitate a discussion in the PCI firmware SIG
> > about this?  It seems like we may want a little text in the spec
> > about how to handle this situation so platforms and OSes have the
> > same expectations.
>
> The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
> author did not test in VM environment impact.
> We can resolve the issue easily by 
>
> #1 Revert the patch which means restoring VMD's original functionality
> and author provide better fix.
> 
> or
> 
> #2 Allow the current change to re-enable VMD hotplug inside VMD driver.
> 
> There is a significant impact for our customers hotplug use cases which
> forces us to apply the fix in out-of-box drivers for different OSs.

I agree 100% that there's a serious problem here and we need to fix
it, there's no argument there.

I guess you're saying it's obvious that an _OSC above VMD does not
apply to devices below VMD, and therefore, no PCI Firmware SIG
discussion or spec clarification is needed?

I'm more interested in a long-term maintainable solution than a quick
fix.  A maintainable solution requires an explanation for (a) why _OSC
above VMD doesn't apply below VMD, and (b) consistency across
everything negotiated by _OSC, not just hotplug.

Bjorn
