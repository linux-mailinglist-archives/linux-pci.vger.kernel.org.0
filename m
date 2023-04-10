Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D46DC33A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 07:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDJFBQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 01:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDJFBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 01:01:14 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29553C1E
        for <linux-pci@vger.kernel.org>; Sun,  9 Apr 2023 22:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=Y0H9bXWuKAjRxKkLcdgnouZ5WCH+/GzNiePqRH059tM=;
        b=OFNIXJSIwRNSl2Borh0mc/mkS6EXqwJS9T5gWCsKpGS4edjIIRPLRhYY0q2vb1
        nEXUi8vqnURBjbJSaB0r3XSMepSXFlETIxnw55+5O7W7WYb8rIt/9FVHZOC8Oq7A
        Rgr/n0UK49co4jSvtGAe7SlxAH1fKo9/iGtPTmgG0n73w=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXX8sFmDNk9TRbBA--.22209S2;
        Mon, 10 Apr 2023 13:00:53 +0800 (CST)
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     lukas@wunner.de, bhelgaas@google.com, weirongguang@kylinos.cn
Cc:     linux-pci@vger.kernel.org
References: <20230403054619.19163-1-clementwei90@163.com>
In-Reply-To: <20230403054619.19163-1-clementwei90@163.com>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <a600ac9e-2fc7-a6b1-0539-d760af9420df@163.com>
Date:   Mon, 10 Apr 2023 13:00:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBXX8sFmDNk9TRbBA--.22209S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DCFWUJF47ArW3Xry7Jrb_yoW5ZF4fpa
        4kK3ySgFy09a1jgw43XF18Ga4Ykr9xZFW5Cr1DAr17W3WfCr4fJa4vv3yjq39rWFWDXF4a
        qa1vgF92gF4UZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UffH8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiXQlNa1WBpMCz4QAAsQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RESEND

On 4/3/23 1:46 PM, Rongguang Wei wrote:
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
> 
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
> 

