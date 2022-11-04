Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77524618D15
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKDABo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKDABn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 20:01:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7B22528;
        Thu,  3 Nov 2022 17:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04219CE29F3;
        Fri,  4 Nov 2022 00:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B6AC433C1;
        Fri,  4 Nov 2022 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667520099;
        bh=yg2N+8uMJ3tMRRsmbFw4hPcVzjt1czigplrA90YYgmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hncW7irTQjMcTD7hz54KhXHRrF8o75FGUE6eFKnRIACY1NuaCgBQmpugbpneqFFrC
         pvhqBPlvMzWDPnjW4ECW1AximHWNX5dLrlKOsrQF8qA8QBabPYOqLrAySpBFhFH9Rr
         JL4+IjkjKfFcs0+QhRlCmRYBw+snHx3hfRMDDDX+MPlZh4CmGA3AwcEKinpI7xDiJy
         B8ZqEi1kNzWEYQrOOHtgH0cWDAYO6Q0/j6SzZMgqqaHwywsxcpHTvEyA5dJIUf4EFd
         JMqyblFJbWT8FjRhwNrCC5WRtQcHOYroR30dr944ELR7xa7eHc+GW14nVOqk9bl6Hg
         AE2wAoplXyyrw==
Date:   Thu, 3 Nov 2022 19:01:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
Message-ID: <20221104000137.GA54487@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221103234111.ykexx733fty7g3da@pali>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 04, 2022 at 12:41:11AM +0100, Pali Rohár wrote:
> On Thursday 03 November 2022 18:13:35 Bjorn Helgaas wrote:
> > [+cc Pali]
> > 
> > On Sat, Sep 17, 2022 at 01:03:38PM +0100, Maciej W. Rozycki wrote:
> > > Attempt to handle cases such as with a downstream port of the ASMedia 
> > > ASM2824 PCIe switch where link training never completes and the link 
> > > continues switching between speeds indefinitely with the data link layer 
> > > never reaching the active state.
> > > 
> > > It has been observed with a downstream port of the ASMedia ASM2824 Gen 3 
> > > switch wired to the upstream port of the Pericom PI7C9X2G304 Gen 2 
> > > switch, using a Delock Riser Card PCI Express x1 > 2 x PCIe x1 device, 
> > > P/N 41433, wired to a SiFive HiFive Unmatched board.  In this setup the 
> > > switches are supposed to negotiate the link speed of preferably 5.0GT/s, 
> > > falling back to 2.5GT/s.
> > > 
> > > Instead the link continues oscillating between the two speeds, at the 
> > > rate of 34-35 times per second, with link training reported repeatedly 
> > > active ~84% of the time.  Forcibly limiting the target link speed to 
> > > 2.5GT/s with the upstream ASM2824 device however makes the two switches 
> > > communicate correctly.  Removing the speed restriction afterwards makes 
> > > the two devices switch to 5.0GT/s then.
> > > 
> > > Make use of these observations then and detect the inability to train 
> > > the link, by checking for the Data Link Layer Link Active status bit 
> > > being off while the Link Bandwidth Management Status indicating that 
> > > hardware has changed the link speed or width in an attempt to correct 
> > > unreliable link operation.
> > > 
> > > Restrict the speed to 2.5GT/s then with the Target Link Speed field, 
> > > request a retrain and wait 200ms for the data link to go up.  If this 
> > > turns out successful, then lift the restriction, letting the devices 
> > > negotiate a higher speed.
> > > 
> > > Also check for a 2.5GT/s speed restriction the firmware may have already 
> > > arranged and lift it too with ports of devices known to continue working 
> > > afterwards, currently the ASM2824 only, that already report their data 
> > > link being up.
> > 
> > This quirk is run at boot-time and resume-time.  What happens after a
> > Secondary Bus Reset, as is done by pci_reset_secondary_bus()?
> 
> Flipping SBR bit can be done on any PCI-to-PCI bridge device and in this
> topology there are following: PCIe Root Port, ASMedia PCIe Switch
> Upstream Port, ASMedia PCIe Switch Downstream Port, Pericom PCIe Switch
> Upstream Port, Pericom PCIe Switch Downstream Port.
> (Maciej, I hope that this is whole topology and there is not some other
> device of PCI-to-PCI bridge type in your setup; please correct me)
> 
> Bjorn, to make it clear, on which device you mean to issue secondary bus
> reset?

IIUC, the problem is observed on the link between the ASM2824
downstream port and the PI7C9X2G304 upstream port, so my question is
about asserting SBR on the ASM2824 downstream port.  I think that
should cause the link between ASM2824 and PI7C9X2G304 to go down and
back up.

Thanks for the question; I didn't notice before that this quirk
applies to *all* devices.  I'm a little queasy about trying to fix
problems we have not observed.  In this case, I think the hardware is
*supposed* to establish a link at the highest supported speed
automatically.

If we need to work around a hardware bug, that's fine, but I'm not
sure I want to blindly try to help things along.

> Because I would not be surprised if different things happen when issuing
> bus reset on different parts of that topology.
> 
> > PCIe r6.0, sec 7.5.1.3.13, says "setting Secondary Bus Reset triggers
> > a hot reset on the corresponding PCI Express Port".  Sec 4.2.7 says
> > LinkUp is 0 in the LTSSM Hot Reset state, and the Hot Reset state
> > leads to Detect, so it looks like this reset would cause the link to
> > go down and come back up.
> > 
> > Can you tell if that's what happens?  Does the link negotiation fail
> > then, too?
> > 
> > If it does fail then, I don't know how hard we need to work to fix it.
> > Maybe we just accept it?  Or maybe we need a "quirk-after-reset" phase
> > or something?
> > 
> > Bjorn
