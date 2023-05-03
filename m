Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C826F6126
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 00:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjECWSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjECWSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 18:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A68A41;
        Wed,  3 May 2023 15:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E7B60FFC;
        Wed,  3 May 2023 22:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D36CC433EF;
        Wed,  3 May 2023 22:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683152285;
        bh=rdWzfBeBb0nIZaH1BRmuCF5QOp3kmicpuhtIZUkpC5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L1BOK6PKarBv7FN4ef3lK+PNVzXMLJhbQE9wxsb5ijQNh3R+X4izhN2Z+/ntlA1Md
         wD6rcQEO99v/1bCqGukJYfzgIucaekmUec1Te3wMdkZ8T8toIS8+/0DhB371ytQ2Z3
         ZPvdxfhNRoDbNdZkgvXEl0RnrJu8Ln5T+VRTLaZ2S9LM3H8Vu/QxP4oD6Yr0IoO+b8
         1LAcNrdcAR8JKK3jLuWuzByzC46TUvD0EKg+7sJsdm14B/wkj4V4TM8owhQ+aDLer9
         ROlJ5457EIGT4gQXCW8LNMAaPfC4Ig/TKRcLg1kokkoKySb+SkGUHn10Nf9xXIyEDJ
         FXRJ+xWGUmhaQ==
Date:   Wed, 3 May 2023 17:18:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: brcmstb:
 brcm,{enable-l1ss,completion-timeout-us} props
Message-ID: <20230503221803.GA798402@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwBCn822NBv1wjLcbd0=bHEfx9V3R_UcAcuMz1_etUjMg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 03, 2023 at 05:38:15PM -0400, Jim Quinlan wrote:
> On Wed, May 3, 2023 at 2:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 03, 2023 at 10:38:57AM -0400, Jim Quinlan wrote:
> > > On Sun, Apr 30, 2023 at 3:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> > > > > brcm,enable-l1ss (bool):
> > > > >
> > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > > > >   requires the driver probe() to deliberately place the HW one of three
> > > > >   CLKREQ# modes:
> > > > >
> > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > >
> > > > >   The HW+driver can tell the difference between downstream devices that
> > > > >   need (a) and (b), but does not know when to configure (c).  All devices
> > > > >   should work fine when the driver chooses (a) or (b), but (c) may be
> > > > >   desired to realize the extra power savings that L1SS offers.  So we
> > > > >   introduce the boolean "brcm,enable-l1ss" property to inform the driver
> > > > >   that (c) is desired.  Setting this property only makes sense when the
> > > > >   downstream device is L1SS-capable and the OS is configured to activate
> > > > >   this mode (e.g. policy==superpowersave).
> > > ...
> >
> > > > What bad things would happen if the driver always configured (c)?
> > >
> > > Well, our driver has traditionally only supported (b) and our
> > > existing boards have been designed with this in mind.  I would not
> > > want to switch modes w'o the user/customer/engineer opting-in to do
> > > so.  Further, the PCIe HW engineer told me defaulting to (c) was a
> > > bad idea and was "asking for trouble".  Note that the commit's
> > > comment has that warning about L1SS mode not meeting this 400ns
> > > spec, and I suspect that many of our existing designs have bumped
> > > into that.
> > >
> > > But to answer your question, I haven't found a scenario that did not
> > > work by setting mode (c).  That doesn't mean they are not out there.
> > >
> > > > Other platforms don't require this, and having to edit the DT
> > > > based on what PCIe device is plugged in seems wrong.  If brcmstb
> > > > does need it, that suggests a hardware defect.  If we need this to
> > > > work around a defect, that's OK, but we should acknowledge the
> > > > defect so we can stop using this for future hardware that doesn't
> > > > need it.
> > >
> > > All devices should work w/o the user having to change the DT.  Only
> > > if they desire L1SS must they add the "brcm,enable-l1ss" property.
> >
> > I thought the DT was supposed to describe properties of the
> > *hardware*, but this seems more like "use this untested clkreq
> > configuration," which maybe could be done via a module parameter?
>
> Electrically, it has been tested, but  specifically for L1SS capable
> devices.  What is untested AFAICT are platforms using this mode on
> non-L1SS capable devices.

Non-L1SS behavior is a subset of L1SS, so if you've tested with L1SS
enabled, I would think you'd be covered.

But I'm not a hardware engineer, so maybe there's some subtlety there.
The "asking for trouble" comment from your engineer is definitely
concerning, but I have no idea what's behind that.

And obviously even if we have "brcm,enable-l1ss", the user may decide
to disable L1SS administratively, so even if the Root Port and the
device both support L1SS, it may be never be enabled.

> WRT bootline param
> pci=[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<device>[:<subvendor>:<subdevice>]:
> this does not look compatible for vendor specific DT options like
> "brcm,enable-l1ss".  I observe that pci_dev_str_match_path() is a
> static function and I don't see a single option in pci.c  that is
> vendor specific.  FWIW, moving something like this to the bootline
> would not be popular with our customers; for some reason they really
> don't like changes to the bootline.

They prefer editing the DT?

I agree the "pci=B:D.F" stuff is a bit ugly.  Do you have multiple
slots such that you would have to apply this parameter to some but not
others?  I guess I was imagining a single-slot system where you
wouldn't need to identify the specific device because there *is* only
one.

Bjorn
