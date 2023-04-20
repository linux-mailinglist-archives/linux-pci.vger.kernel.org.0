Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AE6E8E8A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjDTJs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjDTJsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 05:48:40 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BFB2EC
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=DTJLoh3wDhtP87NtTZz+9UWf9VKsvnPfeLkyReJ8gwI=;
        b=M9dT6RepV4epje95pAx6ZDzdGCzKg1JDywk490RACblu5YXjXW30e4qd8sBlMq
        1JpVXkyysXZ7y80EvhbcLlFRQH+GhkRs+ytkpVxuoFmJtij1YI6kzg8Cgrw4oHHb
        LZacrQ76hyh489fNrjeFQrepYei/fJEGoRPfcIB51oFyc=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXq6XbCUFkxDnIBw--.2252S2;
        Thu, 20 Apr 2023 17:46:04 +0800 (CST)
Subject: Re: [PATCH v1] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <20230403054619.19163-1-clementwei90@163.com>
 <20230416151826.GA13954@wunner.de>
 <93177ee9-2e77-1ce3-8a57-91cfb58f6eed@163.com>
 <20230417071125.GA4930@wunner.de>
 <2c288cac-cc3b-09cb-efbb-2e07f3b16fe6@163.com>
 <20230419074832.GA28243@wunner.de>
In-Reply-To: <20230419074832.GA28243@wunner.de>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <492c25d0-9a0d-6a52-f3e0-449619ef5a54@163.com>
Date:   Thu, 20 Apr 2023 17:46:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDXq6XbCUFkxDnIBw--.2252S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45ZFyDZFyktr48Aw43KFg_yoW8GrWfp3
        yktrWS9Fy0qw4UXw47XF4UWr1YkwnxuFWUCryDKr17C3WfCrWxGFyvg3yYg39agr4UXFW2
        kws8KFnrGF1UJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRyKZZUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiXB1Xa1Xl6UKUcwABsA
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/19/23 3:48 PM, Lukas Wunner wrote:
> On Wed, Apr 19, 2023 at 10:58:33AM +0800, Rongguang Wei wrote:
>> I test the 1-line change and it make the test failed. The dmesg like this:
>>
>> pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>> pcieport 0000:00:01.5: pciehp: Slot(0-5): Powering off due to button press
>> pcieport 0000:00:01.5: pciehp: Slot(0-5): Attention button pressed
>> pcieport 0000:00:01.5: pciehp: Slot(0-5): Ignoring invalid state 0x4
> [...]
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 529c34808440..462a61fc7313 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -256,7 +256,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  	present = pciehp_card_present(ctrl);
>>  	link_active = pciehp_check_link_active(ctrl);
>>  	if (present <= 0 && link_active <= 0) {
>> +		ctrl->state = POWEROFF_STATE;
>>  		mutex_unlock(&ctrl->state_lock);
> 
> My apologies, I made a mistake.  I meant OFF_STATE, not POWEROFF_STATE.
> Could you try that, without the addition below:
> 
>> +		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>>  		return;
>>  	}
> 
> Sorry again and thanks,
> 
> Lukas
> 

It test good. I will rework the patch and send V2. 
Thank you for your help. :)

