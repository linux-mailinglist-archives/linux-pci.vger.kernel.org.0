Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485170A117
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjESU4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESU4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 16:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E610FC
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 13:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F1A615FF
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 20:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E6C433A0;
        Fri, 19 May 2023 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684529736;
        bh=ez27+f2rSZ21VegGHaYolNWqcFHqyJeRFHyFGRUhJtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eiHEoy9AmHp+0sRTyxeFouRUengDWzs4gxQC78Yrs3XbgYSNuL5/03pmT6KivPkiB
         zMx5+79fc5ugVLbXaQrpIZwBqlwuAnst6xCdLlhee0MJWsgEe05H6GxwvN5h3VwLwz
         fIelFyPvkIZSAByl8f8IrUtT9ZmJLQnJd0mCSmuPuUmX4yNlUfQudyDGevalZnnKLx
         5bE7Z1i9X2bgJ7C4WqWAQh0OW5mPvqnZNxHta9nBx3ffjNUzt0To4ELTA0DH2wcco6
         w+mtNhMu07jaOAlGS6hql/ju51TCjstGW2o2nK2CFJf4KXhlmfKiI9WOa4Mik8OpGe
         5eVEXYzOlANnw==
Date:   Fri, 19 May 2023 15:55:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     lukas@wunner.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <ZGfiR7ricXXo3JgO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGVAyd23kpbLDdpw@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> On Fri, May 12, 2023 at 10:15:18AM +0800, Rongguang Wei wrote:
> > From: Rongguang Wei <weirongguang@kylinos.cn>
> > 
> > pciehp's behavior is incorrect if the Attention Button is pressed
> > on an unoccupied slot.
> > 
> > When a Presence Detect Changed event has occurred, the slot status
> > in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.

Was this supposed to say "BLINKINGOFF_STATE or ON_STATE"
(not "OFF_STATE")?

BLINKINGOFF_STATE and ON_STATE are the only cases where
pciehp_handle_presence_or_link_change() calls pciehp_disable_slot() to
turn off slot power.

> > The message print like this:
> >     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
> >     pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
> >     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
> >     pcieport 0000:00:01.5: pciehp: Slot(0-5): Button cancel
> >     pcieport 0000:00:01.5: pciehp: Slot(0-5): Action canceled due to button press

I think the above messages are from *two* button presses, which
complicates the description unnecessarily, since IIUC we only need one
press to see the problem.

I propose the following commit log:

  If a PCIe hotplug slot has an Attention Button, the normal hot-add
  flow is:

    - Slot is empty and slot power is off
    - User inserts card in slot and presses Attention Button
    - OS blinks Power Indicator for 5 seconds
    - After 5 seconds, OS turns on Power Indicator, turns on slot
      power, and enumerates the device

  Previously, if a user pressed the Attention Button on an *empty*
  slot, pciehp logged the following messages and blinked the Power
  Indicator indefinitely:

    [0.000] pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    [0.001] pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering on due to button press

  An empty slot is in OFF_STATE.  When the Attention Button is pressed,
  pciehp_handle_button_press() puts the slot in BLINKINGON_STATE, sets
  the Power Indicator blinking, and schedules pciehp_queue_pushbutton_work()
  to run 5 seconds later.

  pciehp_queue_pushbutton_work() synthesizes a Presence Detect Changed
  event, and pciehp_handle_presence_or_link_change() exits when it
  finds the slot empty, leaving the slot in BLINKINGON_STATE with the
  Power Indicator blinking.

  To fix the indefinitely blinking Power Indicator, change
  pciehp_handle_presence_or_link_change() to put the empty slot back
  in OFF_STATE and turn off the Power Indicator before exiting.

  The Power Indicator will blink for 5 seconds before stopping, and
  messages like this will be logged:

    [0.000] pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
    [0.001] pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering on due to button press
    [5.001] pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present

Let me know if I got anything wrong above.

Bjorn

> > Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
> > Link: https://lore.kernel.org/linux-pci/20230403054619.19163-1-clementwei90@163.com/
> > Link: https://lore.kernel.org/linux-pci/20230421025641.655991-1-clementwei90@163.com/
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> > ---
> >  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> > index 529c34808440..32baba1b7f13 100644
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  	present = pciehp_card_present(ctrl);
> >  	link_active = pciehp_check_link_active(ctrl);
> >  	if (present <= 0 && link_active <= 0) {
> > +		if (ctrl->state == BLINKINGON_STATE) {
> > +			ctrl->state = OFF_STATE;
> > +			cancel_delayed_work(&ctrl->button_work);
> > +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> > +					      INDICATOR_NOOP);
> > +			ctrl_info(ctrl, "Slot(%s): Card not present\n",
> > +				  slot_name(ctrl));
> > +		}
> >  		mutex_unlock(&ctrl->state_lock);
> >  		return;
> >  	}
