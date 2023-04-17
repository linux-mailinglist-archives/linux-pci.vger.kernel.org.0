Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4A6E4061
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDQHLa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 03:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQHL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 03:11:29 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C82D4D
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 00:11:27 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 743E8100D940D;
        Mon, 17 Apr 2023 09:11:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4767038EF2; Mon, 17 Apr 2023 09:11:25 +0200 (CEST)
Date:   Mon, 17 Apr 2023 09:11:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230417071125.GA4930@wunner.de>
References: <20230403054619.19163-1-clementwei90@163.com>
 <20230416151826.GA13954@wunner.de>
 <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 17, 2023 at 11:04:31AM +0800, Rongguang Wei wrote:
> On 4/16/23 11:18 PM, Lukas Wunner wrote:
> > On Mon, Apr 03, 2023 at 01:46:19PM +0800, Rongguang Wei wrote:
> >> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> >> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> >> @@ -232,6 +232,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >>  	 */
> >>  	mutex_lock(&ctrl->state_lock);
> >>  	switch (ctrl->state) {
> >> +	case BLINKINGON_STATE:
> >>  	case BLINKINGOFF_STATE:
> >>  		cancel_delayed_work(&ctrl->button_work);
> >>  		fallthrough;
> > 
> > This solution has the disadvantage that a gratuitous "Card not present"
> > message is emitted even if the slot is occupied.
> 
> I think when the "Card not present" is emitted, it may not consider the
> slot status from the beginning.

I don't quite follow.  With the change you're proposing, if the Attention
Button has been pressed and there's a card in the slot, after five seconds
you'll emit an erroneous "Card not present" message.  Erroneous because
there's a card in the slot.


> If the slot is in ON_STATE and is occupied, turn the slot off and then
> back on. The message is also emitted at first.

That's intentional.  If the slot is occupied and a Presence Detect Changed
event was received, it means the card in the slot may be a different one.
So the "Card not present" message relates to the card that was
*previously* in the slot.

If the slot is still (or again) occupied, we'll then try to bring it up
and that will lead to a subsequent "Card present" message.


> Maybe I can rework to add like this to prevent the gratuitous message:

Could you just test if the 1-line change I suggested in my previous e-mail
fixes the issue for you?

Thanks,

Lukas
