Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF98581CE3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 03:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiG0BBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 21:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiG0BBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 21:01:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B21ADA6;
        Tue, 26 Jul 2022 18:01:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so11979921otb.5;
        Tue, 26 Jul 2022 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gn4xx2ifAzxcQHGoHfrDi5Bg504WW4qTvnA+0yEtrvc=;
        b=IRERJkzBMT4myUzKDVBlehcanwUy5CTz5LhMJuahDJUwzHQQd7DltAZ6Kzm4/gdKSx
         si7brIhiRWFUCEa6hSVsbVm9VPZHRzbkCsbPXIXs7yidgOahH0+raO3f8PXK8f+f8MeK
         21svn8TxhIpy7GwD6OfyXT1lNpcImrXCsEp2qciNru3pLdGs7rsYLNEcaQQQyMm8KNlH
         30WZvmXdD/cpfJmmvZhmhhH3kwztmJX2p3C/DCxLSbAhr9twfvUuFKUWRMibzZyxPzE5
         k+j59VSGK4TJHAsxEtCeIFkra9XjLT/Qgfrucyrd+Ay/tbEFvaXLuASDqKd+KTBsDwrQ
         25wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gn4xx2ifAzxcQHGoHfrDi5Bg504WW4qTvnA+0yEtrvc=;
        b=nAGNxAjWnylY0bAKoxDzrIQlFA2BU7owh5JbfUTHuMFkZ9sK2oF9HOdwo5JJ5mnaTi
         4JvKhnLZmLzKgeFztXqtOV64L25D4O7iiMoVqmIscKazybd6/XPRhdpJuxKHh+c4mmen
         jBsV78teq6O1magRhroZy8tXVdEqDHVhEVhEfW/H4jIv3ipXmNdGKMY/YHLVN9IBI4G3
         Oo1EQuxrIsuwW93XvGkfR8FgI70eRXgormsb9n6YrZ3LVhQeItQ51+TYXoSJxePfJWor
         s/nOoV16N9V4NhsPgN7k7CLtU29RHVR64R9M79yotgkEOMk912r9kbGpi1KdTvKtmu+A
         MjUQ==
X-Gm-Message-State: AJIora9nqs1tljCzTMEErFBUS6x6v4yzAfNPTHohYA+EaNeWxWg0ojQN
        MiP3gI5gi2z/j0QVgn8ZUXVCeGZj/lJoYYqiw/YW+sZS
X-Google-Smtp-Source: AGRyM1ulgmt7T0TcsvMpxz+mwBSCOWGzlWBXaxO8R2gepjQXC15dFrzPZpENc/2eGRJbU8hc7DpTcpi92wgEeLfM5s8=
X-Received: by 2002:a9d:6f01:0:b0:61c:b224:e7c9 with SMTP id
 n1-20020a9d6f01000000b0061cb224e7c9mr7691565otq.245.1658883697748; Tue, 26
 Jul 2022 18:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220725151258.42574-1-jim2101024@gmail.com> <20220726220303.GA109624@bhelgaas>
In-Reply-To: <20220726220303.GA109624@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 26 Jul 2022 21:01:26 -0400
Message-ID: <CANCKTBt=Mt6i+PgBwXfBUUOfo+vpCKv2NK8xJtZFoe5sheyZ7A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
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

On Tue, Jul 26, 2022 at 6:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
> > ...
> > Jim Quinlan (7):
> >   PCI: brcmstb: Remove unnecessary forward declarations
> >   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> >   PCI: brcmstb: Gate config space access on link status
> >   PCI: brcmstb: Add mechanism to turn on subdev regulators
> >   PCI: brcmstb: Add control of subdevice voltage regulators
> >   PCI: brcmstb: Do not turn off WOL regulators on suspend
> >   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
> >
> >  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
> >  1 file changed, 341 insertions(+), 135 deletions(-)
>
> I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
> proposal, not something set in stone.  But time is of the essence to
> figure out how we want to proceed.
>
> I changed a lot of stuff and it's likely I broke something in the
> process, so please take a look and test this out.  Here's an outline
> of what I changed:
>
>   - Moved the config access "link up" check earlier because it's not
>     related to the power regulator patches.
>
>   - Changed config access "link up" checks to use PCIE_ECAM_REG()
>     instead of hard-coding 0xfff masks.  The 32-bit accessors already
>     mask out the low two bits, so we don't need to do that here.
>
>   - Squashed pci_subdev_regulators_add_bus() directly into
>     brcm_pcie_add_bus() for readability.  Similarly for
>     pci_subdev_regulators_remove_bus().
>
>   - This makes a clear split between:
>
>     * A patch that adds get/enable of regulators, and starting the
>       link after enabling regulators, and
>
>     * A patch that disables/enables regulators for suspend/resume.
>
>   - Since we only support one set of subregulator info (for one Root
>     Port, and brcm_pcie_suspend_noirq() depends on this since it uses
>     the pcie->sr pointer), use pcie->sr always instead of
>     dev->driver_data.
>
>   - Squashed wakeup device checking into the suspend/resume patch so
>     there's not a time when suspend might turn off power to a wakeup
>     device.
>
>   - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
>     ends in "_map_bus()" like other drivers.  Also,
>     brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.

Hi Bjorn,
Sorry, it seems that some of my future commits have somehow bled code
into the driver (e.g. "has_phy").
LGTM.

Thanks and regards,
Jim Quinlan
Broadcom STB

>
> Bjorn
