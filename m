Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411A67BA9A5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjJES7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJES7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:59:31 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7586E8
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:59:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id F3E1528046BF6;
        Thu,  5 Oct 2023 20:59:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D55CF50E337; Thu,  5 Oct 2023 20:59:26 +0200 (CEST)
Date:   Thu, 5 Oct 2023 20:59:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20231005185926.GA20935@wunner.de>
References: <20231004144959.158840-1-mario.limonciello@amd.com>
 <20231005181440.GA783423@bhelgaas>
 <20231005184730.GA11020@wunner.de>
 <6c02ad76-b205-40a3-9405-dd03e252414b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c02ad76-b205-40a3-9405-dd03e252414b@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 01:52:34PM -0500, Mario Limonciello wrote:
> On 10/5/2023 13:47, Lukas Wunner wrote:
> > One belated thought I have on this is that it might be a better fit in
> > arch/x86/pci/fixups.c rather than drivers/pci/quirks.c.
> > 
> > The latter contains quirks for cards which could appear in any machine,
> > regardless of the arch.  But this seems to be specific to x86 machines.
> > I understand these xhci controllers are built into the SoC.
> > 
> > We've had complaints in the past from developers working with
> > space-constrained Mips routers that the generic quirks in
> > drivers/pci/quirks.c occupy too much memory:
> > 
> > https://lore.kernel.org/all/1482306784-29224-1-git-send-email-john@phrozen.org/
> > 
> > To cater to their needs, we need to keep in mind that arch-specific
> > quirks are kept outside of drivers/pci/quirks.c.
> > 
> > I apologize that this didn't occur to me earlier.
> 
> This seems like a bigger problem than this quirk.
> On a 6.5.y checkout I have on hand:
> 
> $ cat drivers/pci/quirks.c  | grep "VENDOR_ID_INTEL\|VENDOR_ID_AMD" | wc -l
> 412
> 
> Maybe we should move it all as a later follow up?

It's not that simple.  Some of these are for discrete chips which
may appear in any machine of any arch (think GPUs, Ethernet chips,
USB controllers etc, you might see these attached to a Raspberry Pi
and whatnot).

Thanks,

Lukas
