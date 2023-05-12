Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D76FFE6A
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 03:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbjELBbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 21:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjELBbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 21:31:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F761FC6
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=xSyZgz7gVSkz9kkgZYRKFvv8/VlxSMo9lNmZVgrBa10=;
        b=JrXK+V93Lsto56ulmhh62K3dkTHgbykOOPNwLnCDaIcI+Y03/nzha2tK0gp4ob
        PG8PGqKsjq06vuY51f60mk7Ebn1Z/X1I6jf50cMmEIIIDTrUAkd3WxYxGrwts53t
        Q5eOSSPz9jF00Brtg2hAIO97pTX+Y39HypuPv3Q61arfM=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wBny+Cmll1kC2SPBg--.28176S2;
        Fri, 12 May 2023 09:30:15 +0800 (CST)
Subject: Re: [PATCH v3] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <20230421025641.655991-1-clementwei90@163.com>
 <20230429143057.GA18415@wunner.de>
 <1b107c50-44a0-2fac-72ee-7ef5d2212924@163.com>
 <20230511144348.GA4908@wunner.de>
In-Reply-To: <20230511144348.GA4908@wunner.de>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <99aba0d9-98aa-f6ef-6af2-2216de6d2046@163.com>
Date:   Fri, 12 May 2023 09:30:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBny+Cmll1kC2SPBg--.28176S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF17AFW7CFyruw4xZw47Jwb_yoW5GFy3pF
        Z5tFWIkF18Ja1UXws2qr48Xw1Y93ZavrZrGr10kry7ua4fCF1fCryrKryFgrsxKrW3u342
        9a1Ykr9rAa45ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbBM_UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiQgdta1aEFS5+jQABsY
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/11/23 10:43 PM, Lukas Wunner wrote:
> On Fri, May 05, 2023 at 09:38:59AM +0800, Rongguang Wei wrote:
>> On 4/29/23 10:30 PM, Lukas Wunner wrote:
>>> On Fri, Apr 21, 2023 at 10:56:41AM +0800, Rongguang Wei wrote:
>>>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> @@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>>>  	present = pciehp_card_present(ctrl);
>>>>  	link_active = pciehp_check_link_active(ctrl);
>>>>  	if (present <= 0 && link_active <= 0) {
>>>> +		ctrl->state = OFF_STATE;
>>>>  		mutex_unlock(&ctrl->state_lock);
>>>>  		return;
>>>>  	}
>>>
>>> It has occurred to me that we also need to turn off the Power Indicator,
>>> lest it continues blinking after the 5 second interval.  Sorry for not
>>> spotting this earlier.  And I'm thinking that making the state change
>>> conditional on BLINKINGON_STATE would serve clarity.
>>>
>>> So could you please amend the above as follows and verify it fixes the
>>> issue for you?
>>
>> It works fine.
>>
>>>  	if (present <= 0 && link_active <= 0) {
>>> +		if (ctrl->state == BLINKINGON_STATE) {
>>
>> I have a little question and is there necessary to add
>> "cancel_delayed_work(&ctrl->button_work);" here?
> 
> Right, that seems reasonable.  pciehp_queue_pushbutton_work() becomes
> a no-op once the state has been changed to OFF_STATE, so there's no
> real harm if the work item is left in the queue, but canceling it is
> definitely cleaner.
> 
> And a message to the user might be helpful as well to indicate that
> the button press hasn't resulted in slot bringup due to it being
> empty.  So maybe something like the below?
> 
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
> 

Yep! It looks more focused on this issue and I will send the new version patch base on this.

Thanks. 

