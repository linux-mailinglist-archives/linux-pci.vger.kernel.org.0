Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A070A66A
	for <lists+linux-pci@lfdr.de>; Sat, 20 May 2023 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjETIbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 May 2023 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETIbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 May 2023 04:31:23 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43F19A
        for <linux-pci@vger.kernel.org>; Sat, 20 May 2023 01:31:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 06DCF100DA1A9;
        Sat, 20 May 2023 10:31:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CAAE96BE46; Sat, 20 May 2023 10:31:18 +0200 (CEST)
Date:   Sat, 20 May 2023 10:31:18 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230520083118.GA2713@wunner.de>
References: <ZGVAyd23kpbLDdpw@bhelgaas>
 <ZGfiR7ricXXo3JgO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGfiR7ricXXo3JgO@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 03:55:35PM -0500, Bjorn Helgaas wrote:
> On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 12, 2023 at 10:15:18AM +0800, Rongguang Wei wrote:
> > > From: Rongguang Wei <weirongguang@kylinos.cn>
> > > 
> > > pciehp's behavior is incorrect if the Attention Button is pressed
> > > on an unoccupied slot.
> > > 
> > > When a Presence Detect Changed event has occurred, the slot status
> > > in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
> 
> Was this supposed to say "BLINKINGOFF_STATE or ON_STATE"
> (not "OFF_STATE")?

Yes I think you're right.


> I propose the following commit log:
[...]
>   pciehp_queue_pushbutton_work() synthesizes a Presence Detect Changed
>   event, and pciehp_handle_presence_or_link_change() exits when it
>   finds the slot empty, leaving the slot in BLINKINGON_STATE with the
>   Power Indicator blinking.
> 
>   To fix the indefinitely blinking Power Indicator, change
>   pciehp_handle_presence_or_link_change() to put the empty slot back
>   in OFF_STATE and turn off the Power Indicator before exiting.

The indefinitely blinking Power Indicator is only one half of the problem.
The other half is that the next button press doesn't result in slot
bringup, even if the slot is occupied and the 5 second timeout has
elapsed.  Suggested wording, feel free to rephrase as you see fit:

  Because the slot was previously left in BLINKINGON_STATE, the next
  button press was interpreted as a "button cancel" event, even if the
  slot was occupied upon that next button press:  pciehp stopped blinking
  and did not perform another slot bringup attempt.

  By putting the slot in OFF_STATE, such user-unfriendly behavior is
  avoided:  Instead, the next button press will result in the slot
  starting to blink again and another bringup attempt after 5 seconds.

Thanks,

Lukas
