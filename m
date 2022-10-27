Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915361011B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiJ0TGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiJ0TGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 15:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACD61D5E;
        Thu, 27 Oct 2022 12:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBE46248A;
        Thu, 27 Oct 2022 19:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA046C433C1;
        Thu, 27 Oct 2022 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666897559;
        bh=gBTYxB2dsge0Tv0Ub58ghS3tJkrNS57BPTr8d72Kepo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a7zNy+4nxdk11E7davArldQrz2NkDtboKNWDaBkPpPjhxpXLg3uYGhG+2x8SGKXdf
         hsbHf5I7Gw1VgVO8ICSmHP8M1H/mBcIHK2F8yFi4d2W4lyCw4h6QQy9QO+Bk/3eueH
         EmjJgOjcO9L8eU+6jUkrAI0a35guQn3pyz3+r8zQKydaKHX3HzIAHGoXqu8pLJ5rgv
         7jD9m7yMyQkzBUDkpQyyqNlNMqx6h/ZS1hkxr7u1/rmPTs59YrN0RuaYVOYdgIlUfH
         NIKficWP/VCiRFIwQyUQpLpQ5Ve85+Q+BBWPYkS8bLMCc50kgCqbfBAI6QCXvqnRvf
         bzuitB9xISYeg==
Date:   Thu, 27 Oct 2022 14:05:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI: Add function for parsing
 'slot-power-limit-milliwatt' DT property
Message-ID: <20221027190557.GA833443@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408152750.GA306189@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 08, 2022 at 10:27:50AM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 25, 2022 at 10:38:26AM +0100, Pali Rohár wrote:
> > Add function of_pci_get_slot_power_limit(), which parses the
> > 'slot-power-limit-milliwatt' DT property, returning the value in
> > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> ...

> I think the spec is poorly worded here.  PCIe r6.0, sec 7.5.3.9, says:
> 
>   F0h   > 239 W and <= 250 W Slot Power Limit
> 
> I don't think it's meaningful for the spec to include a range here.
> The amount of power the slot can supply has a single maximum.  I
> suspect the *intent* of F0h/00b is that a device in the slot may
> consume up to 250W.
> 
> Your code above would mean that slot_power_limit_mw == 245,000 would
> cause the slot to advertise F0h/00b (250W), which seems wrong.
> 
> I think we should do something like this instead:
> 
>   scale = 0;
>   if (slot_power_limit_mw >= 600*1000) {
>     value = 0xFE;
>     slot_power_limit_mw = 600*1000;
>   } else if (slot_power_limit_mw >= 575*1000) {
>     value = 0xFD;
>     slot_power_limit_mw = 575*1000;
>   } ...
> 
> I raised an issue with the PCI SIG about this.

Just to close the loop here, a PCI SIG moderator agrees that F0h
should mean up to 250 W may be consumed.  My question as posed:

  7.5.3.9 defines alternate encodings for Slot Power Limit Values
  F0h-FEh when Slot Power Limit Scale is 00b. For example:

    F0h > 239 W and <= 250 W Slot Power Limit

  How should an Upstream Port interpret a Set_Slot_Power_Limit message
  with a payload of Scale 00b and Value F0h? Obviously the device may
  consume up to 239 W. Is it allowed to consume 240 W? 245 W? 250 W?

  If it is allowed to consume 250 W, I suggest that there is no reason
  to mention 239 W at all, and I suggest that the table be reworked so
  each encoding specifies a single limit, e.g.,

    F0h 250 W Slot Power Limit
    F1h 275 W Slot Power Limit

  This question arises because a Linux Device Tree may specify the
  amount of power a slot can supply. If the Device Tree says a slot
  can supply 245 W, how should Slot Power Limit Value/Scale be
  programmed? F0h/00b because 245 is between 239 and 250? Or EFh/00b
  (239 W) because F0h/00b actually means the slot must be able to
  supply 250 W and this slot can't do that?

PCI-SIG MODERATOR RESPONSE:

  A setting of F0h should be interpreted as allowing up to 250 W to be
  consumed. I agree that it makes sense to list the limits as:

  F0h 250 W Slot Power Limit
  F1h 275 W Slot Power Limit
  ...

  I will propose your suggested simplification to the Protocol Work Group.

For PCI-SIG members, this discussion is at
https://forum.pcisig.com/viewtopic.php?f=616&p=3914#p3914

Bjorn
