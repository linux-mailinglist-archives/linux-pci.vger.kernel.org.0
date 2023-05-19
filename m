Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA84708D56
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjESB2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESB2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 21:28:08 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E457B99
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
        Content-Type; bh=u5wxDegre1Yr7vlRwGnw6Fam8P0Lv783DtVp537O9pM=;
        b=IQIsF4V8tVeYXaFhHweJlXiKAOQZVSAhg40/AMC7YBSvObrFGsNdCxD2XlHosb
        nqgA/Cz8iuXYdyj892oK+a+/RxWnXBGCABrAy9YKXYuk2UZ0vwyPHjNugeTnXYNE
        aC5m0gT0B4KKKFEF4mD5RGMWd8+7Gni2oFtkCIeZWbP8s=
Received: from [172.20.125.31] (unknown [116.128.244.169])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXP0eM0GZkUo0mAA--.10596S2;
        Fri, 19 May 2023 09:27:42 +0800 (CST)
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Rongguang Wei <weirongguang@kylinos.cn>
References: <ZGYHdbvZ8JJUFPMc@bhelgaas>
In-Reply-To: <ZGYHdbvZ8JJUFPMc@bhelgaas>
From:   Rongguang Wei <clementwei90@163.com>
Message-ID: <d818f249-a107-d229-461d-e905771177c9@163.com>
Date:   Fri, 19 May 2023 09:27:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wBXP0eM0GZkUo0mAA--.10596S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW5JFWDXFW7CF17uF15Arb_yoWkKrc_u3
        4fZayqgw4vk395KFnrKr4rtF9rJrW3J3W0ga4xX34avrWrAaykurykXas8GF1UX398trZ8
        Cwn0vryYqFyavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUznQ5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiGhJ0a1aEFR+BdQAAs7
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

On 5/18/23 7:09 PM, Bjorn Helgaas wrote:
> On Thu, May 18, 2023 at 08:25:57AM +0200, Lukas Wunner wrote:
>> On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
>>> I'm curious why we want the 5 seconds of blinking power indicator at
>>> all.  We can't really do anything in response to an Attention Button
>>> on an empty slot, so could we just ignore it completely in
>>> pciehp_handle_button_press()?
>>
>> That wouldn't cover the case where the slot is occupied when the
>> button is pressed, but the card is yanked out during the 5 second
>> blinking interval.
> 
> Obviously we can't ignore a button press when the slot is occupied,
> because that's part of the "insert card, press button to power it up"
> and "press button to power down card, remove card" flows.
> 
> I'm asking about ignoring it when the slot is empty, which would mean
> adding a check for card presence in pciehp_handle_button_press().  But
> maybe there's a reason why we can't do that there?
> 
> Bjorn
> 
I think we can't add a check in pciehp_handle_button_press() because
this function is handle the ABP event and the slot is occupied or empty
is PDC event. Those two events are better not control in one function.

Thanks.

