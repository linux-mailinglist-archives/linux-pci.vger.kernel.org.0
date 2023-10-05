Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6D7BA999
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJES6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJES6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:58:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D038190
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:58:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ABEC433C7;
        Thu,  5 Oct 2023 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696532298;
        bh=2ILI1jJ36alJU5unxpwoT1vnP0cd0qNJ6u/X5RrArhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dzF5hNUPxB5onmjiDIhLkAggmR2dqPM3Oc7/DtKJssZLGRwf9QePl+1oGC8orm5p3
         j8UnXcFD/Pjn3kEG1y5DQv4zf033bchy6DeUayrdC7v2kjsOFP7GAYI8dHQJwqlfGZ
         qEI1IGzVYjialD3GBS+NYZJpUV2GHdOqsoU9QEQpnuw67uy9KCZdmD56v1lt5SVLRY
         zG+aVajkIYT70Ob+baeYmARXIctP8b+8inrSaZTcz61Uh3T4T8jbwB2EE5vZjRW6x/
         V+mdTHWs4jlP4DBXiCxHtcSRWOgSgv9jE63/kwWhuzK0YMpdRsWLC/4wWz0jc2/oz5
         tYtgwtiThFB+g==
Date:   Thu, 5 Oct 2023 13:58:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231005185816.GA786641@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005184730.GA11020@wunner.de>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 08:47:30PM +0200, Lukas Wunner wrote:
> On Thu, Oct 05, 2023 at 01:14:40PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 04, 2023 at 09:49:59AM -0500, Mario Limonciello wrote:
> > > Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> > > suspend.  This occurs because on some AMD platforms, even though the Root
> > > Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> > > messages and generate wakeup interrupts from those states when amd-pmc has
> > > put the platform in a hardware sleep state.
> > > 
> > > Iain reported this on an AMD Rembrandt platform, but it also affects
> > > Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
> > > generates the PME. To avoid this issue, disable D3 for the root port
> > > associated with USB4 controllers at suspend time.
> > > 
> > > Restore D3 support at resume so that it can be used by runtime suspend.
> > > The amd-pmc driver doesn't put the platform in a hardware sleep state for
> > > runtime suspend, so PMEs work as advertised.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> > > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Applied to pci/pm for v6.7, thanks for all your patience!
> 
> One belated thought I have on this is that it might be a better fit in
> arch/x86/pci/fixups.c rather than drivers/pci/quirks.c.

Good point, I moved it there, thanks.  There are lots of other things
that should probably be moved, but no point in adding more.

Bjorn
