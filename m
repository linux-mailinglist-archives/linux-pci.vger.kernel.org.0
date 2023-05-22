Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728570CC02
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 23:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjEVVKk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEVVKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 17:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B489C
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 14:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8378161C31
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 21:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76F5C433EF;
        Mon, 22 May 2023 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684789837;
        bh=IqzASODcUsUhD8Za+88Zyx+svljArvnv9rfA7a6q4y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=itcArAjEuThG7PJYuiFD6wqsv9EJ+pK2C/isqXjlC6KuBBAaMEqiKPlqB3EB4a1jT
         JEgPowL+6EFBWPK9BYxFrrjMsEJ7O0rov6Nq3rAwC+29bL5Tk3Uf5d0qkJpbHSozyn
         VU4C/McOk85VMfrG3R5IrupNQquUC//LcfwFenmVDw0la+agQmfP6/It7aJoBRmwDL
         xtFCIIG1THILd9XWAfuWm8vIxFuxKA2Z3le9Dv+E70drmOnv8udlZ5KOyB3y0YB+6i
         AunyZpShMfTqV4mLUn+GtutISnQTWGq1cuYe1KMPyO5Sd7BSY2mm8QtPG87OObAHxO
         xih3bz05oJPsw==
Date:   Mon, 22 May 2023 16:10:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <ZGvaTOlY/Srh9Zip@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520083118.GA2713@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 20, 2023 at 10:31:18AM +0200, Lukas Wunner wrote:
> On Fri, May 19, 2023 at 03:55:35PM -0500, Bjorn Helgaas wrote:
> > On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 12, 2023 at 10:15:18AM +0800, Rongguang Wei wrote:
> > > > From: Rongguang Wei <weirongguang@kylinos.cn>
> > > > 
> > > > pciehp's behavior is incorrect if the Attention Button is pressed
> > > > on an unoccupied slot.
> > > > 
> > > > When a Presence Detect Changed event has occurred, the slot status
> > > > in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
> > 
> > Was this supposed to say "BLINKINGOFF_STATE or ON_STATE"
> > (not "OFF_STATE")?
> 
> Yes I think you're right.
> 
> > I propose the following commit log:
> [...]
> >   pciehp_queue_pushbutton_work() synthesizes a Presence Detect Changed
> >   event, and pciehp_handle_presence_or_link_change() exits when it
> >   finds the slot empty, leaving the slot in BLINKINGON_STATE with the
> >   Power Indicator blinking.
> > 
> >   To fix the indefinitely blinking Power Indicator, change
> >   pciehp_handle_presence_or_link_change() to put the empty slot back
> >   in OFF_STATE and turn off the Power Indicator before exiting.
> 
> The indefinitely blinking Power Indicator is only one half of the problem.
> The other half is that the next button press doesn't result in slot
> bringup, even if the slot is occupied and the 5 second timeout has
> elapsed.  

Thanks for your patience, I think I understand that.  Here's another
try:

  Previously, if a user pressed the Attention Button on an *empty* slot,
  pciehp logged the following messages and blinked the Power Indicator
  until a second button press:

    [0.000] pciehp: Attention button pressed
    [0.001] pciehp: Powering on due to button press
    [0.002] # Power Indicator starts blinking
    [5.002] # 5 second timeout should abort power-on sequence, but doesn't

    [8.000] # Power Indicator should be off, but is still blinking
    [9.000] # possible card insertion
    [9.000] pciehp: Attention button pressed
    [9.001] pciehp: Button cancel
    [9.002] pciehp: Action canceled due to button press

  The first button press incorrectly left the slot in BLINKINGON_STATE,
  so the second was interpreted as a "button cancel" event regardless of
  whether a card was present.

  If the slot is empty, turn off the Power Indicator and return from
  BLINKINGON_STATE to OFF_STATE after 5 seconds.  Putting the slot in
  OFF_STATE also means the second button press will correctly start a
  bringup attempt if the slot is occupied.

Maybe the above is enough for a commit log.  The notes below are my
attempt to work through in more detail:

IIUC, if the button is pressed twice on an empty slot, we end up back
in the "Empty slot, OFF" state (although the indicator blinks until
the second press, when it should stop after 5 seconds), and inserting
a card and pressing the button works as expected.

The problem is when the card is inserted between first and second
button presses, where the second press cancels the BLINKINGON when it
should *start* BLINKINGON.  A third press would power on the slot,
when it should go to BLINKINGOFF to power it off:

                    Slot        v6.4               Expected
                    --------    -----------        -----------
  Slot empty        Empty       OFF                OFF
  Button press 1    Empty       BLINKINGON         BLINKINGON
                                "Powering on"      "Powering on"
                                sched-work         sched-work
    +5s synth PDC   Empty       BLINKINGON         OFF
                                (a)                "Card not present"
  Insert card       Occupied    BLINKINGON         OFF
  Button press 2    Occupied    OFF                BLINKINGON
                                "Button cancel"    "Powering on"
                                                   sched-work
    +5s synth PDC   Occupied    (b, N/A)           POWERON
    Power control   Occupied    (b, N/A)           ON
  Button press 3    Occupied    BLINKINGON         BLINKINGOFF
                                "Powering on"      "Powering off"
                                sched-work         sched-work
    +5s synth PDC   Occupied    POWERON            POWEROFF
    Power control   Occupied    ON                 OFF

At (a), v6.4-rc1 will blink until another button press.  At (b), the
button press generates a "Button cancel" message and does not schedule
button_work.

And (b) is the situation you refer to where the second button press
doesn't bring the slot up when it should.  Right?

> Suggested wording, feel free to rephrase as you see fit:
> 
>   Because the slot was previously left in BLINKINGON_STATE, the next
>   button press was interpreted as a "button cancel" event, even if the
>   slot was occupied upon that next button press:  pciehp stopped blinking
>   and did not perform another slot bringup attempt.
> 
>   By putting the slot in OFF_STATE, such user-unfriendly behavior is
>   avoided:  Instead, the next button press will result in the slot
>   starting to blink again and another bringup attempt after 5 seconds.
> 
> Thanks,
> 
> Lukas
