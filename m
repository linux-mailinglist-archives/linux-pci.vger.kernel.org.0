Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAE6F5D8C
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjECSHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjECSHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 14:07:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BEA26A0;
        Wed,  3 May 2023 11:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E174861726;
        Wed,  3 May 2023 18:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC653C433D2;
        Wed,  3 May 2023 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683137250;
        bh=UfXTXNSqPrId3batboymLS/dyfE4ksxDwUQtCtEMPs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jNx1NaXCjrW5RzAKonjN2fTLxnrKQkplY8SuSO5vn8DWS/VPVZ98AogCSH9zR9Etj
         gnGRF6jvP1TYEgGDtOnzF0suG0S8URZwDpiLOOv65w5VbRkYICdGIuglOIMkuxo5HN
         Y9jiNtg9kGiu/zYzsD3PSS9HCTwfn7GaVapZGzrWHbDf0OGnq52UcN7ss6xqs5KgPl
         0eAJqx05WLu7BqidvAV+TOLThrF6Y0dMMgjex6CA2O+pX9EF+X+c0AuVpdK28n3Ciy
         ScqvlD+7QAzsn5Um4j5uGsZc6EAxLh9a/cFzhUVQJ+K5iEOqa+cT6FOQ9VpBwc3sgG
         2OiL1GMhPUGbA==
Date:   Wed, 3 May 2023 13:07:28 -0500
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
Message-ID: <20230503180728.GA778510@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxO6y_y5En2Q7YHgDGh=v4a-8E1Qbr2VL0NpWNNJqRf-g@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 03, 2023 at 10:38:57AM -0400, Jim Quinlan wrote:
> On Sun, Apr 30, 2023 at 3:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> > > brcm,enable-l1ss (bool):
> > >
> > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > >   requires the driver probe() to deliberately place the HW one of three
> > >   CLKREQ# modes:
> > >
> > >   (a) CLKREQ# driven by the RC unconditionally
> > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > >
> > >   The HW+driver can tell the difference between downstream devices that
> > >   need (a) and (b), but does not know when to configure (c).  All devices
> > >   should work fine when the driver chooses (a) or (b), but (c) may be
> > >   desired to realize the extra power savings that L1SS offers.  So we
> > >   introduce the boolean "brcm,enable-l1ss" property to inform the driver
> > >   that (c) is desired.  Setting this property only makes sense when the
> > >   downstream device is L1SS-capable and the OS is configured to activate
> > >   this mode (e.g. policy==superpowersave).
> ...

> > What bad things would happen if the driver always configured (c)?
>
> Well, our driver has traditionally only supported (b) and our
> existing boards have been designed with this in mind.  I would not
> want to switch modes w'o the user/customer/engineer opting-in to do
> so.  Further, the PCIe HW engineer told me defaulting to (c) was a
> bad idea and was "asking for trouble".  Note that the commit's
> comment has that warning about L1SS mode not meeting this 400ns
> spec, and I suspect that many of our existing designs have bumped
> into that.
> 
> But to answer your question, I haven't found a scenario that did not
> work by setting mode (c).  That doesn't mean they are not out there.
> 
> > Other platforms don't require this, and having to edit the DT
> > based on what PCIe device is plugged in seems wrong.  If brcmstb
> > does need it, that suggests a hardware defect.  If we need this to
> > work around a defect, that's OK, but we should acknowledge the
> > defect so we can stop using this for future hardware that doesn't
> > need it.
> 
> All devices should work w/o the user having to change the DT.  Only
> if they desire L1SS must they add the "brcm,enable-l1ss" property.

I thought the DT was supposed to describe properties of the
*hardware*, but this seems more like "use this untested clkreq
configuration," which maybe could be done via a module parameter?

Whatever the mechanism, it looks like patch 2/5 makes brcmstb
advertise the appropriate ASPM and L1SS stuff in the PCIe and L1SS
Capabilities so the OS will do the right thing without any core
changes.

> > Maybe the name should be more specific to CLKREQ#, since this
> > doesn't actually *enable* L1SS; apparently it's just one of the
> > pieces needed to enable L1SS?
> 
> The other pieces are:  (a) policy == POWERSUPERSAVE and (b) an
> L1SS-capable device, which seem unrelated and are out of the scope
> of the driver.

Right.  Of course, if ASPM and L1SS support are advertised, the OS can
still choose whether to enable them, and that choice can change at
run-time.

> The RPi Raspian folks have been using "brcm,enable-l1ss"  for a
> while now and I would prefer to keep that name for compatibility.

BTW, the DT comment in the patch refers to PCIe Mini CEM .0 sec
3.2.5.2.5.  I think the correct section is 3.2.5.2.2 (at least in the
r2.1 spec).

There's also a footnote to the effect that T_CRLon is allowed to
exceed 400ns when LTR is supported and enabled.  L1.2 requires LTR, so
if L1.2 is the case where brcmstb exceeds 400ns, that might not be a
problem.

Bjorn
