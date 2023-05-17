Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17C707376
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEQVCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEQVCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 17:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755B123
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 14:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 988F264A23
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 21:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D176FC433EF;
        Wed, 17 May 2023 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684357323;
        bh=eotJq66CcMgwYH2kdzzNtbfkpYNplPetsFtg5OMN6UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SMtxNQUTtUKBF/nO/6Kf7LRIStyUUez8Bdq3dthKtighiulrP4If+/nR0oKynFG71
         hA1X0nzLW/qsNK5ThK/zHGhxkcz9Bn3yRlgRefXS/42MW2X2dcsXLlxwHggPGTj+L3
         BNJNl7tFAADjyqnyntra+xNloYMeDvp+r5q43uFoCXkS5FtacX65b5N4dyT0ADEc9v
         hS9b32du88vaK9FfSfp2Wnigi4ySVR1sn/X4JJY1hgLszfaZwsHB9oAToOv7NmFaFI
         HpbbBQWHC80F5CD+5shDszZTNHswKu6mx5rJXJlr/9WDybv37yLcmbTCfgRfFMF/4B
         Z8z7yIbrNgybw==
Date:   Wed, 17 May 2023 16:02:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     lukas@wunner.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <ZGVAyd23kpbLDdpw@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512021518.336460-1-clementwei90@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 10:15:18AM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> pciehp's behavior is incorrect if the Attention Button is pressed
> on an unoccupied slot.
> 
> When a Presence Detect Changed event has occurred, the slot status
> in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
> But if the slot status is in BLINKINGON_STATE and the slot is currently
> empty, the slot status was staying in BLINKINGON_STATE.

Thanks for the patch!

I don't quite follow the events here.  I think the current behavior is
this (tell me if I'm going wrong):

  - Slot is empty (OFF_STATE).

  - User presses Attention Button.  pciehp_handle_button_press() sets
    state to BLINKINGON_STATE, sets power indicator to blinking,
    schedules pciehp_queue_pushbutton_work() to turn on power after
    5 seconds.

  - When pciehp_queue_pushbutton_work() runs 5 seconds later, it
    synthesizes a PCI_EXP_SLTSTA_PDC event and wakes the IRQ thread.

  - The IRQ thread (pciehp_ist()) calls
    pciehp_handle_presence_or_link_change(), which does nothing since
    the slot is in BLINKINGON_STATE, the slot is empty, and the link
    is not active.

  - Slot incorrectly remains in BLINKINGON_STATE and power indicator
    remains blinking.

And this patch changes pciehp_handle_presence_or_link_change() so that
if the slot is empty, the link is not acive, and the slot is in
BLINKINGON_STATE, we put it in OFF_STATE, cancel the delayed work, and
turn off the power indicator.

After this patch, the user experience is this:

  - Slot is empty (OFF_STATE).

  - User presses Attention Button.

  - Power indicator blinks for 5 seconds.

  - Power indicator turns off.

which definitely seems better.

I'm curious why we want the 5 seconds of blinking power indicator at
all.  We can't really do anything in response to an Attention Button
on an empty slot, so could we just ignore it completely in
pciehp_handle_button_press()?

IIUC, this patch leads to messages like these, which are slightly
confusing because we say we're powering up the slot, then later decide
"oops, there's nothing here, never mind" (or, I guess the user could
push the button, *then* insert the card, and we would power it up,
which seems a little sketchy):

  [ 0.000] pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
  [ 0.001] pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering on due to button press
  [ 5.001] pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present

Is there a spec that covers the user experience of this case?  The
closest I could find are SHPC r1.0, sec 2.5, and PCIe r6.0, sec
6.7.1.5.  Both mention the 5-second abort interval with the power
indicator blinking, but they implicitly assume the slot is occupied.
Neither mentions the empty slot case.

> The message print like this:
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>     pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Button cancel
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Action canceled due to button press
>
> It cause the next Attention Button Pressed event become Button cancel
> and missing the Presence Detect Changed event with this button press
> though this button presses event is occurred after 5s.

It seems like the problem ("empty slot staying in BLINKINGON_STATE
forever after one Attention Button event") only requires one button
press.

If so, why do we talk about the *next* button press here?

> According to the Commit d331710ea78f ("PCI: pciehp: Become resilient
> to missed events"), if the slot is currently occupied, turn it on and
> if the slot is empty, it need to set in OFF_STATE rather than stay in
> current status when pciehp_handle_presence_or_link_change() bails out.
>
> Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
> Link: https://lore.kernel.org/linux-pci/20230403054619.19163-1-clementwei90@163.com/
> Link: https://lore.kernel.org/linux-pci/20230421025641.655991-1-clementwei90@163.com/
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..32baba1b7f13 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (present <= 0 && link_active <= 0) {
> +		if (ctrl->state == BLINKINGON_STATE) {
> +			ctrl->state = OFF_STATE;
> +			cancel_delayed_work(&ctrl->button_work);
> +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +					      INDICATOR_NOOP);
> +			ctrl_info(ctrl, "Slot(%s): Card not present\n",
> +				  slot_name(ctrl));
> +		}
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
