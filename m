Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D86F7AB7
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEEBjk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 21:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 21:39:39 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E46112487
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=F81mPkUO7zwdgusMtBS4DUHl3xWkA7jFOfcYIW79poQ=;
        b=KfU6Oz1WV/Jsr6TZinzbNLN2n7krz07pV1dP3BWpV7OeEv2F/hISOskXbPYzIR
        62iGk4a+cRJKcCHxJPHytGjHk0giWh4zNPDLMtruwFntVBvKqP3pm38e/xDiH+f5
        2GrEAStH/qCu7HxQUorhjCabPZ2OAkAcuge8AlmAWTlds=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3sqwzXlRkSyIFBA--.5463S2;
        Fri, 05 May 2023 09:39:00 +0800 (CST)
Subject: Re: [PATCH v3] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <20230421025641.655991-1-clementwei90@163.com>
 <20230429143057.GA18415@wunner.de>
In-Reply-To: <20230429143057.GA18415@wunner.de>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <1b107c50-44a0-2fac-72ee-7ef5d2212924@163.com>
Date:   Fri, 5 May 2023 09:38:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3sqwzXlRkSyIFBA--.5463S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rGw43Ar1xAr4kCr45Wrg_yoW8Jw17pF
        95KFW0kFy8Xr4UXrsFqFW0qr4Y93ZavFZrG340k347uayrGrsxuryrKryYgrs8tFyfury2
        9w4YgryDA3W5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjAp5UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiGhdma1aEFIEMVwAAsc
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 4/29/23 10:30 PM, Lukas Wunner wrote:
> On Fri, Apr 21, 2023 at 10:56:41AM +0800, Rongguang Wei wrote:
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -256,6 +256,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  	present = pciehp_card_present(ctrl);
>>  	link_active = pciehp_check_link_active(ctrl);
>>  	if (present <= 0 && link_active <= 0) {
>> +		ctrl->state = OFF_STATE;
>>  		mutex_unlock(&ctrl->state_lock);
>>  		return;
>>  	}
> 
> It has occurred to me that we also need to turn off the Power Indicator,
> lest it continues blinking after the 5 second interval.  Sorry for not
> spotting this earlier.  And I'm thinking that making the state change
> conditional on BLINKINGON_STATE would serve clarity.
> 
> So could you please amend the above as follows and verify it fixes the
> issue for you?
> 
It works fine.
>  	if (present <= 0 && link_active <= 0) {
> +		if (ctrl->state == BLINKINGON_STATE) {
I have a little question and is there necessary to add "cancel_delayed_work(&ctrl->button_work);" here?
> +			ctrl->state = OFF_STATE;
> +			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +					      INDICATOR_NOOP);
> +		}
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
>  	}
> 
> Thanks!
> 
> Lukas
> 
Thanks!

