Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645BD6E3DF0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 05:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDQDYL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 23:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQDYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 23:24:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8352D1FC4
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=auofhjPW+d680hEgOZGAAJIFLiNkEUEOS3zOFhvHiBE=;
        b=dy1HQUNVkOz3RRjWNY7tbPAVDeEQ7YcAxwDCbldr6TL1bj8P5w+D0K7oWSCuHL
        dPnY6vIZWzmM8oj288pgej0gLf0Ea3LkDX5o9nouFPVxzVYoPFhTd0t8Q3e8xAJv
        4sxOT6Q0+THzBX+AmVEtcc0ohprSfRjEQCCaV4Zqkptgw=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wAXAwk_tzxkFJadBg--.10031S2;
        Mon, 17 Apr 2023 11:04:32 +0800 (CST)
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <20230403054619.19163-1-clementwei90@163.com>
 <20230416151826.GA13954@wunner.de>
From:   Rongguang Wei <clementwei90@163.com>
In-Reply-To: <20230416151826.GA13954@wunner.de>
Message-ID: <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
Date:   Mon, 17 Apr 2023 11:04:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wAXAwk_tzxkFJadBg--.10031S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry7tr48WFWrJw1kCr1UGFg_yoWruF1rpF
        ykJrWI9Fy8W3yUXw4aqF48Wr1Ykwna9rWDGr1DCry7u3WfCrW3CFyvk34Fgr43tFZrXFy2
        gan8KFyDAayUAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRwZxUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiXQZUa1WBpQznEgAAss
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/16/23 11:18 PM, Lukas Wunner wrote:
> On Mon, Apr 03, 2023 at 01:46:19PM +0800, Rongguang Wei wrote:
>> When a Presence Detect Changed event has occurred, the slot status
>> in either BLINKINGOFF_STATE or OFF_STATE, turn it off unconditionally.
>> But if the slot status is in BLINKINGON_STATE and the slot is currently
>> empty, the slot status was staying in BLINKINGON_STATE.
>>
>> The message print like this:
>>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>>     pcieport 0000:00:01.5: pciehp: Slot(0-5) Powering on due to button press
>>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Button cancel
>>     pcieport 0000:00:01.5: pciehp: Slot(0-5): Action canceled due to button press
>>
>> It cause the next Attention Button Pressed event become Button cancel
>> and missing the Presence Detect Changed event with this button press
>> though this button presses event is occurred after 5s.
> 
> I see what you mean.
> 
> pciehp's behavior is incorrect if the Attention Button is pressed
> on an unoccupied slot:
> 
> Upon a button press, pciehp_queue_pushbutton_work() is scheduled to run
> after 5 seconds.  It synthesizes a Presence Detect Changed event,
> whereupon pciehp_handle_presence_or_link_change() runs.
> 
> Should the slot be empty, pciehp_handle_presence_or_link_change() just
> bails out and the state incorrectly remains in BLINKINGON_STATE.
> 
> 
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -232,6 +232,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  	 */
>>  	mutex_lock(&ctrl->state_lock);
>>  	switch (ctrl->state) {
>> +	case BLINKINGON_STATE:
>>  	case BLINKINGOFF_STATE:
>>  		cancel_delayed_work(&ctrl->button_work);
>>  		fallthrough;
> 
> This solution has the disadvantage that a gratuitous "Card not present"
> message is emitted even if the slot is occupied.
> 
Thank you for your advice.

I think when the "Card not present" is emitted, it may not consider the slot status
from the beginning. If the slot is in ON_STATE and is occupied, turn the slot off and then back on. The message is also emitted at first.

> I'd prefer the following simpler solution:
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c348..e680444 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (present <= 0 && link_active <= 0) {
> +		ctrl->state = POWEROFF_STATE;
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
>> Optionally the assignment can be made conditional on
> "if (ctrl->state == BLINKINGON_STATE)" for clarity.
> 
> Likewise, a "Card not present" message can optionally be emitted here.
It should set crtl->state = OFF_STATE in direct and add cancel_delayed_work(&ctrl->button_work). And add message here looks a bit redundancy.
> 
> Thanks,
> 
> Lukas
> 
Maybe I can rework to add like this to prevent the gratuitous message:

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 86fc9342be68..8dbf767a65ac 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -239,12 +239,6 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	case ON_STATE:
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
-		if (events & PCI_EXP_SLTSTA_DLLSC)
-			ctrl_info(ctrl, "Slot(%s): Link Down\n",
-				  slot_name(ctrl));
-		if (events & PCI_EXP_SLTSTA_PDC)
-			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(ctrl));
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -257,6 +251,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
 		mutex_unlock(&ctrl->state_lock);
+		if (events & PCI_EXP_SLTSTA_DLLSC)
+			ctrl_info(ctrl, "Slot(%s): Link Down\n",
+				  slot_name(ctrl));
+		if (events & PCI_EXP_SLTSTA_PDC)
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
 		return;
 	}

Thanks,

Wei

