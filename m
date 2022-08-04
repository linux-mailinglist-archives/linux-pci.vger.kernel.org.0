Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC656589FAC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHDRFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiHDRFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 13:05:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF621096;
        Thu,  4 Aug 2022 10:05:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so75498ooj.6;
        Thu, 04 Aug 2022 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LRKg0v+hrcSbPoYGLyRSx0AXbDp9cNywCGo7mnpmDks=;
        b=OBaqNDQcei+HgcAGQ4eZKg8pDNNCRE1Ok2DXed6QAU4y1VXIbGkSIb9+97K0IwvuLh
         qqruOdJKYCsAmXm6w4k3WFr4+8qMVkHHsOrRkUh/h8SefJoQE8jDnwQQopsjU9joQlh5
         Ks9Rv96LDUpY66VUaT5zS2VqEEbhoYlW2eO28r/UoyWVkyqv9/zVKRZ1Txu80YVSLjyv
         Wldj4ZszUmxO46SuM7pdFqHM7tBoYWx/eL3SfEuzurcsoBZcjxXrLnqEFUUe92BDcmLQ
         ORqU4dM7fWT88KYcS6qpnM7DqGYEm2gmEiZUzQB3C6JHe9F6kg+lMqmmFLUr2EI/HfQt
         9Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LRKg0v+hrcSbPoYGLyRSx0AXbDp9cNywCGo7mnpmDks=;
        b=s8zGu+9PJkeENRhcCFp4/UD0TZd1uhTW/VhHSucjz2P0OQhBoz34hQUvf++o/EOj4l
         B+r7vuFambMYYHCZe/wA6UINb7GUx+Xos9p0DWter8tJAMX1F4fhPgqih5i1ZPizhsAl
         vgWD0TmQHT8KgCTCrBVO1HcAjTflZ3cFmoS52F4MDySHjZJGpK01EnDnFP2ZpWS0cY81
         QQlotB7hlag4ecig4iiWA1IXpCEBXe2YqiDXsTEqH5joI3tbUqnol5n2ZA0EqctFepfO
         6lDGyJXthSSg8hlCPLR+8I+8avV7zfRujIzp0IUyoU4s71Wc4HP4oItkfWcY4jZqD685
         yigw==
X-Gm-Message-State: ACgBeo1Uj77vfDxiWV98jBWnpAI1STbFCXCpn+p2D3ajtwLDkKq66WYz
        iWqE469802r4KyCd08WX61hYtSB5eVZ4+SNazzw=
X-Google-Smtp-Source: AA6agR7lfWkv+z8R1U3wOdELLwy6A/puWcikTM2/IJvs7aWmmAFjDX7zeOXB7vHBCkmOTK/gCDxQpRmeFcOYJQJgP68=
X-Received: by 2002:a4a:eacc:0:b0:442:dbc4:be4 with SMTP id
 s12-20020a4aeacc000000b00442dbc40be4mr375511ooh.35.1659632716142; Thu, 04 Aug
 2022 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <4af7c132-1100-3d48-2311-e6be3bdf3629@gmail.com> <20220801221916.GA677562@bhelgaas>
In-Reply-To: <20220801221916.GA677562@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 4 Aug 2022 13:05:04 -0400
Message-ID: <CANCKTBspR9kc5WE72q8LYJrr0bAOp+xwqzPxEX0Kp4i0RynwFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Cyril Brulebois <kibi@debian.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 1, 2022 at 6:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 04:41:09PM -0700, Florian Fainelli wrote:
> > On 7/26/22 15:03, Bjorn Helgaas wrote:
> > > On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
> > >> ...
> > >> Jim Quinlan (7):
> > >>   PCI: brcmstb: Remove unnecessary forward declarations
> > >>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> > >>   PCI: brcmstb: Gate config space access on link status
> > >>   PCI: brcmstb: Add mechanism to turn on subdev regulators
> > >>   PCI: brcmstb: Add control of subdevice voltage regulators
> > >>   PCI: brcmstb: Do not turn off WOL regulators on suspend
> > >>   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
> > >>
> > >>  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
> > >>  1 file changed, 341 insertions(+), 135 deletions(-)
> > >
> > > I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
> > > proposal, not something set in stone.  But time is of the essence to
> > > figure out how we want to proceed.
> > >
> > > I changed a lot of stuff and it's likely I broke something in the
> > > process, so please take a look and test this out.  Here's an outline
> > > of what I changed:
> > >
> > >   - Moved the config access "link up" check earlier because it's not
> > >     related to the power regulator patches.
> > >
> > >   - Changed config access "link up" checks to use PCIE_ECAM_REG()
> > >     instead of hard-coding 0xfff masks.  The 32-bit accessors already
> > >     mask out the low two bits, so we don't need to do that here.
> > >
> > >   - Squashed pci_subdev_regulators_add_bus() directly into
> > >     brcm_pcie_add_bus() for readability.  Similarly for
> > >     pci_subdev_regulators_remove_bus().
> > >
> > >   - This makes a clear split between:
> > >
> > >     * A patch that adds get/enable of regulators, and starting the
> > >       link after enabling regulators, and
> > >
> > >     * A patch that disables/enables regulators for suspend/resume.
> > >
> > >   - Since we only support one set of subregulator info (for one Root
> > >     Port, and brcm_pcie_suspend_noirq() depends on this since it uses
> > >     the pcie->sr pointer), use pcie->sr always instead of
> > >     dev->driver_data.
> > >
> > >   - Squashed wakeup device checking into the suspend/resume patch so
> > >     there's not a time when suspend might turn off power to a wakeup
> > >     device.
> > >
> > >   - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
> > >     ends in "_map_bus()" like other drivers.  Also,
> > >     brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.
> >
> > Attached is the diff between Jim's and your branch just so it is easier to see what moved around.
> >
> > Initial testing on an ARCH_BRCMSTB system with PCIe appears to be good, we don't have any regulator on that board so the dummy ones get picked up which is expected. Same thing with a Raspberry Pi 4B system.
> >
> > I could unbind and bind again and there were no reference count leaks on the regulators, so this looks good to me.
> >
> > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> >
> > of course, we should have Jim's test results as well as Cyril's ideally to make sure there are no regressions on the CM4 board.
>
> Cyril, any chance you could test this to be sure it fixes the problem
> you reported?  This is in -next and hopefully headed for v5.20/v6.0
> soon.

Hello Bjorn,

Cyril sent me an email about a week ago saying that he probably
wouldn't have the bandwidth to test this.
I immediately ordered an overpriced CM4 via Ebay and it recently
arrived.  I'm happy to say that this
patchset tests successfully, w/ or w/o a device in the slot.

That being said, there is an old device, when paired with the CM4,
works with RPi Linux but not with upstream Linux.  It is unrelated
to this patchset; i.e. it fails w/ or w/o this patchset applied.  I
know the reason for this failure: the current driver
assumes clkreq# asserted, which is true for all STB boards.  I can add
a patch for this now or in the next release
cycle, your choice.

Regards,
Jim Quinlan
Broadcom STB


>
> I see that we failed to reference
> https://bugzilla.kernel.org/show_bug.cgi?id=215925 in the commit logs,
> but IIUC, this *should* fix that.
>
> Bjorn
