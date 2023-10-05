Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314C7BA963
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjJESrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjJESre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:47:34 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FF93
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:47:32 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id AA509100E417B;
        Thu,  5 Oct 2023 20:47:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6F3173E7BF7; Thu,  5 Oct 2023 20:47:30 +0200 (CEST)
Date:   Thu, 5 Oct 2023 20:47:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231005184730.GA11020@wunner.de>
References: <20231004144959.158840-1-mario.limonciello@amd.com>
 <20231005181440.GA783423@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005181440.GA783423@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 01:14:40PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 04, 2023 at 09:49:59AM -0500, Mario Limonciello wrote:
> > Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> > suspend.  This occurs because on some AMD platforms, even though the Root
> > Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> > messages and generate wakeup interrupts from those states when amd-pmc has
> > put the platform in a hardware sleep state.
> > 
> > Iain reported this on an AMD Rembrandt platform, but it also affects
> > Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
> > generates the PME. To avoid this issue, disable D3 for the root port
> > associated with USB4 controllers at suspend time.
> > 
> > Restore D3 support at resume so that it can be used by runtime suspend.
> > The amd-pmc driver doesn't put the platform in a hardware sleep state for
> > runtime suspend, so PMEs work as advertised.
> > 
> > Cc: stable@vger.kernel.org
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Applied to pci/pm for v6.7, thanks for all your patience!

One belated thought I have on this is that it might be a better fit in
arch/x86/pci/fixups.c rather than drivers/pci/quirks.c.

The latter contains quirks for cards which could appear in any machine,
regardless of the arch.  But this seems to be specific to x86 machines.
I understand these xhci controllers are built into the SoC.

We've had complaints in the past from developers working with
space-constrained Mips routers that the generic quirks in
drivers/pci/quirks.c occupy too much memory:

https://lore.kernel.org/all/1482306784-29224-1-git-send-email-john@phrozen.org/

To cater to their needs, we need to keep in mind that arch-specific
quirks are kept outside of drivers/pci/quirks.c.

I apologize that this didn't occur to me earlier.

Thanks,

Lukas
