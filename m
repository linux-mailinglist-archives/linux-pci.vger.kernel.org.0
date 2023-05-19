Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45778708FD0
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjESGWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 02:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 02:22:35 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783591A6
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 23:22:33 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 410C1280072AB;
        Fri, 19 May 2023 08:22:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3772C4E015; Fri, 19 May 2023 08:22:31 +0200 (CEST)
Date:   Fri, 19 May 2023 08:22:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230519062231.GA6413@wunner.de>
References: <20230518062557.GB13145@wunner.de>
 <ZGYHdbvZ8JJUFPMc@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGYHdbvZ8JJUFPMc@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023 at 06:09:41AM -0500, Bjorn Helgaas wrote:
> On Thu, May 18, 2023 at 08:25:57AM +0200, Lukas Wunner wrote:
> > On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> > > I'm curious why we want the 5 seconds of blinking power indicator at
> > > all.  We can't really do anything in response to an Attention Button
> > > on an empty slot, so could we just ignore it completely in
> > > pciehp_handle_button_press()?
> > 
> > That wouldn't cover the case where the slot is occupied when the
> > button is pressed, but the card is yanked out during the 5 second
> > blinking interval.
> 
> Obviously we can't ignore a button press when the slot is occupied,
> because that's part of the "insert card, press button to power it up"
> and "press button to power down card, remove card" flows.
> 
> I'm asking about ignoring it when the slot is empty, which would mean
> adding a check for card presence in pciehp_handle_button_press().  But
> maybe there's a reason why we can't do that there?

It would of course be possible to copy/paste the pciehp_card_present() +
pciehp_check_link_active() check from pciehp_handle_presence_or_link_change().

The only downside is that the symmetry between the ON_STATE / OFF_STATE
cases in pciehp_handle_button_press() could no longer be preserved.
(Because the additional check only applies to OFF_STATE.)  So it could
be argued that readability becomes a little worse and the logic of the
state machine slightly more difficult to follow.

Ultimately any engineering discipline boils down to balancing various
competing traits (such as simplicity of code versus usability) and
personally I would decide to continue allowing the "press button first,
insert card afterwards" usage model because it keeps the code lean.

Unfortunately back in the day the PCISIG decided to saddle PCIe hotplug
with numerous optional features which now complicate implementations.
Form factors implementing the Attention Button seem pretty rare,
as evidenced by the fact this glitch was discovered by Rongguang Wei
almost 5 years after the issue was introduced.  I think most modern
form factors just use surprise-removal instead (NVMe drives in data
centers specifically, and Thunderbolt).

The present commit is necessary anyway to deal with the "card is in slot
when button is pressed, but yanked within 5 seconds" case.  The additional
check in pciehp_handle_button_press() you're contemplating to avoid bringup
attempts if the card is not in the slot upon button press is optional.

Your call. :)

Thanks,

Lukas
