Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52A77C342
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 00:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjHNWHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjHNWHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 18:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B410D1;
        Mon, 14 Aug 2023 15:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055C36365C;
        Mon, 14 Aug 2023 22:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B356C433C8;
        Mon, 14 Aug 2023 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692050820;
        bh=48/dlFQB8VC8OlFHrcOt82tycaKer65es1u2ufvLD58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UWXDOGb+6lxSCIFUkhYUzHoFKnMvkonIzu77lc35b/bkXmfr9EvhQk9Oh42iH2jgJ
         PiU3eNOV7okYxO/Rq6denjg4BE0Nz/HZIoS1pKXdss3usGxi/O47grdSOtoEE0+uXx
         HgXIPSUKZNQRrJlWQXNUJufNA5oWJ5H8GRT0Xes7EXP6f5/LSmh1iDNvfqxwXcZGwy
         45X/mzQ0t6zZh5voiG9Nx0OMenYSgrnzNhGaPef8q+Tsdhvc44ZOftcs2efA+m4PIi
         qoinwz2o4NMCUGE0dByVp7G+R1FyPLZWEsIG/ceA5vB4JzhlS67qkRkLkvcusSJ+cr
         /88ZA4FibG6FA==
Date:   Mon, 14 Aug 2023 17:06:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] PCI: brcmstb: Set higher value for internal bus
 timeout
Message-ID: <20230814220658.GA193031@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzKB4vMkM4Qt6781GN-WwzCCdUYY3o=stgPSjQyJPr6vQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 14, 2023 at 03:30:07PM -0400, Jim Quinlan wrote:
> On Fri, Jul 28, 2023 at 12:15 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > On Thu, Jul 27, 2023, 10:44 PM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >> On Fri, Jun 23, 2023 at 10:40:56AM -0400, Jim Quinlan wrote:
> >> > During long periods of the PCIe RC HW being in an L1SS sleep state, there
> >> > may be a timeout on an internal bus access, even though there may not be
> >> > any PCIe access involved.  Such a timeout will cause a subsequent CPU
> >> > abort.
> >> >
> >> > So, when "brcm,enable-l1ss" is observed, we increase the timeout value to
> >> > four seconds instead of using its HW default.
> >> >
> >> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >> > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> >> > ---
> >> >  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
> >> >  1 file changed, 16 insertions(+)
> >> >
> >> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> >> > index d30636a725d7..fe0415a98c63 100644
> >> > --- a/drivers/pci/controller/pcie-brcmstb.c
> >> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> >> > @@ -1034,6 +1034,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >> >       return 0;
> >> >  }
> >> >
> >> > +/*
> >> > + * This extends the timeout period for an access to an internal bus.  This
> >> > + * access timeout may occur during L1SS sleep periods even without the
> >> > + * presence of a PCIe access.
> >> > + */
> >> > +static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
> >> > +{
> >> > +     /* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> >> > +     const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
> >>
> >> Nit: you could define an offset for the TIMEOUT register, if that makes
> >> it any cleaner, up to you.
> >>
> >> > +     u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
> >>
> >> It would be useful to describe why this has to be 4 seconds in case
> >> someone in the future will have to change it.
> >
> > IIRC our customer requested 2s and we doubled it.  Bjorn, can you
> > please add this comment or a paraphrase of it before applying --
> > I'm currently on vacation.
> 
> Is the above request okay with you?  What is the status of these
> commits -- will they be applied to pci-next in the near future?

The "brcm,enable-l1ss" DT property is either unnecessary or an
indication of a hardware defect in the controller.

Requiring the property is a terrible user experience, completely
antithetical to the PCI compatibility story, and per the conversation
at [1], there are no known problems that would occur if we ignored
"brcm,enable-l1ss" and always configured mode (c) ("Bidirectional
CLKREQ# for L1SS capable devices").

Even when configured as mode (c), L1SS is not *always* enabled.  It's
certainly not enabled before ASPM init, and users can always disable
L1SS whenever they desire via the sysfs interfaces or pcie_aspm=off,
so if there's some problem with running in mode (c) with L1SS
disabled, we're still likely to see it.

But if you want to require the DT property, I guess it's mainly an
issue for you and your customers.

So to answer your question, yes, I'm OK with this series.

Bjorn

[1] https://lore.kernel.org/r/20230428223500.23337-2-jim2101024@gmail.com

> >> > +     /* Each unit in timeout register is 1/216,000,000 seconds */
> >> > +     writel(216 * timeout_us, pcie->base + REG_OFFSET);
> >> > +}
> >> > +
> >> >  static void brcm_config_clkreq(struct brcm_pcie *pcie)
> >> >  {
> >> >       bool l1ss = of_property_read_bool(pcie->np, "brcm,enable-l1ss");
> >> > @@ -1059,6 +1074,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
> >> >                * of 400ns, as specified in 3.2.5.2.2 of the PCI Express
> >> >                * Mini CEM 2.0 specification.
> >> >                */
> >> > +             brcm_extend_rbus_timeout(pcie);
> >> >               clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> >> >               dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power savings");
> >> >       } else {
