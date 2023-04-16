Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F86E39BD
	for <lists+linux-pci@lfdr.de>; Sun, 16 Apr 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDPPSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDPPSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 11:18:30 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C411BE7
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 08:18:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 618EE3001C94A;
        Sun, 16 Apr 2023 17:18:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 46B4215427F; Sun, 16 Apr 2023 17:18:26 +0200 (CEST)
Date:   Sun, 16 Apr 2023 17:18:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230416151826.GA13954@wunner.de>
References: <20230403054619.19163-1-clementwei90@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403054619.19163-1-clementwei90@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 03, 2023 at 01:46:19PM +0800, Rongguang Wei wrote:
> When a Presence Detect Changed event has occurred, the slot status
> in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
> But if the slot status is in BLINKINGON_STATE and the slot is currently
> empty, the slot status was staying in BLINKINGON_STATE.
> 
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

I see what you mean.

pciehp's behavior is incorrect if the Attention Button is pressed
on an unoccupied slot:

Upon a button press, pciehp_queue_pushbutton_work() is scheduled to run
after 5 seconds.  It synthesizes a Presence Detect Changed event,
whereupon pciehp_handle_presence_or_link_change() runs.

Should the slot be empty, pciehp_handle_presence_or_link_change() just
bails out and the state incorrectly remains in BLINKINGON_STATE.


> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -232,6 +232,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	 */
>  	mutex_lock(&ctrl->state_lock);
>  	switch (ctrl->state) {
> +	case BLINKINGON_STATE:
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&ctrl->button_work);
>  		fallthrough;

This solution has the disadvantage that a gratuitous "Card not present"
message is emitted even if the slot is occupied.

I'd prefer the following simpler solution:

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c348..e680444 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}

Optionally the assignment can be made conditional on
"if (ctrl->state == BLINKINGON_STATE)" for clarity.

Likewise, a "Card not present" message can optionally be emitted here.

Thanks,

Lukas
