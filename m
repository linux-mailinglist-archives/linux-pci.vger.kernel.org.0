Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4866DE3EC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDKSao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKSao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36348BD
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 11:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C18EF62AC2
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 18:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01550C433EF;
        Tue, 11 Apr 2023 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681237842;
        bh=Wultu0ABFCZVt+YGR2wI5v6FvNLxpRLLqTxSQvtyvdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sm/mQjFxwC11nrM6L/e/7FHJVHYbWHrlR1PDcfekGzUamK666VicYx07ZkStGImNy
         mtZ4cvpTG2Cq4sOwSilgAE3hfqaveR4YbpjywJvCSl/IJkfpHrPOeZWHAkI0c+lkw8
         19oMb1xGsRWq3oiuqbWocMbmuh8exgV7Hp3730y87rEgiYDGqyt2AiW2Uk+/UR6YvP
         +3Q6qS1lDHMAMmAqY1S8bLFsrPoOd+pYNV+jT87WqjUYxIAcPd9+LAeF9naYeY9oag
         ZRUKvzCNOvto5l8BhVIW7bVG5tEXsoV6EC+CvC4u5PH/IQwYi03Qd2OUlyaFzR3tcQ
         ls7POJX2ZMRYQ==
Date:   Tue, 11 Apr 2023 13:30:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
        Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230411183040.GA4166190@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403054619.19163-1-clementwei90@163.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 03, 2023 at 01:46:19PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
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
> 
> According to the Commit d331710ea78f ("PCI: pciehp: Become resilient
> to missed events"), if the slot is currently occupied, turn it on and
> if the slot is empty, it need to set in OFF_STATE rather than stay in
> current status. So the slot which status in BLINKINGON_STATE is also
> turn off unconditionally.
> 
> The message print like this after the patch:
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>     pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Already disabled
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>     pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Card not present
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Already disabled
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Card present
>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Link Up
> 
> After that, the next Attention Button Pressed event would power on
> the slot normally.

Lukas, any comment?

> Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..86fc9342be68 100644
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
> @@ -261,9 +262,6 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	}
>  
>  	switch (ctrl->state) {
> -	case BLINKINGON_STATE:
> -		cancel_delayed_work(&ctrl->button_work);
> -		fallthrough;
>  	case OFF_STATE:
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 
