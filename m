Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59506E7160
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDSC7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSC7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 22:59:13 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FDE944AC
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=J1SqxCAzuzg7aJHGJAYANDzwYeuKvoL5zMmHF3XKmxA=;
        b=FYG8BcnFwoqOfVF+ZQfNXfnEogU6pX4dTpU86Vw4sVq7/0vAgjbb9LA9j53P21
        YPl1FuddIvbF6bsunAFhNtBeX3GcrpAwE6jt7cI71wPoHpHTOBFF5++MacIZZXj1
        I6/zFUciUDsefscV2xQNzncSOxzh1JGeOLOmgjdeyuKX4=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBnbzPZWD9kYhpTBw--.16710S2;
        Wed, 19 Apr 2023 10:58:34 +0800 (CST)
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <20230403054619.19163-1-clementwei90@163.com>
 <20230416151826.GA13954@wunner.de>
 <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
 <20230417071125.GA4930@wunner.de>
In-Reply-To: <20230417071125.GA4930@wunner.de>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <2c288cac-cc3b-09cb-efbb-2e07f3b16fe6@163.com>
Date:   Wed, 19 Apr 2023 10:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBnbzPZWD9kYhpTBw--.16710S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1UZF4xKrW7Ww18Xry7KFg_yoW5ArWxpF
        Z8JFWIkFykXa1UXw42qF48Wr1Yk3savrWUGrn8K347Z3WfCFyfGFykKrWavrWagrWDAry2
        9an0gwn7uFyUJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1GQgUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbBzh9Wa2I0Y5NbrwAAs+
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 4/17/23 3:11 PM, Lukas Wunner wrote:
> On Mon, Apr 17, 2023 at 11:04:31AM +0800, Rongguang Wei wrote:
>> On 4/16/23 11:18 PM, Lukas Wunner wrote:
>>> On Mon, Apr 03, 2023 at 01:46:19PM +0800, Rongguang Wei wrote:
>>>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> @@ -232,6 +232,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>>>  	 */
>>>>  	mutex_lock(&ctrl->state_lock);
>>>>  	switch (ctrl->state) {
>>>> +	case BLINKINGON_STATE:
>>>>  	case BLINKINGOFF_STATE:
>>>>  		cancel_delayed_work(&ctrl->button_work);
>>>>  		fallthrough;
>>>
>>> This solution has the disadvantage that a gratuitous "Card not present"
>>> message is emitted even if the slot is occupied.
>>
>> I think when the "Card not present" is emitted, it may not consider the
>> slot status from the beginning.
> 
> I don't quite follow.  With the change you're proposing, if the Attention
> Button has been pressed and there's a card in the slot, after five seconds
> you'll emit an erroneous "Card not present" message.  Erroneous because
> there's a card in the slot.
> 
> 
>> If the slot is in ON_STATE and is occupied, turn the slot off and then
>> back on. The message is also emitted at first.
> 
> That's intentional.  If the slot is occupied and a Presence Detect Changed
> event was received, it means the card in the slot may be a different one.
> So the "Card not present" message relates to the card that was
> *previously* in the slot.
> 
> If the slot is still (or again) occupied, we'll then try to bring it up
> and that will lead to a subsequent "Card present" message.
> 
> 
>> Maybe I can rework to add like this to prevent the gratuitous message:
> 
> Could you just test if the 1-line change I suggested in my previous e-mail
> fixes the issue for you?
> 
> Thanks,
> 
> Lukas
>
I test the 1-line change and it make the test failed. The dmesg like this:

pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering off due to button press
pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
pcieport 0000:00:01.5: pciehp: Slot(0-5): Ignoring invalid state 0x4

all ABP event are print "Ignoring invalid state 0x4". 

I was add 1 line to disable slot and it works. This looks like what was done
before.

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..462a61fc7313 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,7 +256,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
+		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		return;
 	}

